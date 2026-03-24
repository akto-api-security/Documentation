---
description: Connect Akto with LiteLLM
---

# LiteLLM

## Overview

LiteLLM is a unified interface for calling 100+ LLM APIs in a consistent format. Akto provides two ways to connect with your LiteLLM proxy:

1. **Native LiteLLM Integration (Recommended)** — Configure Akto directly in `config.yaml` using LiteLLM's built-in guardrail and callback system. No custom code required.
2. **Custom Hook** — A Python middleware file (`custom_hooks.py`) that plugs into LiteLLM's callback system for more control or older LiteLLM versions.

The Akto LiteLLM integration automatically:

* Validates AI requests and responses against security policies
* Detects PII, prompt injection, and policy violations
* Ingests traffic into Akto for monitoring and analysis
* Blocks malicious requests (sync mode) or logs violations (async mode)

## Prerequisites

Before integrating Akto with LiteLLM, ensure you have:

* Existing LiteLLM proxy installation (running or ready to configure)
* Akto guardrails service endpoint (URL and API key)
* Akto data ingestion service endpoint (URL and API key)

---

## Option 1: Native LiteLLM Integration (Recommended)

This approach uses Akto's built-in LiteLLM support — a guardrail for pre-call blocking and a logger callback for traffic ingestion. You can configure this either through the **LiteLLM UI** or directly in `config.yaml`:

* **LiteLLM UI** — Navigate to **Guardrails** to add the Akto guardrail, and **Logging & Alerts** to enable the Akto logger. No file editing required.
* **`config.yaml`** — Declare the guardrail and callbacks directly in your proxy config file.

Both modes are supported either way:

* **Sync mode** — Guardrail runs `pre_call`, validating the request _before_ the LLM is called. Violations block the request (403). All traffic is also ingested via the Akto logger callback.
* **Async mode** — No blocking. Traffic is ingested via the Akto logger callback after the call completes.

### How It Works

The integration hooks into two points of the LiteLLM proxy lifecycle:

* **Guardrail (`pre_call`)** — Validates the prompt against Akto guardrails _before_ the LLM is called. In sync mode, a policy violation blocks the request immediately with a 403.
* **Logger callbacks (`success_callback` / `failure_callback`)** — Ingests the completed interaction (request + response) into Akto for audit and dashboard visibility. Runs on both successful and failed calls.

### Request Flow (Sync Mode)

```
1. Client → LiteLLM Proxy
2. Akto guardrail intercepts request (pre_call, blocking)
   ├─ If BLOCKED: 403 error returned to client (LLM never called)
   └─ If ALLOWED: Continue to step 3
3. Request forwarded to LLM Provider
4. LLM response received
5. Akto logger ingests full interaction (request + response)
```

### Request Flow (Async Mode)

```
1. Client → LiteLLM Proxy
2. Request immediately forwarded to LLM Provider (no pre-validation)
3. LLM response received and returned to client
4. Akto logger ingests full interaction asynchronously (log-only)
```

### Steps to Connect

The steps below cover the `config.yaml` approach. For the UI approach, navigate to **Guardrails** and **Logging & Alerts** in your LiteLLM dashboard and add Akto as the provider in each section.

{% stepper %}
{% step %}
**Set Environment Variables**

```bash
# Required for both sync and async
export AKTO_DATA_INGESTION_API_BASE="http://your-akto-instance:8080"
export AKTO_API_KEY="your-akto-api-key"

# Optional
export AKTO_ACCOUNT_ID="1000000"   # default: 1000000
export AKTO_VXLAN_ID="0"           # default: 0

# Required for sync mode only
export AKTO_GUARDRAIL_API_BASE="http://your-akto-guardrail-service"
```
{% endstep %}

{% step %}
**Configure `config.yaml`**

**Sync mode** — guardrail blocks bad requests, logger captures all traffic:

