# Connect Akto with AWS API Gateway (CloudFormation)

AWS API Gateway is a fully managed service from AWS that helps developers create, publish, monitor, and secure APIs at scale. Akto reads your API Gateway execution logs through a read-only cross-account IAM role, created with CloudFormation or manually. The connector that reads those logs runs in one of two places:

<table><thead><tr><th width="201.5">Setup</th><th>Description</th></tr></thead><tbody><tr><td><a href="#part-2-set-up-the-connector"><strong>Self-hosted (Recommended)</strong></a></td><td>You run the connector in an AWS account of your choosing. Choose self-hosted to keep the connector inside your own environment, or to connect more than one AWS account through a single connector.</td></tr><tr><td><a href="#part-2-set-up-the-connector"><strong>Akto-hosted</strong></a></td><td>Akto runs the connector. You grant access to your logs and share the role details with Akto.</td></tr></tbody></table>

## Prerequisites

* One or more REST APIs deployed in AWS API Gateway.
* Permissions to create IAM roles in your AWS account.

{% hint style="info" %}
Complete every step in the AWS region where your APIs are deployed.
{% endhint %}

{% hint style="info" %}
Logging is enabled for REST APIs only. Akto discovers HTTP and WebSocket API specs, but does not monitor their traffic.
{% endhint %}

## Part 1: Grant access to your API Gateway logs

Akto reads the execution logs that API Gateway writes to CloudWatch. The steps in Part 1 are the same for both hosting models, with the `ServiceAccountId` and `ExternalId` values shown below.

### Values by hosting model

`ServiceAccountId` and `ExternalId` depend on who runs the connector.

<table><thead><tr><th width="201.5">Value</th><th>Self-hosted</th><th>Akto-hosted</th></tr></thead><tbody><tr><td><code>ServiceAccountId</code></td><td>The AWS account ID where you deploy the central connector. Use the same account for every cross-account role. Part 2 deploys the connector stack in this account.</td><td>The AWS account ID provided by your Akto representative.</td></tr><tr><td><code>ExternalId</code></td><td>A value you choose (16 or more characters). Use the same value for every cross-account role, and reuse it as <code>CrossAccountExternalId</code> in Part 2, Step 2.</td><td>The External ID provided by your Akto representative.</td></tr><tr><td>Region</td><td>The region where you deploy the central connector. Every cross-account role uses this region, and Part 2, Step 2 deploys the connector stack in the same region.</td><td>The region where your APIs run.</td></tr></tbody></table>

{% hint style="warning" %}
The self-hosted connector reads each account's logs and specs only in the region where the connector is deployed. APIs in a different region need their own central connector there. Repeat Part 1 once per AWS account you connect.
{% endhint %}

### Choose a setup method

<table><thead><tr><th width="201.5">Method</th><th>Description</th></tr></thead><tbody><tr><td><strong>Option 1: Automated setup (Recommended)</strong></td><td>A single CloudFormation stack enables logging and creates the role.</td></tr><tr><td><strong>Option 2: Manual setup</strong></td><td>You enable logging on your stages, then create the cross-account role. Choose manual setup to review and control every change made in your account.</td></tr></tbody></table>

{% tabs %}
{% tab title="Option 1: Automated setup (Recommended)" %}
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

<table><thead><tr><th width="201.5">Parameter</th><th>Value</th></tr></thead><tbody><tr><td><code>ServiceAccountId</code></td><td>The AWS account ID that runs the connector. See <a href="#values-by-hosting-model">Values by hosting model</a>.</td></tr><tr><td><code>ExternalId</code></td><td>The External ID the role requires on every AssumeRole call. See <a href="#values-by-hosting-model">Values by hosting model</a>.</td></tr><tr><td><code>RestApiIds</code></td><td>Optional. Comma-separated REST API IDs to enable logging on. Leave blank to enable logging for all APIs.</td></tr><tr><td><code>Version</code></td><td>Leave as default.</td></tr></tbody></table>
{% endstep %}

{% step %}
Click **Next**, check the box acknowledging IAM resource creation, and click **Submit**.
{% endstep %}

{% step %}
Once the stack reaches **CREATE\_COMPLETE**, open the **Outputs** tab and copy the `RoleArn` value.
{% endstep %}
{% endstepper %}

{% hint style="info" %}
To pick up APIs or stages created later, update the stack with a new `Version` value (e.g. `1.0.1`). CloudFormation re-runs the setup only when a parameter changes.
{% endhint %}

{% hint style="warning" %}
Deleting the stack does not disable logging or remove the CloudWatch role the stack created.
{% endhint %}

