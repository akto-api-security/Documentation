# Modify Data

## Agent & MCP

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="420">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/createCollection</strong></td><td>Create a new Agentic Collection in Akto.</td></tr><tr><td>2</td><td><strong>POST /api/createCustomCollection</strong></td><td>Create a custom Agentic Collection by grouping selected Agentic Components.</td></tr><tr><td>3</td><td><strong>POST /api/addApisToCustomCollection</strong></td><td>Add Agentic Components to an existing custom agentic collection.</td></tr><tr><td>4</td><td><strong>POST /api/saveCollectionDescription</strong></td><td>Save or update the description of an agentic collection.</td></tr><tr><td>5</td><td><strong>POST /api/updateEnvType</strong></td><td>Update the environment type (e.g., prod, staging) for an agentic collection.</td></tr><tr><td>6</td><td><strong>POST /api/toggleCollectionsOutOfTestScope</strong></td><td>Mark/unmark agentic collections as out of scan scope.</td></tr><tr><td>7</td><td><strong>POST /api/deactivateCollections</strong></td><td>Deactivate specific agentic collections so they are no longer active.</td></tr><tr><td>8</td><td><strong>POST /api/deleteMultipleCollections</strong></td><td>Delete multiple agentic collections at once.</td></tr><tr><td>9</td><td><strong>POST /api/redactCollection</strong></td><td>Redact sensitive data within an agentic collection.</td></tr><tr><td>10</td><td><strong>POST /api/saveEndpointDescription</strong></td><td>Save or update the description of a specific Agentic component.</td></tr><tr><td>11</td><td><strong>POST /api/loadParamsOfEndpoint</strong></td><td>Load the Agentic Parameters (query, path, body) of a given Agentic component.</td></tr><tr><td>12</td><td><strong>POST /api/loadSensitiveParameters</strong></td><td>Load Agentic Parameters identified as sensitive for a given agentic component/collection.</td></tr><tr><td>13</td><td><strong>POST /api/importDataFromOpenApiSpec</strong></td><td>Import Agentic components and Agentic Collections from an OpenAPI specification file.</td></tr><tr><td>14</td><td><strong>POST /api/uploadHar</strong></td><td>Upload a HAR (HTTP Archive) file to create or update Agentic Component data in Akto.</td></tr><tr><td>15</td><td><strong>POST /api/importDataFromPostmanFile</strong></td><td>Import Agentic Component data from a Postman agentic collection file.</td></tr><tr><td>16</td><td><strong>POST /api/importPostmanWorkspace</strong></td><td>Import Agentic Components from a Postman workspace.</td></tr><tr><td>17</td><td><strong>POST /api/addSensitiveField</strong></td><td>Add or mark a field as containing Sensitive in Response data.</td></tr><tr><td>18</td><td><strong>POST /api/saveAktoDataType</strong></td><td>Save or update a custom data type configuration.</td></tr><tr><td>19</td><td><strong>POST /api/addMcpRegistryIntegration</strong></td><td>Adds or updates MCP registry integrations with validation for duplicate names/URLs and maximum limits (10 registries max).</td></tr><tr><td>20</td><td><strong>POST /api/createAgentRun</strong></td><td>Creates a new agent run with initialization data, checking for existing running agents and validating the model.</td></tr><tr><td>21</td><td><strong>POST /api/deleteAgentModel</strong></td><td>Deletes an agent model by name with audit logging.</td></tr><tr><td>22</td><td><strong>POST /api/deleteAgentRun</strong></td><td>Deletes an agent run (only allowed for SCHEDULED, RUNNING, or STOPPED states) and associated subprocesses.</td></tr><tr><td>23</td><td><strong>POST /api/feedDataToAgent</strong></td><td>Polling endpoint for agent to get initialization data or next subprocess task.</td></tr><tr><td>24</td><td><strong>POST /api/feedDiscoveryDataToAgent</strong></td><td>Polling endpoint for discovery agent to get initialization or next discovery subprocess task.</td></tr><tr><td>25</td><td><strong>POST /api/initiateAIAgentConnectorImport</strong></td><td>Initiates a recurring import job for AI agent connector data with connector-specific validation and configuration.</td></tr><tr><td>26</td><td><strong>POST /api/saveAgentModel</strong></td><td>Saves a new AI model configuration with type-specific validation.</td></tr><tr><td>27</td><td><strong>POST /api/updateAgentHealthCheck</strong></td><td>Updates agent health check status with instance ID, version, and process information.</td></tr><tr><td>28</td><td><strong>POST /api/updateAgentRun</strong></td><td>Updates the state of an agent run, setting appropriate timestamps for RUNNING and COMPLETED states.</td></tr><tr><td>29</td><td><strong>POST /api/updateAgentSubprocess</strong></td><td>Updates subprocess state, heading, and user input with upsert behavior and validation. RE_ATTEMPT state is only allowed if current state is COMPLETED.</td></tr><tr><td>30</td><td><strong>POST /api/updateStateOfDiscoveryAgentRun</strong></td><td>Updates state and optionally results for a discovery agent run.</td></tr><tr><td>31</td><td><strong>POST /api/createSensitiveResponseDataTypes</strong></td><td>Asynchronously creates custom Sensitive in Response data types from detected data in Agentic Responses using pattern matching and machine learning.</td></tr><tr><td>32</td><td><strong>POST /api/createSubProcessNew</strong></td><td>Creates a new discovery subprocess with user input data for hostname and auth token.</td></tr><tr><td>33</td><td><strong>POST /api/initiateMCPRecon</strong></td><td>Initiates MCP reconnaissance for specified IP ranges, creating a pending reconnaissance request.</td></tr><tr><td>34</td><td><strong>POST /api/initiateMCPScan</strong></td><td>Initiates an MCP server scan by creating an Agentic Collection and scheduling a MCP tools sync job.</td></tr><tr><td>35</td><td><strong>POST /api/saveVulnerabilities</strong></td><td>Saves source code vulnerabilities found by agent to the database for tracking and remediation.</td></tr><tr><td>36</td><td><strong>POST /api/activateCollections</strong></td><td>Activate one or more Agentic Collections.</td></tr><tr><td>37</td><td><strong>POST /api/deleteApis</strong></td><td>Delete one or more Agentic Components.</td></tr><tr><td>38</td><td><strong>POST /api/removeApisFromCustomCollection</strong></td><td>Remove Agentic Components from a custom agentic collection.</td></tr><tr><td>39</td><td><strong>POST /api/computeCustomCollections</strong></td><td>Compute and create custom Agentic Collections based on criteria.</td></tr><tr><td>40</td><td><strong>POST /api/uploadTcp</strong></td><td>Upload TCP traffic data (HAR format).</td></tr><tr><td>41</td><td><strong>POST /api/updateCustomCollection</strong></td><td>Update details of a custom agentic collection.</td></tr><tr><td>42</td><td><strong>POST /api/deleteCollection</strong></td><td>Delete an entire Agentic Collection.</td></tr><tr><td>43</td><td><strong>POST /api/deleteUntrackedCollections</strong></td><td>Delete agentic collections that are not being tracked.</td></tr><tr><td>44</td><td><strong>POST /api/updateUserCollections</strong></td><td>Update user permissions for agentic collections.</td></tr><tr><td>45</td><td><strong>POST /api/addApiCollectionNameMapper</strong></td><td>Add a mapping for Agentic Collection names.</td></tr><tr><td>46</td><td><strong>POST /api/deleteApiCollectionNameMapper</strong></td><td>Delete an Agentic Collection name mapper.</td></tr><tr><td>47</td><td><strong>POST /api/deMergeApi</strong></td><td>Separate a merged Agentic Component into individual components.</td></tr><tr><td>48</td><td><strong>POST /api/bulkDeMergeApis</strong></td><td>Bulk de-merge multiple Agentic Components.</td></tr><tr><td>49</td><td><strong>POST /api/undoDemergedApis</strong></td><td>Undo de-merging of Agentic Components.</td></tr><tr><td>50</td><td><strong>POST /api/editCollectionName</strong></td><td>Edit the name of an Agentic Collection.</td></tr><tr><td>51</td><td><strong>POST /api/deleteApisBasedOnHeader</strong></td><td>Delete Agentic Components based on header matching criteria.</td></tr><tr><td>52</td><td><strong>POST /api/syncExtractedAPIs</strong></td><td>Sync Agentic Components extracted from code analysis.</td></tr></tbody></table>

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

{% openapi-operation spec="akto-agentic-security-api" path="/api/activateCollections" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteApis" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/removeApisFromCustomCollection" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/computeCustomCollections" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/uploadTcp" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateCustomCollection" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteCollection" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteUntrackedCollections" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateUserCollections" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/addApiCollectionNameMapper" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteApiCollectionNameMapper" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deMergeApi" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/bulkDeMergeApis" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/undoDemergedApis" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/editCollectionName" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteApisBasedOnHeader" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/syncExtractedAPIs" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}
