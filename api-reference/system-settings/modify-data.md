# Modify Data

## System & Health

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="420">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/sendHealthCheck</strong></td><td>Sends a health check request to verify system status and connectivity.</td></tr><tr><td>2</td><td><strong>POST /api/deleteModuleInfo</strong></td><td>Deletes information or data for a specified system module.</td></tr><tr><td>3</td><td><strong>POST /api/rebootModules</strong></td><td>Reboots specified system modules.</td></tr><tr><td>4</td><td><strong>POST /api/updateModuleEnvAndReboot</strong></td><td>Updates environment variables for modules and triggers a reboot.</td></tr><tr><td>5</td><td><strong>POST /api/takeUpdate</strong></td><td>Applies a system update and restarts affected components.</td></tr><tr><td>6</td><td><strong>POST /api/closeLoader</strong></td><td>Closes or dismisses the system loader/initialization interface.</td></tr><tr><td>7</td><td><strong>POST /api/skipOnboarding</strong></td><td>Skips the onboarding process for the current session or user.</td></tr><tr><td>8</td><td><strong>POST /api/runTestOnboarding</strong></td><td>Runs the onboarding test sequence to validate system configuration.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/sendHealthCheck" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteModuleInfo" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/rebootModules" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateModuleEnvAndReboot" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/takeUpdate" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/closeLoader" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/skipOnboarding" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/runTestOnboarding" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Settings & Toggles

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="420">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/modifyAccountSettings</strong></td><td>Updates account-level settings and configurations.</td></tr><tr><td>2</td><td><strong>POST /api/updateAktoUIMode</strong></td><td>Updates the UI mode/theme for the Akto platform (light, dark, etc.).</td></tr><tr><td>3</td><td><strong>POST /api/toggleRedactFeature</strong></td><td>Toggles the sensitive data redaction feature on or off.</td></tr><tr><td>4</td><td><strong>POST /api/toggleCaseSensitiveApis</strong></td><td>Toggles case-sensitive API matching and comparison.</td></tr><tr><td>5</td><td><strong>POST /api/switchTestingModule</strong></td><td>Switches between different security testing modules.</td></tr><tr><td>6</td><td><strong>POST /api/enableMergingOnVersionsInApis</strong></td><td>Enables API version merging and consolidation.</td></tr><tr><td>7</td><td><strong>POST /api/updateMergeAsyncOutside</strong></td><td>Updates settings for asynchronous API merging outside the main flow.</td></tr><tr><td>8</td><td><strong>POST /api/updateGlobalRateLimit</strong></td><td>Updates the global rate limiting configuration for all APIs.</td></tr><tr><td>9</td><td><strong>POST /api/updateIgnoreTimeForSummaries</strong></td><td>Updates the time window to ignore when generating summary reports.</td></tr><tr><td>10</td><td><strong>POST /api/updatePrivateCidrIps</strong></td><td>Updates the list of private CIDR IP ranges for the organization.</td></tr><tr><td>11</td><td><strong>POST /api/addMatchingPatternForProxy</strong></td><td>Adds URL matching patterns for proxy configuration.</td></tr><tr><td>12</td><td><strong>POST /api/updatePartnerIps</strong></td><td>Updates the list of partner IP addresses for access control.</td></tr><tr><td>13</td><td><strong>POST /api/toggleNewMergingEnabled</strong></td><td>Toggles the new API merging algorithm or approach.</td></tr><tr><td>14</td><td><strong>POST /api/toggleDoBodyMatch</strong></td><td>Toggles body-based matching for API requests and responses.</td></tr><tr><td>15</td><td><strong>POST /api/toggleTelemetry</strong></td><td>Toggles telemetry and usage tracking features.</td></tr><tr><td>16</td><td><strong>POST /api/updateUrlSettings</strong></td><td>Updates URL-related settings and configurations.</td></tr><tr><td>17</td><td><strong>POST /api/toggleDebugLogsFeature</strong></td><td>Toggles debug logging for troubleshooting and diagnostics.</td></tr><tr><td>18</td><td><strong>POST /api/updateSetupType</strong></td><td>Updates the deployment setup type (cloud, self-hosted, etc.).</td></tr><tr><td>19</td><td><strong>POST /api/updateTrafficAlertThresholdSeconds</strong></td><td>Updates the time threshold for traffic alert triggering.</td></tr><tr><td>20</td><td><strong>POST /api/toggleArchivalEnabled</strong></td><td>Toggles data archival functionality for historical data management.</td></tr><tr><td>21</td><td><strong>POST /api/updateRetrospectiveFilterSettings</strong></td><td>Updates retrospective filter configurations and rules.</td></tr><tr><td>22</td><td><strong>POST /api/updateCompulsoryDescription</strong></td><td>Updates requirements for API descriptions and documentation.</td></tr><tr><td>23</td><td><strong>POST /api/updateBlockLogs</strong></td><td>Updates logging configuration for blocked or rejected requests.</td></tr><tr><td>24</td><td><strong>POST /api/updateFilterLogPolicy</strong></td><td>Updates the policy for filtering and managing logs.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/modifyAccountSettings" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateAktoUIMode" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/toggleRedactFeature" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/toggleCaseSensitiveApis" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/switchTestingModule" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/enableMergingOnVersionsInApis" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateMergeAsyncOutside" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateGlobalRateLimit" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateIgnoreTimeForSummaries" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updatePrivateCidrIps" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/addMatchingPatternForProxy" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updatePartnerIps" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/toggleNewMergingEnabled" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/toggleDoBodyMatch" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/toggleTelemetry" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateUrlSettings" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/toggleDebugLogsFeature" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateSetupType" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateTrafficAlertThresholdSeconds" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/toggleArchivalEnabled" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateRetrospectiveFilterSettings" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateCompulsoryDescription" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateBlockLogs" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateFilterLogPolicy" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Runtime & Infrastructure

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="420">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>GET /api/checkStackCreationProgress</strong></td><td>Checks the progress of runtime stack creation or deployment.</td></tr><tr><td>2</td><td><strong>POST /api/createRuntimeStack</strong></td><td>Initiates creation of a new runtime stack for deployment.</td></tr><tr><td>3</td><td><strong>POST /api/addAwsAccountIdsForApiGatewayLogging</strong></td><td>Adds AWS account IDs to enable API Gateway logging for traffic analysis.</td></tr><tr><td>4</td><td><strong>POST /api/saveLoadBalancers</strong></td><td>Saves and updates load balancer configurations.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/checkStackCreationProgress" method="get" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/createRuntimeStack" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/addAwsAccountIdsForApiGatewayLogging" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/saveLoadBalancers" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Logs, Audit & Traffic

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="420">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/updateAuditData</strong></td><td>Updates audit logs and tracking records for compliance and forensics.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateAuditData" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Dashboard, Filters & Misc

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="420">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/saveDashboardLayout</strong></td><td>Saves the user's custom dashboard layout configuration.</td></tr><tr><td>2</td><td><strong>POST /api/saveTagConfig</strong></td><td>Saves tag configurations and taxonomy settings.</td></tr><tr><td>3</td><td><strong>GET /api/reviewTagConfig</strong></td><td>Submits tag configuration for review and approval.</td></tr><tr><td>4</td><td><strong>POST /api/toggleActiveTagConfig</strong></td><td>Toggles a tag configuration between active and inactive states.</td></tr><tr><td>5</td><td><strong>POST /api/saveFilterYamlTemplate</strong></td><td>Saves a custom YAML filter template for reuse.</td></tr><tr><td>6</td><td><strong>POST /api/deleteFilterYamlTemplate</strong></td><td>Deletes a saved YAML filter template.</td></tr><tr><td>7</td><td><strong>POST /api/addFilterHeaderValueMap</strong></td><td>Adds header value mappings to filter configurations.</td></tr><tr><td>8</td><td><strong>POST /api/saveBrowserExtensionConfig</strong></td><td>Saves browser extension settings and configurations.</td></tr><tr><td>9</td><td><strong>POST /api/deleteBrowserExtensionConfigs</strong></td><td>Deletes browser extension configurations.</td></tr><tr><td>10</td><td><strong>POST /api/handleRefreshTableCount</strong></td><td>Handles refresh of table data and record counts.</td></tr><tr><td>11</td><td><strong>POST /api/send_event</strong></td><td>Sends custom events for analytics and tracking.</td></tr><tr><td>12</td><td><strong>POST /api/markAlertAsDismissed</strong></td><td>Marks security alerts as dismissed or acknowledged.</td></tr><tr><td>13</td><td><strong>GET /api/getAllTrafficAlerts</strong></td><td>Retrieves and processes all active traffic alerts.</td></tr><tr><td>14</td><td><strong>POST /api/wrapped</strong></td><td>Generates or processes wrapped/summarized reports.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/saveDashboardLayout" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/saveTagConfig" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/reviewTagConfig" method="get" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/toggleActiveTagConfig" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/saveFilterYamlTemplate" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteFilterYamlTemplate" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/addFilterHeaderValueMap" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/saveBrowserExtensionConfig" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteBrowserExtensionConfigs" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/handleRefreshTableCount" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/send_event" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/markAlertAsDismissed" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getAllTrafficAlerts" method="get" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/wrapped" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Maintenance

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="420">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/cleanNonHostApiInfos</strong></td><td>Cleans up API information for non-host endpoints, removing stale data.</td></tr><tr><td>2</td><td><strong>POST /api/deleteOptionAndSlashApis</strong></td><td>Deletes OPTIONS and SLASH method API endpoints from the catalog.</td></tr><tr><td>3</td><td><strong>POST /api/deleteExtraApiInfo</strong></td><td>Removes extra or redundant API information entries.</td></tr><tr><td>4</td><td><strong>POST /api/deleteDuplicateEntries</strong></td><td>Removes duplicate API entries to maintain catalog integrity.</td></tr><tr><td>5</td><td><strong>POST /api/deleteNonHostSTIs</strong></td><td>Deletes Sensitive Technology Indicators (STIs) for non-host APIs.</td></tr><tr><td>6</td><td><strong>POST /api/unsetTemp</strong></td><td>Clears temporary flags and settings used during operations.</td></tr><tr><td>7</td><td><strong>POST /api/dryRunAdvancedFilters</strong></td><td>Performs a test run of advanced filter configurations without applying changes.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/cleanNonHostApiInfos" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteOptionAndSlashApis" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteExtraApiInfo" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteDuplicateEntries" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteNonHostSTIs" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/unsetTemp" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/dryRunAdvancedFilters" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}
