---
description: Connect Akto with Microsoft Copilot Studio
---

# Microsoft Copilot Studio

## Overview

Microsoft Copilot Studio is a platform for building and deploying conversational AI agents and copilots. This setup is recommended if you want to monitor API traffic from your Copilot Studio applications and ensure your AI-powered conversations maintain security standards.

The Akto Copilot Studio connector automatically:

* Fetches all Copilot Studio conversation data
* Monitors bot interactions and user conversations
* Sends API traffic data to Akto for security analysis

## Steps to Connect

{% stepper %}
{% step %}
**Configure Akto Traffic Processor**

Set up and configure your Traffic Processor. The steps are mentioned [here](../others/hybrid-saas.md).
{% endstep %}

{% step %}
**Set Up Application Insights**

To monitor your Copilot Studio application, you need to configure Azure Application Insights:

1. **Create Application Insights Resource** (if not already created):
   * Follow the [Azure Application Insights documentation](https://learn.microsoft.com/en-us/azure/azure-monitor/app/create-workspace-resource) to create a new Application Insights resource
2. **Configure Your Copilot in Copilot Studio**:
   * Follow the [Copilot Studio Application Insights integration guide](https://learn.microsoft.com/en-us/microsoft-copilot-studio/advanced-bot-framework-composer-capture-telemetry) to connect your copilot to Application Insights
3. **Get Your Application Insights Credentials**:
   * Follow the [API Access documentation](https://learn.microsoft.com/en-us/azure/azure-monitor/app/api-filtering) to get your Application ID and create an API Key with "Read telemetry" permission
{% endstep %}

{% step %}
**Clone the Akto Infrastructure Repository**

Clone the Akto infrastructure repository:

```bash
wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/docker-compose-copilot-studio-cron.yaml

wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/copilot-studio-cron.env

wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/watchtower.env
```
{% endstep %}

{% step %}
**Configure Copilot Studio Environment Variables**

Update the following variables in the `copilot-cron.env` file:

```bash
APPINSIGHTS_APP_ID=<YOUR_APPLICATION_INSIGHTS_APP_ID>
APPINSIGHTS_API_KEY=<YOUR_APPLICATION_INSIGHTS_API_KEY>
AKTO_KAFKA_BROKER_URL=kafka1:19092
```
{% endstep %}

{% step %}
**Start the Copilot Studio Traffic Connector**

Run the following command to start the Copilot Studio traffic connector:

```bash
docker compose -f docker-compose-copilot-cron.yaml up
```

This will start monitoring your Copilot Studio conversations and send API traffic data to Akto for analysis.
{% endstep %}
{% endstepper %}

## What Data is Collected?

The Copilot Studio connector collects conversation data from your copilot applications:

### Conversation Data

* All bot conversations and user interactions
* User messages and bot responses
* Conversation topics and flows

### Metadata

* Conversation IDs and timestamps
* Channel information (Web Chat, Teams, etc.)
* Activity IDs for tracking message pairs

## How It Works

The connector uses Azure Application Insights to retrieve conversation telemetry:

1. **Data Source**: Application Insights stores all conversation events from your Copilot Studio bots using the Bot Framework
2. **Polling**: The connector polls Application Insights every 10 minutes (configurable) to fetch new conversation events
3. **Processing**: Events are paired (user message → bot response) to create complete conversation flows
4. **Publishing**: Processed data is sent to Akto's Kafka topic for security analysis

## Supported Channels

The connector works with all channels supported by Copilot Studio:

* Direct Line (Web Chat)
* Microsoft Teams
* Copilot Studio Test Chat
* Custom channels

All conversation sources are normalized by the Bot Framework before being logged to Application Insights.

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
