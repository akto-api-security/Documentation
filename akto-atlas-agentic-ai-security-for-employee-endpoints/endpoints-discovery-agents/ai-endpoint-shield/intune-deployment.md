---
description: >-
  Deploy AI Endpoint Shield to Windows endpoints with Microsoft Intune using
  install.ps1 — a Win32 app for the one-time install and Remediations for
  recurring auto-update.
---

# Intune Deployment (Windows)

## Overview

AI Endpoint Shield is deployed to Windows devices from **Microsoft Intune** with a single PowerShell script, **`install.ps1`**. The script downloads the versioned ZIP from Akto-hosted storage, installs or upgrades the agent, writes configuration, registers the scheduled tasks, and keeps devices current via a version manifest.

Akto ships the installer in two forms:

| Form | Credentials | What you pass at deploy time |
| ---- | ----------- | ---------------------------- |
| **Client-specific installer** | `AKTO_API_TOKEN` and `AKTO_API_BASE_URL` are **already embedded** | Manifest URL only — nothing sensitive lives in Intune |
| **Universal installer** | One build shared across all clients | Manifest URL **plus** token and base URL as parameters |

Deployment has **two parts**, and both are needed:

1. **One-time install** — a **Win32 app** that runs `install.ps1` once per device, governed by a detection rule.
2. **Recurring auto-update and self-heal** — an Intune **Remediations** script pair that checks the manifest and task health on a schedule and repairs in place.

{% hint style="info" %}
For **macOS**, see [Jamf MDM Deployment](jamf-mdm-deployment.md) or [Mosyle MDM Deployment](mosyle-deployment.md). For other Windows tools, see [NinjaOne Deployment (Windows)](ninjaone-windows-deployment.md) and [Automox Deployment](automox-deployment.md).
{% endhint %}

***

## Architecture

| Aspect | Detail |
| ------ | ------ |
| Script execution | **SYSTEM** / LocalSystem (not the logged-on user) |
| PowerShell | **64-bit** (`powershell.exe`, not 32-bit WOW64) |
| Installer payload | Versioned ZIP per release, hosted by Akto — client-specific or universal |
| Credentials | Embedded in a client-specific installer, or passed as script arguments / environment variables with the universal installer |
| Auto-update | `latest.json` manifest URL, provided by Akto |
| Install location | `C:\Program Files\Akto Endpoint Shield\` |
| Services | Scheduled tasks `MCPEndpointShieldHTTP`, `MCPEndpointShieldAgent`, `MCPEndpointShieldDetector`, `MCPEndpointShieldSystemProxy` |
| Config | Per-user and SYSTEM `config.env.enc` under `.akto-endpoint-shield\config\` — encrypted at rest via Windows DPAPI |

This path uses **ZIP + `install.ps1`** — there is no MSI.

***

## Prerequisites

### 1. Akto installer package

Provided by Akto, containing `install.ps1` and the scripts below.

* **Client-specific installer** — your `AKTO_API_TOKEN` and `AKTO_API_BASE_URL` are already embedded; nothing else to supply.
* **Universal installer** — shared across all clients; you pass the token and base URL at deploy time.

### 2. MANIFEST\_URL

HTTPS URL to `latest.json`, provided by Akto during onboarding. This is what enables auto-update.

### 3. INSTALLER\_URL (optional)

Direct HTTPS URL to the ZIP — used as a fallback if the manifest cannot be fetched.

### 4. AKTO\_API\_TOKEN + AKTO\_API\_BASE\_URL (universal installer only)

* `AKTO_API_TOKEN` — from the Akto platform; treat as a secret.
* `AKTO_API_BASE_URL` — your guardrails URL, e.g. `https://<account_id>-guardrails.akto.io`.

### 5. Network access

Managed devices need HTTPS access to:

* `MANIFEST_URL` and the ZIP host (often `*.amazonaws.com`)
* `https://<account_id>-guardrails.akto.io`
* `https://ultron.akto.io` (default data ingestion endpoint)

***

## Scripts

