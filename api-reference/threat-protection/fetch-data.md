# Fetch Data

<table data-full-width="true"><thead><tr><th width="413.728515625">API</th><th>Description</th></tr></thead><tbody><tr><td><strong>POST /api/fetchSuspectSampleData</strong></td><td>Fetch suspicious sample request/response data flagged during guardrail detection.</td></tr><tr><td><strong>POST /api/fetchThreatActors</strong></td><td>Retrieve details of identified guardrail actors (malicious sources).</td></tr><tr><td><strong>POST /api/fetchFiltersThreatTable</strong></td><td>Fetch available filters for organizing and querying the guardrail table.</td></tr><tr><td><strong>POST /api/getThreatActivityTimeline</strong></td><td>Retrieve the activity timeline of guardrails across a given period.</td></tr><tr><td><strong>POST /api/fetchAggregateMaliciousRequests</strong></td><td>Get aggregated statistics of malicious requests detected across APIs.</td></tr><tr><td><strong>POST /api/fetchCountBySeverity</strong></td><td>Retrieve counts of guardrails grouped by severity (Critical, High, Medium, Low).</td></tr><tr><td><strong>POST /api/fetchRemediationInfo</strong></td><td>Fetch remediation details and guidance for specific guardrails or issues.</td></tr><tr><td><strong>POST /api/fetchThreatApis</strong></td><td>Get the list of APIs targeted by guardrails or malicious traffic.</td></tr><tr><td><strong>POST /api/fetchThreatCategoryCount</strong></td><td>Retrieve the count of guardrails grouped by categories (e.g., Injection, Auth, DoS).</td></tr><tr><td><strong>POST /api/fetchFilterYamlTemplate</strong></td><td>Fetch the YAML template for building custom filters for guardrail analysis.</td></tr><tr><td><strong>POST /api/fetchFiltersForThreatActors</strong></td><td>Retrieve filter options for drilling into guardrail actor activity.</td></tr><tr><td><strong>POST /api/getDailyThreatActorsCount</strong></td><td>Get the count of active guardrail actors observed per day.</td></tr><tr><td><strong>POST /api/getActorsCountPerCounty</strong></td><td>Retrieve the distribution of guardrail actors grouped by country.</td></tr></tbody></table>

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
