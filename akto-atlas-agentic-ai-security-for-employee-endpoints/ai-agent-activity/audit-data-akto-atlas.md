# Audit Data - Akto Atlas

## Overview

The **Audit Data** page in **Akto Atlas** shows you every MCP server and skill your employees' agents use, and lets you **control how they're allowed to operate**.

From here, you can:

* See which MCP servers and skills are being accessed.
* Inspect the tools, resources, and prompts exposed by each MCP server.
* Approve, block, or conditionally allow any of them, individually or in bulk.

## Explore Audit Data

Use the tabs at the top of the page to switch between **MCP Servers** and **Skills**. Each tab shows a live count, and you can filter the time range with the **All time** dropdown at the top right.

### MCP Servers

Each row represents an MCP server and the agent that accesses it.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (84).png" alt="" width="563"><figcaption></figcaption></figure></div>

#### You will see:

<table><thead><tr><th width="147.92578125">Column</th><th>What it tells you</th></tr></thead><tbody><tr><td><strong>MCP Server</strong></td><td>The MCP server (domain or endpoint) being accessed</td></tr><tr><td><strong>AI Agent</strong></td><td>The agent accessing the server (e.g. VSCode, Claude, Cursor)</td></tr><tr><td><strong>Last Detected</strong></td><td>When the server was first observed in Atlas</td></tr><tr><td><strong>Updated</strong></td><td>Most recent activity for this server</td></tr><tr><td><strong>Access Type</strong></td><td>Type of access (e.g. public, private, third-party)</td></tr><tr><td><strong>Remarks</strong></td><td>Current decision: <strong>Approved</strong>, <strong>Rejected</strong>, or <strong>Conditionally Allowed</strong>. A clock icon next to the remark means an <strong>Audit Pending</strong> re-review is due.</td></tr><tr><td><strong>Marked By</strong></td><td>Who last updated the decision</td></tr></tbody></table>

{% hint style="info" %}
**Default Approval Behaviour**

* Without an [MCP registry integration](../../integrations/mcp-registry-integration.md) set up, every newly discovered MCP server defaults to **Approved**.
* Once you set up an [MCP registry integration](../../integrations/mcp-registry-integration.md), every newly discovered MCP server instead defaults to **Blocked**. From there, you either conditionally allow it for a specific agent (Cursor, Claude, and so on), or [add it to your MCP registry](#action-dropdown), which gets it approved by default.
{% endhint %}

You can also act on a server directly from this table: hover a row to open its quick actions (**Allow this server**, **Block this server**, **Add to MCP registry**), without opening the full server details.

### Skills

Each row represents a skill discovered on your employees' agentic tools.

<table><thead><tr><th width="147.92578125">Column</th><th>What it tells you</th></tr></thead><tbody><tr><td><strong>Skill</strong></td><td>The name of the skill</td></tr><tr><td><strong>Source</strong></td><td>The agent the skill was discovered on (e.g. codex, claude), or <strong>not-attached</strong> if it isn't tied to a specific agent</td></tr><tr><td><strong>Last Detected</strong></td><td>When the skill was first observed in Atlas</td></tr><tr><td><strong>Remarks</strong></td><td>Current decision: <strong>Allowed</strong>, <strong>Blocked</strong>, or <strong>Conditionally Allowed</strong></td></tr><tr><td><strong>Marked By</strong></td><td>Who last updated the decision</td></tr></tbody></table>

{% hint style="success" %}
**Bulk Blocking**

Select one or more skills using the checkboxes, then click **Block \<N> selected skills** from the action bar at the bottom of the table to block them all in one action.
{% endhint %}

## View MCP Server Details

Click on any MCP server to view its details, including all tools, resources, and prompts it exposes.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (85).png" alt="" width="563"><figcaption></figcaption></figure></div>

### Capabilities

Each MCP server exposes capabilities used by agents. For each capability, you can see:

<table><thead><tr><th width="224.94921875">Field</th><th>What it tells you</th></tr></thead><tbody><tr><td><strong>Type</strong></td><td>Whether it's a Tool, Resource, or Prompt</td></tr><tr><td><strong>Risk Analysis</strong></td><td>Any risk signals like <strong>Privileged Access</strong> or <strong>Malicious</strong></td></tr><tr><td><strong>Name</strong></td><td>The identifier of the capability</td></tr><tr><td><strong>Access Types</strong></td><td>Whether the capability is public, private, or third-party</td></tr><tr><td><strong>Remarks</strong></td><td>Whether it's <strong>Approved</strong>, <strong>Rejected</strong>, or <strong>Conditionally Allowed</strong></td></tr><tr><td><strong>Marked By</strong></td><td>Who made the decision</td></tr></tbody></table>

### Access Control Options

You can set access decisions at both the server level (via the Action dropdown) and the individual tool level. Use the following options:

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (95).png" alt="" width="563"><figcaption></figcaption></figure></div>

#### **Allow**

Grant full access to the MCP server or specific tool. The agent can use all capabilities without restrictions.

#### **Block**

Deny access entirely. The agent cannot interact with this server or tool.

#### Setting Conditional Approval

If you choose **Conditionally Allow**, you can set clear boundaries for how the component is allowed to operate. The following components can be set:

{% tabs %}
{% tab title="Time Duration Allowed" %}
You define how long the component can remain active. Once the duration expires, Akto automatically blocks it.

<figure><img src="../../.gitbook/assets/Screenshot 2025-12-17 at 7.27.30 PM.png" alt="" width="563"><figcaption></figcaption></figure>
{% endtab %}

{% tab title="IPs Allowed" %}
You control where the component can be used from. You can allow:

* All IPs
* Specific IPs
* An IP range (CIDR)

<figure><img src="../../.gitbook/assets/Screenshot 2025-12-17 at 7.27.52 PM.png" alt="" width="563"><figcaption></figcaption></figure>
{% endtab %}

{% tab title="Endpoints Allowed" %}
You choose which endpoints the component can access.

<figure><img src="../../.gitbook/assets/Screenshot 2025-12-17 at 7.28.02 PM.png" alt="" width="563"><figcaption></figcaption></figure>
{% endtab %}

{% tab title="Justification" %}
You add a mandatory justification so your team understands why you approved the component with conditions.

<figure><img src="../../.gitbook/assets/image (3) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt="" width="563"><figcaption></figcaption></figure>
{% endtab %}
{% endtabs %}

After configuring everything, click **Approve with Conditions** to enforce the restricted access.

### Action Dropdown

From the **Action** dropdown at the top of the server details view, you can make server-level decisions:

* [**Allow this server**](audit-data-akto-atlas.md#allow) – Grant full access to all capabilities
* [**Block this server**](audit-data-akto-atlas.md#block) – Deny all access immediately for the particular AI Agent
* **Block for all agents** – Block this server across all agents in your organisation
* [**Conditionally allow this server**](audit-data-akto-atlas.md#setting-conditional-approval) – Grant access with defined restrictions
*   **Add to MCP registry** – Register the server in your organisation's MCP registry

    <div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (100).png" alt="" width="563"><figcaption></figcaption></figure></div>

{% hint style="info" %}
To use **Add to MCP registry**, you must first set up an [MCP registry integration](../../integrations/mcp-registry-integration.md) from **Settings → Integrations → MCP Registry**.
{% endhint %}
