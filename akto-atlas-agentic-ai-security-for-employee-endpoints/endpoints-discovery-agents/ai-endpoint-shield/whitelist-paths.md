# Whitelist Paths — AI Endpoint Shield

If an endpoint management tool is deployed in your organization, add the Akto AI Endpoint Shield binary paths as exclusions to prevent the tool from blocking or quarantining the process.

> Only the binary paths need to be excluded. Unlike broader EDR whitelisting, exclusions scoped to the executable paths are sufficient for normal operation.

---

## Paths to Exclude

These paths apply to all endpoint management tools (Microsoft Defender, SentinelOne, CrowdStrike, and others).

| Path | Description |
|------|-------------|
| `/usr/local/bin/akto-endpoint-shield` | Main binary (MDM/Jamf install) |
| `~/.akto-endpoint-shield/bin/akto-endpoint-shield` | User-level binary |

---

## Configure for MS Defender Endpoint

The following steps are specific to **Microsoft Defender for Endpoint**. For other tools, refer to your vendor's documentation for adding process or path exclusions.

### Directly on the Mac

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

### Via Jamf Pro

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

### Via Microsoft Intune

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

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact [support@akto.io](mailto:support@akto.io) for email support.
