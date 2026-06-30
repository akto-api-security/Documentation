---
description: >-
  Use the Akto Guardrails HTTP API to inspect and ingest AI agent traffic
  directly
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

* An **Akto API token** — follow the [Getting API Token](../../akto-argus-agentic-ai-security-for-homegrown-ai/connectors/others/hybrid-saas.md#getting-api-token) steps in the Hybrid SaaS guide
* Your **Guardrails Service URL** — contact the Akto support team to get the URL for your account. It follows the format `https://<account_id>-guardrails.akto.io`

## API Reference

### Endpoint

```
GET https://<GUARDRAILS_SERVICE_URL>/api/http-proxy
```

### Query Parameters

All three parameters are required:

<table><thead><tr><th width="225.015625">Parameter</th><th width="114.375">Value</th><th>Description</th></tr></thead><tbody><tr><td><code>guardrails</code></td><td><code>true</code></td><td>Run guardrail checks on the request payload</td></tr><tr><td><code>response_guardrails</code></td><td><code>true</code></td><td>Run guardrail checks on the response payload</td></tr><tr><td><code>ingest_data</code></td><td><code>true</code></td><td>Send the interaction to the Akto dashboard for monitoring and visibility</td></tr></tbody></table>

### Headers

<table><thead><tr><th width="218.23046875">Header</th><th width="187.65234375">Required</th><th>Description</th></tr></thead><tbody><tr><td><code>authorization</code></td><td>Yes</td><td>Your Akto API token</td></tr><tr><td><code>Content-Type</code></td><td>Yes</td><td><code>application/json</code></td></tr></tbody></table>

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

<table><thead><tr><th width="200.21875">Field</th><th width="198.09765625">Type</th><th>Description</th></tr></thead><tbody><tr><td><code>path</code></td><td>string</td><td>The API path of the upstream call (e.g. <code>/v1/messages</code>, <code>/v1/chat/completions</code>)</td></tr><tr><td><code>requestHeaders</code></td><td>stringified JSON</td><td>Headers sent with the request. The <code>host</code> value becomes the <strong>collection name</strong> in Akto</td></tr><tr><td><code>responseHeaders</code></td><td>stringified JSON</td><td>Headers received with the response. Pass <code>"{}"</code> if not available</td></tr><tr><td><code>method</code></td><td>string</td><td>HTTP method of the upstream call (e.g. <code>POST</code>, <code>GET</code>)</td></tr><tr><td><code>requestPayload</code></td><td>stringified JSON</td><td>Body of the request sent to the LLM or agent. Use <code>{"body": "&#x3C;content>"}</code> format</td></tr><tr><td><code>responsePayload</code></td><td>stringified JSON</td><td>Body of the response received from the LLM or agent. Use <code>{"body": "&#x3C;content>"}</code> format</td></tr><tr><td><code>ip</code></td><td>string</td><td>IP address of the caller. Use <code>"127.0.0.1"</code> if not applicable</td></tr><tr><td><code>time</code></td><td>string</td><td>Unix timestamp in <strong>milliseconds</strong> of when the interaction occurred</td></tr><tr><td><code>statusCode</code></td><td>string</td><td>HTTP status code of the upstream response (e.g. <code>"200"</code>, <code>"500"</code>)</td></tr><tr><td><code>type</code></td><td>string or null</td><td>Set to <code>null</code> unless instructed otherwise</td></tr><tr><td><code>status</code></td><td>string</td><td>Same as <code>statusCode</code></td></tr><tr><td><code>akto_account_id</code></td><td>string</td><td>Your Akto account ID. Use <code>"1000000"</code> unless the Akto support team specifies otherwise</td></tr><tr><td><code>akto_vxlan_id</code></td><td>string</td><td>Set to <code>"0"</code> unless instructed otherwise</td></tr><tr><td><code>is_pending</code></td><td>string</td><td>Set to <code>"false"</code></td></tr><tr><td><code>source</code></td><td>string</td><td>Traffic source label. Use <code>"MIRRORING"</code> for agentic traffic</td></tr><tr><td><code>tag</code></td><td>stringified JSON</td><td>Labels attached to the interaction. The <code>source</code> key inside the tag must match the product: <code>"AGENTIC"</code> for Akto Argus</td></tr><tr><td><code>contextSource</code></td><td>string</td><td>Identifies the product context: <code>"AGENTIC"</code> for Akto Argus (homegrown AI</td></tr></tbody></table>

{% hint style="info" %}
**Collection Naming**

The `host` value inside `requestHeaders` determines which collection this interaction appears under in the Akto dashboard. Use a consistent, descriptive hostname (e.g. `"my-agent.internal"`) to group traffic from the same agent together.
{% endhint %}

## File / Media Validation API

Use this endpoint when the payload is a file (image, video, audio, PDF, etc.) rather than a JSON body. The endpoint accepts a `multipart/form-data` request and evaluates the file against your configured guardrail policies.

### Endpoint

```
POST https://<GUARDRAILS_SERVICE_URL>/api/validate/file
```

### Headers

<table><thead><tr><th width="218">Header</th><th width="140">Required</th><th>Description</th></tr></thead><tbody><tr><td><code>Authorization</code></td><td>Yes</td><td>Your Akto API token</td></tr></tbody></table>

### Form Fields

All fields are sent as `multipart/form-data` parts:

<table><thead><tr><th width="200">Field</th><th width="110">Required</th><th>Description</th></tr></thead><tbody><tr><td><code>file</code></td><td>Yes</td><td>The file to validate (binary upload)</td></tr><tr><td><code>contextSource</code></td><td>Yes</td><td>Product context. Use <code>"ENDPOINT"</code> for Akto Atlas</td></tr><tr><td><code>path</code></td><td>Yes</td><td>API path where the file was submitted (e.g. <code>"/backend-api/files"</code>)</td></tr><tr><td><code>requestHeaders</code></td><td>Yes</td><td>Stringified JSON of request headers. The <code>host</code> value sets the collection name in Akto</td></tr><tr><td><code>method</code></td><td>Yes</td><td>HTTP method of the original upload (e.g. <code>"POST"</code>)</td></tr><tr><td><code>ip</code></td><td>Yes</td><td>IP address of the caller</td></tr><tr><td><code>time</code></td><td>Yes</td><td>Unix timestamp in <strong>milliseconds</strong> of when the interaction occurred</td></tr><tr><td><code>statusCode</code></td><td>Yes</td><td>HTTP status code (e.g. <code>"200"</code>)</td></tr><tr><td><code>status</code></td><td>Yes</td><td>Same as <code>statusCode</code></td></tr><tr><td><code>tag</code></td><td>Yes</td><td>Stringified JSON of labels (e.g. <code>{"gen-ai":"Gen AI"}</code>)</td></tr><tr><td><code>metadata</code></td><td>Yes</td><td>Stringified JSON of additional metadata. Can mirror <code>tag</code></td></tr></tbody></table>

### Sample Request

```bash
curl --location 'https://<GUARDRAILS_SERVICE_URL>/api/validate/file' \
--header 'Authorization: <YOUR_AKTO_API_TOKEN>' \
--form 'file=@"/path/to/file"' \
--form 'contextSource="ENDPOINT"' \
--form 'path="/backend-api/files"' \
--form 'requestHeaders="{\"host\":\"your-agent.example.com\"}"' \
--form 'method="POST"' \
--form 'ip="<CLIENT_IP>"' \
--form 'time="1780821900129"' \
--form 'statusCode="200"' \
--form 'status="200"' \
--form 'tag="{\"gen-ai\":\"Gen AI\"}"' \
--form 'metadata="{\"gen-ai\":\"Gen AI\"}"'
```

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

Follow the [Getting API Token](../../akto-argus-agentic-ai-security-for-homegrown-ai/connectors/others/hybrid-saas.md#getting-api-token) steps in the Hybrid SaaS guide to get your token. Copy it — you will use it as the `Authorization` header value.
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
**Send a file for validation (optional)**

To test file/media guardrails, use the `/api/validate/file` endpoint instead:

```bash
curl --location 'https://<GUARDRAILS_SERVICE_URL>/api/validate/file' \
--header 'Authorization: <YOUR_AKTO_API_TOKEN>' \
--form 'file=@"/path/to/file"' \
--form 'contextSource="ENDPOINT"' \
--form 'path="/backend-api/files"' \
--form 'requestHeaders="{\"host\":\"your-agent.example.com\"}"' \
--form 'method="POST"' \
--form 'ip="<CLIENT_IP>"' \
--form 'time="1780821900129"' \
--form 'statusCode="200"' \
--form 'status="200"' \
--form 'tag="{\"gen-ai\":\"Gen AI\"}"' \
--form 'metadata="{\"gen-ai\":\"Gen AI\"}"'
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
