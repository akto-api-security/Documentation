---
description: >-
  Override the auto-detected hostname and username shown for a Mac in Akto by
  staging an identity.json file before installing AI Endpoint Shield.
---

# Custom Device Name and Email (macOS)

## Overview

By default, the [Endpoint Shield](../../ai-agent-activity/view-endpoint-shield-details.md) Agent List shows whatever hostname and OS username each Mac reports. On an imaged fleet those are often generic, unhelpful computer names, or a local login name that doesn't map back to the employee's corporate email.

Staging an `identity.json` file on the device before you run the install script lets you assign a specific device name and email that Akto shows instead.

## How it maps

| `identity.json` field | Shows up as |
| --- | --- |
| `deviceName` | Hostname, in the Agent List and Endpoint Details |
| `email` | Username |

## File format

```json
{
  "email": "akto@akto.com",
  "deviceName": "akto-mac-001"
}
```

## Where to place it

Endpoint Shield reads `identity.json` from:

```
/Library/Application Support/Akto/identity.json
```

```bash
sudo mkdir -p "/Library/Application Support/Akto"
sudo cp identity.json "/Library/Application Support/Akto/identity.json"
```

## When to stage it

Place `identity.json` **before** running `install.sh` (via Jamf, Mosyle, or NinjaOne) on the device, not after. Once it's in place, Endpoint Shield picks it up automatically on its next check-in — no service restart, reinstall, or reboot needed.

{% hint style="warning" %}
**One file per device, today.** `email` and `deviceName` are specific to each machine, and there's currently no Akto-provided mechanism to auto-populate them from Jamf/Mosyle/NinjaOne device variables (computer name, directory-bound user, and so on). You, or your imaging/staging workflow, are responsible for generating a distinct `identity.json` per device before rollout. This page covers the file format and placement only.
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
