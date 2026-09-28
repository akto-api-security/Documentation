---
description: Connect Akto with LiteLLM
---

# LiteLLM

## Overview

LiteLLM is a unified interface for calling 100+ LLM APIs in a consistent format. Connecting Akto to a LiteLLM proxy validates AI requests and responses against Akto guardrail policies, detects PII, prompt injection and policy violations, blocks malicious requests, and ingests the traffic into Akto for monitoring.

<figure><img src="../../../.gitbook/assets/litellm-akto-architecture.png" alt="AI apps and coding agents send traffic through the LiteLLM Proxy to model providers and MCP servers; the proxy calls Akto for pre-call validation and post-call ingestion"><figcaption><p>Akto guardrails on a LiteLLM Proxy</p></figcaption></figure>

There are two ways to connect Akto with LiteLLM:

* **[Native Guardrail](#option-1-native-guardrail):** LiteLLM's built-in Akto guardrail, set up in the LiteLLM Admin UI. Nothing to deploy, and each guardrail chooses which Akto policies to enforce and whether traffic goes to Argus or Atlas.
* **[Custom Hook](#option-2-custom-hook):** Akto's `custom_hooks.py` callback, loaded from `config.yaml`. Use this if you need per-agent collections, session tracking, or an async (log-only) mode.

## Option 1: Native Guardrail

LiteLLM ships an Akto guardrail that calls Akto directly from the LiteLLM proxy. It is set up in the LiteLLM Admin UI, with no hook file to deploy. Each guardrail tells Akto **which policies to enforce** and **whether the traffic belongs to Argus or Atlas**, through its `akto_vxlan_id` field, so the LiteLLM administrator chooses the policies for each set of keys, teams or clients without any change on the client side.

### Prerequisites

* A LiteLLM proxy with the Admin UI enabled and a database configured (`DATABASE_URL`); guardrails created in the UI are stored in the database
* An Akto guardrails endpoint (URL and API token). See [Getting API Token](../others/hybrid-saas.md#getting-api-token) for where to get the token
* The Akto guardrail policies to enforce, created in the Akto dashboard

### Steps to Connect

Create the guardrails in the LiteLLM Admin UI. Create **two** guardrails: one that checks each request before the model call, and one that sends the request and response to Akto after the call.

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
| `akto_account_id` | Leave empty. |

Click **Create Guardrail**.
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

{% hint style="info" %}
**Only `Pre Call` blocks**

LiteLLM does not block on `Post Call` guardrails. The Akto ingest (`Post Call`) guardrail sends the request and response to Akto in the background and returns the response unchanged, so a `Post Call` violation is recorded and reported in Akto, never blocked. Only `Pre Call` (`akto-validate`) can block a request.
{% endhint %}

### Choosing Policies and Context Source

Set the `akto_vxlan_id` field of the guardrail to a policy directive:

```text
policy:<contextSource>:<policy name>[,<policy name>...]
```

| Part | Values | Meaning |
| --- | --- | --- |
| `policy:` | fixed prefix | Marks the value as a directive. Values without it are treated as a normal VXLAN ID. |
| `<contextSource>` | `ENDPOINT`, `AGENTIC`, or empty | `ENDPOINT` sends the traffic to **Atlas**; `AGENTIC` keeps it in **Argus**. Empty or any other value keeps the default (Argus). |
| `<policy name>` | one or more names, comma-separated | The Akto guardrail policies to enforce. Optional. |

<details>

<summary><strong>Examples</strong></summary>

| `akto_vxlan_id` | Result |
| --- | --- |
| `policy:ENDPOINT:block employee pii` | Atlas traffic; only the *block employee pii* policy is enforced |
| `policy:AGENTIC:Secrets,Prompt Injection` | Argus traffic; only these two policies are enforced |
| `policy:ENDPOINT:` | Atlas traffic; all Atlas policies in scope are enforced |
| `policy::Secrets` | Argus traffic (default); only *Secrets* is enforced |

</details>

Rules for policy names:

* Matched **case-insensitively**, with leading and trailing spaces ignored. Spaces inside a name must match exactly.
* Separate multiple names with commas. A name may contain `:` (only the first two `:` split the directive), but not `,`.
* Akto resets the field to `0` after reading it, so the directive never becomes a collection ID.

{% hint style="info" %}
**Set the same directive on both guardrails**

The `akto-validate` and `akto-ingest` guardrails send their own `akto_vxlan_id`. Use the same value on both, otherwise ingested traffic will not be placed in the same context source as the verdicts.
{% endhint %}

### How Named Policies Are Enforced

* **A named policy is always enforced while it is active.** It applies regardless of the policy's own context source and scope (server/agent, device/user, account type, approved servers), and regardless of `GUARDRAILS_SKIP_PATHS`.
* **Only the named policies are enforced.** Other policies do not run for that traffic.
* **Inactive policies are never enforced.** Deactivating a policy in the Akto dashboard turns it off for LiteLLM traffic too, within about a minute. If it was the only name in the directive, that traffic then gets no guardrails.
* Each policy keeps its own behaviour and severity in threat reports and the dashboard.

{% hint style="warning" %}
**A typo or an inactive name turns guardrails off for that traffic**

If none of the names in `akto_vxlan_id` match an active policy, Akto applies **no** guardrails to the request and allows it (and logs `no active policy matches the requested names, applying no guardrails`). A misspelled, renamed or deactivated policy name therefore leaves that traffic unchecked, so verify each name matches an active policy exactly. Names that match are still enforced when other names in the list don't.
{% endhint %}

### Argus or Atlas

| Context source | Where the traffic appears | Collection |
| --- | --- | --- |
| `ENDPOINT` | Atlas | One per user and agent: `{user}.ai-agent.{agent}-litellm` (for example `jane.ai-agent.opencode-litellm`). The user comes from the email the client sends (see [Identifying Users](#identifying-users)); otherwise the client's device ID or the proxy host. The agent comes from the client's `User-Agent`. |
| `AGENTIC` (default) | Argus | Named after the host header LiteLLM forwards (the proxy host), shared by all users. |

### Identifying Users

Akto attributes LiteLLM traffic to a user by the user's **email**, which the client must send with every request. Without it, Akto cannot tell users apart:

* In Atlas, each user gets their own collection, named from the email (for example `jane@example.com` → `jane.ai-agent.opencode-litellm`). Without an email, the collection is named after the client's device ID or the proxy host, so different users can end up in the same collection.
* Policies targeted at specific users, and policies that skip enterprise accounts, match on this email. A request without an email is treated as an unknown user.

Send the email in the `x-akto-installer-user_email` request header. Akto reads the email from the first of these it finds:

1. `X-OpenWebUI-User-Email` header (sent by Open WebUI when `ENABLE_FORWARD_USER_INFO_HEADERS=true`)
2. `x-akto-installer-user_email` header
3. `user_email` in the request metadata
4. `user_email` in the `x-litellm-spend-logs-metadata` header

**Example: OpenCode**

Add the header to the LiteLLM provider in `opencode.json`, reading the email from an environment variable so each user sends their own:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "litellm": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "LiteLLM (Akto guardrails)",
      "options": {
        "baseURL": "http://<your-litellm-host>/v1",
        "apiKey": "{env:LITELLM_API_KEY}",
        "headers": {
          "x-akto-installer-user_email": "{env:AKTO_USER_EMAIL}"
        }
      },
      "models": {
        "claude-sonnet-5": { "name": "Claude Sonnet 5 via LiteLLM" }
      }
    }
  },
  "model": "litellm/claude-sonnet-5"
}
```

Then set the user's email before starting OpenCode:

```bash
export AKTO_USER_EMAIL="$(git config user.email)"
opencode
```

{% hint style="warning" %}
Send the real user's email, not a shared or test address. Every request carrying the same email is attributed to the same user.
{% endhint %}

### Different Policies for Different Users or Teams

The directive is set per guardrail, not per client. To scope a policy to specific teams, users, models, keys or access groups: create a dedicated pair of guardrails with `default_on: false` (so it doesn't run for every request), group the pair under a named entry in `policies`, then attach that policy to a target under `policy_attachments` in `config.yaml`, or by selecting the pair under **Guardrails** when creating or editing a virtual key or team in the Admin UI. See [Examples](#examples) below for a worked config per target.

{% hint style="info" %}
Attaching a policy by `keys` or `teams`, in `config.yaml` or the Admin UI, is a LiteLLM Enterprise feature. Attaching by `tags` worked without an Enterprise licence when tested; attaching by `models` needs no special licence either way.
{% endhint %}

### Examples

Worked `config.yaml` snippets scoping an Akto guardrail pair to one target, using LiteLLM's `guardrails` + `policies` + `policy_attachments` blocks. Each pair has `default_on: false`, so only requests matching the attachment run it; every other request is unaffected.

To try any of these, the flow is the same end to end, only step 3 (the LiteLLM policy) changes between examples:

{% stepper %}
{% step %}
**Get a Virtual Key**

Grab an existing virtual key from LiteLLM, or create one, and note the key (`sk-...`).
{% endstep %}

{% step %}
**Create the Akto Guardrails**

Add the `guardrails` block from the example you want to your `config.yaml`: an `akto-*-validate` (pre-call) and `akto-*-ingest` (post-call) pair, both `default_on: false`.
{% endstep %}

{% step %}
**Set Up the LiteLLM Policy**

This is the part that differs per example. Add the matching `policies` and `policy_attachments` blocks, and create or identify the team, model, or tagged key it selects (for example, a team aliased `finance-team`, or a key tagged `access-group:finance`), so the key from step 1 is covered by it. Reload LiteLLM afterward.
{% endstep %}

{% step %}
**Point OpenCode at LiteLLM**

Configure OpenCode's LiteLLM provider with the virtual key as `apiKey` (see [Identifying Users](#identifying-users) for the config), or use any client you'd like to test with.
{% endstep %}

{% step %}
**Send a Safe Prompt, Then a Malicious One**

From OpenCode, send an ordinary prompt first, then one designed to trigger the policy you attached, for example a request containing PII to trigger `block employee pii`, or any prompt at all for `test-guardrail`.
{% endstep %}

{% step %}
**Check the Dashboard**

Go to **Collections** and confirm the OpenCode/LiteLLM collection formed with both requests (see [AI Usage](#ai-usage)), then check [Guardrail Activity](../../../agentic-guardrails/concepts/guardrail-activity.md) for the malicious prompt's detection.
{% endstep %}
{% endstepper %}

<details>

<summary><strong>Example: Scope by Model</strong></summary>

Any key calling `gpt-4o-mini-strict` gets the policy; calls to any other model get none. No key, team or tag setup needed, just a second `model_list` entry pointing at the model you want to guard.

```yaml
guardrails:
  - guardrail_name: akto-model-validate
    litellm_params:
      guardrail: akto
      mode: pre_call
      default_on: false
      akto_vxlan_id: "policy:ENDPOINT:test-guardrail"
      unreachable_fallback: fail_open
      guardrail_timeout: 30
  - guardrail_name: akto-model-ingest
    litellm_params:
      guardrail: akto
      mode: post_call
      default_on: false
      akto_vxlan_id: "policy:ENDPOINT:test-guardrail"
      unreachable_fallback: fail_open
      guardrail_timeout: 30

policies:
  akto-model:
    description: Akto policy "test-guardrail" for the strict model
    guardrails:
      add: [akto-model-validate, akto-model-ingest]

policy_attachments:
  - policy: akto-model
    models: ["gpt-4o-mini-strict"]
```

</details>

<details>

<summary><strong>Example: Scope by Virtual Key</strong></summary>

Only the named key's traffic gets the policy; every other key gets none. The key's `user_id` (for example `jane@example.com`) is also how Akto attributes the traffic to that user, see [Identifying Users](#identifying-users).

```yaml
guardrails:
  - guardrail_name: akto-test-guardrail-validate
    litellm_params:
      guardrail: akto
      mode: pre_call
      default_on: false
      akto_vxlan_id: "policy:ENDPOINT:test-guardrail"
      unreachable_fallback: fail_open
      guardrail_timeout: 30
  - guardrail_name: akto-test-guardrail-ingest
    litellm_params:
      guardrail: akto
      mode: post_call
      default_on: false
      akto_vxlan_id: "policy:ENDPOINT:test-guardrail"
      unreachable_fallback: fail_open
      guardrail_timeout: 30

policies:
  akto-test-guardrail-only:
    description: Only the Akto policy "test-guardrail"
    guardrails:
      add: [akto-test-guardrail-validate, akto-test-guardrail-ingest]

policy_attachments:
  - policy: akto-test-guardrail-only
    keys: ["jane-opencode"]
```

</details>

<details>

<summary><strong>Example: Scope by Team</strong></summary>

Every key that belongs to the team gets the policy; keys outside the team get none.

```yaml
guardrails:
  - guardrail_name: akto-team-validate
    litellm_params:
      guardrail: akto
      mode: pre_call
      default_on: false
      akto_vxlan_id: "policy:ENDPOINT:block employee pii"
      unreachable_fallback: fail_open
      guardrail_timeout: 30
  - guardrail_name: akto-team-ingest
    litellm_params:
      guardrail: akto
      mode: post_call
      default_on: false
      akto_vxlan_id: "policy:ENDPOINT:block employee pii"
      unreachable_fallback: fail_open
      guardrail_timeout: 30

policies:
  akto-team:
    description: Akto policy "block employee pii" for the finance team
    guardrails:
      add: [akto-team-validate, akto-team-ingest]

policy_attachments:
  - policy: akto-team
    teams: ["finance-team"]
```

</details>

<details>

<summary><strong>Example: Scope by User</strong></summary>

Every key tagged with a given user's email gets the policy, regardless of which team or key alias it uses. Unlike the Team and Virtual Key attachments above, tag-based attachment worked without a LiteLLM Enterprise licence when tested.

```yaml
guardrails:
  - guardrail_name: akto-test-guardrail-validate
    litellm_params:
      guardrail: akto
      mode: pre_call
      default_on: false
      akto_vxlan_id: "policy:ENDPOINT:test-guardrail"
      unreachable_fallback: fail_open
      guardrail_timeout: 30
  - guardrail_name: akto-test-guardrail-ingest
    litellm_params:
      guardrail: akto
      mode: post_call
      default_on: false
      akto_vxlan_id: "policy:ENDPOINT:test-guardrail"
      unreachable_fallback: fail_open
      guardrail_timeout: 30

policies:
  akto-test-guardrail-only:
    description: Only the Akto policy "test-guardrail"
    guardrails:
      add: [akto-test-guardrail-validate, akto-test-guardrail-ingest]

policy_attachments:
  - policy: akto-test-guardrail-only
    tags: ["user:jane@example.com"]
```

</details>

<details>

<summary><strong>Example: Scope by Access Group</strong></summary>

Every key or team assigned to a LiteLLM access group (a named grant of specific models, created in the Admin UI under **Access Groups**) gets the policy. `policy_attachments` can't select an access group directly, so tag every key or team assigned to the group with `access-group:<name>`, and match on that tag instead.

```yaml
guardrails:
  - guardrail_name: akto-access-group-validate
    litellm_params:
      guardrail: akto
      mode: pre_call
      default_on: false
      akto_vxlan_id: "policy:ENDPOINT:block employee pii"
      unreachable_fallback: fail_open
      guardrail_timeout: 30
  - guardrail_name: akto-access-group-ingest
    litellm_params:
      guardrail: akto
      mode: post_call
      default_on: false
      akto_vxlan_id: "policy:ENDPOINT:block employee pii"
      unreachable_fallback: fail_open
      guardrail_timeout: 30

policies:
  akto-access-group:
    description: Akto policy "block employee pii" for the finance access group
    guardrails:
      add: [akto-access-group-validate, akto-access-group-ingest]

policy_attachments:
  - policy: akto-access-group
    tags: ["access-group:finance"]
```

</details>

## Option 2: Custom Hook

Akto's custom hook (`custom_hooks.py`) is a LiteLLM callback that sends each request to Akto for validation and ingests the request and response. It supports per-agent collections, session-based guardrails, and a sync (block) or async (log-only) mode.

### Prerequisites

Before integrating Akto with LiteLLM, ensure the following are in place:

* An existing LiteLLM proxy installation (running or ready to configure)
* An Akto guardrails service endpoint (URL and authentication token)

### Steps to Connect

{% stepper %}
{% step %}
**Download the Custom Hook**

Download the `custom_hooks.py` file to the LiteLLM configuration directory:

```bash
# Navigate to the LiteLLM config directory
cd /path/to/your/litellm/config

# Download the hook file
curl -O https://raw.githubusercontent.com/akto-api-security/akto/master/apps/mcp-endpoint-shield/litellm/custom_hooks.py
```
{% endstep %}

{% step %}
**Configure Environment Variables**

Add the following environment variables to the LiteLLM environment (`.env` file or system environment):

```bash
# URL of this LiteLLM proxy instance (used as the default collection host)
LITELLM_URL=http://your-litellm-instance-url

# Akto's Data Ingestion Service URL
DATA_INGESTION_SERVICE_URL=http://data-ingestion-service-url

# Akto API token used to authenticate to the Data Ingestion Service
AKTO_API_TOKEN=<your-akto-guardrail-service-token>

# Optional: Operation Mode
SYNC_MODE=true              # true = block violations, false = async logging only, default true

# Optional: timeout (in seconds) for calls to the Data Ingestion Service
TIMEOUT=5                   # default 5
```

The connector reads these variables (`custom_hooks.py`):

| Variable | Required | Default | Description |
| --- | --- | --- | --- |
| `DATA_INGESTION_SERVICE_URL` | Yes | | Akto Data Ingestion Service endpoint the hook sends traffic and validation requests to. |
| `AKTO_API_TOKEN` | Yes | empty | Token sent in the `Authorization` header to the Data Ingestion Service. See [Getting API Token](../others/hybrid-saas.md#getting-api-token). |
| `LITELLM_URL` | Yes | `http://localhost:4000` | This proxy's URL; its host is used as the default collection name when no agent identity is present. |
| `SYNC_MODE` | No | `true` | `true` blocks violations before the LLM call; `false` validates asynchronously (log only). |
| `TIMEOUT` | No | `5` | Timeout in seconds for HTTP calls to the Data Ingestion Service. |

{% hint style="warning" %}
**Note**

`SYNC_MODE` determines behavior:

* `SYNC_MODE=true`: Requests are validated before being sent to the LLM. Violations block the request immediately.
* `SYNC_MODE=false`: Requests proceed immediately. Validation occurs in the background.
{% endhint %}
{% endstep %}

{% step %}
**Update LiteLLM Configuration**

Edit the `config.yaml` to enable the custom hook:

```yaml
model_list:
  # Existing models

litellm_settings:
  callbacks: [custom_hooks.proxy_handler_instance]  # ← Add this line
  drop_params: true
  set_verbose: false
  request_timeout: 600
  num_retries: 2

# ... rest of the config ...
```

The required change is adding `callbacks: [custom_hooks.proxy_handler_instance]` to activate the Akto guardrails hook.
{% endstep %}

{% step %}
**Ensure Hook File is Accessible**

{% tabs %}
{% tab title="Using LiteLLM Directly" %}
Ensure `custom_hooks.py` is in the same directory as `config.yaml`, then start LiteLLM with the environment variables from the previous step set:

```bash
litellm --config config.yaml
```

{% hint style="info" %}
See [Getting API Token](../others/hybrid-saas.md#getting-api-token) for where to get the Akto API Token.\
![](<../../../.gitbook/assets/image (178).png>)
{% endhint %}
{% endtab %}

{% tab title="Using Docker" %}
Mount the hook file in the docker compose configuration:

```yaml
services:
  litellm:
    image: docker.litellm.ai/berriai/litellm:main-stable
    volumes:
      - ./config.yaml:/app/config.yaml
      - ./custom_hooks.py:/app/custom_hooks.py
    environment:
      - LITELLM_URL=${LITELLM_URL}
      - DATA_INGESTION_SERVICE_URL=${DATA_INGESTION_SERVICE_URL}
      - AKTO_API_TOKEN=${AKTO_API_TOKEN}
      - SYNC_MODE=${SYNC_MODE}
    # ... rest of config ...
```
{% endtab %}
{% endtabs %}
{% endstep %}

{% step %}
**Start LiteLLM**

```bash
# Using Docker Compose
docker compose restart litellm

# Using Docker run
docker restart litellm-container

# Running directly (stop with Ctrl+C, then restart)
litellm --config config.yaml
```
{% endstep %}

{% step %}
**Verify Integration**

Confirm that LiteLLM starts successfully with the hook:

```bash
# Check logs for hook initialization
docker compose logs litellm | grep GuardrailsHandler

# Expected output:
# GuardrailsHandler initialized | sync_mode=True
```

**Send a test request:**

```bash
curl -X POST http://localhost:4000/chat/completions \
  -H "Authorization: Bearer YOUR_LITELLM_MASTER_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gpt-4",
    "messages": [{"role": "user", "content": "Hello!"}]
  }'
```

**Verify in the Akto dashboard:**

* Log into the Akto dashboard
* Navigate to the Collections section
* Confirm that requests from LiteLLM are appearing
{% endstep %}
{% endstepper %}

### Per-Agent Collections

By default, all LiteLLM traffic is grouped into a single collection named after the proxy host. The connector supports creating separate collections per agent, allowing each agent's API traffic to be tracked independently in the Akto dashboard.

#### How Collections Are Created

The connector extracts the agent identity from request metadata and uses it as the collection name. The following sources are checked in order of priority:

1. **`metadata.agent_name`**: explicitly provided by the user in the request body
2. **`key_alias`**: the human-readable name assigned to the LiteLLM virtual key
3. **`team_alias`**: the human-readable name assigned to the team the key belongs to

If none of the above are available, all traffic is grouped into a single collection named after the LiteLLM proxy host.

#### Using Metadata

Users can specify an `agent_name` in the request metadata. This approach is supported across all SDKs:

<details>

<summary><strong>Example: setting <code>agent_name</code></strong></summary>

{% tabs %}
{% tab title="OpenAI SDK" %}
```python
from openai import OpenAI

client = OpenAI(base_url="http://localhost:4000", api_key="sk-...")

response = client.chat.completions.create(
    model="gpt-4",
    messages=[{"role": "user", "content": "Hello!"}],
    extra_body={
        "metadata": {"agent_name": "chatbot-agent"}
    }
)
```
{% endtab %}

{% tab title="LiteLLM SDK" %}
```python
import litellm

response = litellm.completion(
    model="litellm_proxy/gpt-4",
    messages=[{"role": "user", "content": "Hello!"}],
    extra_body={
        "metadata": {"agent_name": "chatbot-agent"}
    },
    api_base="http://localhost:4000",
    api_key="sk-...",
)
```
{% endtab %}

{% tab title="curl" %}
```bash
curl -X POST http://localhost:4000/chat/completions \
  -H "Authorization: Bearer sk-..." \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gpt-4",
    "messages": [{"role": "user", "content": "Hello!"}],
    "metadata": {"agent_name": "chatbot-agent"}
  }'
```
{% endtab %}
{% endtabs %}

</details>

The above creates a collection named **chatbot-agent** in the Akto dashboard.

#### Using key\_alias

If the LiteLLM virtual keys have a `key_alias` configured (e.g., `"search-agent"`), the connector identifies the agent automatically. All traffic associated with that key is grouped into a collection named after the alias. No changes to the end user's code are required.

#### Using team\_alias

If the key belongs to a team with a `team_alias` configured (e.g., `"search-agents"`), the connector uses it as the collection name. This groups all traffic from keys within that team into a single collection. No changes to the end user's code are required.

{% hint style="info" %}
**Priority**

The resolution order is: `metadata.agent_name` (highest) → `key_alias` → `team_alias` (lowest). When multiple sources are available, the highest priority value is used.
{% endhint %}

### Session-Based Guardrails

The connector supports session tracking, which lets the Akto guardrails service correlate multiple requests belonging to the same conversation or user session. This enables session-aware policies such as malicious-session detection and session-summary injection.

To enable this, send an `x-session-id` header on the request to the LiteLLM proxy. When present, the connector captures it and forwards it to the Akto guardrails service, which groups requests sharing the same session ID.

<details>

<summary><strong>Example: setting <code>x-session-id</code></strong></summary>

{% tabs %}
{% tab title="OpenAI SDK" %}
```python
from openai import OpenAI

client = OpenAI(base_url="http://localhost:4000", api_key="sk-...")

response = client.chat.completions.create(
    model="gpt-4",
    messages=[{"role": "user", "content": "Hello!"}],
    extra_headers={"x-session-id": "session-abc-123"}
)
```
{% endtab %}

{% tab title="curl" %}
```bash
curl -X POST http://localhost:4000/chat/completions \
  -H "Authorization: Bearer sk-..." \
  -H "Content-Type: application/json" \
  -H "x-session-id: session-abc-123" \
  -d '{
    "model": "gpt-4",
    "messages": [{"role": "user", "content": "Hello!"}]
  }'
```
{% endtab %}
{% endtabs %}

</details>

{% hint style="info" %}
**Note**

Session tracking is optional. Requests without an `x-session-id` header are processed normally and are simply not associated with a session. Session-based features on the guardrails service are controlled by the `SESSION_ENABLED` setting (enabled by default).
{% endhint %}

### How It Works

#### Request Flow (SYNC\_MODE=true)

```
1. Client → LiteLLM Proxy
2. Hook intercepts the request (pre-call hook)
3. Request is sent to the Akto Data Ingestion Service API
4. Data Ingestion Service validates against policies
   ├─ If BLOCKED: Error returned to the client (LLM is not called)
   └─ If ALLOWED: Continue to step 5
5. Request is forwarded to the LLM provider
6. LLM response is received
7. Hook intercepts the response (post-call hook)
8. Response is sent to the Akto Data Ingestion Service API for display in the dashboard
```

#### Request Flow (SYNC\_MODE=false)

```
1. Client → LiteLLM Proxy
2. Hook initiates a background validation task (non-blocking)
3. Request is immediately forwarded to the LLM provider
4. Response is returned to the client
5. Validation completes in the background (violations are logged only)
```

## AI Usage

Once traffic is flowing through either option, LiteLLM requests show up in the Akto dashboard like any other collection: log in, open **Collections**, and select the collection the traffic landed in to see the request/response list with a guardrail verdict (policy triggered, severity) on each entry.

Which collection a given request lands in, and how it's segmented by user, agent, key or team, is controlled by the rules in [Argus or Atlas](#argus-or-atlas) and [Per-Agent Collections](#per-agent-collections) above.

{% hint style="info" %}
**No dedicated model, token or spend breakdown**

Akto does not currently show a separate usage-analytics view for LiteLLM traffic, such as a per-model chart, token counts, or spend/cost totals. Model names, `key_alias`, `team_alias` and LiteLLM's own spend metadata are used only for collection naming and user attribution (as described above), not surfaced as usage analytics. To see which model a request used, open the request in the collection.
{% endhint %}

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
