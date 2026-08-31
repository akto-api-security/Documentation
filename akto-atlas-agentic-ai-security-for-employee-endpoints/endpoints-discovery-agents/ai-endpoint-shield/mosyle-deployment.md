---
description: >-
  Deploy AI Endpoint Shield across your macOS fleet with Mosyle MDM using a
  single install.sh Custom Command with auto-update.
---

# Mosyle MDM Deployment

## Overview

AI Endpoint Shield is deployed to macOS devices from **Mosyle** with a single script, **`install.sh`** — the same script used for [Jamf MDM Deployment](jamf-mdm-deployment.md). It runs as a Mosyle **Custom Command** at user sign-in and:

1. Fetches the version manifest (`latest.json`) from the URL you provide
2. Compares the installed version against the manifest and exits early if the device is already current
3. Downloads the signed and notarized `.pkg` and installs it
4. Writes `config.env` (token and feature flags) into the console user's home directory
5. Lets the pkg's embedded `postinstall` handle file placement, LaunchAgent setup, and hook installation

**No package upload to Mosyle is required** — the script downloads the pkg itself, so a new Akto release reaches your fleet without touching the Custom Command.

Mosyle has no encrypted script-parameter field equivalent to Jamf's `$4`–`$7`, so the values are set in the **`CONFIG` block at the top of the script** instead.

***

## Architecture

| Aspect | Detail |
| ------ | ------ |
| Script execution | Root (Mosyle default) — auto-detects the console user |
| Installation type | Per-user (`~/.akto-endpoint-shield/`) |
| Services | LaunchAgents (run as the user, not system-wide) |
| Auto-update | Manifest (`latest.json`) — devices update at next sign-in |
| Reinstall | `FORCE_REINSTALL=true` |
| Token storage | `~/.akto-endpoint-shield/config/` (permissions 600) |

***

## Prerequisites

### 1. Akto credentials

* **`AKTO_API_TOKEN`** — from the Akto platform
* **`AKTO_API_BASE_URL`** — your guardrails URL, e.g. `https://<account_id>-guardrails.akto.io`

### 2. MANIFEST\_URL

Provided by Akto during onboarding. This is what enables auto-update: devices check it on each run to decide whether a newer version is available.

### 3. Mosyle admin access

Permissions to create and manage Custom Commands, device group assignments, and execution results.

### 4. Device enrolment

Target Macs must be enrolled and visible in your Mosyle dashboard, with internet access to the manifest and pkg hosts, to `https://<account_id>-guardrails.akto.io`, and to `https://ultron.akto.io`.

***

## install.sh configuration

`install.sh` reads its values from environment variables, falling back to the `CONFIG` block at the top of the script. Fill in these four before uploading:

| Variable | Required | Description |
| -------- | -------- | ----------- |
| `MANIFEST_URL` | Recommended | HTTPS URL to `latest.json` — this is what enables auto-update |
| `AKTO_API_TOKEN` | Yes | Your Akto API token |
| `AKTO_API_BASE_URL` | Yes | `https://<account_id>-guardrails.akto.io` |
| `PKG_URL` | Fallback | Direct HTTPS URL to the `.pkg`, used only if `MANIFEST_URL` is not set |
| `FORCE_REINSTALL` | No | `true` forces a reinstall even when the version already matches |

```bash
MANIFEST_URL="https://<manifest-url>/latest.json"   # provided by Akto — enables auto-update
AKTO_API_TOKEN=""                                    # your Akto API token
AKTO_API_BASE_URL=""                                 # https://<account_id>-guardrails.akto.io
PKG_URL=""                                           # leave empty when MANIFEST_URL is set
```

All other values — hook flags, MCP wrap flags, TCC guard — can be left at their defaults; they are managed from the **Akto dashboard** after install.

{% hint style="warning" %}
**Security note.** The configured copy of `install.sh` contains a live token. Keep it in Mosyle or a secrets manager — do not commit it to version control.
{% endhint %}

***

## Deployment

{% stepper %}
{% step %}
### Request the artifacts from Akto

Contact [support@akto.io](mailto:support@akto.io) for:

* `install.sh` and `uninstall.sh`
* Your `MANIFEST_URL`
* Confirmation of your `AKTO_API_TOKEN` and `AKTO_API_BASE_URL`

Fill in the `CONFIG` block as described above.
{% endstep %}

{% step %}
### Create the Custom Command profile

1. Log in to your **Mosyle Business** console
2. Navigate to **Management** → **Custom Commands**
3. Click **Add new profile**
4. Name it `Akto Endpoint Shield - Install`
5. Set **Category:** Security
{% endstep %}

{% step %}
### Upload the script

1. Open the **Code** tab
2. Select code format: **Shell Script (bash)**
3. Paste the **entire contents** of your configured `install.sh`
4. Verify the `CONFIG` section is filled in
5. Click **Save**

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
### Configure execution settings

Open the **Execution Settings** tab and configure:

<table><thead><tr><th width="234.02734375">Option</th><th>Configuration</th></tr></thead><tbody><tr><td><strong>Execute command</strong></td><td>Select: <strong>Immediately when saving the profile, upon assignment, or based on schedule or events</strong></td></tr><tr><td><strong>Execution trigger</strong></td><td>Tick <strong>Every user sign-in</strong> ✅</td></tr><tr><td><strong>Schedule</strong></td><td><strong>Always (Event Required)</strong> ✅</td></tr></tbody></table>

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (3) (1).png" alt="" width="563"><figcaption></figcaption></figure></div>

