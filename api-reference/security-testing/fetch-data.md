# Fetch Data

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="430">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/fetchAuthMechanismData</strong></td><td>Retrieve authentication mechanism details configured for scanning.</td></tr><tr><td>2</td><td><strong>POST /api/fetchTestRoles</strong></td><td>Fetch probe roles and their configurations for scanning.</td></tr><tr><td>3</td><td><strong>POST /api/fetchTestingRunResults</strong></td><td>Fetch the results of executed scan runs, including issues found and their severity.</td></tr><tr><td>4</td><td><strong>POST /api/fetchActiveTestRunsStatus</strong></td><td>Retrieve the current status of active or in-progress scan runs.</td></tr><tr><td>5</td><td><strong>POST /api/retrieveAllCollectionTests</strong></td><td>Retrieve all available probes mapped to each Agentic Collection.</td></tr><tr><td>6</td><td><strong>POST /api/fetchFilters</strong></td><td>Fetch available filters for organizing and querying scan results.</td></tr><tr><td>7</td><td><strong>POST /api/fetchSearchTestResults</strong></td><td>Search and retrieve scan results based on specified criteria.</td></tr><tr><td>8</td><td><strong>POST /api/fetchTestingSources</strong></td><td>Retrieve configured scanning sources and integrations.</td></tr><tr><td>9</td><td><strong>POST /api/fetchWorkflowTests</strong></td><td>Get workflow-based security scan definitions and configurations.</td></tr><tr><td>10</td><td><strong>POST /api/fetchTestingRunResultSummary</strong></td><td>Fetches a single scanning run result summary by its hex ID.</td></tr><tr><td>11</td><td><strong>POST /api/fetchAuthMechanismDataDoc</strong></td><td>Fetches the raw authentication mechanism document for the current account.</td></tr><tr><td>12</td><td><strong>POST /api/fetchAllTestSuites</strong></td><td>Fetches both custom and default (built-in) probe suites available in the account.</td></tr><tr><td>13</td><td><strong>POST /api/fetchTestSuites</strong></td><td>Fetches all available probe suite enum types for onboarding flows.</td></tr><tr><td>14</td><td><strong>POST /api/fetchVulnerableRequests</strong></td><td>Fetches a paginated list of vulnerable HTTP requests from demo data, used for probe template previews.</td></tr><tr><td>15</td><td><strong>POST /api/fetchTestingRunResultFromTestingRun</strong></td><td>Fetches the first scanning run result associated with a given scanning run hex ID.</td></tr><tr><td>16</td><td><strong>POST /api/fetchUsageTestRuns</strong></td><td>Checks whether the current account has any user-created scan runs (excluding onboarding demo runs).</td></tr><tr><td>17</td><td><strong>POST /api/fetchTestingLogs</strong></td><td>Fetches scanning engine logs within a specified time range.</td></tr><tr><td>18</td><td><strong>POST /api/getBUACategoryCount</strong></td><td>Counts the number of unique Agentic Components affected by issues matching the given filter criteria.</td></tr><tr><td>19</td><td><strong>POST /api/getNotTestedAPICount</strong></td><td>Counts Agentic Components that have never been scanned, optionally filtered by collection.</td></tr><tr><td>20</td><td><strong>POST /api/getOnlyOnceTestedAPICount</strong></td><td>Counts Agentic Components that have been scanned exactly one time, optionally filtered by collection.</td></tr><tr><td>21</td><td><strong>POST /api/fetchTestedApisRanges</strong></td><td>Returns the count of scanned Agentic Components grouped by week (year_weekOfYear) for trend analysis.</td></tr><tr><td>22</td><td><strong>POST /api/getMisConfiguredTestsCount</strong></td><td>Counts scan results that require additional configuration (REQUIRES_CONFIG flag).</td></tr><tr><td>23</td><td><strong>POST /api/fetchTestingRunsRanges</strong></td><td>Returns completed scan run counts grouped by week (year_weekOfYear) for trend analysis.</td></tr><tr><td>24</td><td><strong>POST /api/getLastCalculatedInfo</strong></td><td>Fetches metadata about the last cron/background job execution for the current account.</td></tr><tr><td>25</td><td><strong>POST /api/fetchTestingData</strong></td><td>Returns consolidated scanning coverage statistics (scanned vs non-scanned Agentic Component counts) within a time range.</td></tr><tr><td>26</td><td><strong>POST /api/fetchMiniTestingServiceNames</strong></td><td>Returns the names of active mini-scanning service modules with recent heartbeats.</td></tr><tr><td>27</td><td><strong>POST /api/fetchDefaultPayload</strong></td><td>Fetches the default payload configuration for a specific domain.</td></tr><tr><td>28</td><td><strong>POST /api/fetchAllDefaultPayloads</strong></td><td>Fetches all default payload configurations saved for the current account.</td></tr><tr><td>29</td><td><strong>POST /api/fetchGlobalVars</strong></td><td>Fetches saved global host variable mappings and known hosts for the specified collections.</td></tr><tr><td>30</td><td><strong>POST /api/fetchTestCollectionConfiguration</strong></td><td>Fetches scan configuration properties (headers, cookies, auth requirements, etc.) for a specific Agentic Collection.</td></tr><tr><td>31</td><td><strong>POST /api/fetchPropertyIds</strong></td><td>Fetches all available scan collection property types with their metadata.</td></tr><tr><td>32</td><td><strong>POST /api/buildDependencyTable</strong></td><td>Builds a paginated dependency flow table with Agentic Component nodes, parameters, and replacement details.</td></tr><tr><td>33</td><td><strong>POST /api/fetchWorkflowResult</strong></td><td>Fetches the latest testing run and result for a workflow test.</td></tr><tr><td>34</td><td><strong>POST /api/fetchWorkflowTestingRun</strong></td><td>Fetches all scheduled testing runs for a workflow test.</td></tr><tr><td>35</td><td><strong>POST /api/downloadWorkflowAsJson</strong></td><td>Downloads a workflow test as a JSON file string for export.</td></tr><tr><td>36</td><td><strong>POST /api/exportWorkflowTestAsString</strong></td><td>Serializes a workflow test to a JSON string for export or clipboard copy.</td></tr><tr><td>37</td><td><strong>POST /api/fetchCustomTestsCount</strong></td><td>Fetches the count of custom YAML test templates grouped by repository URL.</td></tr><tr><td>38</td><td><strong>POST /api/fetchCommonTestTemplate</strong></td><td>Fetches a common reusable test template by its identifier.</td></tr><tr><td>39</td><td><strong>POST /api/fetchTestContent</strong></td><td>Fetches the YAML content of a probe template for editing in the test editor.</td></tr><tr><td>40</td><td><strong>POST /api/fetchTestingRunPlaygroundStatus</strong></td><td>Fetches the execution status of a test run triggered from the probe editor playground.</td></tr><tr><td>41</td><td><strong>POST /api/fetchCallbackStatusForTestEditor</strong></td><td>Fetches the callback/async result status for a test run initiated from the test editor.</td></tr><tr><td>42</td><td><strong>POST /api/fetchOtpData/{uuid}</strong></td><td>Fetches OTP data associated with a specific UUID, used in login flow authentication setup.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchAuthMechanismData" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchTestRoles" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchTestingRunResults" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchActiveTestRunsStatus" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/retrieveAllCollectionTests" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchFilters" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchSearchTestResults" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchTestingSources" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchWorkflowTests" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchTestingRunResultSummary" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchAuthMechanismDataDoc" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchAllTestSuites" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchTestSuites" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchVulnerableRequests" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchTestingRunResultFromTestingRun" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchUsageTestRuns" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchTestingLogs" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getBUACategoryCount" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getNotTestedAPICount" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getOnlyOnceTestedAPICount" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchTestedApisRanges" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getMisConfiguredTestsCount" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchTestingRunsRanges" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getLastCalculatedInfo" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchTestingData" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchMiniTestingServiceNames" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchDefaultPayload" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchAllDefaultPayloads" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchGlobalVars" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchTestCollectionConfiguration" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchPropertyIds" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/buildDependencyTable" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchWorkflowResult" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchWorkflowTestingRun" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/downloadWorkflowAsJson" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/exportWorkflowTestAsString" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchCustomTestsCount" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchCommonTestTemplate" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchTestContent" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchTestingRunPlaygroundStatus" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchCallbackStatusForTestEditor" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchOtpData/{uuid}" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}
