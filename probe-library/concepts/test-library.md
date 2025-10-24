# Test Library

Akto offers the ability to add your own probes as YAML files, allowing you to execute personalized security tests alongside automated probes developed by Akto against your agent components and MCP endpoints. This streamlines the testing process and increases efficiency in identifying agentic security vulnerabilities.

### What is Akto's Probe Library?

Akto's Probe Library is an extensive collection of security tests specifically designed for agentic systems. It enables security testing of AI agents, LLM components, and MCP endpoints without writing code. This resource allows teams to quickly select from various probe scenarios targeting agent-specific vulnerabilities including prompt injections, tool abuse, and permission escalation.

### Why Probe Library is Essential?

The Probe Library is essential for several reasons:

* **Time Efficiency**: Security engineers can select from pre-existing probe scenarios specifically designed for agentic threats, avoiding time-consuming custom test creation
* **Focused Testing**: Target specific agent components, MCP endpoints, or tool integrations for comprehensive security testing
* **Agentic-Specific Coverage**: Access probes designed for autonomous system vulnerabilities that traditional API testing misses
* **Enhanced Productivity**: Optimize security efforts with specialized probes for AI agent architectures

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

For more information on how to contribute to the test library, please refer to this documentation- [Contribute to Test Library](../how-to/contribute-to-test-library.md).
