# NinjaOne Deployment (Windows)

## Overview

Deploy **Akto Endpoint Shield** to Windows endpoints from NinjaOne using Akto's Windows `install.ps1`.

{% hint style="info" %}
Replace placeholder values before rollout:

* `<AKTO_WINDOWS_INSTALL_PS1_URL>`
{% endhint %}

## Prerequisites

* NinjaOne admin access with script and policy permissions
* Windows device policy in NinjaOne
* Akto-hosted Windows script URL (`install.ps1`)
* Pilot device group for staged rollout

## Deployment Steps

{% stepper %}
{% step %}
### Create the Windows automation script

In NinjaOne:

1. Go to **Administration → Library → Automation**
2. Click **Add** and choose **Script**
3. Configure:
   * **Language:** PowerShell
   * **OS:** Windows
   * **Run As:** System
4. Save as: `Akto Endpoint Shield - Windows Install`
{% endstep %}

{% step %}
### Use this script content

```powershell
$ErrorActionPreference = "Stop"

$scriptUrl = "<AKTO_WINDOWS_INSTALL_PS1_URL>"
$tmpScript = Join-Path $env:TEMP "akto-endpoint-shield-install.ps1"

Write-Host "[Akto] Downloading installer script..."
Invoke-WebRequest -Uri $scriptUrl -OutFile $tmpScript -UseBasicParsing

Write-Host "[Akto] Running installer script..."
powershell.exe -NoProfile -ExecutionPolicy Bypass -File $tmpScript -Silent

Write-Host "[Akto] Installation script finished."
```

{% hint style="warning" %}
Keep **Run As = System** so scheduled tasks and Program Files installation succeed.
{% endhint %}
{% endstep %}

{% step %}
### Attach to policy and schedule

1. Open target **Windows policy**
2. Add a **Scheduled Script**
3. Select `Akto Endpoint Shield - Windows Install`
4. Schedule:
   * Pilot: run once immediately
   * Production: run daily (safe for idempotent installs/upgrades)
5. Save policy
{% endstep %}

{% step %}
### Validate on endpoint

Run on a test endpoint:

```powershell
Test-Path "C:\Program Files\Akto Endpoint Shield\akto-endpoint-shield.exe"
Get-ScheduledTask | Where-Object { $_.TaskName -like "*Akto Endpoint Shield*" } | Select-Object TaskName,State
```

Expected:

* Binary exists in `C:\Program Files\Akto Endpoint Shield\`
* Scheduled tasks exist for HTTP, Agent, and Detector
{% endstep %}
{% endstepper %}

## Troubleshooting

### Script fails in NinjaOne

* Confirm script runs as **System**
* Confirm endpoint can download `<AKTO_WINDOWS_INSTALL_PS1_URL>`
* Check NinjaOne script output and local PowerShell logs

### Install succeeds but services not visible

* Re-run validation command for scheduled tasks
* Verify endpoint restart/startup task execution

## Related Documentation

* [Windows MDM Deployment](windows-mdm-deployment.md)
* [NinjaOne Deployment (macOS)](ninjaone-macos-deployment.md)
* [Chrome NinjaOne Deployment](../browser-extensions/chrome/ninjaone-deployment.md)

## Support

1. In-app Intercom in Akto dashboard
2. [Discord community](https://www.akto.io/community)
3. `support@akto.io`
4. [Contact Akto](https://www.akto.io/contact-us)
