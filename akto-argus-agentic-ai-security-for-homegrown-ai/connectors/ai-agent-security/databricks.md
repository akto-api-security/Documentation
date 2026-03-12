# Databricks

## Overview

Databricks is a unified analytics platform built on Apache Spark that enables data teams to collaborate on data engineering, machine learning, and analytics workloads. Connect Akto Argus to your Databricks workspace to discover agents and workflows defined in Unity Catalog and fetch related execution data.

The visibility helps you identify agentic workloads running in Databricks and assess associated security risks. Once connected, Akto Argus automatically:

* **Discovers AI Agents**: Fetches all AI agents and workflows configured in your Databricks workspace through Unity Catalog
* **Monitors Agent Activity**: Captures agent execution traces, including inputs, outputs, and API interactions
* **Sends Traffic to Akto**: Transmits API traffic data to Akto for comprehensive security analysis

## Prerequisites

Before setting up the Databricks connector, ensure you have completed the following:

1. **Traffic Processor** – Configure your Traffic Processor first. Follow the [Hybrid SaaS Setup Guide](../others/hybrid-saas.md) for detailed instructions.
2. **Databricks Workspace** – An active Databricks workspace with Unity Catalog enabled
3. **Service Principal** – A Databricks Service Principal with appropriate permissions:
   * `USE CATALOG` permission on the target Unity Catalog
   * `USE SCHEMA` permission on the target schema
   * `SELECT` permission on agent-related tables
4. **Network Access** – Ensure connectivity between the connector service and:
   * Your Databricks workspace URL
   * Akto Data Ingestion Service

## Steps to Connect

{% stepper %}
{% step %}
**Open the Databricks Connector in Akto Argus**

1. Navigate to **Akto Argus**.
2. Open **Connectors**.
3. Under **AI Agent Security**, locate the **Databricks** connector card.
4. Select **Connect** to open the setup dialog.
{% endstep %}

{% step %}
**Enter the Databricks Host**

Enter the base URL of your Databricks workspace in the **Databricks Host** field.

* Format: `https://your-workspace.cloud.databricks.com`
* The value can be found in the browser address bar when accessing your Databricks workspace.
{% endstep %}

{% step %}
**Enter the Service Principal Credentials**

Create a Databricks Service Principal and enter its credentials:

1. In your Databricks workspace, go to **Settings** > **Identity and Access** > **Service Principals**.
2. Click **Add Service Principal**, then note the **Application (Client) ID**.
3. Generate a **Client Secret** and save it securely.
4.  Grant the Service Principal the required permissions:

    ```sql
    -- Grant catalog access
    GRANT USE CATALOG ON CATALOG <your_catalog> TO `<service_principal_id>`;

    -- Grant schema access
    GRANT USE SCHEMA ON SCHEMA <your_catalog>.<your_schema> TO `<service_principal_id>`;

    -- Grant read access to tables
    GRANT SELECT ON SCHEMA <your_catalog>.<your_schema> TO `<service_principal_id>`;
    ```
5. Enter the **Application (Client) ID** in the **Databricks Client ID (Service Principal)** field.
6. Enter the generated secret in the **Databricks Client Secret** field.
{% endstep %}

{% step %}
**Specify the Unity Catalog Name and Schema**

Enter the Unity Catalog and schema that contain your agent definitions:

* **Unity Catalog Name** – The name of the Unity Catalog to query (default: `workspace`).
* **Unity Catalog Schema** – The schema within the catalog (default: `default`).

These fields control which catalog and schema Akto Argus queries for agent discovery.
{% endstep %}

{% step %}
**Specify a Table Prefix (Optional)**

Optionally enter a value in the **Table Prefix (Optional)** field to scope agent discovery to tables matching a specific prefix.

* Leave this field empty to discover all agents in the specified catalog and schema.
* Use a prefix (e.g., `production_`) to limit discovery to tables starting with that value.
{% endstep %}

{% step %}
**Enter the Data Ingestion Service URL**

Enter the URL of your **self-hosted data ingestion service** in the **URL for Data Ingestion Service** field in order to forward agent execution and telemetry data into your environment for processing.

{% hint style="warning" %}
#### Note

* The ingestion service must be deployed and exposed in your infrastructure.
* The URL must be reachable from Akto.
* The endpoint receives metadata collected by Akto for this connector.
{% endhint %}
{% endstep %}

{% step %}
**Complete the Integration**

1. Review all entered values.
2. Select **Import** to finalise the connection.
{% endstep %}
{% endstepper %}

## Data Collection

The Databricks connector captures two categories of information:

### Agent Metadata

* **Agent Configurations**: All AI agents and workflows defined in Unity Catalog
* **Model Information**: LLM models and versions being used
* **Catalog Structure**: Unity Catalog tables, schemas, and metadata related to AI workloads

### Agent Execution Data

* **Recent Activity**: Agent executions from the past 60 minutes
* **Input Data**: Prompts, queries, and parameters sent to agents
* **Output Data**: Agent responses and generated content
* **API Interactions**: External API calls made by agents
* **Timing Information**: Execution duration and timestamps
* **Error Logs**: Failures, exceptions, and error messages

## Troubleshooting

### Connection Issues

**Problem**: Cannot connect to Databricks workspace

**Solutions**:

* Verify the **Databricks Host** URL is correct and accessible
* Ensure Service Principal credentials are valid and not expired
* Check network connectivity from the connector service to Databricks
* Verify firewall rules allow outbound HTTPS connections

### Authentication Errors

**Problem**: "Authentication failed" or "Invalid client credentials"

**Solutions**:

* Double-check **Databricks Client ID (Service Principal)** and **Databricks Client Secret**
* Ensure the Service Principal exists and is not disabled
* Verify the secret has not expired; regenerate credentials if necessary

### Permission Issues

**Problem**: Access denied to catalog or schema

**Solutions**:

*   Verify the Service Principal has the required permissions:

    ```sql
    SHOW GRANTS ON CATALOG <catalog_name>;
    SHOW GRANTS ON SCHEMA <catalog_name>.<schema_name>;
    ```
* Grant any missing permissions as described in the setup steps above
* Ensure Unity Catalog is enabled in your workspace

### No Agents Appearing

**Problem**: Connector is running but no agents appear in Akto

**Solutions**:

* Verify agents exist in the specified **Unity Catalog Name** and **Unity Catalog Schema**
* Check that **Table Prefix (Optional)** is not filtering out all tables
* Ensure the **URL for Data Ingestion Service** is correct and reachable
* Verify the Traffic Processor is running and accessible

## Get Support

If you need assistance with the Databricks connector:

* **In-app Chat**: Use the chat widget in your Akto dashboard for instant support
* **Discord Community**: Join our community at [discord.gg/Wpc6xVME4s](https://discord.gg/Wpc6xVME4s)
* **Email Support**: Contact us at [help@akto.io](mailto:help@akto.io)
* **Contact Form**: Submit a support request at [https://www.akto.io/contact-us](https://www.akto.io/contact-us)

Our team is available 24/7 to help with setup, troubleshooting, and best practices.
