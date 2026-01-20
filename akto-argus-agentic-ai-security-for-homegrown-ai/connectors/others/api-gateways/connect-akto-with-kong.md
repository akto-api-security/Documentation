# Connect Akto with Kong

Monitor and analyze all incoming requests and outgoing responses from your AI agents and MCP (Model Context Protocol) servers running on Kong API Gateway. This custom Kong plugin automatically captures API traffic, enabling comprehensive visibility, security analysis, and compliance monitoring for your AI infrastructure.

<figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2Fgit-blob-644c0f5adf38a5b8d700ef0ed54927fe97510207%2Fkong-agentic-guardrail.png?alt=media" alt="Kong AI Agent Monitoring" width="563"><figcaption></figcaption></figure>

## Quick Setup Steps

This integration requires you to download our custom plugin, install it inside your Kong instance, enable it for your target services/routes, and deploy the associated helm charts for full functionality.

### 1. Download the Custom Kong Plugin

Clone the GitHub repository containing the plugin files.

```bash
git clone https://github.com/akto-api-security/kong-integration.git
```

Inside the repository, navigate to the `/plugin` directory. You will find the following two required files:

* **handler.lua**
* **schema.lua**

These constitute the core logic and validation schema for the custom Kong plugin.

### 2. Install the Plugin in Kong

Follow the steps below to install the plugin into your Kong environment.

{% stepper %}
{% step %}
**Copy Plugin Files to Kong**

1.  Create a directory for custom plugins (if not already present):

    ```bash
    mkdir -p /usr/local/share/lua/5.1/kong/plugins/akto-mcp-endpoint-shield
    ```
2.  Copy the files:

    ```bash
    cp plugin/handler.lua /usr/local/share/lua/5.1/kong/plugins/akto-mcp-endpoint-shield/
    cp plugin/schema.lua /usr/local/share/lua/5.1/kong/plugins/akto-mcp-endpoint-shield/
    ```
{% endstep %}

{% step %}
**Update Kong Configuration**

Edit your `kong.conf` or environment variable configuration:

```
plugins = bundled,akto-mcp-endpoint-shield
```

{% hint style="info" %}
This ensures Kong loads your custom plugin along with the built-in ones.
{% endhint %}
{% endstep %}

{% step %}
**Restart Kong**

Apply the config changes:

```bash
kong restart
```
{% endstep %}
{% endstepper %}

### 3. Enable the Plugin for a Service or Route

You can enable the plugin globally or at the service/route level. Most teams prefer enabling it only for selected upstreams (MCP servers or AI agents).

#### **Enable for a specific service:**

```bash
curl -X POST http://localhost:8001/services/<SERVICE_NAME>/plugins \
  --data "name=mcp-endpoint-shield" \
  --data "config.service_url=http://<AKTO_SERVICE_URL>:9091" \
  --data "config.mode=async"
```

#### **Enable for a specific route:**

```bash
curl -X POST http://localhost:8001/routes/<ROUTE_NAME>/plugins \
  --data "name=mcp-endpoint-shield" \
  --data "config.service_url=http://<AKTO_SERVICE_URL>:9091" \
  --data "config.mode=async"
```

#### **Enable globally:**

```bash
curl -X POST http://localhost:8001/plugins \
  --data "name=mcp-endpoint-shield" \
  --data "config.service_url=http://<AKTO_SERVICE_URL>:9091" \
  --data "config.mode=async"
```

{% hint style="info" %}
## **Configuration Parameters**

* **`service_url`** - The URL where captured traffic data will be sent (Akto guardrail service endpoint)
* **`mode`** - Processing mode: `async` or `blocked`

Once applied, the plugin will automatically capture and validate all incoming requests and outgoing responses for the selected service/route.
{% endhint %}

### 4. Deploy the Supporting Helm Charts

After enabling the Kong plugin, you need to deploy the Akto backend components using Helm charts. These components process and store the captured traffic data.

{% stepper %}
{% step %}
**Add Akto Helm Repository**

```bash
# Add the Akto Helm repository
helm repo add akto https://akto-api-security.github.io/helm-charts
```

If you've already added the repository before, update it to get the latest charts:

```bash
# Update Helm repositories
helm repo update
```
{% endstep %}

{% step %}
**Prepare MongoDB Connection String**

Akto requires a MongoDB instance for data storage. You'll need a MongoDB connection string.

