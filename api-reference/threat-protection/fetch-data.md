# Fetch Data

<table data-full-width="true"><thead><tr><th width="413.728515625">API</th><th>Description</th></tr></thead><tbody><tr><td><strong>POST /api/fetchSuspectSampleData</strong></td><td>Fetch suspicious sample request/response data flagged during guardrail detection.</td></tr><tr><td><strong>POST /api/fetchThreatActors</strong></td><td>Retrieve details of identified guardrail actors (malicious sources).</td></tr><tr><td><strong>POST /api/fetchFiltersThreatTable</strong></td><td>Fetch available filters for organizing and querying the guardrail table.</td></tr><tr><td><strong>POST /api/getThreatActivityTimeline</strong></td><td>Retrieve the activity timeline of guardrails across a given period.</td></tr><tr><td><strong>POST /api/fetchAggregateMaliciousRequests</strong></td><td>Get aggregated statistics of malicious requests detected across Agentic Components.</td></tr><tr><td><strong>POST /api/fetchCountBySeverity</strong></td><td>Retrieve counts of guardrails grouped by severity (Critical, High, Medium, Low).</td></tr><tr><td><strong>POST /api/fetchRemediationInfo</strong></td><td>Fetch remediation details and guidance for specific guardrails or issues.</td></tr><tr><td><strong>POST /api/fetchThreatApis</strong></td><td>Get the list of Agentic Components targeted by guardrails or malicious traffic.</td></tr><tr><td><strong>POST /api/fetchThreatCategoryCount</strong></td><td>Retrieve the count of guardrails grouped by categories (e.g., Injection, Auth, DoS).</td></tr><tr><td><strong>POST /api/fetchFilterYamlTemplate</strong></td><td>Fetch the YAML template for building custom filters for guardrail analysis.</td></tr><tr><td><strong>POST /api/fetchFiltersForThreatActors</strong></td><td>Retrieve filter options for drilling into guardrail actor activity.</td></tr><tr><td><strong>POST /api/getDailyThreatActorsCount</strong></td><td>Get the count of active guardrail actors observed per day.</td></tr><tr><td><strong>POST /api/getActorsCountPerCounty</strong></td><td>Retrieve the distribution of guardrail actors grouped by country.</td></tr><tr><td><strong>POST /api/fetchGuardrailPolicies</strong></td><td>Retrieve all guardrail policies in the account with pagination support.</td></tr><tr><td><strong>POST /api/fetchSessionContext</strong></td><td>Get session context for session-based guardrail events and related activities.</td></tr><tr><td><strong>POST /api/fetchMcpdata</strong></td><td>Get count of API endpoints protected by guardrail policies.</td></tr><tr><td><strong>POST /api/fetchBrowserExtensionConfigs</strong></td><td>List all browser extension configurations for guardrail monitoring.</td></tr><tr><td><strong>POST /api/fetchThreatData</strong></td><td>Get consolidated threat dashboard metrics and summary view.</td></tr><tr><td><strong>POST /api/fetchGuardrailData</strong></td><td>Get consolidated guardrail dashboard metrics, posture, and trends.</td></tr><tr><td><strong>POST /api/fetchThreatTopNData</strong></td><td>Get top 5 APIs and hosts by threat count and severity level.</td></tr><tr><td><strong>POST /api/fetchThreatComplianceInfos</strong></td><td>Get compliance-related threat data and impact on compliance status.</td></tr><tr><td><strong>POST /api/getIpReputationScore</strong></td><td>Get reputation and threat score for an IP address.</td></tr></tbody></table>

