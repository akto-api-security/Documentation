---
description: >-
  Third-party agent components represent external AI services, MCP servers, and
  agentic endpoints that your application integrates with but doesn't control directly.
---

# Third Party Agent Components

In Akto's Agentic inventory, these are clearly marked with the "Third-party" access type, helping you distinguish them from your internal agent components. This categorization is crucial for maintaining visibility over your application's external agentic dependencies and ensuring proper security monitoring of all third-party AI integrations.

## What Are Third-Party Agent Components?

Third-party agent components include:

- **External MCP Servers**: Model Context Protocol servers hosted by third parties (e.g., GitHub MCP, Slack MCP, external database connectors)
- **Third-Party AI Models**: OpenAI, Anthropic, Google, or other LLM providers accessed by your agents
- **External Tools**: APIs and services invoked by your AI agents that you don't control
- **Managed Agent Services**: SaaS-based agentic platforms and frameworks

## Why Track Third-Party Components?

Monitoring third-party agent components is essential for:

- **Security Visibility**: Understanding what external services your agents can access
- **Data Flow Tracking**: Identifying where sensitive data is sent outside your system
- **Compliance**: Meeting regulatory requirements for third-party integrations
- **Risk Management**: Assessing the security posture of external dependencies
- **Supply Chain Security**: Protecting against compromised third-party services

## How to View Third-Party Components

1. Navigate to **Agentic Discovery > Collections**
2. Filter by access type: "Third-party"
3. Review all external agent components and their permissions
4. Analyze data flows to and from third-party services
5. Apply appropriate security policies and monitoring

Akto automatically detects and categorizes third-party components based on traffic analysis and endpoint patterns, giving you complete visibility into your agentic application's external dependencies.
