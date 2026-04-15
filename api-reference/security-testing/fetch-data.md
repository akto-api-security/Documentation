# Fetch Data

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="430">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/fetchAuthMechanismData</strong></td><td>Retrieve authentication mechanism details configured for scanning.</td></tr><tr><td>2</td><td><strong>POST /api/fetchTestRoles</strong></td><td>Fetch probe roles and their configurations for scanning.</td></tr><tr><td>3</td><td><strong>POST /api/fetchTestingRunResults</strong></td><td>Fetch the results of executed scan runs, including issues found and their severity.</td></tr><tr><td>4</td><td><strong>POST /api/fetchActiveTestRunsStatus</strong></td><td>Retrieve the current status of active or in-progress scan runs.</td></tr><tr><td>5</td><td><strong>POST /api/retrieveAllCollectionTests</strong></td><td>Retrieve all available scans mapped to each Agentic Collection.</td></tr><tr><td>6</td><td><strong>POST /api/fetchFilters</strong></td><td>Fetch available filters for organizing and querying scan results.</td></tr><tr><td>7</td><td><strong>POST /api/fetchSearchTestResults</strong></td><td>Search and retrieve scan results based on specified criteria.</td></tr><tr><td>8</td><td><strong>POST /api/fetchTestingSources</strong></td><td>Retrieve configured scanning sources and integrations.</td></tr><tr><td>9</td><td><strong>POST /api/fetchWorkflowTests</strong></td><td>Get workflow-based security scan definitions and configurations.</td></tr><tr><td>10</td><td><strong>POST /api/fetchTestingRunResultSummary</strong></td><td>Fetches a single testing run result summary by its hex ID.</td></tr><tr><td>11</td><td><strong>POST /api/fetchAuthMechanismDataDoc</strong></td><td>Fetches the raw authentication mechanism document for the current account.</td></tr><tr><td>12</td><td><strong>POST /api/fetchAllTestSuites</strong></td><td>Fetches both custom and default (built-in) test suites available in the account.</td></tr><tr><td>13</td><td><strong>POST /api/fetchTestSuites</strong></td><td>Fetches all available test suite enum types for onboarding flows.</td></tr><tr><td>14</td><td><strong>POST /api/fetchVulnerableRequests</strong></td><td>Fetches a paginated list of vulnerable HTTP requests from demo data, used for test template previews.</td></tr><tr><td>15</td><td><strong>POST /api/fetchTestingRunResultFromTestingRun</strong></td><td>Fetches the first testing run result associated with a given testing run hex ID.</td></tr><tr><td>16</td><td><strong>POST /api/fetchUsageTestRuns</strong></td><td>Checks whether the current account has any user-created test runs (excluding onboarding demo runs).</td></tr><tr><td>17</td><td><strong>POST /api/fetchTestingLogs</strong></td><td>Fetches testing engine logs within a specified time range.</td></tr><tr><td>18</td><td><strong>POST /api/getBUACategoryCount</strong></td><td>Counts the number of unique APIs affected by issues matching the given filter criteria.</td></tr><tr><td>19</td><td><strong>POST /api/getNotTestedAPICount</strong></td><td>Counts APIs that have never been tested, optionally filtered by collection.</td></tr><tr><td>20</td><td><strong>POST /api/getOnlyOnceTestedAPICount</strong></td><td>Counts APIs that have been tested exactly one time, optionally filtered by collection.</td></tr><tr><td>21</td><td><strong>POST /api/fetchTestedApisRanges</strong></td><td>Returns the count of tested APIs grouped by week (year_weekOfYear) for trend analysis.</td></tr><tr><td>22</td><td><strong>POST /api/getMisConfiguredTestsCount</strong></td><td>Counts test results that require additional configuration (REQUIRES_CONFIG flag).</td></tr><tr><td>23</td><td><strong>POST /api/fetchTestingRunsRanges</strong></td><td>Returns completed test run counts grouped by week (year_weekOfYear) for trend analysis.</td></tr><tr><td>24</td><td><strong>POST /api/getLastCalculatedInfo</strong></td><td>Fetches metadata about the last cron/background job execution for the current account.</td></tr><tr><td>25</td><td><strong>POST /api/fetchTestingData</strong></td><td>Returns consolidated testing coverage statistics (tested vs non-tested API counts) within a time range.</td></tr><tr><td>26</td><td><strong>POST /api/fetchMiniTestingServiceNames</strong></td><td>Returns the names of active mini-testing service modules with recent heartbeats.</td></tr><tr><td>27</td><td><strong>POST /api/fetchDefaultPayload</strong></td><td>Fetches the default payload configuration for a specific domain.</td></tr><tr><td>28</td><td><strong>POST /api/fetchAllDefaultPayloads</strong></td><td>Fetches all default payload configurations saved for the current account.</td></tr><tr><td>29</td><td><strong>POST /api/fetchGlobalVars</strong></td><td>Fetches saved global host variable mappings and known hosts for the specified collections.</td></tr><tr><td>30</td><td><strong>POST /api/fetchTestCollectionConfiguration</strong></td><td>Fetches test configuration properties (headers, cookies, auth requirements, etc.) for a specific API collection.</td></tr><tr><td>31</td><td><strong>POST /api/fetchPropertyIds</strong></td><td>Fetches all available test collection property types with their metadata.</td></tr><tr><td>32</td><td><strong>POST /api/buildDependencyTable</strong></td><td>Builds a paginated dependency flow table with API nodes, parameters, and replacement details.</td></tr></tbody></table>

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
