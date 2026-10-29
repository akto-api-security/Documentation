# Connect Akto with AWS API Gateway (CloudFormation)

AWS API Gateway is a fully managed service from AWS that helps developers create, publish, monitor, and secure APIs at scale. Connecting it to Akto has two parts, both done through CloudFormation: granting read-only access to your API Gateway logs, and choosing who runs the connector that reads them — Akto, or an instance you deploy yourself.

## Part 1: Grant access to your API Gateway logs

There are two ways to do that:

* **Option 1: Manual setup** — you enable logging on your stages yourself, then create the cross-account role. Use this if you want to see and control every change made in your account.
* **Option 2: Automated setup** — a single CloudFormation stack does both.

Either way, you finish by sharing the role ARN with Akto.

***

## Prerequisites

* One or more REST APIs deployed in AWS API Gateway.
* Permissions to create IAM roles in your AWS account.
* The **AWS Account ID** that will run the connector, and the **External ID** to require on every AssumeRole call. If Akto will host the connector, your Akto representative provides both. If you're self-hosting (see [Part 2](#part-2-deploy-the-connector)), you choose both yourself.

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

1. Download [akto-cross-account-role-scoped.yml](https://raw.githubusercontent.com/akto-api-security/infra/feature/quick-setup/api-gateway-customer-onboarding/akto-cross-account-role-scoped.yml) and save the file.
2. Go to **CloudFormation** > **Create stack** > **With new resources (standard)**.
3. Choose **Upload a template file**, select the saved file, and click **Next**.
4.  Name the stack and fill in the parameters:

    * `ServiceAccountId` — the account that will run the connector. Akto-hosted: the account ID given to you by Akto. Self-hosted: your own chosen central account.
    * `ExternalId` — the value to require on every AssumeRole call. Akto-hosted: issued by Akto. Self-hosted: choose any value (16+ characters) and reuse it as `CrossAccountExternalId` when you deploy the connector.
5. Click through, acknowledge IAM resource creation, and submit.
6. On **CREATE\_COMPLETE**, copy the `RoleArn` from the **Outputs** tab.

#### Using the IAM console

1. Go to **IAM** > **Roles** > **Create role**.
2. Choose **Custom trust policy** and paste the following, replacing the two placeholders — the account ID that will run the connector, and the agreed External ID (both given to you by Akto if Akto-hosted; your own choices if self-hosting):

    ```json
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "AWS": "arn:aws:iam::<SERVICE_ACCOUNT_ID>:root"
          },
          "Action": "sts:AssumeRole",
          "Condition": {
            "StringEquals": {
              "sts:ExternalId": "<EXTERNAL_ID>"
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

You now have a Role ARN and the region it covers. See [Part 2](#part-2-deploy-the-connector) to decide who reads them.

***

## Option 2: Automated setup with CloudFormation

A single stack enables execution logging on your stages, configures the account-level CloudWatch role if one isn't already set, and creates the cross-account role.

1. Download [akto-cross-account-role.yml](https://raw.githubusercontent.com/akto-api-security/infra/feature/quick-setup/api-gateway-customer-onboarding/akto-cross-account-role.yml) and save the file.
2. Go to **CloudFormation** in the AWS Console and click **Create stack** > **With new resources (standard)**.
3. Choose **Upload a template file**, select the saved file, and click **Next**.
4.  Enter a stack name (e.g. `akto-api-gateway-connector`) and fill in the parameters:

    * `ServiceAccountId` — the account that will run the connector. Akto-hosted: the account ID given to you by Akto. Self-hosted: your own chosen central account.
    * `ExternalId` — the value to require on every AssumeRole call. Akto-hosted: issued by Akto. Self-hosted: choose any value (16+ characters) and reuse it as `CrossAccountExternalId` when you deploy the connector.
    * `RestApiIds` _(optional)_ — comma-separated REST API IDs to enable logging on. Leave blank to enable logging for all APIs.
    * `Version` — leave as default.
5. Click **Next**, check the box acknowledging IAM resource creation, and click **Submit**.
6. Once the stack reaches **CREATE\_COMPLETE**, open the **Outputs** tab and copy the `RoleArn` value.

You now have a Role ARN and the region it covers. See [Part 2](#part-2-deploy-the-connector) to decide who reads them.

***

## Part 2: Deploy the connector

With your cross-account role(s) in place, decide who runs the connector that reads from them:

* **Akto-hosted (default)** — Akto runs the connector for you.
* **Self-hosted** — deploy the connector yourself, in an AWS account of your choosing. Use this if you'd rather keep it inside your own environment, or you're connecting more than one AWS account and want a single connector reading from all of them.

### Akto-hosted: share the setup details with Akto

Akto sets up the infrastructure that discovers and monitors your APIs. Send your Akto representative the following details, for every account you connected in Part 1:

1. **Role ARN** — the `RoleArn` copied in Part 1.\
   Example: `arn:aws:iam::123456789012:role/akto/AktoApiGatewayLoggingRole-us-east-2`
2. **AWS region** — the region your APIs run in.\
   Example: `us-east-2`

Your AWS account is connected once Akto confirms the setup. Nothing further to deploy on your side.

### Self-hosted: deploy a central connector

A central connector is a single EC2 instance that assumes one cross-account role per AWS account you connect, and reads from all of them. Repeat Option 1 or Option 2 above once per account — using the same External ID and the same central account as `ServiceAccountId` each time — then deploy the connector once, in that central account.

> The connector reads each account's logs and specs in the region it's deployed in only — it doesn't read across regions. Deploy every cross-account role (Option 1/Option 2 above) in the same region you'll deploy the central connector in. APIs in a different region need their own central connector there.

#### Step 1: Set up the Akto Traffic Processor

The connector sends data to a Kafka broker. Follow [CloudFormation template (v2)](https://docs.akto.io/getting-started/quick-start-with-akto-cloud/hybrid-saas#cloudformation-template-v2) to set one up, then copy the `AktoNLBIP` value from its Outputs — you'll need it below.

> Already have one running? Skip this, but deploy the connector in the same subnet as the Traffic Processor.

#### Step 2: Deploy the Akto API Gateway Log Reader

> Deploy this stack in the same AWS region as the cross-account roles above — switch regions using the selector in the top-right of the AWS Console.

1. Download [api-gateway-connector-service-acc-setup.yml](https://raw.githubusercontent.com/akto-api-security/infra/feature/quick-setup/api-gateway-customer-onboarding/api-gateway-connector-service-acc-setup.yml) and save the file.
2. Go to **CloudFormation** > **Create stack** > **With new resources (standard)**.
3. Choose **Upload a template file**, select the saved file, and click **Next**.
4.  Name the stack and fill in the parameters:

    * `VpcId`, `SubnetId` — the VPC and subnet the connector instance should run in.
    * `KeyPair` _(optional)_ — leave blank to use SSM only.
    * `InstanceType` — defaults to `c5.large`.
    * `AktoKafkaBrokerMal` — the `AktoNLBIP` value from Step 1, including the port, e.g. `akto-N-.....amazonaws.com:9092`.
    * `DatabaseAbstractorToken` — from the Akto dashboard.
    * `CrossAccountRoleArns` — comma-separated Role ARN(s), one per account you connected above. Each role must have been deployed in this same region.
    * `CrossAccountExternalId` — the same External ID used for every one of those roles.
    * `LogGroupPrefix` _(optional)_ — leave at the default unless your API Gateway logs use a custom log group name.
5. Click **Next**, check the box acknowledging IAM resource creation, and click **Submit**.
6. Once the stack reaches **CREATE\_COMPLETE**, open the **Outputs** tab.

> This only scopes which role ARNs the connector instance is _allowed_ to assume — it doesn't yet start monitoring them. That's Step 3.

#### Step 3: Add the role ARNs in the Akto dashboard

Add the same Role ARN(s) under the AWS Role ARNs setting in your Akto dashboard for this account. This dashboard list — not the CloudFormation parameter — is what actually tells the connector which accounts to monitor. If you skip this step, the connector stays up but reads nothing.

***

## Note:

1. Logging is enabled for REST APIs only. Akto discovers HTTP and WebSocket API specs, but does not monitor their traffic.
2. If `RestApiIds` is left empty, the stack applies to all REST APIs. Set it to scope the setup to specific APIs.
3. To pick up APIs or stages created later, update the stack with a new `Version` value (e.g. `1.0.1`) — CloudFormation re-runs the setup only when a parameter changes. With the manual setup, enable logging on the new stage yourself.
4. Deleting the stack does not disable logging or remove the CloudWatch role it created.
5. For the self-hosted central connector, a Role ARN is only monitored once it's both in the `CrossAccountRoleArns` parameter and added in the Akto dashboard — the parameter alone only controls what the connector instance is allowed to assume.
6. The self-hosted central connector is single-region: it only reads accounts whose cross-account role was deployed in the same region as the connector itself.

***

## Get Support for your Akto setup

* **In-app support**: Message us in the Akto dashboard.
* **Join our** [**Discord channel**](https://www.akto.io/community) **for community support.**
* **Email**: Contact `help@akto.io`.
* **Contact us** [**here**](https://www.akto.io/contact-us).
