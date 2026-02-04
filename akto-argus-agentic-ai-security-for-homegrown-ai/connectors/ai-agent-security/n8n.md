---
description: Connect Akto with N8N
---

# N8N

## Overview

N8N is a workflow automation platform that connects various services and automates tasks. This setup is recommended if you want to monitor API traffic from your N8N workflows and ensure your automated processes maintain security standards.

The Akto N8N connector automatically:

* Fetches all workflow metadata from your N8N instance
* Monitors workflow executions
* Sends API traffic data to Akto for security analysis

## Steps to Connect

{% stepper %}
{% step %}
### Configure Akto Traffic Processor <a href="#configure-akto-traffic-processor" id="configure-akto-traffic-processor"></a>

Set up and configure Akto Traffic Processor. The steps are mentioned [here](https://app.gitbook.com/o/D7iXZSH1dgJbIZmxvQ4m/s/tog5ODwYfqPOf4eQhsOC/~/diff/~/changes/65/akto-argus-agentic-ai-security-for-homegrown-ai/connectors/others/hybrid-saas).
{% endstep %}

{% step %}
### Open the N8N Connector in Akto Argus

1. Navigate to **Akto Argus**.
2. Open **Connectors**.
3. Under **AI Agent Security**, locate the **N8N** connector card.
4.  Select **Connect** to open the N8N dialog.

    <div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (10).png" alt="" width="375"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
### Enter the N8N Instance URL

* This is the base URL of your N8N deployment.
* For N8N Cloud, this is shown after login (e.g., `https://<workspace>.n8n.cloud`).
* For self-hosted N8N, use your instance’s public hostname/IP.
{% endstep %}

{% step %}
### Enter the N8N API Key

* In N8N, open **Settings → n8n API**.
* Create a new API key, assign a label, set expiration, and copy the key.
* Enter the copied key into the **N8N API Key** field.
{% endstep %}

{% step %}
### Enter the Data Ingestion Service URL

Enter the URL of your **self-hosted data ingestion service** in the **URL for Data Ingestion Service** field in order to forward agent execution and telemetry data into your environment for processing.

{% hint style="warning" %}
## Note

* The ingestion service must be deployed and exposed in your infrastructure.
* The URL must be reachable from Akto.
* The endpoint receives metadata collected by Akto for this connector.
{% endhint %}
{% endstep %}

{% step %}
### Complete the Integration

After all fields are populated:

1. Review the configuration details.
2. Select **Import** to finalize the connection.
{% endstep %}
{% endstepper %}

## What Data is Collected?

The N8N connector collects two types of data:

### Workflow Metadata

* All workflows from your N8N instance
* Webhook URLs (if configured in workflow)

### Workflow Executions

* Executions from the last hour
* First node input data
* Last node output data

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
