# Jamf MDM Deployment

### Overview

MCP Endpoint Shield can be deployed enterprise-wide via **Jamf MDM** (Mobile Device Management) for seamless, automated installation across your organization's macOS devices. This guide covers deployment using both **Jamf Pro** and **Jamf Now**.

#### Why Use MDM Deployment?

MDM deployment provides significant advantages over manual installation:

* **Zero-touch deployment** - Automatic installation at user login
* **Centralized management** - Configure and monitor from a single console
* **Consistent configuration** - Ensure all devices have the same security posture
* **Automated updates** - Push new versions across the organization
* **Compliance tracking** - Monitor deployment status and coverage

#### Supported Platforms

* ✅ **Jamf Pro** - Enterprise MDM solution
* ✅ **Jamf Now** - Small to medium business MDM

***

### Architecture

MCP Endpoint Shield uses a **user-level installation** approach that requires no administrator privileges:

* **Installation Type**: User-level (installs to `~/.local/bin/`)
* **Services**: LaunchAgents (runs as user, not system-wide)
* **Token Management**: External configuration file (`~/.config/mcp-endpoint-shield/config.env`)
* **Binary**: Universal (Intel + Apple Silicon support)
* **Deployment**: Automated at login via Jamf policy
* **Security**: True user-level operation - no root privileges required

***

### Prerequisites

Before deploying MCP Endpoint Shield via Jamf, ensure you have the following:

#### 1. Apple Developer Certificate (Recommended)

**Package signing and notarization is critical** for production deployment to prevent Gatekeeper warnings on user machines.

**Resources for signing packages:**

