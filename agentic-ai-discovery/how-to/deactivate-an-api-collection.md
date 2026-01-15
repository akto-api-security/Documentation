---
hidden: true
description: Learn how to deactivate and reactivate agent and MCP collections in Akto.
---

# Deactivating and Reactivating Agentic Collections

Managing your agent and MCP collections effectively helps ensure optimal performance and control within Akto. Below is a step-by-step guide on how to deactivate and reactivate collections.

## Deactivating a Collection

Deactivating a collection halts data ingestion, monitoring, and security testing for that specific collection.

### Steps to Deactivate

1. Navigate to **Collections** in the sidebar under **Agentic Discovery**
2. Select the checkbox next to the collection you wish to deactivate
3. Click on **Deactivate collection** at the bottom panel
4. Confirm the action in the pop-up dialog

{% hint style="info" %}
Once a collection is deactivated, **all associated agent components and MCP endpoints will be removed after 1 hour**.
{% endhint %}

### When to Deactivate

Consider deactivating a collection when:
- The agent or MCP server is being decommissioned
- You want to temporarily stop monitoring specific components
- The collection contains test or development agents no longer in use
- You need to reduce noise from inactive systems

## Reactivating a Collection

To resume ingestion, monitoring, and security testing, you can reactivate a previously deactivated collection.

### Steps to Reactivate

1. Go to the **Deactivated** tab in the **Collections** view under **Agentic Discovery**
2. Select the collection(s) you want to reactivate
3. Click **Reactivate collection** from the bottom panel
4. Confirm the action in the pop-up dialog

### After Reactivation

Once reactivated:
- Agent component discovery will resume
- Traffic analysis will restart
- Security testing will be enabled again
- Historical data (if retained) will become accessible
