---
description: Visualize and understand relationships between agent components in your agentic system.
---

# Agent Component Dependency Graph

## Introduction

The Agent Component Dependency Graph in Akto helps you visualize and understand the relationships between different agent components, MCP endpoints, and external services in your agentic application. The dependency graph shows how components are interconnected, making it easier to understand the flow of data and assess the impact of changes or security issues.

## Key Features

- **Visual Flow Mapping**: See clear, directional relationships between agent components
- **Component Type Indicators**: Different component types (AI Agent, MCP Server, External Tool) are visually distinguished
- **Framework Detection**: View which agent frameworks (LangChain, LlamaIndex, etc.) are used
- **Data Flow Tracking**: Understand how data moves between components and external services
- **Security Risk Assessment**: Identify high-risk dependencies and potential attack paths

## How to Use

1. Navigate to **Agentic Discovery > Collections**
2. Select an agent collection
3. Click on the **Dependency Graph** tab
4. Explore the visual representation of component relationships

## Understanding the Graph

### Node Types

- **AI Agent Nodes**: Represent your application's AI agents
- **MCP Server Nodes**: Show Model Context Protocol servers and their tools
- **External Service Nodes**: Indicate third-party APIs, databases, or services
- **Tool Nodes**: Display specific tools or resources accessible by agents

### Edge Relationships

- **Invocation Edges**: Show when one component calls another
- **Data Flow Edges**: Indicate data passing between components
- **Authentication Edges**: Highlight authentication dependencies

## Use Cases

- **Impact Analysis**: Understand which components are affected when making changes
- **Security Assessment**: Identify potential attack paths through your agentic system
- **Architecture Review**: Visualize the overall structure of your agent ecosystem
- **Dependency Management**: Track external service dependencies
- **Compliance**: Document data flows for regulatory requirements

## Best Practices

- Review the dependency graph regularly to understand system evolution
- Identify circular dependencies that might cause issues
- Monitor third-party component dependencies for security risks
- Use the graph to plan security testing priorities
- Document critical paths and dependencies for incident response
