---
description: Connect Akto with Amazon Quick
---

# Amazon Quick

## Overview

Amazon Quick Suite is an AWS-native agentic AI platform that lets employees query data, trigger workflows, and take actions across enterprise tools through natural language chat. Organizations use Amazon Quick to build and deploy AI-powered chat agents that connect to business systems like Jira, ServiceNow, Slack, and more.

The Akto Amazon Quick connector automatically:

* Discovers all Amazon Quick chat agents and action connectors in your environment
* Monitors chat conversations and agent interactions
* Sends activity data to Akto for security analysis and guardrail enforcement

## How It Works

Amazon Quick Suite records all agent and chat activity as logs. Akto reads these logs asynchronously, forwards them to Akto's Data Ingestion Service, and surfaces findings in your dashboard.

```mermaid
flowchart LR
    A[Amazon Quick] --> B[Activity Logs]
    B --> C[Akto Data\nIngestion Service]
    C --> D[Akto Dashboard]
```

{% hint style="info" %}
**Async mode** — Akto reads from Amazon Quick logs after the fact. There is an inherent delay between an event occurring in Amazon Quick and it appearing in Akto.
{% endhint %}

## What Data is Collected

| Category | What Akto Discovers |
|---|---|
| **Chat activity** | User queries, agent responses, conversation sessions |
| **Action connector events** | External service actions triggered from Quick (Jira, Slack, ServiceNow, etc.) |
| **Admin operations** | Connector creation/deletion, permission and policy changes |
| **User & access management** | User additions, role changes, group membership updates |

## Steps to Connect

Reach out to the Akto support team via in-app intercom or using the contact links below. The team will provide the **CloudFormation Template (CFT)** and guide you through the full setup of the Amazon Quick connector in your AWS environment.

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Email us at [support@akto.io](mailto:support@akto.io) for direct help.
4. Contact us [here](https://www.akto.io/contact-us).

