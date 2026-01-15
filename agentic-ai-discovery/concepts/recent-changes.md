---
description: Explore agent component changes and updates across your agentic systems.
---

# Recent Changes

If you want to check all the agent components and parameters that have been newly added to your agentic collections or components that have experienced changes, you can navigate to the Recent Changes section from the Akto Dashboard.

## View Recent Changes

Monitor changes to your AI agents and MCP components over time to maintain security visibility and track system evolution.

### How to Access Recent Changes

1. Navigate to **Agentic Discovery > Recent Changes**
2. Select your time period (e.g., last 7 days, last 30 days, last 2 months)
3. Review all new and modified agent components
4. Click on any component to view detailed changes

### What You Can Track

The Recent Changes section shows:

- **New Agent Components**: Newly discovered AI agents or MCP endpoints
- **Modified Components**: Changes to existing agent configurations
- **New Parameters**: Additional input/output parameters for agents
- **Sensitive Data Detection**: Components sharing sensitive information
- **Tool Additions**: New tools or resources added to MCP servers
- **Framework Updates**: Changes to underlying agent frameworks (LangChain, LlamaIndex, etc.)

### Example Use Case

For instance, you might observe that 15 new agent components were introduced in the last two months, with 3 of them sharing sensitive data. For example, an agent component like `/admin/user-config` might be sending out an **Email ID** or **API Key** in its response, which requires immediate security review.

## Configure Alerts

You can configure alerts to be notified when new agent components are discovered or existing components change. This helps you:

- Respond quickly to unauthorized agents
- Track system evolution
- Maintain security compliance
- Monitor for shadow or zombie agents
