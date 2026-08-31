---
description: >-
  Validate and troubleshoot an AI Endpoint Shield installation on macOS —
  version, LaunchAgents, config, logs, hooks, and the common failure modes.
---

# macOS Troubleshooting

## Overview

This page covers post-installation **validation and troubleshooting** of **AI Endpoint Shield** on macOS — checking the version, LaunchAgents and processes, where config lives, the logs the agent writes, verifying IDE hooks, and common fixes. Use it if Akto was installed but is not sending data, or stopped working after a restart.

{% hint style="info" %}
**Everything below is read-only unless a section says otherwise** — safe to run at any time without disrupting a working install.

Run the commands as the **signed-in user**, in Terminal. A few checks note where `sudo` is needed. If you run them over SSH as root, path checks will look at `/var/root` instead of the user's home and report false negatives.
{% endhint %}

## 30-second health check

Paste this into Terminal:

```bash
BIN=/usr/local/bin/akto-endpoint-shield

echo "--- Version ---"
"$BIN" --version 2>&1

echo "--- Config status ---"
"$BIN" check-config --path ~/.akto-endpoint-shield/config 2>&1

echo "--- Services ---"
launchctl list | grep akto-endpoint-shield || echo "(none loaded)"

echo "--- Processes ---"
ps aux | grep -E "akto-endpoint-shield" | grep -v grep || echo "(none running)"
```

A healthy result looks like:

* A version string (e.g. `akto-endpoint-shield version v1.1.134`), not an error
* Config status prints `provisioned`
* Both `io.akto.akto-endpoint-shield` and `io.akto.akto-endpoint-shield-agent` listed, each with a **PID** in the first column — not `-`
* At least one `akto-endpoint-shield` process

If any of these don't match, keep reading — the matching section explains what to check, and [Common issues and fixes](#common-issues-and-fixes) has a symptom → fix table.

## Checking the installed version

```bash
/usr/local/bin/akto-endpoint-shield --version
```

