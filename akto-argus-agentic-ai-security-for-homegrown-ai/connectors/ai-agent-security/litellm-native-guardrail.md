---
description: Enforce chosen Akto policies with LiteLLM's built-in Akto guardrail
---

# LiteLLM (Native Guardrail)

## Overview

LiteLLM ships an Akto guardrail (`guardrail: akto`) that calls Akto directly from the LiteLLM proxy, configured entirely in `config.yaml` with no hook file to deploy.

Each guardrail entry can tell Akto **which policies to enforce** and **whether the traffic belongs to Argus or Atlas**, through the entry's `akto_vxlan_id` field. This lets the LiteLLM administrator choose the policies for each set of keys, teams or clients without any change on the client side.

{% hint style="info" %}
For the Akto custom hook (`custom_hooks.py`), with per-agent collections and session tracking, see [LiteLLM](litellm.md).
{% endhint %}

## Prerequisites

* An existing LiteLLM proxy installation
* An Akto guardrails endpoint (URL and API token)
* The Akto guardrail policies to enforce, created in the Akto dashboard

## Steps to Connect

{% stepper %}
{% step %}
**Configure Environment Variables**

```bash
# Akto endpoint that serves /api/http-proxy
AKTO_GUARDRAIL_API_BASE=https://your-akto-guardrails-url

# Akto API token, from Akto Argus → Connectors → Setup Guardrail
AKTO_API_KEY=<your-akto-guardrail-service-token>
```
{% endstep %}

{% step %}
**Add the Guardrails to `config.yaml`**

Add two entries: one checks each request before the model call, the other sends the request and response to Akto afterwards.

```yaml
guardrails:
  - guardrail_name: akto-validate        # blocks flagged requests before the model call
    litellm_params:
      guardrail: akto
      mode: pre_call
      default_on: true
      akto_vxlan_id: "policy:ENDPOINT:block employee pii"   # optional, see below
      unreachable_fallback: fail_open
      guardrail_timeout: 30
  - guardrail_name: akto-ingest          # sends request + response to Akto after the call
    litellm_params:
      guardrail: akto
      mode: post_call
      default_on: true
      akto_vxlan_id: "policy:ENDPOINT:block employee pii"   # same value as akto-validate
      unreachable_fallback: fail_open
      guardrail_timeout: 30
```

{% hint style="warning" %}
**Set `guardrail_timeout`**

The guardrail's default timeout is 5 seconds, which is too short for coding agents that send large prompts (for example, OpenCode's system prompt alone is about 18KB). A timeout is returned to the client as HTTP 408 **even with `unreachable_fallback: fail_open`**, because LiteLLM only fails open on connection errors. Set `guardrail_timeout: 30`.
{% endhint %}
{% endstep %}

{% step %}
**Restart LiteLLM**

```bash
docker compose up -d --force-recreate litellm
```
{% endstep %}
{% endstepper %}

## Choosing Policies and Context Source

Set `akto_vxlan_id` on a guardrail entry to a policy directive:

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
| `"policy:ENDPOINT:block employee pii"` | Atlas traffic; only the *block employee pii* policy is enforced |
| `"policy:AGENTIC:Secrets,Prompt Injection"` | Argus traffic; only these two policies are enforced |
| `"policy:ENDPOINT:"` | Atlas traffic; all Atlas policies in scope are enforced |
| `"policy::Secrets"` | Argus traffic (default); only *Secrets* is enforced |

Rules for policy names:

* Matched **case-insensitively**, with leading and trailing spaces ignored. Spaces inside a name must match exactly.
* Separate multiple names with commas. A name may contain `:` (only the first two `:` split the directive), but not `,`.
* Quote the value in YAML.
* Akto resets the field to `0` after reading it, so the directive never becomes a collection ID.

{% hint style="info" %}
**Set the same directive on both entries**

The `akto-validate` and `akto-ingest` entries send their own `akto_vxlan_id`. Use the same value on both, otherwise ingested traffic will not be placed in the same context source as the verdicts.
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

The directive is set per guardrail entry, not per client. To give different clients different policies, define one pair of entries per policy set (with `default_on: false`) and attach each pair to the keys, teams or requests that need it, using LiteLLM's guardrail selection.

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
