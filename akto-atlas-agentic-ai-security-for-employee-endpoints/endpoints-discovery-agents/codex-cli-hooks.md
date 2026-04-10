# Codex CLI Hooks

Akto Guardrails for Codex CLI provides comprehensive security monitoring and validation for both **chat interactions** and **tool executions**. It intercepts prompts before sending to Codex, validates tool calls before execution, blocks risky behavior, and reports all events to your Akto dashboard.

## Key Features

* ✅ **Zero Installation** - No standalone apps to install
* ✅ **Transparent Integration** - Uses Codex CLI's native hook mechanism
* ✅ **Real-time Protection** - Validates every prompt and tool call
* ✅ **Centralized Monitoring** - All events reported to Akto dashboard
* ✅ **Flexible Deployment** - Supports Argus and Atlas modes
* ✅ **Configurable Behavior** - Blocking or observation modes
* ✅ **Auto-detected API Host** - Automatically resolves Codex API endpoint from environment

## How It Works

Codex CLI's hook system executes custom scripts at four critical points:

```mermaid
sequenceDiagram
    autonumber
    participant User
    participant PromptHook as UserPromptSubmit Hook
    participant Codex as Codex AI
    participant StopHook as Stop Hook
    participant PreToolHook as PreToolUse Hook
    participant Bash as Bash Tool
    participant PostToolHook as PostToolUse Hook
    participant Akto as Akto Dashboard

    User->>PromptHook: User submits prompt
    Note over PromptHook: Validate guardrail policies
    alt Safe Prompt
        PromptHook->>Codex: Forward to API
        PromptHook-->>Akto: Report event
    else Malicious
        PromptHook-->>User: Block
        PromptHook-->>Akto: Report security event
    end

    Codex->>StopHook: Codex response
    Note over StopHook: Ingest prompt/response pair
    StopHook-->>Akto: Report event
    StopHook->>User: Response

    Codex->>PreToolHook: Tool request (Bash)
    Note over PreToolHook: Validate tool parameters
    alt Safe Tool Call
        PreToolHook->>Bash: Execute tool
        PreToolHook-->>Akto: Report event
    else Malicious
        PreToolHook-->>Codex: Deny execution
        PreToolHook-->>Akto: Report security event
    end

    Bash->>PostToolHook: Tool result
    Note over PostToolHook: Ingest tool input/output
    PostToolHook-->>Akto: Report event
    PostToolHook->>Codex: Result
```

**4 Hook Points:**

1. `UserPromptSubmit` - Validates prompts before sending to Codex API
2. `Stop` - Ingests prompt/response pair when Codex finishes generating
3. `PreToolUse` - Validates tool requests before execution (blocks if malicious)
4. `PostToolUse` - Ingests tool input/output after execution (observational only)

> **Note:** Codex CLI currently only supports the `Bash` tool for `PreToolUse` and `PostToolUse` hooks.

## File Structure

```
~/.codex/
├── hooks.json                                  # Hook configuration
├── config.toml                                 # Codex CLI config (feature flag required)
├── hooks/
│   ├── akto-validate-prompt-wrapper.sh         # Prompt validation wrapper
│   ├── akto-validate-prompt.py                 # Prompt validation logic
│   ├── akto-validate-response-wrapper.sh       # Response ingestion wrapper
│   ├── akto-validate-response.py               # Response ingestion logic
│   ├── akto-validate-pre-tool-wrapper.sh       # Pre-tool validation wrapper
│   ├── akto-validate-pre-tool.py               # Pre-tool validation logic
│   ├── akto-validate-post-tool-wrapper.sh      # Post-tool ingestion wrapper
│   ├── akto-validate-post-tool.py              # Post-tool ingestion logic
│   └── akto_machine_id.py                      # Device ID utility
└── akto/
    └── logs/
        ├── validate-prompt.log
        ├── validate-response.log
        ├── validate-pre-tool.log
        └── validate-post-tool.log
```

**Key Files:**

* **Wrapper scripts (`.sh`)**: Set environment variables, invoke Python scripts
  * ⚠️ **Contains `AKTO_DATA_INGESTION_URL` placeholder** - Must be replaced with your Akto instance URL
