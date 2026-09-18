# Connect Akto with AWS API Gateway (Akto-Hosted Connector)

AWS API Gateway is a fully managed service from AWS that helps developers create, publish, monitor, and secure APIs at scale. With this setup there is nothing to deploy or maintain on your side — Akto hosts and runs the connector, and all you do is enable logging and grant Akto read-only access to it.

There are two ways to do that:

* **Option 1: Manual setup** — you enable logging on your stages yourself, then create the cross-account role. Use this if you want to see and control every change made in your account.
* **Option 2: Automated setup** — a single CloudFormation stack does both.

Either way, you finish by sharing the role ARN with Akto.

***

## Prerequisites

* One or more REST APIs deployed in AWS API Gateway.
* Permissions to create IAM roles in your AWS account.
* The **AWS Account ID** Akto connects from, and the **External ID** issued for your account — both provided by your Akto representative.

> Do all of this in the AWS region where your APIs are deployed.

***

## Option 1: Manual setup

### 1.1 Enable API Gateway logging

Repeat this for every stage you want Akto to monitor.

1. Go to **API Gateway** in the AWS Console.
2.  Navigate to your API and click on `Stages` from the left menu.
3.  Scroll down to the `Logs and tracing` section and click on `Edit`.
4.  Set the log level to `Error and info logs`, turn on `Data tracing`, and save.

Akto reads these execution logs, which API Gateway writes to a log group named `API-Gateway-Execution-Logs_<api-id>/<stage-name>`. Access logging is not required.

> If this is the first API Gateway in the account to use logging, AWS also needs an account-level CloudWatch role. Check **API Gateway > Settings > CloudWatch log role ARN** — if it is empty, create a role that API Gateway can assume with the `AmazonAPIGatewayPushToCloudWatchLogs` managed policy attached, and set its ARN there.

### 1.2 Create the cross-account role

Use whichever you prefer — both produce the same role.

#### Using CloudFormation

