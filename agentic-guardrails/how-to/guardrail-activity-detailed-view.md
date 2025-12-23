# Guardrail Activity Detailed View

## Overview

Guardrail Activity gives you a consolidated view of all security events detected by Akto’s Agentic Guardrails. You can review, investigate, and take action on guardrail violations raised by rule-based detection and anomaly detection mechanisms.

## Navigate to Guardrail Activity

Follow these steps to access Guardrail Activity:

1. Log in to your Akto account.
2. Switch to the **Agentic Security** product.
3. From the left navigation bar, click **Agentic Guardrails**.
4. Select **Guardrail Activity**.
5. Scroll down to view the activity list, categorized as:
   * **Active**
   * **Under Review**
   * **Ignored**
6. Click any activity to open its detailed drilldown view.

{% hint style="success" %}
## Filters

Use filters to quickly narrow down relevant guardrail activities. The search box is located at the top-right corner of the activity list and supports filtering by:

* Actor
* URL
* Host
* Type
* Latest Attack Subcategory
{% endhint %}

## Detailed View

The detailed view provides complete context required for investigation and remediation. The page displays severity along with all relevant metadata and is organised into three tabs:

{% tabs %}
{% tab title="Overview" %}
Presents the **description**, **details**, and **impact** of the activity, giving you a clear understanding of the activity.

<figure><img src="../../.gitbook/assets/image (62).png" alt="" width="563"><figcaption></figcaption></figure>
{% endtab %}

{% tab title="Timeline" %}
Shows the chronological sequence of events related to the activity.

<figure><img src="../../.gitbook/assets/image (63).png" alt="" width="563"><figcaption></figcaption></figure>
{% endtab %}

{% tab title="Values" %}
Shows the **attempted request** and its **response** that helps validate exploit attempts and understand system behaviour.

<figure><img src="../../.gitbook/assets/image (79).png" alt="" width="375"><figcaption></figcaption></figure>

You can copy the request in two formats:

* **Curl**
* **Burp**
{% endtab %}
{% endtabs %}

### **Update the Status**

Use **Event Actions** option to update the status of an activity:

* **Mark for Review** – Move the activity into the review workflow.
*   **Ignore** – Remove the activity from the active threat list.

    <figure><img src="../../.gitbook/assets/image (84).png" alt="" width="563"><figcaption></figcaption></figure>

{% hint style="warning" %}
Once ignored, Akto will **not flag the same actor and endpoint again** based on the agentic guardrails that originally detected it.
{% endhint %}

### Block the Traffic From the Source IP

Use **Block IP** button to immediately stop further activity from the malicious source.

For more details, continue to the [#block-an-ip-from-guardrail-activity-page](take-action-on-guardrails-events.md#block-an-ip-from-guardrail-activity-page "mention").

### Create Internal Workflow Item

You can create a **Jira ticket** or a **Work Item** directly from the threat activity view to support internal tracking, ticketing, and coordinated remediation.

To learn more about creating and configuring these items, head to the [create-internal-workflow-item.md](create-internal-workflow-item.md "mention")**.**
