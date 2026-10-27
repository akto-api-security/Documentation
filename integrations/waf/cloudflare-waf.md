# Cloudflare WAF

The Cloudflare WAF (Web Application Firewall) integration with Akto allows you to seamlessly enhance your web application security. This integration empowers you to efficiently detect vulnerabilities, analyze and intercept web traffic, and fortify your digital defenses.

<figure><img src="../../.gitbook/assets/image (112).png" alt=""><figcaption></figcaption></figure>

### Prerequisites

* A Cloudflare account with the zone (domain) you want to protect.
* Your Cloudflare **Account ID** and **Zone ID**. Both are shown on the zone's **Overview** page in the Cloudflare dashboard, in the **API** section on the right.
* A Cloudflare **API Token** with the permissions listed below (recommended), or your **Global API Key**.

### How Akto uses your Cloudflare account

Akto blocks malicious IPs in two parts:

1. **An IP list.** Akto creates an account-level IP list named `akto_blocked_ips_<akto_account_id>` and adds or removes IPs in it when threats are blocked or unblocked. If the list fills up, Akto creates more lists with a numeric suffix (`_1`, `_2`, …).
2. **A WAF custom rule.** Akto adds a rule called `Akto - Block malicious IPs` with the expression `(ip.src in $akto_blocked_ips_<akto_account_id>)` and the action `Block`.
   * **Zone level** (all Cloudflare plans): the rule is added to the zone's custom rules (`http_request_firewall_custom` phase).
   * **Account level** (Enterprise only): Akto creates a custom ruleset named `Akto IP Block Rules` and deploys it from the account's custom rules entrypoint.

IP lists are always account-level resources in Cloudflare, so the token needs account permissions even if you choose **Zone** as the rule level.

### Create a Cloudflare API Token

1. In the Cloudflare dashboard, go to **My Profile → API Tokens** and click **Create Token**.
2. Choose **Create Custom Token**.
3. Add these permissions:

| Rule level | Scope | Permission | Access |
| --- | --- | --- | --- |
| Zone and Account | Account | Account Filter Lists | Edit |
| Zone | Zone | Zone WAF | Edit |
| Account (Enterprise) | Account | Account WAF | Edit |

4. Under **Account Resources**, choose **Include** and select the account whose Account ID you will enter in Akto.
5. Under **Zone Resources** (zone level only), choose **Include** and select the zone, or **All zones from an account** for that account.
6. Click **Continue to summary**, then **Create Token**, and copy the token. It is shown only once.

{% hint style="info" %}
Cloudflare API Tokens usually start with `cfut_`. When you use an API Token, leave the **Cloudflare email** field in Akto **empty**. If an email is filled in, Akto sends the key as a Global API Key, and Cloudflare rejects the token with `Authentication failed (status: 400)`.
{% endhint %}

{% hint style="warning" %}
If you use the **Global API Key** instead, enter it together with the email address of your Cloudflare login. The Global API Key has full access to your Cloudflare account, so a scoped API Token is recommended.
{% endhint %}

### Steps to Integrate Cloudflare WAF with Akto

1. **Navigate to Settings**
   * Go to your Akto dashboard.
   * Select `Settings` from the left-side menu.
2. **Go to Integrations**
   * Click on the `Integrations` option.
   * Choose `Cloudflare WAF` from the available integrations.
3. **Enter Cloudflare Credentials**
   * **Cloudflare email:** Leave this empty when using an API Token. Enter your Cloudflare login email only when using the Global API Key.
   * **Cloudflare API Key / API Token:** Paste the API Token you created (or your Global API Key).
4. **Select WAF Rule Level**
   * **Zone (Cloudflare - All Plans):** Adds the block rule to a single zone. Use this unless you are on an Enterprise plan and want the rule applied across the account.
   * **Account (Cloudflare - Enterprise Only):** Deploys the block rule across all zones in the account.
5. **Enter Account ID and Zone ID**
   * **Cloudflare Account ID:** Always required, because the IP list is created at the account level.
   * **Cloudflare Zone ID:** Required when the rule level is **Zone**. This is the zone where the block rule will be added.
6. **Select Auto Block Threat Policies**
   * Choose the threat policies whose detected actors should be blocked automatically through Cloudflare WAF.
7. **Save the Configuration**
   * Click `Save`. Akto validates the credentials, creates the IP list and the WAF rule, and saves the integration.

### Validation

After saving, you should see a success message in Akto. In Cloudflare you can confirm the setup:

* **Manage Account → Configurations → Lists** shows the `akto_blocked_ips_<akto_account_id>` IP list.
* For zone level, **your zone → Security → WAF → Custom rules** shows the `Akto - Block malicious IPs` rule.

### Troubleshooting

| Error in Akto | Cause | Fix |
| --- | --- | --- |
| `Authentication failed (status: 400)` | An API Token was entered together with an email, so it was sent as a Global API Key. | Clear the **Cloudflare email** field and save again. |
| `Authentication error` | The token cannot read the account's IP lists. It is missing **Account Filter Lists: Edit**, or the account is not included in **Account Resources**. | Edit the token's permissions and account resources as described above. The token value does not change, so save the integration again. |
| `Unknown X-Auth-Key or X-Auth-Email` | The Global API Key or email is wrong. | Check the key and use the email of the Cloudflare login that owns the key. |
| Save fails after validation succeeds | The token can read lists but cannot create the list or WAF rule. | Make sure the permissions are **Edit**, not **Read**, and that **Zone WAF: Edit** (zone level) or **Account WAF: Edit** (account level) is included. |
| `Please provide a valid Zone ID.` | Rule level is **Zone** but no Zone ID was entered. | Copy the Zone ID from the zone's **Overview** page. |

{% hint style="info" %}
To change the API Token of an existing integration, click `Delete` on the Cloudflare WAF integration page and add it again with the new token.
{% endhint %}

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
