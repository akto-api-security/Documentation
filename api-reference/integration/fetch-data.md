# Fetch Data

## Table of Contents

* [#jira](fetch-data.md#jira "mention")
* [#azure-boards](fetch-data.md#azure-boards "mention")
* [#datadog](fetch-data.md#datadog "mention")
* [#splunk](fetch-data.md#splunk "mention")
* [#azure-data-explorer-adx](fetch-data.md#azure-data-explorer-adx "mention")
* [#devrev](fetch-data.md#devrev "mention")
* [#servicenow](fetch-data.md#servicenow "mention")
* [#microsoft-defender](fetch-data.md#microsoft-defender "mention")
* [#sentinelone](fetch-data.md#sentinelone "mention")
* [#generic-integrations](fetch-data.md#generic-integrations "mention")
* [#slack-webhooks](fetch-data.md#slack-webhooks "mention")
* [#custom-webhooks](fetch-data.md#custom-webhooks "mention")

## Jira

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="400">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/jira/fetchProjectStatuses</strong></td><td>Fetches all issue statuses for a Jira project, used to configure bi-directional sync status mappings.</td></tr><tr><td>2</td><td><strong>POST /api/jira/fetchPriorities</strong></td><td>Fetches available priority levels from the configured Jira instance.</td></tr><tr><td>3</td><td><strong>POST /api/jira/fetchAvailableFieldsForMapping</strong></td><td>Fetches Jira issue fields available for priority field mapping for a given project and issue type.</td></tr><tr><td>4</td><td><strong>POST /api/jira/fetchFieldValues</strong></td><td>Fetches allowed values for a specific Jira field in a given project.</td></tr><tr><td>5</td><td><strong>POST /api/jira/fetchPriorityFieldMapping</strong></td><td>Retrieves the saved Akto severity to Jira field value mapping for a project.</td></tr><tr><td>6</td><td><strong>POST /api/fetchCreateJiraIssueFieldMetaData</strong></td><td>Fetches field metadata required to create a Jira issue for a given project and issue type.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/jira/fetchProjectStatuses" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/jira/fetchPriorities" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/jira/fetchAvailableFieldsForMapping" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/jira/fetchFieldValues" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/jira/fetchPriorityFieldMapping" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchCreateJiraIssueFieldMetaData" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Azure Boards

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="400">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/fetchAzureBoardsIntegration</strong></td><td>Fetches the current Azure Boards integration configuration and status.</td></tr><tr><td>2</td><td><strong>POST /api/fetchCreateABWorkItemFieldMetaData</strong></td><td>Fetches field metadata required to create an Azure Boards work item for a given project and issue type.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchAzureBoardsIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchCreateABWorkItemFieldMetaData" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Datadog

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="400">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/fetchDatadogIntegration</strong></td><td>Fetches the current Datadog integration configuration and status.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchDatadogIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Splunk

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="400">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/fetchSplunkIntegration</strong></td><td>Fetches the current Splunk SIEM integration configuration and status.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchSplunkIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Azure Data Explorer (ADX)

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="400">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/fetchAdxIntegration</strong></td><td>Fetches the current Azure Data Explorer integration configuration and status.</td></tr><tr><td>2</td><td><strong>POST /api/getAdxExportStatus</strong></td><td>Retrieves the current export status and progress for the Azure Data Explorer integration.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchAdxIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getAdxExportStatus" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## DevRev

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="400">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/fetchDevRevIntegration</strong></td><td>Fetches the current DevRev integration configuration and status.</td></tr><tr><td>2</td><td><strong>POST /api/fetchDevRevParts</strong></td><td>Retrieves available DevRev parts/components for ticket creation and linking.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchDevRevIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchDevRevParts" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## ServiceNow

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="400">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/fetchServiceNowIntegration</strong></td><td>Fetches the current ServiceNow integration configuration and status.</td></tr><tr><td>2</td><td><strong>POST /api/fetchServiceNowTables</strong></td><td>Retrieves available ServiceNow tables for ticket creation configuration.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchServiceNowIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchServiceNowTables" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Microsoft Defender

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="400">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/fetchMicrosoftDefenderIntegration</strong></td><td>Fetches the current Microsoft Defender for Endpoint integration configuration and status.</td></tr><tr><td>2</td><td><strong>POST /api/fetchDefenderDevices</strong></td><td>Retrieves devices enrolled in Microsoft Defender for Endpoint.</td></tr><tr><td>3</td><td><strong>POST /api/listDefenderLibraryScripts</strong></td><td>Lists available scripts from the Microsoft Defender Live Response library.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchMicrosoftDefenderIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchDefenderDevices" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/listDefenderLibraryScripts" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## SentinelOne

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="400">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/fetchSentinelOneIntegration</strong></td><td>Fetches the current SentinelOne integration configuration and status.</td></tr><tr><td>2</td><td><strong>POST /api/fetchSentinelOneAgents</strong></td><td>Retrieves agents enrolled in SentinelOne for endpoint management.</td></tr><tr><td>3</td><td><strong>POST /api/getSentinelOneScriptTaskStatus</strong></td><td>Gets the execution status of a remote script task run via SentinelOne.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchSentinelOneIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchSentinelOneAgents" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getSentinelOneScriptTaskStatus" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Generic Integrations

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="400">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/fetchIntegration</strong></td><td>Fetches configuration and status of a generic integration by type.</td></tr><tr><td>2</td><td><strong>POST /api/getIntegratedConnectionsInfo</strong></td><td>Retrieves info about all currently connected and active integrations.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getIntegratedConnectionsInfo" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Slack Webhooks

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="400">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/fetchSlackWebhooks</strong></td><td>Retrieves all configured Slack webhook integrations for the account.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchSlackWebhooks" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Custom Webhooks

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="400">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/fetchCustomWebhooks</strong></td><td>Retrieves all configured custom webhook integrations for the account.</td></tr><tr><td>2</td><td><strong>POST /api/fetchLatestWebhookResult</strong></td><td>Fetches the result of the most recent webhook invocation for debugging and verification.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchCustomWebhooks" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchLatestWebhookResult" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}
