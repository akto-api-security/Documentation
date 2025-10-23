---
description: Enable Tree View to visualize MCP collections in a hierarchical structure for better organization.
---

# Enable Tree View for MCP Collections

The Tree View feature in Akto allows you to visualize your MCP collections in a hierarchical structure, making it easier to navigate and understand the organization of your MCP servers, tools, and resources. This guide will walk you through the process of enabling and using the Tree View.

## Steps to Enable Tree View

1. Navigate to **Agentic Discovery > Collections**
2. Filter or select **MCP Collections**
3. Locate the **More Actions** button in the top right
4. Open the dropdown menu
5. Select **Display tree view**

## Using the Tree View

Once enabled, the Tree View will organize your MCP collections hierarchically:

### Hierarchical Organization

**By Hostname**
- MCP servers grouped by their host
- See all MCP servers running on the same host
- Useful for infrastructure management

**By Groups**
- MCP servers organized by custom groups (e.g., Database MCP, Filesystem MCP)
- View MCP servers by functionality or risk level
- See MCP collections by environment (dev/staging/production)

**By MCP Server Type**
- Group by detected MCP server type (GitHub, Slack, Postgres, etc.)
- Organize by tool categories
- Filter by resource types

**Custom Categories**
- Custom organizational schemes you've defined
- Tag-based groupings
- Framework or provider-based organization

### Tree Navigation

- **Expand/Collapse**: Click the arrow next to any group name to expand or collapse
- **Nested Views**: See MCP tools within servers, resources within tools
- **Quick Access**: Jump directly to specific MCP components
- **Visual Hierarchy**: Understand MCP server relationships at a glance

## Switching Back to List View

To return to the standard list view:

1. Click on the **More Actions** button again
2. Select **Disable tree view**

The list view shows MCP collections in a flat, tabular format with sortable columns and advanced filtering options.