| Script | Purpose |
| ------ | ------- |
| `install.ps1` | One-time install, credential provisioning, and configuration |
| `Detect-AktoEndpointShield.ps1` | Checks installed version and task health; makes no changes (Remediations detection script) |
| `Remediate-AktoEndpointShield.ps1` | Repairs/updates in place, only when detection reports an issue |
| `uninstall_windows.ps1` | Removes the agent, tasks, and config |

### install.ps1 parameters

Positional arguments:

| Position | Name | Required | Description |
| -------- | ---- | -------- | ----------- |
| `$1` | `MANIFEST_URL` | Yes\* | HTTPS URL to `latest.json` |
| `$2` | `INSTALLER_URL` | No | Direct ZIP URL, used if the manifest fetch fails |
| `$3` | `AKTO_API_TOKEN` | Cond. | Required with the **universal** installer; already embedded in a client-specific installer |
| `$4` | `AKTO_API_BASE_URL` | Cond. | Required with the **universal** installer; already embedded in a client-specific installer |

\* Required unless only `INSTALLER_URL` / `INSTALLER_PATH` is used.

**Client-specific installer** — pass only the manifest URL:

```powershell
.\install.ps1 "https://<manifest-url>/latest.json"
```

**Universal installer** — pass the token and base URL. Note the empty `""` placeholder for the unused installer URL so the arguments don't shift:

```powershell
.\install.ps1 "https://<manifest-url>/latest.json" "" "<TOKEN>" "https://<account_id>-guardrails.akto.io"
```

Environment variables (`MANIFEST_URL`, `INSTALLER_URL`, `AKTO_API_TOKEN`, `AKTO_API_BASE_URL`, `FORCE_REINSTALL`, and the per-IDE `ENABLE_*` feature flags) are also honoured if you prefer to set them instead of positional arguments.

`Detect-AktoEndpointShield.ps1` and `Remediate-AktoEndpointShield.ps1` take **no parameters** — they read everything they need from the device after `install.ps1` has provisioned it. That is what lets them run on Intune Remediations, which has no parameters field.

***

## Step 1 — One-time install (Win32 app)

Intune **Platform scripts** (Devices → Scripts and remediations → Platform scripts) re-run on every device check-in rather than installing once, and have no field for the token the universal installer needs. Provisioning therefore goes through a **Win32 app**, which supports a free-text install command and installs only once, governed by a detection rule.

{% stepper %}
{% step %}
#### Package the script

