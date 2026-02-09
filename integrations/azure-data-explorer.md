# Azure Data Explorer

## Overview

The Azure Data Explorer integration allows you to export Akto Agentic security activity data into an Azure Data Explorer (ADX) database. With the integration you can have centralised analytics, long-term storage, and correlation with other operational data already present in ADX.

## Prerequisites

### Azure Data Explorer Cluster and Database Details

You need an existing Azure Data Explorer cluster and database and should have the **cluster endpoint** and the **database name** for the cluster being integrated.

{% hint style="warning" %}
If an Azure Data Explorer cluster does not exist, you can create one in the Azure portal before continuing.
{% endhint %}

### Azure App Registration

Akto uses an Azure App Registration for authentication with Azure Data Explorer.

**Create a New App Registration**

{% stepper %}
{% step %}
Open **App registrations** in the Azure portal.

<figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2FekwaDelj74cBXmn6dOfN%2Fimage.png?alt=media&#x26;token=ddb3fa1b-d000-4e24-ac5b-d4ee52762482" alt="" width="563"><figcaption></figcaption></figure>
{% endstep %}

{% step %}
Select **New registration** from the left navigation panel.
{% endstep %}

{% step %}
Enter a name for the application and set **Supported account types** to **Accounts in this organisational directory only (Single tenant)**.

<figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2FGN4GLpZKk4Fjp96qICrx%2Fimage.png?alt=media&#x26;token=68a5c030-640d-4485-bafe-9da8bc7c92bb" alt="" width="563"><figcaption></figcaption></figure>
{% endstep %}

{% step %}
Select **Register** to create the application.
{% endstep %}
{% endstepper %}

### **Generate Client Secret**

{% stepper %}
{% step %}
Open the newly created App Registration.
{% endstep %}

{% step %}
Navigate to **Certificates & secrets**.
{% endstep %}

{% step %}
Create a new **Client secret**.
{% endstep %}

{% step %}
Copy the **Client secret value** after creation.

<figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2FAuqqwSzF3N3yt77zThgL%2Fimage.png?alt=media&#x26;token=0c96edde-6d3b-4b7d-8f60-28138300a725" alt="" width="563"><figcaption></figcaption></figure>
{% endstep %}

{% step %}
Navigate back to the application overview page.
{% endstep %}

{% step %}
Copy the following identifiers:

* **Application (Client) ID**
*   **Directory (Tenant) ID**

    <figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2F0HxyT20n4tcMVGAlrL0o%2FScreenshot%202026-01-13%20at%207.17.41%E2%80%AFPM.png?alt=media&#x26;token=4b1635a4-a64e-4e92-a531-8629d144b187" alt="" width="563"><figcaption></figcaption></figure>
{% endstep %}
{% endstepper %}

{% hint style="warning" %}
#### Azure Data Explorer Access Permissions

The App Registration requires access to the Azure Data Explorer cluster being integrated.\
You should ensure that the registered application has permissions to write data into the target ADX database.
{% endhint %}

## Steps to Integrate ADX in Akto

{% stepper %}
{% step %}
**Open Integration Settings**

1. Log in to the Akto dashboard.
2.  Navigate to **Settings → Integrations → Azure Data Explorer**.

    <figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2FKd3OYH14jWeZNwyd4YAy%2Fimage.png?alt=media&#x26;token=336e783b-243c-4cd9-b033-42b9c1561a0d" alt="" width="563"><figcaption></figcaption></figure>
3. The Azure Data Explorer configuration form is displayed.
{% endstep %}

{% step %}
**Configure the Integration**

Enter the following values in the configuration form:

* **Cluster Endpoint**
* **Database Name**
* **Tenant ID**
* **Application ID**
*   **Application Key (Client Secret)**

    <figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2FcZprU4AOIMFRCfFi0gId%2Fimage.png?alt=media&#x26;token=2e23d9a9-9aa3-401c-9341-7bb6fff832f3" alt="" width="563"><figcaption></figcaption></figure>

Each value should match the Azure App Registration and Azure Data Explorer cluster configuration.
{% endstep %}

{% step %}
**Save the Configuration**

Select **Save** to complete the integration.
{% endstep %}
{% endstepper %}

Akto validates the credentials and establishes connectivity with Azure Data Explorer.

## Exporting Data to Azure Data Explorer

{% stepper %}
{% step %}
Open the **Akto** **Atlas** or **Argus** dashboard.
{% endstep %}

{% step %}
Navigate to **Guardrails → Guardrail Activity**.
{% endstep %}

{% step %}
Open the **More actions** menu in the top-right corner.
{% endstep %}

{% step %}
Select **Export to ADX (Azure Data Explorer)**.

<figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2FooJdxLvsvSeZsMqd7i0o%2Fimage.png?alt=media&#x26;token=779555bd-7c72-4ed5-869f-5756dbe62b19" alt="" width="563"><figcaption></figcaption></figure>
{% endstep %}
{% endstepper %}

Akto exports the selected guardrail activity data to the configured Azure Data Explorer database.

## How Data Looks in ADX Cluster

After the export completes, the guardrail activity data appears as structured records in the Azure Data Explorer database.

<figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2FtdZhdbfYw6OawHDRmFQn%2Fimage.png?alt=media&#x26;token=dcb587df-d653-403b-b280-e1090f888342" alt="" width="563"><figcaption></figcaption></figure>

You can query the exported data using KQL to support investigation, monitoring, and reporting workflows within Azure Data Explorer.
