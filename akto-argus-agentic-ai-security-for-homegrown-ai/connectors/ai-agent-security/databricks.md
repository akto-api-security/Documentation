# Databricks Connector

## Overview

Databricks is a unified analytics platform built on Apache Spark that enables data teams to collaborate on data engineering, machine learning, and analytics workloads. With the rise of AI agents and LLM-powered applications built on Databricks, organizations need visibility into the security posture of their AI infrastructure.

The Akto Databricks connector enables you to **import Databricks agents seamlessly into Akto Argus**, providing comprehensive security monitoring for your AI agents, workflows, and API interactions running on the Databricks platform. This integration automatically discovers agents using Databricks' Unity Catalog and sends their traffic data to Akto for real-time security analysis.

## What the Connector Does

The Databricks connector automatically:

- **Discovers AI Agents**: Fetches all AI agents and workflows configured in your Databricks workspace through Unity Catalog
- **Monitors Execution Data**: Captures agent execution traces, including inputs, outputs, and API interactions
- **Analyzes Traffic**: Sends API traffic data to Akto for comprehensive security analysis, including:
  - Prompt injection detection
  - Sensitive data exposure
  - Policy violations
  - Runtime threat detection
- **Unified Security View**: Provides a centralized dashboard view of all Databricks agents alongside your other AI infrastructure

## Prerequisites

Before setting up the Databricks connector, ensure you have:

1. **Akto Traffic Processor Configured** - The Akto Traffic Processor must be set up first. Follow the [Hybrid SaaS Setup Guide](https://ai-security-docs.akto.io/akto-argus-agentic-ai-security-for-homegrown-ai/connectors/others/hybrid-saas) for instructions.

2. **Databricks Workspace** - An active Databricks workspace with Unity Catalog enabled

3. **Service Principal** - A Databricks Service Principal with appropriate permissions:
   - `USE CATALOG` permission on the target Unity Catalog
   - `USE SCHEMA` permission on the target schema
   - `SELECT` permission on agent-related tables
   - Access to read workspace configurations

4. **Network Access** - The connector service must have network access to:
   - Your Databricks workspace URL
   - Akto Data Ingestion Service endpoint
   - Kafka broker (configured in Traffic Processor)

## Setup Instructions

### Step 1: Create Databricks Service Principal

1. Navigate to your Databricks workspace
2. Go to **Settings** > **Identity and Access**
3. Select **Service Principals** and click **Add Service Principal**
4. Note the **Application (Client) ID** - you'll need this for configuration
5. Generate a **Client Secret** and save it securely
6. Assign the necessary permissions to the Service Principal:
   ```sql
   -- Grant catalog access
   GRANT USE CATALOG ON CATALOG <your_catalog> TO `<service_principal_id>`;

   -- Grant schema access
   GRANT USE SCHEMA ON SCHEMA <your_catalog>.<your_schema> TO `<service_principal_id>`;

   -- Grant read access to tables
   GRANT SELECT ON SCHEMA <your_catalog>.<your_schema> TO `<service_principal_id>`;
   ```

### Step 2: Download Connector Configuration Files

Download the required configuration files from the Akto infrastructure repository:

```bash
wget https://raw.githubusercontent.com/akto-api-security/infra/feature/argus-connectors/databricks-cron/databricks-cron.env
wget https://raw.githubusercontent.com/akto-api-security/infra/feature/argus-connectors/databricks-cron/docker-compose-databricks-cron.yaml
```

### Step 3: Configure Environment Variables

Edit the `databricks-cron.env` file with your Databricks credentials and Akto configuration:

```bash
# Databricks Configuration
DATABRICKS_HOST=https://your-workspace.cloud.databricks.com
DATABRICKS_CLIENT_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
DATABRICKS_CLIENT_SECRET=your-client-secret-here

# Unity Catalog Configuration
DATABRICKS_CATALOG=workspace
DATABRICKS_SCHEMA=default
DATABRICKS_PREFIX=                    # Optional: Leave empty or specify a table prefix

# Akto Configuration
DATA_INGESTION_SERVICE_URL=https://your-akto-ingestion-service.com
KAFKA_BROKER_HOST=your-kafka-broker:9092

# Connector Settings (Optional)
RECURRING_INTERVAL_SECONDS=300        # Default: 5 minutes (300 seconds)
```

**Configuration Parameters Explained:**

| Parameter | Description | Required | Default |
|-----------|-------------|----------|---------|
| `DATABRICKS_HOST` | Your Databricks workspace URL | Yes | - |
| `DATABRICKS_CLIENT_ID` | Service Principal Application ID | Yes | - |
| `DATABRICKS_CLIENT_SECRET` | Service Principal secret key | Yes | - |
| `DATABRICKS_CATALOG` | Unity Catalog name to query | Yes | `workspace` |
| `DATABRICKS_SCHEMA` | Schema name within the catalog | Yes | `default` |
| `DATABRICKS_PREFIX` | Optional prefix for table filtering | No | (empty) |
| `DATA_INGESTION_SERVICE_URL` | URL of Akto Data Ingestion Service | Yes | - |
| `KAFKA_BROKER_HOST` | Kafka broker endpoint for traffic data | Yes | - |
| `RECURRING_INTERVAL_SECONDS` | Polling interval in seconds | No | 300 |

### Step 4: Launch the Connector

Start the Databricks connector using Docker Compose:

```bash
docker compose -f docker-compose-databricks-cron.yaml up -d
```

Verify the connector is running:

```bash
docker compose -f docker-compose-databricks-cron.yaml ps
docker compose -f docker-compose-databricks-cron.yaml logs -f
```

### Step 5: Verify in Akto Dashboard

1. Log in to your Akto dashboard
2. Navigate to **Akto Argus** > **Connectors**
3. You should see the Databricks connector listed with status "Active"
4. Check **Agents** section to view discovered Databricks agents
5. Monitor the **Traffic** tab for incoming data from Databricks agents

## Data Collection

### Agent Metadata Captured

The connector automatically fetches:

- **Agent Configurations**: All AI agents and workflows defined in Unity Catalog
- **Model Information**: LLM models and versions being used
- **Execution History**: Recent agent runs and their outcomes
- **Catalog Structure**: Unity Catalog tables, schemas, and metadata related to AI workloads

### Execution Data Collected

For each agent execution, the connector captures:

- **Input Data**: Prompts, queries, and parameters sent to agents
- **Output Data**: Agent responses and generated content
- **API Calls**: External API interactions made by agents
- **Timing Information**: Execution duration and timestamps
- **Error Logs**: Failures, exceptions, and error messages

### Data Retention

- Execution data from the past **60 minutes** is captured in each polling cycle
- Historical analysis is available in the Akto dashboard
- Sensitive data is automatically detected and can be masked based on your guardrail policies

## Configuration via Akto Dashboard

You can also configure the Databricks connector directly through the Akto dashboard UI:

1. Navigate to **Quick Start** > **AI Agent Connectors**
2. Select **Databricks** from the connector list
3. Fill in the configuration form:
   - **Databricks Host**: Your workspace URL
   - **Client ID**: Service Principal ID
   - **Client Secret**: Service Principal secret
   - **Unity Catalog**: Catalog name (default: "workspace")
   - **Schema**: Schema name (default: "default")
   - **Table Prefix**: Optional prefix for filtering
   - **Data Ingestion URL**: Your Akto ingestion service endpoint
4. Set the **Recurring Interval** (default: 5 minutes)
5. Click **Import** to activate the connector

The connector binary (`databricks-shield`) will be automatically deployed and configured.

## Troubleshooting

### Connection Issues

**Problem**: "Failed to connect to Databricks workspace"

**Solutions**:
- Verify your `DATABRICKS_HOST` URL is correct and accessible
- Ensure Service Principal credentials are valid
- Check network connectivity from the connector service to Databricks
- Verify firewall rules allow outbound HTTPS connections

### Authentication Errors

**Problem**: "Authentication failed" or "Invalid client credentials"

**Solutions**:
- Double-check `DATABRICKS_CLIENT_ID` and `DATABRICKS_CLIENT_SECRET`
- Ensure the Service Principal exists and is not disabled
- Verify the secret has not expired
- Regenerate credentials if necessary

### Permission Denied

**Problem**: "Access denied to catalog/schema"

**Solutions**:
- Verify Service Principal has required permissions:
  ```sql
  SHOW GRANTS ON CATALOG <catalog_name>;
  SHOW GRANTS ON SCHEMA <catalog_name>.<schema_name>;
  ```
- Grant missing permissions as shown in Step 1
- Ensure Unity Catalog is enabled in your workspace

### No Data Appearing

**Problem**: Connector is running but no agents appear in Akto

**Solutions**:
- Verify agents exist in the specified Unity Catalog and schema
- Check `DATABRICKS_PREFIX` is not filtering out all tables
- Ensure `DATA_INGESTION_SERVICE_URL` and `KAFKA_BROKER_HOST` are correct
- Review connector logs for errors:
  ```bash
  docker compose -f docker-compose-databricks-cron.yaml logs -f
  ```
- Verify Traffic Processor is running and accessible

### Performance Issues

**Problem**: Connector is slow or timing out

**Solutions**:
- Increase `RECURRING_INTERVAL_SECONDS` if polling too frequently
- Check network latency between connector and Databricks
- Verify Databricks workspace has sufficient compute resources
- Consider using `DATABRICKS_PREFIX` to filter tables if catalog is very large

## Security Best Practices

1. **Credential Management**:
   - Store Service Principal secrets in a secure secrets manager
   - Rotate credentials regularly (at least every 90 days)
   - Use environment variables or secret mounting, never hardcode credentials

2. **Network Security**:
   - Deploy the connector in a private network
   - Use VPC peering or private endpoints to connect to Databricks
   - Restrict network access using security groups

3. **Least Privilege**:
   - Grant only the minimum permissions required
   - Create a dedicated Service Principal for Akto connector
   - Avoid using admin or workspace-owner credentials

4. **Monitoring**:
   - Set up alerts for connector failures
   - Monitor connector logs regularly
   - Track data ingestion metrics in Akto dashboard

## Advanced Configuration

### Using Table Prefix for Filtering

If you have multiple applications or teams using the same Unity Catalog, use table prefixes to scope the connector:

```bash
DATABRICKS_PREFIX=production_
```

This will only discover agents and tables starting with "production_".

### Custom Polling Intervals

Adjust the polling frequency based on your needs:

- **Real-time monitoring**: `RECURRING_INTERVAL_SECONDS=60` (1 minute)
- **Standard monitoring**: `RECURRING_INTERVAL_SECONDS=300` (5 minutes - default)
- **Low-frequency monitoring**: `RECURRING_INTERVAL_SECONDS=900` (15 minutes)

**Note**: More frequent polling increases network traffic and Databricks API usage.

### High Availability Setup

For production deployments, consider running multiple connector instances:

1. Deploy connectors across different availability zones
2. Configure the same Databricks credentials and Kafka broker
3. Akto will automatically deduplicate data from multiple sources
4. Monitor health of all connector instances

## Support

If you need help with the Databricks connector:

- **In-app Chat**: Use the chat widget in your Akto dashboard for instant support
- **Discord Community**: Join our community at [discord.gg/Wpc6xVME4s](https://discord.gg/Wpc6xVME4s)
- **Email Support**: Contact us at help@akto.io
- **Contact Form**: Submit a support request at [akto.io/contact](https://www.akto.io/contact)

Our team is available 24/7 to assist you with setup, troubleshooting, and best practices.
