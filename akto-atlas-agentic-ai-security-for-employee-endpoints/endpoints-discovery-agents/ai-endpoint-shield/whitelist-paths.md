# Whitelist Paths — MCP Endpoint Shield

This page lists all file system paths that should be whitelisted in your security software (EDR, antivirus, or endpoint protection) to allow the Akto MCP Endpoint Shield to function correctly on macOS.

> **Note:** `*` in paths is a wildcard covering all usernames (e.g., `/Users/*/` matches `/Users/john/`).

---

## Priority Order

Add paths in the following order of importance. Start with Section 1 — it alone resolves most conflicts.

| Priority | Section | What it covers |
|----------|---------|----------------|
| **1 — Critical** | Binaries & Executables | Process execution blocks |
| **2 — High** | Hook Scripts (Claude CLI & Cursor) | Hook execution blocks |
| **3 — Medium** | LaunchAgent Plists | Background service alerts |
| **4 — Low** | Staging & Install Paths | Install-time transient alerts |
| **5 — Informational** | Logs & App Data | File write alerts |

---

## 1. Binaries & Executables

These are the primary process paths evaluated on launch. **Whitelist these first.**

| Path | Description |
|------|-------------|
| `/Users/*/.akto-mcp-endpoint-shield/bin/mcp-endpoint-shield` | Main Go binary |
| `/Users/*/.akto-mcp-endpoint-shield/bin/mcp_endpoint_shield.sh` | User-level wrapper shell script |
| `/usr/local/bin/mcp_endpoint_shield.sh` | System-level detector wrapper script |

---

## 2. Hook Scripts — Claude CLI

| Path | Description |
|------|-------------|
| `/Users/*/.claude/hooks/akto-validate-prompt.py` | Prompt validation hook |
| `/Users/*/.claude/hooks/akto-validate-response.py` | Response validation hook |
| `/Users/*/.claude/hooks/akto-validate-prompt-wrapper.sh` | Prompt wrapper script |
| `/Users/*/.claude/hooks/akto-validate-response-wrapper.sh` | Response wrapper script |
| `/Users/*/.claude/hooks/akto_machine_id.py` | Machine ID generator |

---

## 3. Hook Scripts — Cursor IDE

| Path | Description |
|------|-------------|
| `/Users/*/.cursor/hooks/akto/akto-validate-chat-prompt.py` | Chat prompt validation |
| `/Users/*/.cursor/hooks/akto/akto-validate-chat-response.py` | Chat response validation |
| `/Users/*/.cursor/hooks/akto/akto-validate-mcp-request.py` | MCP request validation |
| `/Users/*/.cursor/hooks/akto/akto-validate-mcp-response.py` | MCP response validation |
| `/Users/*/.cursor/hooks/akto/akto-validate-chat-prompt-wrapper.sh` | Chat prompt wrapper |
| `/Users/*/.cursor/hooks/akto/akto-validate-chat-response-wrapper.sh` | Chat response wrapper |
| `/Users/*/.cursor/hooks/akto/akto-validate-mcp-request-wrapper.sh` | MCP request wrapper |
| `/Users/*/.cursor/hooks/akto/akto-validate-mcp-response-wrapper.sh` | MCP response wrapper |
| `/Users/*/.cursor/hooks/akto/akto_machine_id.py` | Machine ID generator |

---

## 4. LaunchAgent Plists

These define the background services launched at user login. Whitelist these if your security software monitors `launchctl` activity.

| Path | Description |
|------|-------------|
| `/Users/*/Library/LaunchAgents/io.akto.mcp-endpoint-shield.plist` | HTTP proxy service |
| `/Users/*/Library/LaunchAgents/io.akto.mcp-endpoint-shield-agent.plist` | Auto-discovery agent service |
| `/Users/*/Library/LaunchAgents/io.akto.mcp-endpoint-shield-detector.plist` | MCP detector service |

---

## 5. Staging & Install Paths

Active only during Jamf installation. Whitelist as transient execution paths if your security software raises alerts during the install phase.

| Path | Description |
|------|-------------|
| `/tmp/akto-mcp-endpoint-shield-staging/` | Package staging directory |
| `/tmp/akto-mcp-endpoint-shield-staging/.akto-mcp-endpoint-shield/bin/mcp-endpoint-shield` | Staged binary |
| `/Library/Application Support/JAMF/Waiting Room/` | Jamf package cache |

---

## 6. Log Directories

Whitelist these only if your security software raises alerts on file write activity.

| Path | Description |
|------|-------------|
| `/var/log/akto-mcp-endpoint-shield/` | System-level log directory |
| `/var/log/akto-mcp-endpoint-shield-install.log` | Installation log |
| `/var/log/akto-mcp-endpoint-shield-uninstall.log` | Uninstallation log |
| `/var/log/akto-mcp-endpoint-shield-deploy-token.log` | Token deployment log |
| `/Users/*/.akto-mcp-endpoint-shield/logs/` | User-level log directory |

---

## 7. Application Data Directory

| Path | Description |
|------|-------------|
| `/Users/*/.akto-mcp-endpoint-shield/` | Root application directory (`bin/`, `config/`, `logs/`) |
| `/Users/*/.akto-mcp-endpoint-shield/config/config.env` | Token and configuration file |

---

## Related Documentation

* [Jamf MDM Deployment](jamf-mdm-deployment.md) — Step-by-step guide to deploying MCP Endpoint Shield via Jamf Pro or Jamf Now
* [MCP Endpoint Shield Overview](README.md) — Manual installation and general overview
