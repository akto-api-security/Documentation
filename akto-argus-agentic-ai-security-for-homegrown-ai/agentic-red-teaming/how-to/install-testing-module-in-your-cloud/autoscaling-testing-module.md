# Autoscale the Scanning Module

## Overview

The scanning module runs one scan per pod. With autoscaling, Akto adds pods while scans are waiting and removes them when they are idle, so several red teaming scans can run in parallel without you sizing the module by hand.

Autoscaling applies to the Helm chart install (`akto/akto-mini-testing`) on Kubernetes. Every container in the pod scales together as one unit: the scanning module, the Puppeteer replay service, AI automated testing and the red teaming (`agent-testing`) container.

{% hint style="info" %}
Autoscaling is off by default. The chart runs a fixed number of pods (`testing.replicas`, default `1`) until you enable it.
{% endhint %}

## Choose an autoscaling mode

Set `testing.autoScaling.mode` to pick how the pods are scaled.

| | `keda` (default) | `orchestrator` |
|---|---|---|
| Scaled by | KEDA, reading the `is_module_busy` metric from Prometheus | `mini-testing-orchestrator`, which asks each pod whether it is running a scan |
| Needs Prometheus or Grafana Cloud | Yes | No |
| Needs KEDA and its CRDs | Yes | No |
| Cluster-wide permissions | Yes (KEDA installs CRDs and an APIService) | No. Only a Role in the release namespace |
| Extra objects created by the chart | ScaledObject, Service, ServiceMonitor or Grafana Cloud objects | A small orchestrator Deployment, ServiceAccount, Role, RoleBinding and a token Secret |
| Scale-up signal | Average `is_module_busy` above `0.9` | Every pod is busy |

Use **KEDA** if Prometheus and KEDA are already part of your cluster. Use **orchestrator mode** if you can't install them, for example in a locked-down or shared cluster.

Both modes use the same signal: scale up when every pod is busy. Neither can see how many scans are queued.

## Before you start

