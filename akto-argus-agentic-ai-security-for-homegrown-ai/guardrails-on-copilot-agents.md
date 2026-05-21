# Akto Guardrails for Copilot Studio

Add request and response guardrails to your Microsoft Copilot Studio agent using Akto.

---

## Request Guardrails

Intercepts every user message before it reaches the AI model.

### Step 1 — Open your agent

Go to [copilotstudio.microsoft.com](https://copilotstudio.microsoft.com) and open the agent you want to protect.

### Step 2 — Create a new topic

**Topics → + Add a topic → From blank**

### Step 3 — Name the topic

Name it `Akto Request Guardrail` and click **Save**.

### Step 4 — Set the trigger

- Click the **Trigger** node → change type to **"A message is received"** (not keyword-based)
- Click **Edit** → set **Priority** to `0`

> Priority 0 ensures this topic fires on every user message before any other topic.

### Step 5 — Add an HTTP Request action

Click **+** below the trigger → **Advanced → Send HTTP request**

### Step 6 — Configure the HTTP request

| Field | Value |
|-------|-------|
| URL | `https://<your-akto-host>/api/http-proxy?ingest_data=true&guardrails=true` |
| Method | `POST` |

**Body** — select **JSON Content**, then choose **Edit formula** and paste:

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

**Response Data Type** — choose **From a sample**, click **Get schema from sample data**, and paste:

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

**Save response as** → **Select a variable → Create new** → rename to `GuardrailsResponse`

### Step 7 — Handle blocked requests

**Add a Condition:**
- Variable: `GuardrailsResponse.data.guardrailsResult.Allowed`
- Condition: **Is equal to** → `false`

**Left branch (blocked):**
1. **+ → Send a message** → insert variable `GuardrailsResponse.data.guardrailsResult.Reason`
2. **+ → Topic Management → End All Topics**

**Right branch (allowed):**
- Leave empty — conversation continues normally.

### Step 8 — Save

---

## Response Guardrails

Intercepts the AI-generated response before it is sent to the user. Runs asynchronously — the response is delivered to the user while Akto scans it in the background.

### Step 1 — Create a new topic

**Topics → + Add a topic → From blank**

### Step 2 — Name the topic

Name it `Akto Response Guardrail` and click **Save**.

### Step 3 — Set the trigger

- Click the **Trigger** node → change type to **"An AI generated response is about to be sent"**

### Step 4 — Add an HTTP Request action

Click **+** below the trigger → **Advanced → Send HTTP request**

### Step 5 — Configure the HTTP request

| Field | Value |
|-------|-------|
| URL | `https://<your-akto-host>/api/http-proxy?ingest_data=true&guardrails=true` |
| Method | `POST` |

**Body** — select **JSON Content**, then choose **Edit formula** and paste:

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

### Step 6 — Save

> Response guardrails are asynchronous. The user receives the AI response immediately; Akto scans it in the background and flags violations.