{% hint style="info" %}
**Why run on every sign-in?**

This is what enables auto-update. `install.sh` checks the manifest against the installed version and exits early when the device is already current, so re-running costs a single HTTPS request. When Akto publishes a new release, devices upgrade on the next sign-in with no change to the Custom Command.

If you deliberately want a one-time install with no updates, use **Only once (Event Required)** instead — the command then stops running after its first success, and updates require re-saving the profile.
{% endhint %}

Leave all other options unchecked and click **Save**.
{% endstep %}

{% step %}
### Assign to devices

Click **+ Add Assignment**, choose the target users or devices, and confirm. Save the Custom Command.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (3).png" alt="" width="563"><figcaption></figcaption></figure></div>

The script runs the next time each assigned user signs in.
{% endstep %}

{% step %}
### Monitor deployment

Go to **Management** → **Custom Commands**, select the profile, and click **View Results**:

* **Success** — installation completed
* **Pending** — awaiting user sign-in
* **Failed** — see [Troubleshooting](#troubleshooting)

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1).png" alt="" width="563"><figcaption></figcaption></figure>
{% endstep %}
{% endstepper %}

***

## Background item approval (macOS 13+)

macOS 13 and later require every LaunchAgent label to be approved as a **background item** before `launchd` will start it. Without approval, a fully signed and notarized install can sit loaded but never running, with no logs.

Deploy a **`com.apple.servicemanagement`** configuration profile from Mosyle that pre-approves Akto's Team Identifier, so users are never prompted. Without that profile, each user must approve the agent manually under **System Settings → General → Login Items & Extensions → Allow in the Background**.

Contact Akto for the Team Identifier and a sample profile payload.

***

## Verification

On a target Mac after the user has signed in:

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

* [ ] Mosyle shows **Success** for the device
* [ ] Binary installed and executable at `/usr/local/bin/akto-endpoint-shield`
* [ ] `check-config` prints `provisioned`, config permissions are 600
* [ ] Both LaunchAgents show a PID
* [ ] Endpoint visible in Akto with recent activity

***

## Updating AI Endpoint Shield

With **Every user sign-in** + **Always (Event Required)**, updates are automatic: Akto updates `latest.json`, and devices upgrade on the next sign-in. No change to the Custom Command is needed.

**To force an immediate reinstall on all devices:** edit the script in Mosyle, set `FORCE_REINSTALL="true"`, save, and let it run — then set it back to `false`.

## Uninstall

1. In Mosyle → **Custom Commands** → **Add new profile**
2. Paste the contents of `uninstall.sh` (it takes no configuration)
3. Name it `Akto Endpoint Shield - Uninstall`
4. Execution Settings: trigger **Every user sign-in**, schedule **Only once (Event Required)**
5. Assign to the target devices

Remember to unassign the install profile first, or it will reinstall at the next sign-in.

***

## Troubleshooting

| Symptom | Likely cause | What to do |
| ------- | ------------ | ---------- |
| Mosyle shows **Failed** | See the install log | `tail -50 ~/.akto-endpoint-shield/logs/install.log` and `/var/log/akto-endpoint-shield-install.log` |
| `Neither PKG_URL, PKG_PATH, nor MANIFEST_URL is set` | `CONFIG` block left empty | Set `MANIFEST_URL` in the script body |
| `AKTO_API_TOKEN` empty in the log | `CONFIG` block missing the token | Fill in `AKTO_API_TOKEN` and re-save the profile |
| `No console user logged in` | Command ran with nobody signed in | Expected — it retries at the next sign-in |
| `Already at latest version — nothing to do` | Manifest version matches the installed version | Expected. Set `FORCE_REINSTALL="true"` to override |
| Services show `-` instead of a PID | Token missing or invalid | Run `check-config`; check the install log |
| Services loaded but never start, no logs | macOS 13+ background item not approved | See [Background item approval](#background-item-approval-macos-13) |
| Manifest URL unreachable | Firewall or proxy | `curl -I "$MANIFEST_URL"` from the device |

For device-level diagnosis, see [macOS Troubleshooting](macos-troubleshooting.md). For EDR and antivirus exclusions, see [Allowlist in Security Software](allowlist-in-security-software.md).

***

## File locations

| Path | Purpose |
| ---- | ------- |
| `/usr/local/bin/akto-endpoint-shield` | Main binary |
| `/Library/Application Support/Akto/` | Read-only asset bundle installed by the pkg |
| `~/Library/LaunchAgents/io.akto.akto-endpoint-shield.plist` | HTTP proxy service |
| `~/Library/LaunchAgents/io.akto.akto-endpoint-shield-agent.plist` | Agent service |
| `~/.akto-endpoint-shield/config/` | Token + feature flags (permissions 600) |
| `~/.akto-endpoint-shield/logs/install.log` | Install log |
| `/var/log/akto-endpoint-shield-install.log` | Root-context install log |

***

## Related documentation

* [Jamf MDM Deployment](jamf-mdm-deployment.md)
* [NinjaOne Deployment (macOS)](ninjaone-macos-deployment.md)
* [macOS Troubleshooting](macos-troubleshooting.md)

## Get support

1. In-app Intercom in the Akto dashboard
2. [Discord community](https://www.akto.io/community)
3. [support@akto.io](mailto:support@akto.io)
