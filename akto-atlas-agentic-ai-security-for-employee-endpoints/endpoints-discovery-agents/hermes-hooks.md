# Hermes Agent - Akto Guardrails Integration

Akto Guardrails for Hermes provides security validation for AI agent interactions. It intercepts prompts and tool calls before execution, validates against security policies, blocks risky behavior, and reports all events to your Akto dashboard.

## Key Features

* ✅ **MCP & Non-MCP Tool Support** - Validates both MCP server tools and non-MCP built-in tools
* ✅ **Real-time Protection** - Validates every prompt and tool call before execution
* ✅ **JSON-RPC Compliance** - Full JSON-RPC 2.0 support for MCP protocol
* ✅ **Device ID Tracking** - Multi-device management with unique device identifiers
* ✅ **Audit Trail** - Complete audit logging to Akto dashboard
* ✅ **Configurable Behavior** - Blocking or observation modes
* ✅ **Fail-Safe Design** - Graceful degradation if Akto server unavailable

## How It Works

Hermes plugin hooks into four critical points in the AI agent lifecycle:

```
User Input
    ↓
┌─────────────────────────────────────┐
│ pre_llm_call Hook                   │ ← Validate prompt, BLOCK if needed
│ (Runs BEFORE sending to Claude)     │
└────────────┬────────────────────────┘
             ↓ (if allowed)
        Claude LLM API
             ↓
┌─────────────────────────────────────┐
│ post_llm_call Hook                  │ ← Log response for audit
│ (Runs AFTER LLM responds)           │
└────────────┬────────────────────────┘
             ↓
       Tool Execution Request
             ↓
┌─────────────────────────────────────┐
│ pre_tool_call Hook                  │ ← Validate tool, BLOCK if needed
│ (Runs BEFORE tool execution)        │
└────────────┬────────────────────────┘
             ↓ (if allowed)
       Tool Execution
             ↓
┌──────────────────────────────────────┐
│ post_tool_call Hook                 │ ← Log result for audit
│ (Runs AFTER tool completes)         │
└──────────────────────────────────────┘
```

**4 Hook Points:**

1. `pre_llm_call` - Validates user prompts before sending to Claude LLM
2. `post_llm_call` - Logs Claude responses and audit trail
3. `pre_tool_call` - Validates tool calls (MCP and non-MCP) before execution
4. `post_tool_call` - Logs tool responses for audit trail

## File Structure

```
~/.hermes/plugins/akto-guardrails/
├── __init__.py                      # Hook handlers (4 hooks)
├── akto_client.py                   # Akto API client (validation + ingestion)
├── validators.py                    # Prompt & tool validation logic
├── config.py                        # Configuration management
├── logging_util.py                  # Logging setup
├── mcp_util.py                      # MCP tool detection
├── akto_machine_id.py               # Device ID utility
└── plugin.yaml                      # Plugin manifest
```

**Key Files:**

* **`__init__.py`**: Main plugin that registers 4 hooks with Hermes
* **`akto_client.py`**: Handles all API communication (validation + ingestion)
  - Validation calls: `/api/http-proxy?guardrails=true`
  - Ingestion calls: `/api/http-proxy?ingest_data=true`
* **`validators.py`**: Prompt and tool validation logic against Akto policies
* **`mcp_util.py`**: Detects MCP tools and converts to JSON-RPC 2.0 format
* **`akto_machine_id.py`**: Generates unique device identifiers for multi-device tracking
* **`plugin.yaml`**: Hermes plugin manifest — metadata for plugin discovery

## Setup Guide

### Prerequisites

* Hermes Agent installed and functional
* Python 3.6+ available
* Akto instance with guardrails API endpoint
* Network access to your Akto server
* Akto Data Ingestion URL (provided by your Akto admin)

### Installation Steps

#### Step 1: Obtain Plugin Files

Clone the Akto repository or download the plugin files:

```bash
# Clone repository
git clone https://github.com/akto-api-security/akto.git
cd akto/apps/mcp-endpoint-shield/hermes
```

Alternatively, download individual files from GitHub:

```bash
HERMES_BASE="https://raw.githubusercontent.com/akto-api-security/akto/master/apps/mcp-endpoint-shield/hermes"

# Create directories
mkdir -p ~/.hermes/plugins/akto-guardrails

# Download all files
for file in __init__.py akto_client.py validators.py config.py logging_util.py mcp_util.py akto_machine_id.py plugin.yaml; do
  curl -o ~/.hermes/plugins/akto-guardrails/$file "${HERMES_BASE}/${file}"
done
```

#### Step 2: Copy Plugin to Hermes

Create the plugins directory and copy all files:

