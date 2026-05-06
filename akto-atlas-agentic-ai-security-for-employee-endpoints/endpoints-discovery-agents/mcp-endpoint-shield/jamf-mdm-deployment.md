# Jamf MDM Deployment

### Overview

MCP Endpoint Shield can be deployed enterprise-wide via **Jamf Pro** for seamless, automated installation across your organization's macOS devices.

#### Why Use MDM Deployment?

MDM deployment provides significant advantages over manual installation:

* **Zero-touch deployment** - Automatic installation at user login
* **Centralized management** - Configure and monitor from a single console
* **Consistent configuration** - Ensure all devices have the same security posture
* **Automated updates** - Devices automatically pull the latest version on each login
* **Compliance tracking** - Monitor deployment status and coverage

#### Supported Platforms

* ✅ **Jamf Pro** - Enterprise MDM solution

***

### Architecture

| Aspect | Detail |
| ------ | ------ |
| Script execution | Root (Jamf default) — auto-detects console user |
| Installation type | Per-user (`~/.akto-endpoint-shield/`) |
| Services | LaunchAgents (run as user, not system-wide) |
| Auto-update | Manifest (`latest.json`) — devices update at next login |
| Reinstall | `FORCE_REINSTALL=true` Jamf parameter |
| Token storage | `~/.akto-endpoint-shield/config/config.env` (permissions 600) |

***

### Prerequisites

Before deploying via Jamf, ensure you have the following:

#### 1. AKTO\_API\_TOKEN

* Obtain from the Akto platform
* Will be deployed securely via Jamf encrypted parameters

#### 2. AKTO\_API\_BASE\_URL

* Your Akto data ingestion URL (e.g. `https://<account-id>-guardrails.akto.io`)

#### 3. MANIFEST\_URL

* Provided by Akto during onboarding
* Enables auto-update: devices check this URL on each login to determine if a newer version is available

#### 4. Jamf Pro Access

Permissions to create/edit:

* Scripts
* Policies
* Smart Groups (optional)
* Extension Attributes (optional)

***

### Deployment Script

This deployment uses a **single script** (`install.sh`). The script:

1. Fetches the latest version manifest (`latest.json`) from the URL you provide
2. Compares installed version vs manifest — skips if already up to date
3. Downloads the signed/notarized `.pkg` and installs it
4. Writes `config.env` (token, feature flags) to the user's home directory
5. The pkg's embedded `postinstall` handles file placement, LaunchAgent setup, and hook installation

**No manual package upload to Jamf is required.**

#### install.sh

* **Purpose**: Install or update Akto Endpoint Shield
* **Run as**: Root (auto-detects logged-in user)
* **Parameter 4**: `AKTO_API_TOKEN` (encrypted)
* **Parameter 5**: `AKTO_API_BASE_URL`
* **Parameter 6**: `MANIFEST_URL` (provided by Akto — enables auto-update)
* **Parameter 7**: `PKG_URL` (direct pkg URL — fallback if MANIFEST\_URL not set)

#### uninstall.sh

* **Purpose**: Removes Akto Endpoint Shield from user's system
* **Run as**: Root (auto-detects logged-in user)
* **Cleanup**: Includes removal of MCP server configurations

***

### Phase 1: Upload Scripts to Jamf Pro

Navigate to **Settings** → **Computer Management** → **Scripts** → **+ New**

**Script 1: install.sh**

* **Display Name**: Akto Endpoint Shield - Install
* **Category**: Security
* **Execution**: Root (default — do not change)
* **Parameter Labels**:
  * Parameter 4: `AKTO_API_TOKEN`
  * Parameter 5: `AKTO_API_BASE_URL`
  * Parameter 6: `MANIFEST_URL` (provided by Akto — enables auto-update)
  * Parameter 7: `PKG_URL` (direct pkg URL — fallback if MANIFEST\_URL not used)

Paste the contents of `install.sh` (provided by Akto) as the script body.

**Script 2: uninstall.sh**

* **Display Name**: Akto Endpoint Shield - Uninstall
* **Category**: Security
* No parameters needed

Paste the contents of `uninstall.sh` (provided by Akto) as the script body.

#### Extension Attribute (Optional but Recommended)

Navigate to **Settings** → **Computer Management** → **Extension Attributes** → **+ New**

* **Display Name**: Akto Endpoint Shield Version
* **Description**: Reports installed version of Akto Endpoint Shield
* **Data Type**: String
* **Inventory Display**: General
* **Input Type**: Script

**Script**:

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

#### Smart Group (Optional)

Navigate to **Computers** → **Smart Computer Groups** → **+ New**

