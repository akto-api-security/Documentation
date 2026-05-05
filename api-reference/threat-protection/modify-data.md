# Modify Data

## Table of Contents

* [#guardrails-and-prompts](modify-data.md#guardrails-and-prompts "mention")

## Guardrails & Prompts

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="370">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/createGuardrailPolicy</strong></td><td>Create a new Agentic Guardrails Policy to protect Agentic components.</td></tr><tr><td>2</td><td><strong>POST /api/modifyThreatActorStatus</strong></td><td>Update the status of a threat actor or malicious source.</td></tr><tr><td>3</td><td><strong>POST /api/deleteGuardrailPolicies</strong></td><td>Delete one or more Agentic Guardrails Policies.</td></tr><tr><td>4</td><td><strong>POST /api/deleteMaliciousEvents</strong></td><td>Bulk delete Agentic Guardrail Activity or malicious events.</td></tr><tr><td>5</td><td><strong>POST /api/updateMaliciousEventStatus</strong></td><td>Update the status of an Agentic Guardrail Activity or malicious event.</td></tr><tr><td>6</td><td><strong>POST /api/addThreatActivityWebhookIntegration</strong></td><td>Add Agentic Guardrail Activity webhook integration.</td></tr><tr><td>7</td><td><strong>POST /api/bulkModifyThreatActorStatusCloudflare</strong></td><td>Bulk modify threat actor status in Cloudflare WAF.</td></tr><tr><td>8</td><td><strong>POST /api/modifyThreatActorStatusCloudflare</strong></td><td>Modify threat actor status in Cloudflare WAF.</td></tr><tr><td>9</td><td><strong>POST /api/modifyThreatConfiguration</strong></td><td>Modify threat detection configuration settings.</td></tr><tr><td>10</td><td><strong>POST /api/deleteAllMaliciousEvents</strong></td><td>Delete all malicious events from the system.</td></tr><tr><td>11</td><td><strong>POST /api/addCloudflareWafIntegration</strong></td><td>Add Cloudflare WAF integration.</td></tr><tr><td>12</td><td><strong>POST /api/deleteCloudflareWafIntegration</strong></td><td>Delete Cloudflare WAF integration.</td></tr><tr><td>13</td><td><strong>POST /api/addAwsWafIntegration</strong></td><td>Add AWS WAF integration.</td></tr><tr><td>14</td><td><strong>POST /api/addAdvancedFiltersForTraffic</strong></td><td>Add advanced filters for traffic filtering.</td></tr><tr><td>15</td><td><strong>POST /api/deleteAdvancedFilter</strong></td><td>Delete an advanced traffic filter.</td></tr><tr><td>16</td><td><strong>POST /api/changeStateOfFilter</strong></td><td>Change the active/inactive state of a filter.</td></tr><tr><td>17</td><td><strong>POST /api/dryRunAdvancedFilters</strong></td><td>Perform dry run of advanced filters to test traffic filtering.</td></tr><tr><td>18</td><td><strong>POST /api/apiInfo/bulkAgentProxyGuardrail</strong></td><td>Applies guardrail configurations in bulk across multiple agent proxy Agentic components.</td></tr><tr><td>19</td><td><strong>POST /api/guardrailPlayground</strong></td><td>Scans and previews guardrail rules against sample inputs in a sandbox environment.</td></tr><tr><td>20</td><td><strong>POST /api/saveGuardrailsConfig</strong></td><td>Saves or updates the guardrails configuration for the organization.</td></tr><tr><td>21</td><td><strong>POST /api/executeGuardrails</strong></td><td>Executes configured guardrails against specified inputs or traffic.</td></tr><tr><td>22</td><td><strong>POST /api/exportGuardrailActivityToAdx</strong></td><td>Exports guardrail activity logs and events to Azure Data Explorer (ADX).</td></tr><tr><td>23</td><td><strong>POST /api/savePrompt</strong></td><td>Saves or updates a system prompt configuration.</td></tr><tr><td>24</td><td><strong>POST /api/deletePrompt</strong></td><td>Deletes an existing system prompt.</td></tr><tr><td>25</td><td><strong>POST /api/togglePromptStatus</strong></td><td>Toggles the active/inactive status of a system prompt.</td></tr><tr><td>26</td><td><strong>POST /api/testSystemPrompt</strong></td><td>Scans a system prompt against sample inputs to validate its behavior.</td></tr><tr><td>27</td><td><strong>POST /api/generateMaliciousUserInput</strong></td><td>Generates adversarial user inputs to scan guardrail and prompt robustness.</td></tr><tr><td>28</td><td><strong>POST /api/hardenSystemPrompt</strong></td><td>Analyzes and hardens a system prompt to improve its resistance to adversarial inputs.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/modifyThreatActorStatus" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/createGuardrailPolicy" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteGuardrailPolicies" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}


{% openapi-operation spec="akto-agentic-security-api" path="/api/updateMaliciousEventStatus" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteMaliciousEvents" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/addThreatActivityWebhookIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/bulkModifyThreatActorStatusCloudflare" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/modifyThreatActorStatusCloudflare" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/modifyThreatConfiguration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteAllMaliciousEvents" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/addCloudflareWafIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteCloudflareWafIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/addAwsWafIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/addAdvancedFiltersForTraffic" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteAdvancedFilter" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/changeStateOfFilter" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/dryRunAdvancedFilters" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/apiInfo/bulkAgentProxyGuardrail" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/guardrailPlayground" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/saveGuardrailsConfig" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/executeGuardrails" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/exportGuardrailActivityToAdx" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/savePrompt" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deletePrompt" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/togglePromptStatus" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/testSystemPrompt" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/generateMaliciousUserInput" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/hardenSystemPrompt" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}
