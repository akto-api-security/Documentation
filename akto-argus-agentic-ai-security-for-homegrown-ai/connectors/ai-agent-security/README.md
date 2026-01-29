# AI Agent Security

## Overview

Akto lets you seamlessly import **AI agents** such as **AWS Bedrock, Azure AI Foundry, Databricks, Google Vertex AI, IBM Watsonx**, or even your **custom agent** into **AI Agent Security**. With just the agent endpoint URL and optional configuration, you can start monitoring and testing agent activity instantly.

<figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2Fgit-blob-26c83f936b6d7958a5830edb6b158a31fbdd2e2a%2Fimage.png?alt=media" alt="" width="563"><figcaption></figcaption></figure>

## Supported AI Agents

* [**AWS Bedrock**](connect-akto-with-aws-bedrock.md) – Import Bedrock agents seamlessly
* [**Hugging Face**](connect-akto-with-huggingface.md) - Integrate Hugging Face Private Inference Endpoint
* **Azure AI Foundry** – Import Azure AI Foundry agents seamlessly
* **Databricks** – Import Databricks agents seamlessly
* **Google Vertex AI** – Import Vertex AI agents seamlessly
* **IBM Watsonx** – Import Watsonx agents seamlessly
* **Bring Your Own AI Agent** – Import any custom AI agent seamlessly

## What You Need

* **AI Endpoint URL** (e.g., `https://api.example.com/ai-agent`)
* **(Optional) Custom Request Body** – for agents requiring specific input JSON
* **(Optional) Test Role for Authentication** – for agents with role-based access

<figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2Fgit-blob-2d67298aa334f86b23e720ea82b13f8fa50abba8%2Fimage.png?alt=media" alt=""><figcaption></figcaption></figure>

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
* Register the agent into **AI Agent Security Inventory** for monitoring and testing&#x20;

{% hint style="success" %}
## Akto Access Scope

* Auth/test roles (if any) are used **only during import** and are **not stored**
* Akto uses **read-only access** to interact with your AI agent
{% endhint %}

***

#### Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
