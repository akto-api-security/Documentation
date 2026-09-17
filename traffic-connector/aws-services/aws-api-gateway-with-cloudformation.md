# Connect Akto with AWS API Gateway (Akto-Hosted Connector)

AWS API Gateway is a fully managed service from AWS that helps developers create, publish, monitor, and secure APIs at scale. Akto connects to your AWS account to automatically discover your APIs and monitor their traffic for security testing.

For REST APIs, Akto both discovers the API and monitors live traffic for security testing. For HTTP and WebSocket APIs, Akto discovers and catalogs the API specification, but does not yet monitor live traffic for these two types.

Setting up this connection only requires running a single AWS CloudFormation stack in your account — there's nothing to deploy or host on your side. The stack grants Akto read-only, revocable access to your API Gateway logs and specs, and nothing else.

***

## Prerequisites

Before you begin, make sure you have:

* **An AWS account with API Gateway already in use** — one or more REST APIs deployed and running.
* **Permissions to create IAM roles, IAM policies, and a Lambda function** in that AWS account. Deploying this stack requires administrator-level or IAM-management permissions, since CloudFormation will ask you to explicitly acknowledge it's creating IAM resources.
* **The AWS Account ID that Akto will connect from.** Get this value from your Akto representative or the Akto dashboard before you start — you'll need to enter it as a parameter when you run the stack.
* **(Optional) The specific REST API ID(s)** you want Akto to monitor, if you don't want to enable logging on every REST API in the account/region. You can find an API's ID in the API Gateway console, or leave this blank to cover every REST API automatically.
* **The AWS CLI installed and configured**, if you plan to deploy via CLI instead of the console.
* **The CloudFormation template file** — download it from Akto's public infra repository: [akto-cross-account-role.yml](https://github.com/akto-api-security/infra/blob/feature/quick-setup/api-gateway-customer-onboarding/akto-cross-account-role.yml).

**Important:** API Gateway is a regional AWS service. If your REST APIs are spread across more than one AWS region, or more than one AWS account, you'll need to run this stack once per region and once per account.

***

## What this stack sets up automatically

Running the stack does the following in your AWS account, with no further action needed from you:

* Enables execution logging on every stage of the REST API(s) you specify (or every REST API in the account/region, if left blank) — this is the same "Error and info logs" + "Data tracing" setting you'd otherwise turn on by hand in the API Gateway console.
* Configures the account-level API Gateway CloudWatch Logs permission, **only if your account doesn't already have one set up** — if you already have this configured, the stack leaves it untouched.
* Creates a dedicated IAM role that only Akto can assume, scoped strictly to reading those logs and reading your API specifications — no other access is granted.

***

## What isn't automated

A few things are worth knowing before and after you run the stack:

1. **Logging is enabled for REST APIs only.** If you have HTTP or WebSocket APIs, this stack does not turn on logging for them. Akto will still discover and catalog their specs, but won't monitor their live traffic today.
2. **Leaving the REST API list blank enables logging for every REST API in this AWS account — but only in the single region where you deploy this stack**, not every region. If you have REST APIs in multiple regions, you'll still need to run the stack separately in each one (see Prerequisites above). If you'd rather limit logging to specific APIs within a region, list their IDs explicitly as a stack parameter instead of leaving it blank.
3. **You must manually share the resulting role with Akto.** The stack doesn't notify Akto on its own — after it completes, copy the `RoleArn` value from the stack's Outputs and share it with Akto (via the dashboard or your Akto representative) to finish connecting your account.
4. **New APIs or stages added later aren't picked up automatically.** If you add a new REST API or a new stage to an existing one after running this stack, re-run it (see [Re-running the stack](#re-running-the-stack-to-pick-up-new-apis) below) to extend logging to the new resources.
5. **Deleting the stack does not turn off logging.** If you remove the stack later, it intentionally leaves your API Gateway logging settings (and the account-level CloudWatch role, if it created one) in place, so removing the Akto integration doesn't silently disrupt your own logging.

***

## Step 1: Run the CloudFormation stack

### Option A: Using the AWS Console

