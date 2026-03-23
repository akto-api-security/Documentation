---
description: Connect Akto with Salesforce AgentForce
---

# Salesforce

## Overview

Salesforce AgentForce is a platform for building and managing AI agents within Salesforce. This setup is recommended if you want to monitor conversation data from your Salesforce agents and ensure your AI-powered processes maintain security standards.

The Akto Salesforce connector automatically:

* Imports all Salesforce agents and AI capabilities
* Monitors agent executions and interactions
* Sends traffic data to Akto for security analysis

## Steps to Connect

{% stepper %}
{% step %}
#### Enable AgentForce in Salesforce

1. Log in to your Salesforce account with administrator privileges
2. Navigate to **Setup** > **Feature Activation**
3. Enable **AgentForce** for your organization
4. Ensure your Salesforce org has the necessary AgentForce licenses activated
{% endstep %}

{% step %}
#### Create a Connected App

1. In Salesforce, go to **Setup** > **Apps** > **App Manager**
2. Click **New Connected App**
3. Fill in the following details:
   * **Connected App Name**: Akto Salesforce Connector
   * **API Name**: AktoSalesforceConnector
   * **Contact Email**: Your email address
4. Under **API (Enable OAuth Settings)**:
   * Check **Enable OAuth Settings**
5. Under **Selected OAuth Scopes**, add:
   * `api`
6. Click **Save**
{% endstep %}

{% step %}
#### Retrieve Credentials

1. In the Connected App details, locate:
   * **Consumer Key**: Copy this value
   * **Consumer Secret**: Click to reveal and copy this value
2. Keep these credentials safe; you'll need them for Akto configuration
{% endstep %}

{% step %}
#### Configure Akto Connector

In Akto, provide the following information:

* **Salesforce URL**: Your Salesforce instance URL (e.g., `https://your-domain.my.salesforce.com`)
* **Consumer Key**: OAuth 2.0 Consumer Key from your Connected App
* **Consumer Secret**: OAuth 2.0 Consumer Secret from your Connected App
* **URL for Data Ingestion Service**: Your Akto data ingestion service endpoint
* **Ingestion API Key**: Your Akto ingestion API key
{% endstep %}

{% step %}
#### Authorize the Connection

1. Click **Connect** in Akto
2. You will be redirected to Salesforce for authorization
3. Log in with your Salesforce credentials
4. Grant permissions to the Akto Connected App
5. You'll be redirected back to Akto upon successful authorization
{% endstep %}
{% endstepper %}

## What Data is Collected?

The Salesforce connector collects execution data from your Salesforce agents:

### Agent Metadata

* All Salesforce agents and their configurations
* Agent execution metadata

### Execution Data

* Agent interactions and conversations
* Input and output data from agent executions

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact [<!--email_off-->support@akto.io<!--/email_off-->](mailto:<!--email_off-->support@akto.io<!--/email_off-->) for email support.
4. Contact us [here](https://www.akto.io/contact-us).
