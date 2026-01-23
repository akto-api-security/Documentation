# Cloudflare WAF

The Cloudflare WAF (Web Application Firewall) integration with Akto allows you to seamlessly enhance your web application security. This integration empowers you to efficiently detect vulnerabilities, analyze and intercept web traffic, and fortify your digital defenses.

<figure><img src="../../.gitbook/assets/image (112).png" alt=""><figcaption></figcaption></figure>

### Prerequisites

* A valid Cloudflare account.
* API Key from Cloudflare with appropriate permissions.
* Account ID from your Cloudflare dashboard.

### Steps to Integrate Cloudflare WAF with Akto

1. **Navigate to Settings**
   * Go to your Akto dashboard.
   * Select `Settings` from the left-side menu.
2. **Go to Integrations**
   * Click on the `Integrations` option.
   * Choose `Cloudflare WAF` from the available integrations.
3. **Enter Cloudflare Details**
   * **Cloudflare Email:** Enter the email address associated with your Cloudflare account.
   * **Cloudflare API Key:** Provide your Cloudflare API key. Ensure it has permissions to manage WAF settings and read traffic data.
4. **Select Integration Type**
   * Use the dropdown to choose your integration type. The available option is `accounts`.
5. **Enter Account ID**
   * Input your Cloudflare Account ID. You can find this in your Cloudflare dashboard under the account settings.
6. **Select Severity Levels to Block**
   * Choose which levels of issues (**Critical**, **High**, **Medium**, **Low**) you want to automatically block using your Cloudflare WAF.
   * This helps prioritize response and mitigation based on issue severity.
7. **Save the Configuration**
   * Once all fields are filled, click the `Save` button to complete the integration.

### Validation

After saving, Akto will validate the provided credentials and establish the integration. If successful, you will see a confirmation message. In case of errors, please verify:

* The correctness of your API key and email.
* That your API key has the necessary permissions.
* Ensure at least one severity level is selected, if you intend to block threats using Cloudflare WAF rules.

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
