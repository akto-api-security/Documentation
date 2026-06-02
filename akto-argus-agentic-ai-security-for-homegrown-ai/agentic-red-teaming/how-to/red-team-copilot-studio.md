# Red Team Copilot Studio AI Agents

## Overview

This guide walks you through setting up automated red teaming for AI Agents built on Microsoft Copilot Studio using Akto. A Power Automate flow acts as the HTTP bridge between Akto and your Copilot Studio agent — Akto sends adversarial prompts to the flow, the flow forwards them to your agent, and the responses come back for analysis.

## Prerequisites

* A **published** AI Agent in Copilot Studio (draft agents won't work)
* A Microsoft account with:
  * Permission to create App Registrations and add API permissions in Microsoft Entra
  * Permission to create flows in Power Automate
* **Power Automate Premium** license (per-user or per-flow) — the HTTP trigger and Copilot Studio connector are both premium features

## 1. Create an App Re gistration in Microsoft Entra

This app registration lets you obtain an access token to call the Power Automate flow programmatically.

### Register the App

{% stepper %}
{% step %}
Go to [Microsoft Entra](https://entra.microsoft.com) > **App registrations** > **New registration**.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/1. App Registration.png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Give the app a name and set supported account types to **Single tenant**.
{% endstep %}

{% step %}
Configure Redirect URI.

(For Microsoft Copilot Studio) Select platform as **Web** and add [https://app.akto.io/copilot/oauth/callback](https://app.akto.io/copilot/oauth/callback) as URI.

Click **Register**.
{% endstep %}

{% step %}
{% hint style="info" %}
You will be prompted to log in once with your Microsoft account. Once you do, Akto will obtain a refresh token that stays valid for **90 days**.
{% endhint %}
{% endstep %}

{% step %}
Note down:

* **Application (Client) ID**
* **Directory (Tenant) ID**

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/2. App Registration IDs.png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}
{% endstepper %}

### Create a Client Secret

{% stepper %}
{% step %}
Go to **Certificates & secrets** > **New client secret**.
{% endstep %}

{% step %}
Set an expiry and click **Add**.
{% endstep %}

{% step %}
**Copy the secret value immediately** — it is not shown again.
{% endstep %}
{% endstepper %}

### Add API Permissions

{% stepper %}
{% step %}
Go to **API Permissions** > **Add a permission**.
{% endstep %}

{% step %}
Select the **APIs my organization uses** tab. Search for **Power Platform API** and add the following **delegated permission**:

* `CopilotStudio.Copilots.Invoke`
{% endstep %}

{% step %}
(Optional) Click **Add a permission** again. Search for **Power Automate** (also listed as "Microsoft Flow Service") and add the following delegated permission:

* `User`
{% endstep %}

{% step %}
(Optional) Click **Grant admin consent**.

{% hint style="info" %}
Granting admin consent requires the **Application Administrator** or **Global Administrator** role in Microsoft Entra. If you don't have this access, you can skip this step — users will be prompted to consent individually when they authenticate.
{% endhint %}
{% endstep %}
{% endstepper %}

## 2. Create a Scan Role in Akto

A scan role tells Akto which credentials to use when sending adversarial prompts to your Copilot Studio agent. For a full walkthrough of scan role configuration, refer to the [Create a Test Role](https://docs.akto.io/api-security-testing/how-to/create-a-test-role) guide.

{% stepper %}
{% step %}
Go to **AI Red Teaming** > **Scan Roles** and click **Create New Test Role**.
{% endstep %}

{% step %}
Under **Details**, enter a name for the scan role (e.g. `agent-red-teaming`).
{% endstep %}

{% step %}
Under **Role endpoint conditions**, set:

* **Endpoint** | **contains** | `/`&#x20;

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (174).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Scroll down to **Authentication details** > **Token details** and select **Copilot Studio (Microsoft OAuth)**.
{% endstep %}

{% step %}
Fill in the credentials from Step 1:

* **Tenant ID**: your Directory (Tenant) ID
* **Client ID**: your Application (Client) ID
*   **Client Secret**: the secret value you copied

    <div data-with-frame="true"><figure><img src="../../../.gitbook/assets/Screenshot 2026-06-02 at 3.45.50 PM.png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Click **Save & Connect with Microsoft** and complete the login prompt.

{% hint style="info" %}
You will be prompted to log in once with your Microsoft account. Once you do, Akto will obtain a refresh token that stays valid for **90 days**.
{% endhint %}
{% endstep %}
{% endstepper %}

## 3. Run a Red Teaming Scan

{% stepper %}
{% step %}
Navigate to **AI Agent Discovery** and open the collection that contains your imported Copilot Studio agent.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/Screenshot 2026-06-02 at 5.34.52 PM.png" alt="" width="563"><figcaption></figcaption></figure></div>

Verify that `bot-environment-id` and `bot-schemaname` are present in the collection tags. If not, expand the section below.

<details>

<summary>How to get and add bot-environment-id and bot-schemaname</summary>

These tags are required for Akto to correctly target your Copilot Studio agent during red teaming.

**Get the values from Copilot Studio**

1. Log in to [https://copilotstudio.microsoft.com](https://copilotstudio.microsoft.com).
2. Go to the **Agents** page and select your agent.
3. Click **Settings** > **Advanced** > **Metadata**.
4.  Copy the **Environment ID** and **Schema name** values.

    <div data-with-frame="true"><figure><img src="../../../.gitbook/assets/Screenshot 2026-06-02 at 3.50.24 PM.png" alt="" width="563"><figcaption></figcaption></figure></div>

**Add them to the agent collection in Akto**

Once you have the values, add them as tags on the agent collection. Refer to [Create New Tags](../../agentic-ai-discovery/how-to/create-new-tags.md) for step-by-step instructions.

Add the following tags:

* `bot-environment-id=<your-environment-id>`
* `bot-schemaname=<your-schema-name>`

</details>
{% endstep %}

{% step %}
Select the agent endpoint you want to red team.
{% endstep %}

{% step %}
Click **Run Scan** to open the scan configuration panel.
{% endstep %}

{% step %}
Choose the red teaming tests you want to execute against the agent.
{% endstep %}

{% step %}
In the **Roles** section, select the scan role you **created in Step 2**.
{% endstep %}

{% step %}
Click **Run Scan** to start.
{% endstep %}
{% endstepper %}

## Get Support

If you need assistance with the Copilot Studio connector:

* **In-app Chat** — Use the chat widget in your Akto dashboard for instant support.
* **Discord Community** — Join our community at [discord.gg/Wpc6xVME4s](https://discord.gg/Wpc6xVME4s).
* **Email Support** — Contact us at [support@akto.io](mailto:support@akto.io).
* **Contact Form** — Submit a support request at [https://www.akto.io/contact-us](https://www.akto.io/contact-us).
