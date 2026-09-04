# AI Agent Security

## Overview

Akto lets you seamlessly import **AI agents** such as **AWS Bedrock, Azure AI Foundry, Databricks, Google Vertex AI, IBM Watsonx**, or even your **custom agent** into **AI Agent Security**. With just the agent endpoint URL and optional configuration, you can start monitoring and scanning agent activity instantly.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (232).png" alt="" width="563"><figcaption></figcaption></figure></div>

## Supported AI Agents

The following AI agents, platforms, and tools are supported by Akto Argus for agentic AI security, enabling visibility, governance, and protection across diverse AI ecosystems.

<table><thead><tr><th width="215.03515625">AI Agent/Connector</th><th>Description</th></tr></thead><tbody><tr><td><a href="connect-akto-with-aws-bedrock.md">AWS Bedrock</a></td><td>Import your AWS Bedrock AI agents seamlessly into Akto.</td></tr><tr><td><a href="aws-bedrock-agentcore.md">AWS AgentCore</a></td><td>Import your AWS Bedrock AgentCore AI agents seamlessly into Akto.</td></tr><tr><td><a href="azure-ai-foundry.md">Azure AI Foundry</a></td><td>Import Azure AI Foundry agents seamlessly into AKTO.</td></tr><tr><td><a href="databricks.md">Databricks</a></td><td>Import Databricks agents seamlessly into AKTO.</td></tr><tr><td><a href="vertex-ai.md">Google Vertex AI</a></td><td>Import Google Vertex AI agents seamlessly into AKTO.</td></tr><tr><td>IBM Watsonx</td><td>Import IBM Watsonx AI agents seamlessly into AKTO.</td></tr><tr><td>Bring Your Own AI Agent</td><td>Import your custom AI agents seamlessly into AKTO.</td></tr><tr><td><a href="n8n.md">N8N</a></td><td>Use our N8N feature to capture traffic and instantly send it to your dashboard for real-time insights.</td></tr><tr><td><a href="langchain.md">Langchain</a></td><td>Use our Langchain feature to capture traffic from LangSmith and instantly send it to your dashboard for real-time insights.</td></tr><tr><td><a href="snowflake/">Snowflake</a></td><td>Connect to your Snowflake account to discover agents using Cortex and automatically fetch data for all Snowflake agents.</td></tr><tr><td>Vertex AI Custom Deployed Model</td><td>Import your Vertex AI Custom Deployed Model traffic seamlessly into AKTO.</td></tr><tr><td><a href="salesforce.md">Salesforce</a></td><td>Import Salesforce agents seamlessly into AKTO.</td></tr></tbody></table>

{% hint style="success" %}
**Bring Your Own AI Agent**

Akto Argus also supports **Bring Your Own Agent**, enabling organizations to secure **any custom, in-house, or self-hosted AI agent**, even if it is not built on a predefined platform.

**With Bring Your Own Agent, you can:**

* Secure proprietary and homegrown AI agents
* Integrate agents built using custom frameworks or internal tooling
* Monitor agent behavior, inputs, outputs, and tool usage
* Enforce security policies via Akto Argus APIs or SDKs
{% endhint %}

## Bring Your Own AI Agent: What You Need

The steps below are for importing a custom, in-house, or self-hosted agent that doesn't have a dedicated connector in the table above. If your platform is listed above, follow its linked guide instead; it will have setup steps specific to that platform rather than this generic flow.

{% stepper %}
{% step %}
**AI Endpoint URL** (e.g., `https://api.example.com/ai-agent`)
{% endstep %}

{% step %}
**(Optional) AI Agent Name** – if left blank, the hostname from the URL is used
{% endstep %}

{% step %}
**(Optional) Custom Request Body** – for agents requiring specific input JSON
{% endstep %}

{% step %}
**(Optional) Test Role for Authentication** – for agents with role-based access
{% endstep %}

{% step %}
**(Optional) Custom Headers** – for agents requiring additional headers such as API keys or auth tokens
{% endstep %}

{% step %}
**(Optional) Custom Response** – skip the live call and provide the response yourself, useful when the endpoint isn't reachable from the dashboard
{% endstep %}
{% endstepper %}

## Bring Your Own Agent: Steps to Import

{% stepper %}
{% step %}
**Open Akto Argus Dashboard** → Go to Connectors
{% endstep %}

{% step %}
**Select Bring Your Own AI Agent** (or Custom Agent) and click **Connect**

<figure><img src="../../../.gitbook/assets/image (236).png" alt="" width="563"><figcaption></figcaption></figure>
{% endstep %}

{% step %}
**Fill in agent details** in the Set up guide panel:

* **AI Endpoint URL**: e.g., `https://api.example.com/ai-agent`
* _(Optional)_ **AI Agent name**: if not provided, the hostname from the URL will be used
*   _(Optional)_ Check **Use custom request body** and enter JSON payload:

    ```json
    { "key": "value" }
    ```
* _(Optional)_ Enable **Use test role for authentication** and select a role (e.g., `ATTACKER_TOKEN_ALL`)
* _(Optional)_ Click **+ Add header** under **Custom Headers** to pass additional headers with each request
* _(Optional)_ Enable **Use custom response (skip live call)** and provide the response yourself instead of Akto calling the URL, useful when the endpoint isn't reachable from the dashboard
{% endstep %}

{% step %}
Click **Import**
{% endstep %}
{% endstepper %}

Akto will now automatically:

* Connect to the AI agent endpoint
* Send sample test requests to validate the configuration
* Register the agent into **AI Agent Security Inventory** for monitoring and scanning

{% hint style="success" %}
**Akto Access Scope**

* Auth/test roles (if any) are used **only during import** and are **not stored**
{% endhint %}

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact [support@akto.io](mailto:support@akto.io) for email support.
4. Contact us [here](https://www.akto.io/contact-us).
