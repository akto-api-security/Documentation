# Update Severity

## Overview

In **Akto**, severity levels help teams prioritise security issues based on risk and impact. Akto allows you to manually update the severity of both **Issues** and **Scan Results** directly from the dashboard.

## Update Severity for an Issue

You can update the severity of one or more identified issues from the Issues section of the dashboard.

### **Step**

{% stepper %}
{% step %}
Log in to the Akto dashboard.
{% endstep %}

{% step %}
Navigate to **Akto Argus** → **Reports** → **Issues**.
{% endstep %}

{% step %}
Select one or more issues whose severity you want to update.
{% endstep %}

{% step %}
Once selected, an **Actions** button appears at the bottom center of the screen.

<figure><img src="../../.gitbook/assets/image (89).png" alt="" width="563"><figcaption></figcaption></figure>
{% endstep %}

{% step %}
Click **Actions**, then choose **Update Severity** from the top of the menu.

<figure><img src="../../.gitbook/assets/image (86).png" alt="" width="563"><figcaption></figcaption></figure>
{% endstep %}

{% step %}
Select the desired severity level.

<figure><img src="../../.gitbook/assets/image (87).png" alt="" width="563"><figcaption></figcaption></figure>
{% endstep %}

{% step %}
Click **Update Severity** to save the changes.
{% endstep %}
{% endstepper %}

The selected issues are immediately updated with the new severity level.

## When to Update Severity

Common scenarios where severity updates are useful include:

* Accounting for application-specific business impact
* Downgrading known false positives
* Increasing severity for exposed critical APIs
* Aligning findings with internal risk frameworks
