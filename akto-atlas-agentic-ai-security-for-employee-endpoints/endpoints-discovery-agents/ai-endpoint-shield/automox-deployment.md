---
description: >-
  Deploy AI Endpoint Shield to Windows endpoints from Automox using a recurring
  Required Software Policy that runs the install.ps1 script.
---

# Automox Deployment (Windows)

## Overview

Deploy **AI Endpoint Shield** to Windows laptops from Automox using a **Required Software Policy** that runs Akto's **`install.ps1`** on a recurring schedule.

`install.ps1` is the same script used for [Intune Deployment](intune-deployment.md) and takes the same parameters. It downloads the versioned ZIP from Akto-hosted storage, installs or upgrades the agent, writes configuration for both the SYSTEM profile and every interactive user, installs the IDE guardrail hooks, and registers the scheduled tasks.

Because the script compares the installed version against a manifest and **exits without downloading anything when the device is already current**, one recurring policy handles both the initial install and every subsequent update. No worklet, evaluation code, or remediation code is needed.

Akto ships the installer in two forms:

| Form | Credentials | What you pass at deploy time |
| ---- | ----------- | ---------------------------- |
| **Client-specific installer** | `AKTO_API_TOKEN` and `AKTO_API_BASE_URL` are **already embedded** | Manifest URL only — nothing sensitive lives in Automox |
| **Universal installer** | One build shared across all clients | Manifest URL **plus** token and base URL in the install command |

{% hint style="info" %}
**Automox runs as SYSTEM**, which is what this deployment needs. `install.ps1` provisions the SYSTEM profile config that the scheduled tasks read, and separately writes a copy into each interactive user profile — so no manual config propagation step is required.
{% endhint %}

## Prerequisites

* Automox account with policy permissions
* Windows 10/11 (64-bit) devices enrolled in Automox, in a device group
* `install.ps1` from Akto, plus your `MANIFEST_URL`
* With the universal installer: your `AKTO_API_TOKEN` and `AKTO_API_BASE_URL`
* Devices need HTTPS access to the manifest and ZIP hosts, to `https://<account_id>-guardrails.akto.io`, and to `https://ultron.akto.io`

Contact **support@akto.io** with your Akto account ID to request the installer package and your manifest URL.

## install.ps1 parameters

Positional arguments, in order:

| Position | Name | Required | Description |
| -------- | ---- | -------- | ----------- |
| `$1` | `MANIFEST_URL` | Yes\* | HTTPS URL to `latest.json` |
| `$2` | `INSTALLER_URL` | No | Direct ZIP URL, used if the manifest fetch fails |
| `$3` | `AKTO_API_TOKEN` | Cond. | Required with the **universal** installer; already embedded in a client-specific installer |
| `$4` | `AKTO_API_BASE_URL` | Cond. | Required with the **universal** installer; already embedded in a client-specific installer |

\* Required unless only `INSTALLER_URL` is used.

## Deployment Steps

{% stepper %}
{% step %}
### Create the policy

Go to **Automate → Policies → Create Policy**, and under **Required Software Policy** choose **Windows**.
{% endstep %}

{% step %}
### Info

* **Policy Name:** `Akto Endpoint Shield - Install & Update`
* **Operating System:** Windows
* **Notes:** optional

Under **Groups**, click **+ Associate Groups** and select your target device group. Start with a pilot group before widening the scope.

Leave **Device Targeting** off unless you need to filter further within those groups.
{% endstep %}

{% step %}
### Scope

* **Package Name:** `Akto Endpoint Shield`
* **Package Version:** the version Akto published in your manifest, e.g. `1.1.134`
* **Installation File:** click **Upload File** and upload `install.ps1`

Then, in the installation script box below Scope, enter the command that runs the uploaded script.

**Client-specific installer** — manifest URL only:

```powershell
$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
& "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass `
    -File (Join-Path $dir 'install.ps1') `
    "https://<manifest-url>/latest.json"
exit $LASTEXITCODE
```

**Universal installer** — append the token and base URL, with an empty `""` for the unused installer URL so the arguments don't shift:

```powershell
$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
& "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass `
    -File (Join-Path $dir 'install.ps1') `
    "https://<manifest-url>/latest.json" "" "<TOKEN>" "https://<account_id>-guardrails.akto.io"
exit $LASTEXITCODE
```

{% hint style="warning" %}
Call `powershell.exe` by its full `System32` path. Automox's agent can run 32-bit, and `install.ps1` must execute in **64-bit** PowerShell to write to `C:\Program Files\` and the real SYSTEM profile rather than their WOW64 redirects.

Do **not** add `-Verb RunAs` — the policy already runs as SYSTEM.
{% endhint %}
{% endstep %}

