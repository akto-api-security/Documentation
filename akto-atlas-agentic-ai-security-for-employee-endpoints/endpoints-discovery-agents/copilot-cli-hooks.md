# Copilot Hooks

Akto Guardrails for GitHub Copilot provides security validation for AI-assisted development across VS Code and the CLI. It intercepts prompts when submitted and tool executions before and after they run, validates against security policies, blocks risky behavior, and reports events to your Akto dashboard.

## Key Features

* ✅ **Zero Installation** - No standalone apps to install
* ✅ **Transparent Integration** - Uses GitHub Copilot's native hook mechanism in both VS Code and CLI
* ✅ **Real-time Tool Blocking** - Can block dangerous tool executions before they run
* ✅ **Centralized Monitoring** - All events reported to Akto dashboard
* ✅ **Agent Registration** - Automatically registers the device (ID + username) with Akto on first hook invocation
* ✅ **Flexible Deployment** - Supports Argus and Atlas modes
* ✅ **Configurable Behavior** - Blocking or observation modes
* ✅ **Cross-platform** - Full support for macOS, Linux, and Windows (including Azure Virtual Desktop)
* ⚠️ **Prompt Monitoring Only** - GitHub Copilot limitation prevents blocking prompts at submission

## How Hooks Works

GitHub Copilot's hook system executes custom scripts at three critical points in both VS Code and the CLI:

```mermaid
sequenceDiagram
    autonumber
    participant User
    participant PromptHook as userPromptSubmitted Hook
    participant Copilot as GitHub Copilot AI
    participant PreToolHook as preToolUse Hook
    participant PostToolHook as postToolUse Hook
    participant Akto as Akto Dashboard

    User->>PromptHook: User submits prompt
    Note over PromptHook: Validate guardrail policies (monitor only)
    PromptHook-->>Akto: Report event / flag security issue
    PromptHook->>Copilot: Forward to Copilot (cannot block)

    Copilot->>PreToolHook: Copilot requests tool execution
    Note over PreToolHook: Validate tool use against policies
    alt Safe Tool Use
        PreToolHook->>Copilot: Allow tool execution
        PreToolHook-->>Akto: Report event
    else Policy Violation
        PreToolHook-->>User: Block tool execution
        PreToolHook-->>Akto: Report security event
    end

    Copilot->>PostToolHook: Tool execution completes
    Note over PostToolHook: Ingest tool result for analytics
    PostToolHook-->>Akto: Report event
    PostToolHook->>User: Result returned
```

**3 Hook Points:**

1. `userPromptSubmitted` - Monitors prompts when submitted to Copilot (reporting only, cannot block)
2. `preToolUse` - Validates tool use before execution and **can block** dangerous operations
3. `postToolUse` - Ingests tool execution results for monitoring and audit

{% hint style="warning" %}
**GitHub Copilot Limitation**: The `userPromptSubmitted` hook **cannot block** prompt execution. Prompts flagged by guardrails will still reach the LLM. Only `preToolUse` can prevent operations from executing. For complete prompt blocking, consider using a network proxy.
{% endhint %}

## File Structure

```
<project-root>/
└── .github/
    └── hooks/
        ├── akto-validate-prompt-wrapper.sh       # Prompt monitoring wrapper (macOS/Linux)
        ├── akto-validate-prompt-wrapper.ps1      # Prompt monitoring wrapper (Windows)
        ├── akto-validate-prompt.py               # Prompt monitoring logic
        ├── akto-validate-pre-tool-wrapper.sh     # Pre-tool validation wrapper (macOS/Linux)
        ├── akto-validate-pre-tool-wrapper.ps1    # Pre-tool validation wrapper (Windows)
        ├── akto-validate-pre-tool.py             # Pre-tool validation and blocking logic
        ├── akto-validate-post-tool-wrapper.sh    # Post-tool ingestion wrapper (macOS/Linux)
        ├── akto-validate-post-tool-wrapper.ps1   # Post-tool ingestion wrapper (Windows)
        ├── akto-validate-post-tool.py            # Post-tool ingestion logic
        ├── akto_machine_id.py                    # Device ID utility (macOS/Linux/Windows)
        ├── akto_heartbeat.py                     # Agent registration heartbeat
        └── hooks.json                            # Hook configuration
```

