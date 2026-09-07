---
description: >-
  Override the auto-detected hostname and username shown for a Mac in Akto by staging an identity.json file before installing AI Endpoint Shield.
---

# Custom Device Name and Email

## Overview

By default, the [Endpoint Shield](../../ai-agent-activity/view-endpoint-shield-details.md) Agent List shows whatever hostname and OS username each Mac reports. On an imaged fleet, that's often a generic computer name or a local login that doesn't map back to the employee's corporate email.

Staging an **`identity.json`** file on the device before install lets you assign a specific device name and email that Akto shows instead.

{% hint style="info" %}
**macOS only, for now.** This capability currently applies to AI Endpoint Shield on macOS. Windows and Linux support isn't available yet.
{% endhint %}



## File format

```json
{
  "email": "akto@akto.com",
  "deviceName": "akto-mac-001"
}
```



## Where and when to place it

Endpoint Shield reads `identity.json` from:

```
/Library/Application Support/Akto/identity.json
```

Stage it **before** running `install.sh` (via Jamf, Mosyle, or NinjaOne) — not after:

```bash
sudo mkdir -p "/Library/Application Support/Akto"
sudo cp identity.json "/Library/Application Support/Akto/identity.json"
```

Once the file is in place, Endpoint Shield picks it up automatically on its next check-in — no service restart, reinstall, or reboot needed.



## What shows up in Endpoint Shield

| `identity.json` field | Shows up as |
| --- | --- |
| `deviceName` | Hostname, in the Agent List and Endpoint Details |
| `email` | Username |

{% hint style="warning" %}
**One file per device.** `email` and `deviceName` are specific to each machine, and there's no Akto-provided mechanism yet to auto-populate them from Jamf/Mosyle/NinjaOne device variables (computer name, directory-bound user, and so on). You, or your imaging/staging workflow, are responsible for generating a distinct `identity.json` per device before rollout.
{% endhint %}

## Related documentation

* [Jamf MDM Deployment](jamf-mdm-deployment.md)
* [Mosyle MDM Deployment](mosyle-deployment.md)
* [NinjaOne Deployment (macOS)](ninjaone-macos-deployment.md)
* [Endpoint Shield](../../ai-agent-activity/view-endpoint-shield-details.md)

## Get support

1. In-app Intercom in the Akto dashboard
2. [Discord community](https://www.akto.io/community)
3. [support@akto.io](mailto:support@akto.io)
4. [Contact Akto](https://www.akto.io/contact-us)
