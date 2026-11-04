# Managed Configuration (Identity)

Push per-user and per-device identity to the Akto Chrome extension through your MDM. This
lets each managed device report the correct **user** and **device** identity to Akto,
instead of relying on auto-detection.

## Overview

The extension reads a small **managed configuration** that Chrome delivers from your MDM
policy. You set three values; Chrome hands them to the extension automatically. This is
separate from force-install (which is covered in [Intune Deployment](intune-deployment.md))
— force-install puts the extension on the device; managed configuration tells it who the
user and device are.

{% hint style="info" %}
Ask the Akto Support team at [**support@akto.io**](mailto:support@akto.io) for your
**Extension ID**. The examples below use `<AKTO_EXTENSION_ID>` as a placeholder.
{% endhint %}

## Where the extension reads from

The extension reads from **Chrome's managed configuration** for the Akto extension ID.

On Windows, Chrome exposes this at the registry key:

```
HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome\3rdparty\extensions\<AKTO_EXTENSION_ID>\policy
```

On macOS, it maps to the preference domain:

```
com.google.Chrome.extensions.<AKTO_EXTENSION_ID>
```

Whatever your MDM writes to that location is what the extension picks up.

## Fields the extension expects

Exactly three fields, all plain text (string / `REG_SZ`):

| Field | What it must contain | Suggested Intune variable |
|------------|----------------------------------------------------|-----------------------------|
| `email` | The signed-in user's email address (must contain `@`) | `{{UserPrincipalName}}` |
| `username` | The user's login or display name | `{{UserName}}` |
| `deviceId` | The device / endpoint **name** (the machine name, e.g. `windows-desktop`) | `{{DeviceName}}` |

{% hint style="warning" %}
Set `deviceId` to the **device / endpoint name**, not a serial number. It must be
**stable** — the same value every time on that machine — otherwise the device appears as a
new device on each heartbeat.
{% endhint %}

## Configure in Intune

Add Chrome's **managed configuration** setting to your Settings Catalog profile (the same
profile used for force-install, or a separate one).

{% stepper %}
{% step %}
**Add the managed configuration setting**

1. In your Windows **Settings catalog** profile, click **Add settings**.
2. In **Settings picker**, search for `managed configuration`.
3. Select **Google Chrome > Extensions**.
4. Choose **Configure the list of managed configurations (Device)**.
5. Click **Select these settings**.
{% endstep %}

{% step %}
**Set the extension ID and JSON**

1. Set the policy to **Enabled**.
2. Add an entry with the **Extension ID** = `<AKTO_EXTENSION_ID>`.
3. Set the **configuration JSON** to:

```json
{
  "email": "{{UserPrincipalName}}",
  "username": "{{UserName}}",
  "deviceId": "{{DeviceName}}"
}
```

4. Click **Next**, assign to your device groups, and **Create**.
{% endstep %}
{% endstepper %}

{% hint style="info" %}
On-prem Active Directory (GPO): use the Google Chrome ADMX template →
**Google Chrome > Extensions > Configure the list of managed configurations**, targeting
the same extension ID with the same three keys.
{% endhint %}

## Verify

On a target machine after the policy applies (restart Chrome / run `gpupdate /force` if
needed):

**Chrome policy page (fastest):**

1. Open `chrome://policy`.
2. Click **Reload policies**.
3. Search for `email` or `deviceId` — the applied values appear under the extension.

**Registry (PowerShell):**

```powershell
Get-ItemProperty 'HKLM:\SOFTWARE\Policies\Google\Chrome\3rdparty\extensions\<AKTO_EXTENSION_ID>\policy'
```

Expected output:

```
email    : user@company.com
username : user
deviceId : windows-desktop
```

{% hint style="info" %}
`Get-ChildItem` / `ls` on that key shows nothing — these are registry **values**, not
sub-keys. Use `Get-ItemProperty` to read them.
{% endhint %}

Once set, the values appear against the device and user in your Akto dashboard.

## If a field is missing

Every field is optional; the extension falls back automatically:

* **`email` missing** → uses the signed-in Chrome profile email.
* **`deviceId` missing** → uses the enterprise device id (directory id / serial / hostname), else an auto-generated id.
* **`username` missing** → derives a name from the email.

Providing all three gives the most accurate and consistent identity in Akto.

## Support

For the extension ID or configuration help, contact [**support@akto.io**](mailto:support@akto.io).
