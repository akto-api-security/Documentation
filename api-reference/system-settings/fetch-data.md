# Fetch Data

## Table of Contents

- [System & Health](#system--health)
- [Settings & Toggles](#settings--toggles)
- [SSO & Authentication](#sso--authentication)
- [Runtime & Infrastructure](#runtime--infrastructure)
- [Logs, Audit & Traffic](#logs-audit--traffic)
- [Dashboard, Filters & Misc](#dashboard-filters--misc)
- [Service Graph, Tracing & Misc](#service-graph-tracing--misc)
- [Maintenance](#maintenance)

## System & Health

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="400">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/metrics</strong></td><td>Fetches system metrics and performance data.</td></tr><tr><td>2</td><td><strong>GET /api/allMetricsDescription</strong></td><td>Retrieves descriptions and metadata for all available system metrics.</td></tr><tr><td>3</td><td><strong>GET /api/health</strong></td><td>Checks the health status of the system and services.</td></tr><tr><td>4</td><td><strong>GET /api/fetchModuleInfo</strong></td><td>Fetches information about system modules and their status.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/metrics" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/allMetricsDescription" method="get" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/health" method="get" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchModuleInfo" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Settings & Toggles

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="400">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>GET /api/fetchAdminSettings</strong></td><td>Fetches admin-level settings for the current account or organization.</td></tr><tr><td>2</td><td><strong>GET /api/getAccountSettingsForAdvancedFilters</strong></td><td>Retrieves account settings specific to advanced filter configurations.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchAdminSettings" method="get" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getAccountSettingsForAdvancedFilters" method="get" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## SSO & Authentication

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="400">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/fetchGithubSso</strong></td><td>Fetches the current GitHub SSO configuration for the organization.</td></tr><tr><td>2</td><td><strong>POST /api/fetchGithubAppId</strong></td><td>Retrieves the GitHub App ID configured for SSO integration.</td></tr><tr><td>3</td><td><strong>POST /api/fetchOktaSso</strong></td><td>Fetches the current Okta SSO configuration and settings.</td></tr><tr><td>4</td><td><strong>POST /api/fetchOktaGroups</strong></td><td>Retrieves available Okta groups for role mapping configuration.</td></tr><tr><td>5</td><td><strong>POST /api/fetchSAMLSso</strong></td><td>Fetches the current SAML SSO configuration and metadata.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchGithubSso" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchGithubAppId" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchOktaSso" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchOktaGroups" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchSAMLSso" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Runtime & Infrastructure

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="400">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>GET /api/fetchRuntimeInstances</strong></td><td>Fetches information about all configured runtime instances and their status.</td></tr><tr><td>2</td><td><strong>POST /api/fetchRuntimeMetrics</strong></td><td>Retrieves metrics and performance data for runtime instances.</td></tr><tr><td>3</td><td><strong>GET /api/fetchRuntimeHelmCommand</strong></td><td>Fetches the Helm command required for deploying the runtime.</td></tr><tr><td>4</td><td><strong>GET /api/fetchAwsAccountIdsForApiGatewayLogging</strong></td><td>Retrieves AWS account IDs configured for API Gateway logging.</td></tr><tr><td>5</td><td><strong>GET /api/fetchLoadBalancers</strong></td><td>Fetches all configured load balancers and their settings.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchRuntimeInstances" method="get" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchRuntimeMetrics" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchRuntimeHelmCommand" method="get" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchAwsAccountIdsForApiGatewayLogging" method="get" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchLoadBalancers" method="get" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Logs, Audit & Traffic

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="400">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/fetchLogs</strong></td><td>Fetches system logs from the current session or a specified timeframe.</td></tr><tr><td>2</td><td><strong>POST /api/fetchLogsFromDb</strong></td><td>Retrieves logs stored in the database with filtering and pagination options.</td></tr><tr><td>3</td><td><strong>POST /api/fetchTestingLogs</strong></td><td>Fetches logs specific to security testing operations.</td></tr><tr><td>4</td><td><strong>POST /api/fetchApiAuditLogsFromDb</strong></td><td>Retrieves audit logs for API operations from the database.</td></tr><tr><td>5</td><td><strong>POST /api/fetchAuditData</strong></td><td>Fetches audit trail data and user activity logs.</td></tr><tr><td>6</td><td><strong>POST /api/fetchTrafficMetrics</strong></td><td>Retrieves traffic metrics and analytics data.</td></tr><tr><td>7</td><td><strong>POST /api/fetchTrafficMetricsDesciptions</strong></td><td>Fetches descriptions and metadata for traffic metrics.</td></tr><tr><td>8</td><td><strong>POST /api/fetchHistoricalData</strong></td><td>Retrieves historical data for analysis and reporting.</td></tr><tr><td>9</td><td><strong>POST /api/fetchApiStats</strong></td><td>Fetches statistics and performance metrics for APIs.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchLogs" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchLogsFromDb" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchTestingLogs" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchApiAuditLogsFromDb" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchAuditData" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchTrafficMetrics" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchTrafficMetricsDesciptions" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchHistoricalData" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchApiStats" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Dashboard, Filters & Misc

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="400">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>GET /api/fetchDashboardLayout</strong></td><td>Retrieves the user's saved dashboard layout configuration.</td></tr><tr><td>2</td><td><strong>GET /api/getRecentActivities</strong></td><td>Fetches recent user activities and system events.</td></tr><tr><td>3</td><td><strong>GET /api/fetchFilterYamlTemplate</strong></td><td>Retrieves YAML filter templates for custom filters.</td></tr><tr><td>4</td><td><strong>GET /api/fetchMetadataFilters</strong></td><td>Fetches available metadata filter options and configurations.</td></tr><tr><td>5</td><td><strong>GET /api/fetchBrowserExtensionConfigs</strong></td><td>Retrieves browser extension configurations for the current user.</td></tr><tr><td>6</td><td><strong>POST /api/getSummaryInfoForChanges</strong></td><td>Fetches summary information for changes and modifications.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchDashboardLayout" method="get" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getRecentActivities" method="get" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchFilterYamlTemplate" method="get" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchMetadataFilters" method="get" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchBrowserExtensionConfigs" method="get" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getSummaryInfoForChanges" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Service Graph, Tracing & Misc

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="400">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/fetchApiDependencies</strong></td><td>Fetches API dependency information and service relationships.</td></tr><tr><td>2</td><td><strong>GET /api/checkIfDependencyGraphAvailable</strong></td><td>Checks if the dependency graph is available for the current configuration.</td></tr><tr><td>3</td><td><strong>POST /api/fetchLatestTraces</strong></td><td>Retrieves the latest traces from the tracing system.</td></tr><tr><td>4</td><td><strong>GET /api/fetchSpansForTrace</strong></td><td>Fetches individual spans associated with a specific trace.</td></tr><tr><td>5</td><td><strong>POST /api/findSvcToSvcGraphEdges</strong></td><td>Retrieves service-to-service graph edges for visualization.</td></tr><tr><td>6</td><td><strong>POST /api/findSvcToSvcGraphNodes</strong></td><td>Fetches service-to-service graph nodes representing services.</td></tr><tr><td>7</td><td><strong>POST /api/fetchMiniTestingServiceNames</strong></td><td>Retrieves available service names for mini testing.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchApiDependencies" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/checkIfDependencyGraphAvailable" method="get" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchLatestTraces" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchSpansForTrace" method="get" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/findSvcToSvcGraphEdges" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/findSvcToSvcGraphNodes" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchMiniTestingServiceNames" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Maintenance

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="400">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>GET /api/fetchParamsStatus</strong></td><td>Fetches the status of parameters and configurations for maintenance purposes.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchParamsStatus" method="get" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}
