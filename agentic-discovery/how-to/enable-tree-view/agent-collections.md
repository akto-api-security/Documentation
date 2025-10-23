---
description: Enable Tree View to visualize agent collections in a hierarchical structure for better organization.
---

# Enable Tree View for Agent Collections

The Tree View feature in Akto allows you to visualize your agent collections in a hierarchical structure, making it easier to navigate and understand the organization of your AI agents, their components, and dependencies. This guide will walk you through the process of enabling and using the Tree View.

## Steps to Enable Tree View

1. Navigate to **Agentic Discovery > Collections**
2. Filter or select **Agent Collections**
3. Locate the **More Actions** button in the top right
4. Open the dropdown menu
5. Select **Display tree view**

## Using the Tree View

Once enabled, the Tree View will organize your agent collections hierarchically:

### Hierarchical Organization

**By Hostname**
- Agents grouped by their deployment host
- See all agents running on the same infrastructure
- Useful for infrastructure and capacity planning

**By Groups**
- Agents organized by custom groups (e.g., Customer Service Agents, Data Analysis Agents)
- View agents by functionality or business purpose
- See collections by environment (dev/staging/production)

**By Framework**
- Group by agent framework (LangChain, LlamaIndex, CrewAI, AutoGen)
- Organize by implementation approach
- Filter by framework version

**By LLM Provider**
- Group agents using OpenAI, Anthropic, Google, or other providers
- Understand cost distribution across providers
- Track provider dependencies

**Custom Categories**
- Custom organizational schemes you've defined
- Tag-based groupings
- Team-based organization

### Tree Navigation

- **Expand/Collapse**: Click the arrow next to any group name to expand or collapse
- **Nested Views**: See agent components within collections, tools within agents
- **Quick Access**: Jump directly to specific agent endpoints
- **Visual Hierarchy**: Understand agent relationships and dependencies at a glance

## Use Cases

### Agent Portfolio Management
View all agents by business function to understand your agentic capabilities and identify redundancies or gaps.

### Security Assessment
Group agents by risk level, data sensitivity, or public exposure to prioritize security testing and monitoring.

### Framework Migration
Organize agents by framework to plan migrations or consolidations (e.g., moving from LangChain to LlamaIndex).

### Cost Optimization
Group agents by LLM provider to understand cost distribution and identify optimization opportunities.

### Team Collaboration
Organize agents by team ownership to clarify responsibilities and facilitate handoffs.

## Switching Back to List View

To return to the standard list view:

1. Click on the **More Actions** button again
2. Select **Disable tree view**

The list view shows agent collections in a flat, tabular format with sortable columns and advanced filtering options.