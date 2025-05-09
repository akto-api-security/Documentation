# Create Custom Test Suites

**Custom Test Suites** in Akto allow you to create tailored sets of security tests that align precisely with your application's unique requirements and risk profile. This feature is essential for teams that want more granular control over their API security testing, beyond the default pre-built Akto test collections.

<figure><img src="../../.gitbook/assets/image (103).png" alt=""><figcaption></figcaption></figure>

### How to Set Up

1. Navigate to the **Test Suite** section under **Testing** in the Akto dashboard.
2. Click to create a new suite or edit an existing one.
3. Select the required tests by category or by individual items.
4. Name your test suite (e.g., "Custom Suite for Payment APIs").
5. Save your configuration and use it in your testing workflows.

### Key Features

* **Flexible Test Selection:**\
  Choose from hundreds of tests across multiple categories, including:
  * Cross-site scripting (XSS)
  * Command Injection
  * Broken Object Level Authorization (BOLA)
  * Security Misconfiguration
  * Local File Inclusion (LFI)
  * Broken User Authentication (BUA)
  * Server Side Request Forgery (SSRF)
  * And more!
* **Category-Level and Individual Test Selection:**\
  You can select entire categories or drill down to individual tests (e.g., specific CRLF Injection tests like HTTP Header Abuse or Apache mod\_userdir CRLF injection).
* **Efficient Management:**\
  Easily search and filter tests to quickly assemble the suite that best suits your needs.
* **Reusable Configurations:**\
  Save your custom test suites for repeated use in different environments or across various stages of your CI/CD pipeline.

### Benefits

* **Precision Testing:** Focus on vulnerabilities that are most relevant to your API's functionality and architecture.
* **Reduced Noise:** Avoid unnecessary test results by excluding irrelevant categories.
* **Compliance & Security Goals:** Customize suites to align with specific compliance requirements (e.g., OWASP Top 10 API Security Risks).
