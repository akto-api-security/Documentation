# Fetch Data

<table data-full-width="true"><thead><tr><th width="425.9404296875">API</th><th>Description</th></tr></thead><tbody><tr><td><strong>POST /api/fetchSlackWebhooks</strong></td><td>Fetch the configured Slack webhooks that can be used for sending notifications.</td></tr><tr><td><strong>POST /api/fetchAuthMechanismData</strong></td><td>Retrieve authentication mechanism details (e.g., headers, tokens) configured for testing APIs.</td></tr><tr><td><strong>POST /api/fetchTestingRunResults</strong></td><td>Fetch the results of executed test runs, including issues found and their severity.</td></tr><tr><td><strong>POST /api/fetchActiveTestRunsStatus</strong></td><td>Retrieve the current status of active or in-progress test runs.</td></tr><tr><td><strong>POST /api/fetchTestRoles</strong></td><td>Fetch test roles and their associated permissions or configurations for API testing.</td></tr><tr><td><strong>POST /api/fetchMiniTestingServiceNames</strong></td><td>Get the names of mini-testing services available for distributed/parallel test execution.</td></tr><tr><td><strong>POST /api/retrieveAllCollectionTests</strong></td><td>Retrieve all available tests mapped to each API collection.</td></tr><tr><td><strong>POST /api/convertSamleDataToBurpRequest</strong></td><td>Convert an Akto HTTP sample message to a raw Burp Suite-compatible HTTP request string.</td></tr><tr><td><strong>POST /api/downloadBurpPluginJar</strong></td><td>Record a Burp plugin JAR download event and update the last downloaded timestamp for the user.</td></tr><tr><td><strong>POST /api/fetchBurpPluginDownloadLink</strong></td><td>Return the static download URL for the latest Akto Burp extension JAR.</td></tr><tr><td><strong>POST /api/fetchBurpCredentials</strong></td><td>Find or create a Burp-type API token for the current account for use with the Burp extension.</td></tr><tr><td><strong>POST /api/fetchBurpPluginInfo</strong></td><td>Return the last boot-up timestamp and version of the Akto Burp extension.</td></tr><tr><td><strong>POST /api/fetchRecordedFlowOutput</strong></td><td>Poll for the result of a recorded login flow execution and retrieve the extracted auth token when complete.</td></tr><tr><td><strong>POST /api/fetchRecordedLoginScreenshots</strong></td><td>Retrieve base64-encoded PNG screenshots captured during the last login flow execution for a test role.</td></tr></tbody></table>

{% openapi-operation spec="securitytestingv1" path="/api/fetchSlackWebhooks" method="post" %}
[OpenAPI securitytestingv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/a060843946aa15da0a921990dea9838dc099ddc4fa148069d2d4a3212a98ac44.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=44bf4ce9bb4173af2906b12dffb7c3f0f5c0f8254e8ed80f8c5ccd65188fb736&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="securitytestingv1" path="/api/fetchAuthMechanismData" method="post" %}
[OpenAPI securitytestingv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/a060843946aa15da0a921990dea9838dc099ddc4fa148069d2d4a3212a98ac44.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=44bf4ce9bb4173af2906b12dffb7c3f0f5c0f8254e8ed80f8c5ccd65188fb736&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="securitytestingv1" path="/api/fetchTestingRunResults" method="post" %}
[OpenAPI securitytestingv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/a060843946aa15da0a921990dea9838dc099ddc4fa148069d2d4a3212a98ac44.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=44bf4ce9bb4173af2906b12dffb7c3f0f5c0f8254e8ed80f8c5ccd65188fb736&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="securitytestingv1" path="/api/fetchActiveTestRunsStatus" method="post" %}
[OpenAPI securitytestingv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/a060843946aa15da0a921990dea9838dc099ddc4fa148069d2d4a3212a98ac44.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=44bf4ce9bb4173af2906b12dffb7c3f0f5c0f8254e8ed80f8c5ccd65188fb736&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="securitytestingv1" path="/api/fetchTestRoles" method="post" %}
[OpenAPI securitytestingv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/a060843946aa15da0a921990dea9838dc099ddc4fa148069d2d4a3212a98ac44.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=44bf4ce9bb4173af2906b12dffb7c3f0f5c0f8254e8ed80f8c5ccd65188fb736&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="securitytestingv1" path="/api/fetchMiniTestingServiceNames" method="post" %}
[OpenAPI securitytestingv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/a060843946aa15da0a921990dea9838dc099ddc4fa148069d2d4a3212a98ac44.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=44bf4ce9bb4173af2906b12dffb7c3f0f5c0f8254e8ed80f8c5ccd65188fb736&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="securitytestingv1" path="/api/retrieveAllCollectionTests" method="post" %}
[OpenAPI securitytestingv1](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/a060843946aa15da0a921990dea9838dc099ddc4fa148069d2d4a3212a98ac44.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250906%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250906T051536Z&X-Amz-Expires=172800&X-Amz-Signature=44bf4ce9bb4173af2906b12dffb7c3f0f5c0f8254e8ed80f8c5ccd65188fb736&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/convertSamleDataToBurpRequest" method="post" %}
[OpenAPI lastestscanresultv1](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/main/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/downloadBurpPluginJar" method="post" %}
[OpenAPI lastestscanresultv1](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/main/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchBurpPluginDownloadLink" method="post" %}
[OpenAPI lastestscanresultv1](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/main/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchBurpCredentials" method="post" %}
[OpenAPI lastestscanresultv1](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/main/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchBurpPluginInfo" method="post" %}
[OpenAPI lastestscanresultv1](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/main/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchRecordedFlowOutput" method="post" %}
[OpenAPI lastestscanresultv1](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/main/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchRecordedLoginScreenshots" method="post" %}
[OpenAPI lastestscanresultv1](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/main/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}
