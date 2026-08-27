# AWS Bedrock AgentCore

## Overview

AWS Bedrock AgentCore is Amazon's managed platform for building and operating production AI agents. Its **Gateway** is a managed MCP endpoint that aggregates tools (Lambda, OpenAPI, and MCP servers) and serves them to your agents and MCP clients over a single URL.

Akto secures this traffic with a **gateway interceptor**: an AWS Lambda function that AgentCore invokes on every request and response passing through the gateway. It validates MCP `tools/call` traffic against your Akto guardrail policies in real time: blocking disallowed tool calls, redacting sensitive tool results, and ingesting all tool activity into the Akto dashboard.

The interceptor code and deployment script are open source: [github.com/akto-api-security/aws-bedrock-agentcore](https://github.com/akto-api-security/aws-bedrock-agentcore).

## How It Works

A single Lambda is attached to the gateway at two interception points: **REQUEST** (before the tool runs) and **RESPONSE** (after the tool returns). The same function handles both; it detects which phase it is from the event.

```mermaid
sequenceDiagram
    autonumber
    participant Client as MCP Client / Agent
    participant Gateway as AgentCore Gateway
    participant Interceptor as Akto Interceptor Lambda
    participant Akto as Akto Guardrails
    participant Target as Tool / MCP Target

    Client->>Gateway: tools/call
    Gateway->>Interceptor: REQUEST event
    Interceptor->>Akto: validate request
    alt Blocked
        Akto-->>Interceptor: not allowed
        Interceptor-->>Gateway: JSON-RPC error (short-circuit)
        Gateway-->>Client: blocked, target never runs
    else Allowed
        Akto-->>Interceptor: allowed (optionally modified)
        Interceptor-->>Gateway: forward request
        Gateway->>Target: invoke tool
        Target-->>Gateway: tool result
        Gateway->>Interceptor: RESPONSE event
        Interceptor->>Akto: validate response
        Interceptor-->>Gateway: pass through / redact / block
        Gateway-->>Client: final result
    end
```

### What gets guardrailed

| MCP method                                            | REQUEST interceptor                       | RESPONSE interceptor                  |
| ----------------------------------------------------- | ----------------------------------------- | ------------------------------------- |
| `tools/call`                                          | Validated; blocked or arguments rewritten | Result validated; blocked or redacted |
| `tools/list`, `initialize`, `notifications/*`, `ping` | Passed through                            | Passed through                        |

## What You'll Achieve

✅ **Real-time tool-call guardrails**: block disallowed `tools/call` before the tool executes\
✅ **Response redaction**: strip or block sensitive data in tool results before the client sees them\
✅ **Full observability**: every MCP tool call and result is ingested into the Akto dashboard\
✅ **Managed enforcement**: runs inside AWS as a gateway interceptor; no proxy or sidecar to operate\
✅ **Fail-open by design**: if Akto is unreachable, traffic passes through so the gateway never breaks

## Prerequisites

### AWS

* An existing AgentCore **Gateway** (MCP protocol): note its **Gateway ID** and **Region**
* AWS credentials with permissions for `lambda:*`, `iam:CreateRole` / `PutRolePolicy` / `PassRole`, and `bedrock-agentcore-control:GetGateway` / `UpdateGateway`
* For the CLI method: `aws` CLI v2, `jq`, and `zip` installed locally

### Akto

* Akto **Data Ingestion URL** (`AKTO_DATA_INGESTION_URL`)
* Akto **API token** (`AKTO_API_TOKEN`)

## Setup

You can deploy via CloudFormation, with the provided CLI script, or manually from the AWS Console. All three attach the **same** Lambda to both interception points.

{% tabs %}
{% tab title="Deploy via CloudFormation (recommended)" %}
{% stepper %}
{% step %}
**Prepare Your Information**

Before running the deployment, gather this information:

1. **AKTO API Key**: Authentication key for your AKTO instance
   * Navigate to: **AKTO Argus** → **Connectors** → **Setup Guardrails**
   * Copy the API key from there
2. **AWS Region**: The region where your AgentCore Gateway is deployed
   * Example: `ap-south-1`
3. **Gateway ID(s)**: One or more AgentCore Gateway IDs to attach the interceptor to (comma-separated)
   * Example: `gateway-quick-start-9080a8`
4. **AKTO Data Ingestion URL**: Your AKTO endpoint
   * Format: `https://your-akto-instance.com/api/ingestData`
   * Contact AKTO support team to obtain your Data Ingestion URL
5. **S3 Bucket Name**: A bucket name for storing Bedrock conversation logs
   * Example: `bedrock-logs-agents`
{% endstep %}

{% step %}
**Open CloudFormation**

1. Sign in to AWS Console
2. Search for "CloudFormation"
3. Click **CloudFormation** service
{% endstep %}

{% step %}
**Create Stack**

1. Click **Create stack**
2. Select **Amazon S3 URL**
3.  Enter the CloudFormation template URL:

    <pre data-overflow="wrap"><code>https://lambda-code-akto-ap-south-1.s3.ap-south-1.amazonaws.com/UNIFIED_TEMPLATE.yaml
    </code></pre>
4. Click **Next.**

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (208).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
**Enter Stack Details**

Fill in the form with your information:

* **Stack name**: Enter a name for your stack (must be lowercase, no spaces)
  * Example: `aws-akto-discovery`

**Parameters:**

* **AktoApiKey**: `<Akto-API-Key>`
* **AwsRegion**: AWS region where Bedrock resources are deployed
  * Example: `ap-south-1`
* **ClientGatewayIds**: AgentCore Gateway IDs to attach interceptor to (comma-separated)
  * Example: `gateway-quick-start-9080a8`
* **DataIngestionEndpoint**: `<URL-obtained-from-akto-team>`
  * Example: `https://your-akto-instance.com/api/ingestData`
* **S3BucketName**: S3 bucket name where your Bedrock conversation logs will be stored via Model Invocation logging. 
  * Make sure that you have enabled 'Model invocation logging' and the S3 bucket configured for invocation logs need to be provided.
  * Go to Amazon Bedrock - Settings - Check 'Model invocation logging' and the S3 logging destination selected. If not enabled, there would be no discovery possible.
  * Example: `bedrock-logs-agents`&#x20;

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (209).png" alt="" width="563"><figcaption></figcaption></figure></div>

Click **Next.**
{% endstep %}

{% step %}
**Configure Stack Options**

1. Leave defaults (no changes needed)
2. Scroll down to **Acknowledgment**
3. ✅ Check: "I acknowledge that AWS CloudFormation might create IAM resources with custom names"

{% hint style="warning" %}
CloudFormation needs this acknowledgement to create the Lambda execution role.
{% endhint %}

4. Click **Create stack**
{% endstep %}

{% step %}
**Wait for Completion**

CloudFormation will create the Lambda execution role, the unified Lambda function for discovery from provided S3 bucket and intercepting gateway, the CloudFormation helper lambda to attach interceptor configuration  (REQUEST + RESPONSE) to each gateway listed in **ClientGatewayIds**.

**Expected Status:**

```
aws-akto-discovery - CREATE_IN_PROGRESS
├─ LambdaExecutionRole - CREATE_COMPLETE ✓
├─ AktoInterceptorLambdaFunction - CREATE_COMPLETE ✓
└─ aws-akto-discovery - CREATE_COMPLETE ✓
```

⏳ **Typical time: 2-3 minutes**
{% endstep %}

{% step %}
**Verify Success**

1. **Stack Status** should show: **CREATE\_COMPLETE** (green)
2. Click the **Outputs** tab
3. You should see the interceptor Lambda's function name and ARN

✅ **Deployment successful!**
{% endstep %}
{% endstepper %}
{% endtab %}

{% tab title="Deploy with CLI" %}
{% stepper %}
{% step %}
**Clone the repository**

```bash
git clone https://github.com/akto-api-security/aws-bedrock-agentcore.git
cd aws-bedrock-agentcore/deploy
```
{% endstep %}

{% step %}
**Create your `.env`**

```bash
cp .env.example .env
```

Fill in the four required values:

```bash
AKTO_DATA_INGESTION_URL=https://your-akto-instance.com
AKTO_API_TOKEN=your-akto-api-token
AWS_REGION=ap-south-1
GATEWAY_IDS=your-gateway-id          # one or many, comma/space separated
```
{% endstep %}

{% step %}
**Run the deploy script**

```bash
./deploy.sh
```

The script auto-fetches your AWS account ID, creates the Lambda execution role if needed, packages and deploys the interceptor, then for each gateway in `GATEWAY_IDS` grants invoke permission and attaches the interceptor (REQUEST + RESPONSE, with request headers enabled). It is idempotent: safe to re-run.
{% endstep %}
{% endstepper %}

{% hint style="info" %}
To attach to multiple gateways, list them in `GATEWAY_IDS` separated by commas or spaces. They must all be in the same `AWS_REGION`; for another region, run the script again with that region.
{% endhint %}
{% endtab %}

{% tab title="Deploy from AWS Console" %}
{% stepper %}
{% step %}
**Create the Lambda function**

Open the **AWS Lambda** console (in the same Region as your gateway) → **Create function** → **Author from scratch**.

* **Function name:** `akto-guardrails-interceptor`
* **Runtime:** **Python 3.12**
* **Architecture:** `x86_64` (default)

Click **Create function**.
{% endstep %}

{% step %}
**Add the interceptor code**

Download [`lambda/interceptor/handler.py`](https://github.com/akto-api-security/aws-bedrock-agentcore/blob/master/lambda/interceptor/handler.py) from the repository.

On the function page, open the **Code** tab and either:

* paste the file contents into the inline editor and rename the file to `handler.py`, **or**
* zip `handler.py` and use **Upload from → .zip file**

Then set the entry point: **Runtime settings → Edit → Handler** = `handler.lambda_handler`. Click **Save**.
{% endstep %}

{% step %}
**Set environment variables**

Go to **Configuration → Environment variables → Edit → Add environment variable** and add both:

| Key                       | Value                                                                                              |
| ------------------------- | -------------------------------------------------------------------------------------------------- |
| `AKTO_DATA_INGESTION_URL` | `https://your-akto-instance.com`                                                                   |
| `AKTO_API_TOKEN`          | your Akto API token (go to **Akto Argus → Connectors → Setup Guardrail** card and copy your token) |

Click **Save**.
{% endstep %}

{% step %}
Copy the **Function ARN** shown at the top right of the function page: you'll need it in the next steps.
{% endstep %}

{% step %}
**Allow the gateway to invoke the Lambda**

The gateway calls the interceptor using its own execution role, so that role needs `lambda:InvokeFunction` permission.

1. In the **Bedrock AgentCore** console, open your **Gateway** and note its **execution role** (an IAM role ARN under the gateway details).
2. Open the **IAM** console → **Roles** → find that role → **Add permissions → Create inline policy** → **JSON** tab, and paste (replace the ARN with your function ARN):

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "lambda:InvokeFunction",
      "Resource": "arn:aws:lambda:<region>:<account-id>:function:akto-guardrails-interceptor"
    }
  ]
}
```

3. Name it `invoke-akto-guardrails-interceptor` and **Create policy**.
{% endstep %}

{% step %}
**Attach the interceptor to the gateway**

Back in the **Bedrock AgentCore** console → your **Gateway** → **Edit**, find the interceptor configuration and paste the **same** Function ARN into both fields:

* **Request Interceptor Lambda ARN** → your function ARN: set **Pass request header** to **True**
* **Response Interceptor Lambda ARN** → the **same** function ARN: set **Pass request header** to **True**
* Leave **Exclude the response body from the interceptor Lambda invocation** **unchecked**

Click **Save** / **Update gateway**.
{% endstep %}
{% endstepper %}

{% hint style="warning" %}
Set **Pass request header** to **True** on both interceptors: the interceptor forwards the `Mcp-Session-Id` header to Akto for session grouping; with it off, sessions can't be correlated. And keep **Exclude the response body** unchecked, or response-content guardrails become a no-op.
{% endhint %}
{% endtab %}
{% endtabs %}

## Verify the Integration

Tail the Lambda logs and make a tool call through the gateway:

```bash
aws logs tail /aws/lambda/akto-guardrails-interceptor --follow --region <your-region>
```

On a `tools/call` you should see:

```
Guardrailing REQUEST tools/call: <tool-name>
Akto response: status=200 ...
```

A blocked call returns a JSON-RPC error to the client instead of the tool result, and the tool activity appears in the Akto dashboard.

## Environment Variables

Only two settings are environment-driven; everything else is a fixed default tuned for the gateway use case.

| Variable                  | Default      | Description                                  |
| ------------------------- | ------------ | -------------------------------------------- |
| `AKTO_DATA_INGESTION_URL` | _(required)_ | Base URL of your Akto data ingestion service |
| `AKTO_API_TOKEN`          | _(required)_ | Authorization token sent to the Akto API     |

## Guardrail Behaviour

The interceptor reads the guardrail verdict from Akto and acts on the policy `behaviour`:

| Verdict              | Action at the gateway                                                                                        |
| -------------------- | ------------------------------------------------------------------------------------------------------------ |
| Allowed              | Traffic passes through                                                                                       |
| Blocked (`block`)    | Returns a JSON-RPC error; the tool never runs (REQUEST) or the result is replaced (RESPONSE)                 |
| `warn` / `alert`     | Traffic is **allowed and logged**: a gateway has no interactive resubmit path, so warnings cannot hard-block |
| Modified             | The tool arguments (REQUEST) or result (RESPONSE) are rewritten with Akto's redacted payload                 |
| Akto error / timeout | **Fail-open**: traffic passes through so the gateway never breaks                                            |

{% hint style="info" %}
Configure which tools and patterns to block, warn, or redact in the Akto dashboard under **Settings → Guardrails**. The interceptor enforces whatever policies you define there.
{% endhint %}


## Integrate Both Bedrock and AgentCore (Unified Setup)

To integrate **both** AWS Bedrock discovery **and** [AWS Bedrock AgentCore](aws-bedrock-agentcore.md) gateway interception in a single stack, use the unified template below instead of the template referenced in the steps above.

**Unified CloudFormation Template:**

<pre data-overflow="wrap"><code>https://lambda-code-akto-us-east-1.s3.us-east-1.amazonaws.com/v4.1/client-aws-cf-template.yaml
</code></pre>

This template adds one new parameter on top of the standard Bedrock discovery setup:

* **EnableGatewayInterception** (`true` / `false`)
    * `true` — Attaches the Akto interceptor to all available AgentCore Gateways. All gateway requests are routed through the interceptor (proxy) to Akto, in addition to discovery through agent traffic.
    * `false` — Only discovery through agent traffic is enabled; no gateway interceptor is attached.

Lambda package used by this template: `s3://lambda-code-akto-us-east-1/v4.1/akto-bedrock-processor.zip`

