---
description: Enforce chosen Akto policies with LiteLLM's built-in Akto guardrail
---

# LiteLLM (Native Guardrail)

## Overview

LiteLLM ships an Akto guardrail that calls Akto directly from the LiteLLM proxy. It is set up in the LiteLLM Admin UI, with no hook file to deploy.

Each guardrail can tell Akto **which policies to enforce** and **whether the traffic belongs to Argus or Atlas**, through its `akto_vxlan_id` field. This lets the LiteLLM administrator choose the policies for each set of keys, teams or clients without any change on the client side.

{% hint style="info" %}
For the Akto custom hook (`custom_hooks.py`), with per-agent collections and session tracking, see [LiteLLM](litellm.md).
{% endhint %}

## Prerequisites

* A LiteLLM proxy with the Admin UI enabled and a database configured (`DATABASE_URL`); guardrails created in the UI are stored in the database
* An Akto guardrails endpoint (URL and API token). The token is available in **Akto Argus → Connectors → Setup Guardrail**
* The Akto guardrail policies to enforce, created in the Akto dashboard

## Steps to Connect

The recommended way is to create the guardrails in the LiteLLM Admin UI. Create **two** guardrails: one that checks each request before the model call, and one that sends the request and response to Akto after the call.

{% stepper %}
{% step %}
**Open Guardrails**

Log in to the LiteLLM Admin UI (`http://<your-litellm-host>/ui`), open **Guardrails** and click **Create Guardrail**.
{% endstep %}

{% step %}
**Basic Info**

