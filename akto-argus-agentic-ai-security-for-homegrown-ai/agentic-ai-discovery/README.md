# Agentic AI Discovery

Agentic AI Discovery is your inventory of every AI agent and MCP server running across your cloud infrastructure. Once a [connector](../connectors/) is running, Akto continuously maps your agentic landscape: agents, MCP servers, the tools and data they touch, and how they connect to each other, so you always know what's actually deployed.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (224).png" alt="" width="563"><figcaption></figcaption></figure></div>

## What You Can Do

* Browse every discovered AI agent and MCP server as an organized [Collection](concepts/collections/), and drill into individual [Agent Components and MCP Endpoints](concepts/endpoints/).
* See each component's [risk score](concepts/risk-score.md), [sensitive data](concepts/sensitive-data.md) exposure, [auth type](concepts/auth-types.md), and [access type](concepts/access-type.md) at a glance.
* Catch what shouldn't still be running: [Shadow Agents](concepts/shadow-agents.md) nobody documented, [Zombie Agents](concepts/zombie-agents.md) nobody decommissioned, and [Third-Party Agents](concepts/third-party-agents.md) you depend on but don't control.
* Visualise how components connect with the [AI Agent Context Graph](concepts/api-dependency-graph.md) and [Context Graph & Trace Analysis](concepts/agent-architecture-and-trace-analysis.md).
* Organise your inventory with [Component Groups](concepts/component-group/), [Tags](concepts/tags.md), and [Environment Type](concepts/environment-type.md).
* Get notified the moment something changes, through [Recent Changes](concepts/recent-changes.md) and webhook [Alerts](concepts/alerts.md).
* Build collections directly from live traffic using [Explore Mode](concepts/explore-mode.md) and narrow any view with [Advanced Filters](concepts/advanced-filter-option.md).

## Getting Started

1. Connect a [homegrown discovery agent](../connectors/) for your infrastructure, API gateways, eBPF, Kubernetes, manual import, or MCP Recon.
2. Open **Agentic Discovery** in your dashboard to see every discovered agent, MCP server, and tool.
3. Select any component to inspect its endpoints, risk score, and meta properties.

## Next Steps

* Run [Red Teaming](../agentic-red-teaming/get-started/) on discovered components.
* Enable [Guardrails](../../agentic-guardrails/overview/) for real-time protection.
* Review Shadow, Zombie, and Third-Party agents for anything that shouldn't be reachable.

Need help? Contact support@akto.io or use in-app Intercom.