**Key Files:**

* **Wrapper scripts (`.sh` / `.ps1`)**: Set environment variables, invoke Python scripts
  * ⚠️ **Contains `AKTO_DATA_INGESTION_URL` placeholder** - Must be set to your Akto instance URL
  * ⚠️ **Contains `AKTO_API_TOKEN` placeholder** - Must be set for agent registration
  * `.sh` used on macOS/Linux; `.ps1` used on Windows
* **Python scripts (`.py`)**: Core validation logic and Akto API communication
* **`akto_machine_id.py`**: Generates unique device identifiers — uses Windows registry (`MachineGuid`) on Windows, IOPlatformUUID on macOS, `/etc/machine-id` on Linux
* **`akto_heartbeat.py`**: Sends agent registration (device ID, username, OS) to Akto on each hook invocation, rate-limited to once per 30 seconds via a local timestamp cache
* **`hooks.json`**: Links hooks to wrapper scripts — uses `bash` key on macOS/Linux and `powershell` key on Windows

> **Note:** `hooks.json` is loaded from the project root's `.github/hooks/` directory.

## Setup Guide

### Prerequisites

* **GitHub Copilot CLI** installed and authenticated — run `copilot` (macOS/Linux) or `copilot.exe` (Windows) to verify
* **VS Code** with the GitHub Copilot extension (for VS Code hook support)
* Akto instance URL
* Python 3

**macOS / Linux:** bash or zsh

**Windows:** PowerShell 5.1+ (built-in on Windows 10/11, including Azure Virtual Desktop pooled sessions)

### Installation Steps

{% stepper %}
{% step %}
**Create the Hooks Directory**

**macOS / Linux:**
```bash
mkdir -p .github/hooks
```

**Windows (PowerShell):**
```powershell
New-Item -ItemType Directory -Force -Path .github\hooks
```
{% endstep %}

{% step %}
**Download Hook Scripts**

**macOS / Linux:**
```bash
# Base URL for downloading hooks
HOOKS_BASE="https://raw.githubusercontent.com/akto-api-security/akto/master/apps/mcp-endpoint-shield/github-cli-hooks"

# Download prompt monitoring hooks
curl -o .github/hooks/akto-validate-prompt-wrapper.sh \
  "${HOOKS_BASE}/akto-validate-prompt-wrapper.sh"
curl -o .github/hooks/akto-validate-prompt.py \
  "${HOOKS_BASE}/akto-validate-prompt.py"

# Download pre-tool validation hooks
curl -o .github/hooks/akto-validate-pre-tool-wrapper.sh \
  "${HOOKS_BASE}/akto-validate-pre-tool-wrapper.sh"
curl -o .github/hooks/akto-validate-pre-tool.py \
  "${HOOKS_BASE}/akto-validate-pre-tool.py"

# Download post-tool ingestion hooks
curl -o .github/hooks/akto-validate-post-tool-wrapper.sh \
  "${HOOKS_BASE}/akto-validate-post-tool-wrapper.sh"
curl -o .github/hooks/akto-validate-post-tool.py \
  "${HOOKS_BASE}/akto-validate-post-tool.py"

# Download utilities
curl -o .github/hooks/akto_machine_id.py \
  "${HOOKS_BASE}/akto_machine_id.py"
curl -o .github/hooks/akto_heartbeat.py \
  "${HOOKS_BASE}/akto_heartbeat.py"

# Download hooks configuration
curl -o .github/hooks/hooks.json \
  "${HOOKS_BASE}/hooks.json"

# Make executable
chmod +x .github/hooks/*.py .github/hooks/*.sh
```

**Windows (PowerShell):**
```powershell
$HOOKS_BASE = "https://raw.githubusercontent.com/akto-api-security/akto/master/apps/mcp-endpoint-shield/github-cli-hooks"

$files = @(
  "akto-validate-prompt-wrapper.ps1", "akto-validate-prompt.py",
  "akto-validate-pre-tool-wrapper.ps1", "akto-validate-pre-tool.py",
  "akto-validate-post-tool-wrapper.ps1", "akto-validate-post-tool.py",
  "akto_machine_id.py", "akto_heartbeat.py", "hooks.json"
)

foreach ($file in $files) {
  Invoke-WebRequest -Uri "$HOOKS_BASE/$file" -OutFile ".github\hooks\$file"
}
```
{% endstep %}

