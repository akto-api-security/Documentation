---
description: Actions on Agentic Asset Details Page
---

# Take Actions on Collections

## Overview

Actions on the **Agentic Asset Details** page operate on **selected endpoints**.

{% hint style="warning" %}
You must select at least one endpoint before any action becomes available.
{% endhint %}

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (110).png" alt="" width="563"><figcaption></figcaption></figure></div>

## Available Actions

### 1. Export as CSV

Use this action to download endpoint-level data for external analysis.

#### Steps to export endpoints as CSV

{% stepper %}
{% step %}
Navigate to the Akto Atlas → **Agentic Asset** and **s**elect an **asset** from the list.
{% endstep %}

{% step %}
Select one or more endpoints using the checkbox column.
{% endstep %}

{% step %}
Click **More Actions** in the top-right corner, or use the action bar.
{% endstep %}

{% step %}
Select **Export as CSV**.
{% endstep %}

{% step %}
Download the generated CSV file.
{% endstep %}
{% endstepper %}

The exported file includes metadata such as endpoint ID, username, risk score, and discovery timestamps.

### 2. Deactivate Collection

Use this action to stop active monitoring for selected endpoints without removing historical data.

#### Steps to deactivate endpoints

{% stepper %}
{% step %}
Navigate to the Akto Atlas → **Agentic Asset** and **s**elect an **asset** from the list.
{% endstep %}

{% step %}
Select one or more endpoints.
{% endstep %}

{% step %}
Click **Deactivate collection** from the action bar.
{% endstep %}

{% step %}
Confirm the action.
{% endstep %}
{% endstepper %}

The selected endpoints remain visible but no longer process new agentic activity.

### 3. Delete Collection

Use this action to permanently remove endpoints from the agentic asset.

#### Steps to delete endpoints

{% stepper %}
{% step %}
Navigate to the Akto Atlas → **Agentic Asset** and **s**elect an **asset** from the list.
{% endstep %}

{% step %}
Select one or more endpoints.
{% endstep %}

{% step %}
Click **Delete collection** from the action bar.
{% endstep %}

{% step %}
Confirm deletion when prompted.
{% endstep %}
{% endstepper %}

Deleted endpoints are removed permanently and cannot be recovered.

### 4. Mark Collection as Out of Testing Scope

Use this action to exclude endpoints from active testing workflows.

#### Steps to mark endpoints out of scope

{% stepper %}
{% step %}
Navigate to the Akto Atlas → **Agentic Asset** and **s**elect an **asset** from the list.
{% endstep %}

{% step %}
Select one or more endpoints.
{% endstep %}

{% step %}
Click **Mark collection as out of testing scope**.
{% endstep %}

{% step %}
Confirm the scope change.
{% endstep %}
{% endstepper %}

Out-of-scope endpoints remain visible but are excluded from testing and evaluation.

### 5. Set Tags

Use this action to apply environment and custom tags to selected endpoints.

#### Steps to set tags on endpoints

{% stepper %}
{% step %}
Navigate to the Akto Atlas → **Agentic Asset** and **s**elect an **asset** from the list.
{% endstep %}

{% step %}
Select one or more endpoints.
{% endstep %}

{% step %}
Click **Set tags** in the action bar.
{% endstep %}

{% step %}
In the **Environment** section, select one of the following:

* **Staging**
* **Production**
{% endstep %}

{% step %}
In the **Custom tags** section:

* Review existing tags
*   Remove a tag using the delete icon, if needed

    <div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (115).png" alt="" width="335"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Click **Add custom tag** to add a new tag in `key=value` format.

<figure><img src="../../../.gitbook/assets/image (116).png" alt="" width="563"><figcaption></figcaption></figure>
{% endstep %}

{% step %}
Click **Reset** to clear selections made in the current session, if required.
{% endstep %}

{% step %}
Close the tag dialog to apply the changes.
{% endstep %}
{% endstepper %}

Tags are applied immediately to all selected endpoints.

{% hint style="info" %}
### Action Scopes

* Actions apply only to the endpoints selected at the time of execution.
* Multiple endpoints can be updated in a single action.
* Agentic asset–level metadata remains unchanged unless endpoints are deleted.
{% endhint %}

## What Next

After performing endpoint-level actions, you can continue analysis by:

* Review runtime behaviour and schemas in the [**Agentic Components**](../../../agentic-ai-discovery/concepts/endpoints/agent-component.md)
