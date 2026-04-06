# Fetch Data

<table data-full-width="true"><thead><tr><th width="501.8798828125">API</th><th>Description</th></tr></thead><tbody><tr><td><strong>POST /api/fetchThreatActors</strong></td><td>Fetch guardrail actors (malicious sources) and their threat scores.</td></tr><tr><td><strong>POST /api/fetchThreatApis</strong></td><td>Retrieve Agentic components targeted by guardrails or malicious traffic.</td></tr><tr><td><strong>POST /api/fetchThreatData</strong></td><td>Fetch comprehensive guardrail and malicious attack data.</td></tr><tr><td><strong>POST /api/fetchThreatTopNData</strong></td><td>Get the top N guardrail or malicious activities by frequency or impact.</td></tr><tr><td><strong>POST /api/fetchThreatCategoryCount</strong></td><td>Get the count of guardrail events grouped by policy category.</td></tr><tr><td><strong>POST /api/fetchThreatComplianceInfos</strong></td><td>Retrieve guardrail and threat compliance information.</td></tr><tr><td><strong>POST /api/getIpReputationScore</strong></td><td>Get the threat score for a specific IP address.</td></tr><tr><td><strong>POST /api/fetchGuardrailPolicies</strong></td><td>Fetch all configured guardrail policies.</td></tr><tr><td><strong>POST /api/fetchGuardrailData</strong></td><td>Retrieve comprehensive guardrail detection and response data.</td></tr><tr><td><strong>POST /api/fetchAggregateMaliciousRequests</strong></td><td>Fetch aggregated malicious request data.</td></tr><tr><td><strong>POST /api/getActorsCountPerCounty</strong></td><td>Get the count of threat actors or malicious sources per country.</td></tr><tr><td><strong>POST /api/getDailyThreatActorsCount</strong></td><td>Retrieve the daily count of active guardrail actors or malicious sources.</td></tr><tr><td><strong>POST /api/fetchSessionContext</strong></td><td>Fetch session context and metadata for guardrail or malicious events.</td></tr><tr><td><strong>POST /api/fetchSuspectSampleData</strong></td><td>Fetch sample payloads from suspected malicious requests.</td></tr><tr><td><strong>POST /api/fetchCountBySeverity</strong></td><td>Retrieve the count of guardrail events grouped by severity level.</td></tr></tbody></table>

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
