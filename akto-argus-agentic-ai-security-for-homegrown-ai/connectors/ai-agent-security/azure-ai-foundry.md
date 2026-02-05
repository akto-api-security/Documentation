# Azure AI Foundry

## Overview

Azure AI Foundry is Microsoft's comprehensive platform for building, deploying, and scaling production-grade AI agents and applications.  Integration with Akto enables you to **import Azure AI Foundry agents seamlessly into Akto**, providing comprehensive security monitoring for your AI agents, multi-agent workflows, and API interactions running on the Azure platform.&#x20;

## What the Connector Does

The Azure AI Foundry connector automatically:

* **Discovers AI Agents**: Imports all AI agents deployed through Azure AI Foundry Agent Service
* **Monitors Agent Execution**: Captures agent interactions, including prompts, responses, and API calls
* **Analyzes Traffic**: Sends agent traffic data to Akto for comprehensive security analysis, including:
  * Prompt injection detection
  * Sensitive data exposure
  * Policy violations
  * Runtime threat detection
* **Multi-Agent Workflow Visibility**: Tracks interactions across multi-agent workflows and stateful processes
* **Unified Security Dashboard**: Provides centralized monitoring of all Azure AI Foundry agents alongside your other AI infrastructure

## Azure AI Foundry APIs Queried by Akto

The following table lists the Azure AI Foundry API endpoints queried by Akto and the data collected from each endpoint.

| API Endpoint                                                              | What Akto Ingests                      |
| ------------------------------------------------------------------------- | -------------------------------------- |
| `AZURE_PROJECT_URL/assistants?api-version=v1&limit=100`                   | List of AI agents                      |
| `AZURE_PROJECT_URL/threads?api-version=v1&agent_id={id}&limit=100`        | Conversation sessions                  |
| `AZURE_PROJECT_URL/threads/{thread_id}/messages?api-version=v1&limit=100` | Chat messages from users and AI agents |

## Prerequisites

Before setting up the Azure AI Foundry connector, ensure you have:

1. **Active Azure Subscription** – With Azure AI Foundry resources provisioned
2. **Azure AI Foundry Agent Service** – At least one agent deployed and running in Agent Service
3. **Azure Credentials** – One of the following authentication methods:
   * Service Principal (Client ID + Client Secret)
   * Managed Identity
   * Azure AD authentication token
4. **Network Access** – The connector service must have access to:
   * Azure AI Foundry API endpoints
   * Akto Data Ingestion Service
   * Your deployed agents' endpoints
5. **Permissions** – Required Azure permissions:
   * `Cognitive Services User` role on AI Foundry resources
   * Read access to agent configurations
   * Access to Application Insights (for telemetry)

## Setps to Connect

#### Method 1: Import via Akto Dashboard (Recommended)

**Step 1: Navigate to AI Agent Connectors**

1. Log in to your Akto dashboard
2. Go to **Quick Start** > **AI Agent Connectors**
3. Select **Azure AI Foundry** from the connector list

**Step 2: Get Your Azure Project URL**

Before configuring the connector, locate your Azure AI Foundry Project URL:

