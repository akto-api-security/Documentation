# Windows MDM Deployment

### Overview

AI Endpoint Shield can be deployed enterprise-wide on **Windows** through any **MDM or endpoint management platform** that can run PowerShell scripts as **SYSTEM** (for example Microsoft Intune, Workspace ONE, ManageEngine, Kandji for Windows, or custom RMM tools).

A single **`install.ps1`** script downloads a generic ZIP from Akto-hosted storage, installs or upgrades the agent, applies your credentials, and keeps devices current via a version manifest.

#### Why use MDM deployment?

* **Zero-touch deployment** — no manual installs on each laptop
* **Centralized credentials** — API token and guardrails URL passed as script parameters (not embedded in the ZIP)
* **Automatic updates** — devices check a version manifest on each script run
* **MDM-agnostic** — same script and parameters across vendors
* **No per-customer installer builds** — one ZIP per release works for all tenants

{% hint style="info" %}
For **macOS**, use [Jamf MDM Deployment](jamf-mdm-deployment.md). For Automox Worklets on Windows, see [Automox Deployment](automox-deployment.md).
{% endhint %}

***

### Architecture

| Aspect | Detail |
| ------ | ------ |
| Script execution | **SYSTEM** / LocalSystem (not the logged-on user) |
| PowerShell | **64-bit** (`powershell.exe`, not 32-bit WOW64) |
| Installer payload | Generic ZIP per version (hosted by Akto) |
| Credentials | `AKTO_API_TOKEN` + `AKTO_API_BASE_URL` via MDM script parameters or environment variables |
| Auto-update | `latest.json` manifest URL (provided by Akto) |
| Install location | `C:\Program Files\Akto Endpoint Shield\` |
| Services | Scheduled tasks `MCPEndpointShieldHTTP`, `MCPEndpointShieldAgent`, `MCPEndpointShieldDetector`, `MCPEndpointShieldSystemProxy` |
| Config | Per-user and SYSTEM `config.env` under `.akto-endpoint-shield\config\` |

This path uses **ZIP + `install.ps1`**, not an MSI or per-tenant `.exe` installer.

***

### Prerequisites

#### 1. AKTO\_API\_TOKEN

* From the Akto platform (Atlas / guardrails onboarding)
* Store as a **secret** in your MDM where supported

#### 2. AKTO\_API\_BASE\_URL

* Guardrails URL, e.g. `https://<account-id>-guardrails.akto.io`

#### 3. MANIFEST\_URL

* Provided by Akto during onboarding
* HTTPS URL to `latest.json` for auto-update

#### 4. INSTALLER\_URL (optional)

* Direct HTTPS URL to the ZIP — fallback if the manifest cannot be fetched

#### 5. MDM capabilities

Your platform must support:

* Running a **PowerShell script** on Windows 10/11
* Execution as **SYSTEM** (elevated machine context)
* **64-bit** PowerShell
* Recurring execution (daily recommended) for updates
* Passing **script arguments** or environment variables to the script

#### 6. Network

Managed devices need HTTPS access to:

* `MANIFEST_URL` and the ZIP host (often `*.amazonaws.com`)
* `https://<account-id>-guardrails.akto.io`
* `https://ultron.akto.io` (default data ingestion endpoint)

***

### Scripts

Akto provides:

| Script | Purpose |
| ------ | ------- |
| `install.ps1` | Install, upgrade, configure |
| `uninstall_windows.ps1` | Remove agent, tasks, and config (separate MDM assignment) |

#### install.ps1 parameters

Positional arguments (space-separated when your MDM supports a single parameter string):

| Position | Name | Required | Description |
| -------- | ---- | -------- | ----------- |
| `$1` | `MANIFEST_URL` | Yes\* | HTTPS URL to `latest.json` |
| `$2` | `INSTALLER_URL` | No | Direct ZIP URL if manifest fetch fails |
| `$3` | `AKTO_API_TOKEN` | Yes | API token |
| `$4` | `AKTO_API_BASE_URL` | Yes | Guardrails base URL |

\* Required unless only `INSTALLER_URL` / `INSTALLER_PATH` is used.

**Example (with ZIP fallback):**

```text
https://<akto-host>/atlas-installers/windows-installer/latest.json  https://<akto-host>/atlas-installers/windows-installer/<version>/akto-endpoint-shield-<version>.zip  <TOKEN>  https://<account-id>-guardrails.akto.io
```

**Example (manifest only)** — local test in PowerShell:

```powershell
.\install.ps1 "https://<manifest-url>/latest.json" "" "<TOKEN>" "https://<account-id>-guardrails.akto.io"
```

Environment variables (`MANIFEST_URL`, `AKTO_API_TOKEN`, `AKTO_API_BASE_URL`, `FORCE_REINSTALL`, etc.) are also supported if your MDM sets them instead of positional args.

***

### Deploy via your MDM

