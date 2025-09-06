# Fetch Data

<table data-full-width="true"><thead><tr><th width="427.5712890625">API</th><th>Description</th></tr></thead><tbody><tr><td><strong>POST /api/getAllCollectionsBasic</strong></td><td>Fetch a lightweight list of all API collections with only basic metadata. Useful for quick lookups or dropdowns.</td></tr><tr><td><strong>POST /api/getAllCollections</strong></td><td>Retrieve the complete list of all API collections with detailed information.</td></tr><tr><td><strong>POST /api/getAllUsersCollections</strong></td><td>Fetch all API collections accessible to the current user.</td></tr><tr><td><strong>POST /api/getCoverageInfoForCollections</strong></td><td>Get test coverage data for each collection (e.g., how many endpoints are tested vs. untested).</td></tr><tr><td><strong>POST /api/getSeverityInfoForCollections</strong></td><td>Retrieve aggregated severity information (High, Medium, Low) across API collections.</td></tr><tr><td><strong>POST /api/getSeveritiesCountPerCollection</strong></td><td>Get the count of issues grouped by severity for each collection.</td></tr><tr><td><strong>POST /api/getLastSeenTrafficInfoForCollections</strong></td><td>Fetch last seen traffic timestamps for each collection, helping track activity recency.</td></tr><tr><td><strong>POST /api/getSensitiveInfoForCollections</strong></td><td>Retrieve sensitive data findings per collection (e.g., PII, secrets).</td></tr><tr><td><strong>POST /api/getRiskScoreInfo</strong></td><td>Get risk scores calculated for API collections, based on threats and sensitive data exposure.</td></tr><tr><td><strong>POST /api/fetchCollectionWiseApiEndpoints</strong></td><td>Fetch all API endpoints belonging to a specific collection.</td></tr><tr><td><strong>POST /api/fetchApiInfosForCollection</strong></td><td>Retrieve detailed API information for a given collection (method, path, params, etc.).</td></tr><tr><td><strong>POST /api/fetchApiInfosFromSTIs</strong></td><td>Fetch API details using stored traffic identifiers (STIs). Useful for replay or drill-down.</td></tr><tr><td><strong>POST /api/fetchEndpointsCount</strong></td><td>Get a count of API endpoints per collection.</td></tr><tr><td><strong>POST /api/fetchApiCallStats</strong></td><td>Retrieve traffic statistics such as call counts, trends, and usage metrics per API.</td></tr><tr><td><strong>POST /api/fetchIpLevelApiCallStats</strong></td><td>Get API call stats broken down by IP, useful for identifying abusive clients or usage patterns.</td></tr><tr><td><strong>POST /api/fetchSampleData</strong></td><td>Fetch sample request/response payloads observed for a given API, used for testing or schema generation.</td></tr><tr><td><strong>POST /api/generateOpenApiFile</strong></td><td>Generate an OpenAPI (Swagger) specification file from discovered API data.</td></tr></tbody></table>



{% openapi-operation spec="discoveryfinallatest" path="/api/getAllCollectionsBasic" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/getSeverityInfoForCollections" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/getLastSeenTrafficInfoForCollections" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/getSensitiveInfoForCollections" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/getRiskScoreInfo" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/getCoverageInfoForCollections" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/getAllCollections" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/getAllUsersCollections" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/getSeveritiesCountPerCollection" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/fetchCollectionWiseApiEndpoints" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/fetchIpLevelApiCallStats" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/fetchApiInfosForCollection" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/fetchApiCallStats" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/fetchApiInfosFromSTIs" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/fetchEndpointsCount" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/fetchSampleData" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/generateOpenApiFile" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}