* **Python scripts (`.py`)**: Core validation and ingestion logic, Akto API communication
* **`akto_machine_id.py`**: Generates unique device identifiers for Atlas mode
* **`hooks.json`**: Links hooks to wrapper scripts
* **`config.toml`**: Must enable the `codex_hooks` feature flag

## Setup Guide

### Prerequisites

* Codex CLI installed
* Akto instance URL
* Python 3.7+
* macOS, Linux, or Windows with bash/zsh

### Installation Steps

{% stepper %}
{% step %}
**Enable Codex Hooks Feature Flag**

Codex CLI hooks are experimental. Enable them in `~/.codex/config.toml`:

```toml
[features]
codex_hooks = true
```
{% endstep %}

{% step %}
**Create Directories**

```bash
mkdir -p ~/.codex/hooks
mkdir -p ~/.codex/akto/logs
```
{% endstep %}

{% step %}
**Download Hook Scripts**

```bash
# Base URL for downloading hooks
HOOKS_BASE="https://raw.githubusercontent.com/akto-api-security/akto/master/apps/mcp-endpoint-shield/codex-cli-hooks"

# Download prompt validation hooks
curl -o ~/.codex/hooks/akto-validate-prompt-wrapper.sh \
  "${HOOKS_BASE}/akto-validate-prompt-wrapper.sh"
curl -o ~/.codex/hooks/akto-validate-prompt.py \
  "${HOOKS_BASE}/akto-validate-prompt.py"

# Download response ingestion hooks
curl -o ~/.codex/hooks/akto-validate-response-wrapper.sh \
  "${HOOKS_BASE}/akto-validate-response-wrapper.sh"
curl -o ~/.codex/hooks/akto-validate-response.py \
  "${HOOKS_BASE}/akto-validate-response.py"

# Download pre-tool validation hooks
curl -o ~/.codex/hooks/akto-validate-pre-tool-wrapper.sh \
  "${HOOKS_BASE}/akto-validate-pre-tool-wrapper.sh"
curl -o ~/.codex/hooks/akto-validate-pre-tool.py \
  "${HOOKS_BASE}/akto-validate-pre-tool.py"

# Download post-tool ingestion hooks
curl -o ~/.codex/hooks/akto-validate-post-tool-wrapper.sh \
  "${HOOKS_BASE}/akto-validate-post-tool-wrapper.sh"
curl -o ~/.codex/hooks/akto-validate-post-tool.py \
  "${HOOKS_BASE}/akto-validate-post-tool.py"

# Download utility
curl -o ~/.codex/hooks/akto_machine_id.py \
  "${HOOKS_BASE}/akto_machine_id.py"

# Make executable
chmod +x ~/.codex/hooks/*.sh
```
{% endstep %}

{% step %}
**Configure Akto Ingestion URL** ⚠️ **CRITICAL STEP**

{% hint style="warning" %}
All wrapper scripts contain placeholder `{{AKTO_DATA_INGESTION_URL}}` that **must be replaced** with your actual Akto instance URL.
{% endhint %}

**Automated replacement:**

```bash
# Set your Akto ingestion URL
AKTO_URL="https://your-akto-instance.com"

# Update all wrapper scripts
sed -i.bak "s|{{AKTO_DATA_INGESTION_URL}}|${AKTO_URL}|g" ~/.codex/hooks/*-wrapper.sh

# Verify replacement
grep "AKTO_DATA_INGESTION_URL" ~/.codex/hooks/*-wrapper.sh
```

**Manual replacement (alternative):**

Edit each wrapper script and replace:

```bash
AKTO_DATA_INGESTION_URL="{{AKTO_DATA_INGESTION_URL}}"
```

With:

```bash
AKTO_DATA_INGESTION_URL="https://your-akto-instance.com"
```

Files to update:

* `akto-validate-prompt-wrapper.sh`
* `akto-validate-response-wrapper.sh`
* `akto-validate-pre-tool-wrapper.sh`
* `akto-validate-post-tool-wrapper.sh`
{% endstep %}

{% step %}
**Configure Hooks**

Copy `hooks.json` to `~/.codex/hooks.json`:

