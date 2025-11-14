# Connect Akto with AWS AppSync using Lambda Data Source

AWS AppSync is a fully managed GraphQL service from AWS. It allows you to build scalable applications by connecting to data sources like Lambda functions. By integrating AppSync with Akto using the Golang Runtime API Proxy Extension on AWS Lambda, you can automatically capture and monitor API traffic flowing through your GraphQL operations.

To connect Akto with AWS AppSync through Lambda functions, follow the steps below:

***

## Step 1: Deploy the Akto Data-Ingestion Service

Before setting up the AppSync and Lambda integration, you need to deploy the Akto Data-Ingestion Service.

### 1.1 Download the Required Files

SSH into the instance where you want to deploy the data-ingestion service and run:

```bash
wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/docker-compose-data-ingestion-runtime.yml
wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/data-ingestion-docker.env
wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/docker-mini-runtime.env
wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/watchtower.env

```

### 1.2 Retrieve the `DATABASE_ABSTRACTOR_SERVICE_TOKEN`

* Log in to the [Akto Dashboard](https://app.akto.io/).
*   Navigate to the **Quick Start** tab from the left panel.

    <figure><img src="../../.gitbook/assets/Quick-Start.png" alt=""><figcaption></figcaption></figure>
*   Select **Hybrid SaaS Connector** and copy the token from the **Runtime Service Command** section.

    <figure><img src="../../.gitbook/assets/HybridSaaSConnector.png" alt=""><figcaption></figcaption></figure>

### 1.3 Update the `docker-mini-runtime.env` File

Edit the file to include your token:

```plaintext
DATABASE_ABSTRACTOR_SERVICE_TOKEN=token

```

### 1.4 Deploy the Data-Ingestion Service

Start the service:

```bash
docker-compose -f docker-compose-data-ingestion-runtime.yml up -d

```

### 1.5 Note the IP Address of the Data-Ingestion Service

Ensure this instance is reachable from your Lambda environment. Note its public IP address or DNS name.

***

## Step 2: Setup Lambda Extension for AppSync Resolver Integration

Now that the Akto Data-Ingestion Service is running, follow these steps to configure your AWS Lambda function and integrate it with AppSync.

### 2.1 Clone the Extension Repository

```bash
git clone https://github.com/akto-api-security/golang-lambda-runtime-api-proxy-extension.git
cd golang-lambda-runtime-api-proxy-extension

```

***

### 2.2 Modify the `Makefile`

Update these values in the `Makefile`:

```makefile
BASENAME := $(shell basename $(CURDIR))
ARTIFACTS_DIR ?= out
targetArch := amd64
extensionName := golang-lambda-runtime-api-proxy-extension
FUNCTION_NAME := <your-lambda-function-name>
LAYER_NAME := $(extensionName)-layer

```

* Replace `<your-lambda-function-name>` with your actual Lambda name.
* You'll update the ingestion URL during function configuration.

***

### 2.3 Build the Extension

```bash
make all

```

This packages the Lambda Runtime API Proxy Extension for deployment.

***

### 2.4 Publish as a Lambda Layer

```bash
make publishLayerVersion

```

Copy the output **Layer ARN**.

***

### 2.5 Attach Extension Layer and Configure the Lambda Function

Run:

```bash
make updateFunctionConfiguration FUNCTION_NAME=<your-lambda-name> AKTO_MIRRORING_URL=https://<your-ingestion-service-address>/api/ingestData

```

This will:

* Attach the layer
* Set required environment variables:
  * `AWS_LAMBDA_EXEC_WRAPPER=/opt/wrapper-script.sh`
  * `AKTO_MIRRORING_URL=https://<your-ingestion-service-address>/api/ingestData`

### 2.6 API Inventory with Source Location

Once your Lambda extension is connected, Akto automatically tags API Collection with the source, like `service=lambda`. This helps you easily track and filter API Collection based on their origin. You can view this under **API Discovery > API Collections**.

<figure><img src="../../.gitbook/assets/image (115) (1).png" alt=""><figcaption></figcaption></figure>

***

## Step 3: Add Lambda as a Data Source in AppSync

Now that your Lambda function is ready:

1. Go to the [AWS AppSync console](https://console.aws.amazon.com/appsync/).
2. Open your GraphQL API.
3. Navigate to **Data Sources**.
4. Choose **New** and add your Lambda function as a data source.
5. Name it appropriately and attach the IAM role if required.

***

## Step 4: Modify Your Resolver to Include Akto Payload

Whether you're using **VTL** or **JavaScript**, you must ensure your AppSync resolver sends an enriched payload to Lambda. This allows Akto to inspect incoming request context for observability.

### VTL (Velocity Template Language) Example (Unit Resolver)

```vtl
{
  "version": "2018-05-29",
  "operation": "Invoke",
  "payload": {
	...
	<YOUR_DEFAULT_PAYLOAD>
 	...
    "akto_data": {
		"path": "/graphql",
		"requestHeaders": $util.toJson($context.request.headers),
		"method": "$util.defaultIfNull($context.request.headers['x-forwarded-method'], 'POST')",
		"requestPayload": "$util.escapeJavaScript($util.toJson({
			operationName: $context.info.fieldName,
			query: "",
			variables: $context.arguments
		}))",
		"ip": "$util.defaultIfNull($context.request.headers['x-forwarded-for'], '')",
		"traffic_source": "AppSync"
	}
  }
}

```

### JavaScript Resolver (Pipeline or Unit)

```js
export function request(ctx) {
  return {
    operation: "Invoke",
    payload: {
	  ...
	  <YOUR_DEFAULT_PAYLOAD>
  	  ...
      akto_data: {
		  path: '/graphql',
		  requestHeaders: (ctx.request?.headers || {}),
		  method: ctx.request?.headers?.['x-forwarded-method'] ||  'POST',
		  requestPayload: {
			  operationName: ctx.info.fieldName,
			  query: "",
			  variables: ctx.arguments || {}
		  },
		  ip: ctx.request?.headers?.['x-forwarded-for'] ||  '',
		  traffic_source: 'AppSync',
	  }
    }
  };
}

```

> 📝 **Note:** Ensure `akto_data` includes the necessary context Akto requires.

***

## Step 5: Verify the Setup

1. Trigger a GraphQL query or mutation in your AppSync API.
2. Observe your Lambda logs to ensure Akto extension starts correctly.
3. Log in to [Akto Dashboard](https://app.akto.io/) and check if API traffic is captured under the associated collection.

***

### Need Help?

If you run into any issues or want help with customizing your integration:

1. Reach out via in-app `intercom` on the Akto Dashboard.
2. Join our [Discord community](https://www.akto.io/community).
3. Email us at [help@akto.io](mailto:help@akto.io).
4. Visit [akto.io/contact-us](https://www.akto.io/contact-us) for further assistance.
