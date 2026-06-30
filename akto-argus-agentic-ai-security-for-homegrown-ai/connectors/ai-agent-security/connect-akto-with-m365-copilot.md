---
description: Connect Akto with Microsoft 365 Copilot
---

# Microsoft 365 Copilot

## Overview

Microsoft 365 Copilot is an AI assistant embedded across the Microsoft 365 suite — Word, Excel, PowerPoint, Teams, Outlook, and more. Employees use it to draft content, summarize meetings, query organizational data, and automate tasks across their daily workflows.

The Akto M365 Copilot connector automatically:

* Discovers all Microsoft 365 Copilot interactions across your organization
* Monitors user prompts, responses, and the resources Copilot accessed
* Sends activity data to Akto for security analysis and guardrail enforcement

## How It Works

Microsoft 365 Copilot activity is automatically logged in **Microsoft Purview eDiscovery**. Akto polls M365 directly at regular intervals, forwards the data to Akto's Data Ingestion Service, and surfaces findings in your dashboard.

```mermaid
flowchart LR
    A[Microsoft 365\nCopilot] --> B[Purview (eDiscovery) Log]
    B --> C[Akto Polls\nM365 directly]
    C --> D[Akto Data\nIngestion Service]
    D --> E[Akto Dashboard]
```

{% hint style="info" %}
**Async mode** — Akto reads Copilot audit events after the fact. Events typically appear within 1 hour of the interaction occurring in Microsoft 365.
{% endhint %}

## What Data is Collected

| Category | What Akto Discovers |
|---|---|
| **Copilot interactions** | User prompts and responses across M365 apps |
| **Accessed resources** | Files, emails, and documents Copilot accessed |
| **Security signals** | Jailbreak attempts and prompt injection detections |
| **Agent activity** | Copilot Studio agents invoked |
| **Admin operations** | Plugin and policy changes |

## Steps to Connect

{% stepper %}
{% step %}
**Contact Akto Support**

Reach out to the Akto support team via in-app intercom or using the contact links below. The team will guide you through connecting your Microsoft 365 environment to Akto.
{% endstep %}

{% step %}
**Verify data in Akto**

Once connected, confirm that Microsoft 365 Copilot activity appears in your Akto Argus dashboard under **Agentic AI Discovery**.
{% endstep %}
{% endstepper %}

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Email us at [support@akto.io](mailto:support@akto.io) for direct help.
4. Contact us [here](https://www.akto.io/contact-us).