```bash
cat > ~/.codex/hooks.json << 'EOF'
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.codex/hooks/akto-validate-prompt-wrapper.sh",
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
            "command": "bash ~/.codex/hooks/akto-validate-response-wrapper.sh",
            "timeout": 10
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.codex/hooks/akto-validate-pre-tool-wrapper.sh",
            "timeout": 10
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.codex/hooks/akto-validate-post-tool-wrapper.sh",
            "timeout": 10
          }
        ]
      }
    ]
  }
}
EOF
```

> **Note:** You can also place `hooks.json` at `<repo>/.codex/hooks.json` for repository-level hooks.
{% endstep %}

{% step %}
**Configure Hook Behavior (Optional)**

Edit wrapper scripts to customize:

```bash
# In each *-wrapper.sh file:

MODE="atlas"                    # "argus" or "atlas"
AKTO_SYNC_MODE="true"          # "true" (blocking) or "false" (observe only)
AKTO_TIMEOUT="5"               # Timeout in seconds
AKTO_CONNECTOR="codex_cli"
```

**Mode Options:**

* **Argus**: Standard validation and reporting
* **Atlas**: Includes device-specific metadata

**Sync Mode:**

* **true**: Blocks threats (prompt validation + tool validation)
* **false**: Reports but allows execution
{% endstep %}

{% step %}
**Verify Installation**

Check logs to confirm hooks are working:

```bash
# Tail all logs
tail -f ~/.codex/akto/logs/*.log
```

Test by running a Codex command:

```bash
codex "What is 2+2?"
```

You should see log entries indicating validation occurred.
{% endstep %}
{% endstepper %}

## Configuration Reference

### Wrapper Script Variables

```bash
MODE="atlas"                                            # "argus" or "atlas"
AKTO_DATA_INGESTION_URL="{{AKTO_DATA_INGESTION_URL}}"  # ⚠️ MUST REPLACE
AKTO_SYNC_MODE="true"                                  # "true" or "false"
AKTO_TIMEOUT="5"                                       # Timeout in seconds
AKTO_CONNECTOR="codex_cli"                             # Connector identifier
CONTEXT_SOURCE="ENDPOINT"                              # Context source tag
LOG_LEVEL="INFO"                                       # DEBUG, INFO, WARNING, ERROR
LOG_PAYLOADS="false"                                   # Log payload previews
```

### Environment Variables (Optional)

Override defaults via environment variables in `~/.zshrc` or `~/.bashrc`:

```bash
export MODE="atlas"
export AKTO_DATA_INGESTION_URL="https://your-akto-instance.com"
export AKTO_SYNC_MODE="true"
export AKTO_TIMEOUT="5"
export DEVICE_ID=""                        # Optional: custom device ID for Atlas mode
export LOG_DIR="~/.codex/akto/logs"       # Log directory
export LOG_LEVEL="INFO"                   # Logging verbosity
export LOG_PAYLOADS="false"               # Log request/response previews
```

Then reload your shell:

```bash
source ~/.zshrc
```

### Codex API Host Auto-Detection

The Codex API host and path are automatically resolved from the same environment variables Codex CLI uses:

| Scenario | Host | Path |
| -------- | ---- | ---- |
| `OPENAI_BASE_URL` set | value of `OPENAI_BASE_URL` | `/v1/responses` |
| `OPENAI_API_KEY` set | `api.openai.com` | `/v1/responses` |
| ChatGPT browser login | `chatgpt.com` | `/backend-api/codex/responses` |

### Hook Input Fields

All hooks receive a common JSON payload on stdin, plus event-specific fields:

| Event | Additional Fields |
| ----- | ----------------- |
| `UserPromptSubmit` | `prompt` |
| `Stop` | `last_assistant_message`, `stop_hook_active` |
| `PreToolUse` | `tool_name`, `tool_use_id`, `tool_input` |
| `PostToolUse` | `tool_name`, `tool_use_id`, `tool_input`, `tool_response` |

## Troubleshooting

### Hooks Not Executing

