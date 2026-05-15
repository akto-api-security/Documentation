# Safari

Discover AI agents and MCP servers directly from Safari on macOS. The Akto Safari extension captures agent interactions in real-time as you browse.

## What Extension Captures

The Safari extension monitors:

* AI agent API calls and responses
* MCP server interactions
* Tool invocations and parameters
* Authentication tokens and headers
* Request/response payloads

All captured data is sent securely to your Akto instance for analysis.

{% hint style="info" %}
**Privacy & Security**

The extension only captures traffic when actively enabled and only sends data to your configured Akto instance. You have full control over what gets monitored.
{% endhint %}

## Deployment using ZIP File

### Prerequisites

* Safari on macOS (Ventura 13 or higher recommended)
* The Akto Security extension ZIP file
* The extension app bundle (extracted from the ZIP file)

{% hint style="warning" %}
Contact the Akto support team for the required extension ZIP file.
{% endhint %}

### Steps

{% stepper %}
{% step %}
**Get the Extension Files**

* Download the extension package you received
* If it's a ZIP file, extract it to a folder on your computer
* Remember where you saved the `.app` bundle
{% endstep %}

{% step %}
**Move the App to Applications**

* Move the extracted `.app` bundle to your `/Applications` folder
* Launch the app once so macOS registers it
{% endstep %}

{% step %}
**Enable Safari Developer Mode**

Open Safari and enable developer features:

1. Click **Safari** in the menu bar → **Settings**
2. Open the **Advanced** tab
3. Check **"Show features for web developers"**

The **Develop** menu will now appear in the Safari menu bar.
{% endstep %}

{% step %}
**Allow Unsigned Extensions**

1. Click **Develop** in the menu bar
2. Select **Allow Unsigned Extensions**

{% hint style="warning" %}
This setting resets every time Safari is quit. You will need to re-enable it each time you restart Safari until the extension is distributed through the App Store.
{% endhint %}
{% endstep %}

{% step %}
**Enable the Akto Extension**

1. Click **Safari** → **Settings**
2. Open the **Extensions** tab
3. Find **Akto Security** in the list
4. Toggle the checkbox next to it to enable it
{% endstep %}

{% step %}
**Verify It's Installed**

You should now see **Akto Security** in the Extensions list with:

* Akto icon
* Version number
* Toggle switch set to ON

The Akto icon will also appear in the Safari toolbar.
{% endstep %}
{% endstepper %}

## Support

For deployment assistance or troubleshooting, you can contact the Akto Support team at [**support@akto.io**](mailto:support@akto.io).
