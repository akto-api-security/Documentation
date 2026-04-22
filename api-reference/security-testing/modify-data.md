# Modify Data

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="430">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/startTest</strong></td><td>Start a new scan run on the selected agentic collections or agentic components.</td></tr><tr><td>2</td><td><strong>POST /api/stopTest</strong></td><td>Stop an ongoing scan run before it completes.</td></tr><tr><td>3</td><td><strong>POST /api/addTestRoles</strong></td><td>Add probe roles for red teaming execution.</td></tr><tr><td>4</td><td><strong>POST /api/stopAllTests</strong></td><td>Stop all ongoing scan runs.</td></tr><tr><td>5</td><td><strong>POST /api/updateTestRoles</strong></td><td>Update probe role configurations.</td></tr><tr><td>6</td><td><strong>POST /api/modifyTestingRunConfig</strong></td><td>Modifies an existing scanning run configuration including probe suites, subcategories, schedule, concurrency, alerts, role, and auto-ticketing settings.</td></tr><tr><td>7</td><td><strong>POST /api/addAuthMechanism</strong></td><td>Adds a new authentication mechanism (hardcoded token, login flow, sample data, or TLS) for Agentic Component scanning.</td></tr><tr><td>8</td><td><strong>POST /api/triggerLoginSteps</strong></td><td>Executes login flow steps and returns step-by-step responses. Used to validate login sequences before saving an auth mechanism.</td></tr><tr><td>9</td><td><strong>POST /api/createTestSuite</strong></td><td>Creates a new custom probe suite with a given name and list of probe subcategories.</td></tr><tr><td>10</td><td><strong>POST /api/modifyTestSuite</strong></td><td>Updates an existing custom probe suite's name and/or subcategories.</td></tr><tr><td>11</td><td><strong>POST /api/deleteTestSuite</strong></td><td>Deletes a custom probe suite by its hex ID.</td></tr><tr><td>12</td><td><strong>POST /api/bulkUpdateTestResultsSeverity</strong></td><td>Bulk-updates the severity level of selected scan results across all related collections.</td></tr><tr><td>13</td><td><strong>POST /api/deleteTestRuns</strong></td><td>Deletes the specified scan runs and schedules a background job to clean up associated results and summaries.</td></tr><tr><td>14</td><td><strong>POST /api/deleteTestRunsFromSummaries</strong></td><td>Deletes scan data (results and summaries) identified by scanning run result summary IDs via a background job.</td></tr><tr><td>15</td><td><strong>POST /api/changeStatus</strong></td><td>Changes the active/inactive status of a custom webhook and updates its associated scheduled job.</td></tr><tr><td>16</td><td><strong>POST /api/runOnce</strong></td><td>Triggers an immediate one-time asynchronous execution of a custom webhook.</td></tr><tr><td>17</td><td><strong>POST /api/runTestOnboarding</strong></td><td>Runs the onboarding probe suite against a specified collection with provided auth credentials.</td></tr><tr><td>18</td><td><strong>POST /api/saveDefaultPayload</strong></td><td>Saves or updates a default payload pattern for a domain, recording the creator and timestamps.</td></tr><tr><td>19</td><td><strong>POST /api/saveReplaceDetails</strong></td><td>Saves key-value replacement pairs for a specific Agentic component, used in dependency flow scanning.</td></tr><tr><td>20</td><td><strong>POST /api/saveGlobalVars</strong></td><td>Saves global host variable mappings for dependency flow scanning.</td></tr><tr><td>21</td><td><strong>POST /api/invokeDependencyTable</strong></td><td>Asynchronously invokes the dependency graph build job for the specified collections.</td></tr><tr><td>22</td><td><strong>POST /api/createWorkflowTest</strong></td><td>Creates a new workflow scan with a node/edge graph and associated node details.</td></tr><tr><td>23</td><td><strong>POST /api/editWorkflowTest</strong></td><td>Updates the nodes, edges, and node details of an existing workflow scan.</td></tr><tr><td>24</td><td><strong>POST /api/setWorkflowTestState</strong></td><td>Changes the state of a workflow scan (e.g. DRAFT → PUBLISHED → INACTIVE).</td></tr><tr><td>25</td><td><strong>POST /api/editWorkflowNodeDetails</strong></td><td>Updates the details of a single node within a workflow scan.</td></tr><tr><td>26</td><td><strong>POST /api/deleteScheduledWorkflowTests</strong></td><td>Stops all scheduled or running scanning runs for a given workflow scan.</td></tr><tr><td>27</td><td><strong>POST /api/uploadWorkflowJson</strong></td><td>Imports a workflow scan from a JSON string, creating a new workflow scan with a fresh ID.</td></tr><tr><td>28</td><td><strong>POST /api/addTestLibrary</strong></td><td>Adds a custom GitHub probe library to the account and clones YAML probe templates from it immediately.</td></tr><tr><td>29</td><td><strong>POST /api/removeTestLibrary</strong></td><td>Removes a custom probe library and deletes all CUSTOM-sourced templates loaded from it.</td></tr><tr><td>30</td><td><strong>POST /api/syncCustomLibrary</strong></td><td>Re-syncs YAML templates from a previously added custom probe library repository.</td></tr><tr><td>31</td><td><strong>POST /api/syncAllDefaultTestLibraries</strong></td><td>Triggers an async sync of all default Akto probe libraries from GitHub for the current account.</td></tr><tr><td>32</td><td><strong>POST /api/saveTestEditorFile</strong></td><td>Saves a custom YAML probe template file from the Agentic Playground.</td></tr><tr><td>33</td><td><strong>POST /api/saveCommonTestTemplate</strong></td><td>Saves or updates a common reusable probe template.</td></tr><tr><td>34</td><td><strong>POST /api/runTestForGivenTemplate</strong></td><td>Runs a probe for a given YAML template against a specified Agentic component from the Agentic Playground.</td></tr><tr><td>35</td><td><strong>POST /api/saveTestRoleMeta</strong></td><td>Saves metadata and configuration for a scan role.</td></tr><tr><td>36</td><td><strong>POST /api/deleteTestRole</strong></td><td>Deletes a scan role by ID.</td></tr><tr><td>37</td><td><strong>POST /api/deleteAuthFromRole</strong></td><td>Removes an authentication configuration from a scan role.</td></tr><tr><td>38</td><td><strong>POST /api/updateAuthInRole</strong></td><td>Updates an existing authentication configuration within a scan role.</td></tr><tr><td>39</td><td><strong>POST /api/addAuthToRole</strong></td><td>Adds a new authentication configuration to a scan role.</td></tr><tr><td>40</td><td><strong>POST /api/triggerSingleLoginFlow</strong></td><td>Triggers a single login flow step and returns the response, used to validate auth sequences.</td></tr><tr><td>41</td><td><strong>POST /api/addScript</strong></td><td>Inserts a new JavaScript scan script for a specified script type (PRE_TEST, PRE_REQUEST, POST_REQUEST, POST_TEST).</td></tr><tr><td>42</td><td><strong>POST /api/updateScript</strong></td><td>Replaces the JavaScript content of an existing scan script identified by its ID.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/stopTest" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/startTest" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/addTestRoles" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/stopAllTests" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateTestRoles" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/modifyTestingRunConfig" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/addAuthMechanism" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/triggerLoginSteps" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/createTestSuite" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/modifyTestSuite" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteTestSuite" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/bulkUpdateTestResultsSeverity" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteTestRuns" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteTestRunsFromSummaries" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/changeStatus" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/runOnce" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/runTestOnboarding" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/saveDefaultPayload" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/saveReplaceDetails" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/saveGlobalVars" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/invokeDependencyTable" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/createWorkflowTest" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/editWorkflowTest" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/setWorkflowTestState" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/editWorkflowNodeDetails" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteScheduledWorkflowTests" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/uploadWorkflowJson" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/addTestLibrary" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/removeTestLibrary" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/syncCustomLibrary" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/syncAllDefaultTestLibraries" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/saveTestEditorFile" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/saveCommonTestTemplate" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/runTestForGivenTemplate" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/saveTestRoleMeta" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteTestRole" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteAuthFromRole" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateAuthInRole" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/addAuthToRole" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/triggerSingleLoginFlow" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/addScript" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateScript" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}
