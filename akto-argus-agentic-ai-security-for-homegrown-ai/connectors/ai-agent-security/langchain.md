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
* Enforces whatever behaviour a violated policy is configured with — block, alert, or warn (see [Guardrails Behaviour Reference](#guardrails-behaviour-reference)) — in sync mode, or just logs violations in async mode
* Ingests traffic into Akto for monitoring and analysis

## Prerequisites

Before integrating Akto with LangChain, ensure you have:

* A LangChain application using `langchain` and `langgraph`
* Python 3.9+
* `httpx` package installed
* Akto guardrails service endpoint (your `AKTO_DATA_INGESTION_URL`)

***

## Option 1: LangChain Hooks (Recommended)

This approach uses Akto's `AktoGuardrailsMiddleware` — a class-based `AgentMiddleware` that intercepts model calls to enforce Akto guardrails before and after each LLM invocation.

### How It Works

The middleware hooks into two points of the LangChain agent lifecycle, and validates guardrails at **both**:

* **`before_model`** — Validates the prompt against Akto guardrails _before_ the LLM is called.
* **`after_model`** — Validates the LLM's response against Akto guardrails, then ingests the completed interaction into Akto for audit and dashboard visibility.

What happens on a violation depends on that policy's configured `behaviour` — see [Guardrails Behaviour Reference](#guardrails-behaviour-reference). Both synchronous and asynchronous agent execution modes are supported.

### Request Flow (AKTO\_SYNC\_MODE=true)

```
1. Agent invokes model call
2. before_model hook sends the prompt to Akto for validation
   ├─ behaviour=block:            ValueError raised, LLM never called
   ├─ behaviour=warn:             agent pauses, waits for a human decision
   │    ├─ approved: continue to step 3
   │    └─ declined: ValueError raised, LLM never called
   ├─ behaviour=alert:            logged server-side, continue to step 3
   └─ allowed:                    continue to step 3
3. Request forwarded to LLM provider
4. LLM response received
5. after_model hook sends the response to Akto for validation (same behaviour branching as step 2)
6. Full interaction sent to Akto for audit and dashboard display
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
# Required: Akto Data Ingestion Service URL — contact the Akto support team to get the URL for your account
AKTO_DATA_INGESTION_URL=https://<account_id>-guardrails.akto.io

# Required: Unique identifier for this LangChain application in Akto
PROJECT_NAME=my-langchain-agent

# Optional: sent as the Authorization header on every call to Akto, if set
AKTO_API_TOKEN=

# Optional: Operation mode (default: "true")
AKTO_SYNC_MODE=true        # true = enforce block/warn violations, false = async log-only

# Optional: HTTP timeout in seconds (default: "5")
AKTO_TIMEOUT=5

# Optional: Logging
LOG_LEVEL=INFO             # Logging level (default: "INFO")
LOG_PAYLOADS=true          # Log full payloads — privacy-sensitive (default: "true")
```

{% hint style="warning" %}
**Note**

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

{% hint style="info" %}
This is enough for policies whose `behaviour` is `block` or `alert`. If any policy uses `warn`, you also need a checkpointer — see [Handling Warn Verdicts](#handling-warn-verdicts) below.
{% endhint %}
{% endstep %}

{% step %}
**Verify Integration**

Run your agent and check the logs for middleware initialization:

```
AktoGuardrailsMiddleware initialized | connector=langchain sync_mode=True url=https://<account_id>-guardrails.akto.io
```

Then verify in the Akto dashboard:

* Log into your Akto dashboard
* Navigate to the Collections section
* Verify you see requests from your LangChain application appearing
{% endstep %}
{% endstepper %}

### Configuration Reference

| Variable                  | Required | Default             | Description                                                     |
| ------------------------- | -------- | ------------------- | ---------------------------------------------------------------- |
| `AKTO_DATA_INGESTION_URL` | Yes      |                     | Akto service base URL                                            |
| `PROJECT_NAME`            | Yes      |                     | Unique identifier for this LangChain application in Akto         |
| `AKTO_API_TOKEN`          | No       |                     | Sent as the `Authorization` header on every call to Akto, if set |
| `AKTO_SYNC_MODE`          | No       | `true`              | `true` to enforce block/warn violations, `false` for log-only    |
| `AKTO_TIMEOUT`            | No       | `5`                 | HTTP timeout in seconds                                          |
| `AKTO_INSTANCE_IP`        | No       | auto-detected       | Source IP recorded in proxy payloads                             |
| `LOG_LEVEL`               | No       | `INFO`              | Logging level                                                    |
| `LOG_PAYLOADS`            | No       | `true`              | Log full request/response payloads (privacy-sensitive)           |
| `LANGCHAIN_API_HOST`      | No       | `api.langchain.com` | Host header used in the proxy payload                            |
| `LANGCHAIN_API_PATH`      | No       | `/langchain/chat`   | Path used in the proxy payload                                   |
| `LANGCHAIN_MODEL`         | No       | `unknown`           | Fallback model name recorded in proxy payloads, if it can't be read off the agent's runtime |

### Guardrails Behaviour Reference

Every Akto guardrail policy has a `behaviour`, configured on the policy itself in the Akto dashboard. It determines what the middleware does when that policy is violated:

| `behaviour`         | What the middleware does                                                | What your code needs to do        |
| ------------------- | ------------------------------------------------------------------------ | ---------------------------------- |
| `block`             | Raises `ValueError` immediately, before or after the model call.         | `try`/`except ValueError`          |
| `alert`             | Proceeds — the violation is only logged server-side, nothing client-visible. | Nothing                        |
| `warn` | Pauses the agent and waits for a human to decide, via LangGraph's `interrupt()`. | See [Handling Warn Verdicts](#handling-warn-verdicts) |

### Handling Blocked Requests

When `AKTO_SYNC_MODE=true` and a request (or a declined `warn`) is blocked by guardrails, the middleware raises a `ValueError`:

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

### Handling Warn Verdicts

A `warn` verdict means: don't just block, ask a human first. That needs two extra pieces of setup that `block`/`alert` don't:

1. **A checkpointer**, passed as `create_agent(..., checkpointer=...)`. LangGraph's `interrupt()` needs somewhere to persist the paused state. `InMemorySaver()` is fine for a single process; use a durable one (Postgres, Redis, etc.) if the pause needs to survive a restart, or be answered by a different process than the one that started it.
2. **A stable `thread_id`** for the conversation, passed in `config={"configurable": {"thread_id": ...}}` on every `invoke()` and every resume call for that conversation. It's the key the checkpointer uses to find the paused state — reuse the same value you already use elsewhere to mean "this conversation," you don't need a new ID just for this. A mismatch between the call that paused and the call that resumes just means there's nothing to resume; it doesn't error.

Beyond that, **you decide how a human actually gets asked** — that's your application's concern, not something the middleware can predict. Two helper functions cover the two common shapes.

#### The interrupt payload schema

Whichever helper you use, the pause is described by this payload:

| Field       | Type | Values                                               |
| ----------- | ---- | ----------------------------------------------------- |
| `phase`     | `str` | `"request"` (checked before the LLM call) or `"response"` (checked after) |
| `behaviour` | `str` | `"warn"`                                              |
| `reason`    | `str` | The policy's violation reason                         |
| `message`   | `str` | A human-readable description of what to do next       |

#### `resolve_interrupts()` — for a CLI, or anywhere blocking is fine

```python
def resolve_interrupts(agent, result: dict, config: dict, ask_human=None) -> dict
```

Blocks the calling thread until the pause is resolved — a good fit when the human answering is right there synchronously (a terminal, a script). Given a result already obtained from `agent.invoke()`, it checks for a pending pause, calls `ask_human(payload) -> bool` (defaults to a terminal `y`/`N` prompt if you don't pass one), and resumes with `Command(resume=...)` — looping, since a single turn can pause twice (once for the request, once for the response). Raises `ValueError` if the human declines, same as a hard `block`.

```python
from akto_middleware import AktoGuardrailsMiddleware, resolve_interrupts
from langchain.agents import create_agent
from langgraph.checkpoint.memory import InMemorySaver

agent = create_agent(
    model="gpt-4.1",
    tools=[...],
    middleware=[AktoGuardrailsMiddleware()],
    checkpointer=InMemorySaver(),
)

def ask_human(payload: dict) -> bool:
    return input(f"{payload['reason']} -- proceed anyway? [y/N]: ").strip().lower() == "y"

config = {"configurable": {"thread_id": "conversation-1"}}
try:
    result = agent.invoke({"messages": [{"role": "user", "content": user_input}]}, config=config)
    result = resolve_interrupts(agent, result, config, ask_human=ask_human)  # ask_human is optional
except ValueError as e:
    print(f"Blocked by Akto Guardrails: {e}")
```

#### `interrupt_payload()` — for a web app, or anything that can't block on a human answering

```python
def interrupt_payload(result: dict) -> dict | None
```

An HTTP request can't sit there waiting for someone to click a button — they might take a minute, or an hour, in a completely separate request. `interrupt_payload(result)` just checks whether `result` has a pending pause and returns its payload (or `None`) — no blocking. Use it to split the flow across two endpoints instead of one loop: one that sends the message and returns `needs_review` immediately instead of blocking, and a second that's called whenever the human actually answers, resuming with `Command(resume=decision)`.

```python
from akto_middleware import AktoGuardrailsMiddleware, interrupt_payload
from langchain.agents import create_agent
from langgraph.checkpoint.memory import InMemorySaver
from langgraph.types import Command

agent = create_agent(
    model="gpt-4.1",
    tools=[...],
    middleware=[AktoGuardrailsMiddleware()],
    checkpointer=InMemorySaver(),
)

def handle_result(result: dict) -> dict:
    payload = interrupt_payload(result)
    if payload is not None:
        return {"status": "needs_review", **payload}
    return {"status": "ok", "reply": result["messages"][-1].content}

# First request: send the message
config = {"configurable": {"thread_id": thread_id}}
try:
    result = agent.invoke({"messages": [{"role": "user", "content": user_input}]}, config=config)
except ValueError as e:
    return {"status": "blocked", "reason": str(e)}
return handle_result(result)

# A later, separate request, once the human answers:
try:
    result = agent.invoke(Command(resume=decision), config=config)
except ValueError as e:
    return {"status": "blocked", "reason": str(e)}
return handle_result(result)
```

***

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

***

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
