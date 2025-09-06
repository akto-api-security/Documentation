# Fetch Data

<table data-full-width="true"><thead><tr><th width="501.0283203125">API</th><th>Description</th></tr></thead><tbody><tr><td><strong>POST /api/fetchTestRunResultsCount</strong></td><td>Fetch the count of test run results, useful for pagination or summaries.</td></tr><tr><td><strong>POST /api/fetchSeverityInfoForIssues</strong></td><td>Retrieve aggregated severity information (Critical, High, Medium, Low) for issues.</td></tr><tr><td><strong>POST /api/fetchIssueFromTestRunResultDetails</strong></td><td>Get detailed issue information from a specific test run result.</td></tr><tr><td><strong>POST /api/fetchAllSubCategories</strong></td><td>Fetch all issue subcategories (e.g., SQLi, XSS under Injection) used for classification.</td></tr><tr><td><strong>POST /api/fetchRemediationInfo</strong></td><td>Retrieve remediation details and best practices for fixing a specific issue.</td></tr><tr><td><strong>POST /api/fetchTestRunResultDetails</strong></td><td>Get detailed information about a specific test run result.</td></tr><tr><td><strong>POST /api/findTotalIssuesByDay</strong></td><td>Fetch the total number of issues discovered per day, useful for trend analysis.</td></tr><tr><td><strong>POST /api/fetchAllIssues</strong></td><td>Retrieve all issues detected across collections and test runs.</td></tr><tr><td><strong>POST /api/fetchTestingRunResultSummaries</strong></td><td>Fetch summaries of testing run results (high-level overview of findings).</td></tr><tr><td><strong>POST /api/generateReportPDF</strong></td><td>Generate a downloadable PDF report of test results and issues.</td></tr><tr><td><strong>POST /api/fetchFilterYamlTemplate</strong></td><td>Retrieve the YAML template for issue filters, used for customizing reports or queries.</td></tr><tr><td><strong>POST /api/fetchTestingRunResults</strong></td><td>Fetch detailed testing run results including all issues found.</td></tr><tr><td><strong>POST /api/fetchActiveTestRunsStatus</strong></td><td>Retrieve the current status of active test runs.</td></tr><tr><td><strong>POST /api/fetchTestResultsStatsCount</strong></td><td>Get statistical counts of test results grouped by categories (e.g., pass/fail).</td></tr><tr><td><strong>POST /api/fetchTestingRunResult</strong></td><td>Fetch a single testing run result with its details.</td></tr><tr><td><strong>POST /api/fetchVulnerableTestingRunResultsFromIssues</strong></td><td>Retrieve test run results linked to vulnerable issues.</td></tr><tr><td><strong>POST /api/getAllTestsCountMap</strong></td><td>Get a count map of all available tests grouped by categories/subcategories.</td></tr><tr><td><strong>POST /api/retrieveAllCollectionTests</strong></td><td>Retrieve all tests mapped to API collections.</td></tr><tr><td><strong>POST /api/fetchTestingRunResultsSummary</strong></td><td>Fetch a summary of testing run results, highlighting major findings.</td></tr><tr><td><strong>POST /api/fetchIssuesByApis</strong></td><td>Get all issues grouped by APIs for better endpoint-level visibility.</td></tr><tr><td><strong>POST /api/fetchIssuesFromResultIds</strong></td><td>Fetch issues associated with specific test run result IDs.</td></tr><tr><td><strong>POST /api/fetchCriticalIssuesTrend</strong></td><td>Retrieve the trend of critical issues over time.</td></tr><tr><td><strong>POST /api/fetchTestCoverageData</strong></td><td>Fetch test coverage data showing which APIs/endpoints have been tested and which remain untested.</td></tr></tbody></table>



