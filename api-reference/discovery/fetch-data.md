# Fetch Data

<table data-full-width="true"><thead><tr><th width="427.5712890625">API</th><th>Description</th></tr></thead><tbody><tr><td><strong>POST /api/getAllCollectionsBasic</strong></td><td>Fetch a lightweight list of all agentic collections with only basic metadata. Useful for quick lookups or dropdowns.</td></tr><tr><td><strong>POST /api/getAllCollections</strong></td><td>Retrieve the complete list of all agentic collections with detailed information.</td></tr><tr><td><strong>POST /api/getAllUsersCollections</strong></td><td>Fetch all agentic collections accessible to the current user.</td></tr><tr><td><strong>POST /api/getCoverageInfoForCollections</strong></td><td>Get scan coverage data for each collection (e.g., how many endpoints are tested vs. untested). Used to track which agentic components are covered by scans.</td></tr><tr><td><strong>POST /api/getSeverityInfoForCollections</strong></td><td>Retrieve aggregated severity information (High, Medium, Low) across agentic collections.</td></tr><tr><td><strong>POST /api/getSeveritiesCountPerCollection</strong></td><td>Get the count of issues grouped by severity for each collection.</td></tr><tr><td><strong>POST /api/getLastSeenTrafficInfoForCollections</strong></td><td>Fetch last seen traffic timestamps for each collection, helping track activity recency.</td></tr><tr><td><strong>POST /api/getSensitiveInfoForCollections</strong></td><td>Retrieve sensitive data findings per collection (e.g., PII, secrets).</td></tr><tr><td><strong>POST /api/getRiskScoreInfo</strong></td><td>Get risk scores calculated for agentic collections, based on threats and sensitive data exposure.</td></tr><tr><td><strong>POST /api/fetchCollectionWiseApiEndpoints</strong></td><td>Fetch all Agentic components belonging to a specific collection.</td></tr><tr><td><strong>POST /api/fetchApiInfosForCollection</strong></td><td>Retrieve detailed agentic component information for a given collection (method, path, params, etc.).</td></tr><tr><td><strong>POST /api/fetchApiInfosFromSTIs</strong></td><td>Fetch agentic component details using stored traffic identifiers (STIs). Useful for replay or drill-down.</td></tr><tr><td><strong>POST /api/fetchEndpointsCount</strong></td><td>Get a count of Agentic components per collection.</td></tr><tr><td><strong>POST /api/fetchApiCallStats</strong></td><td>Retrieve traffic statistics such as call counts, trends, and usage metrics per agentic component call.</td></tr><tr><td><strong>POST /api/fetchIpLevelApiCallStats</strong></td><td>Get agentic component call stats broken down by IP, useful for identifying abusive clients or usage patterns.</td></tr><tr><td><strong>POST /api/fetchSampleData</strong></td><td>Fetch sample request/response payloads observed for a given agentic component, used for testing or schema generation.</td></tr><tr><td><strong>POST /api/generateOpenApiFile</strong></td><td>Generate an OpenAPI (Swagger) specification file from discovered API data.</td></tr></tbody></table>



{% openapi-operation spec="akto-agentic-security-api" path="/api/getAllCollectionsBasic" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getSeverityInfoForCollections" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getLastSeenTrafficInfoForCollections" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getSensitiveInfoForCollections" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getRiskScoreInfo" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getCoverageInfoForCollections" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getAllCollections" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getAllUsersCollections" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getSeveritiesCountPerCollection" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchCollectionWiseApiEndpoints" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchIpLevelApiCallStats" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchApiInfosForCollection" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchApiCallStats" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchApiInfosFromSTIs" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchEndpointsCount" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchSampleData" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/generateOpenApiFile" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}