* **Jamf Now**: [Building and Signing Mac Packages](https://learn.jamf.com/en-US/bundle/jamf-now-documentation/page/Building_and_Signing_Mac_Packages.html)
* **Jamf Pro**: [Creating a Signing Certificate Using Jamf Pro's Built-in CA](https://learn.jamf.com/en-US/bundle/technical-articles/page/Creating_a_Signing_Certificate_Using_Jamf_Pros_Built-in_CA_to_Use_for_Signing_Configuration_Profiles_and_Packages.html)

**Why signing and notarization matters:**

* ✅ Passes Gatekeeper checks on macOS 10.15+ without manual overrides
* ✅ No security warnings during installation
* ✅ Compatible with MDM silent installs (no user interaction required)
* ✅ Trusted by Apple - package integrity verified
* ✅ Meets enterprise security policies for managed devices

#### 2. AKTO\_API\_TOKEN

* Obtain from Akto platform
* Will be deployed securely via Jamf encrypted parameters

#### 3. Jamf Pro Access

Permissions to create/edit:

* Packages
* Scripts
* Policies
* Smart Groups (optional)
* Extension Attributes (optional)

***

### Deployment Scripts

This deployment uses three scripts that are included in the MCP Endpoint Shield repository:

#### 1. deploy\_token.sh

* **Purpose**: Deploys AKTO\_API\_TOKEN to user's config directory
* **Run as**: Logged-in user (NOT root)
* **Jamf Parameter 4**: AKTO\_API\_TOKEN (encrypted)
* **Execution**: Before or with package installation

#### 2. install\_from\_staging.sh

* **Purpose**: Installs MCP Endpoint Shield in user context
* **Run as**: Logged-in user (NOT root)
* **Auto-detects**: Package from Jamf cache
* **Execution**: After package is cached by Jamf

#### 3. uninstall.sh

* **Purpose**: Removes MCP Endpoint Shield from user's system
* **Run as**: Logged-in user (NOT root)
* **Cleanup**: Includes removal of MCP server configurations
* **Execution**: Via Self Service or policy

***

### Phase 1: Upload to Jamf Pro

#### Step 1: Upload Package

1. Log into Jamf Pro console
2. Navigate to **Settings** → **Computer Management** → **Packages**
3. Click **+ New**
4. Upload: `mcp-endpoint-shield-Jamf-Installer.pkg`
5. Configure:
   * **Display Name**: MCP Endpoint Shield
   * **Category**: Security (or Development Tools)
   * **Priority**: 10 (default)
6. Save and upload to distribution points

#### Step 2: Upload Scripts

Navigate to **Settings** → **Computer Management** → **Scripts** and upload each script:

**Script 1: deploy\_token.sh**

* **Display Name**: MCP Endpoint Shield - Deploy Token
* **Category**: MCP Endpoint Shield
* **Parameter Labels**:
  * Parameter 4: `AKTO_API_TOKEN` (description: "API token for MCP Endpoint Shield")

**Script 2: install\_from\_staging.sh**

* **Display Name**: MCP Endpoint Shield - Install User Package
* **Category**: MCP Endpoint Shield
* No parameters needed (auto-detects package)

**Script 3: uninstall.sh**

* **Display Name**: MCP Endpoint Shield - Uninstall
* **Category**: MCP Endpoint Shield
* No parameters needed

#### Step 3: Create Extension Attribute (Optional but Recommended)

Navigate to **Settings** → **Computer Management** → **Extension Attributes**

* **Display Name**: MCP Endpoint Shield Version
* **Description**: Reports installed version of MCP Endpoint Shield
* **Data Type**: String
* **Inventory Display**: General
* **Input Type**: Script

**Script**:

```bash
#!/bin/bash
# This extension attribute runs as root but checks user installations
USER=$(stat -f%Su /dev/console 2>/dev/null)
if [ -z "$USER" ] || [ "$USER" = "root" ] || [ "$USER" = "_mbsetupuser" ]; then
    echo "<result>Not Installed (no user logged in)</result>"
elif [ -f "/Users/$USER/.local/bin/mcp-endpoint-shield" ]; then
    # Run as user to check version
    VERSION=$(sudo -u "$USER" /Users/$USER/.local/bin/mcp-endpoint-shield --version 2>/dev/null | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' || echo "unknown")
    echo "<result>$VERSION</result>"
else
    echo "<result>Not Installed</result>"
fi
```

**Note**: Extension Attributes run as root by default, which is acceptable here since it only reads version info and doesn't modify anything.

#### Step 4: Create Smart Group (Optional)

Navigate to **Computers** → **Smart Computer Groups** → **+ New**

* **Name**: MCP Endpoint Shield Not Installed
* **Criteria**:
  * Extension Attribute "MCP Endpoint Shield Version" is "Not Installed"
  * Operating System Version greater than or equal to 10.13.x

***

### Phase 2: Create Jamf Policy

Navigate to **Computers** → **Policies** → **+ New**

#### General Settings

* **Display Name**: Install MCP Endpoint Shield
* **Enabled**: Yes
* **Triggers**:
  * ✅ **Login** (user login trigger)
  * ✅ Recurring Check-in (optional, for catch-up)
* **Execution Frequency**: **Once per user per computer**
* **Category**: Security

#### Packages

* Click **Configure**
* Add package: **MCP Endpoint Shield**
* **Action**: Install
* **Distribution Point**: Use default

#### Scripts

Configure scripts in this order:

**Script 1: Deploy Token (Priority: Before)**

* Select: **MCP Endpoint Shield - Deploy Token**
* Priority: **Before**
* Parameter Values:
  * Parameter 4 (AKTO\_API\_TOKEN): `<YOUR_AKTO_TOKEN_HERE>`
    * ⚠️ **IMPORTANT**: Use Jamf's encrypted parameters feature
    * Store token securely, don't commit to version control

**Script 2: Install User Package (Priority: After)**

* Select: **MCP Endpoint Shield - Install User Package**
* Priority: **After**
* No parameters needed

#### Scope

Choose one of the following scoping options:

**Option A: Target Specific Group**

* **Targets**:
  * Smart Group: "MCP Endpoint Shield Not Installed"
* **Exclusions**: None

**Option B: All Computers**

* **Targets**: All Computers
* **Exclusions**: (optional) Test computers, excluded departments

**Option C: Specific Departments/Locations**

* **Targets**:
  * Department: Engineering, Security, etc.
  * Location: Office A, Remote Workers, etc.

#### User Interaction (Optional)

* **Start Message**: Leave empty for silent installation
* **Complete Message**: "MCP Endpoint Shield has been installed to protect your MCP servers."
* Or leave both empty for completely silent deployment

#### Maintenance

* **Update Inventory**: Yes (recommended)

***

### Phase 3: Create Uninstall Policy (Optional)

Navigate to **Computers** → **Policies** → **+ New**

#### General Settings

* **Display Name**: Uninstall MCP Endpoint Shield
* **Enabled**: Yes
* **Triggers**:
  * ✅ **Self Service** (user-initiated only for safety)
* **Execution Frequency**: Ongoing
* **Category**: Security

#### Scripts

* Select: **MCP Endpoint Shield - Uninstall**
* Priority: Before

#### Scope

* **Targets**: All Computers (available to all, but Self Service only)

#### Self Service

* **Make the policy available in Self Service**: Yes
* **Display Name**: Uninstall MCP Endpoint Shield
* **Description**: "Remove MCP Endpoint Shield from your computer. This will restore your MCP server configurations to their original state."
* **Icon**: Upload Akto icon if available
* **Category**: Security

***

### Testing

#### Test Plan

1. **Create Test Group**
   * Create a Smart Group: "MCP Shield Test Group"
   * Add 2-3 test computers to the group
2. **Scope Policy to Test Group**
   * Edit your installation policy
   * Change scope to target only "MCP Shield Test Group"
3. **Test on First Machine**
   * Log in as test user
   * Policy should trigger automatically at login
   *   Verify installation:

       ```bash
       ls -la ~/.local/bin/mcp-endpoint-shield
       ls -la ~/.config/mcp-endpoint-shield/config.env
       launchctl list | grep mcp-endpoint-shield
       tail -f ~/.local/share/mcp-endpoint-shield/logs/*.log
       ```
4. **Verify Functionality**
   * Services running: `launchctl list | grep akto`
   * Binary version: `~/.local/bin/mcp-endpoint-shield --version`
   * Token configured: `cat ~/.config/mcp-endpoint-shield/config.env` (check permissions are 600)
   * MCP configs discovered: Check agent log
5. **Test on Multiple Architectures**
   * Test on Intel Mac
   * Test on Apple Silicon Mac
   * Verify universal binary works on both
6. **Test Uninstallation**
   * Run uninstall from Self Service
   * Verify complete removal
   * Check MCP configs are unwrapped

#### Verification Checklist

* [ ] Package uploads successfully to Jamf
* [ ] Scripts upload successfully to Jamf
* [ ] Policy triggers at login
* [ ] Token deployed with correct permissions (600)
* [ ] Binary installed and executable
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

* Scope policy to all computers
* Monitor deployment metrics
* Provide user support/documentation
* Track compliance via Extension Attribute

***

### Troubleshooting

#### Issue: Installation Not Triggering

**Symptoms**: User logs in but installation doesn't happen

**Causes**:

* No user logged in when policy checks in
* User not in scope
* Policy frequency set to "Once per computer" instead of "Once per user per computer"

**Solutions**:

1. Check policy logs in Jamf for that computer
2. Verify user is in scoped group
3. Change frequency to "Once per user per computer"
4. Manually trigger: `sudo jamf policy -id <policy_id>`

#### Issue: Token Not Found

**Symptoms**: Services fail to start, logs show "AKTO\_API\_TOKEN not configured"

**Causes**:

* Token deployment script didn't run
* Token script ran after installation
* Token parameter not set in Jamf policy

**Solutions**:

1. Verify token script ran before installation: Check `/var/log/jamf.log`
2.  Manually deploy token:

    ```bash
    sudo /path/to/deploy_token.sh "" "" "" "YOUR_TOKEN"
    ```
3.  Restart services:

    ```bash
    launchctl bootout gui/$(id -u)/io.akto.mcp-endpoint-shield
    launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/io.akto.mcp-endpoint-shield.plist
    ```

#### Issue: Services Not Starting

**Symptoms**: `launchctl list` doesn't show services

**Causes**:

* Token not configured
* LaunchAgent plist syntax error
* Permissions issue

**Solutions**:

1. Check token exists: `ls -la ~/.config/mcp-endpoint-shield/config.env`
2. Check plist syntax: `plutil -lint ~/Library/LaunchAgents/io.akto.mcp-endpoint-shield.plist`
3. Check logs: `tail -f ~/.local/share/mcp-endpoint-shield/logs/*.log`
4.  Manually load:

    ```bash
    launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/io.akto.mcp-endpoint-shield.plist
    ```

#### Issue: Permission Denied Errors

**Symptoms**: Installation fails with permission errors

**Causes**:

* Trying to install to system directories (shouldn't happen with user-level install)
* User home directory not accessible

**Solutions**:

1. Verify user is logged in: `stat -f%Su /dev/console`
2. Verify user home exists: `ls -ld ~username`
3. Check installer logs: `/var/log/install.log`

#### Issue: Multiple Users on Same Mac

**Symptoms**: Only first user gets installation

**Causes**:

* Policy set to "Once per computer" instead of "Once per user per computer"

**Solutions**:

1. Change policy frequency to "Once per user per computer"
2. Each user will get installation on their first login after policy deployment

***

### Security Considerations

#### Token Storage

* **Location**: `~/.config/mcp-endpoint-shield/config.env`
* **Permissions**: 600 (readable only by owner)
* **Encryption**: Token passed via Jamf encrypted parameter (parameter 4)
* **Access Control**: Limit Jamf policy editing to security team

#### Best Practices

**1. Rotate Tokens Regularly**

* Update token in Jamf policy
* Token deployment script can update existing installations
* Consider 90-day rotation schedule

**2. Monitor Deployments**

* Use Extension Attribute to track deployment status
* Create Smart Group for failed installations
* Review Jamf logs regularly

**3. Least Privilege**

* Binaries run as user, not system
* No system-level daemons
* All operations confined to user's home directory

**4. Audit Trail**

* Jamf logs all script executions
* MCP Endpoint Shield logs all activity
* Token deployment is timestamped

***

### Updating MCP Endpoint Shield

#### Update Process

**1. Build New Version**

```bash
make release
lipo -create dist/darwin-amd64/mcp-endpoint-shield dist/darwin-arm64/mcp-endpoint-shield -output dist/universal/mcp-endpoint-shield
./pkgbuild-scripts/build_mac_jamf.sh
```

**2. Upload New Package to Jamf**

* Upload as new package version
* Keep same name: "MCP Endpoint Shield"

**3. Update Policy**

* Edit existing policy
* Change package to new version
* Change execution frequency to "Ongoing" (or create separate update policy)

**4. Rollout**

* Test on pilot group first
* Gradually expand scope
* Monitor for issues

#### Considerations

* User-level installation means each user gets updated independently
* Consider using Jamf Patch Management for version tracking
* Updates can coexist with existing installations (postinstall handles upgrades)

***

### File Locations

| Path                                                             | Purpose             |
| ---------------------------------------------------------------- | ------------------- |
| `~/.local/bin/mcp-endpoint-shield`                               | Main binary         |
| `~/.local/bin/mcp_endpoint_shield.sh`                            | Wrapper script      |
| `~/Library/LaunchAgents/io.akto.mcp-endpoint-shield.plist`       | HTTP service        |
| `~/Library/LaunchAgents/io.akto.mcp-endpoint-shield-agent.plist` | Agent service       |
| `~/.config/mcp-endpoint-shield/config.env`                       | Token configuration |
| `~/.local/share/mcp-endpoint-shield/logs/`                       | Application logs    |
| `~/.mcp-endpoint-shield/mcp_audit_info.db`                       | Audit database      |

***

### Useful Commands

#### Check Installation Status

```bash
# Check if installed
ls -la ~/.local/bin/mcp-endpoint-shield

# Check version
~/.local/bin/mcp-endpoint-shield --version
```

#### Check Services

```bash
# Check services
launchctl list | grep mcp-endpoint-shield

# View logs
tail -f ~/.local/share/mcp-endpoint-shield/logs/*.log
```

#### Check Configuration

```bash
# Check token
ls -la ~/.config/mcp-endpoint-shield/config.env
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

| Parameter | Value            | Description                      |
| --------- | ---------------- | -------------------------------- |
| $1        | Mount point      | Typically `/`                    |
| $2        | Computer name    | Hostname                         |
| $3        | Username         | Current user                     |
| $4        | AKTO\_API\_TOKEN | Token for MCP Shield (encrypted) |

***

### Support

#### User Documentation

Provide users with:

* What MCP Endpoint Shield does
* Why it's required (security/compliance)
* How to check if it's running
* Who to contact for issues

#### Admin Contacts

* **Jamf Issues**: IT Helpdesk
* **MCP Shield Issues**: Security Team
* **Token Issues**: Security Team
* **Akto Platform**: support@akto.io

***

### Related Documentation

* MCP Endpoint Shield Overview - General installation and manual setup
* MCP Endpoint Shield via Cursor Hooks - Alternative deployment method
* MCP Security - Security concepts and best practices

***

### Version

This documentation is for MCP Endpoint Shield v1.1.5 (Jamf deployment).
