# Deploy via SentinelOne

## Overview

SentinelOne provides centralized visibility and management for enterprise endpoints.\
Akto integrates with SentinelOne to help security teams discover AI coding tools and deploy guardrails on managed devices.

With this integration, you can:

* Discover AI agents and AI coding tools running on SentinelOne-managed endpoints
* Configure and deploy guardrails for selected devices directly from Akto

## Prerequisites

Before connecting SentinelOne to Akto, ensure the following:

* **SentinelOne admin account access** (required to generate and use API token)
* **SentinelOne Console URL** (typically in the format `https://<your-tenant>.sentinelone.net`)
* **SentinelOne API Token**
* **Akto Data Ingestion Service URL** (`AKTO_DATA_INGESTION_URL`)

{% hint style="info" %}
Your SentinelOne account should have sufficient permissions to access endpoint inventory and run integration actions for your organization.
{% endhint %}

## Steps to Integrate

The integration flow has two stages:

1. Connect SentinelOne in Akto to discover AI agents on managed endpoints
2. Configure and run guardrails on selected devices

{% stepper %}
{% step %}
**Connect SentinelOne to Akto**

1. Open **Akto ATLAS Dashboard**.
2. Go to Connectors.
3. Go to **Endpoint Management**.
4.  Select **SentinelOne** and click **Connect**.

    <div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (5).png" alt="" width="563"><figcaption></figcaption></figure></div>
5. Fill in the following fields:

* **SentinelOne Console URL**: `https://<your-tenant>.sentinelone.net`
* **API Token**: SentinelOne admin API token
* **Data Ingestion Service URL**: your Akto ingestion endpoint (`AKTO_DATA_INGESTION_URL`)
*   **Polling Interval (seconds)**: keep default or set based on your monitoring preference

    <div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (1) (1).png" alt="" width="375"><figcaption></figcaption></figure></div>

6. Click **Save**.

After saving, Akto starts discovering AI coding tools and related agent activity from SentinelOne-managed endpoints.
{% endstep %}

{% step %}
**Discover AI Agents on Managed Endpoints**

Once integration is active, Akto uses SentinelOne endpoint telemetry to identify AI tooling usage (for example Cursor, Claude , and other supported agent clients) on managed devices.

You can then:

* Review discovered endpoints in Akto
* Select target devices for guardrail deployment
* Continue monitoring newly discovered devices as polling runs
{% endstep %}

{% step %}
**Configure and Run Guardrails**

1. Open the SentinelOne integration setup in Akto.
2. In **Guardrails Installation**, choose the guardrails you want to deploy.
3. Select specific devices, or use **Run on all devices**.
4.  Click **Save & Run Guardrails**.

    <div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (2) (1).png" alt="" width="375"><figcaption></figcaption></figure></div>

**Cursor Guardrails**

Enable **Cursor IDE Hooks** to install Akto guardrail hooks for Cursor IDE on selected SentinelOne-managed devices.

`AKTO_DATA_INGESTION_URL` is used as the default ingestion destination.

**Claude CLI Guardrails**

Enable **Claude CLI Hooks** to monitor and secure Claude CLI assistant usage on selected devices.

`AKTO_DATA_INGESTION_URL` is used as the default ingestion destination.

**OpenClaw Guardrails**

Enable **OpenClaw Guardrails** to install MCP Endpoint Shield guardrails for OpenClaw (Clawdbot).

OpenClaw requires additional model/runtime fields in the setup form, such as:

* **API Key** (provider key used by your selected model provider)
* **Original Provider**
* **Model ID**

You can use providers beyond OpenAI, including Anthropic , Gemini model setups, as long as valid provider and model values are configured.

{% hint style="info" %}
For guardrails that require additional environment values, Akto displays the required input fields dynamically in the setup panel.
{% endhint %}
{% endstep %}
{% endstepper %}

## Operational Notes

* Use a SentinelOne account with admin-level API access for reliable integration setup.
* Use a valid `AKTO_DATA_INGESTION_URL` that is reachable from managed endpoints.
* Polling interval controls how frequently Akto refreshes endpoint discovery data.
* Guardrails can be deployed to selected devices or across all managed devices.

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `support@akto.io` for email support.