```bash
# 1. Verify hooks feature flag is enabled
cat ~/.codex/config.toml | grep codex_hooks

# 2. Check hooks.json exists and is valid
cat ~/.codex/hooks.json | python3 -m json.tool

# 3. Verify scripts are executable
ls -la ~/.codex/hooks/
chmod +x ~/.codex/hooks/*.sh

# 4. Check Python 3 is installed
python3 --version

# 5. Check logs
tail -f ~/.codex/akto/logs/*.log
```

### Ingestion URL Not Configured

```bash
# Check if placeholder still exists
grep "{{AKTO_DATA_INGESTION_URL}}" ~/.codex/hooks/*-wrapper.sh

# Replace with actual URL
AKTO_URL="https://your-akto-instance.com"
sed -i.bak "s|{{AKTO_DATA_INGESTION_URL}}|${AKTO_URL}|g" ~/.codex/hooks/*-wrapper.sh
```

### Check Logs for Errors

```bash
# View individual logs
cat ~/.codex/akto/logs/validate-prompt.log
cat ~/.codex/akto/logs/validate-response.log
cat ~/.codex/akto/logs/validate-pre-tool.log
cat ~/.codex/akto/logs/validate-post-tool.log

# Check for API call failures
grep "API CALL FAILED" ~/.codex/akto/logs/*.log

# Check for blocked events
grep "BLOCKING" ~/.codex/akto/logs/*.log
```

### Events Not in Dashboard

```bash
# Test API connectivity
curl -X POST "${AKTO_DATA_INGESTION_URL}/api/v1/events" \
  -H "Content-Type: application/json" \
  -d '{"test": "event"}'

# Verify URL in wrapper scripts
grep "AKTO_DATA_INGESTION_URL" ~/.codex/hooks/*-wrapper.sh
```

### Service Unavailable

If Akto is unreachable:

* With `AKTO_SYNC_MODE=true`: hooks fail open and allow execution (fail-safe)
* With `AKTO_SYNC_MODE=false`: hooks skip ingestion silently

## Uninstallation

To completely remove Akto hooks from Codex CLI:

### Complete Removal

```bash
# 1. Remove hook configuration
rm ~/.codex/hooks.json

# 2. Remove Akto hook scripts
rm -rf ~/.codex/hooks/

# 3. Remove feature flag from config.toml
# Edit ~/.codex/config.toml and remove or set codex_hooks = false

# 4. Remove Akto logs (optional - keeps historical data if skipped)
rm -rf ~/.codex/akto/

# 5. No restart needed - Codex CLI reads config on each invocation
```

### Selective Removal (Keep Logs)

```bash
# Remove only hooks and configuration
rm ~/.codex/hooks.json
rm -rf ~/.codex/hooks/

# Akto logs preserved in ~/.codex/akto/
```

### Backup Before Removal

```bash
# Backup configuration and logs before removal
mkdir -p ~/akto-backup
cp ~/.codex/hooks.json ~/akto-backup/codex-hooks.json.bak 2>/dev/null
cp -r ~/.codex/akto/ ~/akto-backup/codex-akto-logs/ 2>/dev/null

# Then proceed with removal steps above
```

### Verify Removal

```bash
# Check that hooks are removed
test -f ~/.codex/hooks.json && echo "⚠️  hooks.json still exists" || echo "✅ hooks.json removed"
test -d ~/.codex/hooks && echo "⚠️  Hook scripts still exist" || echo "✅ Hook scripts removed"

# Check if logs are removed (if you chose to remove them)
test -d ~/.codex/akto && echo "ℹ️  Logs still present" || echo "✅ Logs removed"
```

### Restore Codex CLI to Default

After uninstallation, Codex CLI will operate without Akto security monitoring. Test with:

```bash
codex "Test message"
```

## Enterprise Deployment

### Automated Deployment Script

