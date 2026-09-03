# Agentic AI Discovery

Agentic AI Discovery is where you drill into everything your Atlas connectors surface: every agentic asset, endpoint, session, and MCP interaction across your employees' devices.

## What You Can Do

* Review your full inventory of AI Agents, SaaS Agents, MCP Servers, LLMs, Skills, and Plugins.
* Drill into an asset's endpoints, then into a single tool call or MCP method.
* Trace every AI/LLM session: who prompted which model, and how many tokens it cost.
* Approve, block, or conditionally allow MCP servers and the capabilities they expose.
* Look up any user or device, and assign teams and roles for context.
* Inspect any endpoint's device details, MCP servers, apps, and logs, and configure protection on it.

## Available Views

### [Agentic Assets](agentic-assets/)

Your inventory of AI Agents, SaaS Agents, MCP Servers, LLMs, Skills, and Plugins, with risk score, sensitive-data flags, and last-seen traffic. Drill into an asset's endpoints, then into its [Agentic Components](agentic-components/), the individual tool calls and MCP methods it exposes. The [Skills tab](agentic-skills/) covers the callable capabilities your employees' agents expose, scanned for prompt injection, credential leakage, and malicious code.

### [Endpoints](users-and-devices.md)

A complete inventory of discovered users and devices, with the ability to assign teams and roles for filtering and investigation.

### [Traces](traces.md)

Every AI/LLM session across your organization: who prompted which model, how many tokens it consumed, and the full input/output for each trace.

### [Sensitive Data](../../akto-argus-agentic-ai-security-for-homegrown-ai/agentic-ai-discovery/concepts/sensitive-data.md)

The sensitive data types Akto detects flowing through your agent components and MCP endpoints.

### [Audit Data](audit-data-akto-atlas.md)

Every MCP server your employees' agents interact with, with controls to allow, block, or conditionally allow servers and specific capabilities.

### [Endpoint Shield](view-endpoint-shield-details.md)

Every endpoint discovered across your connectors, with device, MCP server, app, and log detail, plus the tools to configure protection on it.

## Next Step

Cross-reference what you find here with [NHI Governance](../nhi-governance/) for credential risk, and enforce policy on it with [Atlas Guardrails](../atlas-guardrails.md).
