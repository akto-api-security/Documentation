# Install testing module as a StatefulSet

## Introduction

You can install the Akto testing module in your Kubernetes cluster using the `akto-stateful-mini-testing` Helm chart. It runs the testing module as a Kubernetes **StatefulSet**, and gives every testing pod its own storage.

Use this chart when you want each testing pod to keep a stable name and remember its own information after a restart.

## How it works

A regular Kubernetes Deployment gives pods random names, and a replacement pod starts with no history. A StatefulSet works differently:

* **Stable pod names**: pods are named `akto-external-testing-0`, `akto-external-testing-1`, and so on. A pod keeps the same name when it restarts or moves to another node.
* **One storage volume per pod**: each testing pod stores its own information in a small `.json` file in the `/app/testing-info` folder. The chart creates a separate PersistentVolumeClaim (PVC) for every pod, 100Mi by default, and pods never share a volume.
* **Restarts are safe**: when a pod restarts, it re-attaches to its own volume and picks up its file, so Akto does not treat it as a new testing module.
* **Scaling up**: each extra pod gets its own new volume.
* **Scaling down or uninstalling**: volumes are not deleted automatically, so nothing is lost by accident. See [Uninstall](install-testing-module-as-a-statefulset.md#uninstall) to remove them.

<figure><img src="../../../.gitbook/assets/statefulset-pvc.svg" alt="Each testing pod in the StatefulSet has its own volume. A restarted pod keeps its name and re-attaches to the same volume."><figcaption></figcaption></figure>

## Prerequisites

1. A Kubernetes cluster where you have permission to deploy.
2. [Helm](https://helm.sh/docs/intro/install/) installed.
3. A default storage class in your cluster that can create volumes. Most managed clusters (EKS, GKE, AKS) already have one. You can check with `kubectl get storageclass`.
4. Network access from the cluster to `https://cyborg.akto.io` and to a Kafka broker (see [Configure Kafka](install-testing-module-as-a-statefulset.md#configure-kafka)).
5. Your Database Abstractor Token:
   1. Log in to the Akto dashboard at [app.akto.io](https://app.akto.io).
   2. Go to **Quick Start** > **Hybrid Saas** and click **Connect**.
   3. Copy the JWT token. It is also called the `Database Abstractor Token`.

## Install

1. Add the Akto Helm repository.

```bash
helm repo add akto https://akto-api-security.github.io/helm-charts/
```

If you have already added it, update it instead:

```bash
helm repo update akto
```

2. Install the chart.

```bash
helm install akto-stateful-mini-testing akto/akto-stateful-mini-testing -n <your-namespace> \
  --set testing.aktoApiSecurityTesting.env.databaseAbstractorToken="<your-database-abstractor-token>"
```

3. Check that it is running.

```bash
kubectl get pods -n <your-namespace>
kubectl get pvc -n <your-namespace>
```

You should see:

* a pod named `akto-external-testing-0` in the `Running` state, and
* a PVC named `testing-info-akto-external-testing-0` in the `Bound` state.

## Configure Kafka

This chart does not include a Kafka broker. Point the testing module to a broker it can reach:

```bash
--set testing.aktoApiSecurityTesting.env.kafkaBrokerUrl="<kafka-host>:<port>"
```

## Options

Add these flags to the `helm install` command as needed.

| Goal | Flag |
| --- | --- |
| Run more than one testing pod | `--set testing.replicas=<count>` |
| Use a specific storage class | `--set testing.persistence.storageClass=<storage-class>` |
| Change the volume size (default `100Mi`) | `--set testing.persistence.size=<size>` |
| Change the pod name prefix (default `akto-external-testing`) | `--set testing.aktoApiSecurityTesting.env.miniTestingName=<name>` |
| Use a proxy | `--set tokens.env.proxyUri="<proxy-uri>" --set tokens.env.noProxy="<no-proxy-urls>"` |

For example, to run 3 pods:

```bash
helm install akto-stateful-mini-testing akto/akto-stateful-mini-testing -n <your-namespace> \
  --set testing.aktoApiSecurityTesting.env.databaseAbstractorToken="<your-database-abstractor-token>" \
  --set testing.replicas=3
```

This creates pods `akto-external-testing-0`, `-1` and `-2`, each with its own volume.

## Upgrade

```bash
helm repo update akto
helm upgrade akto-stateful-mini-testing akto/akto-stateful-mini-testing -n <your-namespace> \
  --set testing.aktoApiSecurityTesting.env.databaseAbstractorToken="<your-database-abstractor-token>"
```

Your volumes and the data in them are kept during an upgrade.

## Uninstall

1. Remove the testing module.

```bash
helm uninstall akto-stateful-mini-testing -n <your-namespace>
```

2. The volumes are kept after uninstall. If you no longer need the data, delete them too.

```bash
kubectl delete pvc -n <your-namespace> -l app=<release-name>-akto-stateful-mini-testing
```

{% hint style="warning" %}
Deleting the volumes removes the saved information of each testing pod. A pod installed again afterwards starts fresh.
{% endhint %}

## Switching from the standard testing module chart

This chart is separate from the `akto-mini-testing` chart. A Deployment cannot be converted to a StatefulSet in place, so uninstall the `akto-mini-testing` release first, then install this one. Do not run both together.

## Troubleshooting

| Problem | What to check |
| --- | --- |
| Pod stays `Pending` | Run `kubectl describe pvc -n <your-namespace>`. The cluster likely has no default storage class. Set one with `testing.persistence.storageClass`. |
| Pod cannot reach Akto | Make sure the cluster can reach `https://cyborg.akto.io`. If you use a proxy, set `tokens.env.proxyUri`. |

## Need help?

Contact us at `help@akto.io` or on [Discord](https://www.akto.io/community).
