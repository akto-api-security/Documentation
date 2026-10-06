---
description: Deploy Akto Agent Guard in your EKS cluster with Helm, using Amazon Bedrock models and IAM role credentials
---

# Deploy Agent Guard on AWS Bedrock

## Overview

This guide shows how to deploy Agent Guard in your Amazon EKS cluster with the `akto-regional-setup` Helm chart and run its models on **Amazon Bedrock**.

Agent Guard uses no API keys to reach Bedrock. Its credentials come from an IAM role bound to the `agent-guard` Kubernetes service account. This guide uses EKS Pod Identity.

The values file in this guide turns off these components: threat client, anonymizer, embedder, guardrails Redis, guardrails service Kafka, and guardrails threat buffer.

## Models

The example configuration uses two Bedrock models, one for each model role:

| Model role | Model | Timeout |
| --- | --- | --- |
| `FAST_THREAT_FILTER` | `google.gemma-4-e2b` | 5000 ms |
| `FINAL_ARBITER` | `google.gemma-4-26b-a4b` | 30000 ms |

`FAST_THREAT_FILTER` uses a `safeDecisionThreshold` of 0.9.

## Prerequisites

* An Amazon EKS cluster with `kubectl` access, and the AWS CLI.
* [Helm](https://helm.sh/docs/intro/install/).
* Model access enabled in the Amazon Bedrock console for every model you route to. Access is per region and per model, and it is off by default.

## Steps

{% stepper %}
{% step %}
### Install the Pod Identity add-on

```bash
aws eks create-addon --cluster-name <cluster> --addon-name eks-pod-identity-agent
```
{% endstep %}

{% step %}
### Create the IAM role

Use this trust policy. The principal must be `pods.eks.amazonaws.com`.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": { "Service": "pods.eks.amazonaws.com" },
      "Action": ["sts:AssumeRole", "sts:TagSession"]
    }
  ]
}
```

For permissions, allow `bedrock:InvokeModel` and `bedrock:InvokeModelWithResponseStream` on the models you route to.
{% endstep %}

{% step %}
### Associate the role with the service account

```bash
aws eks create-pod-identity-association \
  --cluster-name <cluster> \
  --namespace akto-regional \
  --service-account agent-guard \
  --role-arn arn:aws:iam::<acct>:role/<role>
```

Pod Identity binds the role outside Kubernetes, so the service account needs no annotations. It only has to exist with the name used in this command.
{% endstep %}

{% step %}
### Create the values file

Save this as `agent-guard-bedrock.yaml`:

{% code title="agent-guard-bedrock.yaml" %}
```yaml
  serviceAccount:
    create: true
    name: agent-guard
  env:
    bedrockRegion: us-east-1
    defaultModelConfigJson: |
      {"modelConfigs":[
        {"provider":"bedrock","model":"google.gemma-4-e2b","modelRole":"FAST_THREAT_FILTER","safeDecisionThreshold":0.9,"timeoutMs":5000},
        {"provider":"bedrock","model":"google.gemma-4-26b-a4b","modelRole":"FINAL_ARBITER","timeoutMs":30000}],
       "parallelExecution":true,"storeAllResults":false}
```
{% endcode %}

{% hint style="warning" %}
Set `defaultModelConfigJson`. If it is blank, Agent Guard falls back to a built-in Vertex config, and scans fail without any message about Bedrock.
{% endhint %}

{% hint style="info" %}
The `us.`, `eu.` and `apac.` model IDs are cross-region inference profiles. They must match `bedrockRegion`.
{% endhint %}
{% endstep %}

{% step %}
### Install the chart

Run Helm with the `akto-regional-setup` chart, in the `akto-regional` namespace, and pass the values file:

```bash
helm upgrade --install akto-regional-setup <chart-reference> \
  -n akto-regional -f agent-guard-bedrock.yaml
```

Replace `<chart-reference>` with the chart as it is available in your setup, for example a local chart path or a chart from your Helm repository.
{% endstep %}

{% step %}
### Verify

```bash
POD=$(kubectl get pod -n akto-regional \
  -l app.kubernetes.io/component=agent-guard -o jsonpath='{.items[0].metadata.name}')

kubectl exec -n akto-regional $POD -- \
  sh -c 'echo "uri=$AWS_CONTAINER_CREDENTIALS_FULL_URI region=$BEDROCK_REGION"'
```

`uri` must be set. It is the node-local agent at `169.254.170.23`. If it is empty, the association did not reach the pod. Check that the pod is on the right service account, then restart the pod. The binding is applied at admission.

```bash
kubectl get pod -n akto-regional $POD -o jsonpath='{.spec.serviceAccountName}{"\n"}'
```
{% endstep %}
{% endstepper %}

## Troubleshooting

| Symptom | Cause |
| --- | --- |
| Scans fail, nothing mentions Bedrock | `defaultModelConfigJson` is blank. Agent Guard falls back to a built-in Vertex config. |
| Credentials not found | No association, wrong namespace or service account name, or the add-on is missing. |
| `AccessDeniedException` | Model access is not enabled in the Bedrock console. It is per region and per model, and off by default. |
| `ValidationException` on an inference profile | The model ID prefix does not match `bedrockRegion`. |
| Hangs, then times out | A network policy blocks the Pod Identity agent. Allow `169.254.170.23/32` port 80 under `networkPolicy.components.agentGuard.egressAllowlist`. |

## Get Support

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
