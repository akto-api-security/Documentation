---
description: Connect Akto with LiteLLM
---

# LiteLLM

## Overview

LiteLLM is a unified interface for calling 100+ LLM APIs in a consistent format. This integration enables monitoring of API traffic from a LiteLLM proxy and ensures AI-powered applications maintain security standards.

The Akto LiteLLM connector provides the following capabilities:

* Validates AI requests and responses against security policies
* Detects PII, prompt injection, and policy violations
* Ingests traffic into Akto for monitoring and analysis
* Blocks malicious requests (sync mode) or logs violations (async mode)
* Creates per-agent collections based on agent identity

## Prerequisites

Before integrating Akto with LiteLLM, ensure the following are in place:

* An existing LiteLLM proxy installation (running or ready to configure)
* An Akto guardrails service endpoint (URL and authentication token)

## Steps to Connect

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
LITELLM_URL=http://your-litellm-instance-url

# Akto's Data Ingestion Service URL
DATA_INGESTION_SERVICE_URL=http://data-ingestion-service-url

# Optional: Operation Mode
SYNC_MODE=true              # true = block violations, false = async logging only, default true
```

{% hint style="warning" %}
#### **Note**

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
Ensure `custom_hooks.py` is in the same directory as `config.yaml`:

```bash
# Set environment variables
export LITELLM_URL=http://your-litellm-instance-url
export DATA_INGESTION_SERVICE_URL=http://data-ingestion-service-url
export SYNC_MODE=true

# Start LiteLLM
litellm --config config.yaml
```
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

## Per-Agent Collections

By default, all LiteLLM traffic is grouped into a single collection named after the proxy host. The connector supports creating separate collections per agent, allowing each agent's API traffic to be tracked independently in the Akto dashboard.

### How Collections are Created

The connector extracts the agent identity from request metadata and uses it as the collection name. The following sources are checked in order of priority:

1. **`metadata.agent_name`** — explicitly provided by the user in the request body
2. **`key_alias`** — the human-readable name assigned to the LiteLLM virtual key
3. **`team_alias`** — the human-readable name assigned to the team the key belongs to

If none of the above are available, all traffic is grouped into a single collection named after the LiteLLM proxy host.

### Using Metadata

Users can specify an `agent_name` in the request metadata. This approach is supported across all SDKs:

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

The above creates a collection named **chatbot-agent** in the Akto dashboard.

### Using key\_alias

If the LiteLLM virtual keys have a `key_alias` configured (e.g., `"search-agent"`), the connector identifies the agent automatically. All traffic associated with that key is grouped into a collection named after the alias. No changes to the end user's code are required.

### Using team\_alias

If the key belongs to a team with a `team_alias` configured (e.g., `"search-agents"`), the connector uses it as the collection name. This groups all traffic from keys within that team into a single collection. No changes to the end user's code are required.

{% hint style="info" %}
#### **Priority**

The resolution order is: `metadata.agent_name` (highest) → `key_alias` → `team_alias` (lowest). When multiple sources are available, the highest priority value is used.
{% endhint %}

## How It Works

### Request Flow (SYNC\_MODE=true)

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

### Request Flow (SYNC\_MODE=false)

```
1. Client → LiteLLM Proxy
2. Hook initiates a background validation task (non-blocking)
3. Request is immediately forwarded to the LLM provider
4. Response is returned to the client
5. Validation completes in the background (violations are logged only)
```

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
