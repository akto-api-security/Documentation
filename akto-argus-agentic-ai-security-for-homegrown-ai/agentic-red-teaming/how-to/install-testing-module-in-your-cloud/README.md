# Install Scanning module in your Cloud

## Overview

Red Teaming Modules involves sending malicious agentic requests to your (staging) server. By default, these malicious scanning requests are sent from the Red Teaming module installed within Akto Cloud.

There could be multiple reasons why you'd want to install probing module within your Cloud.

1. Whitelisting Akto's IP in Security Group or WAF isn't an option
2. The staging server isn't reachable from public domain
3. The WAF would block most requests (or block Akto's IP)
4. The Agentic component domain isn't resolvable from public domain
5. The Agentic component is completely internal

## Copy the JWT Token

1. Login to Akto dashboard at [app.akto.io](https://app.akto.io)
2. Go to **Connectors** in the left nav.
3. Open the **Setup Guardrail** card and copy your token (also referred to as the database abstractor token in later steps).

## Configure the LLM in Akto

The red teaming engine needs an LLM. You choose it in the Akto dashboard, and the scanning module fetches it from Akto, so you don't pass any LLM credentials when you install the module. You can change the provider, model or key later without reinstalling; restart the module to apply the change.

1. In the Akto dashboard, go to **Settings** → **Integrations** → **Agents**.
2. Choose the provider and fill in its fields (see the table below).
3. Set **Name** to `red-teaming`. Red teaming uses only the model with this name.
4. Save the model.

**Fields per provider**

| Provider | Required | Optional | Notes |
|---|---|---|---|
| Anthropic | API Key | Model, Fast model | Without a model, the default Claude models are used. |
| AWS Bedrock | AWS Region | Bedrock API Key, Model, Fast model | Without an API key, the module uses its own AWS credentials, such as an IAM role (IRSA or Pod Identity on EKS, an instance profile on a VM). The models must be enabled for that region in the Bedrock console; they are off by default on a new AWS account. |
| Google Vertex AI | Service account JSON, GCP Project ID, Location, Endpoint ID | Dedicated endpoint domain, Model, Fast model | Paste the whole service account key file into **Service account JSON**. It is used for calls to your Vertex AI endpoint; the agent loop needs separate Google credentials (see below). |
| Azure OpenAI | API Key, Azure OpenAI Endpoint, Model | Fast model | Set **Model** to your deployment name. A `https://<resource>.openai.azure.com` endpoint gets `/openai/v1` added automatically; any other endpoint must already end in `/openai/v1`. |
| OpenAI | API Key, Model | Fast model | |
| Gemini | API Key, Model | Fast model | |
| Cloudflare | API Key (API token), Cloudflare Account ID, Model | Fast model | |
| Ollama | OLLAMA Server Endpoint, Model | API Key, Fast model | The Ollama server must be reachable from the scanning module. |
| Databricks | API Key, Databricks Model Serving Endpoint, Model | Fast model | For the endpoint, use the workspace's base URL, `https://<workspace-host>/serving-endpoints`, and set **Model** to the serving endpoint name. A full `.../invocations` URL does not work for red teaming. |

GitHub Copilot models can't be used for red teaming.

**How the models are used**

* **Model** serves the analysis role (validation, remediation, prompt optimisation). **Fast model** serves the fast role (request rewriting and field extraction); when it's empty, **Model** is used.
* The agent loop runs on the Claude Agent SDK, so it needs **Anthropic**, **AWS Bedrock** or **Google Vertex AI**, where it uses the default Claude agent model. With OpenAI, Azure OpenAI, Gemini, Cloudflare, Ollama or Databricks, **Model** and **Fast model** serve only the analysis and fast roles, and red teaming steps that use the agent loop don't work.
* On Google Vertex AI, the agent loop runs Claude on Vertex AI with the module's own Google credentials, not the service account JSON saved in Akto. Give the module credentials for that project, for example GKE Workload Identity, and enable the Claude models in the project.

**Changes and fallback**

* Add the `red-teaming` model before you install the module. The module reads it at startup.
* After you add, change or delete the model, restart the module so every part of it uses the new configuration:
  * Helm: `kubectl rollout restart deploy/akto-mini-testing`
  * Linux VM: `docker restart agent-testing`
* If Akto can't be reached, or the `red-teaming` model is missing a required field, the module keeps the configuration already in use and logs the reason with `AktoModelConfig`.

{% hint style="warning" %}
Add the `red-teaming` model before running scans. Without it, the module has no LLM to use, and the `agent-testing` logs show `LLM provider not configured from env` at startup.
{% endhint %}

You then have to use a Linux VM or a Helm chart to install Akto AI Red Teaming module in your cloud.

## Setup with Helm Chart

{% stepper %}
{% step %}
**Add the Akto Helm Repository**

Run the following commands to add and update the Akto Helm repo:

```bash
helm repo add akto https://akto-api-security.github.io/helm-charts
helm repo update
```
{% endstep %}

{% step %}
**Install the Chart**

Replace `<token>` with the **Database Abstractor Token** copied from [#copy-the-jwt-token](./#copy-the-jwt-token "mention"):

{% code overflow="wrap" %}
```bash
helm install akto-mini-testing akto/akto-mini-testing \
  --set testing.agentTesting.enabled=true \
  --set testing.aktoApiSecurityTesting.env.databaseAbstractorToken="<token>"
```
{% endcode %}

The LLM comes from the `red-teaming` model you added in [#configure-the-llm-in-akto](./#configure-the-llm-in-akto "mention").

{% hint style="info" %}
**AWS Bedrock without an API key**

On EKS, give the pod an IAM role through IRSA or Pod Identity so it can call Bedrock. The role's credentials are used when the `red-teaming` model has no Bedrock API key.
{% endhint %}
{% endstep %}

{% step %}
**Keep the token in a Kubernetes Secret (recommended)**

Passing the token inline puts it in your shell history. To read it from a Secret you create yourself instead:

```bash
kubectl create secret generic akto-db-token --from-literal=token="<token>"
```

{% code overflow="wrap" %}
```bash
helm install akto-mini-testing akto/akto-mini-testing \
  --set testing.agentTesting.enabled=true \
  --set testing.aktoApiSecurityTesting.env.useSecretsForDatabaseAbstractorToken=true \
  --set testing.aktoApiSecurityTesting.env.databaseAbstractorTokenSecrets.existingSecret=akto-db-token
```
{% endcode %}

The secret must be of type `Opaque` with its value under a key named `token`.
{% endstep %}

{% step %}
**Check that the model is in use**

```bash
kubectl logs deploy/akto-mini-testing -c agent-testing | grep AktoModelConfig
```

You should see a line like:

```
[AktoModelConfig] using Akto model "red-teaming" (ANTHROPIC claude-sonnet-4-6)
```
{% endstep %}
{% endstepper %}

### Setup Autoscaling for Scanning Module Pods

If you don't need autoscaling, skip this section.

Autoscaling enables parallel scans via multiple Kubernetes pods that scale based on workload. Every pod, including the red teaming (`agent-testing`) container, scales together. New pods get the LLM from the `red-teaming` model you added in [Configure the LLM in Akto](#configure-the-llm-in-akto), so you don't pass LLM credentials to the chart.

The steps below use Prometheus and KEDA. If you can't install those in your cluster, see [Autoscaling without Prometheus or KEDA](#autoscaling-without-prometheus-or-keda-orchestrator-mode).

#### Step 1: Verify Prometheus is Installed

Autoscaling requires Prometheus to collect and query metrics. Choose one of the following options:

**Option A: In-Cluster Prometheus (kube-prometheus-stack)**

If you have `kube-prometheus-stack` installed in your cluster, identify these details:

```bash
# Check namespace where prometheus is installed
helm list -A | grep prometheus

# Get service name and port
kubectl get svc -A | grep prometheus
```

You'll need:
- Namespace (e.g., `monitoring`)
- Service name (e.g., `prometheus-kube-prometheus-prometheus`)
- Port (e.g., `9090`)

**Option B: Grafana Cloud Prometheus**

If using Grafana Cloud, you'll need:
- Query URL (e.g., `https://prometheus-prod-XX.grafana.net/api/prom`)
- Username (numeric instance ID)
- Read API token

**Note:** For Grafana Cloud, you'll also need to deploy a metrics collector in your cluster. Contact Akto support for assistance with Grafana Cloud setup.

**Important - Metrics Collection Configuration:**

When configuring your metrics collector (e.g., Grafana Alloy) for Grafana Cloud, ensure you **do not add container labels** to scraped metrics. This is critical to prevent metric duplication.

**Technical context:**
- Pods are scraped at the pod IP level (all containers in a pod share the same network namespace)
- Only ONE container per pod serves metrics on the specified port
- Adding container labels artificially creates duplicate time series for all containers in the pod, even though metrics originate from a single container

**Example issue:** A pod with 4 containers (app, sidecar, kafka, zookeeper) would generate 4 time series per metric instead of 1, causing incorrect aggregations like `avg()`.

**Before deploying to production, verify:**
1. Only ONE container per pod exposes metrics on the annotated port (e.g., port 9400)
2. The `prometheus.io/port` annotation matches the actual metrics endpoint port
3. Your metrics queries do not filter by container label (use `pod` or `namespace` labels instead)
4. Your metrics collector configuration does NOT include rules that add container labels

Example of what to **AVOID** in your collector configuration:
```yaml
# DO NOT include this rule - it causes metric duplication
rule {
  source_labels = ["__meta_kubernetes_pod_container_name"]
  action = "replace"
  target_label = "container"
}
```

If you need per-container metrics, configure your collector to scrape at the container level with unique ports for each container.

#### Step 2: Install KEDA

KEDA monitors Prometheus metrics and automatically scales pods based on workload.

```bash
helm repo add kedacore https://kedacore.github.io/charts
helm repo update kedacore

helm install keda kedacore/keda \
  --namespace <your-namespace> \
  --create-namespace

# Restrict KEDA to watch only your namespace (optional but recommended)
helm upgrade keda kedacore/keda \
  --namespace <your-namespace> \
  --set watchNamespace=<your-namespace>
```

**Note:** If you get an error `Error: UPGRADE FAILED: no RoleBinding with the name "keda-operator" found`, simply re-run the upgrade command.

#### Step 3: Install/Upgrade Akto Mini-Testing

**Option A: With In-Cluster Prometheus**

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

Example:
```bash
helm install akto-mini-testing akto/akto-mini-testing \
  --namespace akto \
  --set testing.aktoApiSecurityTesting.env.databaseAbstractorToken="your-token" \
  --set testing.agentTesting.enabled=true \
  --set testing.autoScaling.enabled=true \
  --set testing.kubePrometheus.enabled=true \
  --set testing.kubePrometheus.namespace=monitoring \
  --set testing.kubePrometheus.serviceName=prometheus-kube-prometheus-prometheus \
  --set testing.kubePrometheus.port=9090
```

**Option B: With Grafana Cloud Prometheus**

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

Example:
```bash
helm install akto-mini-testing akto/akto-mini-testing \
  --namespace akto \
  --set testing.aktoApiSecurityTesting.env.databaseAbstractorToken="your-token" \
  --set testing.agentTesting.enabled=true \
  --set testing.autoScaling.enabled=true \
  --set testing.kubePrometheus.enabled=false \
  --set testing.grafanaCloud.enabled=true \
  --set testing.grafanaCloud.queryUrl="https://prometheus-prod-43.grafana.net/api/prom" \
  --set testing.grafanaCloud.username="2781763" \
  --set testing.grafanaCloud.readToken="your-read-token"
```

**Note:** For Grafana Cloud setup, contact Akto support for assistance with metrics collection and obtaining credentials.

#### Verify Autoscaling

```bash
# Check KEDA ScaledObject
kubectl get scaledobject -n <your-namespace>

# Check HPA created by KEDA
kubectl get hpa -n <your-namespace>

# Watch scaling in action
kubectl get hpa -n <your-namespace> -w
```

### Autoscaling without Prometheus or KEDA (orchestrator mode)

If Prometheus and KEDA can't be installed in your cluster, use orchestrator mode instead. The chart then runs `mini-testing-orchestrator`, one small Deployment in the release namespace. It needs no CRDs, no cluster-wide RBAC and no metrics stack, only a Role in that namespace.

The orchestrator checks each mini-testing pod for whether it is running a scan:
- **Scale up:** while every pod is busy, it adds a pod (`scaleUpStep` per check), up to `maxReplicas`.
- **Scale down:** pods that have been idle for `scaleDownDelay` are told to stop taking scans, then removed. A pod running a scan is never removed. While any scan is running, one idle pod is kept ready for the next one.
- **If something goes wrong:** the replica count never drops below `minReplicas`. If the orchestrator stops, the mini-testing pods keep running and scanning at their current count.

#### Install

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
- The mini-testing pods use the `local` image tag (`testing.autoScaling.orchestrator.testingImageTag`), because the orchestrator needs a recent mini-testing release.
- The orchestrator image is `public.ecr.aws/aktosecurity/akto-mini-testing-orchestrator:1.0.0`.
- The `kubePrometheus` and `grafanaCloud` values are ignored, and no ScaledObject or ServiceMonitor is created.

**Moving an existing install from KEDA:** run the upgrade above while no scans are running. The chart stops setting the replica count, so Kubernetes resets it to 1 once, and the orchestrator scales up from there. Afterwards, uninstall KEDA if nothing else uses it.

#### Settings

Optional, under `testing.autoScaling.orchestrator`:

| Value | Default | Meaning |
|---|---|---|
| `pollInterval` | `15s` | How often pods are checked |
| `scaleDownDelay` | `5m` | How long a pod must be idle before it is removed |
| `scaleUpStep` | `1` | Pods added per check while all pods are busy |
| `notReadyGrace` | `10m` | A pod not ready for longer than this is treated as broken and can be removed, so one crashlooping pod can't keep extra pods running |
| `stuckAfter` | `10m` | Scaling that stays held for longer than this (for example, a pod not answering, or every pod busy at `maxReplicas`) is reported, with a hint |
| `reportToAkto` | `true` | Send scaling events, held-scaling warnings and errors to the Akto dashboard, using the module's token |
| `heartbeat` | `false` | Show the orchestrator under **Settings → Module Info**, with its last heartbeat and current scaling state |
| `testingImageTag` | `local` | mini-testing image tag used in this mode. Set it to `""` to use `testing.aktoApiSecurityTesting.image.tag` instead. |
| `image.tag` | `1.0.0` | Orchestrator image tag |
| `controlToken.existingSecret` | `""` | Secret holding the token the mini-testing pods require from the orchestrator. If empty, the chart generates one and keeps it across upgrades. Set this when deploying with Argo CD or another tool that can't run Helm `lookup`. |

#### Check it

- **In the Akto dashboard:** go to **Settings → Logs** and choose **Mini Testing Orchestrator**. It shows each scale up and down, held scaling with a hint, errors, and a status summary every 5 minutes.
- On an older Akto release, this view and the Module Info heartbeat are not available. The events show in the module's testing logs instead, and `heartbeat` should stay `false`.
- **In the cluster:**

  ```bash
  kubectl logs deploy/akto-mini-testing-orchestrator -n <your-namespace> -f
  kubectl get deploy akto-mini-testing -n <your-namespace> -w
  ```

### Uninstalling

**IMPORTANT:** Always uninstall Helm releases BEFORE deleting the namespace. Deleting the namespace first will leave orphaned cluster-scoped resources that will cause conflicts when reinstalling.

#### Correct Uninstall Order

```bash
# 1. Uninstall mini-testing chart
helm uninstall akto-mini-testing -n <your-namespace>

# 2. Uninstall KEDA (only if not used by other applications)
helm uninstall keda -n <keda-namespace>

# 3. Delete KEDA CRDs (only if completely removing KEDA from cluster)
kubectl delete crd scaledobjects.keda.sh
kubectl delete crd scaledjobs.keda.sh
kubectl delete crd triggerauthentications.keda.sh
kubectl delete crd clustertriggerauthentications.keda.sh
kubectl delete crd cloudeventsources.eventing.keda.sh

# 4. Now safe to delete the namespace
kubectl delete namespace <your-namespace>
```

#### Troubleshooting: Recovering from Incorrect Uninstall

If you deleted the namespace before uninstalling KEDA, you'll encounter errors when trying to reinstall. Follow these steps to recover:

**1. Namespace Stuck in Terminating State**

```bash
# Remove finalizers to force delete the namespace
kubectl patch namespace <namespace-name> -p '{"metadata":{"finalizers":[]}}' --type=merge
```

**2. Clean Up Orphaned KEDA Resources**

When a namespace is deleted before uninstalling KEDA, cluster-scoped resources remain with old namespace annotations, causing installation failures.

```bash
# Delete orphaned CRDs
kubectl get crd | grep keda.sh | awk '{print $1}' | xargs kubectl delete crd

# Delete orphaned ClusterRoles
kubectl get clusterrole | grep keda | awk '{print $1}' | xargs kubectl delete clusterrole

# Delete orphaned ClusterRoleBindings
kubectl get clusterrolebinding | grep keda | awk '{print $1}' | xargs kubectl delete clusterrolebinding

# Delete orphaned RoleBinding in kube-system (used by KEDA for extension apiserver)
kubectl delete rolebinding keda-operator-auth-reader -n kube-system 2>/dev/null

# Check for and delete any other KEDA Roles in kube-system
kubectl get role -n kube-system | grep keda | awk '{print $1}' | xargs kubectl delete role 2>/dev/null

# Delete webhooks
kubectl delete mutatingwebhookconfiguration keda-admission 2>/dev/null
kubectl delete validatingwebhookconfiguration keda-admission 2>/dev/null

# Delete APIServices
kubectl get apiservice | grep keda | awk '{print $1}' | xargs kubectl delete apiservice 2>/dev/null
```

**3. Reinstall KEDA Cleanly**

```bash
# Add KEDA repo if not already added
helm repo add kedacore https://kedacore.github.io/charts
helm repo update kedacore

# Install KEDA in your namespace
helm install keda kedacore/keda --namespace <your-namespace>
```

**4. Reinstall Mini-Testing**

Follow the installation steps from [Step 3: Install/Upgrade Akto Mini-Testing](#step-3-installupgrade-akto-mini-testing) above.

## Setup Linux VM

{% stepper %}
{% step %}
**Provision a New VM**

Minimum recommended configuration:

* **Platform**: Amazon Linux 2023
* **CPU:** 2 vCPUs
* **Memory:** 4 GB RAM
* **Disk:** 20 GB

{% hint style="warning" %}
Don’t use burstable instances.
{% endhint %}

* **Network**:
  * Private subnet
  * connectivity to internet (typically via NAT)
  * connectivity to your staging service
* **Security groups**
  * Inbound - Open only port 22 for SSH
  * Outbound - Open all
{% endstep %}

{% step %}
**SSH into the VM**

1. SSH into this new instance in your Cloud
2.  Run the following command:

    ```bash
    sudo su -
    ```
{% endstep %}

{% step %}
**Install Docker & Docker Compose**

Install the [docker](https://github.com/akto-api-security/infra/blob/feature/quick-setup/get-docker.sh) and [docker-compose](https://github.com/akto-api-security/infra/blob/feature/quick-setup/get-docker-compose.sh).
{% endstep %}

{% step %}
**Create the Environment File**

1.  Create:

    ```bash
    nano docker-agentic-testing.env
    ```
2.  Add the following configuration:

    ```dotenv
    NODE_ENV=dev
    PORT=5500
    AGENTIC_MODE=false
    NODE_TLS_REJECT_UNAUTHORIZED=0
    AKTO_UTILITY_SERVER=http://akto-api-security-testing:8001
    USE_SESSION_MANAGEMENT=true
    ```

The LLM comes from the `red-teaming` model you added in [#configure-the-llm-in-akto](./#configure-the-llm-in-akto "mention"). `AKTO_UTILITY_SERVER` is how the module fetches it, so keep it as shown.

{% hint style="info" %}
**AWS Bedrock without an API key**

Attach an IAM role to the VM (instance profile) so the container can call Bedrock. On IMDSv2 the instance metadata hop limit must be at least `2`, or the container cannot reach it.
{% endhint %}

You can also reference the original template is [here](https://github.com/akto-api-security/infra/blob/feature/quick-setup/docker-agentic-testing.env).
{% endstep %}

{% step %}
**Create the Docker Compose File**

1.  Create:

    ```bash
    nano docker-compose-mini-testing-agentic.yml
    ```

{% hint style="danger" %}
**Important Requirements**

* You must replace `<your-database-abstractor-token>` with the actual **Database Abstractor Service Token (JWT)** copied from the Step 3 of [#copy-the-jwt-token](./#copy-the-jwt-token "mention").
* Ensure **both files** below are in the **same directory**:
  * `docker-compose-mini-testing-agentic.yml`
  * `docker-agentic-testing.env`
{% endhint %}

2. Add the following configuration:

```yml
version: '3.8'
services:
  agent-testing:
    container_name: agent-testing
    image: public.ecr.aws/aktosecurity/akto-agentic-testing:latest
    ports:
      - "5500:5500"
    env_file:
      - ./docker-agentic-testing.env
    restart: always

  akto-api-security-testing:
    image: public.ecr.aws/aktosecurity/akto-api-security-mini-testing:latest
    container_name: akto-api-security-testing
    environment:
      RUNTIME_MODE: hybrid
      DATABASE_ABSTRACTOR_SERVICE_TOKEN: <token>
      PUPPETEER_REPLAY_SERVICE_URL: "http://akto-puppeteer-replay:3000"
      MINI_TESTING_NAME: "akto-testing-module"
      AGENT_BASE_URL: "http://agent-testing:5500"
    ports:
      - "8001:8001"
    restart: always

  akto-api-security-puppeteer-replay:
    image: public.ecr.aws/aktosecurity/akto-puppeteer-replay:latest
    container_name: akto-puppeteer-replay
    ports:
      - "3000:3000"
    environment:
      NODE_ENV: production
    restart: always

  watchtower:
    image: containrrr/watchtower
    restart: always
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    environment:
      WATCHTOWER_CLEANUP: true
      WATCHTOWER_POLL_INTERVAL: 1800
    labels:
      com.centurylinklabs.watchtower.enable: "false"
```

For the reference,the original template is [here](https://github.com/akto-api-security/infra/blob/feature/quick-setup/docker-compose-mini-testing-agentic.yml).
{% endstep %}

{% step %}
**Start the Scanning Module**

*   Run:

    ```bash
    docker-compose -f docker-compose-mini-testing-agentic.yml up -d
    ```
*   Run the following command to ensure Docker starts up in case of instance restarts:

    ```bash
    systemctl enable /usr/lib/systemd/system/docker.service
    ```
{% endstep %}

{% step %}
**Check that the model is in use**

```bash
docker logs agent-testing 2>&1 | grep AktoModelConfig
```

You should see a line like:

```
[AktoModelConfig] using Akto model "red-teaming" (ANTHROPIC claude-sonnet-4-6)
```
{% endstep %}
{% endstepper %}

{% hint style="info" %}
**Existing installs**

Installs that already pass LLM credentials at install time keep working and need no changes. Once you add a `red-teaming` model in Akto and restart the module, that model is used instead.
{% endhint %}

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `support@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
