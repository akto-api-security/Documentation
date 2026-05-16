---
description: >-
  Deploy Akto Endpoint Shield on Windows endpoints using an Automox Worklet policy
  with a customer-specific Inno Setup installer.
---

# Automox Deployment

## Overview

**Akto Endpoint Shield** can be deployed to managed Windows laptops and desktops using **Automox Worklets**. Automox runs a compliance check (evaluation script) on each device; if the shield is not installed, it silently runs the Akto installer you provide.

This guide covers:

* Obtaining a **customer-specific** `akto-endpoint-shield-setup-<version>.exe` from Akto (token embedded at build time)
* Creating an Automox **Worklet policy** with evaluation and remediation PowerShell
* Uploading the installer and targeting device groups
* Verifying installation and troubleshooting common issues

{% hint style="info" %}
**Windows installer type:** Akto ships an **Inno Setup `.exe`**, not an MSI. Use an Automox **Worklet** with a file payload (or the **EXE Software Installation** catalog worklet as a starting point).
{% endhint %}

### Why Automox

* **Silent, unattended install** on fleet devices (runs as SYSTEM)
* **Compliance loop** — reinstall only when evaluation reports non-compliant
* **Central scheduling** and group targeting
* **Activity logs** per device for install success or failure

### What the installer does

When remediation runs successfully, the installer:

* Installs to `C:\Program Files\Akto Endpoint Shield\`
* Writes `config.env` (API token, base URL, feature flags) for the installing context
* Registers scheduled tasks (`MCPEndpointShieldHTTP`, `MCPEndpointShieldAgent`, `MCPEndpointShieldDetector`)
* Bundles hook and system-proxy scripts (hooks stay **off** until enabled in the Akto dashboard unless your build sets otherwise)

## Prerequisites

* **Automox** account with permission to create Worklet policies
* **Windows 10/11** devices (64-bit) enrolled in Automox
* **Akto account** and API token (Akto builds the installer with your token — you do not paste the token into Automox unless you choose a custom token-update script)
* Network access from endpoints to:
  * `https://*.akto.io` (guardrails / API)
  * `https://ultron.akto.io` (database abstractor — default in builds)

Contact **support@akto.io** to request the installer build.

{% stepper %}
{% step %}
**Obtain the installer from Akto**

**Contact Akto Support**

Email **support@akto.io** (or your Akto account team) with:

* Your **Akto account ID** / guardrails URL (e.g. `https://<account-id>-guardrails.akto.io`)
* **API token** to embed (or ask Akto to use your existing org token)
* Target **version** (e.g. `1.1.5`)

Akto will return:

* `akto-endpoint-shield-setup-<version>.exe` — silent Inno Setup installer with your token and URLs baked in
* Optional: evaluation and remediation scripts (also in this document)

**Verify the file name**

Note the **exact** file name (e.g. `akto-endpoint-shield-setup-1.1.5.exe`). The remediation script must use the **same** name as the uploaded payload.
{% endstep %}

{% step %}
**Create the Worklet policy in Automox**

You can either start from the **Worklet Catalog** template or create a **custom policy** from scratch. Both approaches use the same evaluation/remediation scripts and uploaded `.exe`.

### Option A — Start from the catalog (recommended)

1. In Automox, go to **Automate → Worklet Catalog**.
2. Open **EXE Software Installation (System Wide-All Users)** (Windows, Automox Verified).
3. Click **Create Policy**.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/automox-worklet-catalog-exe-install.png" alt="Automox Worklet Catalog - EXE Software Installation" width="563"><figcaption>Worklet Catalog — EXE Software Installation (System Wide-All Users)</figcaption></figure></div>

4. Continue with the next step below.

### Option B — Create a custom Worklet policy

1. Go to **Automate → Policies → Create Policy**.
2. Choose **Worklet** and **Windows**.
3. Continue with the next step.

{% endstep %}

{% step %}
**Configure policy info**

On the policy **Info** tab:

| Field | Example |
|--------|---------|
| **Policy name** | `akto-mcp-windows-installer` |
| **Operating system** | **Windows** |
| **Notes** | `Silent Inno deploy; token baked at build` |
| **Groups** | Target group(s), e.g. `windows` or a pilot group |

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/automox-policy-info.png" alt="Automox policy info - name, Windows, groups" width="563"><figcaption>Policy Info — name, OS, and device groups</figcaption></figure></div>

{% hint style="warning" %}
**Pilot first:** Assign a **small test group** before rolling out to all Windows devices.
{% endhint %}

**Device targeting:** Leave off unless you need attribute filters within the group.

**Inputs / Secrets:** Not required when the API token is embedded in the installer at build time.

{% endstep %}

{% step %}
**Upload the installer (Payload)**

