# Modify Data

<table data-full-width="true"><thead><tr><th width="447.5126953125">API</th><th>Description</th></tr></thead><tbody><tr><td><strong>POST /api/createCollection</strong></td><td>Create a new API collection in Akto.</td></tr><tr><td><strong>POST /api/createCustomCollection</strong></td><td>Create a custom API collection by grouping selected APIs.</td></tr><tr><td><strong>POST /api/addApisToCustomCollection</strong></td><td>Add APIs to an existing custom collection.</td></tr><tr><td><strong>POST /api/saveCollectionDescription</strong></td><td>Save or update the description of a collection.</td></tr><tr><td><strong>POST /api/updateEnvType</strong></td><td>Update the environment type (e.g., prod, staging) for a collection.</td></tr><tr><td><strong>POST /api/toggleCollectionsOutOfTestScope</strong></td><td>Mark/unmark collections as out of test scope.</td></tr><tr><td><strong>POST /api/deactivateCollections</strong></td><td>Deactivate specific collections so they are no longer active.</td></tr><tr><td><strong>POST /api/deleteMultipleCollections</strong></td><td>Delete multiple collections at once.</td></tr><tr><td><strong>POST /api/redactCollection</strong></td><td>Redact sensitive data within a collection.</td></tr><tr><td><strong>POST /api/saveEndpointDescription</strong></td><td>Save or update the description of a specific API endpoint.</td></tr><tr><td><strong>POST /api/loadParamsOfEndpoint</strong></td><td>Load the parameters (query, path, body) of a given API endpoint.</td></tr><tr><td><strong>POST /api/loadSensitiveParameters</strong></td><td>Load parameters identified as sensitive for a given endpoint/collection.</td></tr><tr><td><strong>POST /api/importDataFromOpenApiSpec</strong></td><td>Import APIs and collections from an OpenAPI specification file.</td></tr><tr><td><strong>POST /api/uploadHar</strong></td><td>Upload a HAR (HTTP Archive) file to create or update API data in Akto.</td></tr></tbody></table>

{% openapi-operation spec="discoveryfinallatest" path="/api/addApisToCustomCollection" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/saveEndpointDescription" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/updateEnvType" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/toggleCollectionsOutOfTestScope" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/uploadHar" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/deleteMultipleCollections" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/saveCollectionDescription" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/loadSensitiveParameters" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/loadParamsOfEndpoint" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/createCollection" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/redactCollection" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/importDataFromOpenApiSpec" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/createCustomCollection" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="discoveryfinallatest" path="/api/deactivateCollections" method="post" %}
[OpenAPI discoveryfinallatest](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/cdb9de608c24b16eb079373197e6abd65e876ed802ebf1b8ab3515048c11fb94.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=a6de9efd0be4e810bc46310a674b336e6908b4da6e8066cd4781d5621d506958&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}
