# Run Ask Akto with GitHub Copilot

## Overview

You can run Ask Akto with GitHub Copilot as the underlying AI model using the **Bring Your Own Model** configuration. This lets you power your on-prem Ask Akto assistant with GitHub Copilot instead of Anthropic Claude.

{% hint style="info" %}
You can use this integration only with **on-premises deployments**.
{% endhint %}

## Before You Begin

Make sure you have:

* A running self-hosted Akto deployment — if you don't have one yet, follow the [Self-Hosted Deployment](self-hosted-deployment.md) guide first
* Your GitHub Copilot access with a valid API key
* Admin access to your Akto dashboard

## Configuration

{% stepper %}
{% step %}
#### Configure GitHub Copilot as Your Model

Head to the [Agent Configuration](agent-configuration.md) guide and select **GitHub Copilot** as your agent when adding a model.
{% endstep %}

{% step %}
#### Update Your Environment File

Open your `docker-agentic-testing-dashboard.env` file and update it with the values below. These override the defaults you set during the [base deployment](self-hosted-deployment.md#create-environment-files):

```bash
# Leave this empty — you're using GitHub Copilot as your model provider
ANTHROPIC_API_KEY=""

NODE_ENV=production
PORT=5500
AGENTIC_MODE=true

# Uses the Docker service name since both your containers run in the same compose stack
MCP_SERVER_URL=http://mcp-server:4000

# Required when you're using GitHub Copilot
DASHBOARD_URL=<YOUR_AKTO_DASHBOARD_URL>
AKTO_API_KEY=<YOUR_AKTO_API_KEY>
```

**What you need to set (GitHub Copilot specific)**

| Variable | What to set |
|---|---|
| `ANTHROPIC_API_KEY` | Leave it empty — you're using GitHub Copilot instead. |
| `DASHBOARD_URL` | Your Akto Agentic AI Security Dashboard's base URL. |
| `AKTO_API_KEY` | Your API key for authenticating with the Akto dashboard. |
{% endstep %}

{% step %}
#### Restart Your Services

Restart your services to apply the updated environment file:

```bash
docker compose down && docker compose up -d
```

To confirm everything is running, follow the [Verify Connectivity](self-hosted-deployment.md#verify-connectivity) steps from the base deployment guide.
{% endstep %}
{% endstepper %}
