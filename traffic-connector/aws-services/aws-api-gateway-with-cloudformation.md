# Connect Akto with AWS API Gateway (CloudFormation)

AWS API Gateway is a fully managed service from AWS that helps developers create, publish, monitor, and secure APIs at scale. Akto reads your API Gateway execution logs through a read-only cross-account IAM role, created with CloudFormation or manually. The connector that reads those logs runs in one of two places:

* **Akto-hosted (default)**: Akto runs the connector. You grant access to your logs and share the role details with Akto.
* **Self-hosted**: you run the connector in an AWS account of your choosing. Choose self-hosted to keep the connector inside your own environment, or to connect more than one AWS account through a single connector.

## Prerequisites

* One or more REST APIs deployed in AWS API Gateway.
* Permissions to create IAM roles in your AWS account.

{% hint style="info" %}
Complete every step in the AWS region where your APIs are deployed.
{% endhint %}

## Akto-hosted setup

Akto runs the connector. Your Akto representative provides the **AWS Account ID** and **External ID** used to create the cross-account role.

### Part 1: Grant access to your API Gateway logs

Choose one of two methods:

* **Option 1: Manual setup**: you enable logging on your stages, then create the cross-account role. Choose manual setup to review and control every change made in your account.
* **Option 2: Automated setup**: a single CloudFormation stack enables logging and creates the role.

{% tabs %}
{% tab title="Option 1: Manual setup" %}

#### 1.1 Enable API Gateway logging

Repeat the following steps for every stage you want Akto to monitor.

{% stepper %}
{% step %}
Go to **API Gateway** in the AWS Console.
{% endstep %}

{% step %}
Navigate to your API and click on `Stages` from the left menu.
{% endstep %}

{% step %}
Scroll down to the `Logs and tracing` section and click on `Edit`.
{% endstep %}

{% step %}
Set the log level to `Error and info logs`, turn on `Data tracing`, and save.
{% endstep %}
{% endstepper %}

Akto reads these execution logs, which API Gateway writes to a log group named `API-Gateway-Execution-Logs_<api-id>/<stage-name>`. Access logging is not required.

{% hint style="info" %}
If the account has not used API Gateway logging before, AWS also needs an account-level CloudWatch role. Check **API Gateway > Settings > CloudWatch log role ARN**. If the field is empty, create a role that API Gateway can assume with the `AmazonAPIGatewayPushToCloudWatchLogs` managed policy attached, and set the role ARN there.
{% endhint %}

#### 1.2 Create the cross-account role

Both methods produce the same role.

##### Using CloudFormation

