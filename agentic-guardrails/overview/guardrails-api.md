---
description: >-
  Use the Akto Guardrails HTTP API to inspect and ingest AI agent traffic
  directly
---

# Guardrails as API

## Overview

Akto exposes its guardrail engine as a standalone HTTP API. Any application or agent can send request/response traffic to this endpoint directly, no SDK, proxy sidecar, or framework hook required. Akto evaluates the payload against your configured guardrail policies, ingests the interaction into the Akto dashboard, and returns a verdict.

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

* An **Akto API token**: follow the [Getting API Token](../../akto-argus-agentic-ai-security-for-homegrown-ai/connectors/others/hybrid-saas.md#getting-api-token) steps in the Hybrid SaaS guide
* Your **Guardrails Service URL**: contact the Akto support team to get the URL for your account. It follows the format `https://<account_id>-guardrails.akto.io`

## API Reference

### Endpoint

```
POST https://<GUARDRAILS_SERVICE_URL>/api/http-proxy
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

{% hint style="warning" %}
**All fields are mandatory.**

Every field listed below must be included in the request body, even the ones with a fixed or default value (e.g. `type`, `akto_vxlan_id`, `is_pending`).
{% endhint %}

<table><thead><tr><th width="200.21875">Field</th><th width="198.09765625">Type</th><th>Description</th></tr></thead><tbody><tr><td><code>path</code></td><td>string</td><td>The API path of the upstream call (e.g. <code>/v1/messages</code>, <code>/v1/chat/completions</code>)</td></tr><tr><td><code>requestHeaders</code></td><td>stringified JSON</td><td>Headers sent with the request. The <code>host</code> value becomes the <strong>collection name</strong> in Akto</td></tr><tr><td><code>responseHeaders</code></td><td>stringified JSON</td><td>Headers received with the response. Pass <code>"{}"</code> if not available</td></tr><tr><td><code>method</code></td><td>string</td><td>HTTP method of the upstream call (e.g. <code>POST</code>, <code>GET</code>)</td></tr><tr><td><code>requestPayload</code></td><td>stringified JSON</td><td>Body of the request sent to the LLM or agent. Use <code>{"body": "&#x3C;content>"}</code> format</td></tr><tr><td><code>responsePayload</code></td><td>stringified JSON</td><td>Body of the response received from the LLM or agent. Use <code>{"body": "&#x3C;content>"}</code> format</td></tr><tr><td><code>ip</code></td><td>string</td><td>IP address of the caller. Use <code>"127.0.0.1"</code> if not applicable</td></tr><tr><td><code>time</code></td><td>string</td><td>Unix timestamp in <strong>milliseconds</strong> of when the interaction occurred</td></tr><tr><td><code>statusCode</code></td><td>string</td><td>HTTP status code of the upstream response (e.g. <code>"200"</code>, <code>"500"</code>)</td></tr><tr><td><code>type</code></td><td>string or null</td><td>Set to <code>null</code> unless instructed otherwise</td></tr><tr><td><code>status</code></td><td>string</td><td>Same as <code>statusCode</code></td></tr><tr><td><code>akto_account_id</code></td><td>string</td><td>Your Akto account ID. Use <code>"1000000"</code> unless the Akto support team specifies otherwise</td></tr><tr><td><code>akto_vxlan_id</code></td><td>string</td><td>Set to <code>"0"</code> unless instructed otherwise</td></tr><tr><td><code>is_pending</code></td><td>string</td><td>Set to <code>"false"</code></td></tr><tr><td><code>source</code></td><td>string</td><td>Traffic source label. Use <code>"MIRRORING"</code> for agentic traffic</td></tr><tr><td><code>tag</code></td><td>stringified JSON</td><td>Labels attached to the interaction. The <code>source</code> key inside the tag must match the product: <code>"AGENTIC"</code> for Akto Argus</td></tr><tr><td><code>contextSource</code></td><td>string</td><td>Identifies the product context: <code>"AGENTIC"</code> for Akto Argus (homegrown AI)</td></tr></tbody></table>

{% hint style="info" %}
**Collection Naming**

The `host` value inside `requestHeaders` determines which collection this interaction appears under in the Akto dashboard. Use a consistent, descriptive hostname (e.g. `"my-agent.internal"`) to group traffic from the same agent together.
{% endhint %}

## Response and Guardrail Modes

### Response Format

The guardrail verdict is returned under `data.guardrailsResult`:

```json
{
  "success": true,
  "message": "Request processed successfully",
  "latencyMs": 1840,
  "data": {
    "success": true,
    "message": "Request processed successfully",
    "guardrailsResult": {
      "Allowed": false,
      "Modified": false,
      "ModifiedPayload": "",
      "Reason": "[Block] Blocked due to prompt injection",
      "behaviour": "block",
      "Metadata": {
        "policy_name": "Prompt Injection Policy",
        "rule_violated": "PromptInjection",
        "severity": "HIGH"
      }
    }
  }
}
```

<table><thead><tr><th width="200">Field</th><th width="120">Type</th><th>Description</th></tr></thead><tbody><tr><td><code>Allowed</code></td><td>boolean</td><td><code>true</code> when no guardrail was violated. <code>false</code> when a policy was violated, <strong>regardless of its mode</strong>. Always read it together with <code>behaviour</code></td></tr><tr><td><code>behaviour</code></td><td>string</td><td>The <strong>Rule Behaviour</strong> of the violated policy: <code>block</code>, <code>alert</code>, <code>human_approval</code>, or <code>warn</code> (legacy). Omitted when nothing was violated</td></tr><tr><td><code>Modified</code></td><td>boolean</td><td><code>true</code> when a policy masked or redacted part of the payload</td></tr><tr><td><code>ModifiedPayload</code></td><td>string</td><td>The masked payload. Forward this instead of the original when <code>Modified</code> is <code>true</code></td></tr><tr><td><code>Reason</code></td><td>string</td><td>Explanation of the verdict, prefixed with the mode, e.g. <code>[Block]</code>, <code>[Alert only]</code>, <code>[Approval required]</code></td></tr><tr><td><code>Metadata</code></td><td>object</td><td>The violated policy (<code>policy_name</code>), rule (<code>rule_violated</code>), <code>severity</code>, and violation details</td></tr></tbody></table>

{% hint style="warning" %}
**Field casing**

`Allowed`, `Modified`, `ModifiedPayload`, `Reason`, and `Metadata` are **PascalCase**, while `behaviour` is **lowercase**. Human Approval responses (below) use lowercase `allowed`. Read both casings to be safe.
{% endhint %}

When both `guardrails=true` and `response_guardrails=true` are set, `guardrailsResult` also carries `requestResult` and `responseResult` with the verdict for each side. The top-level `Allowed` is `false` if either side was violated, so read `behaviour` from the side that was violated.

### Guardrail Modes

Each guardrail policy has a **Rule Behaviour** that decides what happens when it is violated. Set it in the policy's **Scope** section. See [Create Guardrail Policies](../how-to/create-guardrail-policies.md).

Akto does not sit inline in your traffic when you use this API. It returns the verdict, and **your application enforces it**. Use `behaviour` to decide what to do:

<table><thead><tr><th width="160">Mode</th><th width="170"><code>behaviour</code></th><th width="110"><code>Allowed</code></th><th>What your application should do</th></tr></thead><tbody><tr><td><strong>Block</strong></td><td><code>block</code></td><td><code>false</code></td><td>Stop the request or response. Return an error or a safe message to the user</td></tr><tr><td><strong>Alert</strong></td><td><code>alert</code></td><td><code>false</code></td><td><strong>Let it through.</strong> Akto records the violation in Guardrail Activity for review</td></tr><tr><td><strong>Human Approval</strong></td><td><code>human_approval</code></td><td><code>false</code></td><td>Hold the request and poll for the approver's decision (see below)</td></tr><tr><td><strong>Mask / Redact</strong></td><td><code>alert</code> (with <code>Modified: true</code>)</td><td><code>true</code></td><td>Forward <code>ModifiedPayload</code> instead of the original payload</td></tr><tr><td>No violation</td><td><em>omitted</em></td><td><code>true</code></td><td>Let it through</td></tr></tbody></table>

{% hint style="danger" %}
**Do not rely on `Allowed` alone.**

In **Alert** mode `Allowed` is still `false`, because a policy *was* violated. If you block on `Allowed == false`, alert-mode policies will block traffic. Block only when `behaviour` is `block` (or any value other than `alert`).
{% endhint %}

If several policies are violated, the strictest mode is returned: **Block** > **Human Approval** > **Alert**. A missing or unknown `behaviour` on a violation should be treated as **Block**.

**Sample enforcement logic**

```python
result = resp.json()["data"]["guardrailsResult"]
allowed = result.get("Allowed", result.get("allowed", True))
behaviour = (result.get("behaviour") or "").lower()
payload = original_payload

if result.get("Modified"):
    payload = result["ModifiedPayload"]        # Mask / Redact: forward masked payload
if allowed or behaviour == "alert":
    forward(payload)                           # No violation, or Alert mode
elif behaviour == "human_approval":
    wait_for_approval(result["activityId"])    # Human Approval: poll (see below)
else:
    reject(result.get("Reason"))               # Block (default)
```

### Human Approval Mode

When a policy set to **Human Approval** is violated, the attempt is sent to your approvers in the **Needs Approval** tab of Guardrail Activity. The response carries an `activityId` and a `status`:

```json
{
  "success": true,
  "message": "Request processed successfully",
  "data": {
    "guardrailsResult": {
      "allowed": false,
      "behaviour": "human_approval",
      "status": "pending",
      "activityId": "<ACTIVITY_ID>",
      "reason": "[Approval required] Held for approval due to ...",
      "modified": false
    }
  }
}
```

Poll for the decision by calling the same endpoint with only the `activityId`. Akto looks up the decision and does not re-run the guardrails:

```bash
curl --location --request POST 'https://<GUARDRAILS_SERVICE_URL>/api/http-proxy' \
  --header 'authorization: <YOUR_AKTO_API_TOKEN>' \
  --header 'Content-Type: application/json' \
  --data '{"activityId": "<ACTIVITY_ID>"}'
```

<table><thead><tr><th width="160"><code>status</code></th><th width="120"><code>allowed</code></th><th>Meaning</th></tr></thead><tbody><tr><td><code>pending</code></td><td><code>false</code></td><td>No decision yet. Keep holding the request and poll again</td></tr><tr><td><code>approved</code></td><td><code>true</code></td><td>An approver allowed it. Forward the request</td></tr><tr><td><code>blocked</code></td><td><code>false</code></td><td>An approver denied it. Reject the request</td></tr></tbody></table>

Poll every few seconds, and set a timeout after which your application treats the request as blocked. See [Manage Human Approval Requests](../how-to/manage-human-approval-requests.md) for the approver workflow.

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

Follow the [Getting API Token](../../akto-argus-agentic-ai-security-for-homegrown-ai/connectors/others/hybrid-saas.md#getting-api-token) steps in the Hybrid SaaS guide to get your token. Copy it, you will use it as the `Authorization` header value.
{% endstep %}

{% step %}
**Send your first request**

Use the sample `curl` below, replacing the placeholder values:

```bash
curl --location --request POST \
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
