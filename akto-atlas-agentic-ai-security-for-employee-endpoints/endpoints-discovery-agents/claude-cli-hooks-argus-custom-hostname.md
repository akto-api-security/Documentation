# Claude CLI Hooks — Argus Mode with Custom Hostname

This guide covers running Claude CLI hooks in **Argus mode** with a custom hostname. Argus mode is the standard cloud/agentic flow — hooks report activity as agentic AI traffic to your Akto dashboard. The custom hostname option lets you override the default `api.anthropic.com` host in request headers to match your Akto routing configuration.

## When to Use This

Use Argus mode with a custom hostname when:

* You are running Claude CLI on a **server or shared environment** (not an individual endpoint)
* You do **not** need device-specific identity — hooks run under a shared or service account

## How It Works

In Argus mode the hooks send a lightweight agentic payload. The `host` header identifies where the AI traffic originates:

```
Claude CLI
    │
    ▼
Hook (UserPromptSubmit / Stop / PreToolUse / PostToolUse)
    │  ┌────────────────────────────────────────────────────┐
    │  │ Request headers                                    │
    │  │   host: <AKTO_HOST or api.anthropic.com>           │
    │  │   x-claude-hook: UserPromptSubmit                  │
    │  │ Payload                                            │
    │  │   contextSource: "AGENTIC"                         │
    │  │   tags: { gen-ai: "Gen AI" }                       │
    │  └────────────────────────────────────────────────────┘
    ▼
Akto Ingestion URL  ──►  Akto Dashboard (visible under Agentic AI)
```

### Hostname Derivation

The `host` field in request headers is resolved in priority order:

| Priority | Source | Example value |
|---|---|---|
| 1 (highest) | `AKTO_HOST` env var | `my-proxy.corp.example.com` |
| 2 (fallback) | `CLAUDE_API_URL` env var (stripped of protocol) | `api.anthropic.com` |

## Setup

### Prerequisites