```yaml
model_list:
  - model_name: gpt-5.4
    litellm_params:
      model: gpt-5.4

guardrails:
  - guardrail_name: "akto-guardrails"
    litellm_params:
      guardrail: akto
      mode: pre_call
      akto_base_url: os.environ/AKTO_GUARDRAIL_API_BASE
      akto_api_key: os.environ/AKTO_API_KEY
      default_on: true
      unreachable_fallback: fail_closed   # fail_open | fail_closed (default: fail_closed)
      guardrail_timeout: 5                # seconds (default: 5)

litellm_settings:
  success_callback: ["akto"]
  failure_callback: ["akto"]
```

**Async mode** — logger only, no blocking:

```yaml
model_list:
  - model_name: gpt-5.4
    litellm_params:
      model: gpt-5.4

litellm_settings:
  success_callback: ["akto"]
  failure_callback: ["akto"]
```
{% endstep %}

{% step %}
**Start LiteLLM**

```bash
litellm --config config.yaml
```

For Docker, mount your `config.yaml` and pass the environment variables through your `docker-compose.yaml`.
{% endstep %}

{% step %}
**Verify Integration**

Send a test request:

```bash
curl --location 'http://localhost:4000/chat/completions' \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer <your-litellm-key>' \
  -d '{
    "model": "gpt-5.4",
    "messages": [{"role": "user", "content": "Hello!"}]
  }'
```

Check the guardrail health (sync mode):

```bash
curl 'http://localhost:4000/health/services?service=akto' \
  -H 'Authorization: Bearer <your-litellm-key>'
```

Then verify in the Akto dashboard:

* Log into your Akto dashboard
* Navigate to the Collections section
* Verify you see requests from LiteLLM appearing
{% endstep %}
{% endstepper %}

### Configuration Reference

**Logger (both modes)**

| Variable | Required | Default | Description |
| -------- | -------- | ------- | ----------- |
| `AKTO_DATA_INGESTION_API_BASE` | Yes | | Akto data ingestion API base URL |
| `AKTO_API_KEY` | Yes | | Akto API key for authentication |
| `AKTO_ACCOUNT_ID` | No | `1000000` | Akto account ID |
| `AKTO_VXLAN_ID` | No | `0` | Akto VXLAN ID |

**Guardrail (sync mode only)**

| Parameter | Env Variable | Default | Description |
| --------- | ------------ | ------- | ----------- |
| `akto_base_url` | `AKTO_GUARDRAIL_API_BASE` | *required* | Akto guardrail API base URL |
| `akto_api_key` | `AKTO_API_KEY` | *required* | API key (sent as `Authorization` header) |
| `unreachable_fallback` | — | `fail_closed` | `fail_open` or `fail_closed` |
| `guardrail_timeout` | — | `5` | Timeout in seconds |
| `default_on` | — | `true` | Enables the guardrail entry by default |

### Handling Blocked Requests

When `mode: pre_call` is active and a request is blocked by guardrails, LiteLLM returns a 403:

```json
{
  "error": {
    "message": "Prompt injection detected",
    "type": "None",
    "param": "None",
    "code": "403"
  }
}
```

The `unreachable_fallback` setting controls behavior when the Akto guardrail service is unavailable:

| Scenario | `fail_closed` (default) | `fail_open` |
| -------- | ----------------------- | ----------- |
| Akto unreachable | ❌ Blocked (503) | ✅ Passes through |
| Akto returns error | ❌ Blocked (503) | ✅ Passes through |
| Guardrail says no | ❌ Blocked (403) | ❌ Blocked (403) |

### What's Logged to Akto

For every LLM call, the logger sends:

* **Request**: Messages, model, tools, tool calls
* **Response**: Full model response (choices, usage)
* **Headers**: All proxy request headers (sensitive headers like `Authorization`, `Cookie` are stripped)
* **Metadata**: User ID, team ID, API route, client IP
* **Status**: HTTP status code (200 for success, 500 for failures)
* **Timing**: Request timestamp

---

## Option 2: Custom Hook