{% stepper %}
{% step %}
Download [akto-cross-account-role-scoped.yml](https://raw.githubusercontent.com/akto-api-security/infra/feature/quick-setup/api-gateway-customer-onboarding/akto-cross-account-role-scoped.yml) and save the file.
{% endstep %}

{% step %}
Go to **CloudFormation** > **Create stack** > **With new resources (standard)**.
{% endstep %}

{% step %}
Choose **Upload a template file**, select the saved file, and click **Next**.
{% endstep %}

{% step %}
Name the stack and fill in the parameters:

* `ServiceAccountId`: the AWS account ID provided by your Akto representative.
* `ExternalId`: the External ID provided by your Akto representative. The role requires the External ID on every AssumeRole call.
{% endstep %}

{% step %}
Click through, acknowledge IAM resource creation, and submit.
{% endstep %}

{% step %}
On **CREATE\_COMPLETE**, copy the `RoleArn` from the **Outputs** tab.
{% endstep %}
{% endstepper %}

##### Using the IAM console

{% stepper %}
{% step %}
Go to **IAM** > **Roles** > **Create role**.
{% endstep %}

{% step %}
Choose **Custom trust policy** and paste the following, replacing the two placeholders with the account ID and External ID provided by your Akto representative:

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
{% endstep %}

{% step %}
Click **Next**, then **Create policy**, select the **JSON** editor, and paste the following. Replace `<REGION>` with the region your APIs run in and `<YOUR_ACCOUNT_ID>` with your AWS account ID.

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
{% endstep %}

{% step %}
Name the policy, create it, and attach it to the role.
{% endstep %}

{% step %}
Name the role `AktoApiGatewayLoggingRole-<region>` and create it.
{% endstep %}

{% step %}
Open the role and copy its ARN.
{% endstep %}
{% endstepper %}

{% hint style="info" %}
`logs:DescribeLogGroups` cannot be restricted to a name prefix, because AWS evaluates list operations against an empty resource and a prefix pattern never matches. The permission exposes only log group **names**. Reading log **contents** stays restricted to `API-Gateway-Execution-Logs*`.
{% endhint %}

You now have a Role ARN and the region it covers. Continue to [Part 2: Share the setup details with Akto](#part-2-share-the-setup-details-with-akto).
{% endtab %}

{% tab title="Option 2: Automated setup" %}
A single stack enables execution logging on your stages, configures the account-level CloudWatch role if one isn't already set, and creates the cross-account role.

{% stepper %}
{% step %}
Download [akto-cross-account-role.yml](https://raw.githubusercontent.com/akto-api-security/infra/feature/quick-setup/api-gateway-customer-onboarding/akto-cross-account-role.yml) and save the file.
{% endstep %}

{% step %}
Go to **CloudFormation** in the AWS Console and click **Create stack** > **With new resources (standard)**.
{% endstep %}

{% step %}
Choose **Upload a template file**, select the saved file, and click **Next**.
{% endstep %}

{% step %}
Enter a stack name (e.g. `akto-api-gateway-connector`) and fill in the parameters:

* `ServiceAccountId`: the AWS account ID provided by your Akto representative.
* `ExternalId`: the External ID provided by your Akto representative. The role requires the External ID on every AssumeRole call.
* `RestApiIds` _(optional)_: comma-separated REST API IDs to enable logging on. Leave blank to enable logging for all APIs.
* `Version`: leave as default.
{% endstep %}

{% step %}
Click **Next**, check the box acknowledging IAM resource creation, and click **Submit**.
{% endstep %}

{% step %}
Once the stack reaches **CREATE\_COMPLETE**, open the **Outputs** tab and copy the `RoleArn` value.
{% endstep %}
{% endstepper %}

You now have a Role ARN and the region it covers. Continue to [Part 2: Share the setup details with Akto](#part-2-share-the-setup-details-with-akto).
{% endtab %}
{% endtabs %}

### Part 2: Share the setup details with Akto

Akto sets up the infrastructure that discovers and monitors your APIs. Send your Akto representative the following details for every account you connected in Part 1:

1. **Role ARN**: the `RoleArn` copied in Part 1.\
   Example: `arn:aws:iam::123456789012:role/akto/AktoApiGatewayLoggingRole-us-east-2`
2. **AWS region**: the region your APIs run in.\
   Example: `us-east-2`

Your AWS account is connected once Akto confirms the setup. Nothing further to deploy on your side.

## Self-hosted setup

You run the connector. A central connector is a single EC2 instance that assumes one cross-account role per AWS account you connect and reads from all of them.

### Part 1: Grant access with your own account and External ID

Complete [Part 1 of the Akto-hosted setup](#part-1-grant-access-to-your-api-gateway-logs) (Option 1 or Option 2) once per AWS account you connect, with the following values in place of the ones an Akto representative would provide:

<table><thead><tr><th width="201.5">Value</th><th>What to use when self-hosting</th></tr></thead><tbody><tr><td><code>ServiceAccountId</code></td><td>The AWS account ID where you deploy the central connector. Use the same account for every cross-account role.</td></tr><tr><td><code>ExternalId</code></td><td>A value you choose (16 or more characters). Use the same value for every cross-account role, and reuse it as <code>CrossAccountExternalId</code> in Part 2.</td></tr><tr><td>Region</td><td>The region where you deploy the central connector.</td></tr></tbody></table>

{% hint style="warning" %}
The connector reads each account's logs and specs only in the region where the connector is deployed. Deploy every cross-account role in the same region as the central connector. APIs in a different region need their own central connector there.
{% endhint %}

### Part 2: Deploy the connector

Deploy the connector once, in the central account.

##### Step 1: Set up the Akto Traffic Processor

The connector sends data to a Kafka broker. Follow [CloudFormation template (v2)](https://docs.akto.io/getting-started/quick-start-with-akto-cloud/hybrid-saas#cloudformation-template-v2) to set one up, then copy the `AktoNLBIP` value from the stack Outputs. Step 2 uses the value.

{% hint style="info" %}
If a Traffic Processor is already running, skip Step 1 and deploy the connector in the same subnet as the Traffic Processor.
{% endhint %}

##### Step 2: Deploy the Akto API Gateway Log Reader

{% hint style="info" %}
Deploy the stack in the same AWS region as the cross-account roles. Switch regions with the selector in the top-right of the AWS Console.
{% endhint %}

{% stepper %}
{% step %}
Download [api-gateway-connector-service-acc-setup.yml](https://raw.githubusercontent.com/akto-api-security/infra/feature/quick-setup/api-gateway-customer-onboarding/api-gateway-connector-service-acc-setup.yml) and save the file.
{% endstep %}

{% step %}
Go to **CloudFormation** > **Create stack** > **With new resources (standard)**.
{% endstep %}

{% step %}
Choose **Upload a template file**, select the saved file, and click **Next**.
{% endstep %}

{% step %}
Name the stack and fill in the parameters:

* `VpcId`, `SubnetId`: the VPC and subnet the connector instance should run in.
* `KeyPair` _(optional)_: leave blank to use SSM only.
* `InstanceType`: defaults to `c5.large`.
* `AktoKafkaBrokerMal`: the `AktoNLBIP` value from Step 1, including the port, e.g. `akto-N-.....amazonaws.com:9092`.
* `DatabaseAbstractorToken`: from the Akto dashboard.
* `CrossAccountRoleArns`: comma-separated Role ARN(s), one per account you connected above. Deploy each role in the connector's region.
* `CrossAccountExternalId`: the same External ID used for every one of those roles.
* `LogGroupPrefix` _(optional)_: leave at the default unless your API Gateway logs use a custom log group name.
{% endstep %}

{% step %}
Click **Next**, check the box acknowledging IAM resource creation, and click **Submit**.
{% endstep %}

{% step %}
Once the stack reaches **CREATE\_COMPLETE**, open the **Outputs** tab.
{% endstep %}
{% endstepper %}

{% hint style="warning" %}
The `CrossAccountRoleArns` parameter only scopes which role ARNs the connector instance is _allowed_ to assume. Monitoring starts after Step 3.
{% endhint %}

##### Step 3: Add the role ARNs in the Akto dashboard

Add the same Role ARN(s) under the AWS Role ARNs setting in your Akto dashboard for this account. The dashboard list, not the CloudFormation parameter, tells the connector which accounts to monitor. Without the list, the connector stays up but reads no logs.

## Setup notes

1. Logging is enabled for REST APIs only. Akto discovers HTTP and WebSocket API specs, but does not monitor their traffic.
2. If `RestApiIds` is left empty, the stack applies to all REST APIs. Set it to scope the setup to specific APIs.
3. To pick up APIs or stages created later, update the stack with a new `Version` value (e.g. `1.0.1`), because CloudFormation re-runs the setup only when a parameter changes. With the manual setup, enable logging on the new stage yourself.
4. Deleting the stack does not disable logging or remove the CloudWatch role it created.
5. For the self-hosted central connector, a Role ARN is only monitored once the Role ARN is both in the `CrossAccountRoleArns` parameter and added in the Akto dashboard. The parameter alone controls only which roles the connector instance is allowed to assume.
6. The self-hosted central connector is single-region: the connector reads only accounts whose cross-account role was deployed in the same region as the connector itself.

## Get Support for your Akto setup

* **In-app support**: Message us in the Akto dashboard.
* **Join our** [**Discord channel**](https://www.akto.io/community) **for community support.**
* **Email**: Contact `help@akto.io`.
* **Contact us** [**here**](https://www.akto.io/contact-us).
