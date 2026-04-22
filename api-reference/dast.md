# DAST

<table data-full-width="true"><thead><tr><th width="430">API</th><th>Description</th></tr></thead><tbody><tr><td><strong>POST /api/fetchAllDastScans</strong></td><td>Retrieve all DAST scan/crawl runs in active or completed states (RUNNING, COMPLETED, STOP_REQUESTED, STOPPED).</td></tr><tr><td><strong>POST /api/fetchDastScan</strong></td><td>Retrieve all URLs discovered by the crawler for a specific DAST crawl run.</td></tr><tr><td><strong>POST /api/fetchAvailableDastModules</strong></td><td>Retrieve available external DAST modules that have sent a heartbeat within the last 5 minutes.</td></tr><tr><td><strong>POST /api/initiateCrawler</strong></td><td>Start a DAST crawler targeting the specified host with configured authentication, URL patterns, and crawl options.</td></tr><tr><td><strong>POST /api/uploadCrawlerData</strong></td><td>Push raw crawler traffic data for a collection to the ingestion pipeline (Kafka) for async processing.</td></tr><tr><td><strong>POST /api/updateCrawlerStatus</strong></td><td>Update the status of an existing crawl run (RUNNING, COMPLETED, FAILED, or STOPPED).</td></tr><tr><td><strong>POST /api/stopCrawler</strong></td><td>Send a stop request to the internal DAST crawler service and mark the crawl run as STOP_REQUESTED.</td></tr><tr><td><strong>POST /api/saveCrawlerUrl</strong></td><td>Record a URL discovered during a crawl, along with provenance information and whether it was within scope.</td></tr></tbody></table>

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchAllDastScans" method="post" %}
[OpenAPI lastestscanresultv1](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/main/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchDastScan" method="post" %}
[OpenAPI lastestscanresultv1](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/main/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/fetchAvailableDastModules" method="post" %}
[OpenAPI lastestscanresultv1](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/main/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/initiateCrawler" method="post" %}
[OpenAPI lastestscanresultv1](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/main/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/uploadCrawlerData" method="post" %}
[OpenAPI lastestscanresultv1](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/main/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/updateCrawlerStatus" method="post" %}
[OpenAPI lastestscanresultv1](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/main/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/stopCrawler" method="post" %}
[OpenAPI lastestscanresultv1](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/main/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/saveCrawlerUrl" method="post" %}
[OpenAPI lastestscanresultv1](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/main/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}
