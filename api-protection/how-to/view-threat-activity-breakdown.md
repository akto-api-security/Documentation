# View Threat Activity Breakdown

## Overview

Use _Threat Activity Breakdown_ to investigate API threats detected by Akto. You can move from high-level monitoring to detailed drilldowns, apply filters, review complete request–response data, and take targeted remediation actions.

## **Access the Threat Activity View**

{% stepper %}
{% step %}
Log in to your Akto account.
{% endstep %}

{% step %}
Head to **API Security**.
{% endstep %}

{% step %}
From the side navigation bar and select **API Threat Detection**.
{% endstep %}

{% step %}
Click on **Threat Activity**.
{% endstep %}

{% step %}
Review activities under **Active**, **Under Review**, and **Ignored**.
{% endstep %}

{% step %}
Select an activity to open its drilldown view.
{% endstep %}
{% endstepper %}

{% hint style="success" %}
## Refine Threats Using Filters

Use the search and filter option in the upper-right corner of the activity list to refine the displayed results.

<p align="center"><img src="../../.gitbook/assets/image (116).png" alt=""></p>

You can filter by:

* **Actor**
* **URL**
* **Host**
* **Type** (Rule-Based / Anomaly)
* **Latest Attack Subcategory**
* **Successful Exploit**
{% endhint %}

## Explore the Detailed View

The drilldown view presents all relevant information for a selected threat activity, including severity, impacted API endpoint, and detected attack category.

The view contains four tabs that structure the investigation flow:

{% tabs %}
{% tab title="Overview" %}
Presents the **description**, **details**, and **impact** of the activity, giving you a clear understanding of the threat.

<figure><img src="../../.gitbook/assets/image (147).png" alt="" width="375"><figcaption></figcaption></figure>
{% endtab %}

{% tab title="Timeline" %}
Displays a visual timeline that helps you identify patterns, timing, and frequency of the attempts.

<figure><img src="../../.gitbook/assets/image (148).png" alt="" width="375"><figcaption></figcaption></figure>
{% endtab %}

{% tab title="Values" %}
Shows the **attempted request** and its **response**.

<figure><img src="../../.gitbook/assets/image (149).png" alt="" width="375"><figcaption></figcaption></figure>

{% hint style="success" %}
You can now copy the request in two formats:

* Curl&#x20;
*   Burp

    <figure><img src="../../.gitbook/assets/image (157).png" alt="" width="563"><figcaption></figcaption></figure>
{% endhint %}
{% endtab %}

{% tab title="Remediation" %}
Offers actionable steps you can follow to resolve the activity and reduce repeated exposure.

<figure><img src="../../.gitbook/assets/image (150).png" alt="" width="375"><figcaption></figcaption></figure>
{% endtab %}
{% endtabs %}

### **Update the Status**

Use **Event Actions** option to update the status of an activity:

* **Mark for Review** – Move the activity into the review workflow.
*   **Ignore** – Remove the activity from the active threat list.

    <figure><img src="../../.gitbook/assets/image (128).png" alt="" width="563"><figcaption></figcaption></figure>

{% hint style="warning" %}
Once ignored, Akto will **not flag the same actor and API endpoint again** based on the threat policy that originally detected it.
{% endhint %}

### Block the Traffic From the Source IP

Use **Block IP** button to immediately stop further activity from the malicious source.

For more details, continue to the [#id-1.-block-an-ip-from-threat-actors](take-actions-on-threats.md#id-1.-block-an-ip-from-threat-actors "mention") learn more.

### Create Internal Workflow Item

You can create a **Jira ticket** or a **Work Item** directly from the threat activity view to support internal tracking, ticketing, and coordinated remediation.

To learn more about creating and configuring these items, head to the [create-internal-workflow-item.md](create-internal-workflow-item.md "mention")**.**
