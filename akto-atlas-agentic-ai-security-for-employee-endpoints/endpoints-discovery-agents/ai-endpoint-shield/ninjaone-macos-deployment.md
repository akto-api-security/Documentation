---
description: >-
  Deploy AI Endpoint Shield to macOS endpoints from NinjaOne using the install.sh
  script on a recurring schedule.
---

# NinjaOne Deployment (macOS)

## Overview

Deploy **AI Endpoint Shield** to macOS endpoints from NinjaOne by storing Akto's **`install.sh`** in the NinjaOne Automation Library and running it as a scheduled script.

`install.sh` is the same script used for [Jamf MDM Deployment](jamf-mdm-deployment.md). It:

1. Fetches the version manifest (`latest.json`) from the URL you provide
2. Compares the installed version against the manifest and exits early if the device is already current
3. Downloads the signed and notarized `.pkg` and installs it
4. Writes `config.env` (token and feature flags) into the console user's home directory
5. Lets the pkg's embedded `postinstall` handle file placement, LaunchAgent setup, and hook installation

Because step 2 makes the script a no-op on an up-to-date device, the same policy handles both the initial install and every subsequent update on a recurring schedule. **No package upload to NinjaOne is required.**

## Prerequisites

* NinjaOne admin access with script and policy permissions
* A macOS device policy in NinjaOne
* `install.sh` from Akto, plus your `MANIFEST_URL`
* Your `AKTO_API_TOKEN` and `AKTO_API_BASE_URL` (e.g. `https://<account_id>-guardrails.akto.io`)
* A pilot device group for a staged rollout
* Devices need HTTPS access to the manifest and pkg hosts, to `https://<account_id>-guardrails.akto.io`, and to `https://ultron.akto.io`

## install.sh configuration

`install.sh` reads its values from environment variables, falling back to the `CONFIG` block at the top of the script. NinjaOne has no encrypted script-parameter field equivalent to Jamf's, so set the values in the **`CONFIG` section of the script body** before uploading:

| Variable | Required | Description |
| -------- | -------- | ----------- |
| `MANIFEST_URL` | Recommended | HTTPS URL to `latest.json` — this is what enables auto-update |
| `AKTO_API_TOKEN` | Yes | Your Akto API token |
| `AKTO_API_BASE_URL` | Yes | Your guardrails URL, e.g. `https://<account_id>-guardrails.akto.io` |
| `PKG_URL` | Fallback | Direct HTTPS URL to the `.pkg`, used only if `MANIFEST_URL` is not set |
| `FORCE_REINSTALL` | No | `true` forces a reinstall even when the version already matches |

All other values — hook flags, MCP wrap flags, TCC guard — can be left at their defaults; they are managed from the **Akto dashboard** after install.

{% hint style="warning" %}
The configured copy of `install.sh` contains a live token. Keep it in NinjaOne or a secrets manager — do not commit it to version control.
{% endhint %}

## Deployment Steps

{% stepper %}
{% step %}
### Create the automation script

In NinjaOne:

1. Go to **Administration → Library → Automation**
2. Click **Add** and choose **Script**
3. Configure:
   * **Name:** `Akto Endpoint Shield - macOS Install`
   * **Language:** ShellScript
   * **Operating System:** macOS
   * **Run As:** **System** (root)
4. Paste the full contents of your configured `install.sh` as the script body
5. Save

{% hint style="info" %}
Keep **Run As = System**. The script runs as root and detects the logged-in console user itself, then installs into that user's home directory. Running it as the user directly will fail to install the pkg.
{% endhint %}
{% endstep %}

{% step %}
### Attach to a policy and schedule

1. Open the target **macOS policy**
2. Add a **Scheduled Script** and select `Akto Endpoint Shield - macOS Install`
3. Schedule:
   * **Pilot:** run once immediately against a small device group
   * **Production:** run **daily**
4. Save the policy

A daily schedule is what keeps devices updated. When Akto publishes a new release it updates `latest.json`, and devices upgrade on the next run with no policy change. On a device that is already current, the script logs `Already at latest version — nothing to do` and exits.
{% endstep %}

{% step %}
### Validate on an endpoint

Run on a pilot Mac, signed in as the target user:

```bash
/usr/local/bin/akto-endpoint-shield --version
/usr/local/bin/akto-endpoint-shield check-config --path ~/.akto-endpoint-shield/config
launchctl list | grep akto-endpoint-shield
tail -50 ~/.akto-endpoint-shield/logs/install.log
```

Expected:

* A version string matching the manifest
* `check-config` prints `provisioned`
* Both LaunchAgents (`io.akto.akto-endpoint-shield` and `io.akto.akto-endpoint-shield-agent`) show a **PID**, not `-`
* The device appears under **Akto → Endpoint Shield** with recent activity
{% endstep %}
{% endstepper %}

## Uninstall

Create a second automation script from Akto's `uninstall.sh` (ShellScript, macOS, **Run As: System**), and run it on demand against the target devices. It takes no parameters and also unwraps any MCP server configurations it changed.

## Troubleshooting

| Symptom | Likely cause | What to do |
| ------- | ------------ | ---------- |
| `No console user logged in` | Script ran with nobody signed in | Expected — it installs on the next scheduled run once a user is logged in |
| `Neither PKG_URL, PKG_PATH, nor MANIFEST_URL is set` | The `CONFIG` block was left empty | Set `MANIFEST_URL` in the script body |
| `Already at latest version — nothing to do` | Manifest version matches the installed version | Expected. Set `FORCE_REINSTALL=true` to override |
| Services show `-` instead of a PID | Token missing or invalid | Check `~/.akto-endpoint-shield/logs/install.log`, and run `check-config` |
| LaunchAgent won't load | Gatekeeper quarantined the plist | `xattr -dr com.apple.quarantine ~/Library/LaunchAgents/io.akto.akto-endpoint-shield*` |
| Services loaded but never start | macOS 13+ background item not approved | See [macOS Troubleshooting](macos-troubleshooting.md#background-items-btm-approval) — this needs an MDM `com.apple.servicemanagement` profile or manual approval |

For device-level diagnosis, see [macOS Troubleshooting](macos-troubleshooting.md). For EDR and antivirus exclusions, see [Allowlist in Security Software](allowlist-in-security-software.md).

## Related Documentation

* [Jamf MDM Deployment](jamf-mdm-deployment.md)
* [Mosyle MDM Deployment](mosyle-deployment.md)
* [NinjaOne Deployment (Windows)](ninjaone-windows-deployment.md)

## Support

1. In-app Intercom in the Akto dashboard
2. [Discord community](https://www.akto.io/community)
3. [support@akto.io](mailto:support@akto.io)
4. [Contact Akto](https://www.akto.io/contact-us)
