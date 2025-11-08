# Install testing module in your Cloud

## Introduction

API Security testing involves sending malicious API requests to your (staging) server. By default, these malicious testing requests are sent from the Testing module installed within Akto Cloud.

There could be multiple reasons why you'd want to install testing module within your Cloud.

1. Whitelisting Akto's IP in Security Group or WAF isn't an option
2. The staging server isn't reachable from public domain
3. The WAF would block most requests (or block Akto's IP)
4. The API domain isn't resolvable from public domain
5. The API is completely internal

## Testing from Customer Cloud

1. Login to Akto dashboard at [app.akto.io](https://app.akto.io)
2. Go to Quick Start > Hybrid Saas > Click on “Connect” button
3. Copy the JWT token (marked in red) \[ Also referred as `Database Abstractor Token` later]

You can now use a Helm-chart to install Akto Security Testing module in your cloud or install manually

### Terraform

1. To install using Terraform, use the Terraform script [here](https://github.com/akto-api-security/infra/blob/feature/quick-setup/templates/mini-testing.tf).
   1. Please make sure you install it in a private subnet from your application VPC.
   2. This private subnet should also have network connectivity (typically via NAT).
2. For `Database Abstractor Service Token` input in the terraform script specify the JWT token copied in the earlier step.
3. Once the terraform script has finished running, you should be able to see a new autoscaling group created with 1 Akto Testing EC2 instance running.

### Helm-chart

#### Akto's helm chart installation

1. Add akto helm repository.

```bash
helm repo add akto https://akto-api-security.github.io/helm-charts/
```

**Note: If you've already added akto helm repository, update the helm repository using:**

```bash
helm repo update akto
```

2. Using the dashboard abstractor token saved in the above steps, deploy the helm chart below.

```bash
helm install akto-mini-testing akto/akto-mini-testing -n <your-namespace> --set testing.aktoApiSecurityTesting.env.databaseAbstractorToken="<your-database-abstractor-token>"
```

**Note: If you want to modify the helm chart according to your needs, you can clone the same from** [**mini-testing-helm-chart**](https://github.com/akto-api-security/helm-charts/tree/master/charts/mini-testing)

#### Setup Autoscaling for Testing Module Pods

If you don't need autoscaling, skip this section.

Autoscaling enables parallel test runs via multiple Kubernetes pods that scale based on workload.

##### Step 1: Verify Prometheus is Installed

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

##### Step 2: Install KEDA

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

##### Step 3: Install/Upgrade Akto Mini-Testing

**Option A: With In-Cluster Prometheus**

```bash
helm install akto-mini-testing akto/akto-mini-testing \
  --namespace <your-namespace> \
  --set testing.aktoApiSecurityTesting.env.databaseAbstractorToken="<AKTO_TOKEN>" \
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
  --set testing.aktoApiSecurityTesting.env.databaseAbstractorToken="<AKTO_TOKEN>" \
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
  --set testing.autoScaling.enabled=true \
  --set testing.kubePrometheus.enabled=false \
  --set testing.grafanaCloud.enabled=true \
  --set testing.grafanaCloud.queryUrl="https://prometheus-prod-43.grafana.net/api/prom" \
  --set testing.grafanaCloud.username="2781763" \
  --set testing.grafanaCloud.readToken="your-read-token"
```

**Note:** For Grafana Cloud setup, contact Akto support for assistance with metrics collection and obtaining credentials.

##### Verify Autoscaling

```bash
# Check KEDA ScaledObject
kubectl get scaledobject -n <your-namespace>

# Check HPA created by KEDA
kubectl get hpa -n <your-namespace>

# Watch scaling in action
kubectl get hpa -n <your-namespace> -w
```

#### Uninstalling

**IMPORTANT:** Always uninstall Helm releases BEFORE deleting the namespace. Deleting the namespace first will leave orphaned cluster-scoped resources that will cause conflicts when reinstalling.

##### Correct Uninstall Order

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

##### Troubleshooting: Recovering from Incorrect Uninstall

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

### Linux VM

1. Create a new instance with the following requirements
   1. Platform
      1. Linux
   2. Spec
      1. 2 vCPU
      2. 4GB RAM
      3. 20GB Hard disk
      4. Don’t use burstable instances
   3. Network
      1. Private subnet
      2. connectivity to internet (typically via NAT)
      3. connectivity to your staging service
   4. Security groups
      1. Inbound - No ports required
      2. Outbound - Open all
2. SSH into this new instance in your Cloud
3. Run `sudo su -`
4. Install [docker](https://github.com/akto-api-security/infra/blob/feature/quick-setup/get-docker.sh) and [docker-compose](https://github.com/akto-api-security/infra/blob/feature/quick-setup/get-docker-compose.sh).
5.  Paste the following in `docker-compose-testing.yml` file. Use token from step(3) for DATABASE\_ABSTRACTOR\_SERVICE\_TOKEN value. Don't use double-quotes

    ```
    version: '3.8'
    services:
      akto-api-security-testing:
        image: public.ecr.aws/aktosecurity/akto-api-security-mini-testing:latest
        environment:
          RUNTIME_MODE: hybrid
          DATABASE_ABSTRACTOR_SERVICE_TOKEN: <Paste_token_here>
          PUPPETEER_REPLAY_SERVICE_URL: http://akto-puppeteer-replay:3000
        restart: always

      akto-api-security-puppeteer-replay:
        image: public.ecr.aws/aktosecurity/akto-puppeteer-replay:latest
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
6. Run `docker-compose -f docker-compose-testing.yml up -d` .&#x20;
7. Run `systemctl enable /usr/lib/systemd/system/docker.service` to ensure Docker starts up in case of instance restarts

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
