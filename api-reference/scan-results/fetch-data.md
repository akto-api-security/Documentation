# Fetch Data

<table data-full-width="true"><thead><tr><th width="501.0283203125">API</th><th>Description</th></tr></thead><tbody><tr><td><strong>POST /api/fetchTestRunResultsCount</strong></td><td>Fetch the count of scan results, useful for pagination or summaries.</td></tr><tr><td><strong>POST /api/fetchSeverityInfoForIssues</strong></td><td>Retrieve aggregated severity information (Critical, High, Medium, Low) for issues.</td></tr><tr><td><strong>POST /api/fetchIssueFromTestRunResultDetails</strong></td><td>Get detailed issue information from a specific scan result.</td></tr><tr><td><strong>POST /api/fetchAllSubCategories</strong></td><td>Fetch all issue subcategories (e.g., SQLi, XSS under Injection) used for classification.</td></tr><tr><td><strong>POST /api/fetchRemediationInfo</strong></td><td>Retrieve remediation details and best practices for fixing a specific issue.</td></tr><tr><td><strong>POST /api/fetchTestRunResultDetails</strong></td><td>Get detailed information about a specific scan result.</td></tr><tr><td><strong>POST /api/findTotalIssuesByDay</strong></td><td>Fetch the total number of issues discovered per day, useful for trend analysis.</td></tr><tr><td><strong>POST /api/fetchAllIssues</strong></td><td>Retrieve all issues detected across agentic collections and scan runs.</td></tr><tr><td><strong>POST /api/fetchTestingRunResultSummaries</strong></td><td>Fetch summaries of scan results (high-level overview of findings).</td></tr><tr><td><strong>POST /api/generateReportPDF</strong></td><td>Generate a downloadable PDF report of scan results and issues.</td></tr><tr><td><strong>POST /api/fetchTestingRunResults</strong></td><td>Fetch detailed scan results including all issues found.</td></tr><tr><td><strong>POST /api/fetchActiveTestRunsStatus</strong></td><td>Retrieve the current status of active scan runs.</td></tr><tr><td><strong>POST /api/fetchTestResultsStatsCount</strong></td><td>Get statistical counts of scan results grouped by categories (e.g., pass/fail).</td></tr><tr><td><strong>POST /api/fetchTestingRunResult</strong></td><td>Fetch a single scan result with its details.</td></tr><tr><td><strong>POST /api/fetchVulnerableTestingRunResultsFromIssues</strong></td><td>Retrieve scan results linked to vulnerable issues.</td></tr><tr><td><strong>POST /api/getAllTestsCountMap</strong></td><td>Get a count map of all available probes grouped by categories/subcategories.</td></tr><tr><td><strong>POST /api/retrieveAllCollectionTests</strong></td><td>Retrieve all probes mapped to agentic collections.</td></tr><tr><td><strong>POST /api/fetchTestingRunResultsSummary</strong></td><td>Fetch a summary of scan results, highlighting major findings.</td></tr><tr><td><strong>POST /api/fetchIssuesByApis</strong></td><td>Get all issues grouped by Agentic Components for better component-level visibility.</td></tr><tr><td><strong>POST /api/fetchIssuesFromResultIds</strong></td><td>Fetch issues associated with specific scan result IDs.</td></tr><tr><td><strong>POST /api/fetchCriticalIssuesTrend</strong></td><td>Retrieve the trend of critical issues over time.</td></tr><tr><td><strong>POST /api/fetchTestCoverageData</strong></td><td>Fetch scan coverage data showing which agentic components have been scanned and which remain unscanned.</td></tr><tr><td><strong>POST /api/fetchCategoryWiseScores</strong></td><td>Get probe scores grouped by probe category (OWASP, CWE, etc.).</td></tr><tr><td><strong>POST /api/fetchVulnerableTestRunResults</strong></td><td>Get scan results that found vulnerabilities.</td></tr><tr><td><strong>POST /api/fetchAffectedEndpoints</strong></td><td>Retrieve Agentic components affected by specific issues or vulnerabilities.</td></tr><tr><td><strong>POST /api/fetchSensitiveSampleData</strong></td><td>Fetch sample data containing sensitive information from scan results.</td></tr><tr><td><strong>POST /api/fetchSubTypeCountMap</strong></td><td>Get a count map of issue subtypes from scan results.</td></tr></tbody></table>



{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchTestRunResultsCount" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchSeverityInfoForIssues" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchIssueFromTestRunResultDetails" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchAllSubCategories" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchRemediationInfo" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchTestRunResultDetails" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/findTotalIssuesByDay" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchAllIssues" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchTestingRunResultSummaries" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/generateReportPDF" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchTestingRunResults" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchActiveTestRunsStatus" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchTestResultsStatsCount" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchTestingRunResult" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchVulnerableTestingRunResultsFromIssues" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getAllTestsCountMap" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/retrieveAllCollectionTests" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchTestingRunResultsSummary" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchIssuesByApis" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchIssuesFromResultIds" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchCriticalIssuesTrend" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchTestCoverageData" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchCategoryWiseScores" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchVulnerableTestRunResults" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchAffectedEndpoints" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchSensitiveSampleData" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchSubTypeCountMap" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}