```bash
#!/bin/bash
# deploy-codex-cli-hooks.sh

set -e
AKTO_URL="${1:-https://your-akto-instance.com}"

echo "🔧 Installing Akto Guardrails for Codex CLI..."

# Enable feature flag
mkdir -p ~/.codex
if ! grep -q "codex_hooks" ~/.codex/config.toml 2>/dev/null; then
  cat >> ~/.codex/config.toml << 'EOFTOML'

[features]
codex_hooks = true
EOFTOML
fi

# Create directories
mkdir -p ~/.codex/hooks ~/.codex/akto/logs

# Download hooks
HOOKS_BASE="https://raw.githubusercontent.com/akto-api-security/akto/master/apps/mcp-endpoint-shield/codex-cli-hooks"
curl -s "${HOOKS_BASE}/akto-validate-prompt-wrapper.sh" -o ~/.codex/hooks/akto-validate-prompt-wrapper.sh
curl -s "${HOOKS_BASE}/akto-validate-prompt.py" -o ~/.codex/hooks/akto-validate-prompt.py
curl -s "${HOOKS_BASE}/akto-validate-response-wrapper.sh" -o ~/.codex/hooks/akto-validate-response-wrapper.sh
curl -s "${HOOKS_BASE}/akto-validate-response.py" -o ~/.codex/hooks/akto-validate-response.py
curl -s "${HOOKS_BASE}/akto-validate-pre-tool-wrapper.sh" -o ~/.codex/hooks/akto-validate-pre-tool-wrapper.sh
curl -s "${HOOKS_BASE}/akto-validate-pre-tool.py" -o ~/.codex/hooks/akto-validate-pre-tool.py
curl -s "${HOOKS_BASE}/akto-validate-post-tool-wrapper.sh" -o ~/.codex/hooks/akto-validate-post-tool-wrapper.sh
curl -s "${HOOKS_BASE}/akto-validate-post-tool.py" -o ~/.codex/hooks/akto-validate-post-tool.py
curl -s "${HOOKS_BASE}/akto_machine_id.py" -o ~/.codex/hooks/akto_machine_id.py

# Make executable
chmod +x ~/.codex/hooks/*.sh

# Configure URL
sed -i.bak "s|{{AKTO_DATA_INGESTION_URL}}|${AKTO_URL}|g" ~/.codex/hooks/*-wrapper.sh

# Create hooks.json
cat > ~/.codex/hooks.json << 'EOFHOOKS'
{
  "hooks": {
    "UserPromptSubmit": [
      {"hooks": [{"type": "command", "command": "bash ~/.codex/hooks/akto-validate-prompt-wrapper.sh", "timeout": 10}]}
    ],
    "Stop": [
      {"hooks": [{"type": "command", "command": "bash ~/.codex/hooks/akto-validate-response-wrapper.sh", "timeout": 10}]}
    ],
    "PreToolUse": [
      {"hooks": [{"type": "command", "command": "bash ~/.codex/hooks/akto-validate-pre-tool-wrapper.sh", "timeout": 10}]}
    ],
    "PostToolUse": [
      {"hooks": [{"type": "command", "command": "bash ~/.codex/hooks/akto-validate-post-tool-wrapper.sh", "timeout": 10}]}
    ]
  }
}
EOFHOOKS

echo "✅ Installation complete!"
echo "📍 Akto instance: ${AKTO_URL}"
echo "Test with: codex 'What is 2+2?'"
```

**Deploy to developers:**

```bash
curl -fsSL https://your-org.com/deploy-codex-cli-hooks.sh | bash -s https://your-akto-instance.com
```

## Quick Setup Summary

```bash
# 1. Enable feature flag in ~/.codex/config.toml
# [features]
# codex_hooks = true

# 2. Create directories
mkdir -p ~/.codex/hooks ~/.codex/akto/logs

# 3. Download all hook scripts from GitHub (see step 3 above)

# 4. ⚠️ Configure Akto URL (REQUIRED)
AKTO_URL="https://your-akto-instance.com"
sed -i.bak "s|{{AKTO_DATA_INGESTION_URL}}|${AKTO_URL}|g" ~/.codex/hooks/*-wrapper.sh

# 5. Make executable
chmod +x ~/.codex/hooks/*.sh

# 6. Create hooks.json (see step 5 above)

# 7. Test
codex "What is 2+2?"
```

## Resources

* **GitHub**: [https://github.com/akto-api-security/akto](https://github.com/akto-api-security/akto)
* **Support**: [support@akto.io](mailto:support@akto.io)
* **Community**: [https://www.akto.io/community](https://www.akto.io/community)
