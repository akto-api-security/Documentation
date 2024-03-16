# Test Library

Akto offers you the ability to add your own tests as YAML files, hence, allowing you to execute your personalized tests alongside the automated tests developed by Akto against your API collections. This functionality streamlines the testing process and increases the efficiency of identifying and addressing potential security vulnerabilities in your APIs.

### What is Akto's Test Library?

Akto's test library is an extensive collection of tests that allows for security testing without writing code. It is a useful resource for testers who want to quickly select from various test scenarios to test different parts of software or systems. This approach saves time and ensures a more efficient testing process.

### Why Test Library is Needed?

A Test Library is essential for several reasons:

* **Time Efficiency**: Security engineers can easily select from various pre-existing test scenarios, avoiding the time-consuming task of creating security test cases from the initial phase.
* **Focused Testing:** You can target a particular API or a set of APIs (workflow) for security testing.
* **Enhanced Productivity**: By leveraging the Test Library, security engineers can optimize their efforts, ensuring a more efficient and thorough testing process.

Today we have the following test categories in our library, each one having multiple tests:

1\. [Broken Object Level Authorization (BOLA)](https://www.akto.io/test-library/broken-object-level-authorization)

2\. [Cross-Origin Resource Sharing (CORS)](https://www.akto.io/test-library/cross-origin-resource-sharing)

3\. [Broken User Authentication (BUA)](https://www.akto.io/test-library/broken-user-authentication)

4\. [Misconfigured HTTP Headers (MHH)](https://www.akto.io/test-library/misconfigured-http-headers)

5\. [Verbose Error Messages (VEM)](https://www.akto.io/test-library/verbose-error-messages)

6\. [Server Side Request Forgery (SSRF)](https://www.akto.io/test-library/server-side-request-forgery)

7\. [Unnecessary HTTP Methods (UHM)](https://www.akto.io/test-library/unnecessary-http-methods)

8\. [Mass Assignment (MA)](https://www.akto.io/test-library/mass-assignment)

9\. [Security Misconfiguration (SM)](https://www.akto.io/test-library/security-misconfiguration)

10\. [Lack of Resources & Rate Limiting (RL)](https://www.akto.io/test-library/lack-of-resources-and-rate-limiting)

11\. [Server Version Disclosure (SVD)](https://www.akto.io/test-library/server-version-disclosure)

12\. [Server Side Template Injection (SSTI)](https://www.akto.io/test-library/server-side-template-injection)

13\. [Local File Inclusion (LFI)](https://www.akto.io/test-library/local-file-inclusion)

14\. [Command Injection](https://www.akto.io/test-library/command-injection)

15\. [CRLF Injection](https://www.akto.io/test-library/crlf-injection)

16\. [Cross-site scripting (XSS)](https://www.akto.io/test-library/cross-site-scripting)

{% hint style="info" %}
**Our methodology of building the test library:** We are building the test library keeping in mind the needs of our users. Our users care about covering OWASP Top 10 APIs and all the new critical vulnerabilities. Additionally, if we see our users creating custom tests that are also valuable for other members, we add those tests to our test library and make them available to everyone.
{% endhint %}

For more information on how to contribute to the test library, please refer to this documentation- [Contribute to Test Library](../../how-to/contribute-to-test-library.md).