1. Navigate to [Azure AI Foundry portal](https://ai.azure.com)
2. Select your project
3. Go to **Settings** > **Project details**
4. Copy the **Project connection string** or **Endpoint URL**
   * Format: `https://your-project.openai.azure.com`
   * Or: `https://your-resource.cognitiveservices.azure.com`

**Step 3: Configure Agent Endpoint**

Fill in the following information for your Azure AI Foundry agent:

**Basic Configuration:**

| Field                   | Description                              | Example                                                        |
| ----------------------- | ---------------------------------------- | -------------------------------------------------------------- |
| **Agent Name**          | Friendly name for your agent             | "Customer Support Agent"                                       |
| **Azure Project URL**   | Your Azure AI Foundry project endpoint   | `https://your-project.openai.azure.com`                        |
| **Agent Endpoint URL**  | Your Azure AI Foundry agent API endpoint | `https://your-agent.azurecontainerapps.io/v1/chat/completions` |
| **Authentication Type** | Select authentication method             | Service Principal, Managed Identity, or Bearer Token           |

**Authentication Details:**

For **Service Principal** authentication:

* **Tenant ID**: Your Azure AD tenant ID
* **Client ID**: Service principal application ID
* **Client Secret**: Service principal secret key

For **Bearer Token** authentication:

* **API Key/Token**: Your Azure AI Foundry API key or bearer token

**Advanced Settings (Optional):**

* **Request Headers**: Add custom headers (e.g., `api-version: 2024-02-15-preview`)
* **Request Timeout**: Timeout in seconds (default: 30)
* **Enable Streaming**: Track streaming responses

**Step 4: Test Connection**

1.  Use the default test request provided:

    ```json
    {
      "messages": [
        {"role": "user", "content": "Why is the sky blue?"}
      ],
      "max_tokens": 100,
      "temperature": 0.7
    }
    ```
2. Click **Test Connection** to verify the agent responds correctly
3. Review the test response to ensure proper configuration

**Step 5: Import Agent**

1. Click **Import** to add the agent to Akto
2. The connector will automatically begin monitoring agent traffic
3. View the agent in **Akto Argus** > **Agents** section

**Step 6: Verify Monitoring**

1. Navigate to **Akto Argus** > **Agents**
2. Find your Azure AI Foundry agent in the list
3. Click on the agent to view:
   * Recent interactions
   * Security findings
   * Performance metrics
   * Traffic patterns

#### Method 2: Azure Container Apps Integration

For agents deployed on Azure Container Apps, you can integrate directly with Application Insights for automatic traffic capture.

**Step 1: Enable Application Insights**

Ensure your Azure Container App has Application Insights enabled:

```bash
# Using Azure CLI
az containerapp create \
  --name your-agent-app \
  --resource-group your-rg \
  --environment your-env \
  --enable-dapr \
  --instrumentation-key <app-insights-key>
```

**Step 2: Configure Akto Data Forwarder**

Deploy the Akto data forwarder as a sidecar container in your Container App:

```yaml
containers:
  - name: akto-forwarder
    image: aktosecurity/data-forwarder:latest
    env:
      - name: AKTO_INGESTION_URL
        value: "https://your-akto-ingestion-service.com"
      - name: SOURCE_TYPE
        value: "AZURE_AI_FOUNDRY"
      - name: APP_INSIGHTS_CONNECTION_STRING
        secretRef: app-insights-connection
```

**Step 3: Stream Logs to Akto**

Application Insights will automatically capture all agent requests and responses, forwarding them to Akto for analysis.

## Data Collection

The Akto connector uses the following Azure AI Foundry API endpoints to discover and monitor your agents:

| API Endpoint                                                              | What It Gets              |
| ------------------------------------------------------------------------- | ------------------------- |
| `AZURE_PROJECT_URL/assistants?api-version=v1&limit=100`                   | List of AI agents         |
| `AZURE_PROJECT_URL/threads?api-version=v1&agent_id={id}&limit=100`        | Conversation sessions     |
| `AZURE_PROJECT_URL/threads/{thread_id}/messages?api-version=v1&limit=100` | Chat messages (user + AI) |

{% hint style="info" %}
## **Note**

&#x20;Replace `AZURE_PROJECT_URL` with your Azure AI Foundry project URL (e.g., `https://your-project.openai.azure.com`).
{% endhint %}

### Agent Metadata Captured

The connector automatically fetches:

* **Agent Configurations**: All AI agents deployed in Azure AI Foundry
* **Model Information**: LLM models and versions being used (GPT-4, GPT-3.5, Azure OpenAI models)
* **Deployment Details**: Container App configurations, scaling settings
* **Integration Points**: Connected services (Microsoft 365, Teams, custom APIs)

### Execution Data Collected

For each agent interaction, the connector captures:

* **Input Data**: User prompts, queries, and conversation context
* **Output Data**: Agent responses and generated content
* **API Calls**: External API interactions and tool usage
* **Multi-Agent Communication**: Messages exchanged between agents in workflows
* **Timing Information**: Execution duration, latency metrics
* **Error Logs**: Failures, exceptions, and retry attempts
* **Memory State**: Agent memory and context retention

### Real-Time Monitoring

* Execution data is captured in real-time as agents process requests
* Historical analysis available in the Akto dashboard
* Sensitive data automatically detected and can be masked based on guardrail policies

## Troubleshooting

### Connection Issues

**Problem**: "Failed to connect to Azure AI Foundry agent"

**Solutions**:

* Verify the agent endpoint URL is correct and accessible
* Check that the agent is deployed and running in Azure Container Apps
* Ensure network connectivity from Akto to Azure
* Verify firewall rules allow outbound HTTPS connections

### Authentication Errors

**Problem**: "Authentication failed" or "Invalid credentials"

**Solutions**:

* **Service Principal**: Verify Client ID, Client Secret, and Tenant ID are correct
* **Bearer Token**: Ensure the API key or token is valid and not expired
* **Managed Identity**: Verify the managed identity has proper permissions
* Check Azure AD permissions for the service principal
* Regenerate credentials if necessary

### Permission Denied

**Problem**: "Access denied to agent resources"

**Solutions**:

*   Grant `Cognitive Services User` role to your service principal:

    ```bash
    az role assignment create \
      --assignee <service-principal-id> \
      --role "Cognitive Services User" \
      --scope /subscriptions/<subscription-id>/resourceGroups/<rg>/providers/Microsoft.CognitiveServices/accounts/<resource-name>
    ```
* Verify resource group permissions
* Ensure subscription is active

### No Data Appearing

**Problem**: Connector is active but no agent traffic appears in Akto

**Solutions**:

* Verify agents are actively processing requests
* Check Application Insights is properly configured
* Ensure data forwarder is running (for Container Apps integration)
* Review Akto ingestion service logs
* Verify the `DATA_INGESTION_SERVICE_URL` is correct
* Check network connectivity between Azure and Akto

### Streaming Response Issues

**Problem**: Streaming responses not being captured

**Solutions**:

* Enable streaming support in connector configuration
* Verify Application Insights captures streaming data
* Check that the agent endpoint supports streaming
* Review data forwarder configuration

### Related Resources

* [Azure AI Foundry Agent Service](https://azure.microsoft.com/en-us/products/ai-foundry/agent-service) - Official Microsoft documentation
* [Get Started with AI Agents on Azure](https://github.com/Azure-Samples/get-started-with-ai-agents) - Sample implementations
* [Azure AI Foundry Quickstart](https://learn.microsoft.com/en-us/azure/ai-foundry/agents/quickstart) - Microsoft Learn guide
* [Building Conversational AI Agents](https://www.doit.com/blog/creating-conversational-ai-agents-with-azure-ai-foundry/) - Best practices guide

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