1. Open the **Payload** (file upload) section.
2. Click **Upload File** and select your `akto-endpoint-shield-setup-<version>.exe`.
3. Confirm the uploaded name matches what you use in remediation (e.g. `akto-endpoint-shield-setup-1.1.5.exe`).

Automox stages the file next to the worklet scripts on each device (under its exec directory).

{% endstep %}

{% step %}
**Evaluation code**

Paste this script into **Evaluation Code** (PowerShell). It must be **self-contained** — do not call helper functions defined only in remediation (Automox runs evaluation and remediation in **separate** processes).

**Compliance rules:**

* **Exit `0`** → device is compliant (installer not run)
* **Exit `1`** (or any non-zero) → run remediation

```powershell
# Akto Endpoint Shield - Evaluation
# Exit 0 = installed (compliant), Exit 1 = needs install

# Use 64-bit Program Files (required when Automox runs 32-bit PowerShell)
$pf64 = ${env:ProgramW6432}
if (-not $pf64) { $pf64 = "C:\Program Files" }
$binPath = Join-Path $pf64 "Akto Endpoint Shield\akto-endpoint-shield.exe"

$installed = Test-Path -LiteralPath $binPath
$arp = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*" -ErrorAction SilentlyContinue |
  Where-Object { $_.DisplayName -like "*Akto*Endpoint*" }

if ($installed -and $arp) {
    Write-Output "Installed: $binPath"
    exit 0
}

Write-Output "Not installed. Checked: $binPath"
exit 1
```

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/automox-evaluation-code.png" alt="Automox evaluation code for Akto Endpoint Shield" width="563"><figcaption>Payload upload and Evaluation Code (use the script above — not Get-AktoBinaryPath)</figcaption></figure></div>

{% hint style="danger" %}
**Do not use `Get-AktoBinaryPath` in evaluation only.** That function is not defined unless you duplicate it in the same script block. Using it causes `CommandNotFoundException` and policy errors.
{% endhint %}

{% hint style="info" %}
**Optional stricter check:** To require scheduled tasks as well, add after `$arp`:

<pre class="language-powershell"><code class="lang-powershell">$agentTask = Get-ScheduledTask -TaskName "MCPEndpointShieldAgent" -ErrorAction SilentlyContinue
if (-not $agentTask) { Write-Output "Binary present but agent task missing"; exit 1 }</code></pre>

Use this only after you confirm tasks are created successfully on pilot devices.
{% endhint %}

{% endstep %}

{% step %}
**Remediation code**

Paste this into **Remediation Code**. Update `$fileName` to match your uploaded installer **exactly**.

```powershell
# Akto Endpoint Shield - Remediation (silent Inno install)

$fileName  = "akto-endpoint-shield-setup-1.1.5.exe"
$arguments = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /LOG=C:\Windows\Temp\akto-endpoint-shield-install.log"

$pf64 = ${env:ProgramW6432}
if (-not $pf64) { $pf64 = "C:\Program Files" }
$binPath = Join-Path $pf64 "Akto Endpoint Shield\akto-endpoint-shield.exe"

$sPath = Split-Path $script:MyInvocation.MyCommand.Path -Parent
$fPath = Join-Path $sPath $fileName

if (-not (Test-Path $fPath)) {
    Write-Error "Installer not found: $fPath"
    exit 1
}

Write-Output "Running: $fPath $arguments"
$p = Start-Process -FilePath $fPath -ArgumentList $arguments -Wait -PassThru

if ($null -eq $p -or $p.ExitCode -ne 0) {
    Write-Error "Installer failed. ExitCode=$($p.ExitCode)"
    exit 1
}

# Wait for files (mitmproxy / post-install can take a minute)
$deadline = (Get-Date).AddMinutes(5)
while (-not (Test-Path -LiteralPath $binPath) -and (Get-Date) -lt $deadline) {
    Start-Sleep -Seconds 15
}

if (-not (Test-Path -LiteralPath $binPath)) {
    Write-Error "Binary missing after install. Expected: $binPath"
    if (Test-Path "C:\Windows\Temp\akto-endpoint-shield-install.log") {
        Write-Output "--- Inno log (last 30 lines) ---"
        Get-Content "C:\Windows\Temp\akto-endpoint-shield-install.log" -Tail 30
    }
    exit 1
}

Write-Output "Success: $binPath"
exit 0
```

{% hint style="warning" %}
* Do **not** use `-Verb RunAs` — the worklet already runs elevated as **SYSTEM**.
* Do **not** check `C:\Program Files (x86)\...` — the 64-bit installer places files under **`C:\Program Files\Akto Endpoint Shield`**.
{% endhint %}

{% endstep %}

{% step %}
**Schedule and notifications**

