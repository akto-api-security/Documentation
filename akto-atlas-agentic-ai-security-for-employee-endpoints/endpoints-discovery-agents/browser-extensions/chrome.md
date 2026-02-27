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

## Prerequisites for Enterprise Deployment

You can gather the following information before starting deployment:

* Google Workspace administrator access to `https://admin.google.com`
* Target Organisational Unit (OU) or user group for deployment
* Chrome extension ID provided by the Akto Support team
* Custom extension URL provided by the Akto Support team
* Update XML URL provided by the Akto Support team

{% hint style="info" %}
## **Support Contact**

You can request the extension ID, custom extension URL, and update XML URL from the Akto Support team at [**support@akto.io**](mailto:support@akto.io).
{% endhint %}

## Installation Steps

{% stepper %}
{% step %}
### Navigating to Chrome Extension Management

1. Sign in to `https://admin.google.com`.
2. Navigate to **Devices**.
3. Select **Chrome**.
4. Select **Apps & extensions**.
5. Open the **Users and browsers** tab.
6.  Select the target Organisational Unit.

    <div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (1).webp" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
### Adding the Akto Chrome Extension by ID

1. Select the yellow **+** button.
2.  Choose **Add Chrome app or extension by ID**.

    <div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (2).webp" alt="" width="375"><figcaption></figcaption></figure></div>
3. Enter the Chrome extension ID provided by the Akto Support team.
4. Expand **From a custom URL**.
5.  Enter the custom extension URL provided by the Akto Support team.

    <div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (3).webp" alt="" width="375"><figcaption></figcaption></figure></div>
6. Select **Save**.
{% endstep %}

{% step %}
### Configuring Force Installation

1. Open the extension configuration panel.
2.  Set **Installation policy** to **Force install**.

    <div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (4).webp" alt="" width="375"><figcaption></figcaption></figure></div>
3.  Enter the **update XML URL** provided by the Akto Support team in the **Installation URL** space.

    <div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (5).webp" alt="" width="375"><figcaption></figcaption></figure></div>
4. Select **Save**.

Now, force installation enables automatic deployment to all managed Chrome users within the selected Organisational Unit.
{% endstep %}
{% endstepper %}

## Extension Appearance After Successful Installation

Managed Chrome browsers install the Akto extension after policy synchronisation. The Chrome toolbar then displays the Akto extension icon once installation completes.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/Feb 27 2026 Screenshot (1).webp" alt="" width="563"><figcaption></figcaption></figure></div>

## Support

For deployment assistance or troubleshooting, you can contact the Akto Support team at [**support@akto.io**](mailto:support@akto.io).

## What Next

Chrome extension installation completes enterprise deployment.

The next section explains how the Akto Chrome extension monitors browser activity and enforces guardrails during runtime.
