# Modify Data

## Agent & MCP

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="420">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/createCollection</strong></td><td>Create a new Agentic Collection in Akto.</td></tr><tr><td>2</td><td><strong>POST /api/createCustomCollection</strong></td><td>Create a custom Agentic Collection by grouping selected Agentic Components.</td></tr><tr><td>3</td><td><strong>POST /api/addApisToCustomCollection</strong></td><td>Add Agentic Components to an existing custom collection.</td></tr><tr><td>4</td><td><strong>POST /api/saveCollectionDescription</strong></td><td>Save or update the description of a collection.</td></tr><tr><td>5</td><td><strong>POST /api/updateEnvType</strong></td><td>Update the environment type (e.g., prod, staging) for a collection.</td></tr><tr><td>6</td><td><strong>POST /api/toggleCollectionsOutOfTestScope</strong></td><td>Mark/unmark collections as out of scan scope.</td></tr><tr><td>7</td><td><strong>POST /api/deactivateCollections</strong></td><td>Deactivate specific collections so they are no longer active.</td></tr><tr><td>8</td><td><strong>POST /api/deleteMultipleCollections</strong></td><td>Delete multiple collections at once.</td></tr><tr><td>9</td><td><strong>POST /api/redactCollection</strong></td><td>Redact sensitive data within a collection.</td></tr><tr><td>10</td><td><strong>POST /api/saveEndpointDescription</strong></td><td>Save or update the description of a specific Agentic component.</td></tr><tr><td>11</td><td><strong>POST /api/loadParamsOfEndpoint</strong></td><td>Load the parameters (query, path, body) of a given Agentic component.</td></tr><tr><td>12</td><td><strong>POST /api/loadSensitiveParameters</strong></td><td>Load parameters identified as sensitive for a given agentic component/collection.</td></tr><tr><td>13</td><td><strong>POST /api/importDataFromOpenApiSpec</strong></td><td>Import Agentic components and Agentic Collections from an OpenAPI specification file.</td></tr><tr><td>14</td><td><strong>POST /api/uploadHar</strong></td><td>Upload a HAR (HTTP Archive) file to create or update Agentic Component data in Akto.</td></tr><tr><td>15</td><td><strong>POST /api/importDataFromPostmanFile</strong></td><td>Import Agentic Component data from a Postman collection file.</td></tr><tr><td>16</td><td><strong>POST /api/importPostmanWorkspace</strong></td><td>Import Agentic Components from a Postman workspace.</td></tr><tr><td>17</td><td><strong>POST /api/addSensitiveField</strong></td><td>Add or mark a field as containing sensitive data.</td></tr><tr><td>18</td><td><strong>POST /api/saveAktoDataType</strong></td><td>Save or update a custom data type configuration.</td></tr><tr><td>19</td><td><strong>POST /api/addMcpRegistryIntegration</strong></td><td>Adds or updates MCP registry integrations with validation for duplicate names/URLs and maximum limits (10 registries max).</td></tr><tr><td>20</td><td><strong>POST /api/createAgentRun</strong></td><td>Creates a new agent run with initialization data, checking for existing running agents and validating the model.</td></tr><tr><td>21</td><td><strong>POST /api/deleteAgentModel</strong></td><td>Deletes an agent model by name with audit logging.</td></tr><tr><td>22</td><td><strong>POST /api/deleteAgentRun</strong></td><td>Deletes an agent run (only allowed for SCHEDULED, RUNNING, or STOPPED states) and associated subprocesses.</td></tr><tr><td>23</td><td><strong>POST /api/feedDataToAgent</strong></td><td>Polling endpoint for agent to get initialization data or next subprocess task.</td></tr><tr><td>24</td><td><strong>POST /api/feedDiscoveryDataToAgent</strong></td><td>Polling endpoint for discovery agent to get initialization or next discovery subprocess task.</td></tr><tr><td>25</td><td><strong>POST /api/initiateAIAgentConnectorImport</strong></td><td>Initiates a recurring import job for AI agent connector data with connector-specific validation and configuration.</td></tr><tr><td>26</td><td><strong>POST /api/saveAgentModel</strong></td><td>Saves a new AI model configuration with type-specific validation.</td></tr><tr><td>27</td><td><strong>POST /api/updateAgentHealthCheck</strong></td><td>Updates agent health check status with instance ID, version, and process information.</td></tr><tr><td>28</td><td><strong>POST /api/updateAgentRun</strong></td><td>Updates the state of an agent run, setting appropriate timestamps for RUNNING and COMPLETED states.</td></tr><tr><td>29</td><td><strong>POST /api/updateAgentSubprocess</strong></td><td>Updates subprocess state, heading, and user input with upsert behavior and validation. RE_ATTEMPT state is only allowed if current state is COMPLETED.</td></tr><tr><td>30</td><td><strong>POST /api/updateStateOfDiscoveryAgentRun</strong></td><td>Updates state and optionally results for a discovery agent run.</td></tr><tr><td>31</td><td><strong>POST /api/createSensitiveResponseDataTypes</strong></td><td>Asynchronously creates custom sensitive data types from detected data in responses using pattern matching and machine learning.</td></tr><tr><td>32</td><td><strong>POST /api/createSubProcessNew</strong></td><td>Creates a new discovery subprocess with user input data for hostname and auth token.</td></tr><tr><td>33</td><td><strong>POST /api/initiateMCPRecon</strong></td><td>Initiates MCP reconnaissance for specified IP ranges, creating a pending reconnaissance request.</td></tr><tr><td>34</td><td><strong>POST /api/initiateMCPScan</strong></td><td>Initiates an MCP server scan by creating an API collection and scheduling a MCP tools sync job.</td></tr><tr><td>35</td><td><strong>POST /api/saveVulnerabilities</strong></td><td>Saves source code vulnerabilities found by agent to the database for tracking and remediation.</td></tr></tbody></table>

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

{% openapi-operation spec="akto-agentic-security-api" path="/api/addMcpRegistryIntegration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/createAgentRun" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteAgentModel" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteAgentRun" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/feedDataToAgent" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/feedDiscoveryDataToAgent" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/initiateAIAgentConnectorImport" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/saveAgentModel" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateAgentHealthCheck" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateAgentRun" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateAgentSubprocess" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateStateOfDiscoveryAgentRun" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/createSensitiveResponseDataTypes" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/createSubProcessNew" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/initiateMCPRecon" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/initiateMCPScan" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/saveVulnerabilities" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}
