
# Red Teaming Copilot Studio AI Agents with Akto

## Overview

This guide walks you through setting up automated red teaming for AI Agents built on Microsoft Copilot Studio using Akto. A Power Automate flow acts as the HTTP bridge between Akto and your Copilot Studio agent — Akto sends adversarial prompts to the flow, the flow forwards them to your agent, and the responses come back for analysis.

***

## Prerequisites

* A **published** AI Agent in Copilot Studio (draft agents won't work)
* Admin access to the Microsoft account used for testing
* Access to [Microsoft Entra](https://entra.microsoft.com)
* Access to [Power Automate](https://make.powerautomate.com)

***

## Step 1: Create an App Registration in Microsoft Entra

This app registration lets you obtain an access token to call the Power Automate flow programmatically.

### Register the App

{% stepper %}
{% step %}
Go to [Microsoft Entra](https://entra.microsoft.com) > **App registrations** > **New registration**.
{% endstep %}

{% step %}
Give the app a name (e.g., `AktoFlowCaller`) and set supported account types to **Single tenant**.
{% endstep %}

{% step %}
No redirect URI needed — click **Register**.
{% endstep %}

{% step %}
Note down:

* **Application (Client) ID**
* **Directory (Tenant) ID**
{% endstep %}
{% endstepper %}

### Create a Client Secret

{% stepper %}
{% step %}
Go to **Certificates & secrets** > **New client secret**.
{% endstep %}

{% step %}
Set an expiry and click **Add**.
{% endstep %}

{% step %}
**Copy the secret value immediately** — it is not shown again.
{% endstep %}
{% endstepper %}

### Add API Permissions

{% stepper %}
{% step %}
Go to **API Permissions** > **Add a permission**.
{% endstep %}

{% step %}
Select the **APIs my organization uses** tab.
{% endstep %}

{% step %}
Search for **Power Automate** (also listed as "Microsoft Flow Service").
{% endstep %}

{% step %}
Select **Delegated permissions** > select **User**.
{% endstep %}

{% step %}
Click **Add permissions**, then click **Grant admin consent**.
{% endstep %}
{% endstepper %}

{% hint style="info" %}
Power Automate exposes delegated permissions only — there are no application-level permissions for `service.flow.microsoft.com`. Client credentials flow still works because Power Automate validates the token's `aud` and `oid` claims, not specific scopes.
{% endhint %}

### Note the Service Principal Object ID

This is required when restricting who can trigger the flow.

{% stepper %}
{% step %}
Go to **Microsoft Entra** > **Enterprise applications**.
{% endstep %}

{% step %}
Search for your app by name.
{% endstep %}

{% step %}
Note the **Object ID** — this is **different** from the Application (Client) ID.
{% endstep %}
{% endstepper %}

***

## Step 2: Create a Power Automate Flow

This flow is the HTTP endpoint that Akto will call. It forwards the prompt to your Copilot Studio agent and returns the response.

{% stepper %}
{% step %}
Go to [Power Automate](https://make.powerautomate.com) and create a new **Instant cloud flow**. Give it a name and click **Skip** on the template screen.
{% endstep %}

{% step %}
Click **Add Trigger** and search for **"When an HTTP request is received"** — select it.
{% endstep %}

{% step %}
In the trigger settings, set **"Who can trigger the flow?"** to:

* **Any user in my tenant** — for broad access, or
* **Specific users in my tenant** — paste the **Object ID** from Step 1 (the Enterprise Application Object ID, not the Client ID)
{% endstep %}

{% step %}
Add a sample JSON body to auto-generate the schema:

```json
{
  "query": "hello"
}
```
{% endstep %}

{% step %}
**Save the flow first** — the trigger URL is only generated after saving. Copy the **HTTP POST URL** from the trigger card.
{% endstep %}

{% step %}
Click **+** to add a new step, search for **Microsoft Copilot Studio**, and select **"Execute Agent and wait"**.
{% endstep %}

{% step %}
Connect your Copilot Studio account (provide a connection name and authenticate with a named user account).
{% endstep %}

{% step %}
Configure the action:

* **Agent**: select your published agent
* **Message**: click **Add dynamic content** → select `query`
* **Conversation ID**: leave blank to start a new conversation each time
{% endstep %}

{% step %}
Click **+** to add another step — search for and select **Response** (from the Request connector).
{% endstep %}

{% step %}
Set the following fields:

* **Status Code**: `200`
* **Body**: click the function icon (`fx`) and enter the expression below
* **Content-Type header**: `application/json`

```
addProperty(json('{}'), 'lastResponse', outputs('Execute_Agent_and_wait')?['body/lastResponse'])
```
{% endstep %}

{% step %}
**Save** the flow.
{% endstep %}
{% endstepper %}

{% hint style="warning" %}
Use **"Execute Agent and wait"** — not **"Execute Agent"**. The latter is fire-and-forget and does not return the agent's response.
{% endhint %}

***

## Step 3: Test the Flow Manually

Verify everything works before connecting to Akto.

### Get an Access Token

```bash
curl --request POST \
  --url https://login.microsoftonline.com/<TENANT_ID>/oauth2/v2.0/token \
  --header 'content-type: application/x-www-form-urlencoded' \
  --data client_id=<CLIENT_ID> \
  --data 'scope=https://service.flow.microsoft.com//.default' \
  --data 'client_secret=<CLIENT_SECRET>' \
  --data grant_type=client_credentials
```

{% hint style="warning" %}
The scope uses a **double slash** (`//`) before `.default`. This is required — the token audience must be exactly `https://service.flow.microsoft.com/` (with trailing slash). A single slash produces a mismatched `aud` claim and the flow will reject the token with `MisMatchingOAuthClaims`.
{% endhint %}

Copy the `access_token` from the response.

### Call the Flow

```bash
curl --request POST \
  --url '<FLOW_TRIGGER_URL>' \
  --header 'Authorization: Bearer <ACCESS_TOKEN>' \
  --header 'Content-Type: application/json' \
  --data '{
  "query": "what are you doing?"
}'
```

Replace `<FLOW_TRIGGER_URL>` with the HTTP POST URL copied from the trigger card in Step 2.

**Expected response:** The agent's reply in the response body.

***

## Step 4: Add to Akto for Automated Red Teaming

Coming soon.

***

## Troubleshooting

| Issue | Likely Cause | Fix |
|---|---|---|
| `MisMatchingOAuthClaims` on flow call | Wrong scope in token request | Use double slash: `https://service.flow.microsoft.com//.default` |
| `401 Unauthorized` on token request | Wrong client ID, secret, or tenant ID | Double-check app registration values in Entra |
| `403 Forbidden` on flow call | Wrong Object ID in Allowed Users, or admin consent not granted | Use the Enterprise Application Object ID (not the Client/App ID); re-check the Add API Permissions section |
| Trigger URL is blank | Flow not saved yet | Save the flow first — the URL only appears after the first save |
| Agent returns empty response | Using "Execute Agent" instead of "Execute Agent and wait" | Switch to the "Execute Agent and wait" action |
| Field `latestResponse` not found | Wrong field name | The correct field is `lastResponse` (not `latestResponse`) |
| Flow works but agent gives no reply | Agent is unpublished | Publish the agent in Copilot Studio before testing |
| Token accepted but flow returns 403 | "Specific users" mode but wrong Object ID entered | Paste the **Object ID** from Enterprise Applications, not the App ID from App Registrations |
