# AWS deploy

### 60 seconds deploy in AWS 🚀

{% tabs %}
{% tab title="Akto Setup" %}
![Deployment Architecture](<../../../.gitbook/assets/scale (1)-Page-4.drawio (1).png>)
{% endtab %}
{% endtabs %}

### Deployment Options

Before proceeding with the deployment steps, consider the following options to choose the most suitable deployment method for your environment:

1. **Standard AWS Deployment**: If you have a single VPC and are not using Kubernetes, continue with the steps below.
2. **Kubernetes Users**: If you're using Kubernetes, consider deploying using Helm. Learn more about [Helm deployment](../helm-deploy.md).
3. **Multiple VPCs**:
   * For multi-VPC deployment, refer to our [AWS multi-VPC deploy guide](aws-multi-vpc-deploy.md).
   * For cross-region, cross-VPC deployment, check out our [AWS Cross-Region Cross-VPC deploy guide](aws-cross-region-vpc-deploy.md).
4. **Custom Subdomain**: For custom subdomain setup on AWS, see our [Custom subdomain on Akto on AWS guide](../aws-ssl.md).

Choose the option that best fits your infrastructure needs. If you're proceeding with the standard AWS deployment, continue with the steps below.

### Prerequisites

* An active AWS account
* Necessary permissions to create and manage CloudFormation stacks

### Step 1: Fetch the AWS CFT

1. Sign up on [Akto](https://app.akto.io) and download the [AWS CFT](https://github.com/akto-api-security/infra/blob/feature/quick-setup/templates/akto-quick-setup.yaml).

### Step 2: Create stack in AWS

1. Sign into your `AWS account` if you are not logged-in. Go to `Cloudformation` and upload the template we just downloaded, then click next.

![](<../../../.gitbook/assets/Screen Shot 2023-01-03 at 3.38 2.png>)

2\. This will take you to a pre-filled `quick create stack` like below.

<figure><img src="../../../.gitbook/assets/Screen Shot 2023-01-03 at 3.52 3.png" alt=""><figcaption></figcaption></figure>

3\. Add your parameters here - `keypair`, `1 private subnetId` and `2 public subnetIds`. Atleast 1 public subnet should be in the same availability zone as private subnet.

<figure><img src="../../../.gitbook/assets/Frame 7 (1).png" alt=""><figcaption></figcaption></figure>

4\. Your user email parameter should be the same as the one you used to signup with Akto.

5\. Select `I acknowledge that AWS CloudFormation might create IAM resources.`

<figure><img src="../../../.gitbook/assets/Frame 8 (1).png" alt=""><figcaption></figcaption></figure>

6\. Click on `create stack`.

### Step 3: Launch Akto dashboard

1. `Wait` for a couple of minutes before you stack creation is complete.
2. Once your stack is created, `navigate to outputs` sections and `copy Akto dashboard url` into your browser.

<figure><img src="../../../.gitbook/assets/Frame 4 (4).png" alt=""><figcaption></figcaption></figure>

3\. `Signup` and start using Akto.

### Post-Deployment

After successful deployment, free plan users will be able to see up to 25 APIs. To access more APIs and additional features, consider upgrading to a paid plan. [View our pricing options](https://www.akto.io/pricing).

Need help? [Contact](mailto:support@akto.io) our support team for assistance.

### Optional -

1. [Add custom subdomain and SSL certificate to your akto deployment on AWS](../aws-ssl.md)
2. [Take periodic snapshot of Akto data](../../aws-snapshot-policy.md)
