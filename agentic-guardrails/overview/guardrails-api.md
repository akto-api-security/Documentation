---
description: Use the Akto Guardrails HTTP API to inspect and ingest AI agent traffic directly
---

# Guardrails as API

## Overview

Akto exposes its guardrail engine as a standalone HTTP API. Any application or agent can send request/response traffic to this endpoint directly — no SDK, proxy sidecar, or framework hook required. Akto evaluates the payload against your configured guardrail policies, ingests the interaction into the Akto dashboard, and returns a verdict.

Use this connector when:

* You are building a homegrown AI agent and cannot install a framework-specific hook
* You want to evaluate guardrails inline from any language or runtime
* You are integrating from a system where installing dependencies is not practical (e.g. serverless functions, edge runtimes, shell scripts)

**What Akto does with each request:**

* Evaluates the request payload against input guardrails (prompt injection, PII, policy violations)
* Evaluates the response payload against output guardrails (sensitive data leakage, unsafe outputs)
* Ingests the full interaction into the Akto dashboard under a collection named after the target host
* Returns a guardrail verdict so callers can block or allow the request in real time

## Prerequisites

Before you start, you need:

* An **Akto API token** — generate one from your Akto dashboard under **Settings → Integrations → API Tokens**
* Your **Guardrails Service URL** — contact the Akto support team to get the URL for your account. It follows the format `https://<account_id>-guardrails.akto.io`

## API Reference

### Endpoint

```
GET https://<GUARDRAILS_SERVICE_URL>/api/http-proxy
```

### Query Parameters

All three parameters are required:

| Parameter             | Value  | Description                                                                              |
| --------------------- | ------ | ---------------------------------------------------------------------------------------- |
| `guardrails`          | `true` | Run guardrail checks on the request payload                                              |
| `response_guardrails` | `true` | Run guardrail checks on the response payload                                             |
| `ingest_data`         | `true` | Send the interaction to the Akto dashboard for monitoring and visibility                 |

### Headers

| Header          | Required | Description                                                  |
| --------------- | -------- | ------------------------------------------------------------ |
| `authorization` | Yes      | Your Akto API token                                          |
| `Content-Type`  | Yes      | `application/json`                                           |

### Request Body

The body represents one HTTP interaction (a request/response pair from your AI agent). All fields are required.

```json
{
  "path": "/v1/messages",
  "requestHeaders": "{\"host\":\"your-agent.example.com\"}",
  "responseHeaders": "{}",
  "method": "POST",
  "requestPayload": "{\"body\":\"<prompt or message sent to the LLM>\"}",
  "responsePayload": "{\"body\":\"<response received from the LLM>\"}",
  "ip": "127.0.0.1",
  "time": "1780531200000",
  "statusCode": "200",
  "type": null,
  "status": "200",
  "akto_account_id": "1000000",
  "akto_vxlan_id": "0",
  "is_pending": "false",
  "source": "MIRRORING",
  "tag": "{\"gen-ai\":\"Gen AI\",\"source\":\"AGENTIC\"}",
  "contextSource": "AGENTIC"
}
```

#### Field Reference

