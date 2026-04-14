# Okta OIDC

## Overview

Okta SSO integration with Akto enables centralized authentication using your existing identity provider. Akto uses OpenID Connect (OIDC) to authenticate users and enforce access control using identity and group attributes.

This integration allows your enterprise teams to manage authentication and authorization through Okta while Akto enforces role-based access during login.

## Configure Okta Account for Akto SSO

You can configure Okta SSO and role mapping in a single flow that connects Okta identity, group claims, and Akto role enforcement.

{% stepper %}
{% step %}
### Create Okta Application for Akto

1. Go to your Okta Admin Console and navigate to **Applications**.\
   Select **Create App Integration**.
2. In **Sign-in Method**, choose **OIDC - OpenID Connect**.\
   In **Application type**, choose **Web Application**.
3. In **App integration name**, enter `Akto`.
4. In **Sign-in redirect URIs**, add:\
   `https://app.akto.io/authorization-code/callback`
5. In **Initiate login URI**, add the following URL if you use login initiated by Okta:\
   `https://app.akto.io/okta-initiate-login?accountId=<your-akto-accountId>`
6. In **Assignments**, select required users or groups.\
   Save the application.
7. Copy **CLIENT\_ID** and **CLIENT\_SECRET** from the application.
{% endstep %}

{% step %}
### **Configure Authorisation Server for Group Claims**

Configure your Okta authorisation server to include a **groups claim** in the access token.

You can use existing Okta groups if your organisation already defines access control groups.\
You may create new groups only when separate access control is required for Akto.

For guidance on creating groups in Okta, refer [here](https://help.okta.com/en-us/content/topics/users-groups-profiles/usgp-groups-create.htm).

Group claims allow Akto to assign roles based on Okta group membership.
{% endstep %}

{% step %}
### Generate Okta API Token

Navigate to:

* **Security → API → Tokens**
* Create a new token
* Provide a name for the token
*   Configure IP restrictions: `Any IP`

    <div data-with-frame="true"><figure><img src="../../.gitbook/assets/Screenshot 2026-03-20 at 6.57.36 PM.png" alt="" width="375"><figcaption></figcaption></figure></div>

{% hint style="info" %}
## **Note**

Entering a valid Okta API token enables automatic group name suggestions in the mapping interface. Akto retrieves available groups from Okta, which helps reduce manual errors while defining mappings.
{% endhint %}

Copy the generated API token.
{% endstep %}
{% endstepper %}

## Setup Okta SSO in Akto Dashboard

Use the following configuration screen in Akto:

{% stepper %}
{% step %}
Navigate to **Integrations → Okta SSO** in the Akto dashboard.
{% endstep %}

{% step %}
You can see the same [#create-okta-application-for-akto](okta-oidc.md#create-okta-application-for-akto "mention") steps here too. Click on the **Next**.
{% endstep %}

{% step %}
Enter the following fields:

* **Client ID**: Okta application client ID
* **Client Secret**: Okta application client secret
* **Authorisation Server ID**: Okta authorisation server identifier
* **Domain Name**: Okta domain (for example: `your-org.okta.com`)
* **API Token**: Okta API token

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (155).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Submit the configuration to enable SSO.
{% endstep %}
{% endstepper %}

## Configure Group-to-Role Mapping in Akto

After SSO configuration, define how Okta groups map to Akto roles.

{% stepper %}
{% step %}
Navigate to **Group mapping & API access** section and select **Edit**.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (156).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
In **Okta group name**, enter the exact group name from Okta.

{% hint style="info" %}
Group name must match the value present in the access token or retrieved through the Okta API.
{% endhint %}
{% endstep %}

{% step %}
In **Akto role**, select the corresponding role such as **Admin**, **Security Engineer**, **Developer**, or **Guest**.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (158).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Select **Add** to create the mapping.

Here, each Okta group maps to one Akto role, and each role can be assigned once.
{% endstep %}

{% step %}
Repeat the process for additional groups as required.
{% endstep %}

{% step %}
Add the **Management API token** in the same section if group claims are not included in the access token.
{% endstep %}

{% step %}
Save the configuration.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (159).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}
{% endstepper %}

{% hint style="warning" %}
## Role Override on Okta SSO Login

When you sign in using Okta SSO, your role in Akto is based on your current Okta group. If your group (and role) has changed in Okta, your role in Akto will automatically update and override your previous role the next time you log in.
{% endhint %}

## Role Assignment During Login

Akto evaluates group membership during user login and assigns roles based on configured mappings.

* Okta groups determine access levels
* Akto roles enforce permissions inside the platform
* API token enables fallback group resolution when required

This setup allows your teams to manage identity and access in Okta while Akto enforces consistent authorisation.
