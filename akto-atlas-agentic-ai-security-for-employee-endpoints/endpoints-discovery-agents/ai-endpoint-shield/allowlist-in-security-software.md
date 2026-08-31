---
description: >-
  Allowlist AI Endpoint Shield in the antivirus, EDR, and endpoint management
  tools deployed across your organization so they do not block or quarantine it.
---

# Allowlist in Security Software

AI Endpoint Shield runs a background binary as SYSTEM (Windows) or as the signed-in user (macOS), and installs hooks into local AI tooling. Antivirus, EDR, and endpoint management products routinely flag that behaviour and can quarantine the binary, kill the process at startup, or block the installer outright.

Add the paths below as exclusions in whichever tools your organization runs — Microsoft Defender, SentinelOne, CrowdStrike Falcon, Carbon Black, Netskope, and similar. Forward this page to your IT or security administrator.

> Only the binary paths need to be excluded. Unlike broader EDR allowlisting, exclusions scoped to the executable paths are sufficient for normal operation.

**Symptoms that point here:** the binary disappears after install, scheduled tasks show `LastResult 0xC000013A` or `0x00000005`, processes start and die within seconds, or the install log ends abruptly.

---

## Paths to Exclude

These paths apply to all endpoint management tools (Microsoft Defender, SentinelOne, CrowdStrike, and others).

**macOS**

| Path | Description |
|------|-------------|
| `/usr/local/bin/akto-endpoint-shield` | Main binary (MDM/Jamf install) |
| `/usr/local/lib/akto-endpoint-shield/` | Bundled runtime (includes `venv/bin/mitmdump` when the optional system proxy is enabled) |
| `~/.akto-endpoint-shield/bin/` | Per-user wrapper and hook installer scripts |

**Windows**

| Path | Description |
|------|-------------|
| `C:\Program Files\Akto Endpoint Shield\akto-endpoint-shield.exe` | Main binary |
| `C:\ProgramData\akto-endpoint-shield\` | Logs, and the mitmproxy virtualenv when the optional system proxy is enabled |

### Getting the binary hash

Some vendors want a SHA256 hash rather than (or in addition to) a path. Run this on an affected machine and share the output with your security administrator.

**macOS**

```bash
shasum -a 256 /usr/local/bin/akto-endpoint-shield
```

**Windows**

```powershell
Get-FileHash "C:\Program Files\Akto Endpoint Shield\akto-endpoint-shield.exe" -Algorithm SHA256 |
    Select-Object Hash, Path
