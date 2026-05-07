---
description: >-
  Deploy MCP Endpoint Shield across your organization using a single script via
  Mosyle MDM.
---

# Mosyle MDM Deployment

## Overview

MCP Endpoint Shield can be deployed enterprise-wide via **Mosyle MDM** (Mobile Device Management) for seamless, automated installation across your organization's macOS devices.

## Why Use MDM Deployment?

MDM deployment provides significant advantages over manual installation:

* **Zero-touch deployment** - Automatic installation at user login
* **Centralized management** - Configure and monitor from a single Mosyle console
* **Consistent configuration** - Ensure all devices have the same security posture
* **Automated updates** - Push new versions across the organization
* **Compliance tracking** - Monitor deployment status and coverage

## Key Features of Mosyle Deployment

* **One script** handles everything: downloads the installer, deploys the token, installs to each user's home directory, and starts services automatically
* **Runs at user sign-in:** installs once per user, retries automatically if it fails
* **No PKG upload to Mosyle required:** the script downloads the installer directly from a URL provided by Akto.
* **Minimal configuration:** only 3 values to configure in the script

## Prerequisites

Before deploying MCP Endpoint Shield via Mosyle, ensure you have the following:

### 1. Akto Credentials

* **AKTO\_API\_TOKEN:** obtain from your Akto platform dashboard
* **AKTO\_API\_BASE\_URL:** your Akto instance URL (e.g. `https://<account-id>-guardrails.akto.io`)

### 2. Installer URL

* **PKG download URL:** request this from Akto (support@akto.io); Akto will provide a direct download URL for the installer
* ⚠️ **Important**: Keep this URL confidential as it's tied to your organization

### 3. Mosyle Admin Access

Permissions to create/edit and manage:

* Custom Commands
* Device Group assignments
* Execution results and logs

### 4. Device Enrolment

* Target Macs must be enrolled and appear in your Mosyle dashboard
* Devices must have internet connectivity to download the installer
* Users must be able to log in to devices for installation to trigger

## Deployment Process

{% stepper %}
{% step %}
**Prepare the Installation Script**

**1. Obtain credentials from Akto**

Contact Akto support team to request following information:

* Installation Script: `install.sh` file.
* Direct download URL for the installer (`PKG_URL`)
* Confirmation of your `AKTO_API_TOKEN`
* Your `AKTO_API_BASE_URL`

**2. Configure the installation script**

Open `install.sh` and fill in the CONFIG section at the top:

```bash
PKG_URL=""              # installer URL provided by Akto
AKTO_API_TOKEN=""       # your Akto API token
AKTO_API_BASE_URL=""    # your Akto base URL (e.g. https://<account-id>-guardrails.akto.io)
```

All other values (hook flags, wrap flags) can be left at their defaults or adjusted as needed.

{% hint style="warning" %}
#### **Security Note**

Do not commit `install.sh` with a real token to version control. Keep the filled-in copy local or in a secrets manager.
{% endhint %}
{% endstep %}

{% step %}
**Upload to Mosyle**

**1. Create Custom Command profile**

1. Log into your **Mosyle Business** console
2. Navigate to **Management** → **Custom Commands**
3. Click **Add new profile**
4. Name it: `Akto Endpoint Shield - Install`
5. Choose **Category**: Security (or create custom category)

**2. Upload the script**

1. Click the **Code** tab
2. Select code format: **Shell Script (bash)**
3. Paste the **entire contents** of your configured `install.sh` file
4. Review the pasted content for accuracy (verify CONFIG section is filled)
5. Click **Save**

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1).png" alt="" width="563"><figcaption></figcaption></figure></div>

**3. Configure execution settings**

Click the **Execution Settings** tab and configure:

<table><thead><tr><th width="234.02734375">Option</th><th>Configuration</th></tr></thead><tbody><tr><td><strong>Execute command</strong></td><td>Select: <strong>Immediately when saving the profile, upon assignment, or based on schedule or events</strong></td></tr><tr><td><strong>Execution trigger</strong></td><td>Tick Every user sign-in✅</td></tr><tr><td><strong>Schedule</strong></td><td>Only once (Event Required)✅</td></tr></tbody></table>

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (3) (1).png" alt="" width="563"><figcaption></figcaption></figure></div>

{% hint style="info" %}
#### **Why this configuration?**

This combination runs the script on each user sign-in until it succeeds, then stops. If the download fails or no user is logged in, it retries automatically at the next sign-in.

The "**only once**" setting prevents repeated executions for the same user on the same device.
{% endhint %}

Leave all other options unchecked. Click **Save** to create the profile.
{% endstep %}

{% step %}
**Deploy to Devices**

**1. Add Profile Assignment Based on Your Preferences**

*   Click **+ Add Assignment**, choose users or devices, then select and confirm your assignment.

    <div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (3).png" alt="" width="563"><figcaption></figcaption></figure></div>
