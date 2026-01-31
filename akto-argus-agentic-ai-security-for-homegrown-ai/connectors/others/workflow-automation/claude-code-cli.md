---
description: Connect Akto with Claude Code CLI
---

# Claude Code CLI

## Overview

Claude Code (claude-code-cli) is a command-line interface that lets you use Claude for coding tasks. This setup is recommended if you want to validate prompts and responses from Claude Code against Akto guardrails and ingest traffic for monitoring and analysis.

The Akto Claude Code CLI connector automatically:

* Validates user prompts against security policies before they are sent to Claude
* Detects PII, prompt injection, and policy violations
* Ingests traffic into Akto for monitoring and analysis
* Blocks malicious prompts (sync mode) or logs violations (async mode)

## Prerequisites

Before integrating Akto with Claude Code CLI, ensure you have:

* Claude Code CLI installed and working (`claude` command available)
* Python 3 installed
* Akto data ingestion service endpoint (URL)

## Steps to Connect

{% stepper %}
{% step %}
#### Download the Hook Scripts

Create the hooks directory and download the validation scripts:

```bash
mkdir -p ~/.claude/hooks
cd ~/.claude/hooks

# Download the hook files
curl -O https://raw.githubusercontent.com/akto-api-security/akto/master/apps/mcp-endpoint-shield/claude-cli-hooks/validate-prompt.py
curl -O https://raw.githubusercontent.com/akto-api-security/akto/master/apps/mcp-endpoint-shield/claude-cli-hooks/validate-response.py
```
{% endstep %}

{% step %}
#### Configure Environment Variables

Add the following environment variables to your shell configuration file (e.g. `~/.bashrc`, `~/.zshrc`, or `~/.profile`):

```bash
# Akto Data Ingestion Service URL (required)
export AKTO_DATA_INGESTION_URL="http://your-ingestion-service-url"

# Operation mode: true = block violating prompts, false = allow but still send to Akto (default: true)
export AKTO_SYNC_MODE=true
```

Then reload your shell configuration (or open a new terminal) before running Claude Code:

```bash
source ~/.zshrc   # or source ~/.bashrc
```

{% hint style="warning" %}
### **Note**

`AKTO_SYNC_MODE` determines behavior:

* `AKTO_SYNC_MODE=true`: Prompts are validated BEFORE being sent to Claude. Violations block the prompt immediately.
* `AKTO_SYNC_MODE=false`: Prompts proceed to Claude; validation and ingestion still run for visibility in Akto.
{% endhint %}
{% endstep %}

{% step %}
#### Add Hooks to Claude CLI

Open or create `~/.claude/settings.json` and add the following. If the file already exists with other settings, add or merge the `hooks` section:

```json
{
    "hooks": {
        "UserPromptSubmit": [
            {
                "hooks": [
                    {
                        "type": "command",
                        "command": "python3 ~/.claude/hooks/validate-prompt.py",
                        "timeout": 10
                    }
                ]
            }
        ],
        "Stop": [
            {
                "hooks": [
                    {
                        "type": "command",
                        "command": "python3 ~/.claude/hooks/validate-response.py",
                        "timeout": 10
                    }
                ]
            }
        ]
    }
}
```

* **UserPromptSubmit**: Runs before each user prompt is sent to Claude. The `validate-prompt.py` script checks the prompt against Akto guardrails and can block it.
* **Stop**: Runs when a request completes. The `validate-response.py` script sends request/response data for every message to Akto for ingestion and dashboard visibility.
{% endstep %}

{% step %}
#### Restart Claude Code CLI

Ensure no Claude Code CLI process is running, then run:

```bash
claude
```
{% endstep %}

{% step %}
#### Verify Integration

1. **Send a test prompt** in Claude Code (e.g. ask a simple coding question). If guardrails block it, you should see a block message and the prompt will not be sent to Claude.
2. **Complete a request, then exit Claude Code CLI.** The Stop hook will run and send the interaction to Akto.
3. **Verify in Akto dashboard:**
   * Log into your Akto dashboard
   * Navigate to the Collections section
   * Verify you see requests from Claude Code CLI appearing
{% endstep %}
{% endstepper %}

## How It Works

### Request Flow (AKTO\_SYNC\_MODE=true)

```
1. User submits prompt in Claude Code CLI
2. UserPromptSubmit hook runs → validate-prompt.py
3. Prompt sent to Akto Data Ingestion Service API
4. Akto validates against policies
   ├─ If BLOCKED: Hook returns decision "block" → Claude never receives the prompt
   └─ If ALLOWED: Hook exits 0 → Continue to step 5
5. Prompt sent to Claude API
6. User receives response and continues or ends the request
7. On Stop: Stop hook runs → validate-response.py
8. Request/response data sent to Akto Data Ingestion Service API for the dashboard
```

### Request Flow (AKTO\_SYNC\_MODE=false)

```
1. User submits prompt in Claude Code CLI
2. Prompt immediately sent to Claude API
3. User receives response
4. On Stop: validate-response.py sends request/response to Akto Data Ingestion Service API for ingestion
```

## Environment Reference

| Variable                  | Required | Default | Description                                                                   |
| ------------------------- | -------- | ------- | ----------------------------------------------------------------------------- |
| `AKTO_DATA_INGESTION_URL` | Yes      | —       | Base URL of the Akto data ingestion service (e.g. `http://localhost:80`)      |
| `AKTO_SYNC_MODE`          | No       | `true`  | `true` = block violating prompts; `false` = allow prompts and log/ingest only |

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