* **Name**: Akto Endpoint Shield Not Installed
* **Criteria**:
  * Extension Attribute "Akto Endpoint Shield Version" is "Not Installed"
  * Operating System Version greater than or equal to 10.13.x

***

### Phase 2: Create Jamf Policy

Navigate to **Computers** → **Policies** → **+ New**

#### General Settings

* **Display Name**: Install Akto Endpoint Shield
* **Enabled**: Yes
* **Triggers**:
  * ✅ **Login** (user login trigger)
  * ✅ Recurring Check-in (optional, for catch-up)
* **Execution Frequency**: **Once per user per computer**

  > For auto-updates: change frequency to **Ongoing** — the script skips reinstall if already at the latest version (based on the manifest), so running on every login is safe.
* **Category**: Security

#### No Package Required

The script downloads and installs the pkg automatically. Do **not** add a package to this policy.

#### Scripts

Add **Akto Endpoint Shield - Install** with **Priority: Before**

**Parameter Values:**

| Parameter | Label | Value |
| --------- | ----- | ----- |
| $4 | AKTO\_API\_TOKEN | `<your-token>` (use Jamf encrypted parameter) |
| $5 | AKTO\_API\_BASE\_URL | `https://<account-id>-guardrails.akto.io` |
| $6 | MANIFEST\_URL | Provided by Akto — enables auto-update |
| $7 | PKG\_URL | (leave empty — manifest provides the URL) |

> Configuration (which MCP clients to protect, hook settings) is managed via the Akto dashboard after install — no Jamf policy changes needed.

#### Scope

Choose one of the following scoping options:

**Option A: Target Specific Group**

* **Targets**: Smart Group "Akto Endpoint Shield Not Installed"

**Option B: All Computers (install + auto-update)**

* **Targets**: All Computers
* **Frequency**: Ongoing

**Option C: Specific Departments/Locations**

* **Targets**:
  * Department: Engineering, Security, etc.
  * Location: Office A, Remote Workers, etc.

#### User Interaction (Optional)

* **Start Message**: Leave empty for silent installation
* **Complete Message**: "Akto Endpoint Shield has been installed to protect your MCP servers."
* Or leave both empty for completely silent deployment

#### Maintenance

* **Update Inventory**: Yes (recommended)

***

### Phase 3: Create Uninstall Policy (Optional)

Navigate to **Computers** → **Policies** → **+ New**

#### General Settings

* **Display Name**: Uninstall Akto Endpoint Shield
* **Enabled**: Yes
* **Triggers**:
  * ✅ **Self Service** (user-initiated only for safety)
* **Execution Frequency**: Ongoing
* **Category**: Security

#### Scripts

* Select: **Akto Endpoint Shield - Uninstall**
* Priority: Before

#### Scope

* **Targets**: All Computers (available to all, but Self Service only)

#### Self Service

* **Make the policy available in Self Service**: Yes
* **Display Name**: Uninstall Akto Endpoint Shield
* **Description**: "Remove Akto Endpoint Shield from your computer. This will restore your MCP server configurations to their original state."
* **Icon**: Upload Akto icon if available
* **Category**: Security

***

### Updating Akto Endpoint Shield

Updates are handled automatically. When Akto releases a new version, the `MANIFEST_URL` you configured in your Jamf policy will point to the updated package. Devices check this URL on each login and update if a newer version is available — no changes to your Jamf policy are needed.

**To force an immediate reinstall**: Set Jamf parameter `$7 PKG_URL` to the pkg URL provided by Akto (bypasses the manifest version check) and run the policy manually.

***

### Testing

#### Test Plan

1. **Create Test Group**
   * Create a Smart Group: "Akto Shield Test Group"
   * Add 2-3 test computers to the group
2. **Scope Policy to Test Group**
   * Edit your installation policy
   * Change scope to target only "Akto Shield Test Group"
3. **Test on First Machine**
   * Log in as test user
   * Policy should trigger automatically at login
   * Verify installation:

     ```bash
     /usr/local/bin/akto-endpoint-shield --version
     launchctl list | grep akto-endpoint-shield
     cat ~/.akto-endpoint-shield/config/config.env
     tail -50 ~/.akto-endpoint-shield/logs/install.log
     ```
4. **Verify Functionality**
   * Services running: `launchctl list | grep akto-endpoint-shield`
   * Config: `ls -la ~/.akto-endpoint-shield/config/config.env` (check permissions are 600)
   * Live logs: `tail -f ~/.akto-endpoint-shield/logs/*.log`
5. **Test on Multiple Architectures**
   * Test on Intel Mac
   * Test on Apple Silicon Mac
   * Verify universal binary works on both
6. **Test Uninstallation**
   * Run uninstall from Self Service
   * Verify complete removal
   * Check MCP configs are unwrapped

