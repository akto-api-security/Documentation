# Secure REST APIs using Akto

### Introduction

You can use Akto to help you secure your REST APIs in the CI/CD pipeline:

* Automate REST [API Inventory](secure-rest-apis-using-akto.md#api-inventory)
* Identify [Sensitive data exposure](secure-rest-apis-using-akto.md#sensitive-data-exposure)
* [Run test](secure-rest-apis-using-akto.md#run-owasp-top-10-tests) for OWASP API top 10 vulnerabilities
* Write your own [custom tests for REST APIs](secure-rest-apis-using-akto.md#custom-rest-security-tests)
* [Run tests in CI/CD](secure-rest-apis-using-akto.md#run-tests-in-ci-cd)

### API Inventory

Akto can automatically prepare an API Inventory for REST APIs. Use one of our [traffic connectors](broken-reference) to capture API traffic. Akto will start populating API endpoints, methods, and parameters in the dashboard.

You will see a separate entry for each endpoint along with its HTTP method (GET, POST, PUT, DELETE).

Click on the API to see its request and response schema.

### Sensitive data exposure

Go to [Sensitive Data](../../api-inventory-1/concepts/sensitive-data.md) to check if your APIs are sending sensitive or PII data in the API response. You can also [configure Slack/Webhook alerts](../../api-inventory-1/concepts/alerts.md) for real-time notifications.

### Run OWASP Top 10 tests

Click on the **Run Test** button to start testing your APIs for all OWASP Top 10 and Hackerone Top 10 vulnerabilities.

Akto will automatically generate and run security tests for your API endpoints, covering risks like broken authentication, mass assignment, injection vulnerabilities, and more.

### Custom REST security tests

Using Akto's unique test editor, you can also write your own security tests for REST APIs. See instructions for custom tests [here](../../test-editor/concepts/custom-test.md).

There are a few REST-specific instructions you can use:

* add header
* modify parameter
* inject payload in body
* change query param

### Run tests in CI/CD

You can also automate REST API Security Testing by using our [GitHub action](run-test.md) or [pre-deployment hook](run-tests-in-cli-using-akto.md) to trigger tests in your CI/CD pipeline.

Feel free to write us at support@akto.io for any help.
