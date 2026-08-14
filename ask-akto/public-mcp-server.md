# Access the Public Akto MCP Server

## Overview

Akto hosts a public **MCP (Model Context Protocol) server** that lets any MCP-compatible client (Claude, Cursor, etc.) connect directly to your Akto data, without deploying or self-hosting an MCP server yourself.

{% hint style="warning" %}
**Akto's MCP server is HTTP-only; `stdio` is not supported.** Configure it as an `http`-type server entry pointing at `https://mcp.akto.io/mcp`, as shown below.

It also supports only the request/response half of MCP's Streamable HTTP transport, not the streaming (`GET`/SSE) half. If your client requires that streaming handshake to connect, it won't work with this server yet; don't assume a connection failure is an auth issue.
{% endhint %}

## Prerequisites

* An Akto account with access to **Settings**
* An MCP-compatible client (Claude, Cursor, etc.)

## Configuration

{% stepper %}
{% step %}
**Generate Your Akto API Key**

1. In your Akto dashboard, go to **Settings → Integrations → Automation → Akto API Token**
2. Click **Generate** to create a new token
3. Copy the token; you'll use it as the `x-mcp-api-key` value in the next step
{% endstep %}

{% step %}
**Configure the MCP Server**

Add the following configuration in your MCP client:

```json
"akto-mcp-server": {
  "type": "http",
  "url": "https://mcp.akto.io/mcp",
  "headers": {
    "x-mcp-api-key": "<YOUR_AKTO_API_KEY>",
    "x-context-source": "Agentic"
  }
}
```

Replace `<YOUR_AKTO_API_KEY>` with the token generated in the previous step.
{% endstep %}
{% endstepper %}

## The `x-context-source` Header

The `x-context-source` header tells the MCP server which Akto product's data to serve:

| Value      | Product                                                 |
| ---------- | -------------------------------------------------------- |
| `API`      | Akto API Security                                       |
| `Agentic`  | Akto Argus (Agentic AI Security)                        |
| `Endpoint` | Akto Atlas (Agentic AI Security for Employee Endpoints) |
| `DAST`     | Akto DAST                                               |

{% hint style="info" %}
* If `x-context-source` is **not provided**, the server defaults to **API** context.
* If `x-context-source` is set to anything other than the four values above, the request is rejected with an error.
{% endhint %}

Most MCP clients apply a fixed `headers` block for the life of a server connection, so you can't switch `x-context-source` per question. If your work spans multiple contexts (e.g. both Agentic and Endpoint), add multiple named server entries pointing at the same URL and API key, each with a different `x-context-source`, and enable whichever matches what you're currently working on:

<details>

<summary>Example: configuring multiple context entries</summary>

The wrapper key below (`mcpServers`) may be named `servers` instead, depending on your client. Use whichever key your client's own MCP config expects.

```json
{
  "mcpServers": {
    "akto-mcp-server-argus": {
      "type": "http",
      "url": "https://mcp.akto.io/mcp",
      "headers": {
        "x-mcp-api-key": "<YOUR_AKTO_API_KEY>",
        "x-context-source": "Agentic"
      }
    },
    "akto-mcp-server-atlas": {
      "type": "http",
      "url": "https://mcp.akto.io/mcp",
      "headers": {
        "x-mcp-api-key": "<YOUR_AKTO_API_KEY>",
        "x-context-source": "Endpoint"
      }
    }
  }
}
```

</details>

## Troubleshooting

* **Check the server is reachable**: `GET https://mcp.akto.io/health` returns a liveness response and doesn't require any headers.
* **Connection fails immediately / handshake never completes**: your client may depend on the streaming (`GET`/SSE) half of Streamable HTTP, which this server doesn't implement yet. See the note above.
* **401 error**: `x-mcp-api-key` is missing or invalid. Double-check the token generated in Step 1.
* **400 error**: `x-context-source` is set to a value other than `API`, `Agentic`, `Endpoint`, or `DAST`. Fix the value, or omit the header to default to `API`.

## Support

If you need help with the setup:

* **Discord Community**: Join our community at [discord.gg/Wpc6xVME4s](https://discord.gg/Wpc6xVME4s)
* **Email Support**: Contact us at [support@akto.io](mailto:support@akto.io)

Our team is available 24/7 to assist you with setup, troubleshooting, and best practices.
