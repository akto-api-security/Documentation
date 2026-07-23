# Windows Installation

## Overview

This page covers post-installation **validation and troubleshooting** of **AI Endpoint Shield** on Windows — checking the version, processes and scheduled tasks, where config lives, the logs the agent writes, verifying IDE hooks, and common fixes. Use it if Akto was installed but is not sending data, or stopped working after a reboot.

{% hint style="info" %}
**Everything below is read-only unless a section says otherwise** — safe to run at any time without disrupting a working install.

**How to open PowerShell as Administrator:** press `Win`, type `powershell`, right-click **Windows PowerShell**, and choose **Run as administrator**. Most checks below need this.
{% endhint %}

## 30-second health check

Paste this into an elevated PowerShell window:

```powershell
$d = "C:\Program Files\Akto Endpoint Shield"

Write-Host "`n--- Version ---"
& "$d\akto-endpoint-shield.exe" --version 2>&1

Write-Host "`n--- Scheduled tasks ---"
Get-ScheduledTask -TaskName "MCPEndpointShield*" | ForEach-Object {
    $i = $_ | Get-ScheduledTaskInfo
    [PSCustomObject]@{ Task = $_.TaskName; State = $_.State; LastResult = "0x{0:X8}" -f $i.LastTaskResult }
} | Format-Table -AutoSize

Write-Host "--- Running processes ---"
Get-Process akto-endpoint-shield -ErrorAction SilentlyContinue | Format-Table Name, Id, StartTime -AutoSize

