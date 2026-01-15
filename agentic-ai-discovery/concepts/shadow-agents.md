---
description: Akto can detect and alert about Shadow Agents
---

# Shadow Agents

Shadow Agents are AI agents or agentic components that exist within the system but are not documented or known to the managers or owners of the agentic ecosystem. These can pose a significant security risk as they can be exploited without detection.

For example, a development team might create a new version of an agent component (`/v3/agent`) but forgets to remove `/v2/agent`. If the team removes security controls and forgets to secure the `/v2` agent when the feature goes live, it becomes a Shadow Agent. Unauthorized users who discover this agent might be able to access sensitive data, invoke unauthorized tools, or perform actions that could harm the system.

Because `v2` is still active but not documented anymore, it will most likely bypass all future security checks. This unnoticed agent poses significant risk.

### How to Detect Shadow Agents

1. Navigate to **Agentic Discovery > Collections**
2. Look for the 'Shadow Agents' tab
3. Review flagged components for undocumented or deprecated agents
4. Run security scans to identify agents with missing documentation or security controls

Shadow agents can include:
- Deprecated agent endpoints still accepting requests
- Undocumented MCP tools or resources
- Agent components bypassing authentication
- Legacy AI agent versions with outdated security
