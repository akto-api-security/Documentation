# Intune MDM Deployment (Windows)

### Overview

AI Endpoint Shield can be deployed enterprise-wide on **Windows** via **Microsoft Intune** using a single PowerShell script. The script downloads a generic installer package from Akto-hosted storage, installs or upgrades the agent, applies your organization's credentials, and keeps devices on the latest version automatically.

#### Why use Intune deployment?

* **Zero-touch deployment** — no manual installs on each laptop
* **Centralized credentials** — API token and guardrails URL passed as Intune parameters (not baked into the installer)
* **Automatic updates** — devices check a version manifest on each script run
* **Consistent configuration** — same security posture across the fleet
* **No per-customer installer builds** — one ZIP per release works for all tenants

#### Supported platforms

* ✅ **Microsoft Intune** (Windows 10 and later)

{% hint style="info" %}
For **macOS** fleet deployment, use [Jamf MDM Deployment](jamf-mdm-deployment.md). For Automox-based Windows deployment, see [Automox Deployment](automox-deployment.md).
{% endhint %}

***

### Architecture

| Aspect | Detail |
| ------ | ------ |
| Script execution | **SYSTEM** (Intune: run as logged-on user = **No**) |
| Installer payload | Generic ZIP per version (hosted by Akto on S3) |
| Credentials | `AKTO_API_TOKEN` + `AKTO_API_BASE_URL` from Intune script parameters |
| Auto-update | `latest.json` manifest URL (provided by Akto) |
| Install location | `C:\Program Files\Akto Endpoint Shield\` |
| Services | Windows scheduled tasks (`MCPEndpointShieldHTTP`, `MCPEndpointShieldAgent`, `MCPEndpointShieldDetector`, `MCPEndpointShieldSystemProxy`) |
| Config | `%USERPROFILE%\.akto-endpoint-shield\config\config.env` (per user) + SYSTEM profile for background tasks |

This deployment uses **ZIP + `install.ps1`**, not an MSI or per-user `.exe` installer.

***

### Prerequisites

Before deploying via Intune, ensure you have:

#### 1. AKTO\_API\_TOKEN

* Obtain from the Akto platform (Atlas / guardrails onboarding)
* Store in Intune as a **secret** script parameter where possible

#### 2. AKTO\_API\_BASE\_URL

* Your Akto guardrails URL, for example: `https://<account-id>-guardrails.akto.io`

#### 3. MANIFEST\_URL

* Provided by Akto during onboarding
* Points to `latest.json` on Akto-hosted storage
* Enables auto-update: the script compares the installed version with the manifest and downloads a newer ZIP when needed

#### 4. INSTALLER\_URL (optional)

* Direct HTTPS URL to the ZIP file
* Used only as a **fallback** if the manifest cannot be fetched
* Akto can provide this alongside `MANIFEST_URL`

#### 5. Microsoft Intune access

Permissions to create and assign:

* **Platform scripts** (Devices → Scripts)
* Device groups for scoping
* (Optional) Separate uninstall script assignment

#### 6. Network

* Managed devices must reach:
  * Your `MANIFEST_URL` and ZIP URL (HTTPS, typically `*.amazonaws.com`)
  * `https://<account-id>-guardrails.akto.io` (HTTPS, port 443)
  * `https://ultron.akto.io` (data ingestion, used by default config)

***

### Deployment scripts

Akto provides two PowerShell scripts:

#### install.ps1

* **Purpose:** Install, upgrade, or reconfigure Akto Endpoint Shield
* **Run as:** SYSTEM (64-bit PowerShell)
* **Parameters (positional, space-separated):**

| Position | Name | Required | Description |
| -------- | ---- | -------- | ----------- |
| `$1` | `MANIFEST_URL` | Yes\* | HTTPS URL to `latest.json` |
| `$2` | `INSTALLER_URL` | No | Direct ZIP URL if manifest fetch fails |
| `$3` | `AKTO_API_TOKEN` | Yes | Customer API token |
| `$4` | `AKTO_API_BASE_URL` | Yes | Guardrails base URL |

\* Required unless `INSTALLER_URL` is set and manifest is not used.