#### Verification Checklist

* [ ] Scripts upload successfully to Jamf
* [ ] Policy triggers at login
* [ ] Token deployed with correct permissions (600)
* [ ] Binary installed and executable at `/usr/local/bin/akto-endpoint-shield`
* [ ] Services start automatically
* [ ] Agent discovers MCP configurations
* [ ] HTTP proxy responds (check logs)
* [ ] Works on Intel Macs
* [ ] Works on Apple Silicon Macs
* [ ] Extension Attribute reports version correctly
* [ ] Uninstall removes all components
* [ ] Uninstall restores MCP configs

***

### Rollout Strategy

#### Phase 1: Pilot (Week 1)

* Deploy to 5-10 test users
* Monitor for issues
* Gather feedback
* Verify no conflicts with existing tools

#### Phase 2: Department Rollout (Week 2-3)

* Deploy to engineering/security teams first
* Monitor service health
* Address any issues
* Expand to other departments incrementally

#### Phase 3: Organization-Wide (Week 4+)

* Scope policy to all computers with **Ongoing** frequency
* Monitor deployment metrics
* Provide user support/documentation
* Track compliance via Extension Attribute

***

### Troubleshooting

| Error | Cause | Fix |
| ----- | ----- | --- |
| `No console user logged in` | Script ran before login | Ensure trigger is **Login** |
| `Neither PKG_URL, PKG_PATH, nor MANIFEST_URL is set` | All three sources empty | Set `$6 MANIFEST_URL` in Jamf policy parameters |
| Services show `-` (not running) | Token missing or invalid | Check `~/.akto-endpoint-shield/logs/install.log` |
| `Already at latest version — nothing to do` | Manifest version matches installed | Expected — set `FORCE_REINSTALL=true` to override |
| LaunchAgent won't load (quarantine) | Gatekeeper blocked plist | `xattr -dr com.apple.quarantine ~/Library/LaunchAgents/io.akto.akto-endpoint-shield*` |
| User not in scope | User not in scoped group | Verify user is in scoped group or change scope to All Computers |
| Policy frequency wrong | Policy set to "Once per computer" | Change frequency to "Once per user per computer" |

***

### Security Considerations

#### Token Storage

* **Location**: `~/.akto-endpoint-shield/config/config.env`
* **Permissions**: 600 (readable only by owner)
* **Encryption**: Token passed via Jamf encrypted parameter (parameter 4)
* **Access Control**: Limit Jamf policy editing to security team

#### Best Practices

**1. Rotate Tokens Regularly**

* Update token in Jamf policy
* Install script updates `config.env` on next run
* Consider 90-day rotation schedule

**2. Monitor Deployments**

* Use Extension Attribute to track deployment status
* Create Smart Group for failed installations
* Review Jamf logs regularly

**3. Least Privilege**

* Binaries run as user, not system
* No system-level daemons
* All user data confined to `~/.akto-endpoint-shield/`

**4. Audit Trail**

* Jamf logs all script executions
* Akto Endpoint Shield logs all activity in `~/.akto-endpoint-shield/logs/`
* Token deployment is timestamped

***

### File Locations

| Path | Purpose |
| ---- | ------- |
| `/usr/local/bin/akto-endpoint-shield` | Main binary |
| `~/.akto-endpoint-shield/bin/akto_endpoint_shield.sh` | Wrapper script |
| `~/Library/LaunchAgents/io.akto.akto-endpoint-shield.plist` | HTTP proxy service |
| `~/Library/LaunchAgents/io.akto.akto-endpoint-shield-agent.plist` | Agent service |
| `~/.akto-endpoint-shield/config/config.env` | Token + feature flags (permissions 600) |
| `~/.akto-endpoint-shield/logs/install.log` | Install log (readable without sudo) |
| `~/.akto-endpoint-shield/logs/agent.log` | Agent runtime log |
| `~/.akto-endpoint-shield/logs/proxy-server.log` | HTTP proxy runtime log |

***

### Useful Commands

#### Check Installation Status

```bash
# Check version
/usr/local/bin/akto-endpoint-shield --version

# One-shot status check
echo "=== Version ===" && /usr/local/bin/akto-endpoint-shield --version && \
echo "=== Services ===" && launchctl list | grep akto-endpoint-shield && \
echo "=== Config ===" && ls -la ~/.akto-endpoint-shield/config/config.env && \
echo "=== Claude hooks ===" && jq '.hooks | keys' ~/.claude/settings.json 2>/dev/null || echo "not configured"
```

#### Check Services

