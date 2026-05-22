---
description: Route MCP server traffic from Copilot Studio agents through the Akto agent-proxy
---

# Proxy MCP Server via Akto

## Overview

Microsoft Copilot Studio agents can call external [Model Context Protocol (MCP)](https://modelcontextprotocol.io) servers as **tools**. By pointing the agent at Akto's `agent-proxy` instead of the MCP server directly, every tool call — both the request the agent makes and the response the MCP server returns — flows through Akto for inspection, policy enforcement, and audit.

The proxy is fully transparent: the MCP server sees a normal request and returns a normal response. The agent sees the same MCP server contract. Akto sits in the middle.

## How It Works

```
Copilot Studio agent
        │ (MCP tool call)
        ▼
https://<proxy-host>/agent-proxy/<target-mcp-host>/<path>
        │ (inspected, policies applied)
        ▼
Target MCP server  (e.g. docs.akto.io/~gitbook/mcp)
```

The proxy URL is built by **dropping `https://`** from the target MCP server URL and **appending it to the Akto agent-proxy base**:

| Target MCP server | Final proxy URL |
| --- | --- |
| `https://docs.akto.io/~gitbook/mcp` | `https://<proxy-host>/agent-proxy/docs.akto.io/~gitbook/mcp` |
| `https://mcp.example.com/api/v1/mcp` | `https://<proxy-host>/agent-proxy/mcp.example.com/api/v1/mcp` |

{% hint style="info" %}
The proxy preserves the full path, query string, and request body of the original MCP server call. No changes are needed on the MCP server side.
{% endhint %}

## Prerequisites

* A **Microsoft Copilot Studio** agent you can edit (Author or Maker role on the agent).
* The **full HTTPS URL** of the MCP server you want to expose to the agent.
* The **Akto proxy host** (`<proxy-host>`) — provisioned and shared by Akto.
* Permission to publish the agent after the tool is added.

## Steps to Connect

{% stepper %}
{% step %}
**Open the Copilot Studio agent**

Go to [copilotstudio.microsoft.com](https://copilotstudio.microsoft.com) and open the agent you want to attach the MCP server to.
{% endstep %}

{% step %}
**Open the Tools tab**

In the agent's top navigation, select the **Tools** tab. This is where every external action available to the agent — connectors, custom skills, and MCP servers — is registered.
{% endstep %}

{% step %}
**Add a new tool**

Select **+ Add a tool** (top-right of the Tools tab). A side panel opens with the list of tool types Copilot Studio supports.
{% endstep %}

{% step %}
**Select MCP Server**

From the **New tool** panel, choose **Model Context Protocol** (sometimes labelled **MCP Server**). The form switches to the MCP-specific fields.
{% endstep %}

{% step %}
**Enter the name and description**

* **Name** — a short, human-readable label (e.g. `Akto Docs MCP`). The agent uses this name when deciding which tool to call.
* **Description** — one or two sentences explaining what the MCP server does. The model relies on this description to pick the tool, so be specific (e.g. _"Search and retrieve Akto documentation pages"_).
{% endstep %}

{% step %}
**Enter the proxy URL**

In the **URL** field, paste the Akto agent-proxy URL — **not** the raw MCP server URL.

Build it by taking your target MCP server URL and dropping `https://`, then appending the remainder to `https://<proxy-host>/agent-proxy/`:

```
https://<proxy-host>/agent-proxy/<mcp_server_url_without_https>
```

**Example**

| | |
| --- | --- |
| Target MCP Server | `https://docs.akto.io/~gitbook/mcp` |
| Final Proxy URL | `https://<proxy-host>/agent-proxy/docs.akto.io/~gitbook/mcp` |

{% hint style="warning" %}
Do **not** include `https://` after `/agent-proxy/`. The proxy expects only the host and path of the upstream MCP server.
{% endhint %}
{% endstep %}

{% step %}
**Add the tool**

Select **Add** at the bottom of the panel. Copilot Studio registers the proxy URL as the MCP endpoint for this tool.
{% endstep %}

{% step %}
**Connect**

Select **Connect**. Copilot Studio performs an MCP handshake against the proxy URL — the proxy forwards the handshake to the upstream MCP server and returns the advertised tools list to the agent.

{% hint style="info" %}
If the upstream MCP server requires authentication (API key, OAuth, etc.), Copilot Studio will prompt for it here. Credentials are sent through the proxy verbatim — Akto does not store them.
{% endhint %}
{% endstep %}

{% step %}
**Add and Configure**

Select **Add and Configure**. The tool is attached to the agent and the configuration pane opens — review the auto-discovered MCP tool list and toggle individual tools on or off as needed.

Once finished, **Publish** the agent so the tool becomes available in conversations.
{% endstep %}
{% endstepper %}

## Verify the Integration

1. Open your agent in the **Test agent** pane on the right side of Copilot Studio.
2. Ask the agent a question that requires the MCP server (e.g. _"Look up the Akto MCP connector docs"_).
3. The agent should invoke the new tool. In the **Activity** panel, expand the tool call — the request URL should be the `agent-proxy` URL, not the original MCP server.
4. Open the Akto dashboard → **Argus → Traffic** and confirm the MCP request and response appear with the corresponding policy verdict.

## Troubleshooting

### Tool fails to connect

* Verify the proxy URL is correctly formatted: `https://<proxy-host>/agent-proxy/<host>/<path>` — no `https://` after `/agent-proxy/`, and no trailing slash.
* Confirm the upstream MCP server is reachable from the Akto agent-proxy environment. If the MCP server is internal-only, contact Akto to allow-list it.

### MCP tools do not appear after Connect

* The handshake against the upstream server may have failed silently. Try the original MCP URL directly in an MCP client to confirm it responds, then re-create the tool in Copilot Studio.
* Check the Akto dashboard for proxy errors — the response from the upstream server is logged with the same trace ID.

### Tool calls are not visible in Akto

* Confirm the agent has been **published** after the tool was added — unpublished tools may not route through the configured URL in some tenants.
* Verify the agent is actually using the tool. Inspect the **Activity** panel during a test conversation — the agent may be answering from its model knowledge without calling the tool at all.

## Get Support

If you need help proxying an MCP server through Akto:

* **In-app Chat** — use the chat widget in your Akto dashboard for instant support.
* **Discord Community** — join us at [discord.gg/Wpc6xVME4s](https://discord.gg/Wpc6xVME4s).
* **Email Support** — contact [help@akto.io](mailto:help@akto.io).
* **Contact Form** — submit a request at [https://www.akto.io/contact-us](https://www.akto.io/contact-us).