1. Download [akto-cross-account-role-scoped.yml](https://github.com/akto-api-security/infra/blob/feature/quick-setup/api-gateway-customer-onboarding/akto-cross-account-role-scoped.yml) — click **Raw**, then save the file.
2. Go to **CloudFormation** > **Create stack** > **With new resources (standard)**.
3. Choose **Upload a template file**, select the saved file, and click **Next**.
4.  Name the stack and fill in the parameters:

    * `AktoAWSAccountId` — the AWS Account ID given to you by Akto.
    * `ExternalId` — the External ID issued to you by Akto.
5. Click through, acknowledge IAM resource creation, and submit.
6. On **CREATE\_COMPLETE**, copy the `RoleArn` from the **Outputs** tab.

#### Using the IAM console

1. Go to **IAM** > **Roles** > **Create role**.
2. Choose **Custom trust policy** and paste the following, replacing the two placeholders:

    ```json
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "AWS": "arn:aws:iam::<AKTO_AWS_ACCOUNT_ID>:root"
          },
          "Action": "sts:AssumeRole",
          "Condition": {
            "StringEquals": {
              "sts:ExternalId": "<EXTERNAL_ID_FROM_AKTO>"
            }
          }
        }
      ]
    }
    ```
3.  Click **Next**, then **Create policy**, select the **JSON** editor, and paste the following. Replace `<REGION>` with the region your APIs run in and `<YOUR_ACCOUNT_ID>` with your AWS account ID.

    ```json
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "ListLogGroups",
          "Effect": "Allow",
          "Action": "logs:DescribeLogGroups",
          "Resource": "arn:aws:logs:<REGION>:<YOUR_ACCOUNT_ID>:log-group:*"
        },
        {
          "Sid": "ReadApiGatewayExecutionLogs",
          "Effect": "Allow",
          "Action": [
            "logs:DescribeLogStreams",
            "logs:GetLogEvents",
            "logs:FilterLogEvents"
          ],
          "Resource": [
            "arn:aws:logs:<REGION>:<YOUR_ACCOUNT_ID>:log-group:API-Gateway-Execution-Logs*",
            "arn:aws:logs:<REGION>:<YOUR_ACCOUNT_ID>:log-group:API-Gateway-Execution-Logs*:*"
          ]
        },
        {
          "Sid": "DiscoverApiGatewaySpecs",
          "Effect": "Allow",
          "Action": "apigateway:GET",
          "Resource": [
            "arn:aws:apigateway:<REGION>::/restapis",
            "arn:aws:apigateway:<REGION>::/restapis/*",
            "arn:aws:apigateway:<REGION>::/apis",
            "arn:aws:apigateway:<REGION>::/apis/*"
          ]
        }
      ]
    }
    ```
4. Name the policy, create it, and attach it to the role.
5. Name the role `AktoApiGatewayLoggingRole-<region>` and create it.
6. Open the role and copy its ARN.

> `logs:DescribeLogGroups` cannot be restricted to a name prefix — AWS evaluates list operations against an empty resource, so a prefix pattern never matches. It only exposes log group **names**. Reading log **contents** stays restricted to `API-Gateway-Execution-Logs*`.

### 1.3 Share the setup details with Akto

Akto sets up the infrastructure that discovers and monitors your APIs. Send your Akto representative the following details:

1. **Role ARN** — the `RoleArn` copied in step 1.2.\
   Example: `arn:aws:iam::123456789012:role/akto/AktoApiGatewayLoggingRole-us-east-2`
2. **AWS region** — the region your APIs run in.\
   Example: `us-east-2`

Your AWS account is connected once Akto confirms the setup.

***

## Option 2: Automated setup with CloudFormation

A single stack enables execution logging on your stages, configures the account-level CloudWatch role if one isn't already set, and creates the cross-account role.

### Option A: AWS Console

1. Open [akto-cross-account-role.yml](https://github.com/akto-api-security/infra/blob/feature/quick-setup/api-gateway-customer-onboarding/akto-cross-account-role.yml), click **Raw**, and save the file.
2. Go to **CloudFormation** in the AWS Console and click **Create stack** > **With new resources (standard)**.
3. Choose **Upload a template file**, select the saved file, and click **Next**.
4.  Enter a stack name (e.g. `akto-api-gateway-connector`) and fill in the parameters:

    * `AktoAWSAccountId` — the AWS Account ID given to you by Akto.
    * `ExternalId` — the External ID issued to you by Akto.
    * `RestApiIds` _(optional)_ — comma-separated REST API IDs to enable logging on. Leave blank to enable logging for all APIs.
    * `Version` — leave as default.
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
                   ParameterKey=ExternalId,ParameterValue=<external-id-from-akto> \
      --capabilities CAPABILITY_NAMED_IAM
    ```

3.  Copy the `RoleArn` from the outputs:

    ```sh
    aws cloudformation describe-stacks \
      --stack-name akto-api-gateway-connector \
      --query 'Stacks[0].Outputs'
    ```

***

## Share the setup details with Akto

Akto sets up the infrastructure that discovers and monitors your APIs. Send your Akto representative the following details:

1. **Role ARN** — the `RoleArn` copied above.\
   Example: `arn:aws:iam::123456789012:role/akto/AktoApiGatewayLoggingRole-us-east-2`
2. **AWS region** — the region your APIs run in.\
   Example: `us-east-2`

Your AWS account is connected once Akto confirms the setup.

***

## Note:

1. Logging is enabled for REST APIs only. Akto discovers HTTP and WebSocket API specs, but does not monitor their traffic.
2. If `RestApiIds` is left empty, the stack applies to all REST APIs. Set it to scope the setup to specific APIs.
3. To pick up APIs or stages created later, update the stack with a new `Version` value (e.g. `1.0.1`) — CloudFormation re-runs the setup only when a parameter changes. With the manual setup, enable logging on the new stage yourself.
4. Deleting the stack does not disable logging or remove the CloudWatch role it created.

***

## Get Support for your Akto setup

* **In-app support**: Message us in the Akto dashboard.
* **Join our** [**Discord channel**](https://www.akto.io/community) **for community support.**
* **Email**: Contact `help@akto.io`.
* **Contact us** [**here**](https://www.akto.io/contact-us).
