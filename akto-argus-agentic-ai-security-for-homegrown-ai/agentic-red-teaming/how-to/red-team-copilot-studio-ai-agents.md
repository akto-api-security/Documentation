
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
Select the **APIs my organization uses** tab. Search for **Power Platform API** and add the following delegated permission:

* `CopilotStudio.Copilots.Invoke`
{% endstep %}

{% step %}
Click **Add a permission** again. Search for **Power Automate** (also listed as "Microsoft Flow Service") and add the following delegated permissions:

* `User`
* `Flows.Read.All`
{% endstep %}

{% step %}
Click **Grant admin consent**.
{% endstep %}
{% endstepper %}

{% hint style="info" %}
Power Automate exposes delegated permissions only — there are no application-level permissions for `service.flow.microsoft.com`. Client credentials flow still works because Power Automate validates the token's `aud` and `oid` claims, not specific scopes.
{% endhint %}

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
Connect your Copilot Studio account (provide a connection name and authenticate with OAuth).
{% endstep %}

{% step %}
Configure the action:

* **Agent**: select your published agent
* Click **Advanced parameters** and select **Message**
* In the **Message** field, click **Add dynamic content** → select `query`
{% endstep %}

{% step %}
Click **+** to add another step — search for and select **Response** (from the Request connector).
{% endstep %}

{% step %}
Set the following fields:

* **Status Code**: `200`
* **Content-Type header**: `application/json`
* **Body**: click the function icon (`fx`) and enter the expression below

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

### Add the AI Agent to Akto

{% stepper %}
{% step %}
Log in to Akto and navigate to **Argus** > **Connectors** > **Bring your own AI Agent**.
{% endstep %}

{% step %}
In the **URL** field, paste the `FLOW_TRIGGER_URL` from Step 2.

{% hint style="info" %}
The trigger URL generated by Power Automate includes `:443` after the hostname (e.g., `https://defaultxxx.f8.environment.api.powerplatform.com:443/powerautomate/...`). Remove `:443` before pasting into Akto.
{% endhint %}
{% endstep %}

{% step %}
Select **Custom body** and add the sample payload:

```json
{
  "query": "hello"
}
```
{% endstep %}

{% step %}
Click **Add Custom Headers** and add the following:

* **Key**: `Authorization`
* **Value**: `Bearer <ACCESS_TOKEN>`

Replace `<ACCESS_TOKEN>` with the token obtained in Step 3.
{% endstep %}

{% step %}
Click **Import**.
{% endstep %}
{% endstepper %}

Wait a few seconds — your imported agent will appear under **Agentic Assets** > **Custom** tab.

***

### Create and Configure a Test Role

A test role tells Akto how to fetch a fresh access token automatically during red teaming, since tokens expire.

{% stepper %}
{% step %}
Go to **AI Red Teaming** > **Scan Roles** and click **Create New Test Role**.
{% endstep %}

{% step %}
Enter a name for the test role and configure the role endpoint conditions as needed.
{% endstep %}

{% step %}
Scroll to the **Automated Auth Token Generation** section and configure the token endpoint:

* **URL**: `https://login.microsoftonline.com/<TENANT_ID>/oauth2/v2.0/token`
* **Method**: `POST`
* **Headers**:
  ```json
  {"content-type": "application/x-www-form-urlencoded"}
  ```
* **Body**:
  ```
  client_id=<CLIENT_ID>&scope=https://service.flow.microsoft.com//.default&client_secret=<CLIENT_SECRET>&grant_type=client_credentials
  ```
{% endstep %}

{% step %}
In the **Extract** section, configure how Akto pulls the token from the response and set it to correct location during Red Teaming:

* **From**: `Header`
* **Key**: `Authorization`
* **Value**: `Bearer ${x1.response.body.access_token}`
{% endstep %}

{% step %}
Click **Save**.
{% endstep %}
{% endstepper %}

{% hint style="info" %}
For a detailed walkthrough of test role configuration, refer to the [Create a Test Role](https://docs.akto.io/api-security-testing/how-to/create-a-test-role#id-3.-automated-auth-token-generation) guide.
{% endhint %}

***

### Run a Red Teaming Scan

{% stepper %}
{% step %}
Navigate to **AI Agent Discovery** and open the collection that contains your imported Copilot Studio agent.
{% endstep %}

{% step %}
Select the agent endpoint you want to red team.
{% endstep %}

{% step %}
Click **Run Scan** to open the scan configuration panel.
{% endstep %}

{% step %}
Choose the red teaming tests you want to execute against the agent.
{% endstep %}

{% step %}
In the **Roles** section, select the test role you configured in the previous section. This ensures Akto automatically refreshes the access token during the scan.
{% endstep %}

{% step %}
Click **Run Scan** to start. Akto will send adversarial prompts to your Copilot Studio agent and analyze the responses.
{% endstep %}
{% endstepper %}

***

## Troubleshooting
