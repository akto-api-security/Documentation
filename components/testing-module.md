# Testing module

<figure><img src="../.gitbook/assets/image (96) (1).png" alt=""><figcaption></figcaption></figure>

The Testing module is responsible to do API Security testing.

* Dockerhub version: aktosecurity/akto-api-testing:local
* Dockerfile [link](https://github.com/akto-api-security/akto/blob/master/docker-compose.yml#L24)
* Interaction: Testing module runs in a separate docker image. It polls **Database** for any pending tests. If found, it starts testing the APIs based on the test configuration. It then saves the test reports in **Database**. It might sometimes trigger an API call to **Puppeteer server** if the chrome-recording functionality is being used for automatic auth token generation.
* Architecture: Testing module docker runs on the same instance as Dashboard.

***

### What Does It Do?

*   **Polls for Test Jobs**:

    Regularly checks for **security tests** that need to be executed.
*   **Executes Tests**:

    Runs API security tests based on the configured test suite. Tests include a wide range of vulnerability categories like:

    * OWASP Top 10 API vulnerabilities
    * Authentication and authorization checks
    * Sensitive data exposure
    * Rate limiting, SSRF, and more
*   **Saves Results**:

    After execution, it **records detailed test reports**, including vulnerabilities found, request/response details, and severity.
*   **Supports Auth Token Automation**:

    When your API requires login, the module can automatically handle authentication by fetching the necessary security tokens.

***

### How It Fits Into Akto’s Architecture

* The Testing Module runs as a **separate service** and continuously **listens for new test jobs**.
* Once a job is found, it tests the relevant API endpoints and **pushes the results** to Akto, making them available on the Dashboard.
* Works alongside other modules like the [**Runtime Analyzer**](runtime-analyzer.md) and [**Traffic Mirroring Module**](traffic-mirroring-module.md) to provide a complete API security posture.

***

### Why It Matters

* ✅ **Automated Security Testing**: Eliminates manual effort by automatically testing your APIs for known vulnerabilities.
* ✅ **Covers All APIs**: Tests are run across **discovered APIs**, ensuring security coverage even for undocumented endpoints.
* ✅ **Auth Handling**: Supports dynamic token fetching to test **authenticated endpoints** seamlessly.

***

### Summary

The Testing Module is the **execution engine** behind Akto’s API security testing. It ensures your APIs are **continuously evaluated** against a broad set of security checks, helping identify risks early and at scale.

***

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
