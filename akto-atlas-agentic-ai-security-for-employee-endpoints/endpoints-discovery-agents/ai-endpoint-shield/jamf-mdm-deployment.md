---
description: >-
  Deploy AI Endpoint Shield across your macOS fleet with Jamf Pro using a single
  install.sh script with auto-update.
---

# Jamf MDM Deployment

## Overview

AI Endpoint Shield is deployed to macOS devices from **Jamf Pro** with a single script, **`install.sh`**. The script:

1. Fetches the version manifest (`latest.json`) from the URL you provide
2. Compares the installed version against the manifest and exits early if the device is already current
3. Downloads the signed and notarized `.pkg` and installs it
4. Writes `config.env` (token and feature flags) into the console user's home directory
5. Lets the pkg's embedded `postinstall` handle file placement, LaunchAgent setup, and hook installation

**No package upload to Jamf is required** — the script downloads the pkg itself, so a new Akto release reaches your fleet without touching the Jamf policy.

***

## Architecture

| Aspect | Detail |
| ------ | ------ |
| Script execution | Root (Jamf default) — auto-detects the console user |
| Installation type | Per-user (`~/.akto-endpoint-shield/`) |
| Services | LaunchAgents (run as the user, not system-wide) |
| Auto-update | Manifest (`latest.json`) — devices update at next login |
| Reinstall | `FORCE_REINSTALL=true` |
| Token storage | `~/.akto-endpoint-shield/config/` (permissions 600) |

***

## Prerequisites

### 1. AKTO\_API\_TOKEN

From the Akto platform. Deployed via a Jamf **encrypted** script parameter.

### 2. AKTO\_API\_BASE\_URL

Your Akto guardrails URL, e.g. `https://<account_id>-guardrails.akto.io`.

### 3. MANIFEST\_URL

Provided by Akto during onboarding. Devices check this URL on each run to decide whether a newer version is available — this is what enables auto-update.

### 4. Jamf Pro access

Permissions to create and edit Scripts, Policies, and (optionally) Smart Groups and Extension Attributes.

### 5. Network access

Devices need HTTPS access to the manifest and pkg hosts, to `https://<account_id>-guardrails.akto.io`, and to `https://ultron.akto.io`.

***

## Scripts

| Script | Purpose | Parameters |
| ------ | ------- | ---------- |
| `install.sh` | Install or update AI Endpoint Shield | `$4`–`$7`, below |
| `uninstall.sh` | Remove the agent, LaunchAgents, config, and MCP server wrapping | None |

Both run as **root** and auto-detect the logged-in user.

### install.sh Jamf parameters

| Parameter | Name | Value |
| --------- | ---- | ----- |
| `$4` | `AKTO_API_TOKEN` | Your token — use a **Jamf encrypted parameter** |
| `$5` | `AKTO_API_BASE_URL` | `https://<account_id>-guardrails.akto.io` |
| `$6` | `MANIFEST_URL` | Provided by Akto — enables auto-update |
| `$7` | `PKG_URL` | Direct pkg URL — fallback if `MANIFEST_URL` is not set |

Jamf reserves `$1`–`$3` (mount point, computer name, username); `install.sh` ignores them and detects the console user itself.

***

## Phase 1 — Upload scripts to Jamf Pro

Navigate to **Settings** → **Computer Management** → **Scripts** → **+ New**.

{% stepper %}
{% step %}
### Script 1: install.sh

* **Display Name:** `Akto Endpoint Shield - Install`
* **Category:** Security
* **Execution:** Root (default — do not change)
* **Parameter Labels:**
  * Parameter 4: `AKTO_API_TOKEN`
  * Parameter 5: `AKTO_API_BASE_URL`
  * Parameter 6: `MANIFEST_URL`
  * Parameter 7: `PKG_URL`

Paste the contents of `install.sh` (provided by Akto) as the script body.
{% endstep %}

{% step %}
### Script 2: uninstall.sh

* **Display Name:** `Akto Endpoint Shield - Uninstall`
* **Category:** Security
* No parameters needed

Paste the contents of `uninstall.sh` as the script body.
{% endstep %}

{% step %}
### Extension Attribute (optional but recommended)

Navigate to **Settings** → **Computer Management** → **Extension Attributes** → **+ New**.

* **Display Name:** `Akto Endpoint Shield Version`
* **Data Type:** String
* **Inventory Display:** General
* **Input Type:** Script