**Example parameter string:**

```text
https://<akto-provided-host>/atlas-installers/windows-installer/latest.json  https://<akto-provided-host>/atlas-installers/windows-installer/<version>/akto-endpoint-shield-<version>.zip  <YOUR_TOKEN>  https://<account-id>-guardrails.akto.io
```

If you do not need a ZIP fallback, pass an **empty second argument**. When testing locally in PowerShell:

```powershell
.\install.ps1 "https://<manifest-url>/latest.json" "" "<YOUR_TOKEN>" "https://<account-id>-guardrails.akto.io"
```

{% hint style="warning" %}
In the Intune **Script parameters** box, include a gap for the optional URL between the manifest URL and the token (manifest, then token, then base URL). If your pilot device maps the token to the wrong argument, add an explicit empty second field per your Intune tenant's parameter parsing — Akto onboarding will provide a tested parameter string for your environment.
{% endhint %}

#### uninstall.ps1

* **Purpose:** Remove Akto Endpoint Shield, scheduled tasks, and related files
* **Run as:** SYSTEM (Administrator)
* Deploy as a **separate** Intune script when you need a controlled uninstall path

***

### Phase 1: Upload scripts to Intune

1. Open the **Microsoft Intune admin center**.
2. Go to **Devices** → **Scripts** → **Add** → **Windows 10 and later**.
3. Upload **`install.ps1`** (provided by Akto).
4. Configure script settings:

| Setting | Value |
| ------- | ----- |
| Run this script using the logged-on credentials | **No** |
| Run script in 64-bit PowerShell | **Yes** |
| Enforce script signature check | Per your org policy |
| Run script in hidden PowerShell window | **Yes** (recommended) |

5. Under **Script parameters**, paste your parameter string (manifest URL, optional ZIP URL, token, base URL).
6. Assign to a **pilot device group** first.
7. Set **Schedule** to run daily (recommended for auto-update), or at least once after enrollment.

Repeat for **`uninstall.ps1`** as a separate script if needed (no parameters, assign only to groups that should be able to uninstall).

***

### Phase 2: Assign and schedule

#### Recommended schedule

| Phase | Scope | Frequency |
| ----- | ----- | --------- |
| Pilot | 5–10 test devices | Daily for 1 week |
| Early rollout | Engineering / security | Daily |
| Production | All Windows endpoints | Daily |

The install script **skips re-downloading** the ZIP when the device is already on the manifest version. Running daily is safe and picks up new releases automatically.

#### Force reinstall

If you need to redeploy the same version (for example, after a config fix), set an environment variable on the script assignment:

* `FORCE_REINSTALL=true`

Or ask Akto support for the latest parameter guidance.

***

### What happens on the device

When the script runs:

1. Fetches `latest.json` from your `MANIFEST_URL`
2. Reads `version` and `zip_url` from the manifest
3. Compares with `akto-endpoint-shield.exe --version` under `Program Files`
4. If missing or outdated → downloads ZIP, stops existing tasks, replaces files under `C:\Program Files\Akto Endpoint Shield\`
5. Writes `config.env` for logged-in users and the SYSTEM profile
6. Registers and starts scheduled tasks for HTTP proxy, agent, and detector modes

Hook and MCP client settings are managed from the **Akto dashboard** after install — no Intune policy changes are required for each IDE.

***

### Updating Akto Endpoint Shield

Updates are **automatic**. When Akto publishes a new release, `latest.json` points to the new ZIP. Devices upgrade on the next successful script run — **no Intune policy edit** is required.

**Rollback:** Akto can point `latest.json` to a previous version's ZIP URL. Devices will downgrade on the next script run.

**Emergency:** Use `INSTALLER_URL` (argument 2) with a specific ZIP URL provided by Akto to bypass manifest resolution if needed.

***

### Verification

On a test device, open **PowerShell as Administrator** (or review Intune script run status):

```powershell
# Version
& "${env:ProgramW6432}\Akto Endpoint Shield\akto-endpoint-shield.exe" --version

# Config
Get-Content "$env:USERPROFILE\.akto-endpoint-shield\config\config.env" | Select-String "AKTO_API"

