# AI Agent Security

## Overview

Akto lets you seamlessly import **AI agents** such as **AWS Bedrock, Azure AI Foundry, Databricks, Google Vertex AI, IBM Watsonx**, or even your **custom agent** into **AI Agent Security**. With just the agent endpoint URL and optional configuration, you can start monitoring and testing agent activity instantly.

<figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2Fgit-blob-26c83f936b6d7958a5830edb6b158a31fbdd2e2a%2Fimage.png?alt=media" alt="" width="563"><figcaption></figcaption></figure>

## AI Agents Available

The following AI agents, platforms, and tools are supported by Akto Argus for agentic AI security, enabling visibility, governance, and protection across diverse AI ecosystems.

<table><thead><tr><th width="215.03515625">AI Agent/Connector</th><th>Description</th></tr></thead><tbody><tr><td><a href="connect-akto-with-aws-bedrock.md">AWS Bedrock</a></td><td>Secure and monitor AI agents built using AWS Bedrock managed foundation models.</td></tr><tr><td><a href="n8n.md">N8N</a></td><td>Secure autonomous workflows and AI-powered automations built using n8n.</td></tr><tr><td><a href="langchain.md">LangChain</a></td><td>Monitor and govern LangChain-based AI agents and orchestration pipelines.</td></tr><tr><td><a href="microsoft-copilot-studio.md">Copilot Studio</a></td><td>Secure AI agents created using Microsoft Copilot Studio.</td></tr><tr><td><a href="litellm.md">LiteLLM</a></td><td>Monitor and secure AI agents using LiteLLM for multi-model routing and management.</td></tr><tr><td><a href="claude-code-cli.md">Claude Code CLI</a></td><td>Secure developer workflows and AI agents using Claude Code CLI.</td></tr><tr><td><a href="connect-akto-with-huggingface.md">Hugging Face</a></td><td>Protect AI agents and models hosted or deployed via Hugging Face.</td></tr><tr><td>Azure AI Foundry</td><td>Protect AI agents developed and deployed via Azure AI Foundry.</td></tr><tr><td>Datadog</td><td>Integrate AI agent telemetry and observability signals from Datadog.</td></tr><tr><td>Anthropic</td><td>Secure AI agents powered by Anthropic models and APIs.</td></tr><tr><td>Portkey</td><td>Secure AI gateways and agent routing implemented using Portkey.</td></tr><tr><td>Databricks</td><td>Monitor and secure AI agents running on Databricks platforms.</td></tr><tr><td>Snowflake</td><td>Secure AI agents and data-driven workflows built within Snowflake.</td></tr><tr><td>Vertex AI</td><td>Protect AI agents deployed using Google Vertex AI.</td></tr><tr><td>IBM Watsonx</td><td>Import and monitor Watsonx AI agents seamlessly within Akto Argus.</td></tr><tr><td>Microsoft Defender</td><td>Integrate security insights for AI agents from Microsoft Defender.</td></tr><tr><td>Zscaler</td><td>Secure AI agent traffic and access via Zscaler security controls.</td></tr><tr><td>CrowdStrike</td><td>Monitor AI agent behavior and threats using CrowdStrike telemetry.</td></tr><tr><td>ServiceNow</td><td>Secure AI agents integrated into ServiceNow workflows and automations.</td></tr><tr><td>Salesforce</td><td>Protect AI agents built on or integrated with Salesforce platforms.</td></tr><tr><td>TrueFoundry</td><td>Secure AI agents deployed using the TrueFoundry ML platform.</td></tr><tr><td>DigitalOcean</td><td>Monitor AI agents hosted on DigitalOcean infrastructure.</td></tr><tr><td>ChatGPT Enterprise</td><td>Secure enterprise-grade AI agents built using ChatGPT Enterprise.</td></tr><tr><td>Glean(Coming Soon)</td><td>Protect enterprise search and knowledge AI agents powered by Glean.</td></tr></tbody></table>

{% hint style="success" %}
## Bring Your Own AI Agent

Akto Argus also supports **Bring Your Own Agent**, enabling organizations to secure **any custom, in-house, or self-hosted AI agent**, even if it is not built on a predefined platform.

**With Bring Your Own Agent, you can:**

* Secure proprietary and homegrown AI agents
* Integrate agents built using custom frameworks or internal tooling
* Monitor agent behavior, inputs, outputs, and tool usage
* Enforce security policies via Akto Argus APIs or SDKs
{% endhint %}



## What You Need

* **AI Endpoint URL** (e.g., `https://api.example.com/ai-agent`)
* **(Optional) Custom Request Body** – for agents requiring specific input JSON
* **(Optional) Test Role for Authentication** – for agents with role-based access

<figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2Fgit-blob-2d67298aa334f86b23e720ea82b13f8fa50abba8%2Fimage.png?alt=media" alt="" width="563"><figcaption></figcaption></figure>

## Steps to Import

{% stepper %}
{% step %}
**Open Akto Argus Dashboard** → Go to Connectors
{% endstep %}

{% step %}
**Select your AI Agent provider** (Azure AI Foundry, Databricks, Vertex AI, Watsonx, or _Bring Your Own Agent_)
{% endstep %}

{% step %}
Click **Connect.**
{% endstep %}

{% step %}
**Fill in agent details**:

* **AI Endpoint URL**: e.g., `https://api.example.com/ai-agent`
*   _(Optional)_ Check **Use custom request body** and enter JSON payload:

    ```json
    { "key": "value" }
    ```
* _(Optional)_ Enable **Use test role for authentication** and select a role (e.g., `ATTACKER_TOKEN_ALL`)
{% endstep %}

{% step %}
Click **Import.**
{% endstep %}
{% endstepper %}

Akto will now automatically:

* Connect to the AI agent endpoint
* Send sample test requests to validate the configuration
* Register the agent into **AI Agent Security Inventory** for monitoring and testing

{% hint style="success" %}
### Akto Access Scope

* Auth/test roles (if any) are used **only during import** and are **not stored**
* Akto uses **read-only access** to interact with your AI agent
{% endhint %}

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
