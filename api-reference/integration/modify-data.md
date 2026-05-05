# Modify Data

## Table of Contents

* [#jira](modify-data.md#jira "mention")
* [#azure-boards](modify-data.md#azure-boards "mention")
* [#datadog](modify-data.md#datadog "mention")
* [#splunk](modify-data.md#splunk "mention")
* [#azure-data-explorer-adx](modify-data.md#azure-data-explorer-adx "mention")
* [#devrev](modify-data.md#devrev "mention")
* [#servicenow](modify-data.md#servicenow "mention")
* [#microsoft-defender](modify-data.md#microsoft-defender "mention")
* [#sentinelone](modify-data.md#sentinelone "mention")
* [#generic-integrations](modify-data.md#generic-integrations "mention")
* [#slack-webhooks](modify-data.md#slack-webhooks "mention")
* [#custom-webhooks](modify-data.md#custom-webhooks "mention")

## Jira

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="420">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/jira/add</strong></td><td>Adds a Jira project to the integration or updates bi-directional sync settings for an existing one. Supports both Jira Cloud (v3 API) and Data Center (v2 API).</td></tr><tr><td>2</td><td><strong>POST /api/jira/delete</strong></td><td>Removes a Jira project from the integration.</td></tr><tr><td>3</td><td><strong>POST /api/jira/savePriorityFieldMapping</strong></td><td>Saves the mapping from Akto severity levels to Jira field values for a project.</td></tr><tr><td>4</td><td><strong>POST /api/createJiraIssue</strong></td><td>Creates a Jira issue linked to an Akto testing run issue and stores the resulting Jira ticket URL.</td></tr><tr><td>5</td><td><strong>POST /api/bulkCreateJiraTickets</strong></td><td>Bulk creates Jira issues for multiple Akto testing run issues in a single request.</td></tr><tr><td>6</td><td><strong>POST /api/attachFileToIssue</strong></td><td>Attaches original and test HTTP request/response samples as a file to an existing Jira issue.</td></tr><tr><td>7</td><td><strong>POST /api/createGeneralJiraTicket</strong></td><td>Creates a general-purpose Jira ticket not tied to a specific testing run issue.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/jira/add" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/jira/delete" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/jira/savePriorityFieldMapping" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/createJiraIssue" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/bulkCreateJiraTickets" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/attachFileToIssue" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/createGeneralJiraTicket" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Azure Boards

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="420">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/addAzureBoardsIntegration</strong></td><td>Adds or updates the Azure Boards integration configuration.</td></tr><tr><td>2</td><td><strong>POST /api/removeAzureBoardsIntegration</strong></td><td>Removes the Azure Boards integration configuration.</td></tr><tr><td>3</td><td><strong>POST /api/createAzureBoardsWorkItem</strong></td><td>Creates an Azure Boards work item linked to an Akto testing run issue.</td></tr><tr><td>4</td><td><strong>POST /api/bulkCreateAzureWorkItems</strong></td><td>Bulk creates Azure Boards work items for multiple Akto testing run issues in a single request.</td></tr><tr><td>5</td><td><strong>POST /api/createGeneralAzureBoardsWorkItem</strong></td><td>Creates a general-purpose Azure Boards work item not tied to a specific testing run issue.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/addAzureBoardsIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/removeAzureBoardsIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/createAzureBoardsWorkItem" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/bulkCreateAzureWorkItems" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/createGeneralAzureBoardsWorkItem" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Datadog

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="420">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/saveDataDogConfigs</strong></td><td>Saves Datadog configuration settings for the integration.</td></tr><tr><td>2</td><td><strong>POST /api/addDatadogIntegration</strong></td><td>Adds or updates the Datadog integration configuration.</td></tr><tr><td>3</td><td><strong>POST /api/deleteDatadogIntegration</strong></td><td>Removes the Datadog integration configuration.</td></tr><tr><td>4</td><td><strong>POST /api/testDatadogIntegration</strong></td><td>Tests the Datadog integration by sending a test event to verify connectivity.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/saveDataDogConfigs" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/addDatadogIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteDatadogIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/testDatadogIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Splunk

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="420">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/addSplunkIntegration</strong></td><td>Adds or updates the Splunk SIEM integration configuration.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/addSplunkIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Azure Data Explorer (ADX)

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="420">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/addAdxIntegration</strong></td><td>Adds or updates the Azure Data Explorer integration configuration.</td></tr><tr><td>2</td><td><strong>POST /api/removeAdxIntegration</strong></td><td>Removes the Azure Data Explorer integration configuration.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/addAdxIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/removeAdxIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## DevRev

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="420">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/addDevRevIntegration</strong></td><td>Adds or updates the DevRev integration configuration.</td></tr><tr><td>2</td><td><strong>POST /api/removeDevRevIntegration</strong></td><td>Removes the DevRev integration configuration.</td></tr><tr><td>3</td><td><strong>POST /api/createDevRevTickets</strong></td><td>Creates DevRev tickets linked to Akto testing run issues.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/addDevRevIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/removeDevRevIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/createDevRevTickets" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## ServiceNow

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="420">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/addServiceNowIntegration</strong></td><td>Adds or updates the ServiceNow integration configuration.</td></tr><tr><td>2</td><td><strong>POST /api/removeServiceNowIntegration</strong></td><td>Removes the ServiceNow integration configuration.</td></tr><tr><td>3</td><td><strong>POST /api/createServiceNowTicket</strong></td><td>Creates a ServiceNow ticket linked to an Akto testing run issue.</td></tr><tr><td>4</td><td><strong>POST /api/bulkCreateServiceNowTickets</strong></td><td>Bulk creates ServiceNow tickets for multiple Akto testing run issues in a single request.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/addServiceNowIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/removeServiceNowIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/createServiceNowTicket" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/bulkCreateServiceNowTickets" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Microsoft Defender

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="420">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/addMicrosoftDefenderIntegration</strong></td><td>Adds or updates the Microsoft Defender for Endpoint integration configuration.</td></tr><tr><td>2</td><td><strong>POST /api/removeMicrosoftDefenderIntegration</strong></td><td>Removes the Microsoft Defender for Endpoint integration configuration.</td></tr><tr><td>3</td><td><strong>POST /api/uploadDefenderScript</strong></td><td>Uploads a script to the Microsoft Defender Live Response library.</td></tr><tr><td>4</td><td><strong>POST /api/runDefenderKqlQuery</strong></td><td>Executes a KQL (Kusto Query Language) query against Microsoft Defender data.</td></tr><tr><td>5</td><td><strong>POST /api/runDefenderLiveResponse</strong></td><td>Runs a Live Response session or script on a device via Microsoft Defender.</td></tr><tr><td>6</td><td><strong>POST /api/ingestDefenderKqlResults</strong></td><td>Ingests and processes KQL query results from Microsoft Defender into Akto.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/addMicrosoftDefenderIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/removeMicrosoftDefenderIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/uploadDefenderScript" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/runDefenderKqlQuery" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/runDefenderLiveResponse" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/ingestDefenderKqlResults" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## SentinelOne

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="420">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/addSentinelOneIntegration</strong></td><td>Adds or updates the SentinelOne integration configuration.</td></tr><tr><td>2</td><td><strong>POST /api/removeSentinelOneIntegration</strong></td><td>Removes the SentinelOne integration configuration.</td></tr><tr><td>3</td><td><strong>POST /api/executeSentinelOneRemoteScript</strong></td><td>Executes a remote script on a SentinelOne-enrolled endpoint.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/addSentinelOneIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/removeSentinelOneIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/executeSentinelOneRemoteScript" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Generic Integrations

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="420">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/testIntegration</strong></td><td>Tests a configured integration by sending a test payload to verify connectivity.</td></tr><tr><td>2</td><td><strong>POST /api/addIntegration</strong></td><td>Adds or updates a generic integration configuration by type.</td></tr><tr><td>3</td><td><strong>POST /api/markConnectionAsSkipped</strong></td><td>Marks an integration connection as skipped during setup or onboarding.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/testIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/addIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/markConnectionAsSkipped" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Slack Webhooks

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="420">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/addSlackWebhook</strong></td><td>Adds a new Slack webhook integration for alert and notification delivery.</td></tr><tr><td>2</td><td><strong>POST /api/deleteSlackWebhook</strong></td><td>Removes a configured Slack webhook integration.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/addSlackWebhook" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteSlackWebhook" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Custom Webhooks

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="420">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/addCustomWebhook</strong></td><td>Adds a new custom webhook integration for event notifications.</td></tr><tr><td>2</td><td><strong>POST /api/checkWebhook</strong></td><td>Tests a custom webhook by sending a test request to verify connectivity and response.</td></tr><tr><td>3</td><td><strong>POST /api/updateCustomWebhook</strong></td><td>Updates an existing custom webhook integration configuration.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/addCustomWebhook" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/checkWebhook" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateCustomWebhook" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}
