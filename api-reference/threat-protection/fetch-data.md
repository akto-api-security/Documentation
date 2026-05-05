# Fetch Data

## Table of Contents

* [#guardrails-and-prompts](fetch-data.md#guardrails-and-prompts "mention")

## Guardrails & Prompts

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="450">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/fetchThreatActors</strong></td><td>Fetch guardrail actors (malicious sources) and their threat scores.</td></tr><tr><td>2</td><td><strong>POST /api/fetchThreatApis</strong></td><td>Retrieve Agentic components targeted by guardrails or malicious traffic.</td></tr><tr><td>3</td><td><strong>POST /api/fetchThreatData</strong></td><td>Fetch comprehensive Agentic Guardrail Activity and malicious attack data.</td></tr><tr><td>4</td><td><strong>POST /api/fetchThreatTopNData</strong></td><td>Get the top N Agentic Guardrail Activity or malicious activities by frequency or impact.</td></tr><tr><td>5</td><td><strong>POST /api/fetchThreatCategoryCount</strong></td><td>Get the count of Agentic Guardrails Policy Triggered events grouped by policy category.</td></tr><tr><td>6</td><td><strong>POST /api/fetchThreatComplianceInfos</strong></td><td>Retrieve Agentic Guardrails and threat compliance information.</td></tr><tr><td>7</td><td><strong>POST /api/getIpReputationScore</strong></td><td>Get the threat score for a specific IP address.</td></tr><tr><td>8</td><td><strong>POST /api/fetchGuardrailPolicies</strong></td><td>Fetch all configured Agentic Guardrails policies.</td></tr><tr><td>9</td><td><strong>POST /api/fetchGuardrailData</strong></td><td>Retrieve comprehensive Agentic Guardrails detection and response data.</td></tr><tr><td>10</td><td><strong>POST /api/fetchAggregateMaliciousRequests</strong></td><td>Fetch aggregated malicious Agentic Request data.</td></tr><tr><td>11</td><td><strong>POST /api/getActorsCountPerCounty</strong></td><td>Get the count of threat actors or malicious sources per country.</td></tr><tr><td>12</td><td><strong>POST /api/getDailyThreatActorsCount</strong></td><td>Retrieve the daily count of active Agentic Guardrails actors or malicious sources.</td></tr><tr><td>13</td><td><strong>POST /api/fetchSessionContext</strong></td><td>Fetch session context and metadata for Agentic Guardrails or malicious events.</td></tr><tr><td>14</td><td><strong>POST /api/fetchSuspectSampleData</strong></td><td>Fetch sample payloads from suspected malicious Agentic Requests.</td></tr><tr><td>15</td><td><strong>POST /api/fetchCountBySeverity</strong></td><td>Retrieve the count of Agentic Guardrails events grouped by severity level.</td></tr><tr><td>16</td><td><strong>POST /api/fetchFiltersForThreatActors</strong></td><td>Fetch filters for threat actors.</td></tr><tr><td>17</td><td><strong>POST /api/fetchFiltersThreatTable</strong></td><td>Fetch filters for threat detection table.</td></tr><tr><td>18</td><td><strong>POST /api/fetchThreatActivityWebhookIntegration</strong></td><td>Fetch Agentic Guardrail Activity webhook integration configuration.</td></tr><tr><td>19</td><td><strong>POST /api/fetchThreatConfiguration</strong></td><td>Fetch current threat detection configuration.</td></tr><tr><td>20</td><td><strong>POST /api/fetchThreatsForActor</strong></td><td>Fetch all threats detected for a specific actor.</td></tr><tr><td>21</td><td><strong>POST /api/getThreatActivityTimeline</strong></td><td>Get Agentic Guardrail Activity timeline for visualization.</td></tr><tr><td>22</td><td><strong>POST /api/fetchCloudflareWafIntegration</strong></td><td>Fetch Cloudflare WAF integration details.</td></tr><tr><td>23</td><td><strong>POST /api/fetchAwsWafIntegration</strong></td><td>Fetch AWS WAF integration details.</td></tr><tr><td>24</td><td><strong>POST /api/fetchApiStats</strong></td><td>Fetch Agentic Component statistics and metrics.</td></tr><tr><td>25</td><td><strong>POST /api/fetchAdvancedFiltersForTraffic</strong></td><td>Fetch all advanced traffic filters.</td></tr><tr><td>26</td><td><strong>POST /api/getGuardrailTypes</strong></td><td>Fetches all available guardrail types and their configurations.</td></tr><tr><td>27</td><td><strong>POST /api/fetchAllPrompts</strong></td><td>Fetches all saved system prompts and their configurations.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchSuspectSampleData" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchThreatActors" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchAggregateMaliciousRequests" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchCountBySeverity" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchThreatApis" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchThreatCategoryCount" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getDailyThreatActorsCount" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getActorsCountPerCounty" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchRemediationInfo" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchGuardrailPolicies" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchSessionContext" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchThreatData" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchGuardrailData" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchThreatTopNData" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchThreatComplianceInfos" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getIpReputationScore" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchFiltersForThreatActors" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchFiltersThreatTable" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchThreatActivityWebhookIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchThreatConfiguration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchThreatsForActor" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getThreatActivityTimeline" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchCloudflareWafIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchAwsWafIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchApiStats" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchAdvancedFiltersForTraffic" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getGuardrailTypes" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchAllPrompts" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}
