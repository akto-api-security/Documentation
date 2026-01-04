# View Endpoint Shield Details

## Overview

The Endpoint Shield page shows you every protected endpoint and gives you a clear view of agent activity, deployment status, and shielded MCP servers.

## Accessing Endpoint Shield

Navigate to **Agentic Discovery ->** **Endpoint Shield** in the left sidebar to view your complete agent inventory across all employee devices.

## Agent List

The Agent List displays all endpoints where the shield is active. Each row contains:

| Column             | Description                                                          |
| ------------------ | -------------------------------------------------------------------- |
| **Agent ID**       | Unique identifier of the shielded agent running on the endpoint.     |
| **Device ID**      | Device identifier of the machine where the agent is deployed.        |
| **Username**       | User associated with the device on which the agent is installed.     |
| **Last Heartbeat** | Timestamp of the most recent health check sent by the agent.         |
| **Last Deployed**  | Timestamp showing when the latest shield configuration was deployed. |

<figure><img src="../../.gitbook/assets/image (4).png" alt="" width="563"><figcaption></figcaption></figure>

You can select any Agent ID to view deeper information.

## Agent Details Drilldown

When you click an **Agent ID**, you see two tabs that help you understand what is running on that endpoint.

### MCP Servers

This tab shows you the MCP servers associated with the selected agent. You can review server details and the specific endpoints or commands that are shielded on that device.

<figure><img src="../../.gitbook/assets/image (5).png" alt="" width="563"><figcaption></figcaption></figure>

### Agent Logs

This tab provides a chronological log of the agent’s activity. You can track what the agent executed, when it checked in, and how enforcement behaved on that endpoint.

<figure><img src="../../.gitbook/assets/image (6).png" alt="" width="563"><figcaption></figcaption></figure>

## Learn More

To understand how Endpoint Shield works at a conceptual level—including architecture, workflow, and protection mechanics, refer to the [**MCP** **Endpoint Shield**](https://docs.akto.io/mcp-endpoint-shield)**.**

