# NinjaOne Deployment (Chrome Extension)

Deploy the Akto Chrome extension on NinjaOne-managed Windows endpoints by setting Chrome force-install policy values.

## Prerequisites

* NinjaOne admin access with script and policy permissions
* Windows device policy in NinjaOne
* Akto-provided values:
  * `<AKTO_CHROME_EXTENSION_ID>`
  * `<AKTO_CHROME_UPDATE_XML_URL>`

## Policy Value Format

Use this exact value:

```text
<AKTO_CHROME_EXTENSION_ID>;<AKTO_CHROME_UPDATE_XML_URL>
```

Example:

```text
mjcadlphyjmonhffggcpinejpageieeh;https://akto-chrome-ext.s3.ap-south-1.amazonaws.com/akto-chrome-ext/update.xml
```

## Deployment Steps

{% stepper %}
{% step %}
### Create Windows script for Chrome force-install

In NinjaOne Automation Library, create a PowerShell script (Run As: System) named:

`Akto Chrome Extension - Force Install`
{% endstep %}

{% step %}
### Use this script content

Download direct script file:

* [akto-chrome-ninjaone-force-install.ps1](scripts/akto-chrome-ninjaone-force-install.ps1)

<details>
<summary><strong>Show script</strong></summary>

```powershell
$ErrorActionPreference = "Stop"

$regPath = "HKLM:\SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist"
$extensionValue = "<AKTO_CHROME_EXTENSION_ID>;<AKTO_CHROME_UPDATE_XML_URL>"

if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

New-ItemProperty -Path $regPath -Name "1" -PropertyType String -Value $extensionValue -Force | Out-Null
Write-Host "[Akto] Chrome extension force-install policy set: $extensionValue"
```

</details>
{% endstep %}

{% step %}
### Attach script to Windows policy

1. Open target Windows policy
2. Add a **Scheduled Script** for `Akto Chrome Extension - Force Install`
3. Run once on pilot devices
4. Add to standard build policy for production devices
{% endstep %}

{% step %}
### Validate on endpoint

1. Restart Chrome on a test endpoint
2. Open `chrome://policy` and confirm policy refresh
3. Open `chrome://extensions` and confirm Akto extension is installed and managed
{% endstep %}
{% endstepper %}

## Troubleshooting

### Extension does not appear

* Confirm value format is exactly `id;update_xml_url`
* Confirm policy key exists at `HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist`
* Restart Chrome and re-check `chrome://policy`

## Related Documentation

* [Intune Deployment (Windows)](intune-deployment.md)
* [Extension Usage Behaviour](extension-usage-behaviour.md)
* [NinjaOne Deployment (Windows Endpoint Shield)](../../ai-endpoint-shield/ninjaone-windows-deployment.md)

## Support

For extension ID and update URL details, contact [**support@akto.io**](mailto:support@akto.io).
