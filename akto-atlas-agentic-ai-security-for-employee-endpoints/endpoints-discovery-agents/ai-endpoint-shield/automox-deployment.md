---
description: >-
  Deploy Akto Endpoint Shield on Windows endpoints using an Automox Worklet
  policy with a customer-specific Inno Setup installer.
---

# Automox Deployment

Deploy **Akto Endpoint Shield** to Windows laptops via an Automox **Worklet** policy. The policy checks each device and silently installs or repairs the shield when needed — no user action required.

{% hint style="info" %}
Akto ships an **Inno Setup `.exe`** (not MSI). Use a Worklet with a file payload. Start from **Automate → Worklet Catalog → EXE Software Installation (System Wide-All Users)** or create a custom Windows Worklet.
{% endhint %}

### Important: Automox runs as SYSTEM

The installer writes `config.env` to the **SYSTEM** profile. The agent reads it from the **logged-in user's** profile. The remediation script copies config to every user profile and restarts agent tasks — this is required for the agent to authenticate.

## Prerequisites

* Automox account with Worklet policy permissions
* Windows 10/11 (64-bit) devices enrolled in Automox
* Customer-specific installer from Akto (token embedded at build time)
* Network access to `https://*.akto.io` and `https://ultron.akto.io`

Email **support@akto.io** with your Akto account ID, API token, and target version to request the installer.

## Deployment Steps

{% stepper %}
{% step %}
#### Get the installer

Akto provides `akto-endpoint-shield-setup-<version>.exe` (or a customer-named build). Note the **exact file name** — you will use it in the remediation script.
{% endstep %}

{% step %}
#### Create the Worklet policy

1. **Automate → Worklet Catalog → EXE Software Installation (System Wide-All Users)** → **Create Policy**  
   Or: **Automate → Policies → Create Policy → Worklet → Windows**

2. **Info tab:** Set policy name, OS = Windows, target device group(s). Pilot a small group first.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/automox-policy-info.png" alt="Automox policy info" width="563"><figcaption><p>Policy Info — name, OS, and device groups</p></figcaption></figure></div>

3. **Payload:** Upload your `.exe` installer.

4. **Schedule:** Run once for pilot, then recurring for production. Enable _run on next check-in_ for offline devices. Do **not** restart devices after worklet completion.
{% endstep %}

{% step %}
#### Evaluation code

Paste into **Evaluation Code** only. Exit `0` = compliant, exit `1` = run remediation.

{% hint style="danger" %}
Paste **only** the PowerShell lines — not markdown fences. Evaluation and remediation are separate fields and separate processes.
{% endhint %}

```powershell
# Akto Endpoint Shield - Evaluation
# Exit 0 = compliant, Exit 1 = needs remediation

$pf64 = ${env:ProgramW6432}
if (-not $pf64) { $pf64 = "C:\Program Files" }

$binCandidates = @(
  (Join-Path $pf64 "Akto Endpoint Shield\akto-endpoint-shield.exe")
  (Join-Path $pf64 "MCP Endpoint Shield\akto-endpoint-shield.exe")
)
$binPath = $binCandidates | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1

$arp = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*" -ErrorAction SilentlyContinue |
  Where-Object { $_.DisplayName -like "*Endpoint*Shield*" -or $_.DisplayName -like "*Akto*Endpoint*" }

$agentTask = Get-ScheduledTask -TaskName "MCPEndpointShieldAgent" -ErrorAction SilentlyContinue

$userHasToken = $false
$agentHealthy = $true
Get-CimInstance Win32_UserProfile -ErrorAction SilentlyContinue | ForEach-Object {
  if ($_.Special -or -not $_.LocalPath) { return }
  if ($_.SID -notmatch '^S-1-5-21-') { return }
  $userCfg = Join-Path $_.LocalPath ".akto-endpoint-shield\config\config.env"
  if ((Test-Path -LiteralPath $userCfg) -and (Select-String -LiteralPath $userCfg -Pattern '^AKTO_API_TOKEN=' -Quiet)) {
    $userHasToken = $true
    $agentLog = Join-Path $_.LocalPath "AppData\Local\akto-endpoint-shield\logs\agent.log"
    if (-not (Test-Path -LiteralPath $agentLog)) {
      $agentHealthy = $false
      return
    }
    $startupLine = Select-String -LiteralPath $agentLog -Pattern "startup env" -ErrorAction SilentlyContinue |
      Select-Object -Last 1
    if (-not $startupLine) {
      $agentHealthy = $false
      return
    }
    if ($startupLine.Line -match 'AKTO_API_TOKEN.*\(not set\)') {
      $agentHealthy = $false
      return
    }
    $cfgTime = (Get-Item -LiteralPath $userCfg).LastWriteTime
    $logTime = (Get-Item -LiteralPath $agentLog).LastWriteTime
    if ($cfgTime -gt $logTime) {
      $agentHealthy = $false
    }
  }
}

if ($binPath -and $arp -and $agentTask -and $userHasToken -and $agentHealthy) {
  Write-Output "Compliant: $binPath"
  exit 0
}

Write-Output "Non-compliant. binary=$([bool]$binPath) task=$([bool]$agentTask) userToken=$userHasToken agentHealthy=$agentHealthy"
exit 1
```

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/automox-evaluation-code.png" alt="Automox evaluation code" width="563"><figcaption><p>Payload and Evaluation Code</p></figcaption></figure></div>
{% endstep %}