{% openapi-operation spec="protectionfetch" path="/api/fetchSuspectSampleData" method="post" %}
[OpenAPI protectionfetch](https://pastebin.com/raw/sTgtjUgL)
{% endopenapi-operation %}

{% openapi-operation spec="protectionfetch" path="/api/fetchThreatActors" method="post" %}
[OpenAPI protectionfetch](https://pastebin.com/raw/sTgtjUgL)
{% endopenapi-operation %}

{% openapi-operation spec="protectionfetch" path="/api/fetchFiltersThreatTable" method="post" %}
[OpenAPI protectionfetch](https://pastebin.com/raw/sTgtjUgL)
{% endopenapi-operation %}

{% openapi-operation spec="protectionfetch" path="/api/getThreatActivityTimeline" method="post" %}
[OpenAPI protectionfetch](https://pastebin.com/raw/sTgtjUgL)
{% endopenapi-operation %}

{% openapi-operation spec="protectionfetch" path="/api/fetchAggregateMaliciousRequests" method="post" %}
[OpenAPI protectionfetch](https://pastebin.com/raw/sTgtjUgL)
{% endopenapi-operation %}

{% openapi-operation spec="protectionfetch" path="/api/fetchCountBySeverity" method="post" %}
[OpenAPI protectionfetch](https://pastebin.com/raw/sTgtjUgL)
{% endopenapi-operation %}

{% openapi-operation spec="protectionfetch" path="/api/fetchRemediationInfo" method="post" %}
[OpenAPI protectionfetch](https://pastebin.com/raw/sTgtjUgL)
{% endopenapi-operation %}

{% openapi-operation spec="protectionfetch" path="/api/fetchThreatApis" method="post" %}
[OpenAPI protectionfetch](https://pastebin.com/raw/sTgtjUgL)
{% endopenapi-operation %}

{% openapi-operation spec="protectionfetch" path="/api/fetchThreatCategoryCount" method="post" %}
[OpenAPI protectionfetch](https://pastebin.com/raw/sTgtjUgL)
{% endopenapi-operation %}

{% openapi-operation spec="protectionfetch" path="/api/fetchFilterYamlTemplate" method="post" %}
[OpenAPI protectionfetch](https://pastebin.com/raw/sTgtjUgL)
{% endopenapi-operation %}

{% openapi-operation spec="protectionfetch" path="/api/fetchFiltersForThreatActors" method="post" %}
[OpenAPI protectionfetch](https://pastebin.com/raw/sTgtjUgL)
{% endopenapi-operation %}

{% openapi-operation spec="protectionfetch" path="/api/getDailyThreatActorsCount" method="post" %}
[OpenAPI protectionfetch](https://pastebin.com/raw/sTgtjUgL)
{% endopenapi-operation %}

{% openapi-operation spec="protectionfetch" path="/api/getActorsCountPerCounty" method="post" %}
[OpenAPI protectionfetch](https://pastebin.com/raw/sTgtjUgL)
{% endopenapi-operation %}

{% openapi-operation spec="protectionfetch" path="/api/fetchGuardrailPolicies" method="post" %}
[OpenAPI protectionfetch](https://pastebin.com/raw/sTgtjUgL)
{% endopenapi-operation %}

{% openapi-operation spec="protectionfetch" path="/api/fetchSessionContext" method="post" %}
[OpenAPI protectionfetch](https://pastebin.com/raw/sTgtjUgL)
{% endopenapi-operation %}

{% openapi-operation spec="protectionfetch" path="/api/fetchMcpdata" method="post" %}
[OpenAPI protectionfetch](https://pastebin.com/raw/sTgtjUgL)
{% endopenapi-operation %}

{% openapi-operation spec="protectionfetch" path="/api/fetchBrowserExtensionConfigs" method="post" %}
[OpenAPI protectionfetch](https://pastebin.com/raw/sTgtjUgL)
{% endopenapi-operation %}

{% openapi-operation spec="protectionfetch" path="/api/fetchThreatData" method="post" %}
[OpenAPI protectionfetch](https://pastebin.com/raw/sTgtjUgL)
{% endopenapi-operation %}

{% openapi-operation spec="protectionfetch" path="/api/fetchGuardrailData" method="post" %}
[OpenAPI protectionfetch](https://pastebin.com/raw/sTgtjUgL)
{% endopenapi-operation %}

{% openapi-operation spec="protectionfetch" path="/api/fetchThreatTopNData" method="post" %}
[OpenAPI protectionfetch](https://pastebin.com/raw/sTgtjUgL)
{% endopenapi-operation %}

{% openapi-operation spec="protectionfetch" path="/api/fetchThreatComplianceInfos" method="post" %}
[OpenAPI protectionfetch](https://pastebin.com/raw/sTgtjUgL)
{% endopenapi-operation %}

{% openapi-operation spec="protectionfetch" path="/api/getIpReputationScore" method="post" %}
[OpenAPI protectionfetch](https://pastebin.com/raw/sTgtjUgL)
{% endopenapi-operation %}