| Field              | Type             | Description                                                                                      |
| ------------------ | ---------------- | ------------------------------------------------------------------------------------------------ |
| `path`             | string           | The API path of the upstream call (e.g. `/v1/messages`, `/v1/chat/completions`)                  |
| `requestHeaders`   | stringified JSON | Headers sent with the request. The `host` value becomes the **collection name** in Akto          |
| `responseHeaders`  | stringified JSON | Headers received with the response. Pass `"{}"` if not available                                 |
| `method`           | string           | HTTP method of the upstream call (e.g. `POST`, `GET`)                                            |
| `requestPayload`   | stringified JSON | Body of the request sent to the LLM or agent. Use `{"body": "<content>"}` format                 |
| `responsePayload`  | stringified JSON | Body of the response received from the LLM or agent. Use `{"body": "<content>"}` format          |
| `ip`               | string           | IP address of the caller. Use `"127.0.0.1"` if not applicable                                    |
| `time`             | string           | Unix timestamp in **milliseconds** of when the interaction occurred                               |
| `statusCode`       | string           | HTTP status code of the upstream response (e.g. `"200"`, `"500"`)                                |
| `type`             | string or null   | Set to `null` unless instructed otherwise                                                         |
| `status`           | string           | Same as `statusCode`                                                                              |
| `akto_account_id`  | string           | Your Akto account ID. Use `"1000000"` unless the Akto support team specifies otherwise            |
| `akto_vxlan_id`    | string           | Set to `"0"` unless instructed otherwise                                                          |
| `is_pending`       | string           | Set to `"false"`                                                                                  |
| `source`           | string           | Traffic source label. Use `"MIRRORING"` for agentic traffic                                       |
| `tag`              | stringified JSON | Labels attached to the interaction. The `source` key inside the tag must match the product: `"AGENTIC"` for Akto Argus, `"ENDPOINT"` for Akto Atlas |
| `contextSource`    | string           | Identifies the product context: `"AGENTIC"` for Akto Argus (homegrown AI), `"ENDPOINT"` for Akto Atlas (employee endpoints) |

{% hint style="info" %}
**Collection Naming**

The `host` value inside `requestHeaders` determines which collection this interaction appears under in the Akto dashboard. Use a consistent, descriptive hostname (e.g. `"my-agent.internal"`) to group traffic from the same agent together.
{% endhint %}

## Steps to Test

{% stepper %}
{% step %}
**Get your Guardrails Service URL**

Contact the Akto support team to obtain your Guardrails Service URL. It will be in the format:

```
https://<account_id>-guardrails.akto.io
```
{% endstep %}

{% step %}
**Get your Akto API Token**

In the Akto dashboard, go to **Settings → Integrations → API Tokens** and generate a token. Copy it — you will use it as the `authorization` header value.
{% endstep %}

{% step %}
**Send your first request**

Use the sample `curl` below, replacing the placeholder values:

```bash
curl --location --request GET \
  'https://<GUARDRAILS_SERVICE_URL>/api/http-proxy?guardrails=true&ingest_data=true&response_guardrails=true' \
  --header 'authorization: <YOUR_AKTO_API_TOKEN>' \
  --header 'Content-Type: application/json' \
  --data '{
    "path": "/v1/messages",
    "requestHeaders": "{\"host\":\"my-agent.internal\"}",
    "responseHeaders": "{}",
    "method": "POST",
    "requestPayload": "{\"body\":\"What is the capital of France?\"}",
    "responsePayload": "{\"body\":\"The capital of France is Paris.\"}",
    "ip": "127.0.0.1",
    "time": "1780531200000",
    "statusCode": "200",
    "type": null,
    "status": "200",
    "akto_account_id": "1000000",
    "akto_vxlan_id": "0",
    "is_pending": "false",
    "source": "MIRRORING",
    "tag": "{\"gen-ai\":\"Gen AI\",\"source\":\"AGENTIC\"}",
    "contextSource": "AGENTIC"
  }'
```
{% endstep %}

{% step %}
**Verify in the Akto dashboard**

* Log into the Akto dashboard
* Navigate to **Collections**
* Look for a collection named after the `host` value you set in `requestHeaders` (e.g. `my-agent.internal`)
* Confirm that your interaction appears with guardrail results attached
{% endstep %}
{% endstepper %}

## How Collections are Named

Each interaction is grouped into a **collection** in the Akto dashboard. The collection name is derived from the `host` field inside the `requestHeaders` value.

For example, if `requestHeaders` is `"{\"host\":\"cursor-agent.internal\"}"`, all interactions sent with this hostname appear in a collection named **cursor-agent.internal**.

Use a stable, descriptive hostname to keep collections organized by agent or service.

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact [support@akto.io](mailto:support@akto.io) for email support.
4. Contact us [here](https://www.akto.io/contact-us).