{% step %}
**Configure URLs and API Token** ⚠️ **CRITICAL STEP**

{% hint style="warning" %}
All wrapper scripts contain two placeholders that **must be replaced** before hooks will work:
- `{{AKTO_DATA_INGESTION_URL}}` — your Akto instance URL (required for event ingestion)
- `{{AKTO_API_TOKEN}}` — your Akto API token (required for agent registration auth)

`DATABASE_ABSTRACTOR_SERVICE_URL` is built into the hooks and defaults to `https://cyborg.akto.io` automatically — no action needed for SaaS users.
{% endhint %}

**macOS / Linux — automated replacement:**

```bash
# Set your values
AKTO_URL="https://your-akto-instance.com"
AKTO_TOKEN="your-akto-api-token"

# Update all wrapper scripts
sed -i.bak "s|{{AKTO_DATA_INGESTION_URL}}|${AKTO_URL}|g" .github/hooks/*-wrapper.sh
sed -i.bak "s|{{AKTO_API_TOKEN}}|${AKTO_TOKEN}|g" .github/hooks/*-wrapper.sh

# Verify replacements
grep -E "AKTO_DATA_INGESTION_URL|AKTO_API_TOKEN" .github/hooks/*-wrapper.sh
```

**Windows (PowerShell) — automated replacement:**

```powershell
$AKTO_URL = "https://your-akto-instance.com"
$AKTO_TOKEN = "your-akto-api-token"

Get-ChildItem ".github\hooks\*-wrapper.ps1" | ForEach-Object {
  (Get-Content $_.FullName) `
    -replace '{{AKTO_DATA_INGESTION_URL}}', $AKTO_URL `
    -replace '{{AKTO_API_TOKEN}}', $AKTO_TOKEN |
    Set-Content $_.FullName
}

# Verify replacements
Select-String "AKTO_DATA_INGESTION_URL|AKTO_API_TOKEN" .github\hooks\*-wrapper.ps1
```

**Manual replacement (alternative):**

Edit each wrapper script and replace the two placeholders with your actual values.

Files to update on macOS/Linux:
* `akto-validate-prompt-wrapper.sh`
* `akto-validate-pre-tool-wrapper.sh`
* `akto-validate-post-tool-wrapper.sh`

Files to update on Windows:
* `akto-validate-prompt-wrapper.ps1`
* `akto-validate-pre-tool-wrapper.ps1`
* `akto-validate-post-tool-wrapper.ps1`
{% endstep %}

{% step %}
**Verify hooks.json Configuration**

The `hooks.json` file should already be configured after downloading. Verify it contains all three hooks:

```json
{
  "version": 1,
  "hooks": {
    "userPromptSubmitted": [
      {
        "type": "command",
        "bash": "bash ./.github/hooks/akto-validate-prompt-wrapper.sh",
        "powershell": "powershell -ExecutionPolicy Bypass -File .github/hooks/akto-validate-prompt-wrapper.ps1",
        "comment": "Validate prompts against Akto Guardrails (monitoring only - cannot block per GitHub limitation)",
        "timeoutSec": 30
      }
    ],
    "preToolUse": [
      {
        "type": "command",
        "bash": "bash ./.github/hooks/akto-validate-pre-tool-wrapper.sh",
        "powershell": "powershell -ExecutionPolicy Bypass -File .github/hooks/akto-validate-pre-tool-wrapper.ps1",
        "comment": "Validate and block tool execution based on Akto Guardrails policies",
        "timeoutSec": 30
      }
    ],
    "postToolUse": [
      {
        "type": "command",
        "bash": "bash ./.github/hooks/akto-validate-post-tool-wrapper.sh",
        "powershell": "powershell -ExecutionPolicy Bypass -File .github/hooks/akto-validate-post-tool-wrapper.ps1",
        "comment": "Ingest tool execution results to Akto for monitoring and analytics",
        "timeoutSec": 30
      }
    ]
  }
}
```

