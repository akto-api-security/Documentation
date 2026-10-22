# Autoscale the Testing Module

## Overview

Autoscaling runs more testing module pods when tests are waiting, and fewer when pods are idle. Each pod runs one test at a time, so more pods means more tests in parallel.

Autoscaling works with the Helm chart install on Kubernetes. All containers in a pod scale together (the testing module, Puppeteer replay, AI automated testing, and the red teaming container if you turned it on).

Autoscaling is off by default. The chart runs 1 pod (`testing.replicas`).

## Pick a mode

Set `testing.autoScaling.mode`:

| | `keda` (default) | `orchestrator` |
|---|---|---|
| What scales the pods | KEDA, using a Prometheus metric | A small Akto service called `mini-testing-orchestrator` |
| Needs Prometheus or Grafana Cloud | Yes | No |
| Needs KEDA | Yes | No |
| Cluster-wide permissions | Yes | No. Only a Role in your namespace |
| Scales up when | Every pod is busy | Every pod is busy |

Use `keda` if you already run Prometheus and KEDA. Use `orchestrator` if you can't install them.

Neither mode can see how many tests are waiting.

## Before you start

1. Copy your **Database Abstractor Token**. See [Copy the JWT Token](README.md#copy-the-jwt-token).
2. Add the Akto Helm repo:

```bash
helm repo add akto https://akto-api-security.github.io/helm-charts
helm repo update
```

## Option 1: KEDA and Prometheus

### Step 1: Check Prometheus

You need Prometheus to read metrics. Use one of these:

* **Prometheus in your cluster (kube-prometheus-stack):** note its namespace, service name and port.

  ```bash
  helm list -A | grep prometheus
  kubectl get svc -n <monitoring-namespace> | grep prometheus
  ```

* **Grafana Cloud:** keep your query URL, username and read token ready. Contact Akto support if you need help with credentials.

### Step 2: Install KEDA

```bash
helm repo add kedacore https://kedacore.github.io/charts
helm repo update kedacore

helm install keda kedacore/keda \
  --namespace <your-namespace> \
  --create-namespace

# Optional: make KEDA watch only your namespace
helm upgrade keda kedacore/keda \
  --namespace <your-namespace> \
  --set watchNamespace=<your-namespace>
```

If you see `UPGRADE FAILED: no RoleBinding with the name "keda-operator" found`, run the upgrade again.

### Step 3: Install the testing module

With Prometheus in your cluster:

```bash
helm install akto-mini-testing akto/akto-mini-testing \
  --namespace <your-namespace> \
  --set testing.aktoApiSecurityTesting.env.databaseAbstractorToken="<your-database-abstractor-token>" \
  --set testing.autoScaling.enabled=true \
  --set testing.kubePrometheus.enabled=true \
  --set testing.kubePrometheus.namespace=<monitoring-namespace> \
  --set testing.kubePrometheus.serviceName=<prometheus-service-name> \
  --set testing.kubePrometheus.port=<prometheus-port>
```

With Grafana Cloud:

```bash
helm install akto-mini-testing akto/akto-mini-testing \
  --namespace <your-namespace> \
  --set testing.aktoApiSecurityTesting.env.databaseAbstractorToken="<your-database-abstractor-token>" \
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
| `testing.autoScaling.minReplicas` | `1` | Fewest pods |
| `testing.autoScaling.maxReplicas` | `10` | Most pods |
| `testing.autoScaling.customMetrics.pollingInterval` | `30` | Seconds between checks |
| `testing.autoScaling.customMetrics.cooldownPeriod` | `300` | Seconds to wait before scaling down |
| `testing.autoScaling.customMetrics.isModuleBusy.trigger.target` | `0.9` | Busy level that adds pods |

### Check it

```bash
kubectl get scaledobject -n <your-namespace>
kubectl get hpa -n <your-namespace> -w
```

## Option 2: Orchestrator (no Prometheus or KEDA)

The chart runs one small extra Deployment, `mini-testing-orchestrator`, in your namespace. It needs no CRDs and no cluster-wide permissions.

### How it works

Every 15 seconds the orchestrator asks each testing pod if it is running a test.

* **Scale up:** when every pod is busy, it adds pods (1 at a time by default), up to `maxReplicas`.
* **Scale down:** a pod that has been idle for 5 minutes is told to stop taking new tests, then removed. While any test is running, 1 idle pod is kept ready for the next test.
* **Pods running a test are never removed.**
* **The pod count never goes below `minReplicas`.**
* **If the orchestrator stops,** the testing pods keep running at their current count.

### Install

```bash
helm upgrade --install akto-mini-testing akto/akto-mini-testing -n <your-namespace> \
  --set testing.aktoApiSecurityTesting.env.databaseAbstractorToken="<your-database-abstractor-token>" \
  --set testing.autoScaling.enabled=true \
  --set testing.autoScaling.mode=orchestrator \
  --set testing.autoScaling.minReplicas=1 \
  --set testing.autoScaling.maxReplicas=10
```

In this mode:

* Testing pods use the `local` image tag (`testing.autoScaling.orchestrator.testingImageTag`). The orchestrator needs a testing module build that has its endpoints.
* The orchestrator image is `public.ecr.aws/aktosecurity/akto-mini-testing-orchestrator`, tag `1.0.0`.
* `kubePrometheus` and `grafanaCloud` values are ignored. No ScaledObject, Service or ServiceMonitor is created.
* The chart does not set `replicas` on the testing Deployment, so `helm upgrade` doesn't reset the count.

The chart also creates a ServiceAccount, a Role, a RoleBinding and a Secret with a token. The orchestrator and the testing pods share this token.

The Role works only in your namespace. It allows:

* `get` and `patch` on the testing Deployment
* `get`, `list` and `patch` on pods
* `create` on leases, and `get` and `update` on the orchestrator's own lease

### Settings

All values are under `testing.autoScaling.orchestrator`:

| Value | Default | Meaning |
|---|---|---|
| `pollInterval` | `15s` | How often pods are checked |
| `scaleDownDelay` | `5m` | How long a pod must be idle before it is removed |
| `scaleUpStep` | `1` | Pods added per check while all pods are busy |
| `notReadyGrace` | `10m` | A pod not ready for longer than this is treated as broken and can be removed |
| `stuckAfter` | `10m` | If scaling is held for longer than this, it is reported with a hint |
| `reportToAkto` | `true` | Send scaling events and errors to the Akto dashboard |
| `heartbeat` | `false` | Show the orchestrator in **Settings → Module Info** |
| `logLevel` | `INFO` | Set `DEBUG` to log every check |
| `testingImageTag` | `local` | Testing image tag in this mode. Set `""` to use `testing.aktoApiSecurityTesting.image.tag` |
| `image.tag` | `1.0.0` | Orchestrator image tag |
| `controlToken.existingSecret` | `""` | Your own Secret for the shared token. If empty, the chart creates one and keeps it across upgrades |
| `controlToken.existingSecretKey` | `token` | Key in that Secret |
| `resources` | 20m CPU, 32Mi memory (limits 200m, 128Mi) | Orchestrator resources |

`minReplicas` and `maxReplicas` are set under `testing.autoScaling`.

### Use your own token Secret (Argo CD)

The chart makes the shared token with Helm `lookup`. Argo CD and similar tools can't run `lookup`. Create the Secret yourself:

```bash
kubectl create secret generic akto-orchestrator-token -n <your-namespace> \
  --from-literal=token="$(openssl rand -hex 24)"
```

Then add this to the install command:

```bash
--set testing.autoScaling.orchestrator.controlToken.existingSecret=akto-orchestrator-token
```

### Move from KEDA

1. Run the install command above when **no tests are running**. The chart stops setting the pod count, so Kubernetes sets it to 1 once. The orchestrator then scales up.
2. Check that the orchestrator works (see below).
3. Uninstall KEDA if nothing else uses it.

### Check it

In the Akto dashboard, go to **Settings → Logs** and pick **Mini Testing Orchestrator**. You see each scale up and down, errors, and a status summary every 5 minutes.

{% hint style="info" %}
This log view and the Module Info heartbeat need an Akto dashboard and cloud release that support the orchestrator. On an older release, the events show in the module's testing logs instead, and `heartbeat` should stay `false`.
{% endhint %}

In the cluster:

```bash
kubectl logs deploy/akto-mini-testing-orchestrator -n <your-namespace> -f
kubectl get deploy akto-mini-testing -n <your-namespace> -w
```

### If something goes wrong

* **A pod can't be reached** (for example, the token doesn't match): the orchestrator does not add pods and does not remove that pod. After `stuckAfter`, it reports the problem in **Settings → Logs**.
* **A pod keeps crashing:** after `notReadyGrace` it is treated as broken and removed.
* **Kubernetes older than 1.22:** scale down is turned off. Scale up still works.
* **Stopped pod drain:** a pod told to stop taking tests starts again after 2 minutes if the orchestrator doesn't renew it.

## Uninstall

Uninstall the Helm releases **before** you delete the namespace. If you delete the namespace first, cluster-wide resources are left behind and cause errors when you install again.

```bash
# 1. Uninstall the testing module (this also removes the orchestrator)
helm uninstall akto-mini-testing -n <your-namespace>

# 2. KEDA only: uninstall KEDA if nothing else uses it
helm uninstall keda -n <keda-namespace>

# 3. KEDA only: delete the KEDA CRDs if you are removing KEDA from the cluster
kubectl delete crd scaledobjects.keda.sh
kubectl delete crd scaledjobs.keda.sh
kubectl delete crd triggerauthentications.keda.sh
kubectl delete crd clustertriggerauthentications.keda.sh
kubectl delete crd cloudeventsources.eventing.keda.sh

# 4. Delete the namespace
kubectl delete namespace <your-namespace>
```

Orchestrator mode creates only resources inside your namespace, so steps 2 and 3 don't apply.

## Limits

* Both modes scale up only when every pod is busy. They don't see the queue of waiting tests.
* One pod runs one test at a time. A long test keeps its pod until it ends.
* Autoscaling is for the Helm chart. It does not apply to the Linux VM install.
