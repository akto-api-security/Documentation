---
description: >-
  Deploy AI Endpoint Shield to Windows endpoints from NinjaOne using the
  install.ps1 script on a recurring schedule.
---

# NinjaOne Deployment (Windows)

## Overview

Deploy **AI Endpoint Shield** to Windows endpoints from NinjaOne by storing Akto's **`install.ps1`** in the NinjaOne Automation Library and running it as a scheduled script.

`install.ps1` is the same script used for [Intune Deployment](intune-deployment.md) and takes the same parameters. It downloads the versioned ZIP from Akto-hosted storage, installs or upgrades the agent, writes configuration, and registers the scheduled tasks. Because it compares the installed version against a manifest and **skips the download when the device is already current**, it is safe to run on a recurring daily schedule — the same policy handles both the initial install and every subsequent update.

Akto ships the installer in two forms:

| Form | Credentials | What you pass at deploy time |
| ---- | ----------- | ---------------------------- |
| **Client-specific installer** | `AKTO_API_TOKEN` and `AKTO_API_BASE_URL` are **already embedded** | Manifest URL only — nothing sensitive lives in NinjaOne |
| **Universal installer** | One build shared across all clients | Manifest URL **plus** token and base URL as parameters |

## Prerequisites

* NinjaOne admin access with script and policy permissions
* A Windows device policy in NinjaOne
* `install.ps1` from Akto, plus your `MANIFEST_URL`
* With the universal installer: your `AKTO_API_TOKEN` and `AKTO_API_BASE_URL`
* A pilot device group for a staged rollout
* Devices need HTTPS access to the manifest and ZIP hosts, to `https://<account_id>-guardrails.akto.io`, and to `https://ultron.akto.io`

## install.ps1 parameters

NinjaOne passes the **Parameters** field to the script as positional arguments, in order:

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
### Create the automation script

In NinjaOne:

1. Go to **Administration → Library → Automation**
2. Click **Add** and choose **Script**
3. Configure:
   * **Name:** `Akto Endpoint Shield - Windows Install`
   * **Language:** PowerShell
   * **Operating System:** Windows
   * **Architecture:** **64-bit** (the installer must not run under 32-bit WOW64)
   * **Run As:** **System**
4. Paste the full contents of `install.ps1` (provided by Akto) as the script body
5. Save

{% hint style="warning" %}
Keep **Run As = System** and **Architecture = 64-bit**. The script writes to `C:\Program Files\`, registers scheduled tasks, and provisions the SYSTEM profile config — all of which fail in a user or 32-bit context.
{% endhint %}
{% endstep %}

{% step %}
### Attach to a policy and set parameters

1. Open the target **Windows policy**
2. Add a **Scheduled Script** and select `Akto Endpoint Shield - Windows Install`
3. Set the **Parameters** field:

   **Client-specific installer** — manifest URL only:

   ```
   "https://<manifest-url>/latest.json"
   ```

   **Universal installer** — append the token and base URL, with an empty `""` for the unused installer URL so the arguments don't shift:

   ```
   "https://<manifest-url>/latest.json" "" "<TOKEN>" "https://<account_id>-guardrails.akto.io"
   ```
4. Save the policy

{% hint style="info" %}
With the universal installer, confirm in a pilot that the token lands on argument 3 and the base URL on argument 4. Akto onboarding can provide a parameter string tested for NinjaOne.
{% endhint %}
{% endstep %}

{% step %}
### Schedule

* **Pilot:** run once immediately against a small device group
* **Production:** run **daily**

A daily schedule is what keeps devices updated — the script fetches `latest.json`, compares it to the installed version, and exits without downloading anything when the device is already current. When Akto publishes a new release, devices pick it up on the next run with no policy change.

**Force a full redeploy:** set `FORCE_REINSTALL=true` as an environment variable on the script assignment.
{% endstep %}

{% step %}
### Validate on an endpoint

Run on a pilot device in an **Administrator** PowerShell session:

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
{% endstep %}
{% endstepper %}

## Uninstall

Create a second automation script from Akto's `uninstall_windows.ps1` (PowerShell, 64-bit, **Run As: System**), and run it on demand against the target devices. It takes no parameters.

## Troubleshooting

| Symptom | Likely cause | What to do |
| ------- | ------------ | ---------- |
| Script fails immediately | Not running as System, or 32-bit PowerShell | Set **Run As: System** and **Architecture: 64-bit** on the automation |
| Wrong config / token (universal installer) | Arguments shifted in the Parameters field | Pass an explicit `""` for argument 2; or use a client-specific installer, which needs no credentials passed |
| Download errors | Firewall or proxy blocking the manifest / ZIP host | Allow HTTPS to the manifest and ZIP URLs |
| Install succeeds but no processes | Tasks failed, or an EDR is terminating the binary | Check `%ProgramData%\akto-endpoint-shield\logs\*-wrapper.log`; see [Allowlist in Security Software](allowlist-in-security-software.md) |
| Device never updates to a new release | Script scheduled once instead of daily | Change the scheduled script to run daily |

For device-level diagnosis, see [Windows Troubleshooting](windows-troubleshooting.md).

## Related Documentation

* [Intune Deployment (Windows)](intune-deployment.md)
* [NinjaOne Deployment (macOS)](ninjaone-macos-deployment.md)
* [Chrome NinjaOne Deployment](../browser-extensions/chrome/ninjaone-deployment.md)

## Support

1. In-app Intercom in the Akto dashboard
2. [Discord community](https://www.akto.io/community)
3. [support@akto.io](mailto:support@akto.io)
4. [Contact Akto](https://www.akto.io/contact-us)
