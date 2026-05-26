---
description: Add inline request and response guardrails to Microsoft Copilot Studio agents
---

# Connect to Akto (Sync)

## Overview

The **sync** integration adds Akto guardrails **inside** your Microsoft Copilot Studio agent. Every user message and every AI-generated response is sent to Akto in real time so that prompt-injection, PII leaks, and policy violations can be **blocked** before they reach the model or the end user.

Unlike the [async integration](connect-akto-async.md) — which only observes traffic after the fact — the sync integration sits **on the conversation path** and can stop a request mid-flight.

Once configured, the agent will:

* **Intercept every user message** before it is sent to the AI model and block it if Akto returns `Allowed: false`.
* **Intercept every AI-generated response** before it is delivered to the user and scan it for violations.
* **Surface the block reason** returned by Akto directly inside the chat (e.g. "Request blocked: contains restricted PII").

## How It Works

```
User message
     ↓
Copilot Studio "Request Guardrail" topic ──► Akto (sync, blocking)
     ↓ (allowed)
AI model
     ↓
Copilot Studio "Response Guardrail" topic ──► Akto (async scan)
     ↓
User
```

1. **Request Guardrail topic** — fires on every incoming user message at **Priority 0** (before any other topic). Calls Akto's `http-proxy` endpoint and waits for a verdict. If `Allowed: false`, the topic sends the block reason to the user and ends the conversation turn.
2. **Response Guardrail topic** — fires when an AI-generated response is about to be sent. Forwards the prompt and response to Akto for background analysis; the response is delivered to the user immediately while Akto scans it.

## Prerequisites

* A **Microsoft Copilot Studio** agent you can edit (Author or Maker role on the agent).
* The **Akto Guardrails URL** — provisioned and shared by Akto.
* Permission to publish the agent after the new topics are added.

{% hint style="info" %}
The sync integration runs **alongside** the async Dataverse connector — there is no need to disable one to use the other. Many customers run both: sync for blocking, async for offline red-teaming on the same conversations.
{% endhint %}

## Steps to Connect

### Part 1 — Request Guardrail (blocking)

This topic intercepts every user message **before** it reaches the AI model.

{% stepper %}
{% step %}
**Open your agent**