```bash
#!/bin/bash
USER=$(stat -f%Su /dev/console 2>/dev/null)
if [ -z "$USER" ] || [ "$USER" = "root" ] || [ "$USER" = "_mbsetupuser" ]; then
    echo "<result>Not Installed (no user logged in)</result>"
elif [ -x "/usr/local/bin/akto-endpoint-shield" ]; then
    VERSION=$(sudo -u "$USER" /usr/local/bin/akto-endpoint-shield --version 2>/dev/null | awk '{print $NF}' || echo "unknown")
    echo "<result>$VERSION</result>"
else
    echo "<result>Not Installed</result>"
fi
```

This lets you build a Smart Group (**Computers** → **Smart Computer Groups** → **+ New**) on `Akto Endpoint Shield Version is "Not Installed"` to track coverage.
{% endstep %}
{% endstepper %}

***

## Phase 2 — Create the install policy

Navigate to **Computers** → **Policies** → **+ New**.

{% stepper %}
{% step %}
### General

* **Display Name:** `Install Akto Endpoint Shield`
* **Enabled:** Yes
* **Triggers:** **Login** (add Recurring Check-in as a catch-up if you like)
* **Execution Frequency:** **Ongoing**
* **Category:** Security

**Ongoing** is what enables auto-update. The script skips the reinstall when the installed version already matches the manifest, so running on every login is cheap and safe. Use **Once per user per computer** only if you deliberately want a one-time install with no updates.
{% endstep %}

{% step %}
### Packages

Leave empty. The script downloads and installs the pkg itself — do **not** add a package to this policy.
{% endstep %}

{% step %}
### Scripts

Add **Akto Endpoint Shield - Install** with **Priority: Before**, and fill in the parameters:

| Parameter | Label | Value |
| --------- | ----- | ----- |
| `$4` | `AKTO_API_TOKEN` | `<your-token>` (encrypted parameter) |
| `$5` | `AKTO_API_BASE_URL` | `https://<account_id>-guardrails.akto.io` |
| `$6` | `MANIFEST_URL` | Provided by Akto |
| `$7` | `PKG_URL` | Leave empty — the manifest provides the URL |

Which MCP clients to protect and which hooks to install are managed from the **Akto dashboard** after install — no Jamf policy change needed.
{% endstep %}

{% step %}
### Scope

Target **All Computers** for a full rollout, or a Smart Group / department for a pilot.
{% endstep %}

{% step %}
### User Interaction and Maintenance

Leave the start and complete messages empty for a silent install. Enable **Update Inventory** so the Extension Attribute stays current.
{% endstep %}
{% endstepper %}

***

## Phase 3 — Uninstall policy (optional)

Navigate to **Computers** → **Policies** → **+ New**.

* **Display Name:** `Uninstall Akto Endpoint Shield`
* **Trigger:** **Self Service** only
* **Execution Frequency:** Ongoing
* **Scripts:** `Akto Endpoint Shield - Uninstall`, Priority: Before
* **Scope:** All Computers
* **Self Service:** Make available, with a description such as "Remove Akto Endpoint Shield from your computer. This restores your MCP server configurations to their original state."

***

## Background item approval (macOS 13+)

macOS 13 and later require every LaunchAgent label to be approved as a **background item** before `launchd` will start it. Without approval, a fully signed and notarized install can sit loaded but never running, with no logs.

Deploy a **`com.apple.servicemanagement`** configuration profile from Jamf that pre-approves Akto's Team Identifier, so users are never prompted. Without that profile, each user must approve the agent manually under **System Settings → General → Login Items & Extensions → Allow in the Background**.

Contact Akto for the Team Identifier and a sample profile payload.

***

## Updating AI Endpoint Shield

Updates are automatic. When Akto releases a new version, the `MANIFEST_URL` in your policy points at the updated package, and devices upgrade on their next login — no Jamf policy change is needed.

**To force an immediate reinstall:** set `$7 PKG_URL` to the pkg URL provided by Akto (this bypasses the manifest version check) and run the policy manually.

***

## Verification

On a pilot Mac, signed in as the target user:

```bash
# Version and provisioning state
/usr/local/bin/akto-endpoint-shield --version
/usr/local/bin/akto-endpoint-shield check-config --path ~/.akto-endpoint-shield/config

# Services — both must show a PID, not "-"
launchctl list | grep akto-endpoint-shield

# Config permissions (should be 600)
ls -la ~/.akto-endpoint-shield/config/

# Install log
tail -50 ~/.akto-endpoint-shield/logs/install.log
```