{% step %}
### Schedule

Select **Custom**, then set a **daily** cadence:

* **Months:** tick **Select All**
* **Occurrence:** tick `1ST`, `2ND`, `3RD`, `4TH`, `5TH`
* **Days:** tick `MON` through `SUN`
* **Scheduled Start Time:** a quiet hour, e.g. `12:00 AM`, **Local Time Of Device**
* Tick **If a device misses the configured policy run time, this policy will run the next time the device checks in** so laptops that were offline still get picked up

Click **Create Policy**.

{% hint style="info" %}
A daily run is what keeps devices updated. `install.ps1` fetches `latest.json`, compares it to the installed version, and exits early when the device is already current — so on most days the policy costs a single HTTPS request per device. When Akto publishes a new release, devices upgrade on the next run with no policy change.

`install.ps1` deliberately does not register an Add/Remove Programs entry, so Automox's package-version check will not report the device as already compliant. The install command runs on every scheduled pass, and the script's own version check does the deduplication.
{% endhint %}
{% endstep %}

{% step %}
### Run on a pilot device and check the log

Use **Run Policy** to trigger it immediately on a pilot device, then open the **Activity Log** for that device and confirm the run reported success.
{% endstep %}
{% endstepper %}

## Verify

On a pilot device, in an **Administrator** PowerShell session:

```powershell
& "C:\Program Files\Akto Endpoint Shield\akto-endpoint-shield.exe" --version
& "C:\Program Files\Akto Endpoint Shield\akto-endpoint-shield.exe" check-config --path "$env:SystemRoot\System32\config\systemprofile\.akto-endpoint-shield\config"
Get-ScheduledTask -TaskName "MCPEndpointShield*" | Format-Table TaskName, State -AutoSize
Get-Process akto-endpoint-shield -ErrorAction SilentlyContinue
Get-Content "$env:ProgramData\akto-endpoint-shield\logs\install.log" -Tail 40
```

Expected:

* A version string matching the manifest
* `check-config` prints `provisioned`
* `MCPEndpointShieldHTTP`, `MCPEndpointShieldAgent`, and `MCPEndpointShieldDetector` exist and are `Running` or `Ready`
* The device appears under **Akto → Endpoint Shield** with recent activity

## Hooks and system proxy

IDE guardrail hooks are installed by default. The system-wide proxy is **off** by default. Both are controlled from the **Akto dashboard** after install — no policy change needed.

## Force a redeploy

Set `FORCE_REINSTALL=true` as an environment variable on the policy's script, or add a line before the install command:

```powershell
$env:FORCE_REINSTALL = "true"
```

## Uninstall

Create a second Required Software Policy that uploads and runs Akto's `uninstall_windows.ps1`. It takes no parameters:

```powershell
$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
& "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass `
    -File (Join-Path $dir 'uninstall_windows.ps1')
exit $LASTEXITCODE
```

Schedule it on demand rather than recurring.

## Troubleshooting

| Symptom | Likely cause | What to do |
| ------- | ------------ | ---------- |
| Script fails immediately | Ran under 32-bit PowerShell | Call `powershell.exe` by its full `System32` path, as shown above |
| Wrong config / token (universal installer) | Arguments shifted | Pass an explicit `""` for argument 2; or use a client-specific installer, which needs no credentials passed |
| `COMMAND TIMED OUT` | First install downloads the full ZIP over a slow link | Increase the policy timeout; check `%ProgramData%\akto-endpoint-shield\logs\install.log` |
| `401 Unauthorized` in agent logs | Token is stale or was never written | Run `check-config`; if it prints `not-provisioned`, re-run the policy. If the token is present but the API still returns 401, the JWT has expired — request a new installer from Akto |
| Download errors | Firewall or proxy blocking the manifest / ZIP host | Allow HTTPS to the manifest and ZIP URLs |
| Install succeeds but no processes | Tasks failed, or an EDR is terminating the binary | Check `%ProgramData%\akto-endpoint-shield\logs\*-wrapper.log`; see [Allowlist in Security Software](allowlist-in-security-software.md) |
| A user who signed in after deploy has no config | The user profile did not exist at install time | The next daily run provisions them; no action needed |

For device-level diagnosis, see [Windows Troubleshooting](windows-troubleshooting.md).

## Related documentation

* [Intune Deployment (Windows)](intune-deployment.md)
* [NinjaOne Deployment (Windows)](ninjaone-windows-deployment.md)
* [AI Endpoint Shield overview](README.md)

## Get Support

1. In-app Intercom in the Akto dashboard
2. [Discord community](https://www.akto.io/community)
3. [support@akto.io](mailto:support@akto.io)
