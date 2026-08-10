---
description: Use Akto Atlas as the AI security server behind Anthropic's Inference Hooks to allow or deny Claude prompts inline, before inference runs.
---

# Claude Inference Hooks

## Overview

[Inference Hooks](https://platform.claude.com/docs/en/manage-claude/inference-hooks) is a Claude Enterprise feature that routes every governed prompt through an organization's own **AI security server**, an HTTPS endpoint that returns an allow or deny verdict, before inference runs. A denied prompt never reaches the model.

Akto Atlas can act as that AI security server. Point your organization's Inference Hooks configuration at Akto, and every governed prompt across claude.ai, Cowork, and Claude Code is evaluated against your **Atlas Guardrail policies** in real time, inline, before the model ever sees it, with no endpoint agent, browser extension, or IDE hook required.

This is the only Claude integration in Atlas that can **block a prompt before it runs**. The [Anthropic Connector](anthropic-connector.md) and [Claude Cowork Connector](claude-cowork-connector.md) give you visibility after or alongside the fact; Inference Hooks gives you enforcement in the critical path.

## How It Works

1. A user submits a prompt on a governed surface (claude.ai, Cowork, or Claude Code).
2. Anthropic sends an HTTPS `POST` containing the conversation transcript to Akto's verdict endpoint, signed per the [Standard Webhooks](https://www.standardwebhooks.com/) spec so Atlas can verify it came from Anthropic.
3. Atlas evaluates the transcript against your configured Guardrail policies and returns a verdict within your organization's verdict timeout (5 seconds by default).
4. On `allow`, inference proceeds normally. On `deny`, Anthropic blocks the request and shows the user a policy message built from Atlas's per-request reason plus your standing contact/exception text. The decision is logged to your Akto dashboard either way.

```mermaid
sequenceDiagram
    autonumber
    participant User
    participant Claude as Claude.ai / Cowork / Claude Code
    participant Anthropic
    participant Atlas as Akto Atlas<br/>(AI Security Server)
    participant Model as Claude Model

    User->>Claude: Submits prompt
    Claude->>Anthropic: Governed inference request
    Anthropic->>Atlas: POST signed transcript
    Note over Atlas: Evaluate against<br/>Atlas Guardrail policies
    alt Allow
        Atlas-->>Anthropic: {"action": "allow"}
        Anthropic->>Model: Run inference
        Model-->>User: Response
    else Deny
        Atlas-->>Anthropic: {"action": "deny", "deny_reason": "..."}
        Anthropic-->>User: Blocked-by-policy message
    end
    Atlas-->>Atlas: Log verdict to Akto Dashboard
```

Today the only hook event is `prompt`, firing once per governed request before inference begins. Response-side enforcement is on Anthropic's roadmap, not yet available.

## What Atlas Evaluates

Every transcript Anthropic forwards is scored against the same Guardrail policies Atlas already enforces at the endpoint. See [Agent Guard](../../agentic-guardrails/concepts/agent-guard.md) for the full scanner list. Typical uses of the hook:

* **Sensitive data exposure**: PII, secrets, source code, or other regulated data in the prompt
* **Unsafe prompts and jailbreaks**: prompt injection or jailbreak patterns
* **Policy engines**: model allowlists, project-scoped restrictions, or working-hours controls
* **Compliance archival**: always return `allow` and use the transcript purely to archive activity in real time, as a push-based alternative to polling the Anthropic Compliance API

## What Atlas Can and Cannot See

Anthropic forwards what the user sees: transcript text, tool calls and their results, and text extracted from attachments. It never forwards raw file or image bytes, system prompts, or Anthropic-internal context, so image-only content (a screenshot of a document, for example) cannot be inspected or blocked on this path.

## Prerequisites

* A **Claude Enterprise** organization, with Inference Hooks enabled (currently in beta)
* A user with the `organization:manage` permission in claude.ai (built-in Admin, Owner, and Primary owner roles hold this)
* An **Akto Atlas** account with the Connectors section accessible

## Setting It Up

Setting up Claude Inference Hooks requires provisioning a verdict endpoint on Akto's side and exchanging signing secrets with your Claude Enterprise organization. This is done together with the Akto team rather than as a self-serve step in the dashboard today.

{% hint style="info" %}
**Contact the Akto team** to set up Claude Inference Hooks for your organization. Reach out via in-app Intercom support or [support@akto.io](mailto:support@akto.io). They'll provision your verdict endpoint, walk you through registering it and the signing secret in claude.ai, and help you choose failure handling and rollout (shadow mode or a rollout percentage) so you can validate verdicts on live traffic before enforcing on everyone.
{% endhint %}

At a high level, the setup covers:

1. **Provisioning Akto's verdict endpoint** and signing secret for your organization.
2. **Registering it in claude.ai**, under Organization Settings → Inference Hooks, as an Admin, Owner, or Primary owner.
3. **Choosing failure handling**: block the request, or allow it through uninspected, if Atlas is unreachable or times out.
4. **Validating in shadow mode or a rollout percentage** before enforcing on all governed traffic.

## What You'll See in Akto

* **Atlas Guardrails → Guardrail Activity**: every verdict Atlas returned (allow or deny, the policy that fired, and the full transcript context), alongside guardrail events from your other endpoints
* **Agentic AI Discovery → Agentic Assets**: governed Claude usage attributed to the requesting user, correlated with any Anthropic Connector or Cowork Connector data for the same org

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `support@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
