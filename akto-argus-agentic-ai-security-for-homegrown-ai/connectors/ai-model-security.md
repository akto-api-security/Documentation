# AI Model Security

## Overview

Akto lets you seamlessly import AI models like **Gemini, OpenAI, Claude, DeepSeek, Llama, Grok, Hugging Face**, or even your **custom model** into **AI Model Security**. With just your model's endpoint URL and optional authentication, you can start monitoring and scanning instantly.

<figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2Fgit-blob-1213d79a9e68ade9dce330c6df0f2170f0503f67%2Fimage.png?alt=media" alt="" width="563"><figcaption></figcaption></figure>

## Supported Models

<table><thead><tr><th width="215.03515625">AI Model/Connector</th><th>Description</th></tr></thead><tbody><tr><td>Gemini</td><td>Import Google Gemini models seamlessly into AKTO.</td></tr><tr><td>OpenAI</td><td>Import OpenAI models seamlessly into AKTO.</td></tr><tr><td>Claude</td><td>Import Anthropic Claude models seamlessly into AKTO.</td></tr><tr><td>DeepSeek</td><td>Import DeepSeek models seamlessly into AKTO.</td></tr><tr><td>Llama</td><td>Import Meta Llama models seamlessly into AKTO.</td></tr><tr><td>Grok</td><td>Import xAI Grok models seamlessly into AKTO.</td></tr><tr><td>Bring Your Own Model</td><td>Import your custom AI models seamlessly into AKTO.</td></tr><tr><td>Hugging Face</td><td>Import your Hugging Face models seamlessly into AKTO.</td></tr></tbody></table>

## Bring Your Own Model: What You Need

The steps below are for importing a custom, in-house, or self-hosted model that doesn't have a dedicated connector above. If your provider is listed above, follow its **Connect** flow instead, it will have setup steps specific to that provider rather than this generic flow.

{% stepper %}
{% step %}
**AI Endpoint URL** (e.g., `https://api.example.com/ai-agent`)
{% endstep %}

{% step %}
**(Optional) AI Agent Name** – if left blank, the hostname from the URL is used
{% endstep %}

{% step %}
**(Optional) Custom Request Body** – for models requiring specific input JSON
{% endstep %}

{% step %}
**(Optional) Test Role for Authentication** – for models with role-based access
{% endstep %}

{% step %}
**(Optional) Custom Headers** – for models requiring additional headers such as API keys or auth tokens
{% endstep %}

{% step %}
**(Optional) Custom Response** – skip the live call and provide the response yourself, useful when the endpoint isn't reachable from the dashboard
{% endstep %}
{% endstepper %}

## Bring Your Own Model: Steps to Import

{% stepper %}
{% step %}
**Open Akto Argus Dashboard** → Go to Connectors
{% endstep %}

{% step %}
**Select Bring Your Own Model** and click **Connect**
{% endstep %}

{% step %}
**Fill in model details** in the Set up guide panel:

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

You can also click **Go to docs** on the same panel for detailed setup instructions.
{% endstep %}
{% endstepper %}

Akto will now automatically:

* Connect to the AI model endpoint
* Validate request/response format
* Add the model into **AI Model Security Inventory** for monitoring and scanning

{% hint style="success" %}
**Akto Access Scope**

* Auth tokens/headers (if used) are **only applied during import** and are **not stored**
* Akto uses **read-only access** to interact with your AI endpoint
{% endhint %}

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
