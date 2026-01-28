---
description: More Actions on Agentic Components Page
---

# Take View Level Actions

## Overview

The **More Actions** menu in the top-right corner provides actions that operate on the **current agentic components view**.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (120).png" alt="" width="563"><figcaption></figcaption></figure></div>

{% hint style="warning" %}
These actions do **not** require selecting individual components unless explicitly stated.
{% endhint %}

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

## How to Switch Views

### Display Graph View

Use this action to visualise relationships between agentic components in a graph format.

The graph view helps you understand how agentic components are connected and invoked relative to each other.

#### Steps to display the graph view

{% stepper %}
{% step %}
[Navigate to the **Agentic Components** page.](take-view-level-actions.md#navigating-to-agentic-components)
{% endstep %}

{% step %}
Click **More Actions** in the top-right corner.
{% endstep %}

{% step %}
Select **Display graph view**.
{% endstep %}
{% endstepper %}

Akto switches the current view from a table layout to a graph-based visualization

## Re-Compute

### Refresh

Use this action to reload the agentic components list with the most recent state.

#### Steps to refresh the view

{% stepper %}
{% step %}
[Navigate to the **Agentic Components** page.](take-view-level-actions.md#navigating-to-agentic-components)
{% endstep %}

{% step %}
Click **More Actions**.
{% endstep %}

{% step %}
Select **Refresh**.
{% endstep %}
{% endstepper %}

The page reloads without modifying component data.

### Upload Files

### Upload OpenAPI File

Use this action to upload an OpenAPI specification to align discovered components with a known contract.

#### Steps to upload an OpenAPI file

{% stepper %}
{% step %}
[Navigate to the **Agentic Components** page.](take-view-level-actions.md#navigating-to-agentic-components)
{% endstep %}

{% step %}
Click **More Actions**.
{% endstep %}

{% step %}
Select **Upload OpenAPI file**.
{% endstep %}

{% step %}
Upload a valid OpenAPI specification file.
{% endstep %}
{% endstepper %}

The uploaded specification is used to enrich component definitions and structure.

## Export The Collection

### Export as OpenAPI Spec

Use this action to export the current agentic components view as an OpenAPI specification.

#### Steps to export as OpenAPI

{% stepper %}
{% step %}
Click **More Actions**.
{% endstep %}

{% step %}
Select **OpenAPI spec**.
{% endstep %}
{% endstepper %}

Akto generates and downloads an OpenAPI file based on discovered components.

### Export as Postman format

Use this action to export agentic components in Postman format.

#### Steps to export as Postman collection

{% stepper %}
{% step %}
Click **More Actions**.
{% endstep %}

{% step %}
Select **Postman**.
{% endstep %}
{% endstepper %}

The exported collection can be imported into Postman for testing and exploration.

### Export as CSV

Use this action to export the agentic components list as a CSV file.

#### Steps to export as CSV

{% stepper %}
{% step %}
[Navigate to the **Agentic Components** page.](take-view-level-actions.md#navigating-to-agentic-components)
{% endstep %}

{% step %}
Click **More Actions**.
{% endstep %}

{% step %}
Select **CSV**.
{% endstep %}
{% endstepper %}

The CSV file contains component-level metadata from the current view.

## Other Actions

### Show Workflow Tests

Use this action to view or create workflow tests associated with agentic components.

#### Steps to access workflow tests

{% stepper %}
{% step %}
[Navigate to the **Agentic Components** page.](take-view-level-actions.md#navigating-to-agentic-components)
{% endstep %}

{% step %}
Click **More Actions** in the top-right corner.
{% endstep %}

{% step %}
Select **Show workflow tests**.
{% endstep %}

{% step %}
You are redirected to the **Workflow Tests** page.

From the Workflow Tests page, you can:

* Select an existing workflow test
*   Create a new workflow test for the selected component

    <div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (122).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}
{% endstepper %}

Workflow tests help validate multi-step agentic behaviour across components.

### Redact

Use this action to remove existing sample payload values and redact all future payload data for the current collection.

#### Steps to enable redaction

{% stepper %}
{% step %}
Click **More Actions**.
{% endstep %}

{% step %}
Select **Redact**.
{% endstep %}

{% step %}
Review the confirmation note displayed in the dialog.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (121).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Click **Enable** to confirm.
{% endstep %}
{% endstepper %}

{% hint style="info" %}
## Redaction behavior

When redaction is enabled:

* Existing sample payload values for the collection are deleted
* All future payload values for the collection are redacted
* API Inventory data remains unchanged
* Sensitive data detection remains intact

Only sample payload values are affected by this action
{% endhint %}