1. Copy your **Database Abstractor Token** as described in [Install Scanning module in your Cloud](README.md#copy-the-jwt-token).
2. Add the Akto Helm repository:

```bash
helm repo add akto https://akto-api-security.github.io/helm-charts
helm repo update
```

3. Choose a namespace. All commands below use `<your-namespace>`.
4. Add the `red-teaming` model in the Akto dashboard, as described in [Configure the LLM in Akto](README.md#configure-the-llm-in-akto). Every pod the autoscaler creates fetches it from Akto, so you don't pass LLM credentials to the chart. If you change the model later, restart the module: `kubectl rollout restart deploy/akto-mini-testing`.

## Option 1: Autoscale with KEDA and Prometheus

### Step 1: Verify Prometheus is installed

Autoscaling needs Prometheus to collect and query metrics. Use one of the following.

**In-cluster Prometheus (kube-prometheus-stack)**

```bash
# Namespace where Prometheus is installed
helm list -A | grep prometheus

# Prometheus service name and port
kubectl get svc -n <monitoring-namespace> | grep prometheus
```

Note the namespace, service name and port. You pass them to the chart in step 3.

**Grafana Cloud Prometheus**

Have your Grafana Cloud query URL, username and read token ready. Contact Akto support for help with metrics collection and credentials.

### Step 2: Install KEDA

```bash
helm repo add kedacore https://kedacore.github.io/charts
helm repo update kedacore

helm install keda kedacore/keda \
  --namespace <your-namespace> \
  --create-namespace

# Restrict KEDA to your namespace (optional but recommended)
helm upgrade keda kedacore/keda \
  --namespace <your-namespace> \
  --set watchNamespace=<your-namespace>
```

{% hint style="info" %}
If you get `Error: UPGRADE FAILED: no RoleBinding with the name "keda-operator" found`, run the upgrade command again.
{% endhint %}

### Step 3: Install the scanning module

**With in-cluster Prometheus**

```bash
helm install akto-mini-testing akto/akto-mini-testing \
  --namespace <your-namespace> \
  --set testing.aktoApiSecurityTesting.env.databaseAbstractorToken="<your-database-abstractor-token>" \
  --set testing.agentTesting.enabled=true \
  --set testing.autoScaling.enabled=true \
  --set testing.kubePrometheus.enabled=true \
  --set testing.kubePrometheus.namespace=<monitoring-namespace> \
  --set testing.kubePrometheus.serviceName=<prometheus-service-name> \
  --set testing.kubePrometheus.port=<prometheus-port>
```

**With Grafana Cloud Prometheus**

```bash
helm install akto-mini-testing akto/akto-mini-testing \
  --namespace <your-namespace> \
  --set testing.aktoApiSecurityTesting.env.databaseAbstractorToken="<your-database-abstractor-token>" \
  --set testing.agentTesting.enabled=true \
  --set testing.autoScaling.enabled=true \
  --set testing.kubePrometheus.enabled=false \
  --set testing.grafanaCloud.enabled=true \
  --set testing.grafanaCloud.queryUrl="<your-grafana-cloud-query-url>" \
  --set testing.grafanaCloud.username="<your-username>" \
  --set testing.grafanaCloud.readToken="<your-read-token>"
```

### KEDA settings

| Value | Default | Meaning |
|---|---|---|
| `testing.autoScaling.minReplicas` | `1` | Lowest pod count |
| `testing.autoScaling.maxReplicas` | `10` | Highest pod count |
| `testing.autoScaling.customMetrics.pollingInterval` | `30` | Seconds between metric checks |
| `testing.autoScaling.customMetrics.cooldownPeriod` | `300` | Seconds to wait before scaling down |
| `testing.autoScaling.customMetrics.isModuleBusy.trigger.target` | `0.9` | Average busy value that triggers scale-up |

### Verify KEDA autoscaling

```bash
kubectl get scaledobject -n <your-namespace>
kubectl get hpa -n <your-namespace>
kubectl get hpa -n <your-namespace> -w
```

## Option 2: Autoscale with the orchestrator (no Prometheus or KEDA)

In orchestrator mode the chart runs `mini-testing-orchestrator`, one small Deployment in the release namespace. It needs no CRDs, no ClusterRoles, no APIService and no metrics stack.

### How it works

Every `pollInterval` (default 15 seconds) the orchestrator checks the pods of the testing Deployment and decides whether to scale. Only one orchestrator acts at a time (Lease-based leader election).

1. It reads the Deployment and holds while a rollout is in progress, for example an image update.
2. It asks each pod for its status and sorts the pods into these states:

| State | Meaning | Effect on scale-up | Effect on scale-down |
|---|---|---|---|
| Busy | Holds a scan | Counts toward the "all busy" signal | Never removed |
| Idle | Polling for work | Blocks scale-up | Can be removed |
| Draining | Idle, told not to take new runs | Blocks scale-up | Removed first |
| Pending | Not running yet | Blocks scale-up | Removed first by Kubernetes |
| Not ready | Running but not ready, for less than `notReadyGrace` | Holds scaling | Holds scaling |
| Broken | Not ready for longer than `notReadyGrace` | Not counted as capacity | Can be removed |
| Unreachable | Ready, but its status can't be read | Blocks scale-up | Never removed; treated as possibly busy |

3. It decides:
   * **Scale up:** when every pod is busy, it adds `scaleUpStep` pods per check, up to `maxReplicas`. If some pods are draining, it puts them back to work instead of adding new ones.
   * **Scale down:** it lowers the count to `max(minReplicas, busy + unreachable + 1)`. While any test is running, one idle pod is kept ready for the next run. A pod must have been spare for the whole `scaleDownDelay` before it is removed.
   * **Hold:** in every other case it leaves the count unchanged.
4. To scale down safely, it first tells the chosen idle pods to stop taking new scans. It drops any pod that claimed a run in the meantime, marks the rest for removal, and only then lowers the replica count. A pod that is running a scan is never removed.

### Install

```bash
helm upgrade --install akto-mini-testing akto/akto-mini-testing -n <your-namespace> \
  --set testing.aktoApiSecurityTesting.env.databaseAbstractorToken="<your-database-abstractor-token>" \
  --set testing.agentTesting.enabled=true \
  --set testing.autoScaling.enabled=true \
  --set testing.autoScaling.mode=orchestrator \
  --set testing.autoScaling.minReplicas=1 \
  --set testing.autoScaling.maxReplicas=10
```

In this mode:

* The scanning pods use the `local` image tag (`testing.autoScaling.orchestrator.testingImageTag`), because the orchestrator needs a scanning module release that includes its status and drain endpoints.
* The orchestrator image is `public.ecr.aws/aktosecurity/akto-mini-testing-orchestrator`, tag `1.0.0` by default.
* The `kubePrometheus` and `grafanaCloud` values are ignored. No ScaledObject, Service, ServiceMonitor or Grafana Cloud objects are created.
* The chart no longer sets `replicas` on the testing Deployment, so a `helm upgrade` doesn't reset the count the orchestrator chose.

### What the chart creates

| Resource | Purpose |
|---|---|
| Deployment `<release>-orchestrator` | Runs the orchestrator (1 replica) |
| ServiceAccount, Role, RoleBinding | Namespace-scoped permissions, listed below |
| Secret `<release>-orchestrator` | The control token shared by the orchestrator and the scanning pods |

The scanning pods also get `ORCHESTRATOR_ENABLED=true` and `ORCHESTRATOR_TOKEN` (from the Secret). With these, each pod serves a status endpoint and drain endpoints on its metrics port (`9400`). Every request must carry the control token.

**Permissions (all in the release namespace)**

* `deployments`: `get` and `patch`, on the testing Deployment only
* `pods`: `get`, `list` and `patch` (the patch marks pods for removal)
* `leases` (`coordination.k8s.io`): `create`, and `get` and `update` on the orchestrator's own Lease

### Settings

Optional values under `testing.autoScaling.orchestrator`:

| Value | Default | Meaning |
|---|---|---|
| `pollInterval` | `15s` | How often pods are checked |
| `scaleDownDelay` | `5m` | How long a pod must be spare before it is removed |
| `scaleUpStep` | `1` | Pods added per check while all pods are busy |
| `notReadyGrace` | `10m` | A pod not ready for longer than this is treated as broken and can be removed, so one crash-looping pod can't keep extra pods running |
| `stuckAfter` | `10m` | Scaling that stays held for longer than this (for example a pod not answering, or every pod busy at `maxReplicas`) is reported with a hint |
| `reportToAkto` | `true` | Send scaling events, held-scaling warnings and errors to the Akto dashboard, using the module's token |
| `heartbeat` | `false` | Show the orchestrator under **Settings → Module Info**, with its last heartbeat and scaling state. Turn it on only when your dashboard and Akto cloud support it |
| `logLevel` | `INFO` | `DEBUG` also logs every check |
| `testingImageTag` | `local` | Scanning module image tag used in this mode. Set it to `""` to use `testing.aktoApiSecurityTesting.image.tag` instead |
| `image.repository` / `image.tag` | `public.ecr.aws/aktosecurity/akto-mini-testing-orchestrator` / `1.0.0` | Orchestrator image |
| `imagePullPolicy` | `IfNotPresent` | Orchestrator image pull policy |
| `controlToken.existingSecret` | `""` | Secret holding the token the scanning pods require from the orchestrator. If empty, the chart generates one and keeps it across upgrades |
| `controlToken.existingSecretKey` | `token` | Key inside that Secret |
| `resources` | requests `20m` CPU / `32Mi`, limits `200m` / `128Mi` | Orchestrator resources |

`minReplicas` and `maxReplicas` come from `testing.autoScaling`, as in KEDA mode.

### Control token with Argo CD or other tools

By default the chart generates the control token with Helm `lookup` so it stays the same across upgrades. Tools that render charts without cluster access, such as Argo CD, can't run `lookup`. Create the Secret yourself and point the chart to it:

```bash
kubectl create secret generic akto-orchestrator-token -n <your-namespace> \
  --from-literal=token="$(openssl rand -hex 24)"

helm upgrade --install akto-mini-testing akto/akto-mini-testing -n <your-namespace> \
  --set testing.agentTesting.enabled=true \
  --set testing.autoScaling.enabled=true \
  --set testing.autoScaling.mode=orchestrator \
  --set testing.autoScaling.orchestrator.controlToken.existingSecret=akto-orchestrator-token
```

### Keep the database abstractor token in a Secret

If you already use `testing.aktoApiSecurityTesting.env.useSecretsForDatabaseAbstractorToken=true`, the orchestrator reads the same Secret for `reportToAkto`. You don't need a second value.

### Move an existing install from KEDA

1. Run the install command above **while no tests are running**. The chart stops setting the replica count, so Kubernetes resets the Deployment to 1 pod once, and the orchestrator scales up from there.
2. Confirm the orchestrator is running (see [Check that it works](#check-that-it-works)).
3. Uninstall KEDA if nothing else in your cluster uses it. See [Uninstall](#uninstall).

To go back to KEDA, set `testing.autoScaling.mode=keda` and follow Option 1.

### Safety behavior

* **Testing is never blocked.** The replica count never goes below `minReplicas`, and every change passes through that limit. The chart starts the Deployment at 1 replica even if the orchestrator never starts.
* **If the orchestrator stops,** the scanning pods keep running and taking scans at their current count.
* **Drains expire.** A pod told to stop taking scans resumes by itself after 2 minutes unless the orchestrator renews it, so a pod is never stuck out of service if the orchestrator dies during a scale-down.
* **A busy pod is never removed.** A drain waits for any run that is being claimed, so a run that has just started is never reported as idle.
* **No runaway scale-up.** A pod whose status can't be read (for example, a token mismatch) blocks scale-up and is never removed, so a misconfiguration can't push the count to `maxReplicas`.
* **No leaked pods.** A crash-looping pod counts as broken after `notReadyGrace` and is removed.
* **Kubernetes older than 1.22.** Scale-down is turned off, with an error in the logs, because the ReplicaSet ignores the pod removal hint. Scale-up still works.

### Check that it works

**In the Akto dashboard**

Go to **Settings → Logs** and choose **Mini Testing Orchestrator**. You see:

* when the orchestrator starts
* each scale up and scale down
* pods put back to work after a drain
* held scaling (after `stuckAfter`), with a hint, and when scaling resumes
* token, drain and permission errors
* a status summary every 5 minutes

On an older Akto cloud, the same events appear in the module's testing logs.

**In the cluster**

```bash
kubectl logs deploy/akto-mini-testing-orchestrator -n <your-namespace> -f
kubectl get deploy akto-mini-testing -n <your-namespace> -w
kubectl get pods -n <your-namespace> -w
```

The orchestrator logs one JSON line per decision change, every scale or undrain, and a `status` summary every 5 minutes.

## Troubleshooting

| Symptom | Likely cause and fix |
|---|---|
| Pods never scale up | Pods are not all busy, or a pod is not ready or unreachable. Check **Settings → Logs → Mini Testing Orchestrator** for a "scaling held" event, and its hint |
| "scaling held" with an unreachable pod | The pod's status can't be read. Check that the pod and the orchestrator use the same control token, and that the orchestrator can reach port `9400` on the pod (NetworkPolicy) |
| Count stays at `maxReplicas` | Every pod is busy. Raise `maxReplicas`, or wait for runs to finish |
| Count doesn't go down | A pod is running a scan, a pod is not ready or unreachable, or `scaleDownDelay` hasn't passed. One idle pod is always kept while tests are running |
| Reconcile or permission error in the logs | The Role is missing a permission. Reinstall the chart so the Role is recreated |
| Scale-down disabled error | Kubernetes older than 1.22. Upgrade the cluster; scale-up still works |
| Orchestrator is missing in **Module Info** | Expected. `heartbeat` is `false` by default |

## Uninstall

{% hint style="danger" %}
Uninstall the Helm releases **before** deleting the namespace. If the namespace is deleted first, cluster-scoped resources are left behind and cause conflicts when you reinstall.
{% endhint %}

```bash
# 1. Uninstall the scanning module (removes the orchestrator too, if you use it)
helm uninstall akto-mini-testing -n <your-namespace>

# 2. KEDA mode only: uninstall KEDA, if nothing else uses it
helm uninstall keda -n <keda-namespace>

# 3. KEDA mode only: delete the KEDA CRDs, only if you are removing KEDA from the cluster
kubectl delete crd scaledobjects.keda.sh
kubectl delete crd scaledjobs.keda.sh
kubectl delete crd triggerauthentications.keda.sh
kubectl delete crd clustertriggerauthentications.keda.sh
kubectl delete crd cloudeventsources.eventing.keda.sh

# 4. Now it is safe to delete the namespace
kubectl delete namespace <your-namespace>
```

Orchestrator mode creates only namespaced resources, so steps 2 and 3 don't apply.

## Limitations

* The orchestrator and KEDA both scale on "every pod is busy". They can't see how many scans are waiting, so scale-up adds `scaleUpStep` pods per check.
* One pod runs one scan at a time. A long red teaming scan holds its pod until it finishes.
* Orchestrator mode uses the `local` testing image tag by default. Pin your own tag with `testingImageTag` if you need a fixed version.
* Autoscaling is for the Helm chart. The Linux VM install is not scaled by this feature.