Write-Host "--- Config status ---"
$cfgDir = "$env:SystemRoot\System32\config\systemprofile\.akto-endpoint-shield\config"
& "$d\akto-endpoint-shield.exe" check-config --path $cfgDir
```

A healthy result looks like:

* A version string (e.g. `akto-endpoint-shield version v1.1.134`), not an error
* `MCPEndpointShieldHTTP`, `MCPEndpointShieldAgent`, `MCPEndpointShieldDetector` all show `Running` or `Ready` with `LastResult` `0x00000000` (`MCPEndpointShieldSystemProxy` may show `Ready`/stopped — it's an optional feature, see [System-wide proxy](#system-wide-proxy-optional))
* At least one `akto-endpoint-shield` process listed
* Config status prints `provisioned`

If any of these don't match, keep reading — the matching section explains what to check, and [Common issues and fixes](#common-issues-and-fixes) has a quick symptom → fix table.

## Checking the installed version

```powershell
& "C:\Program Files\Akto Endpoint Shield\akto-endpoint-shield.exe" --version
```

This prints immediately, before anything else the agent does, so it works even if config or the network is broken. If it errors instead of printing a version, the binary itself is missing, blocked, or corrupted — see [Install location and files](#install-location-and-files).

## Install location and files

Default install folder:

```
C:\Program Files\Akto Endpoint Shield\
```

Quick presence + integrity check:

```powershell
$d = "C:\Program Files\Akto Endpoint Shield"
Test-Path "$d\akto-endpoint-shield.exe"
Get-Item "$d\akto-endpoint-shield.exe" | Select-Object Length, LastWriteTime
Get-AuthenticodeSignature "$d\akto-endpoint-shield.exe" | Select-Object Status
Get-Item "$d\akto-endpoint-shield.exe" -Stream Zone.Identifier -ErrorAction SilentlyContinue
```

* `Test-Path` returning `False` means Akto isn't installed (or was installed to a different location) — re-run the installer.
* If the last command (`Zone.Identifier`) returns a result instead of an error, the file is flagged by Windows as downloaded from the internet ("Mark of the Web"), which can cause SmartScreen/UAC to block it. Fix:

  ```powershell
  Unblock-File -LiteralPath "C:\Program Files\Akto Endpoint Shield\akto-endpoint-shield.exe"
  ```

If you previously had an older **MCP Endpoint Shield** install (the product's old name) at `C:\Program Files\MCP Endpoint Shield`, that's expected to be gone after an update — the installer removes it automatically.

## Scheduled tasks

Akto runs as four scheduled tasks (all named `MCPEndpointShield*`, registered to run as `SYSTEM` at startup):

| Task | What it does |
|---|---|
| `MCPEndpointShieldHTTP` | Local HTTP service the agent uses internally |
| `MCPEndpointShieldAgent` | Main background agent — heartbeats to the dashboard, applies config/policy changes, keeps IDE hooks up to date |
| `MCPEndpointShieldDetector` | Detects which AI tools/IDEs are installed on the machine |
| `MCPEndpointShieldSystemProxy` | Optional system-wide HTTPS inspection proxy — only relevant if your organization has this feature turned on (see [System-wide proxy](#system-wide-proxy-optional)) |

Check status and last result:

```powershell
Get-ScheduledTask -TaskName "MCPEndpointShield*" | ForEach-Object {
    $i = $_ | Get-ScheduledTaskInfo
    [PSCustomObject]@{
        Task        = $_.TaskName
        State       = $_.State
        LastRunTime = $i.LastRunTime
        LastResult  = "0x{0:X8}" -f $i.LastTaskResult
    }
} | Format-Table -AutoSize
```

`State` should be `Running` or `Ready` — never `Disabled`. Common `LastResult` codes:

| LastResult | Meaning |
|---|---|
| `0x00000000` | Success |
| `0x00000002` | File not found — binary or launcher script is missing, reinstall |
| `0x00000005` | Access denied — check with your security team if an EDR/antivirus tool is blocking it |
| `0x00041301` | Task is currently running (normal, transient) |
| `0x00041303` | Task has not run yet (normal right after install) |
| `0xC000013A` | Process was terminated externally — usually antivirus/EDR killing it, see [Whitelist Paths](whitelist-paths.md#configure-for-crowdstrike-falcon) if CrowdStrike is in use |
| `0x80070001` | PowerShell execution policy (a Group Policy restriction) is blocking the script at startup — contact your IT admin |

If a task shows `Ready` but never seems to have run, or you just changed something and want to restart everything immediately:

```powershell
Get-ScheduledTask -TaskName "MCPEndpointShield*" | Stop-ScheduledTask -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2
Start-ScheduledTask -TaskName "MCPEndpointShieldHTTP"
Start-ScheduledTask -TaskName "MCPEndpointShieldAgent"
Start-ScheduledTask -TaskName "MCPEndpointShieldDetector"
```

**After a reboot**, all three core tasks (`HTTP`, `Agent`, `Detector`) should show a `LastRunTime` at or after your last boot time:

```powershell
(Get-CimInstance Win32_OperatingSystem).LastBootUpTime
Get-ScheduledTask -TaskName "MCPEndpointShield*" | Get-ScheduledTaskInfo | Select-Object TaskName, LastRunTime
```

If a task's `LastRunTime` is older than the boot time, it didn't auto-start — see [Common issues and fixes](#common-issues-and-fixes).

## Running processes

```powershell
Get-Process akto-endpoint-shield -ErrorAction SilentlyContinue | Format-Table Name, Id, StartTime, CPU -AutoSize
```

You should normally see 2–3 `akto-endpoint-shield.exe` processes (one per running task above). If nothing appears:

* Start the tasks manually (command in [Scheduled tasks](#scheduled-tasks)) and re-check after a few seconds.
* If a process appears and then disappears within a few seconds every time, something is killing it immediately after launch — most commonly an antivirus/EDR tool. See [Whitelist Paths](whitelist-paths.md).

To see the exact error a task would hit (useful when a task starts and immediately exits), run the agent directly in the foreground:

```powershell
cd "C:\Program Files\Akto Endpoint Shield"
.\akto-endpoint-shield.exe agent
```

Leave the window open, read the first few lines of output, then press `Ctrl+C` to stop it. Common messages:

| Message | Meaning / fix |
|---|---|
| `AKTO_API_TOKEN is not set` | Config is missing or unreadable — see [Config values and location](#config-values-and-location) |
| `AKTO_API_BASE_URL is not set` | Same as above |
| `bind: Only one usage of each socket address` | Another Akto process is already using that port — stop existing processes first (`Stop-Process -Name akto-endpoint-shield -Force`), then restart the tasks |
| `failed to install mitmproxy` | No internet access during install — check network and re-run the installer |

## Config values and location

Akto stores its configuration (your account token, dashboard URL, and feature on/off switches) **encrypted on disk**, using Windows' own built-in machine-level encryption (DPAPI) — the file is not human-readable, and only processes on that same machine can decrypt it.

**File locations** (the same encrypted file is kept in more than one place so both your user session and the background SYSTEM tasks can each read their own copy):

| Where | Path |
|---|---|
| Your user profile | `%USERPROFILE%\.akto-endpoint-shield\config\config.env.enc` |
| SYSTEM (used by the scheduled tasks) | `C:\Windows\System32\config\systemprofile\.akto-endpoint-shield\config\config.env.enc` |

On a device that hasn't been updated in a while you may instead see a plain `config.env` file next to it — same idea, older format, still supported.

**Check whether config is present and valid** (does not print any secret values):

```powershell
$d = "C:\Program Files\Akto Endpoint Shield"
& "$d\akto-endpoint-shield.exe" check-config --path "$env:SystemRoot\System32\config\systemprofile\.akto-endpoint-shield\config"
```

| Output | Meaning |
|---|---|
| `provisioned` (exit code `0`) | Healthy — token and settings are present and readable |
| `not-provisioned` (exit code `2`) | Device was never given credentials — re-run the installer with your Akto token |
| `undecryptable` (exit code `3`) | Config file exists but can't be decrypted (e.g. after restoring from a different machine's backup/image) — this device needs to be reinstalled/reprovisioned, it cannot be repaired in place |

**Reading a specific (non-secret) value**, e.g. to confirm which dashboard URL or device ID this machine is registered under:

```powershell
& "C:\Program Files\Akto Endpoint Shield\akto-endpoint-shield.exe" get-config --path "$env:SystemRoot\System32\config\systemprofile\.akto-endpoint-shield\config" AKTO_API_BASE_URL AGENT_ID
```

{% hint style="danger" %}
**Do not run `get-config ... AKTO_API_TOKEN`** and paste the output anywhere (screenshots, tickets, chat) — that value is your account's secret credential. If Akto support needs to confirm the token, they can verify it against your account without you ever displaying it.
{% endhint %}

**Config keys you may be asked about:**

| Key | What it is |
|---|---|
| `AKTO_API_TOKEN` | Your organization's Akto account credential (secret — never share) |
| `AKTO_API_BASE_URL` | Your Akto dashboard's URL for this account |
| `AGENT_ID` | This device's unique identifier, shown on the Akto dashboard |
| `ENABLE_PROMPT_HOOKS_*` / `ENABLE_MCP_HOOKS_*` | Per-IDE switches for whether guardrail hooks are installed for that tool (on by default) |
| `ENABLE_SYSTEM_PROXY` | Whether the optional system-wide HTTPS proxy is turned on (off by default) |

**Cross-checking this device's identity against the dashboard:**

```powershell
$machineGuid = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Cryptography' -Name MachineGuid).MachineGuid
$guidPrefix = ($machineGuid -replace '-', '').ToLower().Substring(0, 8)
$hostNorm = ($env:COMPUTERNAME -replace '[^a-zA-Z0-9]', '-')
"$hostNorm-$guidPrefix"
```

This should match the device label shown for this machine in the Akto dashboard.

## Logs

All logs below are plain text and safe to open in Notepad.

| Log | Location | What's in it |
|---|---|---|
| Install log | `%USERPROFILE%\.akto-endpoint-shield\logs\install.log` (also briefly at `C:\ProgramData\akto-endpoint-shield\logs\install.log` before a user profile is detected) | Full step-by-step output of the last install/update run, including every IDE hook installer's own output |
| Agent (background service) | `C:\ProgramData\akto-endpoint-shield\logs\agent-wrapper.log` | Startup/exit history for the `MCPEndpointShieldAgent` task |
| HTTP service | `C:\ProgramData\akto-endpoint-shield\logs\http-wrapper.log` | Startup/exit history for the `MCPEndpointShieldHTTP` task |
| Detector | `C:\ProgramData\akto-endpoint-shield\logs\detect-wrapper.log` | Startup/exit history for the `MCPEndpointShieldDetector` task |
| System proxy | `C:\ProgramData\akto-endpoint-shield\logs\system-proxy.log` (or `%LOCALAPPDATA%\akto-endpoint-shield\logs\system-proxy.log` once a user is logged in) | Only present if the optional proxy feature is enabled |
| Auto-update / self-heal detection | `C:\ProgramData\akto-endpoint-shield\logs\remediation-detect.log` | Result of each scheduled health check (runs automatically every few hours) |
| Auto-update / self-heal action | `C:\ProgramData\akto-endpoint-shield\logs\remediation-remediate.log` | What happened the last time a health check found and fixed an issue (e.g. installed a new version) |

View the most recent activity in any of them:

```powershell
Get-Content "C:\ProgramData\akto-endpoint-shield\logs\agent-wrapper.log" -Tail 40
```

**Hook installation logs** — there's no separate file per IDE; each IDE's hook installer writes its output into `install.log` above, prefixed with its script name. To see just the hook-related lines from the last install/update:

```powershell
Get-Content "$env:USERPROFILE\.akto-endpoint-shield\logs\install.log" | Select-String "hook", "Hook"
```

**Hook execution (prompt block/allow) logs** — when a hook actually blocks or allows something in your IDE in real time, that decision is recorded on the **Akto dashboard**, not in a local file on this machine.

{% hint style="info" %}
These logs never contain your API token — safe to share with Akto support without redacting anything.
{% endhint %}

## Verifying IDE hooks

Akto installs guardrail "hooks" into each supported IDE/CLI so it can inspect prompts and tool calls. Run the check for whichever tools you use:

| Tool | Check |
|---|---|
| Claude Code | `Get-Content "$env:USERPROFILE\.claude\settings.json" \| Select-String "akto"` |
| Cursor | `(Get-Content "$env:USERPROFILE\.cursor\hooks.json" \| ConvertFrom-Json).hooks.beforeSubmitPrompt` |
| GitHub Copilot CLI | `Test-Path "$env:USERPROFILE\.github\hooks\hooks.json"` |
| VS Code Copilot | `Test-Path "$env:USERPROFILE\.copilot\hooks\akto-hooks.json"` |
| Codex CLI | `Get-Content "$env:USERPROFILE\.codex\config.toml" \| Select-String "codex_hooks"` |
| Gemini CLI | `Test-Path "$env:USERPROFILE\.gemini\settings.json"` |
| OpenCode | Look for `akto-guardrails-plugin.js` under `%APPDATA%\OpenCode\plugin`, `%USERPROFILE%\.config\opencode\plugin`, or `%LOCALAPPDATA%\opencode\plugin` |

A result (a JSON block, `True`, or a matching line) means the hook is installed. No result / `False` means that tool's hooks weren't installed — because the tool wasn't detected on the machine, its feature switch (`ENABLE_PROMPT_HOOKS_*`, see [Config values and location](#config-values-and-location)) is off for your account, or the install needs to be re-run for that tool.

**If hooks worked before and stopped working** (e.g. after editing IDE settings yourself), the background agent (`MCPEndpointShieldAgent` task) automatically re-checks and restores them — no action needed, wait for its next check-in cycle (typically a few minutes), or restart the task to force it immediately:

```powershell
Restart-ScheduledTask -TaskName "MCPEndpointShieldAgent" -ErrorAction SilentlyContinue
```

## System-wide proxy (optional)

Some accounts have an optional feature enabled where Akto routes AI-tool traffic through a local HTTPS-inspecting proxy. This only applies if your organization has turned it on. Check whether it's active:

```powershell
Get-ScheduledTask -TaskName "MCPEndpointShieldSystemProxy" | Select-Object State
Test-Path "C:\ProgramData\akto-endpoint-shield\venv\Scripts\mitmdump.exe"
Get-ChildItem Cert:\LocalMachine\Root | Where-Object { $_.Subject -like "*mitmproxy*" }
```

If the task is `Ready` (not running) and no certificate is listed, the feature is simply not enabled for your account — this is normal and not an error.

If it **is** enabled but the certificate isn't trusted (browser/tool warnings about an untrusted certificate), re-import it:

```powershell
Import-Certificate -FilePath "C:\ProgramData\akto-endpoint-shield\mitmproxy-conf\mitmproxy-ca-cert.pem" `
    -CertStoreLocation Cert:\LocalMachine\Root
```

