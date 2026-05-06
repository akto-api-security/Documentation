# Run with GitHub Copilot

## Overview

You can run Ask Akto with GitHub Copilot as the underlying AI model using the **Bring Your Own Model** configuration. This lets you power your on-prem Ask Akto assistant with GitHub Copilot instead of Anthropic Claude.

{% hint style="info" %}
You can use this integration only with **on-premises deployments**.
{% endhint %}

## Before You Begin

Make sure you have:

* A running self-hosted Akto deployment — if you don't have one yet, follow the Self-Hosted Deployment guide first
* Your GitHub Copilot access with a valid API key
* Admin access to your Akto dashboard

## Configuration

{% stepper %}
{% step %}
### **Generate Your GitHub Copilot API Key**

You need a GitHub **fine-grained personal access token** to authenticate with GitHub Copilot. Here's how to generate one:

1. Go to [github.com](https://github.com) and click your **profile picture** → **Settings**
2. Scroll to the bottom of the left sidebar and click **Developer settings**
3. Go to **Personal access tokens** → **Fine-grained tokens**
4. Click **Generate new token**
5. Give your token a recognisable name (e.g., `akto-copilot`) and set an expiration that suits your policy
6.  Under **Permissions** → **Account permissions**, add the following three permissions, all set to **Read-only**:

    * **Copilot Chat**
    * **Copilot Editor Context**
    * **Copilot Requests**

    <div data-with-frame="true"><figure><img src="../../.gitbook/assets/image.png" alt="" width="563"><figcaption></figcaption></figure></div>
7. Click **Generate token** at the bottom
8. **Copy your token immediately-** GitHub will only show it once

You'll use this token as your API key in the next step.
{% endstep %}

{% step %}
### **Configure GitHub Copilot as Your Model**

Add your token to Akto so it can call GitHub Copilot:

1. In your Akto dashboard, go to **Settings → Integrations → Agents**
2. Click **Add Model**
3. Select **GitHub Copilot** as the provider
4. Enter a **Name**, paste your token into the **API Key** field, and pick a supported **Model**
5. Click **Save.**

{% hint style="warning" %}
## NOTE

Only models that your GitHub Copilot subscription has access to will work. While configuring, make sure to pick a model that's actually available to you.
{% endhint %}
{% endstep %}

{% step %}
### **Update Your Environment File**

Open your `docker-agentic-testing-dashboard.env` file and update it with the values below. These override the defaults you set during the base deployment:

```bash
# Leave this empty — you're using GitHub Copilot as your model provider
ANTHROPIC_API_KEY=""

NODE_ENV=production
PORT=5500
AGENTIC_MODE=true

MCP_SERVER_URL=<YOUR_AKTO_MCP_SERVER_URL>

# Required when you're using GitHub Copilot
DASHBOARD_URL=<YOUR_AKTO_DASHBOARD_URL>
AKTO_API_KEY=<YOUR_AKTO_API_KEY>
```

**What you need to set (GitHub Copilot specific)**

<table><thead><tr><th width="237.70703125">Variable</th><th>What to set</th></tr></thead><tbody><tr><td><code>ANTHROPIC_API_KEY</code></td><td>Leave it empty — you're using GitHub Copilot instead.</td></tr><tr><td><code>AGENTIC_MODE</code></td><td>Must be set to <code>true</code>.</td></tr><tr><td><code>MCP_SERVER_URL</code></td><td>Your Akto MCP server URL.</td></tr><tr><td><code>DASHBOARD_URL</code></td><td>Your Akto Agentic AI Security Dashboard's base URL.</td></tr><tr><td><code>AKTO_API_KEY</code></td><td>Your Akto API key for authenticating with the Akto dashboard.</td></tr></tbody></table>
{% endstep %}

{% step %}
### **Restart Your Services**

Restart your services to apply the updated environment file:

```bash
docker compose down && docker compose up -d
```

To confirm everything is running, follow the Verify Connectivity steps from the base deployment guide.
{% endstep %}
{% endstepper %}

## Support

If you need help with the deployment:

* **Discord Community**: Join our community at [discord.gg/Wpc6xVME4s](https://discord.gg/Wpc6xVME4s)
* **Email Support**: Contact us at [support@akto.io](mailto:support@akto.io)

Our team is available 24/7 to assist you with setup, troubleshooting, and best practices.
