---
description: Connect Akto with LangChain
---

# LangChain

## Overview

LangChain is a framework for developing applications powered by language models. This setup is recommended if you want to monitor Agent traffic from your LangChain applications and ensure your AI-powered processes maintain security standards.

The Akto LangChain connector automatically:

* Fetches all LangChain application metadata
* Monitors LangChain executions
* Sends API traffic data to Akto for security analysis

## Steps to Connect

{% stepper %}
{% step %}
### Configure Akto Traffic Processor <a href="#configure-akto-traffic-processor" id="configure-akto-traffic-processor"></a>

Set up and configure Akto Traffic Processor. The steps are mentioned [here](https://app.gitbook.com/o/D7iXZSH1dgJbIZmxvQ4m/s/tog5ODwYfqPOf4eQhsOC/~/diff/~/changes/65/akto-argus-agentic-ai-security-for-homegrown-ai/connectors/others/hybrid-saas).
{% endstep %}

{% step %}
### Open the Langchain Connector in Akto Argus

1. Navigate to **Akto Argus**.
2. Open **Connectors**.
3. Under **AI Agent Security**, locate the **LangChain** connector card.
4.  Select **Connect** to open the langchain dialog.

    <div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (1) (1).png" alt="" width="375"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
### Enter the LangSmith Base URL

Provide the base URL for the LangSmith API in the **LangSmith Base URL** field.
{% endstep %}

{% step %}
### Enter the LangSmith API Key

Provide a valid LangSmith API key in the **LangSmith API Key** field.

Follow the steps to generate the API keys:

* Log in to LangSmith (`smith.langchain.com`).
* Go to **Settings → API Keys**.
* Create a new API key and copy it.
* Enter this key into **LangSmith API Key**.
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
2. Select **Import** to finalise the connection.


{% endstep %}
{% endstepper %}

## What Data is Collected?

The LangChain connector collects execution data from your LangChain applications:

### Application Metadata

* All LangChain applications and traces

### Execution Data

* Recent execution traces
* Input and output data

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
