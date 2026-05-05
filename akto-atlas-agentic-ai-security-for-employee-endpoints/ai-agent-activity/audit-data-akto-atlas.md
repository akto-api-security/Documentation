# Audit Data (Akto Atlas)

## Overview

The **Audit Data** page in Akto Atlas provides visibility into all detected MCP servers accessed by agents and lets you control their access. You can approve, reject, or set conditional approval to control when, where, and how each MCP server is allowed to interact with agents.

## Server List

The table on the Audit Data page gives you full visibility into each MCP server detected in your environment.

<details>

<summary>You will see the following details:</summary>

| Column            | What it tells you                                                                                   |
| ----------------- | --------------------------------------------------------------------------------------------------- |
| **Server**        | The domain or endpoint of the MCP server.                                                           |
| **Agent**         | The agent that accessed the MCP server (e.g., VSCode, Claude, Cursor).                              |
| **Detected At**   | When the MCP server was first discovered.                                                           |
| **Last Seen**     | The most recent activity from this server.                                                          |
| **Access Type**   | Whether the server is public, private, partner, or third-party.                                     |
| **Status**        | The current approval status: **Approved**, **Rejected**, or **Conditionally Allowed**.              |
| **Marked By**     | The teammate who last updated the decision.                                                         |

</details>

## Server Details

Click on any MCP server to view its details, including all tools, resources, and prompts it exposes.

### Capabilities

Each MCP server exposes capabilities used by agents. For each capability, you can see:

| Field                    | What it tells you                                                                |
| ------------------------ | -------------------------------------------------------------------------------- |
| **Name**                 | The identifier of the capability                                                 |
| **Type**                 | Whether it's a Tool, Resource, or Prompt                                         |
| **Risk Classification**  | Any risk signals like **Privileged Access** or **Malicious**                    |
| **Current Status**       | Whether it's **Approved**, **Rejected**, or **Conditionally Allowed**            |
| **Reviewed By**          | Who made the decision                                                             |

### Access Control Options

You can set access decisions at both the server level (via the Action dropdown) and the individual tool level. Use the following options:

#### Allow

Grant full access to the MCP server or specific tool. The agent can use all capabilities without restrictions.

#### Block

Deny access entirely. The agent cannot interact with this server or tool.

#### Conditionally Allow

Allow access with clear boundaries. You can set restrictions on:

{% tabs %}
{% tab title="Time Duration Allowed" %}
You define how long the server can remain active. Once the duration expires, Akto automatically blocks it.

<figure><img src="../../.gitbook/assets/Screenshot 2025-12-17 at 7.27.30 PM.png" alt="" width="563"><figcaption></figcaption></figure>
{% endtab %}

{% tab title="IPs Allowed" %}
You control where the server can be used from. You can allow:

* All IPs
* Specific IPs
* An IP range (CIDR)

<figure><img src="../../.gitbook/assets/Screenshot 2025-12-17 at 7.27.52 PM.png" alt="" width="563"><figcaption></figcaption></figure>
{% endtab %}

{% tab title="Endpoints Allowed" %}
You choose which endpoints the server can access.

<figure><img src="../../.gitbook/assets/Screenshot 2025-12-17 at 7.28.02 PM.png" alt="" width="563"><figcaption></figcaption></figure>
{% endtab %}

{% tab title="Justification" %}
You add a mandatory justification so your team understands why you approved the server with conditions.

<figure><img src="../../.gitbook/assets/image (3) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt="" width="563"><figcaption></figcaption></figure>
{% endtab %}
{% endtabs %}

After configuring everything, click **Approve with Conditions** to enforce the restricted access.

### Action Dropdown

From the **Action** dropdown at the top of the server details view, you can make server-level decisions:

* **Allow this server** – Grant full access to all capabilities
* **Block this server** – Deny all access immediately
* **Block for all agents** – Block this server across all agents in your organization
* **Conditionally allow this server** – Grant access with defined restrictions
* **Add to MCP registry** – Register the server in your organization's MCP registry

{% hint style="info" %}
To use **Add to MCP registry**, you must first set up an MCP registry integration. Go to **Settings → Integrations → MCP Registry** to configure one.
{% endhint %}
