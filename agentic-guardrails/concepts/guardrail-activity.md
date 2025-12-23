# Guardrail Activity

## Overview

The **Guardrail Activity** page provides a unified view of all agentic guardrail detections across your environment. It enables you to monitor guardrail behavior, assess risk levels, and manage detected events efficiently from a single interface.

<figure><img src="../../.gitbook/assets/image (100).png" alt="" width="563"><figcaption></figcaption></figure>

## Key Metrics

Key metrics summarise guardrail behavior at a glance and help you quickly assess overall security posture and system performance.

### 1. Top Guardrails

Displays the guardrails that are triggered most frequently. This highlights guardrails that are actively engaged and categories where detections are concentrated.

### 2. Guardrail by Severity

Shows detections grouped by severity level, giving clear visibility into the distribution of low, medium, and high-risk events.

### 3. Guardrail (Request vs Response Over Time)

Tracks the number of guardrail messages detected in **requests** versus **responses** over time. This helps distinguish whether detections originate from inbound inputs or outbound agent responses.

### 4. Flagged vs Safe Messages

Shows the trend of messages classified as **flagged** versus **safe** over time, reflecting overall guardrail decision outcomes and stability.

### 5. Guardrail Detection Latency

Displays the **95th percentile detection latency** for guardrail evaluation. It represents the upper bound of guardrail processing time experienced by most requests.

## Guardrail Activity List

The activity list provides a detailed, event-level view of all guardrail detections. Events are grouped into the following categories:

* **Active**
* **Under Review**
* **Ignored**

<details>

<summary>Each activity record contains the following columns:</summary>

| Column             | Description                                                |
| ------------------ | ---------------------------------------------------------- |
| Severity           | Risk level assigned to the detection                       |
| Agentic Component  | Component where the detection occurred                     |
| Host               | Host handling the interaction                              |
| Actor              | Entity initiating the interaction                          |
| Attack Type        | Detected violation or attack category                      |
| Successful Exploit | Indicates whether exploitation was successful (true/false) |
| Collection         | Associated data collection                                 |
| Detected           | Timestamp when the activity was detected                   |

</details>

{% hint style="info" %}
#### Search and Filters

You can refine the activity list using the search bar and the following filters:

* Actor
* URL
* Host
* Type
* Latest attack sub-category
* Successful exploit
{% endhint %}

## Take Bulk Action

Bulk actions can be performed on multiple guardrail activities at once.

**Steps:**

{% stepper %}
{% step %}
Select activities using the checkbox at the start of each row.
{% endstep %}

{% step %}
Bulk action options appear at the bottom center of the screen.

<figure><img src="../../.gitbook/assets/image (102).png" alt="" width="563"><figcaption></figcaption></figure>
{% endstep %}

{% step %}
Choose one of the following actions:

* Mark selected events for review
* Ignore selected events
* Delete selected events
{% endstep %}
{% endstepper %}

## What Next

Navigate to the [guardrail-activity-detailed-view.md](../how-to/guardrail-activity-detailed-view.md "mention") page to analyze individual detections in greater detail and understand their full context.
