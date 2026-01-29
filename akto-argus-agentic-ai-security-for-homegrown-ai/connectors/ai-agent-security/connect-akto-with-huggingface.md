# Hugging Face Private Inference Endpoint

## Overview

This guide explains how to integrate **Akto AI Agent Proxy** with a **Hugging Face Private Inference Endpoint** used by customers to run private LLM inference. The proxy sits between the end user and the agent application (Option B) to monitor, enforce guardrails, and log model invocation traffic without modifying internal client code.

Akto AI Agent Proxy provides:

- Guardrail enforcement on both requests and responses
- Sensitive data redaction
- Security threat detection

Hugging Face’s Private Inference Endpoint provides a dedicated, managed model endpoint accessible only via AWS PrivateLink from within a VPC. Hugging Face does **not automatically log full prompt & response conversations** like AWS Bedrock, so Akto must capture this upstream.

---

## **Prerequisites**

Before integrating Akto Proxy:

1. A working **Hugging Face Private Inference Endpoint** configured with PrivateLink.
2. AWS VPC where the endpoint service is reachable.
3. The AI agent and Akto Proxy deployed in the same VPC or with network access to the PrivateLink interfaces.
4. Access credentials for Hugging Face inference (API token).

---

## **Architecture Diagram**



```mermaid
flowchart LR
    A[EndUser] --> B[Akto AI Agent Proxy] --> C[AI Agent App] --> D[HF Private Inference Endpoint]
    A --> E[Logs, Guardrails, Analytics] <-- D


```

1. End user calls the **AI agent API**.
2. **Akto Proxy** intercepts requests (guardrail enforcement).
3. Proxy forwards to **HF Private Inference Endpoint** (via PrivateLink).
4. Responses pass back through Akto Proxy.
5. Akto logs, analyzes and optionally redacts or blocks results.

---

## **Setup Steps**

### **1. Configure Hugging Face Private Inference Endpoint**

Ensure the endpoint is set up with:

- Model deployed
- **PrivateLink enabled**
- Correct AWS account and region
- VPC interface endpoint created in your VPC

Hugging Face does not log full request/response content by itself. You must capture it upstream.

---

### **2. Deploy Akto AI Agent Proxy**

Deploy the proxy in the same VPC where:

- End user traffic enters
- The AI agent application runs
- The PrivateLink interface to HF endpoint exists

---

### **3. Configure Proxy Environment**

Here is an example config for the proxy:

```bash
export AKTO_API_TOKEN=<YOUR_AKTO_PROXY_TOKEN>
export AKTO_API_BASE_URL=<AKTO_API_BASE_URL>
export APP_URL=<HUGGING_FACE_PRIVATELINK_ENDPOINT_URL>
export LOG_LEVEL=INFO

```

- `AKTO_API_TOKEN`: Akto ingestion token (from Akto dashboard)
- `AKTO_API_BASE_URL`: Akto proxy ingestion server
- `APP_URL`: Upstream target (the HF Private Inference Endpoint URL)
- `LOG_LEVEL`: Logging verbosity

---

### **4. Adjust Endpoint URL in Agent App**

Update the AI agent’s inference call configuration:

- Set model base URL to the **Akto Proxy endpoint**
- Pass Hugging Face authentication headers through proxy

For example:

```
AI_AGENT_INFERENCE_URL=https://akto-proxy.internal.svc
HF_AUTHORIZATION=Bearer <HF_TOKEN>

```

This ensures:

- Traffic flows through Akto Proxy
- Akto captures all inference calls

---

### **5. Validate Integration**

Verify end-to-end flow:

1. Send an inference request from the user
2. Akto Proxy receives and logs the call
3. Proxy enforces any guardrails
4. Proxy forwards to HF Private Endpoint
5. Response returns through Akto Proxy
6. Logs appear in Akto dashboard

Look for:

- Request/response pairs in proxy logs
- Guardrail hits (if configured)
- Redaction results

---

## **Security & Guardrails**

Akto Proxy supports:

- Request guardrails (input sanitization)
- Response guardrails (filtering outputs)
- Redaction of sensitive tokens or PII
- Rate limiting and anomaly detection

Use our policy packs or define custom rules based on:

- Content patterns
- Risk categories
- Endpoint sensitivity

---

## **Logging & Monitoring**

Hugging Face Private Endpoints offer:

- Operational logs (status, errors)
- Metrics (latency, throughput)

They do **not log conversation content** by default.

Akto Proxy will log:

- Full request and response traces
- Guardrail decision events
- Alerts and incidents
- Metadata for analytics

---

## **Troubleshooting**

- **Proxy cannot reach HF Endpoint**: Check PrivateLink and VPC routing.
- **Auth failures**: Verify Hugging Face API token headers are passed by proxy.
- **No logs in Akto**: Confirm AKTO_API_TOKEN and ingestion config.
- **Guardrail not triggering**: Validate rule pack configuration.

---
## **Summary**

By integrating Akto AI Agent Proxy in front of a Hugging Face Private Inference Endpoint:

- You achieve guardrail enforcement without modifying the client code
- You capture and monitor model invocation traffic
- You gain observability of conversation logging

Akto Proxy becomes the enforcement and observability layer for private HF model usage.