You now have a Role ARN and the region it covers. Continue to [Part 2: Set up the connector](#part-2-set-up-the-connector).
{% endtab %}

{% tab title="Option 2: Manual setup" %}

### 2.1 Enable API Gateway logging

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

{% hint style="info" %}
For APIs or stages created later, enable logging on the new stage yourself.
{% endhint %}

Akto reads these execution logs, which API Gateway writes to a log group named `API-Gateway-Execution-Logs_<api-id>/<stage-name>`. Access logging is not required.

{% hint style="info" %}
If the account has not used API Gateway logging before, AWS also needs an account-level CloudWatch role. Check **API Gateway > Settings > CloudWatch log role ARN**. If the field is empty, create a role that API Gateway can assume with the `AmazonAPIGatewayPushToCloudWatchLogs` managed policy attached, and set the role ARN there.
{% endhint %}

### 2.2 Create the cross-account role

Both methods produce the same role.

#### Using CloudFormation

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

<table><thead><tr><th width="201.5">Parameter</th><th>Value</th></tr></thead><tbody><tr><td><code>ServiceAccountId</code></td><td>The AWS account ID that runs the connector. See <a href="#values-by-hosting-model">Values by hosting model</a>.</td></tr><tr><td><code>ExternalId</code></td><td>The External ID the role requires on every AssumeRole call. See <a href="#values-by-hosting-model">Values by hosting model</a>.</td></tr></tbody></table>
{% endstep %}

{% step %}
Click through, acknowledge IAM resource creation, and submit.
{% endstep %}

{% step %}
On **CREATE\_COMPLETE**, copy the `RoleArn` from the **Outputs** tab.
{% endstep %}
{% endstepper %}

#### Using the IAM console

{% stepper %}
{% step %}
Go to **IAM** > **Roles** > **Create role**.
{% endstep %}

{% step %}
Choose **Custom trust policy** and paste the following, replacing the two placeholders with the `ServiceAccountId` and `ExternalId` values for your [hosting model](#values-by-hosting-model):

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

You now have a Role ARN and the region it covers. Continue to [Part 2: Set up the connector](#part-2-set-up-the-connector).
{% endtab %}
{% endtabs %}

## Part 2: Set up the connector

Choose the tab that matches your hosting model.

{% tabs %}
{% tab title="Self-hosted (Recommended)" %}
A central connector is a single EC2 instance that assumes one cross-account role per AWS account you connect and reads from all of them. Deploy the connector once, in the central account.

#### Step 1: Set up the Akto Traffic Processor

The connector sends data to a Kafka broker. Follow [CloudFormation template (v2)](https://docs.akto.io/getting-started/quick-start-with-akto-cloud/hybrid-saas#cloudformation-template-v2) to set one up, then copy the `AktoNLBIP` value from the stack Outputs. Step 2 uses the value.

{% hint style="info" %}
If a Traffic Processor is already running, skip Step 1 and deploy the connector in the same subnet as the Traffic Processor.
{% endhint %}

#### Step 2: Deploy the Akto API Gateway Log Reader

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

<table><thead><tr><th width="201.5">Parameter</th><th>Value</th></tr></thead><tbody><tr><td><code>VpcId</code>, <code>SubnetId</code></td><td>The VPC and subnet the connector instance should run in.</td></tr><tr><td><code>KeyPair</code></td><td>Optional. Leave blank to use SSM only.</td></tr><tr><td><code>InstanceType</code></td><td>Defaults to <code>c5.large</code>.</td></tr><tr><td><code>AktoKafkaBrokerMal</code></td><td>The <code>AktoNLBIP</code> value from Step 1, including the port, e.g. <code>akto-N-.....amazonaws.com:9092</code>.</td></tr><tr><td><code>DatabaseAbstractorToken</code></td><td>From the Akto dashboard.</td></tr><tr><td><code>CrossAccountRoleArns</code></td><td>Comma-separated Role ARN(s), one per account you connected above. Deploy each role in the connector's region.</td></tr><tr><td><code>CrossAccountExternalId</code></td><td>The same External ID used for every one of those roles.</td></tr><tr><td><code>LogGroupPrefix</code></td><td>Optional. Leave at the default unless your API Gateway logs use a custom log group name.</td></tr></tbody></table>
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

#### Step 3: Add the role ARNs in the Akto dashboard

Add the same Role ARN(s) under the AWS Role ARNs setting in your Akto dashboard for this account. The dashboard list, not the CloudFormation parameter, tells the connector which accounts to monitor. Without the list, the connector stays up but reads no logs.
{% endtab %}

{% tab title="Akto-hosted" %}
Akto sets up the infrastructure that discovers and monitors your APIs. Send your Akto representative the following details for every account you connected in Part 1:

<table><thead><tr><th width="201.5">Detail</th><th>Description</th><th>Example</th></tr></thead><tbody><tr><td><strong>Role ARN</strong></td><td>The <code>RoleArn</code> copied in Part 1.</td><td><code>arn:aws:iam::123456789012:role/akto/AktoApiGatewayLoggingRole-us-east-2</code></td></tr><tr><td><strong>AWS region</strong></td><td>The region your APIs run in.</td><td><code>us-east-2</code></td></tr></tbody></table>

Your AWS account is connected once Akto confirms the setup. Nothing further to deploy on your side.
{% endtab %}
{% endtabs %}

## Get Support for your Akto setup

* **In-app support**: Message us in the Akto dashboard.
* **Join our** [**Discord channel**](https://www.akto.io/community) **for community support.**
* **Email**: Contact `help@akto.io`.
* **Contact us** [**here**](https://www.akto.io/contact-us).