* Claude CLI installed ([Installation Guide](https://code.claude.com/docs/en/setup))
* Claude CLI hooks already downloaded and configured (see [Claude CLI Hooks](claude-cli-hooks.md))
* Akto instance URL and token
* Python 3.7+

### Configuration

{% stepper %}
{% step %}
**Set MODE to argus**

In each wrapper script (`~/.claude/hooks/*-wrapper.sh`), set:

```bash
export MODE="argus"
```

`argus` is also the default — if `MODE` is not set, the hooks run in Argus mode automatically.
{% endstep %}

{% step %}
**Set your custom hostname**

Set `AKTO_HOST` in each wrapper script to the hostname you want to appear in the `host` request header:

```bash
export AKTO_HOST="my-proxy.corp.example.com"
```

When set, `AKTO_HOST` overrides the value derived from `CLAUDE_API_URL`. Leave it empty to keep the default `api.anthropic.com`.
{% endstep %}

{% step %}
**Set your Akto ingestion URL and token**

```bash
export AKTO_DATA_INGESTION_URL="https://your-akto-instance.com"
export AKTO_TOKEN="your-akto-token"
```
{% endstep %}

{% step %}
**Apply changes to all four wrapper scripts**

Argus mode with a custom hostname applies to all four hook types. Ensure `MODE`, `AKTO_HOST`, `AKTO_DATA_INGESTION_URL`, and `AKTO_TOKEN` are consistent across:

* `akto-validate-prompt-wrapper.sh`
* `akto-validate-response-wrapper.sh`
* `akto-validate-mcp-request-wrapper.sh`
* `akto-validate-mcp-response-wrapper.sh`

To update all at once:

```bash
AKTO_URL="https://your-akto-instance.com"
AKTO_HOST_VALUE="my-proxy.corp.example.com"

sed -i.bak "s|{{AKTO_DATA_INGESTION_URL}}|${AKTO_URL}|g" ~/.claude/hooks/*-wrapper.sh
sed -i.bak "s|{{AKTO_HOST}}|${AKTO_HOST_VALUE}|g" ~/.claude/hooks/*-wrapper.sh
```
{% endstep %}

{% step %}
**Verify the configuration**

```bash
grep -E "^export AKTO_HOST|^export AKTO_DATA_INGESTION_URL" \
  ~/.claude/hooks/*-wrapper.sh
```

Expected output (one line per wrapper script per variable):

```
akto-validate-prompt-wrapper.sh:        export AKTO_DATA_INGESTION_URL="https://your-akto-instance.com"
akto-validate-prompt-wrapper.sh:        export AKTO_HOST="my-proxy.corp.example.com"
...
```
{% endstep %}
{% endstepper %}

## Complete Wrapper Script Example

A fully configured Argus mode wrapper script with a custom hostname:

```bash
#!/bin/bash
export MODE="argus"
export AKTO_DATA_INGESTION_URL="https://your-akto-instance.com"
export AKTO_TOKEN="your-akto-token"
export AKTO_SYNC_MODE="true"
export AKTO_TIMEOUT="5"
export AKTO_CONNECTOR="claude_code_cli"
export AKTO_HOST="my-proxy.corp.example.com"   # Custom hostname for request headers

export LOG_LEVEL="INFO"
export LOG_PAYLOADS="false"

exec python3 "$HOME/.claude/hooks/akto-validate-prompt.py" "$@"
```

## Configuration Reference

| Variable | Required | Default | Description |
|---|---|---|---|
| `MODE` | No | `argus` | Set to `argus` (or omit) for Argus mode |
| `AKTO_DATA_INGESTION_URL` | Yes | — | Your Akto instance URL |
| `AKTO_TOKEN` | Yes | — | Authorization token for Akto API |
| `AKTO_HOST` | No | `api.anthropic.com` | Custom `host` header value in requests |
| `AKTO_SYNC_MODE` | No | `true` | `true` = blocking, `false` = observe only |
| `AKTO_TIMEOUT` | No | `5` | Request timeout in seconds |
| `AKTO_CONNECTOR` | No | `claude_code_cli` | Connector identifier in the dashboard |

## Argus vs Atlas — Choosing the Right Mode

| Behavior | Argus mode | Atlas mode |
|---|---|---|
| `contextSource` in payload | `AGENTIC` | `ENDPOINT` |
| Default `host` header | `api.anthropic.com` | `{DEVICE_ID}.ai-agent.claudecli` |
| `ai-agent` tag | Not set | `claudecli` |
| Device fingerprint (`akto_vxlan_id`) | Machine ID | Machine ID (or `DEVICE_ID` override) |
| Dashboard view | **Agentic AI** | **Employee Endpoints** |
| Typical use case | Server / shared environment | Individual employee endpoint |

Use **Argus** when Claude CLI runs as a service or shared tool. Use **Atlas** when you need per-device identity tracking on employee machines.

## Verification

After setup, trigger a hook and inspect the logs:

```bash
# Run a test prompt
claude "What is 2+2?"

# Check the prompt hook log
tail -20 ~/.claude/akto/logs/validate-prompt.log
```

A successful Argus mode entry looks like:

```
INFO - MODE: argus, CLAUDE_API_URL: https://api.anthropic.com
INFO - === Hook execution started - Mode: argus, Sync: True ===
INFO - Processing prompt (length: 14 chars)
INFO - Validating prompt against guardrails
INFO - API CALL: POST https://your-akto-instance.com/api/http-proxy?guardrails=true&...
INFO - API RESPONSE: Status 200, Duration: 38ms, Size: 96 bytes
INFO - Prompt ALLOWED by guardrails
INFO - Prompt allowed
```

### Confirm custom hostname in logs

```bash
grep '"host"' ~/.claude/akto/logs/validate-prompt.log | tail -3
```

With `AKTO_HOST` set:

```json
{"host": "my-proxy.corp.example.com", "x-claude-hook": "UserPromptSubmit", ...}
```

Without `AKTO_HOST` (default):

```json
{"host": "api.anthropic.com", "x-claude-hook": "UserPromptSubmit", ...}
```

## Troubleshooting

### Custom hostname not appearing in logs

Confirm `AKTO_HOST` is exported (not just assigned) in the wrapper script:

```bash
grep "AKTO_HOST" ~/.claude/hooks/akto-validate-prompt-wrapper.sh
# Should show: export AKTO_HOST="my-proxy.corp.example.com"
```

### Events appear under Employee Endpoints instead of Agentic AI

The hooks are running in Atlas mode. Verify `MODE` is set correctly:

```bash
grep "^export MODE" ~/.claude/hooks/*-wrapper.sh
# Should show: export MODE="argus"
```

### Hooks not blocking threats

Ensure `AKTO_SYNC_MODE` is `true`:

```bash
grep "AKTO_SYNC_MODE" ~/.claude/hooks/*-wrapper.sh
```

### Connection errors to Akto

```bash
# Test connectivity
curl -s -o /dev/null -w "%{http_code}" \
  "${AKTO_DATA_INGESTION_URL}/api/http-proxy?akto_connector=claude_code_cli"

# Check token is set
grep "AKTO_TOKEN" ~/.claude/hooks/*-wrapper.sh
```
