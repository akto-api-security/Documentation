# Audit Data

## Overview

The **Audit Data** page lists all detected MCP components and lets you control their access. You can approve, reject, or set conditional approval to control when, where, and how the component is allowed to run.

## Explore List

The table on the Audit Data page gives you full visibility into each component.

<details>

<summary>You will see the following details:</summary>

| Column                 | What it tells you                                                                                            |
| ---------------------- | ------------------------------------------------------------------------------------------------------------ |
| **Primitive Type**     | Whether the component is a Tool, Server, or Prompt.                                                          |
| **MCP Component Name** | The name of the detected component.                                                                          |
| **Collection Name**    | The collection or group where you discovered the component.                                                  |
| **Last Detected**      | When you last observed the component.                                                                        |
| **Updated**            | When the component details were last refreshed.                                                              |
| **Access Type**        | Whether the component is Private, Public, Partner, or Third-party.                                           |
| **Remarks**            | The current status of the component: **Approved**, **Pending**, **Rejected**, or **Conditionally Approved**. |
| **Marked By**          | The teammate who tagged or updated the entry.                                                                |
| **Actions**            | Controls that let you approve, disapprove, or apply conditional approval.                                    |

</details>

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1).png" alt="" width="563"><figcaption></figcaption></figure>

## Actions You Can Take

From the actions dropdown at the end of each row, you decide how Akto should treat the component:

* **Approve** – You trust the component and want it to run with reduced guardrails.
* **Disapprove** – You want to block the component entirely.
*   **Set Conditional Approval** – You want to allow the component, but only within limits you define.

    <figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1).png" alt="" width="563"><figcaption></figcaption></figure>

## Setting Conditional Approval

If you choose **Conditional Approval**, you can set clear boundaries for how the component is allowed to operate. The following components can be set:

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

<figure><img src="../../.gitbook/assets/image (3) (1).png" alt="" width="563"><figcaption></figcaption></figure>
{% endtab %}
{% endtabs %}

After configuring everything, click **Approve with Conditions** to enforce the restricted access.
