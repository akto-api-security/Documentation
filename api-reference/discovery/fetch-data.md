# Fetch Data

<table data-full-width="true"><thead><tr><th width="427.5712890625">API</th><th>Description</th></tr></thead><tbody><tr><td><strong>POST /api/getAllCollectionsBasic</strong></td><td>Fetch a lightweight list of all agentic collections with only basic metadata. Useful for quick lookups or dropdowns.</td></tr><tr><td><strong>POST /api/getAllCollections</strong></td><td>Retrieve the complete list of all agentic collections with detailed information.</td></tr><tr><td><strong>POST /api/getAllUsersCollections</strong></td><td>Fetch all agentic collections accessible to the current user.</td></tr><tr><td><strong>POST /api/getCoverageInfoForCollections</strong></td><td>Get scan coverage data for each collection (e.g., how many endpoints are tested vs. untested). Used to track which agentic components are covered by scans.</td></tr><tr><td><strong>POST /api/getSeverityInfoForCollections</strong></td><td>Retrieve aggregated severity information (High, Medium, Low) across agentic collections.</td></tr><tr><td><strong>POST /api/getSeveritiesCountPerCollection</strong></td><td>Get the count of issues grouped by severity for each collection.</td></tr><tr><td><strong>POST /api/getLastSeenTrafficInfoForCollections</strong></td><td>Fetch last seen traffic timestamps for each collection, helping track activity recency.</td></tr><tr><td><strong>POST /api/getSensitiveInfoForCollections</strong></td><td>Retrieve sensitive data findings per collection (e.g., PII, secrets).</td></tr><tr><td><strong>POST /api/getRiskScoreInfo</strong></td><td>Get risk scores calculated for agentic collections, based on threats and sensitive data exposure.</td></tr><tr><td><strong>POST /api/fetchCollectionWiseApiEndpoints</strong></td><td>Fetch all Agentic components belonging to a specific collection.</td></tr><tr><td><strong>POST /api/fetchApiInfosForCollection</strong></td><td>Retrieve detailed agentic component information for a given collection (method, path, params, etc.).</td></tr><tr><td><strong>POST /api/fetchEndpointsCount</strong></td><td>Get a count of Agentic components per collection.</td></tr><tr><td><strong>POST /api/fetchApiCallStats</strong></td><td>Retrieve traffic statistics such as call counts, trends, and usage metrics per agentic component call.</td></tr><tr><td><strong>POST /api/fetchIpLevelApiCallStats</strong></td><td>Get agentic component call stats broken down by IP, useful for identifying abusive clients or usage patterns.</td></tr><tr><td><strong>POST /api/fetchSampleData</strong></td><td>Fetch sample request/response payloads observed for a given agentic component, used for testing or schema generation.</td></tr><tr><td><strong>POST /api/generateOpenApiFile</strong></td><td>Generate an OpenAPI (Swagger) specification file from discovered API data.</td></tr><tr><td><strong>POST /api/fetchAllUrlsAndMethods</strong></td><td>Fetch all unique URLs and HTTP methods in a collection.</td></tr><tr><td><strong>POST /api/fetchNewEndpointsTrendForHostCollections</strong></td><td>Get trend of newly discovered endpoints for host-based collections (for Agentic dashboard).</td></tr><tr><td><strong>POST /api/fetchNewEndpointsTrendForNonHostCollections</strong></td><td>Get trend of newly discovered endpoints for non-host collections (for Agentic dashboard).</td></tr><tr><td><strong>POST /api/fetchAPICollection</strong></td><td>Fetch API collection details and metadata.</td></tr><tr><td><strong>POST /api/fetchChanges</strong></td><td>Retrieve changes and modifications to API collections.</td></tr><tr><td><strong>POST /api/fetchCustomAuthTypes</strong></td><td>Fetch custom authentication types configured in the system.</td></tr><tr><td><strong>POST /api/fetchDataTypeNames</strong></td><td>Retrieve names of all configured data types.</td></tr><tr><td><strong>POST /api/fetchDataTypes</strong></td><td>Fetch detailed information about data types.</td></tr><tr><td><strong>POST /api/fetchEndpointTrafficData</strong></td><td>Get traffic and usage data for API endpoints.</td></tr><tr><td><strong>POST /api/fetchNewParametersTrend</strong></td><td>Retrieve trends of newly discovered parameters.</td></tr><tr><td><strong>POST /api/fetchSensitiveParamsForEndpoints</strong></td><td>Fetch parameters identified as sensitive for endpoints.</td></tr><tr><td><strong>POST /api/fetchTagConfigs</strong></td><td>Retrieve tag configurations for API organization.</td></tr><tr><td><strong>POST /api/loadRecentEndpoints</strong></td><td>Load recently discovered or modified endpoints.</td></tr></tbody></table>



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

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchEndpointsCount" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchSampleData" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/generateOpenApiFile" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchAllUrlsAndMethods" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchNewEndpointsTrendForHostCollections" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchNewEndpointsTrendForNonHostCollections" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchAPICollection" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchChanges" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchCustomAuthTypes" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchDataTypeNames" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchDataTypes" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchEndpointTrafficData" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchNewParametersTrend" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchSensitiveParamsForEndpoints" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchTagConfigs" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/loadRecentEndpoints" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

