# AWS deploy

### 60 seconds deploy in AWS 🚀

{% tabs %}
{% tab title="Akto Setup" %}
![Deployment Architecture](<../.gitbook/assets/scale (1)-Page-4.drawio (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png>)
{% endtab %}
{% endtabs %}

If your application services are hosted in AWS, follow the steps below to install Akto in your AWS cloud.

### Step 1: Create Account

1. Go to [Akto self hosted](https://stairway.akto.io/).
2. `Signup` if you haven't already done that.
3. Go to AWS section. `Select region` from the dropdown and click on `launch stack.`&#x20;

<figure><img src="../.gitbook/assets/Frame 1 (8) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (3).png" alt=""><figcaption></figcaption></figure>

4\. This will re-direct you to the `AWS screen`.&#x20;

### Step 2: Create stack in AWS

1. Sign into your `AWS account` if you are not logged-in.&#x20;

{% hint style="info" %}
Note: Akto can't track anything that you do in AWS.
{% endhint %}

![](<../.gitbook/assets/Screen Shot 2023-01-03 at 3.38 2.png>)

2\. This will take you to a pre-filled `quick create stack` like below. If you don't see the below screen, click on `launch stack` again.

<figure><img src="../.gitbook/assets/Screen Shot 2023-01-03 at 3.52 3.png" alt=""><figcaption></figcaption></figure>

3\.  Add your parameters here - `keypair`, `1 private subnetId` and `2 public subnetIds`. Atleast 1 public subnet should be in the same availability zone as private subnet.

<figure><img src="../.gitbook/assets/Frame 7 (1).png" alt=""><figcaption></figcaption></figure>

4\. Your user email parameter should be the same as the one you used to signup with Akto.

5\. Select `I acknowledge that AWS CloudFormation might create IAM resources.`&#x20;

<figure><img src="../.gitbook/assets/Frame 8 (1).png" alt=""><figcaption></figcaption></figure>

6\. Click on `create stack`.

### Step 3: Launch Akto dashboard

1. `Wait` for a couple of minutes before you stack creation is complete.
2. Once your stack is created, `navigate to outputs` sections and `copy Akto dashboard url` into your browser.

<figure><img src="../.gitbook/assets/Frame 4 (4).png" alt=""><figcaption></figcaption></figure>

3\. `Signup` and start using Akto.
