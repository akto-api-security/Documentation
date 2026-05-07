# Users and Devices

## Overview

The **Users and Devices** page gives you a complete inventory of all users and devices discovered by Akto Atlas in your organization. It shows who is using AI agents, which MCP servers they connect to, and what agentic assets are associated with each user.

From here, you can:

* See all discovered users and devices across your environment
* Assign teams and roles to users for better context and filtering
* Click into any user to inspect the endpoints their agents are accessing

Navigate to: **Akto Atlas → Agentic AI Discovery → Users and Devices**

## Explore the List

The page opens on the **Users** tab by default. Switch to the **Devices** tab to see the device-level inventory.

### Users Tab

Each row in the Users table represents a discovered user.

<table><thead><tr><th width="200">Column</th><th>What it tells you</th></tr></thead><tbody><tr><td><strong>User</strong></td><td>The username discovered from agent traffic</td></tr><tr><td><strong>Type</strong></td><td>The type of AI component the user interacts with (e.g. MCP Server, LLM)</td></tr><tr><td><strong>Agentic assets</strong></td><td>The number of agentic assets associated with this user</td></tr><tr><td><strong>Risk score</strong></td><td>A risk indicator based on the user's agent activity and exposure</td></tr><tr><td><strong>Sensitive data</strong></td><td>Whether sensitive data types have been detected in this user's traffic</td></tr><tr><td><strong>Last traffic seen</strong></td><td>When Akto last observed activity for this user</td></tr><tr><td><strong>Team</strong></td><td>The team you have assigned to this user</td></tr><tr><td><strong>User role</strong></td><td>The role you have assigned to this user</td></tr></tbody></table>

### Devices Tab

The Devices tab shows the same inventory organized by device instead of user. Each discovered device is listed with its associated agents and agentic assets.

## View User Details

Click on any user to open a detailed view listing all endpoints and agentic assets associated with that user.

The detail view shows:

<table><thead><tr><th width="200">Column</th><th>What it tells you</th></tr></thead><tbody><tr><td><strong>Endpoint ID</strong></td><td>The unique identifier for the discovered endpoint</td></tr><tr><td><strong>Type</strong></td><td>The component type (e.g. MCP Server)</td></tr><tr><td><strong>Username</strong></td><td>The username associated with this endpoint</td></tr><tr><td><strong>Risk score</strong></td><td>Risk level for this specific endpoint</td></tr><tr><td><strong>Sensitive data</strong></td><td>Sensitive data types detected on this endpoint</td></tr><tr><td><strong>Last traffic seen</strong></td><td>When this endpoint was last active</td></tr><tr><td><strong>Discovered</strong></td><td>When Akto first detected this endpoint</td></tr></tbody></table>

Expand any endpoint row to see the individual agentic assets (e.g. MCP servers) nested under it.

## Assign Teams and Roles

You can tag users with a team and role to add organizational context. This makes it easier to filter and investigate activity by team or function.

{% stepper %}
{% step %}
Select one or more users using the checkboxes in the Users table.
{% endstep %}

{% step %}
Click **Edit team & role** from the action bar that appears at the bottom of the screen.
{% endstep %}

{% step %}
In the modal, enter a **Team** (e.g. Backend, DevOps) and a **User role** (e.g. Engineer, Architect).
{% endstep %}

{% step %}
Click **Save**.
{% endstep %}
{% endstepper %}

{% hint style="info" %}
You can select multiple users at once and assign the same team and role to all of them in a single action.
{% endhint %}

## Filter by Team or User Role

Once teams and roles are assigned, use the filters at the top of the Users table to narrow down the list by **Team** or **User role**. This helps you focus on a specific group when investigating activity or reviewing risk.