| Field | Value |
| --- | --- |
| **Guardrail Provider** | `Akto` |
| **Guardrail Name** | `akto-validate` |
| **Mode** | `Pre Call` |
| **Always On** | Enabled, to apply the guardrail to all requests. Leave it off to attach the guardrail only to specific keys or teams (see [Different Policies for Different Users or Teams](#different-policies-for-different-users-or-teams)). |

Click **Next**.
{% endstep %}

{% step %}
**Provider Configuration**

| Field | Value |
| --- | --- |
| `akto_base_url` | Your Akto guardrails URL. Can be left empty if `AKTO_GUARDRAIL_API_BASE` is set in the LiteLLM environment. |
| `akto_api_key` | Your Akto API token. Can be left empty if `AKTO_API_KEY` is set in the LiteLLM environment. |
| `akto_vxlan_id` | The policy directive, for example `policy:ENDPOINT:block employee pii`. See [Choosing Policies and Context Source](#choosing-policies-and-context-source). |
| `unreachable_fallback` | `fail_open` to allow requests when Akto cannot be reached, or `fail_closed` to block them. |
| `guardrail_timeout` | `30` |
| `akto_account_id` | Leave empty. |

Click **Create Guardrail**.

{% hint style="warning" %}
**Set `guardrail_timeout`**

The default timeout is 5 seconds, which is too short for coding agents that send large prompts (for example, OpenCode's system prompt alone is about 18KB). A timeout is returned to the client as HTTP 408 **even with `unreachable_fallback` set to `fail_open`**, because LiteLLM only fails open on connection errors. Set `guardrail_timeout` to `30`.
{% endhint %}
{% endstep %}

{% step %}
**Create the Ingest Guardrail**

Click **Create Guardrail** again and repeat the steps with:

* **Guardrail Name**: `akto-ingest`
* **Mode**: `Post Call`
* The **same** `akto_vxlan_id` value as `akto-validate`

The new guardrails apply to requests immediately; no restart is needed.
{% endstep %}
{% endstepper %}

## Choosing Policies and Context Source

Set the `akto_vxlan_id` field of the guardrail to a policy directive:

```
policy:<contextSource>:<policy name>[,<policy name>...]
```

| Part | Values | Meaning |
| --- | --- | --- |
| `policy:` | fixed prefix | Marks the value as a directive. Values without it are treated as a normal VXLAN ID. |
| `<contextSource>` | `ENDPOINT`, `AGENTIC`, or empty | `ENDPOINT` sends the traffic to **Atlas**; `AGENTIC` keeps it in **Argus**. Empty or any other value keeps the default (Argus). |
| `<policy name>` | one or more names, comma-separated | The Akto guardrail policies to enforce. Optional. |

Examples:

| `akto_vxlan_id` | Result |
| --- | --- |
| `policy:ENDPOINT:block employee pii` | Atlas traffic; only the *block employee pii* policy is enforced |
| `policy:AGENTIC:Secrets,Prompt Injection` | Argus traffic; only these two policies are enforced |
| `policy:ENDPOINT:` | Atlas traffic; all Atlas policies in scope are enforced |
| `policy::Secrets` | Argus traffic (default); only *Secrets* is enforced |

Rules for policy names:

* Matched **case-insensitively**, with leading and trailing spaces ignored. Spaces inside a name must match exactly.
* Separate multiple names with commas. A name may contain `:` (only the first two `:` split the directive), but not `,`.
* Akto resets the field to `0` after reading it, so the directive never becomes a collection ID.

{% hint style="info" %}
**Set the same directive on both guardrails**

The `akto-validate` and `akto-ingest` guardrails send their own `akto_vxlan_id`. Use the same value on both, otherwise ingested traffic will not be placed in the same context source as the verdicts.
{% endhint %}

## How Named Policies Are Enforced

* **A named policy is always enforced while it is active.** It applies regardless of the policy's own context source and scope (server/agent, device/user, account type, approved servers), and regardless of `GUARDRAILS_SKIP_PATHS`.
* **Only the named policies are enforced.** Other policies do not run for that traffic.
* **Inactive policies are never enforced.** Deactivating a policy in the Akto dashboard turns it off for LiteLLM traffic too, within about a minute.
* **An unknown or inactive name does not switch protection off.** If no active policy matches any of the names, Akto enforces all policies in scope for the request and logs a warning (`no active policy matches the requested names`).
* Each policy keeps its own behaviour and severity in threat reports and the dashboard. See [Known Limitations](#known-limitations) for how LiteLLM acts on non-block behaviours.

## Argus or Atlas

| Context source | Where the traffic appears | Collection |
| --- | --- | --- |
| `ENDPOINT` | Atlas | One per user and agent: `{user}.ai-agent.{agent}-litellm` (for example `jane.ai-agent.opencode-litellm`). The user comes from the `X-OpenWebUI-User-Email` or `x-akto-installer-user_email` header, the `user_email` tag or `x-litellm-spend-logs-metadata`; otherwise the client's device ID or the proxy host. The agent comes from the client's `User-Agent`. |
| `AGENTIC` (default) | Argus | Named after the host header LiteLLM forwards (the proxy host), shared by all users. |

## Different Policies for Different Users or Teams

The directive is set per guardrail, not per client. To give different clients different policies, create one pair of guardrails (validate and ingest) per policy set with **Always On** disabled, then select the pair under **Guardrails** when creating or editing the virtual key or team that needs it.

{% hint style="info" %}
Selecting guardrails on a key or team is a LiteLLM premium feature. Without it, use **Always On** guardrails, which apply the same policies to all traffic through the proxy.
{% endhint %}

## Known Limitations

LiteLLM's built-in Akto guardrail only reads Akto's `Allowed` and `Reason` fields, so policy behaviours other than *block* are not applied as configured:

| Policy behaviour | Akto intends | Through the built-in guardrail |
| --- | --- | --- |
| block / warn | Block | Blocked |
| alert | Record only, allow | **Blocked** (HTTP 403) |
| mask (PII) | Allow with PII masked | **Sent unmasked** (`ModifiedPayload` is not applied) |
| human approval | Hold for approval | **Blocked** |

Other ways a request can pass without a check:

* `unreachable_fallback: fail_open` lets requests through when Akto cannot be reached. Use `fail_closed` to block instead.
* When Akto's scanners are overloaded, some checks are skipped and the request is allowed.

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