```bash
# Create plugins directory if it doesn't exist
mkdir -p ~/.hermes/plugins/akto-guardrails

# Copy all production files
cp __init__.py ~/.hermes/plugins/akto-guardrails/
cp akto_client.py ~/.hermes/plugins/akto-guardrails/
cp validators.py ~/.hermes/plugins/akto-guardrails/
cp config.py ~/.hermes/plugins/akto-guardrails/
cp logging_util.py ~/.hermes/plugins/akto-guardrails/
cp mcp_util.py ~/.hermes/plugins/akto-guardrails/
cp akto_machine_id.py ~/.hermes/plugins/akto-guardrails/
cp plugin.yaml ~/.hermes/plugins/akto-guardrails/
```

**Verify installation:**

```bash
ls -la ~/.hermes/plugins/akto-guardrails/
# Should show 8 files
```

#### Step 3: Configure Akto Server URL ⚠️ **CRITICAL STEP**

Set your Akto instance URL as an environment variable:

```bash
# For bash
echo 'export AKTO_DATA_INGESTION_URL="https://your-akto-instance.com/guardrails"' >> ~/.bashrc
source ~/.bashrc

# For zsh
echo 'export AKTO_DATA_INGESTION_URL="https://your-akto-instance.com/guardrails"' >> ~/.zshrc
source ~/.zshrc
```

**Verify the URL is set:**

```bash
echo $AKTO_DATA_INGESTION_URL
# Should output: https://your-akto-instance.com/guardrails
```