> **Windows note:** The `powershell` key is used automatically on Windows. The `.ps1` wrapper sets all required environment variables before invoking the Python script — equivalent to what the `.sh` wrappers do on macOS/Linux.

> **Note:** `timeoutSec` is in seconds (30 = 30 seconds). Hooks are loaded from `.github/hooks/hooks.json` in the directory you run copilot from.
{% endstep %}

{% step %}
**Configure Hook Behavior (Optional)**

Edit wrapper scripts to customize:

**macOS / Linux** — in each `*-wrapper.sh`:
```bash
export MODE="atlas"                                   # "argus" or "atlas"
export AKTO_DATA_INGESTION_URL="..."                 # Your Akto instance URL
export AKTO_SYNC_MODE="true"                          # "true" (blocking) or "false" (observe only)
export AKTO_TIMEOUT="5"                               # Timeout in seconds
export AKTO_CONNECTOR="github_copilot_cli"
export CONTEXT_SOURCE="ENDPOINT"
export AKTO_API_TOKEN="..."                           # Akto API token (for agent registration)
```

**Windows** — in each `*-wrapper.ps1`:
```powershell
$env:MODE = "atlas"
$env:AKTO_DATA_INGESTION_URL = "..."                 # Your Akto instance URL
$env:AKTO_SYNC_MODE = "true"
$env:AKTO_TIMEOUT = "5"
$env:AKTO_CONNECTOR = "github_copilot_cli"
$env:CONTEXT_SOURCE = "ENDPOINT"
$env:AKTO_API_TOKEN = "..."                          # Akto API token (for agent registration)
```

**Mode Options:**

* **Argus**: Standard validation and reporting
* **Atlas**: Includes device-specific metadata

**Sync Mode:**

* **true**: Validates in real-time; `preToolUse` blocks dangerous tool executions
* **false**: Monitoring only; all tool executions pass through but are logged
{% endstep %}

{% step %}
**Verify Installation**

**macOS / Linux:**
```bash
# Check hooks.json is valid JSON
python3 -m json.tool .github/hooks/hooks.json

# Verify scripts are executable
ls -la .github/hooks/

# Test a hook manually
echo '{"prompt":"test","cwd":"/test","timestamp":1704614400000}' | \
  python3 .github/hooks/akto-validate-prompt.py

# Run a Copilot command from the project root
copilot
```

**Windows (PowerShell):**
```powershell
# Check hooks.json is valid JSON
python -m json.tool .github\hooks\hooks.json

# List hook files
Get-ChildItem .github\hooks\

# Test a hook manually
'{"prompt":"test","cwd":"C:\\test","timestamp":1704614400000}' | python .github\hooks\akto-validate-prompt.py

# Run a Copilot command from the project root
copilot
```

Check logs to confirm hooks are working:

**macOS / Linux:**
```bash
# Default log location: ~/akto/.github/akto/copilot/logs/
tail -f ~/akto/.github/akto/copilot/logs/validate-prompt.log
tail -f ~/akto/.github/akto/copilot/logs/validate-pre-tool.log
tail -f ~/akto/.github/akto/copilot/logs/validate-post-tool.log
```

**Windows (PowerShell):**
```powershell
# Default log location: C:\Users\<username>\akto\.github\akto\copilot\logs\
Get-Content "$env:USERPROFILE\akto\.github\akto\copilot\logs\validate-prompt.log" -Wait -Tail 20
Get-Content "$env:USERPROFILE\akto\.github\akto\copilot\logs\validate-pre-tool.log" -Wait -Tail 20
Get-Content "$env:USERPROFILE\akto\.github\akto\copilot\logs\validate-post-tool.log" -Wait -Tail 20
```
{% endstep %}
{% endstepper %}

## Configuration Reference

### Wrapper Script Variables

```bash
export MODE="atlas"                                           # "argus" or "atlas"
export AKTO_DATA_INGESTION_URL="{{AKTO_DATA_INGESTION_URL}}" # ⚠️ MUST REPLACE — Akto instance URL
export AKTO_SYNC_MODE="true"                                  # "true" or "false"
export AKTO_TIMEOUT="5"                                       # Timeout in seconds
export AKTO_CONNECTOR="github_copilot_cli"                    # Connector identifier
export CONTEXT_SOURCE="ENDPOINT"                              # Context source tag
export AKTO_API_TOKEN="{{AKTO_API_TOKEN}}"                    # ⚠️ MUST REPLACE — API token for auth
```

