# Take Bulk Actions

## Overview

Actions on the **Agentic Components** page operate on **selected agentic components**.

{% hint style="warning" %}
You must select at least one endpoint before any action becomes available.
{% endhint %}

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (118).png" alt="" width="563"><figcaption></figcaption></figure></div>

## Navigating to Agentic Components

To access **Agentic Components** in Akto ATLAS, follow these steps:

{% stepper %}
{% step %}
Go to **Akto Atlas**.
{% endstep %}

{% step %}
Navigate to **Agentic Assets**.
{% endstep %}

{% step %}
Select an **agentic asset** from the list.
{% endstep %}

{% step %}
In the Agentic Asset Details view, select an **endpoint collection**.
{% endstep %}

{% step %}
The **Agentic Components** list for the selected collection is displayed.
{% endstep %}
{% endstepper %}

## Available Actions

### Export as CSV

Use this action to download agentic component data for external analysis or reporting.

#### Steps to export agentic components as CSV

{% stepper %}
{% step %}
Navigate to the **Agentic Components** list under an endpoint.
{% endstep %}

{% step %}
Select one or more agentic components using the checkboxes.
{% endstep %}

{% step %}
Click **Export as CSV** from the action bar.
{% endstep %}

{% step %}
Download the generated CSV file.
{% endstep %}
{% endstepper %}

The exported file includes component identifiers, access type, authentication status, and risk-related metadata.

### Add to Agentic Component Group

Use this action to group multiple agentic components together for management and analysis.

#### Steps to add components to a group

{% stepper %}
{% step %}
Navigate to the **Agentic Components** list.
{% endstep %}

{% step %}
Select one or more agentic components.
{% endstep %}

{% step %}
Click **Add to Agentic Component group**.
{% endstep %}

{% step %}
Choose an existing group or create a new group.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (119).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Confirm the action.
{% endstep %}
{% endstepper %}

The selected components are added to the chosen group.

### De-merge Agentic Components

Use this action to separate previously grouped agentic components.

#### Steps to de-merge agentic components

{% stepper %}
{% step %}
Navigate to the **Agentic Components** list.
{% endstep %}

{% step %}
Select one or more grouped agentic components.
{% endstep %}

{% step %}
Click **De-merge Agentic Components**.
{% endstep %}

{% step %}
Confirm the de-merge action.
{% endstep %}
{% endstepper %}

Each selected component becomes an independent agentic component again.

### Delete Agentic Components

Use this action to permanently remove agentic components from the asset.

#### Steps to delete agentic components

{% stepper %}
{% step %}
Navigate to the **Agentic Components** list.
{% endstep %}

{% step %}
Select one or more agentic components.
{% endstep %}

{% step %}
Click **Delete Agentic Components**.
{% endstep %}

{% step %}
Confirm deletion when prompted.
{% endstep %}
{% endstepper %}

Deleted components are removed permanently and cannot be recovered.

## What Next

After performing component-level actions, you can continue analysis by:

* Opening an [individual component to review **Values** and **Schema**](../../../agentic-ai-discovery/concepts/endpoints/agent-component.md#how-to-view-agent-components)
* Returning to [**Agentic Assets**](../agentic-assets/) to manage other agentic systems