Go to [copilotstudio.microsoft.com](https://copilotstudio.microsoft.com) and open the agent you want to protect.
{% endstep %}

{% step %}
**Create a new topic**

Select **Topics → + Add a topic → From blank**.
{% endstep %}

{% step %}
**Name the topic**

Name it `Akto Request Guardrail` and select **Save**.
{% endstep %}

{% step %}
**Set the trigger**

1. Select the **Trigger** node and change its type to **"A message is received"** (not a keyword-based trigger).
2. Select **Edit** and set **Priority** to `0`.

{% hint style="info" %}
Priority `0` ensures this topic fires on **every** user message before any other topic — including agent-defined intents.
{% endhint %}
{% endstep %}

{% step %}
**Add an HTTP Request action**

Select **+** below the trigger → **Advanced → Send HTTP request**.
{% endstep %}

{% step %}
**Configure the HTTP request**

| Field | Value |
| --- | --- |
| URL | `https://<your-akto-host>/api/http-proxy?ingest_data=true&guardrails=true` |
| Method | `POST` |

**Body** — select **JSON Content**, then **Edit formula**, and paste:

```
{
    path: "/v1/messages",
    requestHeaders: JSON(
        {
            host: System.Bot.Name & ".copilotstudio.microsoft.com"
        },
        JSONFormat.Compact
    ),
    responseHeaders: "",
    requestPayload: JSON(
        {
            body: System.Activity.Text
        },
        JSONFormat.Compact
    ),
    responsePayload: "{}",
    method: "POST",
    ip: "127.0.0.1",
    destIp: "127.0.0.1",
    time: Text(DateDiff(DateTime(1970,1,1,0,0,0), Now(), TimeUnit.Seconds)),
    statusCode: "200",
    type: "HTTP/1.1",
    status: "200",
    akto_account_id: "1000000",
    akto_vxlan_id: "1000000",
    is_pending: "false",
    source: "MIRRORING",
    contextSource: "AGENTIC",
    tag: JSON(
        {
            'gen-ai': "Gen AI"
        },
        JSONFormat.Compact
    )
}
```

**Response Data Type** — choose **From a sample**, select **Get schema from sample data**, and paste:

```json
{
  "data": {
    "guardrailsResult": {
      "Allowed": false,
      "Modified": false,
      "ModifiedPayload": "",
      "Reason": "reason",
      "Metadata": {
        "policy_name": "",
        "rule_violated": ""
      },
      "behaviour": "block"
    },
    "success": true,
    "message": "Request processed successfully"
  },
  "message": "Request processed successfully",
  "success": true
}
```

**Save response as** → **Select a variable → Create new** → rename it to `GuardrailsResponse`.
{% endstep %}

{% step %}
**Handle blocked requests**

Add a **Condition** node below the HTTP request:

* **Variable**: `GuardrailsResponse.data.guardrailsResult.Allowed`
* **Condition**: **Is equal to** → `false`

**Left branch (blocked):**

1. **+ → Send a message** → insert the variable `GuardrailsResponse.data.guardrailsResult.Reason`.
2. **+ → Topic Management → End All Topics**.

**Right branch (allowed):**

Leave empty — the conversation continues to the next topic or the AI model.
{% endstep %}

{% step %}
**Save the topic**

Select **Save** in the top-right corner of the topic editor.
{% endstep %}
{% endstepper %}

### Part 2 — Response Guardrail (async scan)

This topic captures the AI-generated response and forwards it to Akto for background analysis. The user receives the response immediately; Akto flags violations asynchronously.

{% stepper %}
{% step %}
**Create a new topic**

Select **Topics → + Add a topic → From blank**.
{% endstep %}

{% step %}
**Name the topic**

Name it `Akto Response Guardrail` and select **Save**.
{% endstep %}

{% step %}
**Set the trigger**

Select the **Trigger** node and change its type to **"An AI generated response is about to be sent"**.
{% endstep %}

{% step %}
**Add an HTTP Request action**

Select **+** below the trigger → **Advanced → Send HTTP request**.
{% endstep %}

{% step %}
**Configure the HTTP request**

| Field | Value |
| --- | --- |
| URL | `https://<your-akto-host>/api/http-proxy?ingest_data=true&guardrails=true` |
| Method | `POST` |

**Body** — select **JSON Content**, then **Edit formula**, and paste:

```
{
    path: "/v1/messages",
    requestHeaders: JSON(
        {
            host: System.Bot.Name & ".copilotstudio.microsoft.com"
        },
        JSONFormat.Compact
    ),
    responseHeaders: JSON(
        {
            'content-type': "application/json"
        },
        JSONFormat.Compact
    ),
    requestPayload: JSON(
        {
            body: System.Activity.Text
        },
        JSONFormat.Compact
    ),
    responsePayload: JSON(
        {
            body: System.Response.FormattedText
        },
        JSONFormat.Compact
    ),
    method: "POST",
    ip: "127.0.0.1",
    destIp: "127.0.0.1",
    time: Text(DateDiff(DateTime(1970,1,1,0,0,0), Now(), TimeUnit.Seconds)),
    statusCode: "200",
    type: "HTTP/1.1",
    status: "200",
    akto_account_id: "1000000",
    akto_vxlan_id: "1000000",
    is_pending: "false",
    source: "MIRRORING",
    contextSource: "AGENTIC",
    tag: JSON(
        {
            'gen-ai': "Gen AI"
        },
        JSONFormat.Compact
    )
}
```
{% endstep %}

{% step %}
**Save the topic**

Select **Save**, then **Publish** the agent so both new topics go live.
{% endstep %}
{% endstepper %}

{% hint style="warning" %}
The response guardrail runs **asynchronously**. The user always receives the AI response immediately; Akto scans it in the background and surfaces violations on the dashboard.
{% endhint %}

## Verify the Integration

1. Open your agent in the **Test agent** pane on the right side of Copilot Studio.
2. Send a benign message (e.g. "Hello") — it should flow through normally.
3. Send a prompt that violates one of your configured Akto policies (e.g. a known prompt-injection payload). The response should be the **Reason** returned by Akto, and the conversation turn should end.
4. Open the Akto dashboard → **Argus → Traffic** and confirm the conversation appears with the corresponding guardrail verdict.

## Troubleshooting

### Request guardrail does not fire

* Confirm the topic trigger is **"A message is received"** and that **Priority** is `0`. A non-zero priority lets other topics match first.

### `Allowed` is always `true` even for malicious prompts

* Check your **guardrail policies** configuration in the Akto dashboard — make sure the policies you expect to trigger are enabled and have rules covering the prompt you tested.
* Check whether **guardrails are enabled for this specific agent** in the Akto dashboard. An agent without guardrails enabled will fall through with `Allowed: true`.

### Block message shows raw JSON instead of the reason

* In the **Send a message** node, insert the variable `GuardrailsResponse.data.guardrailsResult.Reason` directly — do not wrap it in a formula or `JSON(...)` call.

### `4xx` or `5xx` from the HTTP request

* Verify the Akto host is reachable from Microsoft's outbound IP ranges. If the host is internal-only, the HTTP request action cannot reach it.
* Inspect the **Activity** log of the topic run in the Copilot Studio test pane for the exact status code and response body.

## Get Support

If you need help with the sync integration:

* **In-app Chat** — use the chat widget in your Akto dashboard for instant support.
* **Discord Community** — join us at [discord.gg/Wpc6xVME4s](https://discord.gg/Wpc6xVME4s).
* **Email Support** — contact [help@akto.io](mailto:help@akto.io).
* **Contact Form** — submit a request at [https://www.akto.io/contact-us](https://www.akto.io/contact-us).