```

The hash changes with every Akto release, so path- and signature-based exclusions are preferable where the vendor supports them.

---

## Configure for MS Defender Endpoint

The following steps are specific to **Microsoft Defender for Endpoint**. For other tools, refer to your vendor's documentation for adding process or path exclusions.

### macOS

#### Directly on the Mac

Run these commands on each machine (no MDM required):

{% stepper %}
{% step %}
Add the process and path exclusions:

```bash
sudo mdatp exclusion process add --name akto-endpoint-shield
mdatp exclusion path add --path /usr/local/bin/akto-endpoint-shield
mdatp exclusion folder add --path ~/.akto-endpoint-shield/bin/
```
{% endstep %}

{% step %}
Verify the exclusions were applied:

```bash
mdatp exclusion list
```
{% endstep %}
{% endstepper %}

---

#### Via Jamf Pro

Deploy a custom Microsoft Defender configuration profile with the preference domain `com.microsoft.wdav`.

{% stepper %}
{% step %}
In Jamf Pro, navigate to **Computers** → **Configuration Profiles** → **+ New**.
{% endstep %}

{% step %}
Add a payload: **Application & Custom Settings**.
{% endstep %}

{% step %}
Set **Preference Domain**: `com.microsoft.wdav`.
{% endstep %}

{% step %}
Upload or paste the following JSON:

```json
{
  "antivirusEngine": {
    "exclusions": [
      { "type": "path", "path": "/usr/local/bin/akto-endpoint-shield" },
      { "type": "folder", "path": "/Users/" }
    ]
  }
}
```

> Microsoft Defender on macOS does not expand `~` in exclusion paths. Using `/Users/` as a folder exclusion covers `~/.akto-endpoint-shield/` for all users on the machine.
{% endstep %}

{% step %}
Set **Scope** to target the relevant computers or groups.
{% endstep %}

{% step %}
Save and deploy.
{% endstep %}
{% endstepper %}

---

#### Via Microsoft Intune

{% stepper %}
{% step %}
Go to **Endpoint Security** → **Antivirus** → **Create Policy**.
{% endstep %}

{% step %}
Select **Platform: macOS** and **Profile: Microsoft Defender Antivirus**.
{% endstep %}

{% step %}
Under **Antivirus engine** → **Exclusions**, add the two paths above.
{% endstep %}

{% step %}
Assign the policy to the relevant device group and save.
{% endstep %}
{% endstepper %}

---

### Windows

#### Directly on the Windows Machine

Run the following commands in an **elevated PowerShell** session:

{% stepper %}
{% step %}
Add the process and path exclusions:

```powershell
Add-MpPreference -ExclusionProcess "akto-endpoint-shield.exe"
Add-MpPreference -ExclusionPath "C:\Program Files\Akto Endpoint Shield\"
```
{% endstep %}

{% step %}
Verify the exclusions were applied:

```powershell
Get-MpPreference | Select-Object -ExpandProperty ExclusionProcess
Get-MpPreference | Select-Object -ExpandProperty ExclusionPath
```
{% endstep %}
{% endstepper %}

---

#### Via Microsoft Intune

{% stepper %}
{% step %}
Go to **Endpoint Security** → **Antivirus** → **Create Policy**.
{% endstep %}

{% step %}
Select **Platform: Windows 10, Windows 11, and Windows Server** and **Profile: Microsoft Defender Antivirus**.
{% endstep %}

{% step %}
Under **Microsoft Defender Antivirus Exclusions**, add:
- **Process exclusions**: `akto-endpoint-shield.exe`
- **Path exclusions**: `C:\Program Files\Akto Endpoint Shield\`
{% endstep %}

{% step %}
Assign the policy to the relevant device group and save.
{% endstep %}
{% endstepper %}

---

## Configure for CrowdStrike Falcon

These steps apply to **Windows** machines managed by CrowdStrike Falcon. Forward this section to your IT / CrowdStrike administrator.

### Windows

Falcon needs both a path and a hash exclusion. Get the SHA256 hash first — see [Getting the binary hash](#getting-the-binary-hash) — and send it to your CrowdStrike administrator along with the steps below.

#### Falcon console exclusions

Add the following exclusions in the **Falcon console**, scoped to the policy or device group that covers the affected machines.

{% stepper %}
{% step %}
**ML exclusion — path**

Go to **Configuration → ML Exclusions → Add Exclusion** and fill in:

| Field | Value |
|---|---|
| Value | `C:\Program Files\Akto Endpoint Shield\akto-endpoint-shield.exe` |
| Type | Windows |
| Groups | *(select the device group)* |
{% endstep %}

{% step %}
**ML exclusion — hash**

Go to **Configuration → ML Exclusions → Add Exclusion** and fill in:

| Field | Value |
|---|---|
| Value | *(SHA256 hash from the step above)* |
| Type | SHA256 |
| Groups | *(select the device group)* |
{% endstep %}

{% step %}
**Prevention policy exclusion**

Go to **Configuration → Prevention Policies → *(policy name)* → Exclusions** and add `akto-endpoint-shield.exe` as a process exclusion.

This prevents behavioral detections from blocking the Akto process when it runs under the SYSTEM account at boot.
{% endstep %}

{% step %}
**Sensor visibility exclusion** *(optional)*

If Akto activity is generating excessive alerts in the Falcon dashboard, go to **Configuration → Sensor Visibility Exclusions → Add** and fill in:

| Field | Value |
|---|---|
| Path | `C:\Program Files\Akto Endpoint Shield\` |
{% endstep %}
{% endstepper %}

---

## Still blocked?

If the exclusions are in place and the binary is still being killed, run the diagnostic in [Windows Troubleshooting](windows-troubleshooting.md#full-automated-diagnostic) or [macOS Troubleshooting](macos-troubleshooting.md#full-automated-diagnostic) — both enumerate the security products present on the machine and the block events they recorded, which is what your vendor's support will ask for.

## Get support

1. In-app Intercom in the Akto dashboard
2. [Discord community](https://www.akto.io/community)
3. [support@akto.io](mailto:support@akto.io)
