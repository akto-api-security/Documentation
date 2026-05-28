# NinjaOne Deployment (macOS)

## Overview

Deploy **Akto Endpoint Shield** to macOS endpoints from NinjaOne using Akto's macOS `.sh` installation script.

{% hint style="info" %}
Replace placeholder values before rollout:

* `<AKTO_MACOS_INSTALL_SH_URL>`
{% endhint %}

## Prerequisites

* NinjaOne admin access with script and policy permissions
* macOS device policy in NinjaOne
* Akto-hosted macOS script URL (`install.sh`)
* Pilot device group for staged rollout

## Deployment Steps

{% stepper %}
{% step %}
### Create the macOS automation script

In NinjaOne:

1. Go to **Administration → Library → Automation**
2. Click **Add** and choose **Script**
3. Configure:
   * **Language:** ShellScript
   * **OS:** macOS
   * **Run As:** System
4. Save as: `Akto Endpoint Shield - macOS Install`
{% endstep %}

{% step %}
### Use this script content

```bash
#!/bin/bash
set -euo pipefail

SCRIPT_URL="<AKTO_MACOS_INSTALL_SH_URL>"
TMP_SCRIPT="/tmp/akto-endpoint-shield-install.sh"

echo "[Akto] Downloading install script..."
curl -fsSL "$SCRIPT_URL" -o "$TMP_SCRIPT"
chmod +x "$TMP_SCRIPT"

echo "[Akto] Running install script..."
bash "$TMP_SCRIPT"

echo "[Akto] Installation script finished."
```

{% hint style="info" %}
If your Akto script expects token/base URL or manifest variables, include them before `bash "$TMP_SCRIPT"` in the same script.
{% endhint %}
{% endstep %}

{% step %}
### Attach to policy and schedule

1. Open target **macOS policy**
2. Add a **Scheduled Script**
3. Select `Akto Endpoint Shield - macOS Install`
4. Schedule:
   * Pilot: immediate run
   * Production: daily
5. Save policy
{% endstep %}

{% step %}
### Validate on endpoint

Run on a test Mac:

```bash
ls -l /usr/local/bin/akto-endpoint-shield
launchctl list | grep -i akto-endpoint-shield || true
```

Expected:

* `/usr/local/bin/akto-endpoint-shield` exists
* Akto launch services appear for logged-in users
{% endstep %}
{% endstepper %}

## Troubleshooting

### Script exits early

* Confirm script runs as **System**
* Verify download from `<AKTO_MACOS_INSTALL_SH_URL>` succeeds
* Ensure required variables are set if your Akto script expects them

### Binary missing after run

* Re-run script on pilot endpoint
* Check NinjaOne script output logs for install-stage failure

## Related Documentation

* [Jamf MDM Deployment](jamf-mdm-deployment.md)
* [NinjaOne Deployment (Windows)](ninjaone-windows-deployment.md)

## Support

1. In-app Intercom in Akto dashboard
2. [Discord community](https://www.akto.io/community)
3. `support@akto.io`
4. [Contact Akto](https://www.akto.io/contact-us)