| Variable | Required | Default | Description |
|---|---|---|---|
| `AKTO_DATA_INGESTION_URL` | ✅ Yes | — | Your Akto instance URL for event ingestion |
| `AKTO_API_TOKEN` | ✅ Yes | — | Akto API token used to authenticate heartbeat |
| `MODE` | No | `argus` | `argus` or `atlas` |
| `AKTO_SYNC_MODE` | No | `true` | `true` = blocking, `false` = observe only |
| `AKTO_TIMEOUT` | No | `5` | Request timeout in seconds |
| `DEVICE_ID` | No | auto-detected | Override the machine ID |
| `LOG_DIR` | No | `~/akto/.github/akto/copilot/logs` | Log directory |
| `LOG_LEVEL` | No | `INFO` | Log level (`DEBUG`, `INFO`, `WARNING`, `ERROR`) |
| `DATABASE_ABSTRACTOR_SERVICE_URL` | No | `https://cyborg.akto.io` | Override cyborg URL — self-hosted deployments only |

### Environment Variables (Optional)

Override defaults via environment variables (e.g. in `~/.bashrc` or `~/.zshrc`):

```bash
export MODE="atlas"
export AKTO_DATA_INGESTION_URL="https://your-akto-instance.com"
export AKTO_API_TOKEN="your-api-token"
export AKTO_SYNC_MODE="true"
export AKTO_TIMEOUT="5"
```

## Agent Registration

Each hook automatically registers the device with Akto on first invocation (and refreshes every 30 seconds). This mirrors the heartbeat mechanism used by the `mcp-endpoint-shield` Go agent.

**What is registered:**

| Field | Value |
|---|---|
| `moduleType` | `GITHUB_COPILOT_CLI_HOOKS` |
| `name` | Machine ID (hardware-based, persistent) |
| `additionalData.username` | System username |
| `additionalData.os` | Operating system (`Windows`, `Darwin`, `Linux`) |
| `additionalData.connector` | `github_copilot_cli` or `vscode` |

**How machine ID is resolved by platform:**

| Platform | Source |
|---|---|
| Windows | `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\MachineGuid` (registry) |
| macOS | `IOPlatformUUID` via `ioreg` |
| Linux | `/etc/machine-id` |
| Fallback | MAC address via `uuid.getnode()` |

**Rate limiting:** Registration is sent at most once every 30 seconds. The timestamp is cached in `<log_dir>/last_heartbeat`. The persistent agent ID is stored in `<log_dir>/agent_id` — this ID survives across hook invocations so the device appears as a single registered agent in the Akto dashboard.

## Troubleshooting

### Hooks Not Executing

```bash
# Check you're running from the project root
ls -la .github/hooks/hooks.json

# Verify scripts are executable
ls -la .github/hooks/
chmod +x .github/hooks/*.py .github/hooks/*.sh

# Check JSON syntax
python3 -m json.tool .github/hooks/hooks.json
```

### Ingestion URL Not Configured

**macOS / Linux:**
```bash
# Check current URL value in wrapper scripts
grep "AKTO_DATA_INGESTION_URL" .github/hooks/*-wrapper.sh

# Replace with actual URL
AKTO_URL="https://your-akto-instance.com"
sed -i.bak "s|{{AKTO_DATA_INGESTION_URL}}|${AKTO_URL}|g" .github/hooks/*-wrapper.sh
```

**Windows (PowerShell):**
```powershell
# Check current URL value
Select-String "AKTO_DATA_INGESTION_URL" .github\hooks\*-wrapper.ps1

# Replace with actual URL
$AKTO_URL = "https://your-akto-instance.com"
Get-ChildItem ".github\hooks\*-wrapper.ps1" | ForEach-Object {
  (Get-Content $_.FullName) -replace '{{AKTO_DATA_INGESTION_URL}}', $AKTO_URL |
    Set-Content $_.FullName
}
```

### Windows: Hooks Not Running