Run the [Win32 Content Prep Tool](https://github.com/microsoft/Microsoft-Win32-Content-Prep-Tool) against a folder containing `install.ps1`, producing an `.intunewin` file.
{% endstep %}

{% step %}
#### Create the app

Go to **Apps** → **Windows** → **Add** → **Windows app (Win32)** and upload the `.intunewin` file.
{% endstep %}

{% step %}
#### Set the program commands

**Install command — client-specific installer** (credentials embedded, manifest URL only):

```
powershell.exe -NoProfile -ExecutionPolicy Bypass -File install.ps1 "https://<manifest-url>/latest.json"
```

**Install command — universal installer** (append the token and base URL, with an empty `""` for the unused installer URL so arguments don't shift):

```
powershell.exe -NoProfile -ExecutionPolicy Bypass -File install.ps1 "https://<manifest-url>/latest.json" "" "<TOKEN>" "https://<account_id>-guardrails.akto.io"
```

**Uninstall command:**

```
powershell.exe -NoProfile -ExecutionPolicy Bypass -File uninstall_windows.ps1
```

**Install behavior:** **System**
{% endstep %}

{% step %}
#### Add a detection rule

A detection rule is **required** — the Win32 app wizard won't let you publish without one — and it is what gives you real one-time-until-uninstalled semantics.

Config is written **encrypted** (`config.env.enc`, via Windows DPAPI), so the detection script asks the installed binary itself rather than trying to read the file:

```powershell
$binary = "$env:ProgramW6432\Akto Endpoint Shield\akto-endpoint-shield.exe"
$cfgDir = "$env:SystemRoot\System32\config\systemprofile\.akto-endpoint-shield\config"
if (Test-Path $binary) {
    & $binary check-config --path $cfgDir | Out-Null
    if ($LASTEXITCODE -eq 0) { Write-Host "Installed"; exit 0 }
}
exit 1
```

A simpler file-exists rule on `akto-endpoint-shield.exe` also works, but it won't catch a device where the binary landed and provisioning failed.

{% hint style="warning" %}
Do **not** write a detection rule that greps `config.env` for the token. That file is encrypted at rest, so the match never succeeds and Intune reinstalls the app roughly every 24 hours, forever.
{% endhint %}

If detection ever reports "not installed" — for example after a bad uninstall — Intune automatically retries the install command within about 24 hours. That is a useful self-heal layer, not a bug.
{% endstep %}

{% step %}
#### Assign

Assign the app as **Required** to your target device group(s).
{% endstep %}
{% endstepper %}

***

## Step 2 — Recurring auto-update (Remediations)

{% stepper %}
{% step %}
#### Create the script package

Go to **Devices** → **Scripts and remediations** → **Create script package**.
{% endstep %}

{% step %}
#### Basics

Name it, for example `Akto Endpoint Shield – Update & Self-heal`.
{% endstep %}

{% step %}
#### Settings

Upload `Detect-AktoEndpointShield.ps1` as the **detection script** and `Remediate-AktoEndpointShield.ps1` as the **remediation script**.

* Run using logged-on credentials: **No**
* Enforce script signature check: **No**
* Run script in 64-bit PowerShell: **Yes**
{% endstep %}

{% step %}
#### Assignments

Target the same device group(s) as the Win32 app.
{% endstep %}

{% step %}
#### Schedule

**Daily** (or every 4–6 hours). Detection is read-only until an issue is found, and the repair step is safe to re-run, so a tighter schedule is fine. Daily meets a "picks up a new release within a day" SLA.
{% endstep %}
{% endstepper %}

{% hint style="warning" %}
With a **client-specific installer** you pass only the manifest URL, so there are no credentials to map. With the **universal installer**, confirm in a pilot that the token maps to argument 3 and the base URL to argument 4, and pass an empty `""` for the unused installer URL (argument 2) so nothing shifts. Akto onboarding can provide a tested parameter string.
{% endhint %}

***

## Schedule and scope

The **Win32 app** is not scheduled — it installs once per device and is re-tried only if the detection rule stops matching. It is the **Remediations** script package that carries a schedule:

| Phase | Scope | Remediations schedule |
| ----- | ----- | --------------------- |
| Pilot | 5–10 devices | Daily, 1 week |
| Rollout | Engineering / security | Daily |
| Production | All Windows endpoints | Daily |

Detection is read-only until it finds a problem, and the repair step re-uses the same install-from-ZIP flow, skipping the download when the installed version already matches the manifest. Daily runs are therefore cheap and pick up new Akto releases automatically.

{% hint style="danger" %}
**Do not also schedule `install.ps1` as a recurring Platform script.** On Intune, auto-update is the Remediations pair's job. Running `install.ps1` on a schedule *as well as* the Remediations pair and the Win32 app's own ~24-hour detection retry gives you three mechanisms racing over the same install directory and scheduled tasks.

Other Windows tools have no Remediations equivalent, so they do run `install.ps1` on a daily schedule instead — see [NinjaOne](ninjaone-windows-deployment.md) and [Automox](automox-deployment.md).
{% endhint %}

**Force a full redeploy:** set `FORCE_REINSTALL=true` as an environment variable on the Remediations script assignment.

***

## What happens on the device

1. Fetches `latest.json` from `MANIFEST_URL`.
2. Compares the manifest `version` with `akto-endpoint-shield.exe --version`.
3. If an update is needed, downloads the ZIP, stops the tasks, and deploys to `C:\Program Files\Akto Endpoint Shield\`.
4. Writes the encrypted `config.env.enc` for interactive users and for SYSTEM — from the credentials embedded in the installer, or from the token and base URL you passed.
5. Installs the IDE guardrail hooks, then registers and starts the scheduled tasks.

MCP client and hook settings are controlled from the **Akto dashboard** after install.

***

## Updates and rollback

* **Updates** — Akto updates `latest.json`; devices upgrade on the next Remediations run. No Intune policy change required.
* **Rollback** — Akto points `latest.json` at an older versioned ZIP.
* **Emergency** — pass a specific ZIP URL as argument 2 (`INSTALLER_URL`).

***

## Verification

On a pilot device, in an **Administrator** PowerShell session:

```powershell
& "${env:ProgramW6432}\Akto Endpoint Shield\akto-endpoint-shield.exe" --version
& "${env:ProgramW6432}\Akto Endpoint Shield\akto-endpoint-shield.exe" check-config --path "$env:SystemRoot\System32\config\systemprofile\.akto-endpoint-shield\config"
Get-ScheduledTask -TaskName "MCPEndpointShield*" | Format-Table TaskName, State -AutoSize
Get-Process akto-endpoint-shield -ErrorAction SilentlyContinue
Get-Content "$env:ProgramData\akto-endpoint-shield\logs\install.log" -Tail 40 -ErrorAction SilentlyContinue
```

`check-config` should print `provisioned`. Also confirm success in **Intune** reporting and that the device appears under **Akto → Endpoint Shield**.

### Checklist

* [ ] Win32 app reports success on pilot devices
* [ ] Binary present under Program Files, and `--version` matches the manifest
* [ ] `check-config` prints `provisioned` for the SYSTEM profile
* [ ] Scheduled tasks `MCPEndpointShield*` exist and are `Running`/`Ready`
* [ ] Remediations script package assigned and scheduled
* [ ] Endpoint visible in Akto with recent activity

***

## Troubleshooting

| Symptom | Likely cause | What to do |
| ------- | ------------ | ---------- |
| Script fails immediately | Not running as SYSTEM, or 32-bit PowerShell | Use 64-bit PowerShell as SYSTEM |
| Wrong config / token (universal installer) | Arguments shifted | Fix the parameter string; test locally with an explicit `""` for argument 2. Or switch to a client-specific installer, which needs no credentials passed |
| Win32 app keeps reinstalling every ~24h | Detection rule never matches — most often a rule that greps the encrypted `config.env` for the token, or a path typo | Use the `check-config` detection rule in [Step 1](#step-1-one-time-install-win32-app); verify it against a working device |
| Device never gets the latest version | Remediation not assigned, or scheduled too infrequently | Confirm the assignment and schedule; policy delivery can take up to 8 hours to reach a device after first assignment |
| No upgrade | Manifest version does not match the published ZIP | Contact Akto to align the manifest and the ZIP |
| No processes running | Tasks failed, or the binary exited | Check `%ProgramData%\akto-endpoint-shield\logs\*-wrapper.log` |
| Download errors | Firewall or proxy | Allow HTTPS to the manifest and ZIP URLs |

For device-level diagnosis, see [Windows Troubleshooting](windows-troubleshooting.md). For EDR and antivirus exclusions, see [Allowlist in Security Software](allowlist-in-security-software.md).

***

## File locations

| Path | Purpose |
| ---- | ------- |
| `C:\Program Files\Akto Endpoint Shield\akto-endpoint-shield.exe` | Main binary |
| `C:\Program Files\Akto Endpoint Shield\start-akto-mode.ps1` | Task wrapper |
| `%SystemRoot%\System32\config\systemprofile\.akto-endpoint-shield\config\` | Credentials + feature flags (SYSTEM) |
| `%USERPROFILE%\.akto-endpoint-shield\config\` | Per-user configuration |
| `%ProgramData%\akto-endpoint-shield\logs\install.log` | Install log |
| `%ProgramData%\akto-endpoint-shield\logs\remediation-detect.log` / `remediation-remediate.log` | Auto-update check / repair logs |
| `%ProgramData%\akto-endpoint-shield\logs\` | Wrapper logs |

***

## Get support

1. In-app **Intercom** on the Akto dashboard
2. [Discord community](https://www.akto.io/community)
3. [support@akto.io](mailto:support@akto.io)
4. [Contact Akto](https://www.akto.io/contact-us)

For `MANIFEST_URL` and release artifacts, contact your Akto account team.
