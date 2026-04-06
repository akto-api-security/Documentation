# Modify Data

<table data-full-width="true"><thead><tr><th width="447.5126953125">API</th><th>Description</th></tr></thead><tbody><tr><td><strong>POST /api/createCollection</strong></td><td>Create a new Agentic Collection in Akto.</td></tr><tr><td><strong>POST /api/createCustomCollection</strong></td><td>Create a custom Agentic Collection by grouping selected Agentic Components.</td></tr><tr><td><strong>POST /api/addApisToCustomCollection</strong></td><td>Add Agentic Components to an existing custom collection.</td></tr><tr><td><strong>POST /api/saveCollectionDescription</strong></td><td>Save or update the description of a collection.</td></tr><tr><td><strong>POST /api/updateEnvType</strong></td><td>Update the environment type (e.g., prod, staging) for a collection.</td></tr><tr><td><strong>POST /api/toggleCollectionsOutOfTestScope</strong></td><td>Mark/unmark collections as out of scan scope.</td></tr><tr><td><strong>POST /api/deactivateCollections</strong></td><td>Deactivate specific collections so they are no longer active.</td></tr><tr><td><strong>POST /api/deleteMultipleCollections</strong></td><td>Delete multiple collections at once.</td></tr><tr><td><strong>POST /api/redactCollection</strong></td><td>Redact sensitive data within a collection.</td></tr><tr><td><strong>POST /api/saveEndpointDescription</strong></td><td>Save or update the description of a specific Agentic component.</td></tr><tr><td><strong>POST /api/loadParamsOfEndpoint</strong></td><td>Load the parameters (query, path, body) of a given Agentic component.</td></tr><tr><td><strong>POST /api/loadSensitiveParameters</strong></td><td>Load parameters identified as sensitive for a given agentic component/collection.</td></tr><tr><td><strong>POST /api/importDataFromOpenApiSpec</strong></td><td>Import Agentic components and Agentic Collections from an OpenAPI specification file.</td></tr><tr><td><strong>POST /api/uploadHar</strong></td><td>Upload a HAR (HTTP Archive) file to create or update Agentic Component data in Akto.</td></tr><tr><td><strong>POST /api/importDataFromPostmanFile</strong></td><td>Import Agentic Component data from a Postman collection file.</td></tr><tr><td><strong>POST /api/importPostmanWorkspace</strong></td><td>Import Agentic Components from a Postman workspace.</td></tr><tr><td><strong>POST /api/addSensitiveField</strong></td><td>Add or mark a field as containing sensitive data.</td></tr><tr><td><strong>POST /api/saveAktoDataType</strong></td><td>Save or update a custom data type configuration.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/addApisToCustomCollection" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/saveEndpointDescription" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateEnvType" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/toggleCollectionsOutOfTestScope" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/uploadHar" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteMultipleCollections" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/saveCollectionDescription" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/loadSensitiveParameters" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/loadParamsOfEndpoint" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/createCollection" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/redactCollection" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/importDataFromOpenApiSpec" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/createCustomCollection" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deactivateCollections" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/importDataFromPostmanFile" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/importPostmanWorkspace" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/addSensitiveField" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/saveAktoDataType" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}
