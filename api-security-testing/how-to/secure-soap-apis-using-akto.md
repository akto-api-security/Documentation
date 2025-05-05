# Secure SOAP APIs using Akto

### Introduction

You can use Akto to help you secure your SOAP APIs in the CI/CD pipeline:

* Automate SOAP [API Inventory](secure-soap-apis-using-akto.md#api-inventory)
* Identify [Sensitive data exposure](secure-soap-apis-using-akto.md#sensitive-data-exposure)
* [Run test](secure-soap-apis-using-akto.md#run-owasp-top-10-tests) for OWASP API top 10 vulnerabilities
* Write your own [custom tests for SOAP APIs](secure-soap-apis-using-akto.md#custom-soap-security-tests)
* [Run tests in CI/CD](secure-soap-apis-using-akto.md#run-tests-in-ci-cd)

### API Inventory

Akto can automatically prepare an API Inventory for SOAP APIs. Use one of our [traffic connectors](broken-reference) or upload WSDL files directly. Akto will populate the dashboard with all detected SOAP operations and their request/response structures.

You will see a separate entry for each SOAP action (operation) along with its endpoint. Click on an API to view its detailed request and response XML schema.

### Sensitive data exposure

Go to [Sensitive Data](../../api-inventory-1/concepts/sensitive-data.md) to check if your APIs are sending sensitive or PII data in the API response. You can also [configure Slack/Webhook alerts](../../api-inventory-1/concepts/alerts.md) to get notified in real-time when sensitive data is detected.

### Run OWASP Top 10 tests

Click on the **Run Test** button to start testing your SOAP APIs for OWASP Top 10 and HackerOne Top 10 vulnerabilities.

Akto will automatically generate security tests tailored to SOAP, including testing for XML injection, weak authentication, and insecure deserialization vulnerabilities.

### Custom SOAP security tests

Using Akto’s test editor, you can write your own security tests for SOAP APIs. See instructions for custom tests [here](../../test-editor/concepts/custom-test.md).

Here are a few SOAP-specific test instructions you can use:

* add/modify SOAP headers
* inject payloads into XML body
* tamper SOAPAction value
* remove/alter XML nodes

### Run tests in CI/CD

You can automate SOAP API Security Testing by using our [GitHub action](run-test.md) or [pre-deployment hook](run-tests-in-cli-using-akto.md) to trigger tests in your CI/CD pipeline.

Feel free to write us at support@akto.io for any help.
