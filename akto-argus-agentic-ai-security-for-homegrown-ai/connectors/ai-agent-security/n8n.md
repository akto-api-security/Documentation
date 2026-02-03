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
### Configure Akto Traffic Processor

Set up and configure Akto Traffic Processor. The steps are mentioned [here](../others/hybrid-saas.md).
{% endstep %}

{% step %}
### Clone the Akto Infrastructure Repository

Clone the Akto infrastructure repository and checkout the feature branch:

```bash
wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/docker-compose-n8n-cron.yaml

wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/n8n-cron.env

wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/watchtower.env
```
{% endstep %}

{% step %}
### Configure N8N Environment Variables

Update the following variables in the `n8n-cron.env` file:

```bash
N8N_BASE_URL=https://<YOUR_INSTANCE_URL>
N8N_API_KEY=<API_KEY>
AKTO_KAFKA_BROKER_URL=kafka1:19092
```
{% endstep %}

{% step %}
### Start the N8N Traffic Connector

Run the following command to start the N8N traffic connector:

```bash
docker compose -f docker-compose-n8n-cron.yaml up
```

This will start monitoring your N8N workflows and send API traffic data to Akto for analysis.
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