**Step 1 — Verify `.ps1` wrapper files were downloaded:**

```powershell
Get-ChildItem .github\hooks\*-wrapper.ps1
```

If missing, re-run the Windows download step above.

**Step 2 — Unblock downloaded files:**

Files downloaded via `Invoke-WebRequest` are marked as "from the internet" by Windows. Under `RemoteSigned` execution policy (default on Windows 10/11), these are blocked. Run:

```powershell
Get-ChildItem ".github\hooks\*" | Unblock-File
```

**Step 3 — Check execution policy:**

```powershell
Get-ExecutionPolicy
# If "Restricted", hooks cannot run at all.
# If "RemoteSigned", unblocking files (step 2) fixes it.
# "Bypass" or "Unrestricted" — execution policy is not the issue.
```

The `hooks.json` already includes `-ExecutionPolicy Bypass` in the `powershell` command, which overrides the policy per-invocation regardless of system settings.

### Check Logs for Errors

```bash
# View logs
cat .github/akto/copilot/logs/*.log

# Check for errors
grep -i error .github/akto/copilot/logs/*.log 2>/dev/null || true
```

### Events Not in Dashboard

```bash
# Test API connectivity
curl -X POST "${AKTO_DATA_INGESTION_URL}/api/http-proxy?akto_connector=github_copilot_cli" \
  -H "Content-Type: application/json" \
  -d '{"test": "event"}'

# Verify URL in wrapper scripts
grep "AKTO_DATA_INGESTION_URL" .github/hooks/*-wrapper.sh
```

### Hook Timing Out

Increase `timeoutSec` in `hooks.json` (value in seconds, e.g. `"timeoutSec": 60`). Ensure `AKTO_DATA_INGESTION_URL` is reachable from your machine.

### Permission Denied on Scripts

```bash
# Fix permissions
chmod +x .github/hooks/*.py .github/hooks/*.sh

# Verify Python 3 is available
python3 --version
```

## Uninstallation

### Complete Removal

```bash
# 1. Remove hook configuration and scripts
rm -rf .github/hooks/

# 2. Remove Akto logs (optional - keeps historical data if skipped)
rm -rf ~/akto-main/akto/.github/akto/

# 3. No restart needed - Copilot reads hooks.json on each invocation
```

### Selective Removal (Keep Logs)

```bash
# Remove only hooks and configuration
rm -rf .github/hooks/

# Logs preserved in ~/akto-main/akto/.github/akto/copilot/logs/
```

### Backup Before Removal

```bash
# Backup configuration and logs before removal
mkdir -p ~/akto-backup
cp -r .github/hooks/ ~/akto-backup/copilot-hooks/ 2>/dev/null
cp -r ~/akto-main/akto/.github/akto/ ~/akto-backup/copilot-akto-logs/ 2>/dev/null

# Then proceed with removal steps above
```

### Verify Removal

```bash
# Check that hooks are removed
test -f .github/hooks/hooks.json && echo "⚠️  hooks.json still exists" || echo "✅ hooks.json removed"
test -d .github/hooks && echo "⚠️  Hook scripts still exist" || echo "✅ Hook scripts removed"
```

## Enterprise Deployment

### Automated Deployment Script

**macOS / Linux:**
```bash
#!/bin/bash
# deploy-copilot-cli-hooks.sh

set -e
AKTO_URL="${1:-https://your-akto-instance.com}"
PROJECT_DIR="${2:-.}"

echo "Installing Akto Guardrails for GitHub Copilot..."

# Create directory
mkdir -p "${PROJECT_DIR}/.github/hooks"

# Download hooks
HOOKS_BASE="https://raw.githubusercontent.com/akto-api-security/akto/master/apps/mcp-endpoint-shield/github-cli-hooks"
for FILE in \
  akto-validate-prompt-wrapper.sh akto-validate-prompt.py \
  akto-validate-pre-tool-wrapper.sh akto-validate-pre-tool.py \
  akto-validate-post-tool-wrapper.sh akto-validate-post-tool.py \
  akto_machine_id.py akto_heartbeat.py hooks.json; do
  curl -s "${HOOKS_BASE}/${FILE}" -o "${PROJECT_DIR}/.github/hooks/${FILE}"
done

# Make executable
chmod +x "${PROJECT_DIR}/.github/hooks"/*.py "${PROJECT_DIR}/.github/hooks"/*.sh

# Configure placeholders
AKTO_TOKEN="${3:-}"
sed -i.bak "s|{{AKTO_DATA_INGESTION_URL}}|${AKTO_URL}|g" \
  "${PROJECT_DIR}/.github/hooks"/*-wrapper.sh
sed -i.bak "s|{{AKTO_API_TOKEN}}|${AKTO_TOKEN}|g" \
  "${PROJECT_DIR}/.github/hooks"/*-wrapper.sh

echo "Installation complete! Akto instance: ${AKTO_URL}"
echo "Test with: cd ${PROJECT_DIR} && gh copilot suggest 'list files'"
```

