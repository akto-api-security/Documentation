# Code Analysis

<table data-full-width="true"><thead><tr><th width="460">API</th><th>Description</th></tr></thead><tbody><tr><td><strong>POST /api/fetchCodeAnalysisApiInfos</strong></td><td>Fetch code-analysis API info for a given traffic collection, returning matched endpoints discovered from source code.</td></tr><tr><td><strong>POST /api/fetchCodeAnalysisRepos</strong></td><td>Fetch all registered source-code repositories, optionally filtered by source-code type.</td></tr><tr><td><strong>POST /api/getSourceCodeCollectionsForDirectories</strong></td><td>Return all code analysis collections that have at least one endpoint under a given backend directory path prefix.</td></tr><tr><td><strong>POST /api/getApisForChosenCollectionForSourceCode</strong></td><td>Fetch request/response schema information for all API endpoints in the specified code analysis collections.</td></tr><tr><td><strong>POST /api/addCodeAnalysisRepo</strong></td><td>Add one or more source-code repositories for code-analysis scanning (upsert — re-adding an existing repo is a no-op).</td></tr><tr><td><strong>POST /api/runCodeAnalysisRepo</strong></td><td>Trigger an immediate scan for one or more registered repositories by setting their schedule time to now.</td></tr><tr><td><strong>POST /api/deleteCodeAnalysisRepo</strong></td><td>Delete a source-code repository registration, removing all documents matching the given project and repo name.</td></tr></tbody></table>

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchCodeAnalysisApiInfos" method="post" %}
[OpenAPI lastestscanresultv1](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/main/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchCodeAnalysisRepos" method="post" %}
[OpenAPI lastestscanresultv1](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/main/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/getSourceCodeCollectionsForDirectories" method="post" %}
[OpenAPI lastestscanresultv1](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/main/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/getApisForChosenCollectionForSourceCode" method="post" %}
[OpenAPI lastestscanresultv1](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/main/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/addCodeAnalysisRepo" method="post" %}
[OpenAPI lastestscanresultv1](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/main/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/runCodeAnalysisRepo" method="post" %}
[OpenAPI lastestscanresultv1](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/main/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/deleteCodeAnalysisRepo" method="post" %}
[OpenAPI lastestscanresultv1](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/main/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}
