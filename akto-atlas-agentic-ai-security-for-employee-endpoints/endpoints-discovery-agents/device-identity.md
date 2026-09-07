---
description: >-
  Override the auto-detected device name and user shown in Akto for AI
  Endpoint Shield and the Chrome browser extension.
---

# Custom Device Name and Email

## Overview

By default, Akto shows whatever hostname and OS username (or Chrome profile) each device reports. On an imaged fleet, that's often a generic computer name or a local login that doesn't map back to the employee's corporate email.

Both AI Endpoint Shield and the Chrome browser extension let you override this with a specific device name and email, so activity is attributed correctly. Each product reads its identity from a different place, covered separately below.

## AI Endpoint Shield (macOS)

{% hint style="info" %}
**MacOS only.** This capability currently applies to AI Endpoint Shield on macOS.
{% endhint %}

Staging an **`identity.json`** file on the device before install lets you assign a specific device name and email that the [Endpoint Shield](../ai-agent-activity/view-endpoint-shield-details.md) Agent List shows instead of the auto-detected hostname and username.

### File format

```json
{
  "email": "akto@akto.com",
  "deviceName": "akto-mac-001"
}
```

### Where and when to place it

Endpoint Shield reads `identity.json` from:

```
/Library/Application Support/Akto/identity.json
```

Stage it **before** running `install.sh` (via Jamf, Mosyle, or NinjaOne), not after:

```bash
sudo mkdir -p "/Library/Application Support/Akto"
sudo cp identity.json "/Library/Application Support/Akto/identity.json"
```

Once the file is in place, Endpoint Shield picks it up automatically on its next check-in: no service restart, reinstall, or reboot needed.

### What shows up in Endpoint Shield

| `identity.json` field | Shows up as |
| --- | --- |
| `deviceName` | Hostname, in the Agent List and Endpoint Details |
| `email` | Username |

{% hint style="warning" %}
**One file per device.** `email` and `deviceName` are specific to each machine, and there's no Akto-provided mechanism yet to auto-populate them from Jamf/Mosyle/NinjaOne device variables (computer name, directory-bound user, and so on). You, or your imaging/staging workflow, are responsible for generating a distinct `identity.json` per device before rollout.
{% endhint %}

## Browser Extension (Chrome, Windows via Intune)

A managed policy tells the Chrome extension who the user and device are, separate from the force-install policy that puts the extension on the machine. Set this up before force-installing the extension.

{% hint style="info" %}
The keys the extension accepts are fixed by its schema. This policy only sets their values; there's no file to edit.
{% endhint %}

### Managed keys

| Key | Set to (Intune token) | Purpose | Fallback if unset |
| --- | --- | --- | --- |
| `email` | `{{UserPrincipalName}}` | Primary user identity | Chrome profile email |
| `username` | `{{UserName}}` | Display name | Derived from email |
| `deviceName` | `{{DeviceName}}` | Device identity | Enterprise device ID → generated UUID |

All three keys are optional, each with its own fallback, so the policy can be deployed with any subset of them.

{% hint style="warning" %}
Use `deviceName` with `{{DeviceName}}`. Do not use the older `deviceId` / `{{SerialNumber}}` pairing (`deviceName` replaces it).
{% endhint %}

### Configure the policy

{% stepper %}
{% step %}
**Create a Custom Configuration Profile**

1. Open the Microsoft Intune admin center.
2. Navigate to **Devices → Windows → Configuration**.
3. Click **Create**.
4. Set:
   * **Platform:** `Windows 10 and later`
   * **Profile type:** `Templates` → `Custom`
5. Click **Create**.
{% endstep %}

{% step %}
**Add the OMA-URI Setting**

1. Enter a profile name, for example: `akto-browser-extension-identity`.
2. Under **Configuration settings**, click **Add**.
3. Set the **OMA-URI** to the extension's managed-policy registry path:

```
HKLM\SOFTWARE\Policies\Google\Chrome\3rdparty\extensions\mjcadlphjmoinphffggcpineljpageie\policy
```

4. Set **Data type** to **String (XML)**, and paste the policy JSON as the value:

```json
{
  "email":      { "Value": "{{UserPrincipalName}}" },
  "username":   { "Value": "{{UserName}}" },
  "deviceName": { "Value": "{{DeviceName}}" }
}
```

5. Click **Save**.
{% endstep %}

{% step %}
**Assign the Profile**

1. Assign the profile to the same device group you'll use for the force-install profile.
2. On **Review + create**, confirm the OMA-URI and JSON value are correct.
3. Click **Create**.
{% endstep %}
{% endstepper %}

### Verify

On an enrolled machine, either:

* Open `chrome://policy`, click **Reload policies**, and confirm `email`, `username`, and `deviceName` show under the Akto extension's policy, **or**
* Run in PowerShell:

```powershell
Get-ItemProperty 'HKLM:\SOFTWARE\Policies\Google\Chrome\3rdparty\extensions\mjcadlphjmoinphffggcpineljpageie\policy'
```

## Related documentation

* [Jamf MDM Deployment](ai-endpoint-shield/jamf-mdm-deployment.md)
* [Mosyle MDM Deployment](ai-endpoint-shield/mosyle-deployment.md)
* [NinjaOne Deployment (macOS)](ai-endpoint-shield/ninjaone-macos-deployment.md)
* [Endpoint Shield](../ai-agent-activity/view-endpoint-shield-details.md)
* [Chrome Intune Deployment (Windows)](browser-extensions/chrome/intune-deployment.md)

## Get support

1. In-app Intercom in the Akto dashboard
2. [Discord community](https://www.akto.io/community)
3. [support@akto.io](mailto:support@akto.io)
4. [Contact Akto](https://www.akto.io/contact-us)
