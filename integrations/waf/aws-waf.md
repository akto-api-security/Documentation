# AWS WAF

The AWS WAF (Web Application Firewall) integration with Akto enables you to bolster your web application security effortlessly. This integration allows you to detect vulnerabilities, monitor web traffic, and implement protection rules to safeguard your digital assets.

<figure><img src="../../.gitbook/assets/image (111).png" alt=""><figcaption></figcaption></figure>

### Prerequisites

* A valid AWS account.
* Access Key ID and Secret Access Key with sufficient IAM permissions to manage AWS WAF.
* Region where your WAF is deployed.
* WAF Rule Set ID and WAF Rule Set Name from your AWS WAF console.

### Steps to Integrate AWS WAF with Akto

1. **Navigate to Settings**
   * Log in to your Akto dashboard.
   * Select `Settings` from the left-hand side menu.
2. **Go to Integrations**
   * Click on `Integrations`.
   * Select `AWS WAF` from the available integrations.
3. **Enter AWS Details**
   * **AWS Access Key ID:** Input your AWS Access Key ID.
   * **AWS Secret Access Key:** Enter your Secret Access Key. Ensure that it has the necessary permissions to manage and monitor your WAF.
4. **Specify Region**
   * Enter the AWS region where your WAF resources are deployed (e.g., us-east-1).
5. **Add WAF Rule Set Info**
   * **WAF Rule Set ID:** Provide the Rule Set ID.
   * **WAF Rule Set Name:** Input the name of the Rule Set as per your AWS WAF configuration.
6. **Select Severity Levels to Block**
   * Choose which levels of issues (Critical, High, Medium, Low) you want to **automatically block using your WAF**.
   * This helps prioritize response and mitigation based on issue severity.
7. **Save the Configuration**
   * After completing all fields, click `Save` to establish the integration.

### Validation

Once you save, Akto will attempt to connect to AWS and validate the credentials and details. Upon successful integration, a confirmation will appear. If there are errors, verify:

* IAM permissions for your Access Key.
* Correctness of Region, Rule Set ID, and Rule Set Name.
* Ensure at least one severity level is selected, if you intend to block threats using AWS WAF rules.

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
