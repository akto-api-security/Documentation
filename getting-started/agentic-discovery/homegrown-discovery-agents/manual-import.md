# Manual Import

Manual import allows you to directly import your AI agents, MCP servers, and AI models into Akto for security testing without setting up continuous discovery agents. This is perfect for quick testing, CI/CD pipelines, or when you only need to test specific components.

## When to Use Manual Import

Manual import is ideal when you:
- Want to test specific AI agents or MCP servers without full infrastructure setup
- Need to run security tests in your CI/CD pipeline
- Have standalone AI models or agents to validate
- Prefer a quick start without deploying discovery agents

## Import Options

### Import AI Agents
Import AI agents from AWS Bedrock, Azure AI Foundry, Databricks, Google Vertex AI, IBM Watsonx, or your custom agents directly into Akto for security testing.

→ [Import AI Agents](../../../agentic-red-teaming/ai-agent-import.md)

### Import MCP Servers
Import MCP servers by connecting to their SSE endpoints. Akto will automatically discover all tools, resources, and prompts for testing.

→ [Import MCP Servers](../../../agentic-red-teaming/mcp-import.md)

### Import AI Models
Import large language models and custom AI implementations for comprehensive security testing.

→ [Import AI Models](../../../agentic-red-teaming/ai-model-import.md)

## What Happens After Import

Once you import your components:
1. They appear in your Akto inventory immediately
2. You can run security tests right away
3. Akto identifies vulnerabilities specific to your agent or model
4. You get detailed remediation guidance for any issues found

For continuous discovery of your infrastructure, consider setting up [homegrown discovery agents](../api-gateways/) or [endpoints discovery agents](../../endpoints-discovery-agents/).
