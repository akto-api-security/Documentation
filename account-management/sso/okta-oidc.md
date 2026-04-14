# Okta OIDC

## Overview

The Okta SSO integration with Akto provides a centralised way to authenticate users through your existing identity provider. Akto leverages OpenID Connect (OIDC) to verify user identities and apply access controls based on identity attributes and group memberships.

With this integration, authentication and authorisation can be managed directly in Okta, while Akto handles role-based access enforcement during user login.

## Configure Okta Account for Akto SSO

You can set up Okta SSO along with role mapping in a unified flow that links Okta identities, group claims, and Akto’s role enforcement.

{% stepper %}
{% step %}
### Create Okta Application for Akto

1. Open your Okta Admin Console and go to **Applications**.\
   Click on **Create App Integration**.
2. Under **Sign-in Method**, select **OIDC - OpenID Connect**.\
   Choose **Web Application** as the application type.
3. Provide the name `Akto` in **App integration name**.
4. Add the following under **Sign-in redirect URIs**:\
   `https://app.akto.io/authorization-code/callback`
5. If using Okta-initiated login, include this under **Initiate login URI**:\
   `https://app.akto.io/okta-initiate-login?accountId=<your-akto-accountId>`&#x20;
6. Assign the application to the necessary users or groups.\
   Save the configuration.
7. Copy the **CLIENT\_ID** and **CLIENT\_SECRET** from the created application.

{% hint style="info" %}
Replace `your-akto-accountId` in step 5 with your actual account ID, which you can find in [Akto settings](https://app.akto.io/dashboard/settings/about).
{% endhint %}
{% endstep %}

{% step %}
### **Configure Authorisation Server for Group Claims**

Update your Okta authorisation server to include a **groups claim** in the access token.

If your organisation already uses Okta groups for access control, you can reuse them.\
Create new groups only if you need separate access definitions for Akto.

Refer to [Okta documentation](https://help.okta.com/en-us/content/topics/users-groups-profiles/usgp-groups-create.htm) for guidance on group creation.

Group claims enable Akto to determine user roles based on their group memberships.
{% endstep %}

{% step %}
### Generate Okta API Token

Navigate to:

* **Security → API → Tokens**
* Generate a new token
* Assign a name to the token
*   Set IP restrictions to: `Any IP`&#x20;

    <div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (196).png" alt="" width="375"><figcaption></figcaption></figure></div>

{% hint style="info" %}
### **Note**

Providing a valid Okta API token allows Akto to automatically fetch available group names. This simplifies the mapping process and minimizes manual configuration errors.
{% endhint %}

Copy and store the generated API token.
{% endstep %}
{% endstepper %}

{% hint style="success" %}
## API Access Management in Okta

It is recommended to have the **API Access Management** feature enabled in Okta. Without this feature, users cannot customise the access policies of authorisation server IDs.&#x20;

By default, Okta provides only a single **default authorisation server**, which cannot be modified. Enabling API Access Management allows organisations to create and configure custom authorisation servers, giving them more control over access policies and security.
{% endhint %}

## Setup Okta SSO in Akto Dashboard

Follow these steps within the Akto dashboard:

{% stepper %}
{% step %}
Go to **Integrations → Okta SSO** in the Akto dashboard.
{% endstep %}

{% step %}
You will see the same [#setup-okta-sso-in-akto-dashboard](okta-oidc.md#setup-okta-sso-in-akto-dashboard "mention") steps here as well. Click **Next** to continue.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image(1).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Provide the following details:

* **Client ID**: Client ID from the Okta application
* **Client Secret**: Client secret from the Okta application
* **Authorisation Server ID**: Identifier of the Okta authorisation server
* **Domain Name**: Your Okta domain (e.g., `your-org.okta.com`)
*   **API Token**: Generated Okta API token

    <div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (197).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Submit the configuration to activate SSO.
{% endstep %}
{% endstepper %}

## Configure Group-to-Role Mapping in Akto

Once SSO is enabled, define how Okta groups correspond to Akto roles.

{% stepper %}
{% step %}
Navigate to **Group mapping & API access** and click **Edit**.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (198).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Enter the exact Okta group name in **Okta group name**.

{% hint style="info" %}
The group name must exactly match the value present in the access token or returned via the Okta API.
{% endhint %}
{% endstep %}

{% step %}
Select the appropriate role in **Akto role**, such as **Admin**, **Security Engineer**, **Developer**, or **Guest**.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (199).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Click **Add** to create the mapping.

Each Okta group can be linked to only one Akto role, and each role can be assigned once.
{% endstep %}

{% step %}
Repeat the steps for any additional group mappings.
{% endstep %}

{% step %}
If group claims are missing from the access token, provide the **Management API token** in the same section.
{% endstep %}

{% step %}
Save your changes.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (200).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}
{% endstepper %}

{% hint style="warning" %}
## Role Override on Okta SSO Login

When you sign in using Okta SSO, your role in Akto is based on your current Okta group. If your group (and role) has changed in Okta, your role in Akto will automatically update and override your previous role the next time you log in.
{% endhint %}

## Role Assignment During Login

During user authentication, Akto evaluates group memberships and assigns roles based on the configured mappings.

* Okta groups define access levels
* Akto roles control permissions within the platform
* The API token supports fallback group retrieval when needed

This setup enables centralized identity management in Okta while ensuring consistent authorisation enforcement within Akto.
