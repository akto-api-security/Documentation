---
description: Organize and categorize related MCP servers, tools, and resources using MCP Groups.
---

# MCP Groups

MCP Groups are a feature in Akto that allow you to organize and categorize related MCP (Model Context Protocol) servers, tools, resources, and prompts. This functionality helps in managing large MCP inventories by grouping components based on common characteristics, functionalities, providers, or any other relevant criteria.

## What is an MCP Group?

An MCP Group is a logical collection of MCP components that share common attributes. Unlike collections, which are primarily for discovery and organization, groups enable you to:

- Apply bulk security policies to MCP servers
- Run targeted security tests on MCP tools
- Monitor related MCP components together
- Manage access control at the group level
- Track metrics across similar MCP servers

## Use Cases

### Security Testing by MCP Group

Run comprehensive security tests on:
- All MCP servers with write permissions
- All MCP servers accessing databases
- All MCP servers handling PII
- All publicly accessible MCP endpoints

### Cost Management

Track and optimize costs for:
- High-usage MCP server groups
- External API-calling MCP tools
- Resource-intensive MCP operations

### Performance Optimization

Monitor and improve:
- Response times for MCP tool invocations
- Error rates by MCP server type
- Tool usage patterns by group

## MCP-Specific Considerations

### Tool Permissions

Group MCP servers by the permissions their tools require:
- **File System Access**: Read/write to local files
- **Network Access**: HTTP requests, API calls
- **Database Access**: Query and modify databases
- **System Commands**: Execute shell commands

### Resource Types

Group by MCP resource types provided:
- **Documents**: File-based resources
- **Database Records**: Structured data resources
- **API Endpoints**: External service resources
- **Search Results**: Query-based resources

### Prompt Templates

Group MCP servers by prompt template categories:
- **Data Query Prompts**: Database and search templates
- **Action Prompts**: Operation and task templates
- **Transformation Prompts**: Data processing templates

MCP groups are a powerful tool for organizing your Model Context Protocol inventory, enabling more efficient management, security testing, and analysis of your MCP server ecosystem.
