# Windows Installation

## Overview

This document covers the post-installation verification and troubleshooting of **AI Endpoint Shield** on Windows. Use it if Akto was installed but is not sending data, or stopped working after a reboot.

{% hint style="info" %}
**How to open PowerShell as Administrator:** Press `Win`, type `powershell`, right-click **Windows PowerShell**, and choose **Run as administrator**.
{% endhint %}

## Troubleshooting

{% stepper %}
{% step %}
**Run the full status check**

Paste this into an elevated PowerShell and press Enter:

```powershell
$d = "C:\Program Files\Akto Endpoint Shield"
Write-Host "--- Binary ---"
Test-Path "$d\akto-endpoint-shield.exe"
& "$d\akto-endpoint-shield.exe" --version 2>&1

Write-Host "`n--- Scheduled Tasks ---"
Get-ScheduledTask -TaskName "MCPEndpointShield*" | ForEach-Object {
    $i = $_ | Get-ScheduledTaskInfo
    [PSCustomObject]@{ Task = $_.TaskName; State = $_.State; LastResult = "0x{0:X8}" -f $i.LastTaskResult }
} | Format-Table -AutoSize

Write-Host "`n--- Processes ---"
Get-Process akto-endpoint-shield -ErrorAction SilentlyContinue | Format-Table Name,Id -AutoSize
```

Share the full output with Akto support if you need help interpreting the results.
{% endstep %}

{% step %}
**Start the services manually**

```powershell
Start-ScheduledTask -TaskName "MCPEndpointShieldHTTP"
Start-ScheduledTask -TaskName "MCPEndpointShieldAgent"
Start-ScheduledTask -TaskName "MCPEndpointShieldDetector"
Start-Sleep -Seconds 8
Get-Process akto-endpoint-shield -ErrorAction SilentlyContinue
```

| Result | Next step |
|---|---|
| Processes appear | Services are running — wait 2–3 minutes and check the Akto dashboard for a heartbeat |
| Processes start then disappear within seconds | CrowdStrike is likely terminating them — see [Whitelist Paths](whitelist-paths.md#configure-for-crowdstrike-falcon) |
| Nothing appears | Continue to the next step |
{% endstep %}

{% step %}
**Run the diagnostic script**

The diagnostic script checks everything automatically and saves a report to your Desktop.

1. Copy `diagnose_windows.ps1` and `diagnose_windows.bat` from the Akto installer package to the same folder on your machine (e.g. your Desktop).
2. Right-click `diagnose_windows.bat` → **Run as administrator**.
3. A `.txt` report file is saved to your Desktop — send this to Akto support.
{% endstep %}

{% step %}
**Run the agent directly to see errors**

If a scheduled task exits immediately, run the agent directly to capture the exact error message:

```powershell
cd "C:\Program Files\Akto Endpoint Shield"
.\akto-endpoint-shield.exe agent
```

Leave the window open and read the output:

| Message | Fix |
|---|---|
| `AKTO_API_TOKEN is not set` | Config file is missing. Re-run the installer and enter your token. |
| `AKTO_API_BASE_URL is not set` | Re-run the installer and enter your Akto dashboard URL. |
| `bind: Only one usage of each socket address` | Port is already in use. Stop existing processes first. |
| `failed to install mitmproxy` | No internet access during install. Check network and re-run the installer. |
{% endstep %}

{% step %}
**Reinstall (last resort)**

If none of the above resolves the issue:

1. Open **Add or remove programs** → find **Akto Endpoint Shield** → **Uninstall**.
2. Restart the machine.
3. Re-run the installer package received from Akto.
4. After install, wait 2–3 minutes and check the dashboard.

If the problem persists after reinstall, run the diagnostic script (Step 3) and send the report to Akto support along with what you observed.
{% endstep %}
{% endstepper %}

## Common Issues

| What you see | Fix |
|---|---|
| `Test-Path` returns `False` | Akto is not installed. Re-run the installer. |
| Task `LastResult` is `0x80070002` | Binary or launcher file is missing. Re-run the installer. |
| Task `LastResult` is `0x00000000` but no process | Binary started and exited immediately. Run the agent directly (Step 4 above). |
| Task `LastResult` is `0xC000013A` | Process was killed externally. Check CrowdStrike — see [Whitelist Paths](whitelist-paths.md). |
| Port conflict error | Another Akto instance is stuck. Run `Stop-Process -Name akto-endpoint-shield -Force` then restart the tasks. |
| No tasks listed at all | Installer did not complete. Re-run the installer as Administrator. |

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact [support@akto.io](mailto:support@akto.io) for email support.
