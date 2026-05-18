---
description: Connect Akto with Microsoft Copilot Studio
---

# Microsoft Copilot Studio

## Overview

[Microsoft Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) is a low-code platform for building and deploying conversational AI agents and copilots. Connect Akto Argus to your Copilot Studio environment to discover deployed agents and ingest conversation transcripts for security analysis.

Once connected, Akto Argus automatically:

* **Discovers Copilot agents** configured in your Power Platform environment
* **Ingests conversation transcripts** captured by Copilot Studio in Microsoft Dataverse
* **Pairs user prompts with bot responses** to reconstruct full conversation flows
* **Sends traffic to Akto** for prompt injection, PII, and policy-violation analysis

The connector reads conversation transcripts from the [Dataverse Web API](https://learn.microsoft.com/en-us/power-apps/developer/data-platform/webapi/overview) using a service principal — no changes are required to your Copilot Studio agents or their deployment.

## How It Works

```
Microsoft Copilot Studio
         ↓ (transcripts persisted)
Microsoft Dataverse  ──── (Dataverse Web API v9.1 + OAuth 2.0)
         ↓
Akto Argus Connector  ── (every 5 minutes)
         ↓
Akto Data Ingestion Service
         ↓
Akto Dashboard
```

1. **Polling** — The connector polls Dataverse on a recurring schedule (default: every 5 minutes) for new [conversation transcripts](https://learn.microsoft.com/en-us/microsoft-copilot-studio/analytics-transcripts-powerapps).
2. **Authentication** — [OAuth 2.0 client-credentials flow](https://learn.microsoft.com/en-us/entra/identity-platform/v2-oauth2-client-creds-grant-flow) using a Microsoft Entra ID app registration and a Dataverse application user.
3. **Pairing** — Each transcript's `activities` array is parsed; user messages (`role: 1`) are paired with the next bot response (`role: 0`) to form request/response pairs.
4. **Publishing** — Each pair is forwarded to your Akto Data Ingestion Service for ingestion into the Akto platform.

## Prerequisites

Before setting up the Copilot Studio connector, ensure the following requirements are met. **Most setup issues are caused by missing prerequisites — please review them carefully.**

### 1. Supported Power Platform Environment

Per the [Microsoft documentation on transcript controls](https://learn.microsoft.com/en-us/microsoft-copilot-studio/admin-transcript-controls), Microsoft does **not** persist Copilot Studio conversation transcripts to Dataverse for the following [environment types](https://learn.microsoft.com/en-us/power-platform/admin/environments-overview):

* Dataverse **developer** environments
* Microsoft Dataverse for Teams environments
* Microsoft 365 Copilot agents

Your agents must be deployed to a **Sandbox** or **Production** environment with a Dataverse database enabled. Verify the environment type in the [Power Platform admin center](https://admin.powerplatform.microsoft.com). For instructions on creating a new environment, see [Create and manage environments](https://learn.microsoft.com/en-us/power-platform/admin/create-environment).

### 2. Transcript Saving Enabled

The Power Platform environment setting **"Allow conversation transcripts and their associated metadata to be saved in Dataverse"** must be turned **on** for your environment. Full details are in the [Microsoft transcript-controls documentation](https://learn.microsoft.com/en-us/microsoft-copilot-studio/admin-transcript-controls#configure-transcript-recording-and-download).

To verify or enable it:

1. Open the [Power Platform admin center](https://admin.powerplatform.microsoft.com).
2. Go to **Manage** → **Environments** → select your environment → **Settings**.
3. Expand **Product** → **Features** → scroll to **Copilot Studio agents**.
4. Ensure **"Allow conversation transcripts and their associated metadata to be saved in Dataverse"** is enabled, then **Save**.

{% hint style="info" %}
Transcripts take **up to 30 minutes** to appear in Dataverse after a conversation ends. The default Dataverse retention for transcripts is 30 days; this can be extended — see [Change the default retention period](https://learn.microsoft.com/en-us/microsoft-copilot-studio/analytics-transcripts-powerapps#change-the-default-retention-period).
{% endhint %}

### 3. Copilot Studio License

A paid [Copilot Studio license](https://learn.microsoft.com/en-us/microsoft-copilot-studio/requirements-licensing) must be assigned to the account that owns the agents. Trial licenses do not always sync conversation transcripts to Dataverse.

### 4. Akto Data Ingestion Service

Your self-hosted Akto **Data Ingestion Service** must be deployed and reachable from the Akto Argus connector. The connector forwards each conversation pair to this endpoint.

## Steps to Connect

### Part 1 — Set Up Microsoft Entra ID and Dataverse Access

You only need to complete Part 1 once per Power Platform environment. The steps below mirror Microsoft's [confidential client app registration tutorial for Dataverse](https://learn.microsoft.com/en-us/power-apps/developer/data-platform/walkthrough-register-app-azure-active-directory#confidential-client-app-registration).

{% stepper %}
{% step %}
**Register an Application in Microsoft Entra ID**

1. Sign in to the [Azure portal](https://portal.azure.com) with an account that has administrator permission.
2. Go to [**Microsoft Entra ID**](https://learn.microsoft.com/en-us/entra/fundamentals/whatis) → **App registrations** → **+ New registration**. (See Microsoft's [Register an application](https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-register-app) guide for screenshots.)
3. Enter the following:
   * **Name**: `akto-copilot-studio-connector` (or any meaningful name)
   * **Supported account types**: **Accounts in this organizational directory only (single tenant)**
4. Select **Register**.
5. On the **Overview** page, copy and save the following values — you will paste them into the Akto dashboard later:
   * **Application (client) ID**
   * **Directory (tenant) ID**
{% endstep %}

{% step %}
**Create a Client Secret**

Follow Microsoft's [Add a client secret](https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-register-app#add-a-client-secret) guidance:

1. In your newly registered app, go to **Certificates & secrets** in the left navigation.
2. Select **+ New client secret**.
3. Enter a description and select an expiry (recommended: 12 months or as per your organization's policy).
4. Select **Add**.
5. Immediately copy the **Value** of the secret and save it securely.

{% hint style="warning" %}
The secret value is shown only once. If you navigate away before copying it, you will need to create a new secret.
{% endhint %}
{% endstep %}

{% step %}
**Create a Dataverse Application User**

The Microsoft Entra app must be bound to an [application user](https://learn.microsoft.com/en-us/power-platform/admin/manage-application-users) inside Dataverse before it can read data.

1. Open the [Power Platform admin center](https://admin.powerplatform.microsoft.com).
2. Select **Manage** → **Environments** → select your target environment.
3. Open **Settings** → **Users + permissions** → [**Application users**](https://learn.microsoft.com/en-us/power-platform/admin/manage-application-users#create-an-application-user).
4. Select **+ New app user**.
5. In the side panel, select **+ Add an app** and search for the app registration you created in Step 1. Select it and choose **Add**.
6. Select the appropriate **Business unit** (typically the default).
7. Assign a [security role](https://learn.microsoft.com/en-us/power-platform/admin/security-roles-privileges) that grants read access to the `bot` and `conversationtranscript` tables. Options:
   * **Quickest**: Assign the **System Administrator** role.
   * **Least privilege (recommended)**: [Create a custom security role](https://learn.microsoft.com/en-us/power-platform/admin/create-edit-security-role) with read access on the **Bot** and **Conversation transcript** tables only.
8. Select **Create**.
{% endstep %}

{% step %}
**Locate the Dataverse Environment URL**

1. In the [Power Platform admin center](https://admin.powerplatform.microsoft.com), open **Manage** → **Environments**.
2. Select your environment to view its details.
3. Copy the **Environment URL** value — it has the form:
   * `https://<your-org>.crm.dynamics.com` (North America)
   * `https://<your-org>.crm<region>.dynamics.com` (other regions, e.g., `crm4` for EMEA)

For the full list of regional URL suffixes, see Microsoft's [Datacenter regions](https://learn.microsoft.com/en-us/power-platform/admin/regions-overview) and [discover the URL of your environment](https://learn.microsoft.com/en-us/power-apps/developer/data-platform/webapi/compose-http-requests-handle-errors#web-api-url-and-versions) guides.
{% endstep %}
{% endstepper %}

### Part 2 — Connect from the Akto Dashboard

{% stepper %}
{% step %}
**Open the Copilot Studio Connector in Akto Argus**

1. Navigate to **Akto Argus** in your Akto dashboard.
2. Open **Connectors**.
3. Under **AI Agent Security**, locate the **Copilot Studio** connector card.
4. Select **Connect** to open the setup dialog.
{% endstep %}

{% step %}
**Enter the Dataverse Environment URL**

Paste the environment URL you copied in Part 1, Step 4 into the **Dataverse Environment URL** field.

* Format: `https://your-org.crm.dynamics.com`
* Do **not** include a trailing slash.
{% endstep %}

{% step %}
**Enter the Azure AD Tenant ID**

Paste the **Directory (tenant) ID** copied in Part 1, Step 1 into the **Azure AD Tenant ID** field.

* Format: `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`
{% endstep %}

{% step %}
**Enter the Azure AD App Client ID**

Paste the **Application (client) ID** copied in Part 1, Step 1 into the **Azure AD App Client ID** field.

* Format: `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`
{% endstep %}

{% step %}
**Enter the Azure AD App Client Secret**

Paste the client secret value you saved in Part 1, Step 2 into the **Azure AD App Client Secret** field.

{% hint style="info" %}
If you did not save the value when it was created, return to the Azure portal, generate a new secret in your app registration, and use the new value.
{% endhint %}
{% endstep %}

{% step %}
**Enter the Data Ingestion Service URL**

In the **URL for Data Ingestion Service** field, enter the base URL of your self-hosted Akto Data Ingestion Service.

* Format: `https://ingestion.your-domain.com`

{% hint style="warning" %}
* The ingestion service must be deployed and reachable from the connector.
* The endpoint receives every conversation pair captured from Copilot Studio.
{% endhint %}
{% endstep %}

{% step %}
**Complete the Integration**

1. Review all entered values.
2. Select **Import** to finalise the connection.

The connector runs immediately and then continues on a 5-minute recurring schedule. Conversations should begin appearing in your Akto dashboard within one or two cycles, provided transcripts exist in Dataverse for the polling window.
{% endstep %}
{% endstepper %}

## Data Collected

The Copilot Studio connector ingests two categories of information:

### Agent Inventory

* **Bot ID and display name** for every Copilot Studio agent in the environment
* **Published date** and current status

### Conversation Traffic

For each conversation transcript, the connector emits one record per **user message → bot response** pair:

| Field | Description |
| --- | --- |
| `path` | `/copilot/conversation/{transcript_id}/message/{index}` |
| `requestPayload` | JSON object containing the user's prompt text |
| `responsePayload` | JSON object containing the bot's response text |
| `host` | `copilot.microsoft.com` (the bot name is tagged separately) |
| `time` | Unix timestamp of the user message |
| `tag.source` | `COPILOT_STUDIO` |
| `tag.bot-name` | Sanitised bot display name |

Edge cases handled automatically:

* **Bot greetings** (no preceding user prompt) — emitted with an empty `requestPayload`.
* **Unanswered user prompts** — emitted with an empty `responsePayload`.
* **Multiple bot replies** — each paired with the most recent user message.

## Troubleshooting

### No Conversations Appearing in Akto

This is the most common issue. Work through the checks below in order:

1. **Environment type** — Confirm you are connected to a **Sandbox** or **Production** environment. Developer and Teams environments do not persist transcripts.
2. **Transcript saving enabled** — Verify the **"Allow conversation transcripts and their associated metadata to be saved in Dataverse"** setting is ON (see Prerequisites, item 2).
3. **Sync delay** — Transcripts can take up to 30 minutes to appear in Dataverse after a conversation ends. Have a test conversation and wait 30+ minutes before retesting.
4. **License** — Confirm a **paid** Copilot Studio license is assigned to the account that owns the agents.
5. **Transcripts visible in Power Apps** — Open [make.powerapps.com](https://make.powerapps.com), select your environment, go to **Tables** → search **Conversation Transcript** (see Microsoft's [download conversation transcripts guide](https://learn.microsoft.com/en-us/microsoft-copilot-studio/analytics-transcripts-powerapps)). If no rows appear there, the connector cannot ingest them either — fix the source first.

### Authentication Errors

**`401 Unauthorized`**

* Verify the **Azure AD App Client ID** and **Client Secret** are correct.
* Verify the secret has not expired. If it has, generate a new one and update the connector configuration.
* Confirm the **Tenant ID** matches the tenant where the app is registered.

**`403 Forbidden`**

* The Microsoft Entra app exists but has no permission inside Dataverse. Verify that a corresponding **Application user** exists in the Power Platform environment (Part 1, Step 3) and that it has a [security role](https://learn.microsoft.com/en-us/power-platform/admin/security-roles-privileges) granting read access on the `bot` and `conversationtranscript` tables.

### Connection Test Fails

* Verify the **Dataverse Environment URL** is correct and has no trailing slash.
* Confirm the URL is reachable from your network (or from the Akto-hosted connector).
* Verify there are no [Conditional Access](https://learn.microsoft.com/en-us/entra/identity/conditional-access/overview) or IP allow-list rules in Microsoft Entra ID blocking the service principal.

### Rate Limiting (`429 Too Many Requests`)

Dataverse enforces [service protection API limits](https://learn.microsoft.com/en-us/power-apps/developer/data-platform/api-limits) (6,000 requests per 5 minutes per user). The default 5-minute polling interval stays well within these limits. If you see `429` errors:

* Reduce concurrent connectors against the same environment.
* Contact Akto support to adjust the recurring interval.

## Security and Privacy

* **Credentials at rest** — The Microsoft Entra client secret is stored encrypted in Akto's secure configuration store and is never displayed back to the user after import.
* **Least privilege** — Akto recommends [creating a custom Dataverse security role](https://learn.microsoft.com/en-us/power-platform/admin/create-edit-security-role) with read-only access to the `bot` and `conversationtranscript` tables, rather than System Administrator.
* **Secret rotation** — Rotate the Microsoft Entra client secret per your organization's policy (see Microsoft's [credential management best practices](https://learn.microsoft.com/en-us/entra/identity-platform/howto-create-service-principal-portal#option-3-create-a-new-client-secret)). After rotating, return to the connector and re-import with the new value.
* **Network** — All Dataverse and ingestion traffic is sent over HTTPS.
* **Data residency** — Conversation transcripts remain in your Dataverse environment; Akto reads them via the Web API. Pairs are then forwarded to your self-hosted Akto Data Ingestion Service.

## Get Support

If you need assistance with the Copilot Studio connector:

* **In-app Chat** — Use the chat widget in your Akto dashboard for instant support.
* **Discord Community** — Join our community at [discord.gg/Wpc6xVME4s](https://discord.gg/Wpc6xVME4s).
* **Email Support** — Contact us at [help@akto.io](mailto:help@akto.io).
* **Contact Form** — Submit a support request at [https://www.akto.io/contact-us](https://www.akto.io/contact-us).

Our team is available 24/7 to help with setup, troubleshooting, and best practices.