```bash
# Check services (both must have a PID, not -)
launchctl list | grep akto-endpoint-shield

# View install log
tail -50 ~/.akto-endpoint-shield/logs/install.log

# View live logs
tail -f ~/.akto-endpoint-shield/logs/*.log
```

#### Check Configuration

```bash
# Check token and feature flags
cat ~/.akto-endpoint-shield/config/config.env
```

#### Jamf Commands

```bash
# Manually trigger Jamf policy
sudo jamf policy -id <policy_id>

# Force policy check-in
sudo jamf policy

# View Jamf logs
tail -f /var/log/jamf.log
```

***

### Jamf Policy Parameters Reference

| Parameter | Value | Description |
| --------- | ----- | ----------- |
| $4 | AKTO\_API\_TOKEN | Token for Akto Endpoint Shield (use Jamf encrypted parameter) |
| $5 | AKTO\_API\_BASE\_URL | Akto data ingestion URL (e.g. `https://<account-id>-guardrails.akto.io`) |
| $6 | MANIFEST\_URL | Provided by Akto — enables auto-update |
| $7 | PKG\_URL | Direct pkg URL — fallback if MANIFEST\_URL not set |

### Support

* **Jamf Issues**: IT Helpdesk
* **Akto Endpoint Shield Issues**: Security Team
* **Token Issues**: Security Team
* **Akto Platform**: support@akto.io

### Related Documentation

* [MCP Endpoint Shield Overview](./) - General installation and manual setup
* [Cursor Hooks](../cursor-hooks.md) - Alternative: Zero-installation hooks for Cursor IDE
* [Claude CLI Hooks](../claude-cli-hooks.md) - Alternative: Zero-installation hooks for Claude CLI
* [Gemini CLI Hooks](../gemini-cli-hooks.md) - Alternative: Zero-installation hooks for Gemini CLI
* [MCP Security](../../../readme/mcp-security.md) - Security concepts and best practices

***

## Deprecated: Legacy Deployment (deploy\_token.sh + .pkg)

{% hint style="warning" %}
This approach is deprecated. It only supports one-time installation and requires manual package uploads to Jamf for every update. Use the [new approach](#deployment-script) above for auto-update support.
{% endhint %}

The legacy approach used three separate scripts and required uploading a `.pkg` file to Jamf for each release.

### Legacy Architecture

* **Installation Type**: User-level (installs to `~/.local/bin/`)
* **Services**: LaunchAgents (runs as user, not system-wide)
* **Token Management**: External configuration file (`~/.config/mcp-endpoint-shield/config.env`)
* **Binary**: Universal (Intel + Apple Silicon support)
* **Deployment**: Automated at login via Jamf policy
* **Security**: True user-level operation - no root privileges required

### Legacy Scripts

#### deploy\_token.sh

* **Purpose**: Deploys AKTO\_API\_TOKEN to user's config directory
* **Run as**: Logged-in user (NOT root)
* **Jamf Parameter 4**: AKTO\_API\_TOKEN (encrypted)
* **Jamf Parameter 5**: AKTO\_API\_BASE\_URL

#### install\_from\_staging.sh

* **Purpose**: Installs MCP Endpoint Shield in user context
* **Run as**: Logged-in user (NOT root)
* **Auto-detects**: Package from Jamf cache

#### uninstall.sh

* **Purpose**: Removes MCP Endpoint Shield from user's system

### Legacy Upload Steps

1. Upload `mcp-endpoint-shield-Jamf-Installer.pkg` via **Settings** → **Computer Management** → **Packages**
2. Upload `deploy_token.sh` as "MCP Endpoint Shield - Deploy Token" with parameters:
   * Parameter 4: `AKTO_API_TOKEN`
   * Parameter 5: `AKTO_API_BASE_URL`
3. Upload `install_from_staging.sh` as "MCP Endpoint Shield - Install User Package"
4. Create policy with:
   * **Script 1**: Deploy Token (Priority: Before) — with token parameters
   * **Script 2**: Install User Package (Priority: After)
   * **Package**: MCP Endpoint Shield pkg
   * **Frequency**: Once per user per computer

### Legacy File Locations

| Path | Purpose |
| ---- | ------- |
| `~/.local/bin/mcp-endpoint-shield` | Main binary |
| `~/.local/bin/mcp_endpoint_shield.sh` | Wrapper script |
| `~/Library/LaunchAgents/io.akto.mcp-endpoint-shield.plist` | HTTP service |
| `~/Library/LaunchAgents/io.akto.mcp-endpoint-shield-agent.plist` | Agent service |
| `~/.config/mcp-endpoint-shield/config.env` | Token configuration |
| `~/.local/share/mcp-endpoint-shield/logs/` | Application logs |
| `~/.mcp-endpoint-shield/mcp_audit_info.db` | Audit database |
