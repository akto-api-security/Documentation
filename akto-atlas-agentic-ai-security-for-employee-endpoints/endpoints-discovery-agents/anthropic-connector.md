# Anthropic Connector

## Overview

The **Anthropic Connector** integrates Akto Atlas with Anthropic's **Compliance API** to give your security team real-time visibility into how employees interact with Claude across Claude.ai, Claude Console, and the Claude API.

Once connected, Akto continuously pulls your organization's activity data from Anthropic and surfaces it in your dashboard — so you can track who is using Claude, what files are being uploaded, which projects are active, and flag compliance-relevant events without deploying any endpoint agents.

## What Akto Ingests

Akto uses the Anthropic Compliance API's **Activity Feed** and **Objects APIs** to pull the following data:

| Data Category | What Akto Discovers |
|---|---|
| **Authentication events** | SSO logins, magic link usage, session revocations |
| **Chat activity** | Chats created, viewed, updated, or deleted by users |
| **File operations** | Files uploaded to or deleted from Claude chats and projects |
| **Project activity** | Projects created, archived, shared, or deleted |
| **Admin actions** | API key creation, workspace changes, org setting updates |
| **User & org management** | Invite accepted/rejected, user role changes, group membership |
| **MCP server events** | MCP server additions, removals, and tool policy updates |
This data populates Akto's **Agentic AI Discovery** and **AI Security Posture** views, giving you an audit trail of Claude usage across your entire organization.

## How It Works

```
Anthropic Compliance API
        │
        │  Pull activity feed + objects data
        ▼
  Akto Connector
        │
        │  Stream to ingestion service
        ▼
  Akto Dashboard
  (Agentic AI Discovery, Security Posture, Audit Data)
```

Akto polls the Anthropic Compliance API at regular intervals using your **Compliance Access Key** (for Claude.ai) or **Admin Key** (for Claude Console / API). All ingested events appear in your Akto dashboard for investigation, alerting, and reporting.

## Prerequisites

Before setting up the connector, ensure:

- You have an **Akto Atlas** account with the Connectors section accessible
- Your Akto **Data Ingestion Service URL** is available (visible in your Akto instance settings)
- You have the appropriate Anthropic key for your product:

| Product | Key Type | Who Creates It |
|---|---|---|
| **Claude.ai** | Compliance Access Key | Primary Owner of the Claude.ai org |
| **Claude Console / API** | Admin Key | Organization admin in Claude Console |

{% hint style="info" %}
**Admin keys** (Claude Console) only grant access to the Activity Feed. They cannot access chat, file, or project content — those endpoints are exclusive to Claude.ai Compliance Access Keys.
{% endhint %}

## Step 1 — Create a Compliance Access Key in Anthropic

{% stepper %}
{% step %}
**Log into Claude.ai** as the **Primary Owner** of your organization.
{% endstep %}

{% step %}
Go to **Organization Settings → Data and Privacy**.

Verify that the **Compliance API** is enabled for your organization. If not, enable it here.
{% endstep %}

{% step %}
Navigate to the **Compliance access keys** section.
{% endstep %}

{% step %}
Click **+ Create key**.

Name your key (e.g., `Akto Atlas Integration`) and select the scopes needed:

| Scope | Required For |
|---|---|
| `read:compliance_activities` | Activity feed (auth, chats, files, admin actions) |
| `read:compliance_user_data` | Reading chat messages, files, project content, org users |
| `read:compliance_org_data` | Reading org metadata, roles, groups |
{% endstep %}

{% step %}
Copy and **securely store** the generated key — it is shown only once.
{% endstep %}
{% endstepper %}

{% hint style="warning" %}
Scopes are **immutable** once a key is created. If you need additional scopes later, you must create a new key.
{% endhint %}

## Step 2 — Connect in Akto Atlas

{% stepper %}
{% step %}
Open your **Akto Atlas** dashboard and navigate to **Connectors**.
{% endstep %}

{% step %}
Under **Platform connectors**, locate the **Anthropic** card and click **Connect**.
{% endstep %}

{% step %}
In the **Set up guide** panel that opens on the right, fill in the following fields:

| Field | Value |
|---|---|
| **API key** | Your Compliance Access Key (or Admin Key for Console/API) |
| **API base URL** *(optional)* | Leave as `https://api.anthropic.com` unless Anthropic has given you a custom endpoint for your tenant |
| **URL for Data Ingestion Service** | Your Akto instance's ingestion URL (e.g., `https://ingestion.your-akto.com`) |
{% endstep %}

{% step %}
Click **Import** to save the configuration and start ingestion.

Akto will verify the key and begin pulling your organization's activity data.
{% endstep %}
{% endstepper %}

## What You'll See in Akto

Once connected, data from Anthropic flows into the following areas of your Akto Atlas dashboard:

- **Agentic AI Discovery → Agentic Assets**: A **Claude Compliance** asset appears, representing all discovered Claude usage across your organization
- **AI Security Posture**: Risk signals derived from employee Claude usage patterns — for example, file uploads to personal chats, unusual access-failed events, or sharing of org projects externally

## Async Guardrails

Akto applies **asynchronous guardrails** to Claude Compliance data. After activity is pulled from the Anthropic Compliance API, Akto evaluates the events against your configured security policies — flagging violations such as sensitive data in chat messages, unexpected file sharing, or anomalous access patterns — and surfaces them as alerts in your dashboard. Because this runs asynchronously, it does not block or interrupt users' Claude interactions in real time.

## Troubleshooting

### Connector not importing data

- Confirm the API key has **at least** the `read:compliance_activities` scope
- Verify the **Data Ingestion Service URL** is reachable from Akto's backend
- Check that the Compliance API is enabled in your Claude.ai org settings (Data and Privacy section)
- Admin keys from Claude Console only work for the Activity Feed — they will return 401 errors on all other endpoints

### Missing chat or file data

- Chat and file content requires the `read:compliance_user_data` scope
- This data is only available via **Claude.ai Compliance Access Keys** — Admin keys cannot access it
- Confirm the user accounts generating the activity are members of the org tied to the key

### Key shows as invalid

- The key may have been disabled or deleted in Claude.ai Compliance access keys settings
- Re-enable the key or create a new one and update the connector configuration in Akto

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `support@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
