---
hidden: true
---

# Databricks

## Overview

The Akto Databricks connector enables you to **import Databricks agents seamlessly into Akto Argus**, providing comprehensive security monitoring for your AI agents, workflows, and API interactions running on the Databricks platform.&#x20;

This integration automatically discovers agents using Databricks' Unity Catalog and sends their traffic data to Akto for real-time security analysis.

{% hint style="success" %}
## Connector Access Scope

The Databricks connector automatically:

* **Discovers AI Agents**: Fetches all AI agents and workflows configured in your Databricks workspace through Unity Catalog
* **Monitors Execution Data**: Captures agent execution traces, including inputs, outputs, and API interactions
* **Analyzes Traffic**: Sends API traffic data to Akto for comprehensive security analysis, including:
  * Prompt injection detection
  * Sensitive data exposure
  * Policy violations
  * Runtime threat detection
* **Unified Security View**: Provides a centralized dashboard view of all Databricks agents alongside your other AI infrastructure
{% endhint %}

## Prerequisites

Before setting up the Databricks connector, ensure you have:

1. **Akto Traffic Processor Configured** - The Akto Traffic Processor must be set up first. Follow the [Hybrid SaaS Setup Guide](../others/hybrid-saas.md) for instructions.
2. **Databricks Workspace** - An active Databricks workspace with Unity Catalog enabled
3. **Service Principal** - A Databricks Service Principal with appropriate permissions:
   * `USE CATALOG` permission on the target Unity Catalog
   * `USE SCHEMA` permission on the target schema
   * `SELECT` permission on agent-related tables
   * Access to read workspace configurations
4. **Network Access** - The connector service must have network access to:
   * Your Databricks workspace URL
   * Akto Data Ingestion Service endpoint
   * Kafka broker (configured in Traffic Processor)

## Setup Instructions

{% stepper %}
{% step %}
### Create Databricks Service Principal

* Navigate to your Databricks workspace
* Go to **Settings** > **Identity and Access**
* Select **Service Principals** and click **Add Service Principal**
* Note the **Application (Client) ID** - you'll need this for configuration
* Generate a **Client Secret** and save it securely
*   Assign the necessary permissions to the Service Principal:

    ```sql
    -- Grant catalog access
    GRANT USE CATALOG ON CATALOG <your_catalog> TO `<service_principal_id>`;

    -- Grant schema access
    GRANT USE SCHEMA ON SCHEMA <your_catalog>.<your_schema> TO `<service_principal_id>`;

    -- Grant read access to tables
    GRANT SELECT ON SCHEMA <your_catalog>.<your_schema> TO `<service_principal_id>`;
    ```
{% endstep %}

{% step %}
### Configuration from Akto Dashboard

1. Navigate to **Quick Start** > **AI Agent Connectors**
2. Select **Databricks** from the connector list
3. Fill in the configuration form:
   * **Databricks Host**: Your workspace URL
   * **Client ID**: Service Principal ID
   * **Client Secret**: Service Principal secret
   * **Unity Catalog**: Catalog name (default: "workspace")
   * **Schema**: Schema name (default: "default")
   * **Table Prefix**: Optional prefix for filtering
   * **Data Ingestion URL**: Your Akto ingestion service endpoint
4. Set the **Recurring Interval** (default: 5 minutes)
5.  Click **Import** to activate the connector

    <figure><img src="../../../.gitbook/assets/image (4).png" alt="" width="563"><figcaption></figcaption></figure>

The connector binary (`databricks-shield`) will be automatically deployed and configured.
{% endstep %}

{% step %}
### Verify in Akto Dashboard

1. Log in to your Akto dashboard
2. Navigate to **Akto Argus** > **Connectors**
3. You should see the Databricks connector listed with status "Active"
4. Check **Agents** section to view discovered Databricks agents
5. Monitor the **Traffic** tab for incoming data from Databricks agents
{% endstep %}
{% endstepper %}

## Data Collection

### Agent Metadata Captured

The connector automatically fetches:

* **Agent Configurations**: All AI agents and workflows defined in Unity Catalog
* **Model Information**: LLM models and versions being used
* **Execution History**: Recent agent runs and their outcomes
* **Catalog Structure**: Unity Catalog tables, schemas, and metadata related to AI workloads

### Execution Data Collected

For each agent execution, the connector captures:

* **Input Data**: Prompts, queries, and parameters sent to agents
* **Output Data**: Agent responses and generated content
* **API Calls**: External API interactions made by agents
* **Timing Information**: Execution duration and timestamps
* **Error Logs**: Failures, exceptions, and error messages

### Data Retention

* Execution data from the past **60 minutes** is captured in each polling cycle
* Historical analysis is available in the Akto dashboard
* Sensitive data is automatically detected and can be masked based on your guardrail policies

## Troubleshooting

### Connection Issues

**Problem**: "Failed to connect to Databricks workspace"

**Solutions**:

* Verify your `DATABRICKS_HOST` URL is correct and accessible
* Ensure Service Principal credentials are valid
* Check network connectivity from the connector service to Databricks
* Verify firewall rules allow outbound HTTPS connections

### Authentication Errors

**Problem**: "Authentication failed" or "Invalid client credentials"

**Solutions**:

* Double-check `DATABRICKS_CLIENT_ID` and `DATABRICKS_CLIENT_SECRET`
* Ensure the Service Principal exists and is not disabled
* Verify the secret has not expired
* Regenerate credentials if necessary

### Permission Denied

**Problem**: "Access denied to catalog/schema"

**Solutions**:

*   Verify Service Principal has required permissions:

    ```sql
    SHOW GRANTS ON CATALOG <catalog_name>;
    SHOW GRANTS ON SCHEMA <catalog_name>.<schema_name>;
    ```
* Grant missing permissions as shown in Step 1
* Ensure Unity Catalog is enabled in your workspace

### No Data Appearing

**Problem**: Connector is running but no agents appear in Akto

**Solutions**:

* Verify agents exist in the specified Unity Catalog and schema
* Check `DATABRICKS_PREFIX` is not filtering out all tables
* Ensure `DATA_INGESTION_SERVICE_URL` and `KAFKA_BROKER_HOST` are correct
*   Review connector logs for errors:

    ```bash
    docker compose -f docker-compose-databricks-cron.yaml logs -f
    ```
* Verify Traffic Processor is running and accessible

### Performance Issues

**Problem**: Connector is slow or timing out

**Solutions**:

* Increase `RECURRING_INTERVAL_SECONDS` if polling too frequently
* Check network latency between connector and Databricks
* Verify Databricks workspace has sufficient compute resources
* Consider using `DATABRICKS_PREFIX` to filter tables if catalog is very large

## Support

If you need help with the Databricks connector:

* **In-app Chat**: Use the chat widget in your Akto dashboard for instant support
* **Discord Community**: Join our community at [discord.gg/Wpc6xVME4s](https://discord.gg/Wpc6xVME4s)
* **Email Support**: Contact us at help@akto.io
* **Contact Form**: Submit a support request at [akto.io/contact](https://www.akto.io/contact)

Our team is available 24/7 to assist you with setup, troubleshooting, and best practices.
