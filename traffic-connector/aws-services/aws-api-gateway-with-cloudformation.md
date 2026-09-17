# Connect Akto with AWS API Gateway (Akto-Hosted Connector)

AWS API Gateway is a fully managed service from AWS that helps developers create, publish, monitor, and secure APIs at scale. With this setup, you only run a single CloudFormation stack in your AWS account — Akto hosts and runs the connector, so there is nothing to deploy or maintain on your side.

The stack enables API Gateway execution logging and creates a read-only IAM role for Akto to assume.

***

## Prerequisites

* One or more REST APIs deployed in AWS API Gateway.
* Permissions to create IAM roles and a Lambda function via CloudFormation.
* The AWS Account ID Akto connects from — ask your Akto representative.
* The template file: [akto-cross-account-role.yml](https://github.com/akto-api-security/infra/blob/feature/quick-setup/api-gateway-customer-onboarding/akto-cross-account-role.yml)

> Run the stack in the AWS region where your APIs are deployed.

***

## What the stack does

In your AWS account, the stack:

1. Enables execution logging (`INFO` level with data tracing) on every stage of the selected REST APIs.
2. Sets the account-level API Gateway CloudWatch Logs role, only if your account doesn't already have one configured.
3. Creates a read-only IAM role that Akto assumes to read those logs and discover your API specs.

It grants no write access, and no access to anything outside API Gateway and its CloudWatch logs.

***

## Step 1: Run the CloudFormation stack

### Option A: AWS Console

1. Open [akto-cross-account-role.yml](https://github.com/akto-api-security/infra/blob/feature/quick-setup/api-gateway-customer-onboarding/akto-cross-account-role.yml), click **Raw**, and save the file.
2. Go to **CloudFormation** in the AWS Console and click **Create stack** > **With new resources (standard)**.
3. Choose **Upload a template file**, select the saved file, and click **Next**.
4.  Enter a stack name (e.g. `akto-api-gateway-connector`) and fill in the parameters:

    * `AktoAWSAccountId` — the AWS Account ID given to you by Akto.
    * `RestApiIds` _(optional)_ — comma-separated REST API IDs to enable logging on. Leave blank to enable logging for all APIs.
    * `RoleName`, `Version` — leave as default.
5. Click **Next**, check the box acknowledging IAM resource creation, and click **Submit**.
6. Once the stack reaches **CREATE\_COMPLETE**, open the **Outputs** tab and copy the `RoleArn` value.

### Option B: AWS CLI

1.  Download the template:

    ```sh
    curl -o akto-cross-account-role.yml \
      https://raw.githubusercontent.com/akto-api-security/infra/feature/quick-setup/api-gateway-customer-onboarding/akto-cross-account-role.yml
    ```
2.  Create the stack:

    ```sh
    aws cloudformation create-stack \
      --stack-name akto-api-gateway-connector \
      --template-body file://akto-cross-account-role.yml \
      --parameters ParameterKey=AktoAWSAccountId,ParameterValue=<aws-account-id-given-by-akto> \
      --capabilities CAPABILITY_NAMED_IAM
    ```

3.  Copy the `RoleArn` from the outputs:

    ```sh
    aws cloudformation describe-stacks \
      --stack-name akto-api-gateway-connector \
      --query 'Stacks[0].Outputs'
    ```

***

## Step 2: Add the role ARN in Akto

1. In the Akto dashboard, go to **Quick Start**.
2. Select the **AWS API Gateway** connector.
3. Paste the `RoleArn` into the **AWS Role ARNs** field.
4. Click **Save**.

***

## Step 3: Share the setup details with Akto

Akto sets up the infrastructure that discovers and monitors your APIs. Send your Akto representative the following details:

1. **Role ARN** — the `RoleArn` copied in **Step 1**.\
   Example: `arn:aws:iam::123456789012:role/akto/AktoApiGatewayLoggingRole`
2. **AWS region** — the region your APIs run in.\
   Example: `us-east-2`

Your AWS account is connected once Akto confirms the setup.

***

## Note:

1. Logging is enabled for REST APIs only. Akto discovers HTTP and WebSocket API specs, but does not monitor their traffic.
2. If `RestApiIds` is left empty, the stack applies to all REST APIs. Set it to scope the setup to specific APIs.
3. To pick up APIs or stages created later, update the stack with a new `Version` value (e.g. `1.0.1`) — CloudFormation re-runs the setup only when a parameter changes.
4. Deleting the stack does not disable logging or remove the CloudWatch role it created.

***

## Get Support for your Akto setup

* **In-app support**: Message us in the Akto dashboard.
* **Join our** [**Discord channel**](https://www.akto.io/community) **for community support.**
* **Email**: Contact `help@akto.io`.
* **Contact us** [**here**](https://www.akto.io/contact-us).