{% hint style="warning" %}
This environment variable is **REQUIRED**. Without it, the plugin will run in fail-open mode (allows all execution but won't send data to Akto).
{% endhint %}

#### Step 4: Configure Hermes Plugin (Optional)

Edit or create `~/.hermes/config.yaml` for additional plugin configuration:

```yaml
# Plugin settings (optional)
plugins:
  akto-guardrails:
    enabled: true
    config:
      AKTO_SYNC_MODE: "true"      # Blocking enabled (default)
      LOG_LEVEL: "INFO"            # INFO, DEBUG, WARNING, ERROR
      LOG_PAYLOADS: "false"        # Set to "true" for verbose logging
      AKTO_TIMEOUT: "5"            # Timeout in seconds
```

**What each setting means:**

* `AKTO_SYNC_MODE: "true"` - Block risky prompts/tools (recommended)
* `AKTO_SYNC_MODE: "false"` - Logging only (no blocking)
* `LOG_LEVEL: "INFO"` - Log important events only
* `LOG_LEVEL: "DEBUG"` - Verbose logging with full payloads
* `AKTO_TIMEOUT: "5"` - Wait max 5 seconds for Akto response

#### Step 5: Configure MCP Servers (Optional)

If you use MCP servers with Hermes, add them to `~/.hermes/config.yaml`:

```yaml
mcp_servers:
  calculator:
    command: python3
    args:
      - /path/to/calculator_server.py
    env: {}
  
  git:
    command: python3
    args:
      - /path/to/git_server.py
    env: {}

agent:
  mcp_server_allowlist:
    - calculator
    - git
```

The plugin will automatically detect MCP tools (format: `server_tool`) and route them to the `/mcp` endpoint with JSON-RPC 2.0 format.

#### Step 6: Create Log Directory

```bash
mkdir -p ~/.config/hermes/akto/logs
chmod 755 ~/.config/hermes/akto/logs
```

Logs will be written to: `~/.config/hermes/akto/logs/hermes-guardrails.log`

#### Step 7: Start Hermes

Start or restart Hermes:

```bash
# Kill existing instance (if running)
pkill -f hermes 2>/dev/null || true
sleep 2

# Start Hermes
hermes
```

**Verify plugin is loaded:**

```bash
tail -f ~/.config/hermes/akto/logs/hermes-guardrails.log
# Should see plugin initialization messages
```

**Expected output:**

```
INFO - === Hermes Akto Guardrails Plugin Initializing ===
INFO - Mode: argus, Sync: True, Timeout: 5.0s
INFO - === Hermes Akto Guardrails Plugin Ready ===
INFO - Plugin hooks registered successfully!
```

#### Step 8: Verify Installation

Check all components are working:

```bash
# 1. Plugin files copied
ls -la ~/.hermes/plugins/akto-guardrails/

# 2. Akto URL configured
echo $AKTO_DATA_INGESTION_URL

# 3. Log directory created
ls -la ~/.config/hermes/akto/logs/

# 4. Test with a simple question
# In Hermes prompt: "What is 2+2?"

# 5. Check logs for activity
tail -20 ~/.config/hermes/akto/logs/hermes-guardrails.log
# Should show: [HOOK: pre_llm_call] ===== HOOK TRIGGERED =====
```

## Configuration Reference

### Environment Variables

Set these to customize the plugin behavior:

```bash
# REQUIRED
export AKTO_DATA_INGESTION_URL="https://your-akto-instance.com/guardrails"

# OPTIONAL - Authentication
export AKTO_API_TOKEN=""                    # API token sent as the Authorization header

# OPTIONAL - Behavior
export AKTO_SYNC_MODE="true"                # "true" (blocking) or "false" (logging only)
export AKTO_TIMEOUT="5"                     # Request timeout in seconds

# OPTIONAL - Logging
export LOG_LEVEL="INFO"                     # DEBUG, INFO, WARNING, ERROR
export LOG_PAYLOADS="false"                 # Set to "true" for verbose payload logging
export LOG_DIR="~/.config/hermes/akto/logs"

# OPTIONAL - Advanced
export MODE="argus"                         # "argus" (default) or "atlas"
export CONTEXT_SOURCE="ENDPOINT"            # Request classification
export AKTO_CONNECTOR="hermes"              # Connector name
```

### Hermes Plugin Settings

Edit `~/.hermes/config.yaml` to customize (optional):

```yaml
plugins:
  akto-guardrails:
    enabled: true
    config:
      AKTO_DATA_INGESTION_URL: "https://your-akto-instance.com/guardrails"
      AKTO_API_TOKEN: "your-akto-api-token"
      AKTO_SYNC_MODE: "true"
      AKTO_TIMEOUT: "5"
      LOG_LEVEL: "INFO"
      LOG_PAYLOADS: false
      MODE: "argus"
```

## Monitoring & Logs

### View Real-time Activity

```bash
# Watch all plugin activity
tail -f ~/.config/hermes/akto/logs/hermes-guardrails.log

# Filter for prompt validation
grep "pre_llm_call\|VALIDATE_PROMPT" ~/.config/hermes/akto/logs/hermes-guardrails.log

# Filter for tool validation
grep "pre_tool_call\|VALIDATE_TOOL" ~/.config/hermes/akto/logs/hermes-guardrails.log

# Filter for blocking events
grep "BLOCKED" ~/.config/hermes/akto/logs/hermes-guardrails.log

# Filter for API calls
grep "\[API\]" ~/.config/hermes/akto/logs/hermes-guardrails.log
```

### Log Format

Each log entry includes:

* **Timestamp**: When the event occurred
* **Component**: Which module generated the log (e.g., [HOOK: pre_llm_call])
* **Details**: Relevant context (session ID, tool name, validation result)

### Enable Debug Logging

For verbose logging with full payloads:

```bash
export LOG_LEVEL="DEBUG"
export LOG_PAYLOADS="true"

# Restart Hermes
pkill -f hermes
sleep 2
hermes
```

## Troubleshooting

### Plugin Not Loading

**Symptom:** No logs appear in `~/.config/hermes/akto/logs/`

**Solution:**

```bash
# Verify plugin files exist
ls -la ~/.hermes/plugins/akto-guardrails/

# Check Python is available
python3 --version

# Create log directory
mkdir -p ~/.config/hermes/akto/logs

# Check plugin.yaml syntax
python3 -c "import yaml; yaml.safe_load(open('~/.hermes/plugins/akto-guardrails/plugin.yaml'))"

# Restart Hermes with verbose output
hermes 2>&1 | grep -i "plugin\|akto\|error"
```

### Akto Server Unreachable

**Symptom:** Logs show "API CALL FAILED"

**Solution:**

```bash
# Verify URL is correct
echo $AKTO_DATA_INGESTION_URL

# Test connectivity
curl -I https://your-akto-instance.com/guardrails

# Check if Akto is running
curl -v https://your-akto-instance.com/health

# Test from within Hermes logs
grep "API\]" ~/.config/hermes/akto/logs/hermes-guardrails.log
```

### MCP Tools Not Detected

**Symptom:** MCP tool doesn't appear as `server_tool` format

**Solution:**

```bash
# Check hermes config.yaml is valid
python3 -m yaml ~/.hermes/config.yaml

# Verify MCP server is configured
grep -A10 "mcp_servers:" ~/.hermes/config.yaml

# Verify server is in allowlist
grep -A5 "mcp_server_allowlist:" ~/.hermes/config.yaml

# Restart Hermes to reload config
pkill -f hermes
sleep 2
hermes
```

### Python Import Errors

**Symptom:** Errors in logs about missing modules

**Solution:**

```bash
# Check Python version (need 3.6+)
python3 --version

# Check all files are present
ls -la ~/.hermes/plugins/akto-guardrails/*.py

# Test imports directly
python3 -c "import sys; sys.path.insert(0, '~/.hermes/plugins/akto-guardrails'); from akto_client import AktoClient; print('OK')"

# Enable debug logging
export LOG_LEVEL="DEBUG"
pkill -f hermes
sleep 2
hermes
```

### No Events in Dashboard

**Symptom:** Plugin runs but events don't appear in Akto dashboard

**Solution:**

```bash
# Verify URL is set and correct
echo $AKTO_DATA_INGESTION_URL

# Check logs for validation/ingestion
grep "API\]" ~/.config/hermes/akto/logs/hermes-guardrails.log

# Check for successful responses
grep "Status 200" ~/.config/hermes/akto/logs/hermes-guardrails.log

# Test API connectivity directly
curl -X POST "$AKTO_DATA_INGESTION_URL/api/http-proxy?akto_connector=hermes" \
  -H "Content-Type: application/json" \
  -d '{"test": "payload"}'

# Check firewall/network
ping $(echo $AKTO_DATA_INGESTION_URL | sed 's|https://||; s|/.*||')
```

## Quick Setup Summary

```bash
# 1. Create directories
mkdir -p ~/.hermes/plugins/akto-guardrails
mkdir -p ~/.config/hermes/akto/logs

# 2. Copy plugin files (from cloned repo or download from GitHub)
cp __init__.py akto_client.py validators.py config.py logging_util.py mcp_util.py akto_machine_id.py plugin.yaml ~/.hermes/plugins/akto-guardrails/

# 3. ⚠️ Set Akto URL (REQUIRED)
echo 'export AKTO_DATA_INGESTION_URL="https://your-akto-instance.com/guardrails"' >> ~/.zshrc
source ~/.zshrc

# 4. (Optional) Configure plugin in ~/.hermes/config.yaml

# 5. (Optional) Configure MCP servers in ~/.hermes/config.yaml

# 6. Restart Hermes
pkill -f hermes 2>/dev/null || true
sleep 2
hermes

# 7. Test with a simple question
# In Hermes: "What is the capital of France?"

# 8. Verify logs
tail -f ~/.config/hermes/akto/logs/hermes-guardrails.log
```

## Data Flow

### Prompt Validation & Logging

```
Hermes User Question
  ↓ (pre_llm_call hook)
Plugin validates prompt policy
  ↓
Validation call: /api/http-proxy?guardrails=true
  ↓
Akto evaluates policy
  ↓
IF BLOCKED:
  Ingestion call: /api/http-proxy?ingest_data=true
  (audit trail of blocked prompt)
  ↓
  Return DENIED to hook
  ↓
  LLM sees security notice
ELSE:
  Return ALLOWED to hook
  ↓
  Claude processes normally
  ↓
  (post_llm_call hook)
  Ingestion call: /api/http-proxy?ingest_data=true
  (audit trail of response)
```

### Tool Execution - Non-MCP Tools (e.g., web_search, terminal)

```
Hermes User wants tool
  ↓ (pre_tool_call hook)
Plugin detects: tool="web_search" (non-MCP)
  ↓
Validation call: /api/http-proxy?guardrails=true
  ↓
Akto evaluates policy
  ↓
IF BLOCKED:
  Ingestion call: /api/http-proxy?ingest_data=true
  (audit trail of blocked tool)
  ↓
  Return BLOCK action
  ↓
  Tool does NOT execute
ELSE:
  Return ALLOW action
  ↓
  Tool executes
  ↓
  (post_tool_call hook)
  Ingestion call: /api/http-proxy?ingest_data=true
  (audit trail of tool result)
```

### Tool Execution - MCP Tools (e.g., calculator_add, git_status)

```
Hermes User wants MCP tool
  ↓ (pre_tool_call hook)
Plugin detects: tool="calculator_add" (MCP format)
  ↓
Converts to JSON-RPC 2.0:
  {"jsonrpc": "2.0", "method": "tools/call", "params": {...}}
  ↓
Validation call: /api/http-proxy?guardrails=true
  (sent with path="/mcp" for MCP tools)
  ↓
Akto evaluates policy
  ↓
IF BLOCKED:
  Ingestion call: /api/http-proxy?ingest_data=true
  (audit trail of blocked MCP tool)
  ↓
  Return BLOCK action
  ↓
  Tool does NOT execute
ELSE:
  Return ALLOW action
  ↓
  Tool executes
  ↓
  (post_tool_call hook)
  Ingestion call: /api/http-proxy?ingest_data=true
  (audit trail of MCP tool result)
```

## Resources

* **GitHub**: [https://github.com/akto-api-security/akto](https://github.com/akto-api-security/akto)
* **Plugin Source**: [https://github.com/akto-api-security/akto/tree/master/apps/mcp-endpoint-shield/hermes](https://github.com/akto-api-security/akto/tree/master/apps/mcp-endpoint-shield/hermes)
* **Support**: [support@akto.io](mailto:support@akto.io)
* **Community**: [https://www.akto.io/community](https://www.akto.io/community)
