---
description: Control access to specific agent and MCP collections with granular RBAC.
---

# Collection-Based RBAC

Admins can grant users access to specific agent or MCP collections, providing granular control for dev teams and security teams.

## How It Works

- Assign users to specific collections (agent or MCP)
- Users only see and can manage their assigned collections
- Useful for team separation and compliance

## Use Cases

- **Team Isolation**: Give each team access to their own agents
- **Environment Control**: Restrict production agent access
- **Compliance**: Limit sensitive agent access to authorized users
- **MCP Security**: Control who can manage high-risk MCP servers

## Setting Up RBAC

1. Navigate to **Settings > Users & Roles**
2. Select a user or role
3. Assign specific agent/MCP collections
4. Set permissions (view, edit, test, delete)