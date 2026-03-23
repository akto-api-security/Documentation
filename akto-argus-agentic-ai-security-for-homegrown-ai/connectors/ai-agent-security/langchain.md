---
description: Connect Akto with LangChain
---

# LangChain

## Overview

LangChain is a framework for developing applications powered by language models. Akto provides two ways to connect with your LangChain applications:

1. **LangChain Hooks (Recommended)** — A Python middleware that plugs directly into your LangChain agent via the `AgentMiddleware` interface. It validates prompts and responses against Akto guardrails in real time.
2. **LangSmith Connector** — A cron-based connector that pulls execution traces from LangSmith for monitoring.

The Akto LangChain integration automatically:

* Validates AI requests and responses against security policies
* Detects PII, prompt injection, and policy violations
* Blocks malicious requests (sync mode) or logs violations (async mode)
* Ingests traffic into Akto for monitoring and analysis

## Prerequisites

Before integrating Akto with LangChain, ensure you have:

* A LangChain application using `langchain` and `langgraph`
* Python 3.9+
* `httpx` package installed
* Akto guardrails service endpoint (your `AKTO_DATA_INGESTION_URL`)

---

## Option 1: LangChain Hooks (Recommended)

This approach uses Akto's `AktoGuardrailsMiddleware` — a class-based `AgentMiddleware` that intercepts model calls to enforce Akto guardrails before and after each LLM invocation.

### How It Works

The middleware hooks into two points of the LangChain agent lifecycle:

* **`before_model`** — Validates the prompt against Akto guardrails _before_ the LLM is called. In sync mode, a policy violation blocks the request immediately.
* **`after_model`** — Ingests the completed interaction (prompt + response) into Akto for audit and dashboard visibility.

Both synchronous and asynchronous agent execution modes are supported.

### Request Flow (AKTO\_SYNC\_MODE=true)

```
1. Agent invokes model call
2. before_model hook intercepts the request
3. Prompt sent to Akto Data Ingestion Service for validation
   ├─ If BLOCKED: ValueError raised, LLM never called
   └─ If ALLOWED: Continue to step 4
4. Request forwarded to LLM provider
5. LLM response received
6. after_model hook intercepts the response
7. Full interaction sent to Akto for audit and dashboard display
```

### Request Flow (AKTO\_SYNC\_MODE=false)

```
1. Agent invokes model call
2. Request forwarded to LLM provider immediately (no pre-validation)
3. LLM response received
4. after_model hook sends the interaction to Akto asynchronously (log-only)
```

### Steps to Connect

{% stepper %}
{% step %}
**Install Dependencies**

Ensure the required packages are installed:

```bash
pip install httpx langchain langgraph
```
{% endstep %}

{% step %}
**Download the Middleware**

Download the `akto_middleware.py` file into your project:

```bash
curl -O https://raw.githubusercontent.com/akto-api-security/akto/master/apps/mcp-endpoint-shield/langchain-hooks/akto_middleware.py
```
{% endstep %}

{% step %}
**Configure Environment Variables**

Set the following environment variables in your shell or `.env` file:

```bash
# Required: Akto Data Ingestion Service URL
AKTO_DATA_INGESTION_URL=https://<YOUR_AKTO_INSTANCE_URL>

# Optional: Operation mode (default: "true")
AKTO_SYNC_MODE=true        # true = block violations, false = async log-only

# Optional: HTTP timeout in seconds (default: "5")
AKTO_TIMEOUT=5

# Optional: Logging
LOG_LEVEL=INFO             # Logging level (default: "INFO")
LOG_PAYLOADS=false         # Log full payloads — privacy-sensitive (default: "false")
```

{% hint style="warning" %}
#### **Note**

`AKTO_SYNC_MODE` determines behavior:

* `AKTO_SYNC_MODE=true`: Prompts are validated **before** being sent to the LLM. Policy violations raise a `ValueError` and block the request.
* `AKTO_SYNC_MODE=false`: All requests proceed immediately. Interactions are ingested after the fact for logging and audit only.
{% endhint %}
{% endstep %}