{% step %}
#### Remediation code

Paste into **Remediation Code** only. Set `$fileName` to match your uploaded installer exactly.

```powershell
# Akto Endpoint Shield - Remediation (install + config propagation)

$fileName  = "akto-endpoint-shield-setup-1.1.5.exe"
$arguments = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /LOG=C:\Windows\Temp\akto-endpoint-shield-install.log"

$pf64 = ${env:ProgramW6432}
if (-not $pf64) { $pf64 = "C:\Program Files" }

$bin1 = Join-Path $pf64 "Akto Endpoint Shield\akto-endpoint-shield.exe"
$bin2 = Join-Path $pf64 "MCP Endpoint Shield\akto-endpoint-shield.exe"

$systemCfgCandidates = @(
  (Join-Path ${env:WINDIR} "Sysnative\config\systemprofile\.akto-endpoint-shield\config\config.env")
  (Join-Path $env:SystemRoot "System32\config\systemprofile\.akto-endpoint-shield\config\config.env")
)
$systemCfg = $null
foreach ($candidate in $systemCfgCandidates) {
  if (Test-Path -LiteralPath $candidate) { $systemCfg = $candidate; break }
}
if (-not $systemCfg) { $systemCfg = $systemCfgCandidates[0] }

$binPath = $null
if (Test-Path -LiteralPath $bin1) { $binPath = $bin1 }
elseif (Test-Path -LiteralPath $bin2) { $binPath = $bin2 }

if (-not $binPath) {
  $sPath = Split-Path $script:MyInvocation.MyCommand.Path -Parent
  $fPath = Join-Path $sPath $fileName
  if (-not (Test-Path -LiteralPath $fPath)) {
    Write-Error "Installer not found: $fPath"
    exit 1
  }
  Write-Output "Running: $fPath $arguments"
  $p = Start-Process -FilePath $fPath -ArgumentList $arguments -Wait -PassThru
  if ($null -eq $p -or $p.ExitCode -ne 0) {
    Write-Error "Installer failed. ExitCode=$($p.ExitCode)"
    exit 1
  }
  $deadline = (Get-Date).AddMinutes(5)
  do {
    if (Test-Path -LiteralPath $bin1) { $binPath = $bin1; break }
    if (Test-Path -LiteralPath $bin2) { $binPath = $bin2; break }
    Start-Sleep -Seconds 15
  } while ((Get-Date) -lt $deadline)
  if (-not $binPath) {
    Write-Error "Binary missing after install. Checked: $bin1 ; $bin2"
    if (Test-Path "C:\Windows\Temp\akto-endpoint-shield-install.log") {
      Get-Content "C:\Windows\Temp\akto-endpoint-shield-install.log" -Tail 30
    }
    exit 1
  }
  Write-Output "Installed: $binPath"
  foreach ($candidate in $systemCfgCandidates) {
    if (Test-Path -LiteralPath $candidate) { $systemCfg = $candidate; break }
  }
}
else {
  Write-Output "Binary present: $binPath - running config sync"
  if (-not (Test-Path -LiteralPath $systemCfg)) {
    $sPath = Split-Path $script:MyInvocation.MyCommand.Path -Parent
    $fPath = Join-Path $sPath $fileName
    if (Test-Path -LiteralPath $fPath) {
      Write-Output "SYSTEM config missing - re-running installer"
      $p = Start-Process -FilePath $fPath -ArgumentList $arguments -Wait -PassThru
      if ($null -eq $p -or $p.ExitCode -ne 0) {
        Write-Error "Installer failed. ExitCode=$($p.ExitCode)"
        exit 1
      }
      Start-Sleep -Seconds 30
      foreach ($candidate in $systemCfgCandidates) {
        if (Test-Path -LiteralPath $candidate) { $systemCfg = $candidate; break }
      }
    }
  }
}

if (-not (Test-Path -LiteralPath $systemCfg)) {
  Write-Error "SYSTEM config missing. Checked: $($systemCfgCandidates -join ' ; ')"
  exit 1
}

Write-Output "Using SYSTEM config: $systemCfg"

$configContent = Get-Content -LiteralPath $systemCfg -Raw
$configContent = $configContent.TrimEnd()

Get-CimInstance Win32_UserProfile -ErrorAction SilentlyContinue | ForEach-Object {
  if ($_.Special -or -not $_.LocalPath) { return }
  if ($_.SID -notmatch '^S-1-5-21-') { return }
  if (-not (Test-Path -LiteralPath $_.LocalPath)) { return }

  $userCfg = Join-Path $_.LocalPath ".akto-endpoint-shield\config\config.env"
  $cfgDir = Split-Path -Parent $userCfg
  if (-not (Test-Path -LiteralPath $cfgDir)) {
    New-Item -ItemType Directory -Path $cfgDir -Force | Out-Null
  }

  $out = $configContent
  if (Test-Path -LiteralPath $userCfg) {
    $agentId = Get-Content -LiteralPath $userCfg -ErrorAction SilentlyContinue |
      Where-Object { $_ -match '^AGENT_ID=' } | Select-Object -First 1
    if ($agentId -and ($out -notlike "*AGENT_ID=*")) {
      $out = $out + [Environment]::NewLine + $agentId
    }
  }

  Set-Content -LiteralPath $userCfg -Value $out -Encoding UTF8
  Write-Output "Synced config: $userCfg"
}

$taskNames = @("MCPEndpointShieldAgent", "MCPEndpointShieldHTTP", "MCPEndpointShieldDetector")
foreach ($taskName in $taskNames) {
  $task = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue
  if (-not $task) {
    Write-Output "Task not found (skipped): $taskName"
    continue
  }
  try {
    Stop-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 3
    Start-ScheduledTask -TaskName $taskName -ErrorAction Stop
    Write-Output "Restarted: $taskName"
  }
  catch {
    & schtasks.exe /End /TN $taskName 2>$null | Out-Null
    Start-Sleep -Seconds 3
    & schtasks.exe /Run /TN $taskName 2>$null | Out-Null
    Write-Output "Restarted via schtasks: $taskName"
  }
}

Write-Output "Success: $binPath (config propagated; tasks restarted)"
exit 0
```

