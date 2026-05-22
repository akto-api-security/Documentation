# Anthropic Connector

## Overview

The **Anthropic Connector** integrates Akto Atlas with Anthropic's **Compliance API** to give your security team real-time visibility into how employees interact with Claude across Claude.ai, Claude Console, and the Claude API.

Once connected, Akto continuously pulls your organization's activity data from Anthropic and surfaces it in your dashboard, so you can track who is using Claude, what files are being uploaded, which projects are active, and flag compliance-relevant events without deploying any endpoint agents.

## What Akto Ingests

Akto uses the Anthropic Compliance API's **Activity Feed** and **Objects APIs** to pull the following data:

| Data Category             | What Akto Discovers                                           |
| ------------------------- | ------------------------------------------------------------- |
| **Chat activity**         | Chats created, viewed, updated, or deleted by users           |
| **User & org management** | Invite accepted/rejected, user role changes, group membership |
| **MCP server events**     | MCP server additions, removals, and tool policy updates       |
| **Skills Activity**       | Skills created, replaced, or deleted                          |

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
  (Agentic AI Discovery, Security Posture)
```

Akto polls the Anthropic Compliance API at regular intervals using your **Compliance Access Key** (for Claude.ai). All ingested events appear in your Akto dashboard for investigation, alerting, and reporting.

## Prerequisites

Before setting up the connector, ensure:

* You have an **Akto Atlas** account with the Connectors section accessible
* Your Akto **Data Ingestion Service URL** is available (visible in your Akto instance settings)
* You have the appropriate Anthropic key for your product:

| Product       | Key Type              | Who Creates It                     |
| ------------- | --------------------- | ---------------------------------- |
| **Claude.ai** | Compliance Access Key | Primary Owner of the Claude.ai org |

{% hint style="info" %}
**Admin keys** (Claude Console) only grant access to the Activity Feed. They cannot access chat, file, or project content — those endpoints are exclusive to Claude.ai Compliance Access Keys.
{% endhint %}

## Create a Compliance Access Key in Anthropic

{% stepper %}
{% step %}
**Log into Claude.ai** as the **Primary Owner** of your organisation.
{% endstep %}

{% step %}
Go to **Organisation Settings → Data and Privacy**.

Verify that the **Compliance API** is enabled for your organisation. If not, enable it here.
{% endstep %}

{% step %}
Navigate to the **Compliance access keys** section.
{% endstep %}

{% step %}
Click **+ Create key**.

Name your key (e.g., `Akto Atlas Integration`) and select the scopes needed:

<table><thead><tr><th width="282.23046875">Scope</th><th>Required For</th></tr></thead><tbody><tr><td><code>read:compliance_activities</code></td><td>Activity feed (auth, chats, files, admin actions)</td></tr><tr><td><code>read:compliance_user_data</code></td><td>Reading chat messages, files, project content, org users</td></tr><tr><td><code>read:compliance_org_data</code></td><td>Reading org metadata, roles, groups</td></tr></tbody></table>
{% endstep %}

{% step %}
Copy and **securely store** the generated key, it is shown only once.
{% endstep %}
{% endstepper %}

{% hint style="warning" %}
Scopes are **immutable** once a key is created. If you need additional scopes later, you must create a new key.
{% endhint %}

## Connect in Akto Atlas

{% stepper %}
{% step %}
Open your **Akto Atlas** dashboard and navigate to **Connectors**.
{% endstep %}

{% step %}
Under **Platform connectors**, locate the **Anthropic** card and click **Connect**.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (113).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
In the **Set up guide** panel that opens on the right, fill in the following fields:

<table><thead><tr><th width="297.84375">Field</th><th>Value</th></tr></thead><tbody><tr><td><strong>API key</strong></td><td>Your Compliance Access Key (or Admin Key for Console/API)</td></tr><tr><td><strong>API base URL</strong> <em>(optional)</em></td><td>Leave as <code>https://api.anthropic.com</code> unless Anthropic has given you a custom endpoint for your tenant</td></tr><tr><td><strong>URL for Data Ingestion Service</strong></td><td>Your Akto instance's ingestion URL (e.g., <code>https://ingestion.your-akto.com</code>)</td></tr></tbody></table>
{% endstep %}

{% step %}
Click **Import** to save the configuration and start ingestion.

Akto will verify the key and begin pulling your organiasation's activity data.
{% endstep %}
{% endstepper %}

## What You'll See in Akto

Once connected, data from Anthropic flows into the following areas of your Akto Atlas dashboard:

* **Agentic AI Discovery → [Agentic Assets](../ai-agent-activity/agentic-assets/README.md)**: A **Claude Compliance** asset appears, representing all discovered Claude usage across your organisation
* **[Atlas Guardrails](../atlas-guardrails.md)**: Akto applies **asynchronous guardrails** to Claude Compliance data — after activity is pulled from the Anthropic Compliance API, Akto evaluates events against your configured security policies, flagging violations such as sensitive data in chat messages, unexpected file sharing, or anomalous access patterns, and surfaces them as alerts

## Troubleshooting

**Connector not importing data**

* Confirm the API key has **at least** the `read:compliance_activities` scope
* Verify the **Data Ingestion Service URL** is reachable from Akto's backend
* Check that the Compliance API is enabled in your Claude.ai org settings (Data and Privacy section)
* Admin keys from Claude Console only work for the Activity Feed — they will return 401 errors on all other endpoints

**Missing chat or file data**

* Chat and file content requires the `read:compliance_user_data` scope
* This data is only available via **Claude.ai Compliance Access Keys** - Admin keys cannot access it
* Confirm the user accounts generating the activity are members of the org tied to the key

**Key shows as invalid**

* The key may have been disabled or deleted in Claude.ai Compliance access keys settings
* Re-enable the key or create a new one and update the connector configuration in Akto

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `support@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