| Setting | Recommendation |
|---------|----------------|
| **Schedule** | Custom — pilot: run once soon; production: recurring or on check-in |
| **Missed run** | Enable *run on next check-in* so offline devices get the install later |
| **Automatic restart** | **Do not** restart devices after worklet completion |

Save the policy (**Save Policy**), then **Run Policy** on a pilot device or wait for the schedule.

{% endstep %}

{% step %}
**Verify deployment**

### In Automox

* **Activity Log** — look for policy `akto-mcp-windows-installer`; success shows `Installer ExitCode=0` and `Success: C:\Program Files\...`
* **Device logs** — `policy_*_remediate` / `policy_*_test` entries

### On the Windows device (PowerShell)

```powershell
# Binary (64-bit path)
Test-Path "C:\Program Files\Akto Endpoint Shield\akto-endpoint-shield.exe"
& "C:\Program Files\Akto Endpoint Shield\akto-endpoint-shield.exe" --version

# Scheduled tasks
Get-ScheduledTask -TaskName "MCPEndpointShield*" -ErrorAction SilentlyContinue |
  Format-Table TaskName, State

# Config (installer may write under SYSTEM profile when deployed via Automox)
Get-Content "$env:USERPROFILE\.akto-endpoint-shield\config\config.env" -ErrorAction SilentlyContinue
Get-Content "C:\Windows\System32\config\systemprofile\.akto-endpoint-shield\config\config.env" -ErrorAction SilentlyContinue

# Agent logs (when running as logged-in user)
Get-Content "$env:LOCALAPPDATA\akto-endpoint-shield\logs\agent.log" -Tail 30 -ErrorAction SilentlyContinue
```

### Test API token (optional)

```bash
export TOKEN='your-jwt-from-config-env'

curl -sS -w "\nHTTP %{http_code}\n" \
  -X POST 'https://ultron.akto.io/api/fetchMcpAuditInfo' \
  -H "Authorization: ${TOKEN}" \
  -H 'Content-Type: application/json' \
  -d '{"updatedAfter":0}'
```

Expect **HTTP 200**. **401** means expired or wrong token — contact Akto for a new build or update `config.env`.
{% endstep %}
{% endstepper %}

## Hooks, MCP wrap, and system proxy

The installer embeds feature flags in `config.env`. **Defaults are `false`** (opt-in):

* Hook installers (Claude, Cursor, Copilot, etc.) run when flags are enabled in the **Akto dashboard** or in `config.env`
* **System proxy (Atlas)** requires dashboard **SwitchProxyMode** and/or `ENABLE_SYSTEM_PROXY=true`

Installing via Automox does **not** mean all hooks are active immediately.

## Troubleshooting

### Evaluation error: `Get-AktoBinaryPath` is not recognized

Evaluation and remediation are separate runs. Use the evaluation script in the steps above with inline paths — no custom functions.

### Remediation error: binary missing under `Program Files (x86)`

Automox often runs 32-bit PowerShell where `$env:ProgramFiles` points to **x86**. Use `${env:ProgramW6432}` as in the scripts above.

### `COMMAND TIMED OUT`

Install or validation took too long. Remediation script includes a 5-minute wait; increase Automox worklet timeout if needed. Check `C:\Windows\Temp\akto-endpoint-shield-install.log`.

### Binary installed but no `MCPEndpointShield*` tasks

Re-run the installer or repair install. Check Inno log for post-install task registration. Agent may not auto-start until tasks exist.

### Agent logs show `401 Unauthorized` to `ultron.akto.io`

Token invalid, expired, or wrong `config.env` path for the process context. Verify token with curl; request a new installer from Akto; ensure SYSTEM and user profiles have correct `config.env` if needed.

### `config.env` only under SYSTEM profile

Normal for Automox (SYSTEM install). The agent loads config from the **user home** when running as the logged-in user. For MDM-wide deploy, align with Akto on copying config to user profiles or per-user install strategies if required.

## Uninstall

On a device:

```powershell
& "C:\Program Files\Akto Endpoint Shield\unins000.exe" /VERYSILENT /SUPPRESSMSGBOXES /NORESTART
```

Or **Settings → Apps → Akto Endpoint Shield → Uninstall**.

After uninstall, evaluation should return non-compliant and remediation can reinstall on the next policy run (if desired).

## Related documentation

* [MDM Deployment](mdm-deployment.md) — Intune, Jamf, and other MDM platforms
* [Mosyle MDM Deployment](mosyle-deployment.md) — macOS MDM
* [README](README.md) — product overview and manual setup

## Get Support

1. In-app **Intercom** on the Akto dashboard
2. [Discord community](https://www.akto.io/community)
3. **support@akto.io**
4. [Contact us](https://www.akto.io/contact-us)