`check-config` should print `provisioned`.

### Checklist

* [ ] Policy triggers at login and reports success in Jamf
* [ ] Binary installed and executable at `/usr/local/bin/akto-endpoint-shield`
* [ ] `check-config` prints `provisioned`, config permissions are 600
* [ ] Both LaunchAgents show a PID
* [ ] Verified on both Intel and Apple Silicon
* [ ] Extension Attribute reports the version correctly
* [ ] Endpoint visible in Akto with recent activity
* [ ] Uninstall removes all components and unwraps MCP configs

***

## Troubleshooting

| Symptom | Likely cause | What to do |
| ------- | ------------ | ---------- |
| `No console user logged in` | Script ran before login | Ensure the trigger is **Login** |
| `Neither PKG_URL, PKG_PATH, nor MANIFEST_URL is set` | All three sources empty | Set `$6 MANIFEST_URL` in the policy parameters |
| `Already at latest version — nothing to do` | Manifest version matches the installed version | Expected. Set `FORCE_REINSTALL=true` to override |
| Services show `-` instead of a PID | Token missing or invalid | Run `check-config`; check `~/.akto-endpoint-shield/logs/install.log` |
| Services loaded but never start, no logs | macOS 13+ background item not approved | See [Background item approval](#background-item-approval-macos-13) |
| LaunchAgent won't load | Gatekeeper quarantined the plist | `xattr -dr com.apple.quarantine ~/Library/LaunchAgents/io.akto.akto-endpoint-shield*` |
| Files landed in `/var/root` | Policy ran with no console user, or the pkg was installed manually with `sudo installer` | Re-run at Login; remove `/var/root/.akto-endpoint-shield` |
| Device not in scope | User not in the scoped group | Verify the scope, or target All Computers |

For device-level diagnosis, see [macOS Troubleshooting](macos-troubleshooting.md). For EDR and antivirus exclusions, see [Allowlist in Security Software](allowlist-in-security-software.md).

***

## File locations

| Path | Purpose |
| ---- | ------- |
| `/usr/local/bin/akto-endpoint-shield` | Main binary |
| `/Library/Application Support/Akto/` | Read-only asset bundle installed by the pkg |
| `~/.akto-endpoint-shield/bin/akto_endpoint_shield.sh` | Per-user wrapper script |
| `~/Library/LaunchAgents/io.akto.akto-endpoint-shield.plist` | HTTP proxy service |
| `~/Library/LaunchAgents/io.akto.akto-endpoint-shield-agent.plist` | Agent service |
| `~/.akto-endpoint-shield/config/` | Token + feature flags (permissions 600) |
| `~/.akto-endpoint-shield/logs/install.log` | Install log |
| `~/.akto-endpoint-shield/logs/agent.log` | Agent runtime log |
| `~/.akto-endpoint-shield/logs/proxy-server.log` | HTTP proxy runtime log |
| `/var/log/akto-endpoint-shield-install.log` | Root-context install log |

***

## Useful Jamf commands

```bash
# Manually trigger a policy
sudo jamf policy -id <policy_id>

# Force a check-in
sudo jamf policy

# View Jamf logs
tail -f /var/log/jamf.log
```

***

## Security notes

* The token is passed via a Jamf **encrypted parameter** and written to `~/.akto-endpoint-shield/config/` with permissions 600.
* Binaries run as the user — there are no system-level daemons, and all user data stays under `~/.akto-endpoint-shield/`.
* Limit Jamf policy editing to your security team, and rotate the token on your usual schedule; the install script updates the on-disk config on its next run.

***

## Related documentation

* [Mosyle MDM Deployment](mosyle-deployment.md)
* [NinjaOne Deployment (macOS)](ninjaone-macos-deployment.md)
* [macOS Standalone Installation](macos-standalone-installation.md)
* [macOS Troubleshooting](macos-troubleshooting.md)
* [Allowlist in Security Software](allowlist-in-security-software.md)

## Get support

1. In-app Intercom in the Akto dashboard
2. [Discord community](https://www.akto.io/community)
3. [support@akto.io](mailto:support@akto.io)
4. [Contact Akto](https://www.akto.io/contact-us)
