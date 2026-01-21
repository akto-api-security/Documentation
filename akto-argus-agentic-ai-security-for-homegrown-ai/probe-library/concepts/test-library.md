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

{% hint style="success" %}
Check out the t[test-categories.md](test-categories.md "mention") present in our library.&#x20;
{% endhint %}

{% hint style="info" %}
**Our methodology of building the test library:** We are building the test library keeping in mind the needs of our users. Our users care about covering OWASP Top 10 APIs and all the new critical vulnerabilities. Additionally, if we see our users creating custom tests that are also valuable for other members, we add those tests to our test library and make them available to everyone.
{% endhint %}

For more information on how to contribute to the test library, please refer to this documentation- [Contribute to Test Library](/broken/pages/ynkA1VzfvEo6zrElY94W).
