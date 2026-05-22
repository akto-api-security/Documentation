# OpenAI Connector

## Overview

The **OpenAI Connector** integrates Akto Atlas with OpenAI's **Admin API** to give your security team real-time visibility into how employees interact with ChatGPT and OpenAI models across your organisation.

Once connected, Akto continuously pulls your organisation's activity data from OpenAI and surfaces it in your dashboard, so you can track who is using ChatGPT, what projects are active, and flag compliance-relevant events without deploying any endpoint agents.

## What Akto Ingests

Akto uses the OpenAI Admin API's **Audit Logs** and **Organization APIs** to pull the following data:

| Data Category             | What Akto Discovers                                           |
| ------------------------- | ------------------------------------------------------------- |
| **Chat activity**         | Chats created, viewed, updated, or deleted by users           |
| **User & org management** | Invite accepted/rejected, user role changes, group membership |
| **MCP server events**     | MCP server additions, removals, and tool policy updates       |
| **Skills Activity**       | Skills created, replaced, or deleted                          |

## How It Works

```
OpenAI Admin API
        │
        │  Pull audit logs + org data
        ▼
  Akto Connector
        │
        │  Stream to ingestion service
        ▼
  Akto Dashboard
  (Agentic AI Discovery)
```

Akto polls the OpenAI Admin API at regular intervals using your **Admin API key**. All ingested events appear in your Akto dashboard for investigation, alerting, and reporting.

## Prerequisites

Before setting up the connector, ensure:

* You have an **Akto Atlas** account with the Connectors section accessible
* Your Akto **Data Ingestion Service URL** is available (visible in your Akto instance settings)
* You have an OpenAI **Admin API key** — these are created by an Owner of the OpenAI organisation.

{% hint style="info" %}
Admin API keys are available to **ChatGPT Enterprise** and **OpenAI API** organisations. You must be an Owner of the organisation to create one.
{% endhint %}

## Setup

{% stepper %}
{% step %}
**Create an Admin API key in OpenAI**

In the OpenAI Platform, go to **Settings → Organisation → Admin keys** and create a new key. Copy and securely store it — it is shown only once.
{% endstep %}

{% step %}
Open your **Akto Atlas** dashboard and navigate to **Connectors**.
{% endstep %}

{% step %}
Under **Platform connectors**, locate the **OpenAI** card and click **Connect**.
{% endstep %}

{% step %}
In the **Set up guide** panel that opens on the right, fill in the following fields:

| Field | Value |
|---|---|
| **API key** | Your OpenAI Admin API key |
| **API base URL** *(optional)* | Leave as `https://api.openai.com` unless you are using a custom or Azure-hosted endpoint |
| **URL for Data Ingestion Service** | Your Akto instance's ingestion URL (e.g., `https://ingestion.your-akto.com`) |
{% endstep %}

{% step %}
Click **Import** to save the configuration and start ingestion.

Akto will verify the key and begin pulling your organisation's activity data.
{% endstep %}
{% endstepper %}

## What You'll See in Akto

Once connected, data from OpenAI flows into the following areas of your Akto Atlas dashboard:

* **Agentic AI Discovery → [Agentic Assets](../ai-agent-activity/agentic-assets/README.md)**: A **ChatGPT Compliance** asset appears, representing all discovered OpenAI usage across your organisation
* **[Atlas Guardrails](../atlas-guardrails.md)**: Akto applies **asynchronous guardrails** to ChatGPT Compliance data — after activity is pulled from the OpenAI Admin API, Akto evaluates events against your configured security policies, flagging violations such as sensitive data in conversations, unexpected API key creation, or anomalous access patterns, and surfaces them as alerts

## Troubleshooting

**Connector not importing data**

* Confirm the Admin API key belongs to an **Owner** of the OpenAI organisation
* Verify the **Data Ingestion Service URL** is reachable from Akto's backend
* Ensure the key has not expired — OpenAI Admin keys can be created with an expiry date

**Missing conversation or user data**

* Audit log access requires a **ChatGPT Enterprise** subscription
* Confirm the users generating activity are members of the organisation tied to the Admin key

**Key shows as invalid**

* The key may have expired or been revoked in OpenAI Platform settings
* Create a new Admin key and update the connector configuration in Akto

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `support@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