* Save the Custom Commands.

The script will run the next time each assigned user signs in.

**2. Monitor deployment**

Go to **Management** → **Custom Commands**, select your profile, and click **View Results** to see execution status:

* **Success**: Installation completed
* **Pending**: Awaiting user sign-in
* **Failed**: See troubleshooting section

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1).png" alt="" width="563"><figcaption></figcaption></figure>
{% endstep %}

{% step %}
**Verify Installation**

**Verify on target device**

On a target Mac after the user has signed in, open Terminal and run:

```bash
# Check 1: Binary installed
ls -la ~/.akto-mcp-endpoint-shield/bin/mcp-endpoint-shield

# Check 2: Token configured
cat ~/.akto-mcp-endpoint-shield/config/config.env

# Check 3: Services running
launchctl list | grep mcp-endpoint-shield

# Check 4: View installation log
tail -30 /var/log/akto-mcp-endpoint-shield-install.log
```

<details>

<summary><strong>Verification checklist</strong></summary>

* [ ] Binary exists at `~/.akto-mcp-endpoint-shield/bin/mcp-endpoint-shield`
* [ ] Config file exists at `~/.akto-mcp-endpoint-shield/config/config.env`
* [ ] Config file has correct permissions (`chmod 600`)
* [ ] Token is present in config file
* [ ] Both LaunchAgents are loaded (`launchctl list`)
* [ ] Installation log shows no errors
* [ ] Mosyle shows "Success" status for this device

</details>
{% endstep %}
{% endstepper %}

## Updating Akto Endpoint Shield

1. Request the updated installer URL from Akto (support@akto.io)
2. Update `PKG_URL` in the script with the new URL
3. Edit the script in Mosyle and save — Mosyle will re-run it on next sign-in

{% hint style="danger" %}
#### **Force Upgrade**:

The script skips reinstallation if the binary is already present. To force an upgrade, run the uninstall script first (see below), then the install script will run again on next sign-in.
{% endhint %}

### Uninstall Script

To remove Akto Endpoint Shield from devices:

1. In Mosyle → **Custom Commands** → **Add new profile**
2. Paste the contents of `uninstall.sh`
3. Name it: `Akto Endpoint Shield - Uninstall`
4. Execution Settings:
   * Event: ✅ **Every user sign-in** (or trigger manually)
   * Schedule: ✅ **Only once (Event Required)**
5. Assign to the target devices

## Troubleshooting

### Issue: Script shows "Failed" in Mosyle View Results

**Symptoms**: Custom Command status shows "Failed" or "Error"

**Diagnostic command:**

```bash
tail -50 /var/log/akto-mcp-endpoint-shield-install.log
```

**Common causes and solutions:**

<table><thead><tr><th width="229.3984375">Issue</th><th>Check</th><th>Solution</th></tr></thead><tbody><tr><td><code>PKG_URL</code> is empty or unreachable</td><td>Look for URL errors in install log</td><td>Verify the URL provided by Akto is correctly pasted in CONFIG; test: <code>curl -I $PKG_URL</code></td></tr><tr><td><code>AKTO_API_TOKEN</code> is empty</td><td>Search install log for "TOKEN"</td><td>Check the CONFIG section of the script has the token value</td></tr><tr><td><code>AKTO_API_BASE_URL</code> is empty</td><td>Search install log for "BASE_URL"</td><td>Check the CONFIG section of the script has the base URL value</td></tr><tr><td>No user logged in</td><td>Check timestamp when script ran</td><td>Will retry automatically on next sign-in; no action needed</td></tr></tbody></table>

### Issue: Services Not Running After Installation

**Symptoms**: `launchctl list` shows no Akto Endpoint Shield services

**Solution - Manually load services:**

```bash
# Load both services
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/io.akto.mcp-endpoint-shield.plist
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/io.akto.mcp-endpoint-shield-agent.plist

# Verify they're running
launchctl list | grep mcp-endpoint-shield
```

### Issue: Token Needs Updating After Installation

**Symptoms**: Services running but not authenticated; logs show "AKTO\_API\_TOKEN not configured"

**Solution:**

Edit the script in Mosyle with the new token. Then on the device:

```bash
# Manually redeploy config
cat > ~/.akto-mcp-endpoint-shield/config/config.env <<EOF
AKTO_API_TOKEN=new-token-here
EOF
chmod 600 ~/.akto-mcp-endpoint-shield/config/config.env

# Restart services
launchctl bootout gui/$(id -u)/io.akto.mcp-endpoint-shield
launchctl bootout gui/$(id -u)/io.akto.mcp-endpoint-shield-agent
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/io.akto.mcp-endpoint-shield.plist
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/io.akto.mcp-endpoint-shield-agent.plist
```

## Support

* **For Akto platform issues**: [support@akto.io](mailto:support@akto.io)
* **For Mosyle issues**: your IT administrator