1. Download [akto-cross-account-role.yml](https://github.com/akto-api-security/infra/blob/feature/quick-setup/api-gateway-customer-onboarding/akto-cross-account-role.yml) — click **Raw**, then save the page (or right-click → Save As) to get the template file.
2. Go to the **CloudFormation** service in the AWS Console.
3. Click **Create stack** → **With new resources (standard)**.
4. Choose **Upload a template file**, select the file you downloaded, and click **Next**.
5. Give the stack a name (e.g. `akto-api-gateway-connector`).
6. Fill in the parameters:
   * **AktoAWSAccountId** — the AWS Account ID given to you by Akto.
   * **RoleName** — leave as default unless you have a naming convention to follow.
   * **RestApiIds** — leave blank to cover every REST API in this account/region, or enter a comma-separated list of specific REST API IDs.
7. Click **Next** through the remaining screens.
8. On the final review screen, check the box acknowledging that AWS CloudFormation might create IAM resources, then click **Submit**.
9. Wait for the stack's status to reach **CREATE\_COMPLETE**.
10. Open the **Outputs** tab and copy the value of `RoleArn`.

### Option B: Using the AWS CLI

Download the template:

```sh
curl -o akto-cross-account-role.yml \
  https://raw.githubusercontent.com/akto-api-security/infra/feature/quick-setup/api-gateway-customer-onboarding/akto-cross-account-role.yml
```

Deploy the stack:

```sh
aws cloudformation create-stack \
  --stack-name akto-api-gateway-connector \
  --template-body file://akto-cross-account-role.yml \
  --parameters ParameterKey=AktoAWSAccountId,ParameterValue=<aws-account-id-given-by-akto> \
  --capabilities CAPABILITY_NAMED_IAM
```

* Replace `<aws-account-id-given-by-akto>` with the AWS Account ID from your Akto representative.
* Add `ParameterKey=RestApiIds,ParameterValue="<api-id-1>,<api-id-2>"` to the `--parameters` list if you want to limit logging to specific REST APIs instead of the whole account/region.

Check that it completed successfully:

```sh
aws cloudformation describe-stacks --stack-name akto-api-gateway-connector --query 'Stacks[0].StackStatus'
```

Retrieve the role ARN you'll need in the next step:

```sh
aws cloudformation describe-stacks --stack-name akto-api-gateway-connector --query 'Stacks[0].Outputs'
```

***

## Step 2: Complete the connection

1. Copy the `RoleArn` value from the stack's Outputs.
2. In the Akto dashboard, go to **Quick Start** in the left sidebar.
3. Search for or browse to the **AWS API Gateway** connector tile (under AWS Services) and click it.
4. In the **AWS Role ARNs** field, paste the Role ARN you copied. If you've run this stack in more than one AWS account, paste all of their Role ARNs here, separated by commas.
5. Click **Save**.

Once saved, your AWS account is fully connected — no further setup is required on your end.

***

## Re-running the stack to pick up new APIs

If you add a new REST API, or a new stage to an existing one, after this stack has already run, CloudFormation won't detect a change and won't re-run automatically. To force it to pick up the new resources:

* **Console:** Select the stack → **Update** → keep the same template → change the **Version** parameter to any new value (e.g. `1.0.1`) → proceed through to **Update stack**.
* **CLI:**
  ```sh
  aws cloudformation update-stack \
    --stack-name akto-api-gateway-connector \
    --use-previous-template \
    --parameters ParameterKey=AktoAWSAccountId,UsePreviousValue=true ParameterKey=RestApiIds,UsePreviousValue=true ParameterKey=Version,ParameterValue=1.0.1 \
    --capabilities CAPABILITY_NAMED_IAM
  ```

This re-scans your REST APIs and stages and enables logging on anything newly added.

***

## Get Support for your Akto setup

* **In-app support**: Message us in the Akto dashboard.
* **Join our** [**Discord channel**](https://www.akto.io/community) **for community support.**
* **Email**: Contact `help@akto.io`.
* **Contact us** [**here**](https://www.akto.io/contact-us).