{% step %}
**Integrate the Middleware into Your Agent**

Import `AktoGuardrailsMiddleware` and pass it to your LangChain agent's middleware list:

```python
from akto_middleware import AktoGuardrailsMiddleware
from langchain.agents import create_agent

agent = create_agent(
    model="gpt-4.1",
    tools=[...],
    middleware=[AktoGuardrailsMiddleware()],
)
```

The middleware automatically handles both sync and async execution paths — no additional configuration is needed.
{% endstep %}

{% step %}
**Verify Integration**

Run your agent and check the logs for middleware initialization:

```
AktoGuardrailsMiddleware initialized | connector=langchain sync_mode=True url=https://<YOUR_AKTO_INSTANCE_URL>
```

Then verify in the Akto dashboard:

* Log into your Akto dashboard
* Navigate to the Collections section
* Verify you see requests from your LangChain application appearing
{% endstep %}
{% endstepper %}

### Configuration Reference

| Variable                | Required | Default              | Description                                        |
| ----------------------- | -------- | -------------------- | -------------------------------------------------- |
| `AKTO_DATA_INGESTION_URL` | Yes   |                      | Akto service base URL                              |
| `AKTO_SYNC_MODE`        | No       | `true`               | `true` to block on violation, `false` for log-only |
| `AKTO_TIMEOUT`          | No       | `5`                  | HTTP timeout in seconds                            |
| `LOG_LEVEL`             | No       | `INFO`               | Logging level                                      |
| `LOG_PAYLOADS`          | No       | `false`              | Log full request/response payloads (privacy-sensitive) |
| `LANGCHAIN_API_HOST`    | No       | `api.langchain.com`  | Host header used in the proxy payload              |
| `LANGCHAIN_API_PATH`    | No       | `/langchain/chat`    | Path used in the proxy payload                     |

### Handling Blocked Requests

When `AKTO_SYNC_MODE=true` and a request is blocked by guardrails, the middleware raises a `ValueError`:

```
ValueError: Blocked by Akto Guardrails: <reason>
```

You can catch this in your application to handle blocked requests gracefully:

```python
try:
    result = agent.invoke({"messages": [{"role": "user", "content": user_input}]})
except ValueError as e:
    if "Blocked by Akto Guardrails" in str(e):
        print(f"Request blocked: {e}")
```

---

## Option 2: LangSmith Connector

This approach uses a cron-based connector that pulls execution traces from LangSmith for monitoring. Use this if you are already using LangSmith and want to monitor traffic without modifying your application code.

### Steps to Connect

{% stepper %}
{% step %}
**Configure Akto Traffic Processor**

Set up and configure your Traffic Processor. The steps are mentioned [here](../others/hybrid-saas.md).
{% endstep %}

{% step %}
**Download Configuration Files**

```bash
wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/docker-compose-langchain-cron.yaml

wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/langchain-cron.env

wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/watchtower.env
```
{% endstep %}

{% step %}
**Update Environment Variables**

Update the following variables in the `langchain-cron.env` file:

```bash
LANGCHAIN_BASE_URL=https://<YOUR_LANGSMITH_URL>
LANGCHAIN_API_KEY=<API_KEY>
AKTO_KAFKA_BROKER_URL=kafka1:19092
```
{% endstep %}

{% step %}
**Start the LangChain Traffic Connector**

Run the following command to start the LangChain traffic connector:

```bash
docker compose -f docker-compose-langchain-cron.yaml up
```

This will start monitoring your LangChain applications and send API traffic data to Akto for analysis.
{% endstep %}
{% endstepper %}

### What Data is Collected?

#### Application Metadata

* All LangChain applications and traces

#### Execution Data

* Recent execution traces
* Input and output data

---

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `<!--email_off-->help@akto.io<!--/email_off-->` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
