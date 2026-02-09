# ServiceNow

Integrate Akto with ServiceNow to streamline your API security workflow by creating tickets for vulnerabilities directly from Akto into your ServiceNow instance.

## Quick Setup Steps

The ServiceNow integration uses OAuth 2.0 Client Credentials flow for secure authentication. Follow these steps to set up the integration:

### **1. Configure OAuth in ServiceNow**

{% stepper %}
{% step %}
**Enable Client Credentials Grant Type**

Before creating the OAuth integration, ensure the client credentials grant type is enabled:

1.  In your ServiceNow instance, in the filter navigator, search for `sys_properties.do`

    <figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2Fgit-blob-101f5d44c73f224773847538b2b889508b31c0f4%2Fservicenow_sys_prop_search.png?alt=media" alt=""><figcaption></figcaption></figure>
2. Click **New** to create a new system property (or search for existing property)
3. Fill in the following fields:
   * **Name:** `glide.oauth.inbound.client.credential.grant_type.enabled`
   * **Value:** `true`
   * **Type:** `true | false`
4.  Click **Save**

    <figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2Fgit-blob-2a51bb0771f7ca65ca98021531159523aaf330a7%2Fservicenow_sys_prop_save.png?alt=media" alt=""><figcaption></figcaption></figure>
5. This property must be enabled for the OAuth integration to work
{% endstep %}

{% step %}
**Create OAuth Integration**

1.  In your ServiceNow instance, navigate to **System OAuth** > **Inbound Integrations**

    <figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2Fgit-blob-c96015e5d7eeddaca30f9907a7b15d263c21e658%2Fsn_oauth_search.png?alt=media" alt=""><figcaption></figcaption></figure>
2. Click **New integration** to create a new integration
3. Choose **OAuth - Client credentials grant type**
4. Fill in the following details:
   * **Name:** Enter a descriptive name (e.g., "Akto API Security Integration")
   * **User:** Select a user account that has all required roles to create and manage tickets
     * Ensure this user has permissions to access and create records in the tables you want to integrate
   * **Active:** Make sure the **Active** checkbox is **enabled**
5.  Click **Submit** to create the integration

    <figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2Fgit-blob-fccfa79ba423ef8f85e9140879b653f2f47a69fa%2Fsn_oauth_data_sample.png?alt=media" alt=""><figcaption></figcaption></figure>
{% endstep %}

{% step %}
**Save Credentials**

After creating the integration:

1. ServiceNow will display your **Client ID** and **Client Secret**
2. **Important:** Copy and save these credentials securely
   * Client ID
   * Client Secret
3. You will need these credentials to configure the integration in Akto
{% endstep %}
{% endstepper %}

### **2. Configure ServiceNow Integration in Akto**

{% stepper %}
{% step %}
**Access Integrations**

* Go to **Settings > Integrations** in Akto
*   Find and click **"Configure"** next to ServiceNow

    <figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2Fgit-blob-c2be568e51851c399baf14239f7d040adb658d88%2Fakto_sn_integration_page.png?alt=media" alt=""><figcaption></figcaption></figure>
{% endstep %}

{% step %}
**Enter ServiceNow Details**

* **ServiceNow Instance URL:** Your ServiceNow instance URL (e.g., `https://yourcompany.service-now.com`)
* **Client ID:** Paste the Client ID from the OAuth integration you created in ServiceNow
* **Client Secret:** Paste the Client Secret from the OAuth integration
{% endstep %}

{% step %}
**Fetch and Select Tables**

* After entering the credentials, click **Fetch Tables**
* Akto will retrieve all available tables from your ServiceNow instance
* Select the tables where you want to create tickets for API vulnerabilities
  * Common choices include: `incident`, `problem`, `change_request`, or custom tables
  * You can select multiple tables based on your workflow requirements
{% endstep %}
{% endstepper %}

### **3. Save**

*   Click **"Save"** to finalize the integration

    <figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2Fgit-blob-71bbf326bee72a3e0749060d0a0af2a60ebf5efe%2Fakto_sn_integration_sample_data.png?alt=media" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
### Important Notes

* **OAuth Setup:** This integration uses the **New Inbound Integration Experience** in ServiceNow, which is the recommended approach (not the deprecated OAuth API endpoint)
* **User Permissions:** Ensure the ServiceNow user assigned to the OAuth integration has appropriate permissions to:
  * Create records in the selected tables
  * Read table schemas and metadata
  * Access necessary ServiceNow APIs
{% endhint %}

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
