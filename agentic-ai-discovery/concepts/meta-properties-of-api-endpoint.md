---
description: View meta properties of agent components and MCP endpoints in Akto.
---

# Meta Properties of Agent Components

Meta properties provide critical security and access information about your agent components and MCP endpoints. These properties help you understand how components are authenticated, accessed, and secured across your agentic systems.

## Auth Type

Akto automatically detects standard authentication methods like JWT, Bearer tokens, and OAuth headers used by your AI agents and MCP servers. This helps identify and address potential security threats in agentic communications. However, not all agent systems follow standard practices, so Akto also supports custom authentication methods. [Read more here](auth-types.md).

### Authentication in Agentic Systems

AI agents and MCP servers may use various authentication approaches:

- **Standard Methods**: JWT tokens, Bearer tokens, API keys
- **Custom Headers**: Non-standard authentication headers specific to agent frameworks
- **MCP Authentication**: Model Context Protocol authentication mechanisms
- **Service-to-Service Auth**: mTLS, service accounts for agent-to-agent communication

For example, if your agent uses a non-standard authentication method, such as sending the auth token under a custom header like `X-Agent-Token`, Akto provides the flexibility to configure this as a custom auth type. This means you can customize Akto to suit the unique requirements of your agentic systems. Even if your authentication method doesn't align with standard practices, Akto can still analyze and secure it properly.

## Access Type

Akto provides visibility into your agent components and MCP endpoints, regardless of whether they're accessed from a public network, internally via microservices, or through agent-to-agent communication. This feature enables you to monitor and ensure that internal agents aren't exposed to the public network, thus enhancing your security posture. [Read more here](access-type.md).

### Access Type Categories

- **Public**: Agent components accessible from the internet
- **Private**: Internal agents only accessible within your network
- **Third-Party**: External AI services, LLM providers, or MCP servers
- **Inter-Agent**: Agent-to-agent communication endpoints

## Environment Type

Track which environment each agent component belongs to:
- Development
- Staging
- Production

This helps ensure you're applying appropriate security policies based on the deployment environment.

## Sensitivity Level

Indicates whether an agent component handles sensitive data:
- Personally Identifiable Information (PII)
- Financial data
- Health information
- Credentials or secrets
- Proprietary business data

## Risk Score

Akto automatically calculates a risk score for each agent component based on:
- Authentication weaknesses
- Sensitive data exposure
- Access patterns
- Known vulnerabilities
- Tool permissions (for MCP servers)