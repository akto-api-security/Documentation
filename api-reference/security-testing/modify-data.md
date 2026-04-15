# Modify Data

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="430">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/startTest</strong></td><td>Start a new scan run on the selected agentic collections or agentic components.</td></tr><tr><td>2</td><td><strong>POST /api/stopTest</strong></td><td>Stop an ongoing scan run before it completes.</td></tr><tr><td>3</td><td><strong>POST /api/addTestRoles</strong></td><td>Add scan roles for red teaming execution.</td></tr><tr><td>4</td><td><strong>POST /api/stopAllTests</strong></td><td>Stop all ongoing scan runs.</td></tr><tr><td>5</td><td><strong>POST /api/updateTestRoles</strong></td><td>Update test role configurations.</td></tr><tr><td>6</td><td><strong>POST /api/modifyTestingRunConfig</strong></td><td>Modifies an existing testing run configuration including test suites, subcategories, schedule, concurrency, alerts, role, and auto-ticketing settings.</td></tr><tr><td>7</td><td><strong>POST /api/addAuthMechanism</strong></td><td>Adds a new authentication mechanism (hardcoded token, login flow, sample data, or TLS) for API testing.</td></tr><tr><td>8</td><td><strong>POST /api/triggerLoginSteps</strong></td><td>Executes login flow steps and returns step-by-step responses. Used to validate login sequences before saving an auth mechanism.</td></tr><tr><td>9</td><td><strong>POST /api/createTestSuite</strong></td><td>Creates a new custom test suite with a given name and list of test subcategories.</td></tr><tr><td>10</td><td><strong>POST /api/modifyTestSuite</strong></td><td>Updates an existing custom test suite's name and/or subcategories.</td></tr><tr><td>11</td><td><strong>POST /api/deleteTestSuite</strong></td><td>Deletes a custom test suite by its hex ID.</td></tr><tr><td>12</td><td><strong>POST /api/bulkUpdateTestResultsSeverity</strong></td><td>Bulk-updates the severity level of selected test results across all related collections.</td></tr><tr><td>13</td><td><strong>POST /api/deleteTestRuns</strong></td><td>Deletes the specified test runs and schedules a background job to clean up associated results and summaries.</td></tr><tr><td>14</td><td><strong>POST /api/deleteTestRunsFromSummaries</strong></td><td>Deletes test data (results and summaries) identified by testing run result summary IDs via a background job.</td></tr><tr><td>15</td><td><strong>POST /api/changeStatus</strong></td><td>Changes the active/inactive status of a custom webhook and updates its associated scheduled job.</td></tr><tr><td>16</td><td><strong>POST /api/runOnce</strong></td><td>Triggers an immediate one-time asynchronous execution of a custom webhook.</td></tr><tr><td>17</td><td><strong>POST /api/runTestOnboarding</strong></td><td>Runs the onboarding test suite against a specified collection with provided auth credentials.</td></tr><tr><td>18</td><td><strong>POST /api/saveDefaultPayload</strong></td><td>Saves or updates a default payload pattern for a domain, recording the creator and timestamps.</td></tr><tr><td>19</td><td><strong>POST /api/saveReplaceDetails</strong></td><td>Saves key-value replacement pairs for a specific API endpoint, used in dependency flow testing.</td></tr><tr><td>20</td><td><strong>POST /api/saveGlobalVars</strong></td><td>Saves global host variable mappings for dependency flow testing.</td></tr><tr><td>21</td><td><strong>POST /api/invokeDependencyTable</strong></td><td>Asynchronously invokes the dependency graph build job for the specified collections.</td></tr></tbody></table>

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