Deploy following the same **Deploy via AWS Console** steps in the [Step-by-Step Setup](#step-by-step-setup) section above, using this template URL and setting `EnableGatewayInterception` alongside the other parameters when filling in stack details.

## Troubleshooting

### Interceptor not firing

```bash
# Confirm the interceptor is attached to the gateway
aws bedrock-agentcore-control get-gateway \
  --gateway-identifier <gateway-id> --region <region> \
  --query interceptorConfigurations
```

You should see your Lambda ARN with `interceptionPoints` of `["REQUEST","RESPONSE"]` and `passRequestHeaders: true`.

### Guardrails always allowing (fail-open)

The interceptor is fail-open by design: any Akto error allows the request through. Check the Lambda logs:

```bash
aws logs tail /aws/lambda/akto-guardrails-interceptor --region <region> | grep -i "fail-open\|error"
```

Common causes:

* `AKTO_DATA_INGESTION_URL` not set or unreachable from the Lambda
* The Lambda is in a VPC without outbound internet (NAT) to reach Akto
* Guardrail policies not configured in the Akto dashboard

### Tool results not guardrailed

Confirm the **Response Interceptor** is configured (same Lambda ARN) and that **Exclude the response body** is unchecked. Look for `Guardrailing RESPONSE tools/call result:` in the logs.

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