{% tabs %}
{% tab title="Microsoft Intune" %}
1. **Devices** → **Scripts** → **Add** → **Windows 10 and later**
2. Upload `install.ps1`
3. **Run as logged-on user:** No | **64-bit PowerShell:** Yes
4. Paste script parameters (manifest, optional ZIP URL, token, base URL)
5. Assign to groups; schedule **daily** for auto-update
6. Review **Device status** under the script assignment
{% endtab %}

{% tab title="Other MDM / RMM" %}
1. Create a **PowerShell** remediation or custom script policy
2. Run as **SYSTEM** / **LocalSystem** with **highest** privileges
3. Use **64-bit** PowerShell
4. Pass the four arguments (or set equivalent environment variables)
5. Schedule at least **daily** on enrolled Windows devices
6. Use your MDM's script success/failure reporting for validation
{% endtab %}
{% endtabs %}

{% hint style="warning" %}
If your MDM passes a single space-delimited string, confirm in a pilot that the token maps to argument 3 and the base URL to argument 4. Akto onboarding can provide a parameter string tested for your platform.
{% endhint %}

***

### Schedule and scope

| Phase | Scope | Frequency |
| ----- | ----- | --------- |
| Pilot | 5–10 devices | Daily, 1 week |
| Rollout | Engineering / security | Daily |
| Production | All Windows endpoints | Daily |

The script **skips downloading** the ZIP when the installed version already matches the manifest. Daily runs are safe and pick up new Akto releases automatically.

**Force full redeploy:** set `FORCE_REINSTALL=true` (environment variable) on the script assignment.

***

### What happens on the device

1. Fetches `latest.json` from `MANIFEST_URL`
2. Compares manifest `version` with `akto-endpoint-shield.exe --version`
3. If needed, downloads ZIP, stops tasks, deploys to `C:\Program Files\Akto Endpoint Shield\`
4. Writes `config.env` for interactive users and SYSTEM
5. Registers and starts scheduled tasks

MCP client and hook settings are controlled from the **Akto dashboard** after install.

***

### Updates and rollback

* **Updates:** Akto updates `latest.json`; devices upgrade on the next script run — no MDM policy change required
* **Rollback:** Akto points `latest.json` to an older versioned ZIP path
* **Emergency:** Pass a specific ZIP URL as argument 2 (`INSTALLER_URL`)

***

### Verification

On a pilot device (Administrator PowerShell):

```powershell
& "${env:ProgramW6432}\Akto Endpoint Shield\akto-endpoint-shield.exe" --version
Get-Content "$env:USERPROFILE\.akto-endpoint-shield\config\config.env" | Select-String "AKTO_API"
Get-ScheduledTask -TaskName "MCPEndpointShield*" | Format-Table TaskName, State -AutoSize
Get-Content "$env:USERPROFILE\.akto-endpoint-shield\logs\install.log" -Tail 40 -ErrorAction SilentlyContinue
Get-Process akto-endpoint-shield -ErrorAction SilentlyContinue
```

Also confirm success in your **MDM script reporting** and that the device appears under **Akto → Endpoint Shield**.

#### Checklist

* [ ] MDM reports script success on pilot devices
* [ ] Binary and version under Program Files
* [ ] `config.env` has correct token and guardrails URL
* [ ] Scheduled tasks `MCPEndpointShield*` exist
* [ ] Endpoint visible in Akto with recent activity

***

### Troubleshooting

| Symptom | Likely cause | What to do |
| ------- | ------------ | ---------- |
| Script fails immediately | Not running as SYSTEM or 32-bit PowerShell | Use 64-bit PowerShell as SYSTEM |
| Wrong config / token | Arguments shifted in MDM | Fix parameter string; test locally with explicit `""` for arg 2 |
| No upgrade | Manifest version mismatch | Contact Akto to align manifest and published ZIP |
| No processes running | Tasks failed or binary exited | Check `%ProgramData%\akto-endpoint-shield\logs\*-wrapper.log` |
| Download errors | Firewall / proxy | Allow HTTPS to manifest and ZIP URLs |

See [Whitelist Paths](whitelist-paths.md) for EDR exclusions (e.g. SentinelOne).

***

### File locations

| Path | Purpose |
| ---- | ------- |
| `C:\Program Files\Akto Endpoint Shield\akto-endpoint-shield.exe` | Main binary |
| `C:\Program Files\Akto Endpoint Shield\start-akto-mode.ps1` | Task wrapper |
| `%USERPROFILE%\.akto-endpoint-shield\config\config.env` | User configuration |
| `%ProgramData%\akto-endpoint-shield\logs\` | Install and wrapper logs |

***

### Get support

1. In-app **Intercom** on the Akto dashboard
2. [Discord community](https://www.akto.io/community)
3. **support@akto.io**
4. [Contact Akto](https://www.akto.io/contact-us)

For `MANIFEST_URL` and release artifacts, contact your Akto account team.