**Windows (PowerShell) — works on Azure Virtual Desktop pooled sessions:**
```powershell
# deploy-copilot-cli-hooks.ps1
param(
  [string]$AktoUrl = "https://your-akto-instance.com",
  [string]$ProjectDir = ".",
  [string]$AktoToken = ""
)

$HOOKS_BASE = "https://raw.githubusercontent.com/akto-api-security/akto/master/apps/mcp-endpoint-shield/github-cli-hooks"
$hooksDir = Join-Path $ProjectDir ".github\hooks"

New-Item -ItemType Directory -Force -Path $hooksDir | Out-Null

$files = @(
  "akto-validate-prompt-wrapper.ps1", "akto-validate-prompt.py",
  "akto-validate-pre-tool-wrapper.ps1", "akto-validate-pre-tool.py",
  "akto-validate-post-tool-wrapper.ps1", "akto-validate-post-tool.py",
  "akto_machine_id.py", "akto_heartbeat.py", "hooks.json"
)

foreach ($file in $files) {
  Invoke-WebRequest -Uri "$HOOKS_BASE/$file" -OutFile (Join-Path $hooksDir $file)
}

# Configure placeholders
Get-ChildItem (Join-Path $hooksDir "*-wrapper.ps1") | ForEach-Object {
  (Get-Content $_.FullName) `
    -replace '{{AKTO_DATA_INGESTION_URL}}', $AktoUrl `
    -replace '{{AKTO_API_TOKEN}}', $AktoToken |
    Set-Content $_.FullName
}

Write-Host "Installation complete! Akto instance: $AktoUrl"
Write-Host "Test with: cd $ProjectDir; gh copilot suggest 'list files'"
```

**Deploy to developers (Windows):**
```powershell
Invoke-WebRequest -Uri https://your-org.com/deploy-copilot-cli-hooks.ps1 -OutFile deploy.ps1
powershell -ExecutionPolicy Bypass -File deploy.ps1 -AktoUrl https://your-akto-instance.com -AktoToken your-akto-api-token -ProjectDir C:\path\to\project
```

## Quick Setup Summary

```bash
# 1. Create directory (from your project root)
mkdir -p .github/hooks

# 2. Download all hook scripts from GitHub (see step 2 above)

# 3. ⚠️ Configure placeholders (REQUIRED)
AKTO_URL="https://your-akto-instance.com"
AKTO_TOKEN="your-akto-api-token"
sed -i.bak "s|{{AKTO_DATA_INGESTION_URL}}|${AKTO_URL}|g" .github/hooks/*-wrapper.sh
sed -i.bak "s|{{AKTO_API_TOKEN}}|${AKTO_TOKEN}|g" .github/hooks/*-wrapper.sh

# 4. Make executable
chmod +x .github/hooks/*.py .github/hooks/*.sh

# 5. Verify hooks.json is present and valid
python3 -m json.tool .github/hooks/hooks.json

# 6. Test (run from project root)
copilot
```

## Resources

* **GitHub Copilot CLI**: [https://github.com/features/copilot/cli](https://github.com/features/copilot/cli)
* **GitHub**: [https://github.com/akto-api-security/akto](https://github.com/akto-api-security/akto)
* **Support**: [<!--email_off-->support@akto.io<!--/email_off-->](mailto:<!--email_off-->support@akto.io<!--/email_off-->)
* **Community**: [https://www.akto.io/community](https://www.akto.io/community)