This prints immediately, before anything else the agent does, so it works even if config or the network is broken. If it errors instead of printing a version, the binary is missing, quarantined, or the wrong architecture — see [Install location and files](#install-location-and-files).

## Install location and files

| Path | Purpose |
|---|---|
| `/usr/local/bin/akto-endpoint-shield` | Main binary |
| `/usr/local/lib/akto-endpoint-shield/` | Bundled runtime (includes the mitmproxy virtualenv when the optional system proxy is enabled) |
| `/Library/Application Support/Akto/` | Read-only asset bundle installed by the pkg (hooks, scripts, config seed) |
| `~/.akto-endpoint-shield/` | Per-user tree — `bin/`, `hooks/`, `config/`, `logs/` |

Presence and trust check:

```bash
BIN=/usr/local/bin/akto-endpoint-shield
ls -l "$BIN"
file "$BIN"                                   # architecture
shasum -a 256 "$BIN"                          # hash, for EDR allowlisting
xattr -p com.apple.quarantine "$BIN" 2>/dev/null && echo "QUARANTINED" || echo "no quarantine attribute"
codesign -dvv "$BIN" 2>&1 | grep -E "Authority=|TeamIdentifier="
spctl -a -vvv "$BIN" 2>&1 | head -3
```

* **Quarantine attribute present** — Gatekeeper may refuse to run it. Clear it:

  ```bash
  sudo xattr -dr com.apple.quarantine /usr/local/bin/akto-endpoint-shield
  ```
* **`x86_64` only on an Apple Silicon Mac** — the binary needs Rosetta 2:

  ```bash
  softwareupdate --install-rosetta --agree-to-license
  ```

  Current Akto builds are universal, so this points at a stale install.
* **`spctl` rejects it** — the notarization ticket is missing or a security tool is intercepting. Reinstall from the Akto-provided pkg.

Also confirm the pkg receipt is on the machine:

```bash
pkgutil --pkgs | grep -i akto
pkgutil --pkg-info io.akto.akto-endpoint-shield
```

### Provisioning markers

The agent writes marker files after it finishes first-run provisioning. Missing markers mean it never completed setup, which is why hooks aren't installed:

```bash
ls -1 ~/.akto-endpoint-shield/.assets-synced-* ~/.akto-endpoint-shield/.hooks-installed-* 2>/dev/null || \
  echo "no provisioning markers — first-run provisioning did not complete"
```

### Root misinstall

If the pkg was installed by hand with `sudo installer -pkg ...` rather than through MDM, the postinstall runs as root and drops everything into root's home instead of the user's:

```bash
sudo ls -d /var/root/.akto-endpoint-shield /var/root/.claude 2>/dev/null && \
  echo "ROOT MISINSTALL — files landed in root's home"
```

Fix by removing `/var/root/.akto-endpoint-shield` and re-running the install through your MDM policy, or by launching the pkg as the signed-in user.

## LaunchAgents and services

Akto runs as LaunchAgents in the **user's** GUI session — there are no system daemons for the core services.

| Label | What it does |
|---|---|
| `io.akto.akto-endpoint-shield` | Local HTTP service the agent and hooks use internally |
| `io.akto.akto-endpoint-shield-agent` | Main background agent — heartbeats to the dashboard, applies config/policy changes, keeps IDE hooks up to date |
| `io.akto.akto-endpoint-shield-detector` | Detects which AI tools/IDEs are installed |
| `io.akto.akto-endpoint-shield-system-proxy` | Optional system-wide HTTPS inspection proxy (LaunchDaemon; only if your organization has it enabled) |

Their plists live in `~/Library/LaunchAgents/`. Check status:

```bash
launchctl list | grep akto-endpoint-shield
```

The first column is the PID and the second is the last exit status:

| Output | Meaning |
|---|---|
| `1234  0  io.akto...` | Running normally |
| `-  0  io.akto...` | Loaded but not running — most often BTM approval, see below |
| `-  78  io.akto...` | Exited with an error — check the logs |
| (nothing listed) | The plist was never loaded — reinstall, or bootstrap manually |

Check the plists themselves:

```bash
for p in ~/Library/LaunchAgents/io.akto.akto-endpoint-shield*.plist; do
  echo "--- $p"
  /usr/libexec/PlistBuddy -c "Print :ProgramArguments" "$p" 2>/dev/null
  /usr/libexec/PlistBuddy -c "Print :RunAtLoad" "$p" 2>/dev/null
  grep -q '%USER%' <(grep '<string>' "$p") && echo "  ERROR: %USER% placeholder was never replaced"
done
```

`RunAtLoad` must be `true`, and the referenced binary must exist. A literal `%USER%` or a `/Users/root/` path in a `<string>` value means the install ran without a console user — re-run it at login.

**Restart the services** (after a config change, or to force a hook re-check):

```bash
launchctl bootout gui/$(id -u)/io.akto.akto-endpoint-shield 2>/dev/null
launchctl bootout gui/$(id -u)/io.akto.akto-endpoint-shield-agent 2>/dev/null
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/io.akto.akto-endpoint-shield.plist
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/io.akto.akto-endpoint-shield-agent.plist
launchctl list | grep akto-endpoint-shield
```

**See why a loaded service isn't running:**

```bash
launchctl print gui/$(id -u)/io.akto.akto-endpoint-shield-agent 2>/dev/null |
  grep -E "state|pid|last exit|throttle|runs"
```

## Background items (BTM approval)

macOS 13 and later require every LaunchAgent label to be approved as a **background item** before `launchd` will start it. This is separate from code signing and notarization: a fully signed, notarized install can sit **loaded, never running, with zero logs** forever if BTM hasn't approved the label.

This is the most common cause of "installed successfully, but nothing happens" on modern macOS.

```bash
# Is Akto registered with BTM, and is it enabled?
sudo sfltool dumpbtm 2>/dev/null | grep -i -A 12 akto

# Same view via system_profiler
system_profiler SPBackgroundTaskManagementDataType 2>/dev/null | grep -i -A 8 akto

# Is an MDM pre-approval profile installed?
sudo profiles show -type configuration 2>/dev/null | grep -i servicemanagement
```

In `sfltool dumpbtm` output, look at the `Disposition:` line. `[enabled, allowed, notified]` is healthy; `[disabled, ...]` or a pending/requires-approval state means launchd will not start the service.

**Fixes, in order of preference:**

1. **MDM profile (fleet-wide, no user prompt)** — deploy a `com.apple.servicemanagement` configuration profile from Jamf, Mosyle, or your MDM that pre-approves Akto's Team Identifier. Contact Akto for the Team Identifier and a sample payload.
2. **Manual approval (single machine)** — open **System Settings → General → Login Items & Extensions → Allow in the Background**, find the Akto Endpoint Shield entry, and turn the toggle **on**.

To see what the system logged around install time:

```bash
log show --predicate 'subsystem == "com.apple.backgroundtaskmanagement" OR process == "syspolicyd"' \
    --last 1h 2>/dev/null | grep -i "akto\|approv\|denied\|background item"
```

## Running processes

```bash
ps aux | grep -E "akto-endpoint-shield|mitmdump" | grep -v grep
```

You should normally see two or three `akto-endpoint-shield` processes. If nothing appears:

* Restart the services (command above) and re-check after a few seconds.
* If a process appears and disappears within seconds every time, something is killing it — most commonly an antivirus/EDR tool. See [Security software conflicts](#security-software-conflicts).

To see the exact startup error, run the binary in the foreground:

```bash
/usr/local/bin/akto-endpoint-shield http
```

Read the first few lines, then press `Ctrl+C`. Common messages:

| Message | Meaning / fix |
|---|---|
| `AKTO_API_TOKEN is not set` | Config missing or unreadable — see [Config values and location](#config-values-and-location) |
| `AKTO_API_BASE_URL is not set` | Same as above |
| `address already in use` | Another Akto process holds the port — `pkill -f akto-endpoint-shield`, then restart the services |
| `failed to install mitmproxy` | No internet access during install — check network and re-run the installer |

{% hint style="warning" %}
Don't use the legacy wrapper (`~/.akto-endpoint-shield/bin/akto_endpoint_shield.sh`) for this test. It only reads plaintext config and reports a false "config not found" on any device with encrypted config. Run the binary directly.
{% endhint %}

## Listening ports

```bash
lsof -nP -iTCP -sTCP:LISTEN | grep -iE "akto|mitmdump"
```

If nothing is listening but processes exist, the service failed to bind — run the foreground test above to see the bind error.

## Config values and location

Akto stores its configuration (your account token, dashboard URL, and feature switches) **encrypted on disk**, keyed to this Mac's hardware `IOPlatformUUID`. The file is not human-readable, and only this machine can decrypt it.

| Where | Path |
|---|---|
| Your user profile | `~/.akto-endpoint-shield/config/config.env.enc` |
| Root (only if misinstalled) | `/var/root/.akto-endpoint-shield/config/config.env.enc` |

On a device that hasn't been updated in a while you may instead see a plain `config.env` — same idea, older format, still supported. If **both** exist, the agent reads the encrypted one; the plaintext copy should have been removed at migration and is safe to delete.

**Check whether config is present and valid** (does not print any secret values):

```bash
/usr/local/bin/akto-endpoint-shield check-config --path ~/.akto-endpoint-shield/config
```

| Output | Exit code | Meaning |
|---|---|---|
| `provisioned` | `0` | Healthy — token and settings are present and readable |
| `not-provisioned` | `2` | Device was never given credentials — re-run the installer with your Akto token |
| `undecryptable` | `3` | Config exists but can't be decrypted (restored from another Mac's backup, or a logic-board swap) — this device must be reinstalled, it cannot be repaired in place |

**Read specific non-secret values**, e.g. to confirm which dashboard this machine reports to:

```bash
/usr/local/bin/akto-endpoint-shield get-config --path ~/.akto-endpoint-shield/config \
    AKTO_API_BASE_URL AGENT_ID DATABASE_ABSTRACTOR_SERVICE_URL
```

{% hint style="danger" %}
**Do not run `get-config ... AKTO_API_TOKEN`** and paste the output anywhere — screenshots, tickets, chat. That value is your account's secret credential. Akto support can verify it against your account without you ever displaying it.
{% endhint %}

**Config keys you may be asked about:**

| Key | What it is |
|---|---|
| `AKTO_API_TOKEN` | Your organization's Akto account credential (secret — never share) |
| `AKTO_API_BASE_URL` | Your Akto dashboard's URL for this account |
| `AGENT_ID` | This device's unique identifier, shown on the Akto dashboard |
| `ENABLE_PROMPT_HOOKS_*` / `ENABLE_MCP_HOOKS_*` | Per-IDE switches for whether guardrail hooks are installed (on by default) |
| `ENABLE_SYSTEM_PROXY` | Whether the optional system-wide HTTPS proxy is on (off by default) |
| `AKTO_TCC_GUARD` | Whether the agent skips Desktop/Documents/Downloads to avoid TCC prompts |

**Permissions** should be `600`:

```bash
ls -la ~/.akto-endpoint-shield/config/
```

**Token mismatch between profiles.** If a root misinstall left a second config behind, the two can carry different tokens and produce intermittent `401`s:

```bash
/usr/local/bin/akto-endpoint-shield check-config --path /var/root/.akto-endpoint-shield/config 2>/dev/null \
  && echo "A root-profile config also exists — see Root misinstall above"
```

## Device identity

Useful when a device is installed and healthy but doesn't show up on the dashboard, or shows up twice.

```bash
UUID=$(ioreg -rd1 -c IOPlatformExpertDevice | awk -F'"' '/IOPlatformUUID/{print $4}' | tr -d '-' | tr 'A-Z' 'a-z')
NAME=$(scutil --get ComputerName | tr 'A-Z' 'a-z' | sed 's/[^a-z0-9]/-/g')
echo "${NAME}-${UUID:0:8}"
```

This should match the device label shown for this machine in the Akto dashboard. A Mac restored from another machine's image inherits that machine's UUID, which both collides on the dashboard and makes the encrypted config undecryptable — it needs a reinstall.

## Logs

All logs below are plain text.

| Log | Location | What's in it |
|---|---|---|
| Install log (user) | `~/.akto-endpoint-shield/logs/install.log` | Step-by-step output of the last install/update, including every IDE hook installer's own output |
| Install log (root context) | `/var/log/akto-endpoint-shield-install.log` | What the MDM script and pkg postinstall did, before a user profile was detected |
| Agent | `~/.akto-endpoint-shield/logs/agent.log` | Main agent runtime — heartbeats, config reloads, hook maintenance |
| HTTP service | `~/.akto-endpoint-shield/logs/proxy-server.log` | Local HTTP service runtime |
| Detector | `~/.akto-endpoint-shield/logs/detector.log` | AI tool/IDE detection runs |
| System proxy | `/var/log/akto-endpoint-shield/system-proxy.log` | Only present if the optional proxy feature is enabled |
| OpenCode plugin | `~/.config/opencode/akto/logs/akto-guardrails.log` | OpenCode guardrail plugin activity |

View recent activity:

```bash
tail -50 ~/.akto-endpoint-shield/logs/agent.log
tail -f ~/.akto-endpoint-shield/logs/*.log
```

**Hook installation output** goes into `install.log`, prefixed with each installer's script name — there is no separate file per IDE:

```bash
grep -i "hook" ~/.akto-endpoint-shield/logs/install.log
```

**Hook execution (prompt block/allow) decisions** are recorded on the **Akto dashboard**, not in a local file.

{% hint style="info" %}
These logs never contain your API token — safe to share with Akto support without redacting anything.
{% endhint %}

## Verifying IDE hooks

Akto installs guardrail hooks into each supported IDE/CLI so it can inspect prompts and tool calls. Check whichever tools you use:

| Tool | Check |
|---|---|
| Claude Code | `jq '.hooks \| keys' ~/.claude/settings.json` |
| Cursor | `jq '.hooks.beforeSubmitPrompt' ~/.cursor/hooks.json` |
| Gemini CLI | `grep -i akto ~/.gemini/settings.json` |
| Codex CLI | `grep -i akto ~/.codex/config.toml` |
| GitHub Copilot CLI | `ls ~/.copilot/hooks/` |
| VS Code Copilot | `ls ~/.vscode/copilot/hooks/akto/` |
| Kiro CLI | `ls ~/.kiro/hooks/akto/` |
| OpenCode | `ls ~/.config/opencode/plugin/akto-guardrails-plugin.js` |

A JSON block or a matching line means the hook is installed. Nothing means that tool's hooks weren't installed — because the tool wasn't detected on the machine, its feature switch (`ENABLE_PROMPT_HOOKS_*`, see [Config values and location](#config-values-and-location)) is off for your account, or first-run provisioning never completed (see [Provisioning markers](#provisioning-markers)).

**Check that registered hook commands actually point at files that exist** — a common failure after manual edits to IDE settings:

```bash
jq -r '.. | .command? // empty' ~/.claude/settings.json 2>/dev/null | grep -i akto | while read -r cmd; do
  f=$(echo "$cmd" | awk '{for(i=1;i<=NF;i++) if ($i ~ /\.sh$/) {print $i; exit}} END{}')
  f=${f/#\~/$HOME}
  [ -f "$f" ] && echo "OK      $f" || echo "MISSING $f"
done
```

Hook commands should use **absolute paths**. A leading `~` is not expanded when bash runs non-interactively, so a `~/`-prefixed hook command fails silently.

**If hooks worked before and stopped working**, the background agent re-checks and restores them automatically — wait for its next check-in cycle (typically a few minutes), or restart the agent service to force it immediately.

## System-wide proxy (optional)

Some accounts have an optional feature enabled where Akto routes AI-tool traffic through a local HTTPS-inspecting proxy. This only applies if your organization has turned it on.

```bash
ls -l /usr/local/lib/akto-endpoint-shield/venv/bin/mitmdump 2>/dev/null || echo "system proxy not installed"
ls -l /var/lib/mitmproxy/mitmproxy-ca-cert.pem 2>/dev/null
security find-certificate -c mitmproxy /Library/Keychains/System.keychain >/dev/null 2>&1 \
  && echo "mitmproxy CA trusted" || echo "mitmproxy CA NOT in System keychain"

# Which proxy the active network service is pointed at
SVC=$(networksetup -listallhardwareports | awk -v d="$(route get default 2>/dev/null | awk '/interface/{print $2}')" \
  '/^Hardware Port:/{n=substr($0,index($0,":")+2)} $0 ~ ("Device: " d "$"){print n; exit}')
networksetup -getsecurewebproxy "$SVC"
```

If mitmdump isn't installed and no certificate is listed, the feature is simply not enabled for your account — this is normal and not an error.

If it **is** enabled but tools warn about an untrusted certificate, re-import the CA:

```bash
sudo security add-trusted-cert -d -r trustRoot \
    -k /Library/Keychains/System.keychain /var/lib/mitmproxy/mitmproxy-ca-cert.pem
```

## Security software conflicts

Antivirus and EDR products are a common cause of "installed, but nothing runs". Enumerate what's present:

```bash
PAT='crowdstrike|falcon|sentinelone|carbonblack|defender|mdatp|sophos|malwarebytes|trendmicro|cylance|trellix|xagt|netskope|zscaler|umbrella|tanium|forcepoint|santa|littlesnitch|kolide'

ps axo user,pid,comm | grep -iE "$PAT" | grep -v grep | grep -v /System/
ls -1 /Applications | grep -iE "$PAT"
systemextensionsctl list 2>/dev/null | grep -iE "$PAT"
ls -1 /Library/LaunchDaemons /Library/LaunchAgents 2>/dev/null | grep -iE "$PAT"
```

Also check the OS-level gates:

```bash
spctl --status                                                    # Gatekeeper
csrutil status                                                    # SIP
/usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate   # Application Firewall
```

If a security tool is present and the binary keeps being killed or quarantined, add the exclusions in [Allowlist in Security Software](allowlist-in-security-software.md) and give your security administrator the SHA256 hash from [Install location and files](#install-location-and-files).

## Folder access (TCC) prompts

macOS may prompt for access to Desktop, Documents, and Downloads. These are **optional** — the agent works without them, but MCP-related file scanning coverage is reduced.

If the prompts were declined and you want to grant access later, open **System Settings → Privacy & Security → Files and Folders** and enable the folders for Akto Endpoint Shield. To suppress the prompts entirely fleet-wide, set `AKTO_TCC_GUARD=true` (the default in MDM deployments) or deploy a PPPC configuration profile from your MDM.

## Common issues and fixes

| Symptom | Likely cause | Fix |
|---|---|---|
| Services show `-` instead of a PID, no logs at all | macOS 13+ background item not approved | [Background items (BTM approval)](#background-items-btm-approval) |
| Device not appearing on the dashboard | Not provisioned, or the agent isn't running | Run `check-config`; see [Config values and location](#config-values-and-location) |
| Services loaded but exit immediately | Missing token, port conflict, or EDR | Foreground test in [Running processes](#running-processes) |
| Binary won't execute at all | Quarantine attribute, or an `x86_64`-only binary on Apple Silicon | [Install location and files](#install-location-and-files) |
| Files ended up in `/var/root` | Installed manually with `sudo installer` instead of via MDM | [Root misinstall](#root-misinstall) |
| `check-config` reports `undecryptable` | Mac restored from another machine's image, or a logic-board swap | Reinstall — this can't be repaired in place |
| A specific IDE's hooks aren't showing up | Tool not detected, feature flag off, or provisioning incomplete | [Verifying IDE hooks](#verifying-ide-hooks) |
| Hooks registered but silently do nothing | Hook command uses `~` instead of an absolute path | [Verifying IDE hooks](#verifying-ide-hooks) |
| Everything worked, then stopped after a restart | `RunAtLoad` false, or BTM approval revoked | [LaunchAgents and services](#launchagents-and-services), then BTM |
| Repeated `401` errors in `agent.log` | Stale or duplicate config | [Config values and location](#config-values-and-location) |
| Device shows up twice, or under the wrong name | Machine cloned from another device's image | [Device identity](#device-identity) |

## Full automated diagnostic

For a single comprehensive report covering everything above plus security-software conflicts, BTM state, Jamf staging, and install-time forensics:

1. Get `diagnose_mac.sh` from Akto support (it is also included in the installer package).
2. Run it and save the output:

   ```bash
   bash diagnose_mac.sh > ~/Desktop/akto-diag.txt 2>&1
   ```
3. Send `~/Desktop/akto-diag.txt` to Akto support.

The script only reads information from your machine — it makes no changes — and never prints your API token.

## Reinstall / uninstall (last resort)

If nothing above resolves the issue:

1. Run the uninstall script provided by Akto (`uninstall.sh`), or trigger the uninstall policy from your MDM's Self Service.
2. Restart the Mac.
3. Re-run the install through your MDM policy, or the installer package provided by your IT team.
4. Wait 2–3 minutes, then check the dashboard for the device to reappear.

If the problem persists after reinstall, run the diagnostic above and send the report to Akto support along with what you observed.

## Related documentation

* [Windows Troubleshooting](windows-troubleshooting.md) — the same checks for Windows
* [Allowlist in Security Software](allowlist-in-security-software.md) — antivirus and EDR exclusions
* [macOS Standalone Installation](macos-standalone-installation.md) — the end-user install walkthrough
* [Jamf MDM Deployment](jamf-mdm-deployment.md) / [Mosyle MDM Deployment](mosyle-deployment.md) / [NinjaOne Deployment (macOS)](ninjaone-macos-deployment.md)

## Get support

When contacting Akto support, include the diagnostic report, the installed version, and what you observed and when it started. **Never** include the raw `AKTO_API_TOKEN` value in a ticket, chat, or screenshot.

1. In-app Intercom in the Akto dashboard
2. [Discord community](https://www.akto.io/community)
3. [support@akto.io](mailto:support@akto.io)
4. [Contact Akto](https://www.akto.io/contact-us)
