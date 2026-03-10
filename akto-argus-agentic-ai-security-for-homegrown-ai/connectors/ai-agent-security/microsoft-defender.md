# Scanning for Agentic (MCP/AI) Endpoints via Microsoft Defender for Endpoint


## 1. Prerequisites

- Admin account
- Microsoft Defender for Endpoint license
- MDE-enrolled devices: devices must be onboarded to Microsoft Defender for Endpoint using one of the supported onboarding methods:
    - Microsoft Intune (macOS, Windows, Linux)
    - Local onboarding script / installation package (macOS, Windows, Linux)

Verification
- Open the Microsoft Defender portal → **Assets** → **Devices** and confirm each device's status is **Active**.



---

## 2. Running the KQL Hunting Queries

### How to get there

1. Open [Microsoft Defender portal](https://security.microsoft.com)
2. Left sidebar → **Investigation & response**
3. **Hunting** → **Advanced hunting**
4. Paste a query into the editor and click **Run query**

---

### Query 1 — AI Agent Software Inventory

Finds AI coding tools (Cursor, Windsurf, Claude, VS Code, Codex) installed on a specific device, using the software inventory table.

```kql
DeviceTvmSoftwareInventory
| where DeviceName contains "<your-device-name>"
| where SoftwareName has_any (
    'cursor',
    'windsurf',
    'visual studio code', 'vscode', 'microsoft visual studio code',
    'claude', 'anthropic claude',
    'openai codex', 'codex'
  )
  or (SoftwareName has 'claude' and SoftwareVendor has 'anthropic')
| project DeviceId, DeviceName, SoftwareName, SoftwareVersion, SoftwareVendor, OSPlatform
| order by SoftwareName asc
```

---

### Query 2 — AI Agent CLI Process Activity

Finds processes associated with AI CLI tools (Claude Code, GitHub Copilot CLI, Gemini CLI, Codex CLI, Cursor agent) run on a device.

```kql
DeviceProcessEvents
| where DeviceName contains "<your-device-name>"
| extend fn = tolower(FileName),
         cmd = tolower(ProcessCommandLine),
         icmd = tolower(InitiatingProcessCommandLine)
| where
    fn in ("gh","gh.exe","claude","claude.exe","agent","agent.exe","gemini","gemini.exe","codex","codex.exe")
    or cmd has_any (" gh ", "gh copilot", " github copilot", " claude ", " claude-code ", " agent ", " gemini ", " codex ")
    or icmd has_any (" gh ", "gh copilot", " github copilot", " claude ", " claude-code ", " agent ", " gemini ", " codex ")
| extend Tool = case(
    fn startswith "gh" or cmd has "gh copilot" or cmd has " gh ", "GitHub CLI",
    fn startswith "claude" or cmd has " claude " or cmd has " claude-code ", "Claude CLI",
    fn startswith "agent" or cmd has " agent ", "Cursor CLI",
    fn startswith "gemini" or cmd has " gemini ", "Gemini CLI",
    fn startswith "codex" or cmd has " codex ", "Codex CLI",
    "Other/Unknown"
)
| project Timestamp, DeviceId, DeviceName, Tool, FileName, FolderPath, ProcessCommandLine, InitiatingProcessFileName, InitiatingProcessCommandLine, AccountName
| order by Timestamp desc
| limit 200
```

---

### Query 3 — Scan MCP related Process events

Detects processes that reference MCP configuration files (mcp.json, mcp_config.json, claude_desktop_config.json) in their command line or initiating process command line.

```kql
DeviceProcessEvents
| where DeviceName contains "<your-device-name>"
| where ProcessCommandLine has 'mcp.json'
    or ProcessCommandLine has 'mcp_config.json'
    or ProcessCommandLine has 'claude_desktop_config.json'
    or InitiatingProcessCommandLine has 'mcp.json'
    or InitiatingProcessCommandLine has 'mcp_config.json'
    or InitiatingProcessCommandLine has 'claude_desktop_config.json'
| extend ExtractedPath = extract(@'([^\s"]+(?:mcp\.json|mcp_config\.json|claude_desktop_config\.json))', 1, coalesce(ProcessCommandLine, InitiatingProcessCommandLine))
| where isnotempty(ExtractedPath)
| summarize LastSeen=max(Timestamp) by DeviceId, DeviceName, ExtractedPath, FileName
| order by LastSeen desc
| limit 100
```

---

Replace `<your-device-name>` with the device's hostname as it appears in the Devices list. Leave the filter empty (remove the `where DeviceName` line) to scan all devices.

---
### Saving a query

After running a query, click **Save** → **Save query** and give it a name. It will appear under **Hunting → Saved queries** for easy reuse.

---

## 3. Deploying the Cursor/Claude  Hooks Script via Live Response

Live Response lets you run a pre-uploaded script on a single device directly from the MDE portal.

### Step 1 — Upload the script to the Live Response library

This is a one-time setup.

1. In the MDE portal, go to **Settings**
2. **Endpoints** → **General** → **Live response library**
3. Click **Upload file**
4. Upload the script file `install_cursor_hooks.sh/ install_claude_hooks.sh`
5. Add a description (e.g. `Akto - Install Cursor/Claude guardrail hooks`)
6. Click **Save**

> The script must be uploaded before you can run it on any device. Repeat this step any time the script changes.

---

### Step 2 — Start a Live Response session on a device

1. Go to **Assets → Devices**
2. Find the target device and click its name to open the device page
3. Select **Initiate live response session**
4. Wait for the session to connect (this can take up to 2 minutes)

---

### Step 3 — Run the script

Once the Live Response console is open:

```
run install_cursor_hooks.sh
```

Type the command exactly as shown. The script name must match what you uploaded in Step 1.

The console will show output lines as the script runs. A successful run ends with:

```
✅ Cursor IDE hooks installed successfully!
```

If Cursor IDE is not installed on that device, the script exits cleanly with:

```
Cursor IDE not detected - skipping hook installation
```

## Notes

- **Live Response requires MDE Plan 2** — it is not available on Plan 1 or Defender for Business Basic.
- All queries above scope to a single device by default (`DeviceName contains`). Remove that filter to run fleet-wide, but expect higher result counts.
- The time frame for the KQL queries can be controlled in the portal for upto a maximum of 30 days. 