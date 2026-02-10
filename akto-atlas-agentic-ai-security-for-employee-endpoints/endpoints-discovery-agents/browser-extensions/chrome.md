# Chrome

Discover AI agents and MCP servers directly from Google Chrome or any Chromium-based browser (Edge, Brave, Opera, etc.). The Akto Security extension captures agent interactions in real-time as you browse.

## What Extension Captures

The Chrome extension monitors:

* AI agent API calls and responses
* MCP server interactions
* Tool invocations and parameters
* Authentication tokens and headers
* Request/response payloads

All captured data is sent securely to your Akto instance for analysis.

{% hint style="info" %}
#### Privacy & Security

The extension only captures traffic when actively enabled and only sends data to your configured Akto instance. You have full control over what gets monitored.
{% endhint %}

## Prerequsites

* Google Chrome browser (Version 88 or higher)
* The Akto Security extension ZIP file (required). If you don’t have it, contact the Akto support team.
* The extension folder (extracted from the ZIP file)

## Installation Steps

{% stepper %}
{% step %}
**Get the Extension Files**

* Download the extension package you received
* If it's a ZIP file, extract it to a folder on your computer
* Remember where you saved this folder
{% endstep %}

{% step %}
**Open Chrome Extensions**

Open Chrome and type this in the address bar:

```hurl
chrome://extensions/
```

Press Enter.

**OR**

Click the three dots (⋮) in Chrome → **More tools** → **Extensions**
{% endstep %}

{% step %}
**Turn On Developer Mode**

* Look at the top-right corner of the Extensions page
* Find the **Developer mode** toggle switch
* Turn it **ON** (it will turn blue)
{% endstep %}

{% step %}
**Load the Extension**

* Click the **Load unpacked** button (appears at the top after Step 3)
* A file browser will open
* Find and select the Akto Security extension folder
* Click **Select Folder**
{% endstep %}

{% step %}
**Verify It's Installed**

You should now see **Akto Security** in your extensions list with:

* Akto icon
* Version number
* Toggle switch set to ON
{% endstep %}

{% step %}
**Pin to Toolbar (Optional but Recommended)**

* Click the puzzle icon (🧩) in Chrome toolbar
* Find **Akto Security** in the list
* Click the pin icon (📌) next to it
* The Akto icon will appear in your toolbar
{% endstep %}
{% endstepper %}

The extension is now installed and working. It will automatically monitor supported websites in the background.

{% hint style="success" %}
#### Supported Websites

The extension works on these platforms:

* ChatGPT ([chatgpt.com](http://chatgpt.com/))
* Claude AI ([claude.ai](http://claude.ai/))
* Grok ([grok.com](http://grok.com/))
* Perplexity ([perplexity.ai](http://perplexity.ai/))
* Google Gemini ([gemini.google.com](http://gemini.google.com/))
{% endhint %}

## Troubleshooting

{% tabs %}
{% tab title="Extension not showing up" %}
* Make sure you selected the correct folder (should contain files like manifest.json)
* Check that Developer mode is ON
* Refresh the Extensions page (F5)
* Restart Chrome and try again
{% endtab %}

{% tab title="Extension shows errors" %}
* Contact your IT administrator
* Make sure you're using Chrome version 88 or higher
{% endtab %}

{% tab title="Extension not working" %}
* Make sure the toggle is ON for Akto Security
* Visit one of the supported websites (ChatGPT, Claude, etc.)
* Refresh the webpage after installing
* Click the Akto icon to check its status
{% endtab %}
{% endtabs %}

## Support

If you need help, contact your IT administrator or visit[https://www.akto.io](https://www.akto.io)