## Common issues and fixes

| Symptom | Likely cause | Fix |
|---|---|---|
| Device not appearing on the dashboard | Not provisioned, or token mismatch between your user profile and SYSTEM | Run the config check in [Config values and location](#config-values-and-location) for both profile locations; re-run installer if `not-provisioned` |
| Tasks show `Running`/`Ready` but no processes | Antivirus/EDR terminating the process immediately | Use the foreground-run test in [Running processes](#running-processes); see [Whitelist Paths](whitelist-paths.md#configure-for-crowdstrike-falcon) if CrowdStrike is in use |
| Everything worked, then stopped after a reboot | Task didn't auto-start, or config mismatch (SYSTEM profile missing token the user profile has) | Run the reboot check in [Scheduled tasks](#scheduled-tasks); copy config from user profile to SYSTEM profile (see below) |
| A specific IDE's hooks aren't showing up | That tool wasn't detected, its feature flag is off, or hooks need reinstalling | [Verifying IDE hooks](#verifying-ide-hooks) |
| `check-config` reports `undecryptable` | Device was cloned/restored from another machine's disk image | Reinstall — this can't be repaired in place |
| Binary blocked by Windows / SmartScreen | File flagged as downloaded ("Mark of the Web") | `Unblock-File` command in [Install location and files](#install-location-and-files) |
| Port conflict error | Another Akto instance is stuck | `Stop-Process -Name akto-endpoint-shield -Force`, then restart the tasks |
| No tasks listed at all | Installer did not complete | Re-run the installer as Administrator |

**Copying config from your user profile to the SYSTEM profile** (fixes the common "works when I run it manually, not after reboot" case):

```powershell
$src  = "$env:USERPROFILE\.akto-endpoint-shield\config"
$dest = "C:\Windows\System32\config\systemprofile\.akto-endpoint-shield\config"
New-Item -ItemType Directory -Force -Path $dest | Out-Null
foreach ($name in @('config.env.enc', 'config.env')) {
    if (Test-Path (Join-Path $src $name)) { Copy-Item (Join-Path $src $name) (Join-Path $dest $name) -Force; break }
}
```

## Full automated diagnostic

For a single comprehensive report covering everything above plus antivirus/EDR conflicts, PowerShell execution-policy restrictions, and event log history:

1. Get `diagnose_windows.ps1` and `diagnose_windows.bat` (included in the Akto installer package, or ask Akto support for them).
2. Put both files in the same folder (e.g. your Desktop).
3. Right-click `diagnose_windows.bat` → **Run as administrator**.
4. A report file named like `akto-diag-20260722-143000.txt` is saved to your Desktop, along with a PASS/WARN/FAIL summary and copy-paste "quick fix" hints printed at the end.

This script only reads information from your machine — it does not change any settings — and does not print your API token.

## Reinstall / uninstall (last resort)

If nothing above resolves the issue:

1. Open **Settings → Apps → Installed apps** (or **Add or remove programs**), find **Akto Endpoint Shield**, and **Uninstall**.
2. Restart the machine.
3. Re-run the installer package provided by your IT team / Akto.
4. Wait 2–3 minutes, then check the dashboard for the device to reappear.

If the problem persists after reinstall, run the diagnostic script above and send the report to Akto support along with what you observed.

## Get Support for your Akto setup

When contacting Akto support, include the diagnostic report (`akto-diag-*.txt`), the installed version, and what you observed and when it started. **Never** include the raw `AKTO_API_TOKEN` value in a ticket, chat, or screenshot.

There are multiple ways to request support from Akto:

1. In-app `intercom` support. Message us with your query on intercom in the Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact [support@akto.io](mailto:support@akto.io) for email support.
</content>
</invoke>
