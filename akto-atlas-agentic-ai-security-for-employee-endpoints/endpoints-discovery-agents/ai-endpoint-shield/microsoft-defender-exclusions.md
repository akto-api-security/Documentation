# Microsoft Defender Exclusions — AI Endpoint Shield

If Microsoft Defender for Endpoint is deployed in your organization, add the Akto AI Endpoint Shield binary paths as exclusions to prevent Defender from blocking or quarantining the process.

> Only the binary paths need to be excluded. Unlike broader EDR whitelisting, Defender exclusions scoped to the executable paths are sufficient for normal operation.

---

## Paths to Exclude

| Path | Description |
|------|-------------|
| `/usr/local/bin/akto-endpoint-shield` | Main binary (MDM/Jamf install) |
| `~/.akto-endpoint-shield/bin/akto-endpoint-shield` | User-level binary |

---

## How to Configure

### Directly on the Mac

Run these commands on each machine (no MDM required):

```bash
sudo mdatp exclusion process add --name akto-endpoint-shield
mdatp exclusion path add --path /usr/local/bin/akto-endpoint-shield
mdatp exclusion folder add --path ~/.akto-endpoint-shield/bin/
```

Verify the exclusions were applied:

```bash
mdatp exclusion list
```

---

### Via Jamf Pro

Deploy a custom Microsoft Defender configuration profile with the preference domain `com.microsoft.wdav`.

1. In Jamf Pro, navigate to **Computers** → **Configuration Profiles** → **+ New**
2. Add a payload: **Application & Custom Settings**
3. Set **Preference Domain**: `com.microsoft.wdav`
4. Upload or paste the following JSON:

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

5. Set **Scope** to target the relevant computers or groups
6. Save and deploy

> Microsoft Defender on macOS does not expand `~` in exclusion paths. Using `/Users/` as a folder exclusion covers `~/.akto-endpoint-shield/` for all users on the machine.

---

### Via Microsoft Intune

1. Go to **Endpoint Security** → **Antivirus** → **Create Policy**
2. Select **Platform: macOS** and **Profile: Microsoft Defender Antivirus**
3. Under **Antivirus engine** → **Exclusions**, add the two paths above
4. Assign the policy to the relevant device group and save

---

## Related Documentation

* [Whitelist Paths](whitelist-paths.md) — Full path list for EDR, antivirus, and other endpoint protection tools
* [Jamf MDM Deployment](jamf-mdm-deployment.md) — Deploying AI Endpoint Shield via Jamf Pro
* [AI Endpoint Shield Overview](README.md) — Manual installation and general overview
