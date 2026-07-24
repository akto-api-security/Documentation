---
description: Connect Akto Atlas to Microsoft Copilot Studio across multiple Power Platform environments
---

# Copilot Studio (Multi Environment)

## Overview

The Copilot Studio Multi Environment connector allows you to connect your entire Power Platform tenant to Akto Atlas once. Akto automatically discovers all Power Platform environments in your tenant and provisions application users in each environment, then ingests Copilot Studio conversation transcripts from all of them simultaneously.

Once connected, Akto Atlas automatically:

* **Discovers all Power Platform environments** in your tenant
* **Auto-provisions application users** in each environment with the required permissions
* **Ingests conversation transcripts** from Copilot Studio agents across all environments
* **Pairs user prompts with bot responses** to reconstruct full conversation flows
* **Sends traffic to Akto** for prompt injection, PII, and policy-violation analysis

## Prerequisites

Before setting up the Multi Environment Copilot Studio connector, ensure the following requirements are met. **Most setup issues are caused by missing prerequisites - please review them carefully.**

### 1. Supported Power Platform Environments

Per the [Microsoft documentation on transcript controls](https://learn.microsoft.com/en-us/microsoft-copilot-studio/admin-transcript-controls), Microsoft does **not** persist Copilot Studio conversation transcripts to Dataverse for the following [environment types](https://learn.microsoft.com/en-us/power-platform/admin/environments-overview):

* Dataverse **developer** environments
* Microsoft Dataverse for Teams environments
* Microsoft 365 Copilot agents

Your agents must be deployed to **Sandbox** or **Production** environments with Dataverse database enabled. Verify environment types in the [Power Platform admin center](https://admin.powerplatform.microsoft.com).

### 2. Transcript Saving Enabled

The Power Platform environment setting **"Allow conversation transcripts and their associated metadata to be saved in Dataverse"** must be turned **on** for each environment. Full details are in the [Microsoft transcript-controls documentation](https://learn.microsoft.com/en-us/microsoft-copilot-studio/admin-transcript-controls#configure-transcript-recording-and-download).

To verify or enable it for each environment:

1. Open the [Power Platform admin center](https://admin.powerplatform.microsoft.com).
2. Go to **Manage** → **Environments** → select each environment → **Settings**.
3. Expand **Product** → **Features** → scroll to **Copilot Studio agents**.
4. Ensure **"Allow conversation transcripts and their associated metadata to be saved in Dataverse"** is enabled, then **Save**.

{% hint style="info" %}
Transcripts take **up to 30 minutes** to appear in Dataverse after a conversation ends. The default Dataverse retention for transcripts is 30 days; this can be extended (see [Change the default retention period](https://learn.microsoft.com/en-us/microsoft-copilot-studio/analytics-transcripts-powerapps#change-the-default-retention-period)).
{% endhint %}

### 3. Copilot Studio License

A paid [Copilot Studio license](https://learn.microsoft.com/en-us/microsoft-copilot-studio/requirements-licensing) must be assigned to the account that owns the agents in each environment. Trial licenses do not always sync conversation transcripts to Dataverse.

### 4. Akto Data Ingestion Service

Your self-hosted Akto **Data Ingestion Service** must be deployed and reachable from the Akto Atlas connector. The connector forwards conversation pairs from all environments to this endpoint.

### 5. Required Permissions

Two distinct sets of permissions are involved in this integration. Note the difference: confusing them is the most common setup mistake.

#### 5a. Permissions for the person running the setup (one-time, tenant level)

The user performing the setup needs to be a **Global Administrator** or **Power Platform Administrator** at the tenant level, because the setup auto-discovers environments and provisions users across all of them.

These permissions are **only** needed at setup time (they are not used by the connector at runtime).

#### 5b. Permissions for the application user (used by Akto at runtime)

Akto automatically provisions the application user in each discovered environment, using the one-time Microsoft interactive login described in [Part 2](#part-2-connect-from-the-akto-dashboard). This application user is created with default **System Administrator** access, since it is auto-provisioned across every environment in the tenant rather than configured manually per environment.

At runtime, the connector only reads two tables using this application user:

| Privilege | Entity | Logical name | Used by |
| --- | --- | --- | --- |
| **Read** (Organization scope) | Bot | `bot` | Agent discovery |
| **Read** (Organization scope) | Conversation Transcript | `conversationtranscript` | Traffic ingestion |

{% hint style="info" %}
If you require least-privilege access instead of System Administrator for the auto-provisioned application user, contact Akto support to discuss a custom role setup.
{% endhint %}

Before connecting in Part 2, you must [create an environment group](https://learn.microsoft.com/en-us/power-platform/admin/environment-groups#create-an-environment-group) in the Power Platform admin center that includes all the environments you want Akto to discover, and assign the application user's permissions at the group level. This step is required: Akto's auto-provisioning relies on the environment group to apply permissions consistently across every environment in the tenant, rather than configuring them one environment at a time.

## Steps to Connect

### Part 1 - Create an App Registration in Microsoft Entra

You only need to complete Part 1 once at the tenant level. This app registration allows Akto to authenticate with Microsoft Copilot Studio across all your Power Platform environments.

#### Register the App

{% stepper %}
{% step %}
Go to [Microsoft Entra](https://entra.microsoft.com) > **App registrations** > **New registration**.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/1. App Registration.png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Give the app a name (e.g. `akto-copilot-studio-multi-env-connector`) and set supported account types to **Single tenant**.
{% endstep %}

{% step %}
Configure the Redirect URI

*   Select platform as **Web** and add the following as the URI:

    <pre data-overflow="wrap"><code>https://app.akto.io/copilot/oauth/callback
    </code></pre>
* Click **Register**.

{% hint style="info" %}
You will be prompted to log in once with your Microsoft account when you [connect from the Akto dashboard](#part-2-connect-from-the-akto-dashboard) in Part 2.
{% endhint %}
{% endstep %}

{% step %}
Note down:

* **Application (Client) ID**
* **Directory (Tenant) ID**

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/2. App Registration IDs.png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}
{% endstepper %}

#### Create a Client Secret

{% stepper %}
{% step %}
Go to **Certificates & secrets** > **New client secret**.
{% endstep %}

{% step %}
Set an expiry and click **Add**.
{% endstep %}

{% step %}
**Copy the secret value immediately**: it is not shown again.
{% endstep %}
{% endstepper %}

#### Add API Permissions

{% stepper %}
{% step %}
Go to **API Permissions** > **Add a permission**.
{% endstep %}

{% step %}
Select the **APIs my organization uses** tab. Search for **PowerApps Service** and add the following **delegated permission**:

* `User`
{% endstep %}
{% endstepper %}

### Part 2 - Connect from the Akto Dashboard

{% hint style="info" %}
**Why does Akto ask for a Microsoft interactive login?**

When you enter your details in the Akto dashboard, you'll be asked to log in to your Microsoft account **once per tenant**. This one-time login:

* Registers the app you created in Part 1 with the Power Platform admin center
* Lets Akto automate the creation of application users in each environment, so you don't have to create them manually
* Creates each application user with default access (**System Administrator**)
* Is used by Akto to fetch conversation transcripts and agent information via these application users
{% endhint %}

{% stepper %}
{% step %}
**Open the Copilot Studio (Multi Environment) Connector in Akto Atlas**

1. Navigate to **Akto Atlas** in your Akto dashboard.
2. Open **Connectors**.
3. Under **Platform Connector**, locate the **Copilot Studio (Multi Environment)** connector card.
4. Select **Connect** to open the setup dialog.
{% endstep %}

{% step %}
**Enter the Azure AD Tenant ID**

Paste the **Directory (tenant) ID** you noted down in Part 1 into the **Azure AD Tenant ID** field.

* Format: `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`

{% hint style="info" %}
The multi-environment connector will use this tenant ID to auto-discover and connect to all Power Platform environments in your organization.
{% endhint %}
{% endstep %}

{% step %}
**Enter the Azure AD App Client ID**

Paste the **Application (client) ID** you noted down in Part 1 into the **Azure AD App Client ID** field.

* Format: `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`
{% endstep %}

{% step %}
**Enter the Azure AD App Client Secret**

Paste the client secret value you saved in Part 1 into the **Azure AD App Client Secret** field.

{% hint style="info" %}
If you did not save the value when it was created, return to the Azure portal, generate a new secret in your app registration, and use the new value.
{% endhint %}
{% endstep %}

{% step %}
**Enter the Data Ingestion Service URL**

In the **URL for Data Ingestion Service** field, enter the base URL of your self-hosted Akto Data Ingestion Service.

* Format: `https://ingestion.your-domain.com`

{% hint style="warning" %}
* The ingestion service must be deployed and reachable from the connector.
* The endpoint receives conversation pairs from all discovered environments.
{% endhint %}
{% endstep %}

{% step %}
**Complete Microsoft Sign-In**

After entering your credentials, you will be taken to the Microsoft login page. Complete the sign-in with an account that has permission to register the app in the Power Platform admin center.

{% hint style="info" %}
This sign-in is required only once per tenant. See [Why does Akto ask for a Microsoft interactive login?](#part-2-connect-from-the-akto-dashboard) above for details.
{% endhint %}
{% endstep %}

{% step %}
**Review Discovered Environments**

After completing the sign-in, Akto will automatically discover all Power Platform environments in your tenant. A **Review discovered environments** section will appear showing:

* **Environment name** (e.g. "Production", "Default")
* **Environment URL** (e.g., `https://org12345.crm.dynamics.com/`)

Review the list to confirm all environments are present. Akto will provision an application user in each environment to read Copilot Studio transcripts.

{% hint style="info" %}
If you don't see an expected environment, verify that:
* It is a **Sandbox** or **Production** environment (not Developer or Teams)
* Transcript saving is enabled in that environment
* You have the appropriate permissions to access it
{% endhint %}
{% endstep %}

{% step %}
**Confirm & Connect**

1. Review all entered values and the discovered environments list.
2. Select **Confirm & Connect** to finalize the integration.

Akto will now:
* Provision application users in each discovered environment
* Start polling Copilot Studio transcripts from all environments every 30 minutes
* Begin importing conversation data to your Akto dashboard

Conversations should begin appearing in your Akto dashboard within one or two polling cycles, provided transcripts exist in Dataverse for the polling window.
{% endstep %}
{% endstepper %}

## Troubleshooting

For common issues and solutions, refer to the [single environment documentation](microsoft-copilot-studio.md#troubleshooting). The troubleshooting guide covers most issues that also apply to the multi-environment setup.

## Get Support

If you need assistance with the Multi Environment Copilot Studio connector:

* **In-app Chat** Use the chat widget in your Akto dashboard for instant support.
* **Email Support** Contact us at [support@akto.io](mailto:support@akto.io).
