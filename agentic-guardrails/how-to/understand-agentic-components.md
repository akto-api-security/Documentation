# Understand Agentic Components

## Overview

The **Agentic Components under Guardrails** page gives you an aggregated view of guardrail activity across your environment. The primary goal of this page is to help you understand **which guardrail types and categories are being flagged most**, and **where those events originate**.

<figure><img src="../../.gitbook/assets/image (113).png" alt="" width="563"><figcaption></figcaption></figure>

## Key Metrics

### Top Guardrail Types

Displays the most frequently triggered guardrail types across all components.

Use this metric to understand which risk patterns are most common and validate whether existing guardrails address real attack behaviour.

### Top Guardrail Categories

Aggregates guardrail triggers into broader categories.

This metric helps you assess where risk is concentrated and prioritise remediation efforts based on security impact.

## Component List

Lists all discovered agentic components along with their guardrail exposure.

<details>

<summary><strong>Available details</strong></summary>

| Column                    | Description                                      |
| ------------------------- | ------------------------------------------------ |
| **Agentic Component URL** | URL where agentic interactions are monitored.    |
| **Host**                  | Domain or service hosting the component.         |
| **Malicious Actors**      | Number of distinct malicious actors detected.    |
| **Malicious Requests**    | Total requests flagged as malicious.             |
| **Discovered (Date)**     | Date the component was first identified by Akto. |

</details>



Selecting a component redirects you to the **Guardrail Activity** page with the URL filter applied, showing only events related to that component.

To analyse individual events in detail, refer to [guardrail-activity-detailed-view.md](guardrail-activity-detailed-view.md "mention").
