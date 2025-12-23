# Access A Specific Guardrail Actor

## Overview

Akto provides a focused view of security activity associated with a single actor. You can analyze the actor’s behavior, understand attack patterns, and assess risk based on severity and affected components.

## Access a Particular Actor

Follow these steps to view the breakdown for a specific guardrail actor:

{% stepper %}
{% step %}
Log in to your Akto account and switch to the **Agentic Security** product.
{% endstep %}

{% step %}
From the left navigation bar, go to **Agentic Guardrails → Guardrail Actors**.
{% endstep %}

{% step %}
Scroll down to the actors table.

<figure><img src="../../.gitbook/assets/image (57).png" alt="" width="563"><figcaption></figcaption></figure>
{% endstep %}

{% step %}
Click the actor for which you want a detailed breakdown.
{% endstep %}
{% endstepper %}

## Understand the Drilldown

The actor drilldown page is designed to help you quickly assess intent, impact, and risk.

### Actor Summary

The top section displays key metadata:

| Field                | Description                                                 |
| -------------------- | ----------------------------------------------------------- |
| Actor ID             | Unique identifier assigned to the actor                     |
| Status               | Current state of the actor (for example, active or blocked) |
| Discovered Timestamp | Time when the actor was first identified                    |

### Attack Classification by Severity

Below the summary, the page presents a list of detected attacks attributed to the actor. Attacks are distinguished by severity, allowing you to prioritize response.

| Time            | Attack Type                  | Severity                    | Host        | Agentic Component                                      |
| --------------- | ---------------------------- | --------------------------- | ----------- | ------------------------------------------------------ |
| Event timestamp | Classification of the attack | Risk level assigned by Akto | Target host | Guardrail or agentic module that detected the activity |

<figure><img src="../../.gitbook/assets/image (58).png" alt="" width="563"><figcaption></figcaption></figure>

With the breakdown helps you correlate attack behavior over time, understand which agentic components are involved, and decide on appropriate response actions.

### Take Action

You can also block the IP address associated with a particular guardrail actor. For step-by-step instructions, refer to the [take-action-on-guardrails-events.md](take-action-on-guardrails-events.md "mention").