# Scheduled tasks
Get-ScheduledTask -TaskName "MCPEndpointShield*" | Format-Table TaskName, State -AutoSize

# Install log (full log when a user was logged in)
Get-Content "$env:USERPROFILE\.akto-endpoint-shield\logs\install.log" -Tail 40 -ErrorAction SilentlyContinue
Get-Content "$env:ProgramData\akto-endpoint-shield\logs\install.log" -Tail 20 -ErrorAction SilentlyContinue

# Background processes (may appear shortly after tasks start)
Get-Process akto-endpoint-shield -ErrorAction SilentlyContinue
```

In the **Intune admin center**, check **Devices** → **Scripts** → your script → **Device status** for per-device success or failure codes.

#### Verification checklist

* [ ] Script shows **Success** in Intune for pilot devices
* [ ] Binary exists under `C:\Program Files\Akto Endpoint Shield\`
* [ ] `--version` matches the version in Akto's current manifest
* [ ] `config.env` contains your guardrails URL and token
* [ ] `MCPEndpointShield*` scheduled tasks are present
* [ ] Device appears in **Akto** → **Endpoint Shield** with recent heartbeat
* [ ] MCP clients (Cursor, VS Code, etc.) show activity after dashboard policy is applied

***

### Troubleshooting

| Symptom | Likely cause | What to do |
| ------- | ------------ | ---------- |
| Script fails in Intune | Wrong parameters or not running as SYSTEM | Confirm **No** for logged-on credentials, **Yes** for 64-bit; verify four arguments |
| Install log stops early | Script error under `$ErrorActionPreference = Stop` | Read full log at `%USERPROFILE%\.akto-endpoint-shield\logs\install.log` |
| Version never updates | Manifest `version` does not match published ZIP | Contact Akto — manifest and binary version must align |
| No `akto-endpoint-shield` processes | Tasks not started or binary exited on startup | Check `C:\ProgramData\akto-endpoint-shield\logs\*-wrapper.log`; run `Start-ScheduledTask` for `MCPEndpointShieldAgent` |
| Stale guardrails URL in config | Old install before credential refresh | Re-run install script; confirm args 3–4 |
| Download blocked | Firewall or TLS inspection | Allow HTTPS to manifest and ZIP hosts; allow `*.akto.io` |

{% hint style="info" %}
**SentinelOne / EDR:** If the agent is blocked, see [Whitelist Paths](whitelist-paths.md) for path exclusions.
{% endhint %}

***

### File locations

| Path | Purpose |
| ---- | ------- |
| `C:\Program Files\Akto Endpoint Shield\akto-endpoint-shield.exe` | Main binary |
| `C:\Program Files\Akto Endpoint Shield\start-akto-mode.ps1` | Wrapper used by scheduled tasks |
| `%USERPROFILE%\.akto-endpoint-shield\config\config.env` | User token and feature flags |
| `%SystemRoot%\System32\config\systemprofile\.akto-endpoint-shield\config\config.env` | SYSTEM task configuration |
| `%ProgramData%\akto-endpoint-shield\logs\install.log` | Install log (initial lines) |
| `%USERPROFILE%\.akto-endpoint-shield\logs\install.log` | Full install log when a console user is present |
| `%ProgramData%\akto-endpoint-shield\logs\*-wrapper.log` | Scheduled task wrapper logs |

***

### Rollout strategy

#### Phase 1: Pilot (week 1)

* Assign script to 5–10 IT or security team devices
* Confirm Intune success, Akto dashboard visibility, and MCP client behavior
* Review install logs for one week

#### Phase 2: Department rollout (weeks 2–3)

* Expand to engineering and high-risk user groups
* Monitor Endpoint Shield inventory in Akto

#### Phase 3: Organization-wide (week 4+)

* Assign to all managed Windows devices
* Keep daily schedule for ongoing updates

***

### Get support

1. In-app **Intercom** on the Akto dashboard
2. [Discord community](https://www.akto.io/community)
3. Email **support@akto.io**
4. [Contact Akto](https://www.akto.io/contact-us)

For onboarding values (`MANIFEST_URL`, release ZIP URLs), contact your Akto account team.
