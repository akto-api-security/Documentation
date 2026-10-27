---
description: Use Akto Atlas as the AI security server behind Grok Bot Inference Hooks to allow or deny Grok Bot prompts inline, before inference runs.
---

# Grok Bot Inference Hooks

## Overview

[Inference Hooks](https://docs.x.ai/grok-bot/inference-hooks) lets an organization route every governed Grok Bot prompt (delivered through Cursor) to its own **AI security server**, which returns an allow or deny verdict before inference runs.

Akto Atlas can act as that server. Point your Inference Hooks configuration at Akto, and every governed prompt is evaluated against your **Atlas Guardrail policies** inline, with no endpoint agent, browser extension, or IDE hook required.

## How It Works

1. A user sends a prompt in Grok Bot.
2. Cursor sends the conversation to Akto's verdict endpoint as a signed [Standard Webhooks](https://www.standardwebhooks.com/) `POST`, with your `Authorization` header so Atlas can identify your account.
3. Atlas evaluates it against your Guardrail policies and returns `allow` or `deny` within the verdict timeout (5 seconds by default).
4. On `deny`, Cursor can block the request, depending on the mode you choose. The verdict is logged to your Akto dashboard either way.

Start in **Shadow** mode (the default), where a deny is only logged, then switch to a blocking mode once you are happy with the policies. Only inputs to the model are checked, not model responses.

## Setting It Up

Akto exposes a webhook endpoint for Grok Bot, scoped to your Akto account:

```
https://<your-account-id>-guardrails.akto.io/api/v1/webhooks/grokbot/guardrail
```

In the Cursor dashboard, open **Grok Bot → Security & Compliance → Inference Hooks**, set the endpoint URL to the address above, and add a custom **`Authorization`** header with your **database abstractor token** (from **Connectors → Setup Guardrail** in Akto Atlas).

{% hint style="info" %}
**Contact the Akto team** to set this up, via in-app Intercom support or [support@akto.io](mailto:support@akto.io).
{% endhint %}

## What You'll See in Akto

* **Atlas Guardrails → Guardrail Activity**: every verdict Atlas returned, with the policy that fired.
* **Agentic AI Discovery → Agentic Assets**: governed usage under a **Grok Bot** agent. Grok Bot sends no email, so activity is attributed to an opaque actor ID.

See also [Claude Inference Hooks](claude-inference-hooks.md).

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `support@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
