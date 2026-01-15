---
description: Akto can detect and alert about Zombie Agents
---

# Zombie Agents

Zombie Agents are AI agents or agentic components that were once in use but are now outdated, deprecated, or no longer intended to be used — yet remain accessible within the system. These stale agents may be overlooked during regular maintenance but can still expose sensitive data or functionality to attackers.

For example, an older agent endpoint used during a previous product release might still be running (`/v1/legacy-agent`) even after the product has migrated to newer agents (`/v3/`). If this endpoint isn't properly decommissioned, it becomes a Zombie Agent.

## Why Zombie Agents Are Dangerous

Zombie Agents pose significant security risks because they:

- Often lack current security protections and guardrails
- Are forgotten in documentation and security audits
- Provide attackers with an unmonitored entry point
- May have access to sensitive tools or data sources
- Bypass modern authentication and authorization controls

Since these agent components are not in active use or visible to developers, they can easily go undetected while remaining exposed to potential attacks.

## Detect Zombie Agents

Akto automatically flags outdated and unused agent components by identifying those with little or no traffic over a significant period — marking them as **Zombie Agents**.

You can monitor and test your agent collections for these stale components using Akto's built-in detection logic under the **Zombie Agent** tag. This uses behavioral analysis and component activity tracking to highlight potential zombie endpoints.

### How to Detect Zombie Agents

1. Navigate to **Agentic Discovery > Collections**
2. Click the Zombie tab from the table,
3. Review agents with low or no activity over extended periods
4. Analyze components that haven't been invoked recently
5. Decommission or secure identified zombie agents

Zombie agents can include:
- Deprecated AI agent endpoints
- Unused MCP servers or tools
- Stale agentic workflows
- Legacy agent components with no recent activity
