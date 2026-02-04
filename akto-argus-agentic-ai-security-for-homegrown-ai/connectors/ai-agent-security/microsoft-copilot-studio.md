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
### Configure Akto Traffic Processor <a href="#configure-akto-traffic-processor" id="configure-akto-traffic-processor"></a>

Set up and configure Akto Traffic Processor. The steps are mentioned [here](https://app.gitbook.com/o/D7iXZSH1dgJbIZmxvQ4m/s/tog5ODwYfqPOf4eQhsOC/~/diff/~/changes/65/akto-argus-agentic-ai-security-for-homegrown-ai/connectors/others/hybrid-saas).
{% endstep %}

{% step %}
### Open the Copilot Studio Connector in Akto Argus

1. Navigate to **Akto Argus**.
2. Open **Connectors**.
3. Under **AI Agent Security**, locate the **Microsoft Copilot Studio** connector card.
4.  Select **Connect** to open setup dialog box.

    <div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (3).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
### Enter the Dataverse Environment URL

Enter the Dataverse environment URL used by your Copilot Studio instance in the **Dataverse Environment URL** field.

* The URL follows the format:\
  `https://<org>.crm.dynamics.com`
* The value can be obtained from:
  * The browser address bar when accessing the Dataverse environment, or
  * The **Power Platform Admin Center → Environments → Environment details** page.

This value allows Akto Argus to associate ingested telemetry with the correct Copilot Studio environment.

{% hint style="info" %}
**Official reference:** [Microsoft Dataverse environment overview in Power Platform documentation](https://learn.microsoft.com/power-platform/admin/environments-overview).
{% endhint %}
{% endstep %}

{% step %}
### Enter the Azure AD Tenant ID

Enter the **Azure AD Tenant ID** associated with the Copilot Studio deployment.

* The Tenant ID can be obtained from:
  * **Azure Portal → Microsoft Entra ID (Azure AD) → Overview → Tenant ID**
* The value is a GUID.

This identifier scopes authentication to the correct Microsoft Entra tenant.

{% hint style="info" %}
**Official reference:** [Microsoft Entra ID tenant identification documentation](https://learn.microsoft.com/entra/fundamentals/how-to-find-tenant).
{% endhint %}
{% endstep %}

{% step %}
### Enter the Azure AD App Client ID

Enter the **Application (Client) ID** of the Azure AD app registration used for this integration.

* The Client ID can be obtained from:
  * **Azure Portal → Microsoft Entra ID → App registrations → Your app → Overview → Application (client) ID**
* The app registration should be configured with permissions to access Dataverse and Application Insights data.

This value identifies the application Akto Argus uses to authenticate with Microsoft services.

{% hint style="info" %}
**Official reference:** [Azure AD app registration documentation.](https://learn.microsoft.com/entra/identity-platform/quickstart-register-app)
{% endhint %}
{% endstep %}

{% step %}
### Enter the Azure AD App Client Secret

Enter the **Client Secret** associated with the same Azure AD app registration.

* The Client Secret can be generated from:
  * **Azure Portal → Microsoft Entra ID → App registrations → Your app → Certificates & secrets**
* Copy the secret value at creation time. The value is not retrievable later.

This credential enables secure, non-interactive authentication.

{% hint style="info" %}
**Official reference:** [Azure AD client secret management documentation.](https://learn.microsoft.com/entra/identity-platform/howto-add-app-credentials)
{% endhint %}
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

1. Review all entered values.
2. Select **Import** to finalize the connection.
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