Use this approach if you need more control or are on an older LiteLLM version that does not have native Akto support. It uses a `custom_hooks.py` file that plugs into LiteLLM's callback system.

### How It Works

The hook intercepts two points of the LiteLLM proxy lifecycle:

* **Pre-call hook** — Validates the request against Akto guardrails _before_ the LLM is called. In sync mode (`SYNC_MODE=true`), a policy violation blocks the request immediately.
* **Post-call hook** — Ingests the completed interaction (request + response) into Akto for dashboard visibility.

### Request Flow (SYNC\_MODE=true)

```
1. Client → LiteLLM Proxy
2. Hook intercepts request (pre-call hook)
3. Request sent to Akto Data Ingestion Service for validation
   ├─ If BLOCKED: Error returned to client (LLM never called)
   └─ If ALLOWED: Continue to step 4
4. Request forwarded to LLM Provider
5. LLM response received
6. Hook intercepts response (post-call hook)
7. Full interaction sent to Akto for audit and dashboard display
```

### Request Flow (SYNC\_MODE=false)

```
1. Client → LiteLLM Proxy
2. Hook starts background validation task (non-blocking)
3. Request immediately forwarded to LLM Provider
4. Response returned to client
5. Validation completes in background (violations logged only)
```

### Steps to Connect

{% stepper %}
{% step %}
**Download the Custom Hook**

Download the `custom_hooks.py` file to your LiteLLM configuration directory:

```bash
# Navigate to your LiteLLM config directory
cd /path/to/your/litellm/config

# Download the hook file
curl -O https://raw.githubusercontent.com/akto-api-security/akto/master/apps/mcp-endpoint-shield/litellm/custom_hooks.py
```
{% endstep %}

{% step %}
**Configure Environment Variables**

Add these environment variables to your LiteLLM environment (`.env` file or system environment):

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

* `SYNC_MODE=true`: Requests are validated BEFORE being sent to the LLM. Violations block the request immediately.
* `SYNC_MODE=false`: Requests proceed immediately, validation happens in background.
{% endhint %}
{% endstep %}

{% step %}
**Update LiteLLM Configuration**

Edit your `config.yaml` to enable the custom hook:

```yaml
model_list:
  # Your existing models

litellm_settings:
  callbacks: [custom_hooks.proxy_handler_instance]  # ← Add this line
  drop_params: true
  set_verbose: false
  request_timeout: 600
  num_retries: 2

# ... rest of your config ...
```

The critical change is adding `callbacks: [custom_hooks.proxy_handler_instance]` to activate the Akto guardrails hook.
{% endstep %}

{% step %}
**Ensure Hook File is Accessible**

{% tabs %}
{% tab title="Using LiteLLM Directly" %}
**If running LiteLLM directly**, ensure `custom_hooks.py` is in the same directory as config.yaml:

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
**If using Docker**, mount the hook file in your docker-compose.yaml:

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
# If using Docker Compose
docker-compose restart litellm

# If using Docker run
docker restart litellm-container

# If running directly
# Stop LiteLLM (Ctrl+C) and restart:
litellm --config config.yaml
```
{% endstep %}

{% step %}
**Verify Integration**

Check that LiteLLM starts successfully with the hook:

```bash
# Check logs for hook initialization
docker-compose logs litellm | grep GuardrailsHandler

# Expected output:
# GuardrailsHandler initialized | sync_mode=True, timeout=5
```

Send a test request:

```bash
curl -X POST http://localhost:4000/chat/completions \
  -H "Authorization: Bearer YOUR_LITELLM_MASTER_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gpt-4",
    "messages": [{"role": "user", "content": "Hello!"}]
  }'
```

Then verify in the Akto dashboard:

* Log into your Akto dashboard
* Navigate to the Collections section
* Verify you see requests from LiteLLM appearing
{% endstep %}
{% endstepper %}

---

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `<!--email_off-->help@akto.io<!--/email_off-->` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