{% openapi-operation spec="lastestscanresultv1" path="/api/fetchTestRunResultsCount" method="post" %}
[OpenAPI lastestscanresultv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/763b0381a96219df166afb4026ffb810d7225df22b0d32ca48eec701026175d4.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=5c9d924273711f9feb75bb1de9d614e9dcff4f7f26e19aaaccbe9c7dc235cb14&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchSeverityInfoForIssues" method="post" %}
[OpenAPI lastestscanresultv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/763b0381a96219df166afb4026ffb810d7225df22b0d32ca48eec701026175d4.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=5c9d924273711f9feb75bb1de9d614e9dcff4f7f26e19aaaccbe9c7dc235cb14&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchIssueFromTestRunResultDetails" method="post" %}
[OpenAPI lastestscanresultv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/763b0381a96219df166afb4026ffb810d7225df22b0d32ca48eec701026175d4.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=5c9d924273711f9feb75bb1de9d614e9dcff4f7f26e19aaaccbe9c7dc235cb14&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchAllSubCategories" method="post" %}
[OpenAPI lastestscanresultv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/763b0381a96219df166afb4026ffb810d7225df22b0d32ca48eec701026175d4.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=5c9d924273711f9feb75bb1de9d614e9dcff4f7f26e19aaaccbe9c7dc235cb14&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchRemediationInfo" method="post" %}
[OpenAPI lastestscanresultv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/763b0381a96219df166afb4026ffb810d7225df22b0d32ca48eec701026175d4.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=5c9d924273711f9feb75bb1de9d614e9dcff4f7f26e19aaaccbe9c7dc235cb14&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchTestRunResultDetails" method="post" %}
[OpenAPI lastestscanresultv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/763b0381a96219df166afb4026ffb810d7225df22b0d32ca48eec701026175d4.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=5c9d924273711f9feb75bb1de9d614e9dcff4f7f26e19aaaccbe9c7dc235cb14&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/findTotalIssuesByDay" method="post" %}
[OpenAPI lastestscanresultv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/763b0381a96219df166afb4026ffb810d7225df22b0d32ca48eec701026175d4.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=5c9d924273711f9feb75bb1de9d614e9dcff4f7f26e19aaaccbe9c7dc235cb14&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchAllIssues" method="post" %}
[OpenAPI lastestscanresultv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/763b0381a96219df166afb4026ffb810d7225df22b0d32ca48eec701026175d4.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=5c9d924273711f9feb75bb1de9d614e9dcff4f7f26e19aaaccbe9c7dc235cb14&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchTestingRunResultSummaries" method="post" %}
[OpenAPI lastestscanresultv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/763b0381a96219df166afb4026ffb810d7225df22b0d32ca48eec701026175d4.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=5c9d924273711f9feb75bb1de9d614e9dcff4f7f26e19aaaccbe9c7dc235cb14&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/generateReportPDF" method="post" %}
[OpenAPI lastestscanresultv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/763b0381a96219df166afb4026ffb810d7225df22b0d32ca48eec701026175d4.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=5c9d924273711f9feb75bb1de9d614e9dcff4f7f26e19aaaccbe9c7dc235cb14&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchFilterYamlTemplate" method="post" %}
[OpenAPI lastestscanresultv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/763b0381a96219df166afb4026ffb810d7225df22b0d32ca48eec701026175d4.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=5c9d924273711f9feb75bb1de9d614e9dcff4f7f26e19aaaccbe9c7dc235cb14&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchTestingRunResults" method="post" %}
[OpenAPI lastestscanresultv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/763b0381a96219df166afb4026ffb810d7225df22b0d32ca48eec701026175d4.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=5c9d924273711f9feb75bb1de9d614e9dcff4f7f26e19aaaccbe9c7dc235cb14&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchActiveTestRunsStatus" method="post" %}
[OpenAPI lastestscanresultv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/763b0381a96219df166afb4026ffb810d7225df22b0d32ca48eec701026175d4.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=5c9d924273711f9feb75bb1de9d614e9dcff4f7f26e19aaaccbe9c7dc235cb14&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchTestResultsStatsCount" method="post" %}
[OpenAPI lastestscanresultv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/763b0381a96219df166afb4026ffb810d7225df22b0d32ca48eec701026175d4.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=5c9d924273711f9feb75bb1de9d614e9dcff4f7f26e19aaaccbe9c7dc235cb14&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchTestingRunResult" method="post" %}
[OpenAPI lastestscanresultv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/763b0381a96219df166afb4026ffb810d7225df22b0d32ca48eec701026175d4.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=5c9d924273711f9feb75bb1de9d614e9dcff4f7f26e19aaaccbe9c7dc235cb14&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchVulnerableTestingRunResultsFromIssues" method="post" %}
[OpenAPI lastestscanresultv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/763b0381a96219df166afb4026ffb810d7225df22b0d32ca48eec701026175d4.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=5c9d924273711f9feb75bb1de9d614e9dcff4f7f26e19aaaccbe9c7dc235cb14&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/getAllTestsCountMap" method="post" %}
[OpenAPI lastestscanresultv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/763b0381a96219df166afb4026ffb810d7225df22b0d32ca48eec701026175d4.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=5c9d924273711f9feb75bb1de9d614e9dcff4f7f26e19aaaccbe9c7dc235cb14&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/retrieveAllCollectionTests" method="post" %}
[OpenAPI lastestscanresultv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/763b0381a96219df166afb4026ffb810d7225df22b0d32ca48eec701026175d4.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=5c9d924273711f9feb75bb1de9d614e9dcff4f7f26e19aaaccbe9c7dc235cb14&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchTestingRunResultsSummary" method="post" %}
[OpenAPI lastestscanresultv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/763b0381a96219df166afb4026ffb810d7225df22b0d32ca48eec701026175d4.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=5c9d924273711f9feb75bb1de9d614e9dcff4f7f26e19aaaccbe9c7dc235cb14&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchIssuesByApis" method="post" %}
[OpenAPI lastestscanresultv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/763b0381a96219df166afb4026ffb810d7225df22b0d32ca48eec701026175d4.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=5c9d924273711f9feb75bb1de9d614e9dcff4f7f26e19aaaccbe9c7dc235cb14&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchIssuesFromResultIds" method="post" %}
[OpenAPI lastestscanresultv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/763b0381a96219df166afb4026ffb810d7225df22b0d32ca48eec701026175d4.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=5c9d924273711f9feb75bb1de9d614e9dcff4f7f26e19aaaccbe9c7dc235cb14&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchCriticalIssuesTrend" method="post" %}
[OpenAPI lastestscanresultv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/763b0381a96219df166afb4026ffb810d7225df22b0d32ca48eec701026175d4.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=5c9d924273711f9feb75bb1de9d614e9dcff4f7f26e19aaaccbe9c7dc235cb14&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchTestCoverageData" method="post" %}
[OpenAPI lastestscanresultv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/763b0381a96219df166afb4026ffb810d7225df22b0d32ca48eec701026175d4.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=5c9d924273711f9feb75bb1de9d614e9dcff4f7f26e19aaaccbe9c7dc235cb14&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}
