# AI Model Security

## Overview

Akto lets you seamlessly import AI models like **Gemini, OpenAI, Claude, DeepSeek, Llama, Grok**, or even your **custom model** into **AI Model Security**. With just your model’s endpoint URL and optional authentication, you can start monitoring and testing instantly.

<figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2Fgit-blob-1213d79a9e68ade9dce330c6df0f2170f0503f67%2Fimage.png?alt=media" alt="" width="563"><figcaption></figcaption></figure>

## Supported Models

* **Gemini** – Import Google Gemini seamlessly
* **OpenAI** – Import OpenAI models seamlessly
* **Claude** – Import Anthropic Claude seamlessly
* **DeepSeek** – Import DeepSeek seamlessly
* **Llama** – Import Meta Llama seamlessly
* **Grok** – Import xAI Grok seamlessly
* **Bring Your Own Model** – Import custom AI models seamlessly

## What You Need

* **AI Endpoint URL** (e.g., `https://api.example.com/ai-agent`)
* **(Optional) Authentication details** if your AI model requires them
* **(Optional) Custom request body** for models that need non-standard inputs

## Steps to Import

{% stepper %}
{% step %}
**Open Akto Argus Dashboard** → Go to Connectors
{% endstep %}

{% step %}
**Select your AI model provider** (Gemini, OpenAI, Claude, DeepSeek, Llama, Grok, or _Bring Your Own Model_) under AI Model Security section.
{% endstep %}

{% step %}
Click **Connect.**

<figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2Fgit-blob-ff2886b0e1105dfd405317fd71f755b76b597d3e%2Fimage.png?alt=media" alt="" width="563"><figcaption></figcaption></figure>
{% endstep %}

{% step %}
**Fill in model details**:

* **AI Endpoint URL**: e.g., `https://api.example.com/ai-agent`
* _(Optional)_ Enable **custom request body** if the model requires non-default payloads
*   _(Optional)_ Use **test role for authentication** if your AI model enforces role-based access

    <figure><img src="../../.gitbook/assets/image (2) (1) (1) (1).png" alt="" width="375"><figcaption></figcaption></figure>
{% endstep %}

{% step %}
**Click Import.**
{% endstep %}
{% endstepper %}

Akto will now automatically:

* Connect to the AI model endpoint
* Validate request/response format
* Add the model into **AI Model Security Inventory** for monitoring and testing

{% hint style="success" %}
## Akto Access Scope

* Auth tokens/headers (if used) are **only applied during import** and are **not stored**
* Akto uses **read-only access** to interact with your AI endpoint
{% endhint %}

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