For detailed MongoDB setup instructions, refer to the [Helm Deploy guide](https://docs.akto.io/getting-started/quick-start-with-akto-self-hosted/helm-deploy#prepare-mongo-connection-string).
{% endstep %}

{% step %}
**Install Helm Charts in Sequence**

Deploy the following three Helm charts **in the order shown below**:

**Chart 1: Database Abstractor (Cyborg)**

This chart sets up the database abstraction layer that manages data access patterns.

```bash
helm install akto-database-abstractor akto/akto-setup-database-abstractor \
  -n <NAMESPACE> \
  --set mongo.aktoMongoConn="<AKTO_MONGO_CONNECTION_STRING>"
```

After installation, retrieve the **Database Abstractor Service Token** from Akto dashboard (you'll need this for Chart 2).

**Chart 2: Data Ingestion + Mini-Runtime (Combined)**

This chart deploys the data ingestion service and mini-runtime together. It processes the traffic captured by the Kong plugin.

```bash
helm install akto-mrs-runtime-combined akto/akto-mrs-runtime-combined \
  -n <NAMESPACE> \
  --set mini_runtime.aktoApiSecurityRuntime.env.databaseAbstractorToken="<DATABASE_ABSTRACTOR_SERVICE_TOKEN>" \
  --set mini_runtime.aktoApiSecurityRuntime.env.aktoLogLevel="INFO"
```

Replace `<DATABASE_ABSTRACTOR_SERVICE_TOKEN>` with the token retrieved from Chart 1.

**Chart 3: Threat Backend**

This chart deploys the threat analysis and security scanning backend.

```bash
helm install akto-threat-backend akto/akto-threat-backend \
  -n <NAMESPACE> \
  --set mongo.aktoMongoConn="<AKTO_MONGO_CONNECTION_STRING>"
```

**Chart 4: AI Guardrails**

This chart deploys the AI guardrails service that validates and monitors AI agent interactions.

```bash
helm install akto-ai-guardrails akto/akto-ai-guardrails \
  -n <NAMESPACE> \
  --set guardrailsService.env.aktoApiToken="<AKTO_API_TOKEN>" \
  --set guardrailsService.env.aktoDbAbstractorHost="<DATABASE_ABSTRACTOR_HOST>" \
  --set guardrailsService.env.aktoAgentGuardUrl="http://akto-ai-guardrails-executor:8092" \
  --set guardrailsService.env.aktoThreatDetectionHost="<THREAT_BACKEND_HOST>" \
  --set guardrailsService.env.aktoLlmValidatorHost="<LLM_VALIDATOR_HOST>" \
  --set guardrailsService.env.aktoIngestHost="<DATA_INGESTION_HOST>" \
  --set guardrailsService.env.logLevel="info"
```

<details>

<summary><strong>Environment Variables Explained</strong></summary>

| Environment Variable          | Description                                                                                                                                      |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| AKTO\_API\_TOKEN              | Database Abstractor token retrieved from Chart 1                                                                                                 |
| AKTO\_DB\_ABSTRACTOR\_HOST    | Database Abstractor service URL (e.g., [http://akto-database-abstractor:8080](http://akto-database-abstractor:8080/))                            |
| AKTO\_AGENT\_GUARD\_URL       | Agent Guard Executor service URL (deployed in same chart, accessible at [http://localhost:8092](http://localhost:8092/))                         |
| AKTO\_THREAT\_DETECTION\_HOST | Threat Backend service URL (e.g., [http://akto-threat-backend:8080](http://akto-threat-backend:8080/))                                           |
| AKTO\_LLM\_VALIDATOR\_HOST    | LLM Validator service URL (same as Database Abstractor service URL)                                                                              |
| AKTO\_INGEST\_HOST            | Data Ingestion service URL (e.g., [http://akto-mrs-runtime-combined-data-ingestion:8080](http://akto-mrs-runtime-combined-data-ingestion:8080/)) |
| LOG\_LEVEL                    | Logging level (set to info for standard logging)                                                                                                 |

</details>

**Getting Service URLs**

To get the internal service URLs for the deployed components:

```bash
# Get Database Abstractor service URL
kubectl get service -n <NAMESPACE> | grep database-abstractor

# Get Threat Backend service URL
kubectl get service -n <NAMESPACE> | grep threat-backend

# Get Data Ingestion service URL
kubectl get service -n <NAMESPACE> | grep data-ingestion
```

The service URLs typically follow the format: `http://<service-name>:<port>`
{% endstep %}

{% step %}
**Verify Helm Deployments**

Check that all pods are running successfully:

```bash
# Check all pods in your namespace
kubectl get pods -n <NAMESPACE>

# You should see pods for:
# - akto-database-abstractor
# - akto-mrs-runtime-combined (mini-runtime and data ingestion)
# - akto-threat-backend
# - akto-ai-guardrails (with agentGuardExecutor service)

# Check services
kubectl get services -n <NAMESPACE>

# Check Helm releases
helm list -n <NAMESPACE>
```

All pods should show a `Running` status. If any pod is in `CrashLoopBackOff` or `Error` state, check the logs:

```bash
kubectl logs -n <NAMESPACE> <POD_NAME>
```
{% endstep %}
{% endstepper %}

## **Complete Deployment Summary**

After all four Helm charts are successfully deployed, you will have:

1. **Database Abstractor (Cyborg)** - Database access layer
2. **Data Ingestion + Mini-Runtime** - Traffic processing pipeline
3. **Threat Backend** - Security scanning and threat analysis
4. **AI Guardrails** - AI agent validation and monitoring with Agent Guard Executor

{% hint style="info" %}
## Important Notes

* Ensure your Kong version supports custom plugins (Kong ≥ 2.0 recommended).
* The plugin must be listed under `plugins` in `kong.conf` to be loaded.
* Restart Kong after any plugin installation or configuration change.
* Helm charts should be deployed in a Kubernetes cluster with sufficient permissions.
{% endhint %}

## Get Support

If you need help integrating or debugging your setup:

1. Contact the team via Slack or internal support channels.
2. Raise an issue in the GitHub repository.
3. Email the engineering team if you need custom integrations or help debugging Kong-level errors.
