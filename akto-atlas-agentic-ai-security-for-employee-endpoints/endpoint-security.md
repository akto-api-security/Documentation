---
hidden: true
---

# Endpoint Security

Agentic Endpoint Shield provides comprehensive visibility into AI agent activity across employee devices and endpoints. Monitor all AI tools, MCP servers, and agent deployments in real-time to secure your organization's agentic infrastructure.

## What is Agentic Endpoint Shield?

Endpoint Shield continuously monitors employee devices to identify and track:

* **AI Agents**: All deployed agents across web, desktop, and endpoint devices
* **MCP Servers**: Model Context Protocol server instances running locally or remotely
* **Device Information**: Complete device inventory with hardware IDs, usernames, and locations
* **Agent Activity**: Real-time heartbeat monitoring and deployment status
* **MCP Connections**: Server URLs, connection health, and last seen timestamps

## Accessing Endpoint Shield

Navigate to **Agentic Discovery** > **Endpoint Shield** in the left sidebar to view your complete agent inventory across all employee devices.

## Agent Inventory View

The main Endpoint Shield dashboard displays all discovered agents with:

* **Agent ID**: Unique identifier for each agent instance
* **Device ID**: Hardware identifier showing which employee device hosts the agent
* **Username & Email**: Employee associated with the device and agent deployment
* **Last Heartbeat**: Real-time connectivity status showing agent health
* **Last Deployed**: Timestamp indicating when the agent was most recently deployed
* **MCP Servers**: Connected Model Context Protocol servers for each agent

## Agent Details

Click any agent to access detailed information:

### Overview Tab

* Agent description and configuration details
* Device and employee information
* Deployment history and status

### MCP Servers Tab

View all MCP servers connected to this agent:

* **Server Name**: MCP server identifier
* **Server URL**: Connection endpoint (local or remote)
* **Last Seen**: Most recent activity timestamp
* **Status**: Connection health indicator

### Agent Logs Tab

* Real-time log streaming from the agent
* Historical log access for security investigations
* Error and warning indicators

### Architecture Tab

Visual diagram showing:

* Agent connections to MCP servers
* MCP server connections to component servers
* Data flow and dependencies across your agentic infrastructure