{% hint style="warning" %}
Update `$fileName` to your uploaded installer (e.g. `Akto-Endpoint-Shield-Comscore-1.1.5.exe`). Do not use `-Verb RunAs` — the worklet already runs as SYSTEM.
{% endhint %}
{% endstep %}

{% step %}
#### Save and run

**Save Policy**, then **Run Policy** on a pilot device.

In **Activity Log**, confirm:

* `Installed:` or `Binary present:`
* `Synced config:`
* `Restarted: MCPEndpointShieldAgent`
* Final line: `Compliant: ...` on the next evaluation run
{% endstep %}
{% endstepper %}

## Verify (optional)

On a device, confirm tasks are running and the agent has a token:

```powershell
Get-ScheduledTask -TaskName "MCPEndpointShield*" | Format-Table TaskName, State
Select-String -Path "$env:USERPROFILE\.akto-endpoint-shield\config\config.env" -Pattern "^AKTO_API_TOKEN="
Select-String -Path "$env:LOCALAPPDATA\akto-endpoint-shield\logs\agent.log" -Pattern "startup env" | Select-Object -Last 1
```

The startup log line should show the token is set (not `(not set)`).

## Hooks and system proxy

Hook installers and system proxy are **off by default**. Enable them in the **Akto dashboard** or via flags in `config.env`.

## Troubleshooting

| Issue | Fix |
| ----- | --- |
| `Unexpected token '}'` or `Get-AktoBinaryPath` not recognized | Paste only the flat scripts above — no markdown fences, no `function` blocks, separate Evaluation and Remediation fields |
| `SYSTEM config missing` | Use the remediation script above (uses `Sysnative` path for 32-bit Automox) |
| `COMMAND TIMED OUT` | Increase worklet timeout; check `C:\Windows\Temp\akto-endpoint-shield-install.log` |
| `401 Unauthorized` in agent logs | Re-run policy. Evaluation reports `userToken=False` or `agentHealthy=False`; remediation syncs config and restarts tasks |
| Token present but API returns 401 | JWT expired — request a new installer from Akto |
| New user after deploy | Recurring schedule picks them up on next run (`userToken=False`) |

## Uninstall

```powershell
$pf64 = ${env:ProgramW6432}
foreach ($dir in @("Akto Endpoint Shield", "MCP Endpoint Shield")) {
  $unins = Join-Path $pf64 "$dir\unins000.exe"
  if (Test-Path -LiteralPath $unins) { & $unins /VERYSILENT /SUPPRESSMSGBOXES /NORESTART; break }
}
```

## Related documentation

* [MDM Deployment](mdm-deployment.md)
* [README](README.md)

## Get Support

* **support@akto.io**
* In-app Intercom on the Akto dashboard
