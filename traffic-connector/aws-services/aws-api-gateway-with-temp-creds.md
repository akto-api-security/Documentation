# Connect Akto with AWS API Gateway with service account (Temporary Credentials)

AWS API Gateway is a fully managed service from AWS that helps developers create, publish, monitor, and secure APIs at scale. By integrating AWS API Gateway with Akto, you'll automatically discover and test the security of all your REST APIs, HTTP APIs, and WebSocket APIs deployed through API Gateway, ensuring comprehensive API security across your AWS infrastructure.

<figure><img src="../../.gitbook/assets/image (16).png" alt=""><figcaption></figcaption></figure>

To connect Akto with AWS API Gateway using **Service Accounts (IRSA)**, follow these steps:

----------

## Step 1: Set Up and Configure API Gateway

### 1.1 Set up Akto Traffic Processor

Follow the steps mentioned [here](https://docs.akto.io/getting-started/traffic-processor/hybrid-saas) to set up the Akto Traffic Processor.

### 1.2 Add AWS API Gateway Connector

1.  Go to **API Gateway** in the AWS Console.
2.  Navigate to your API and click on `Stages` from the left menu.
    <figure><img src="../../.gitbook/assets/aws-api-gateway-1.png" alt=""><figcaption></figcaption></figure>
3.  Scroll down to the `Logs and tracing` section and click on `Edit`.
    <figure><img src="../../.gitbook/assets/aws-api-gateway-2.png" alt=""><figcaption></figcaption></figure>
4.  Select `Error and info logs` and `Data tracing` and save these settings.
    ```
    { "requestId":"$context.requestId", "extendedRequestId":"$context.extendedRequestId","ip": "$context.identity.sourceIp", "caller":"$context.identity.caller", "user":"$context.identity.user", "requestTime":"$context.requestTime", "httpMethod":"$context.httpMethod", "resourcePath":"$context.resourcePath", "status":"$context.status", "protocol":"$context.protocol", "responseLength":"$context.responseLength" }
    ```
  <figure><img src="../../.gitbook/assets/aws-api-gateway-3.png" alt=""><figcaption></figcaption></figure>
5.  Find out the `CloudWatch log group` for your API Gateway for the stage which has the above logs enabled and save its ARN. You'll need it later.

----------

## Step 2: Set Up Cross-Account IAM Role for CloudWatch Logs

If your EKS cluster and CloudWatch log groups are in different AWS accounts, follow these steps to enable access using IAM roles with temporary credentials.

### 2.1 Create IAM Role in CloudWatch Account

1.  Go to the **IAM** service in the AWS Console of the account where CloudWatch logs are stored.
2.  Click **Roles** on the left panel, then click **Create role**.
3.  Choose **Another AWS account** as the trusted entity.
4.  Enter the AWS Account ID of the EKS cluster account.
5.  Click **Next**, and in the permissions step, create a new policy or attach an existing one with the following permissions:

    ```json
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "logs:DescribeLogGroups",
            "logs:DescribeLogStreams",
            "logs:GetLogEvents",
            "logs:FilterLogEvents"
          ],
          "Resource": "arn:aws:logs:<region>:<cloudwatch-account-id>:log-group:*"
        }
      ]
    }
    ```

6.  Replace `<region>` and `<cloudwatch-account-id>` with actual values.
7.  Click **Next**, name the role (e.g., `CrossAccountCloudWatchRole`), and create the role.

### 2.2 Update Trust Policy

After creating the role, modify the **Trust relationships** section to allow access from the EKS IRSA role:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::<eks-account-id>:role/<irsa-role-name>"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
```

- Replace `<eks-account-id>` with the AWS account ID where EKS is running.
- Replace `<irsa-role-name>` with the IAM role attached to the EKS service account.

----------

## Step 3: Create an IAM Role for EKS Service Account

### 3.1 Create an IAM Policy in EKS Account

1.  Go to **IAM** service in the AWS Console of the EKS cluster account.
2.  Click **Policies**, then **Create policy**.
3.  Use the following JSON policy:

    ```json
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": "sts:AssumeRole",
                "Resource": "arn:aws:iam::<cloudwatch-account-id>:role/CrossAccountCloudWatchRole"
            }
        ]
    }
    ```

4.  Replace `<cloudwatch-account-id>` with the AWS account ID where CloudWatch logs are stored.
5.  Click **Next**, give the policy a name (e.g., `EKSCloudWatchAccess`), and create it.

### 3.2 Create IAM Role for Service Account

1.  In the EKS cluster account, go to **IAM** and click **Roles** > **Create role**.
2.  Select **Web Identity** as the trusted entity.
3.  Choose your EKS OIDC provider and enter `sts.amazonaws.com` as the audience.
4.  Attach the policy created in Step 3.1.
5.  Name the role (e.g., `EKSCloudWatchRole`) and create it.

### 3.3 Update Trust Policy for IRSA Role

Modify the trust policy for the role created in Step 3.2:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::<eks-account-id>:oidc-provider/oidc.eks.<region>.amazonaws.com/id/<oidc-provider-id>"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "oidc.eks.<region>.amazonaws.com/id/<oidc-provider-id>:sub": "system:serviceaccount:<namespace>:service-account-eks"
                }
            }
        }
    ]
}
```

- Replace placeholders with actual values.

----------

## Step 4: Attach IAM Role to EKS Service Account

1.  Create a `service-account.yaml` file:

    ```yaml
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: service-account-eks
      namespace: <namespace>
      annotations:
        eks.amazonaws.com/role-arn: arn:aws:iam::<eks-account-id>:role/EKSCloudWatchRole
    ```

2.  Apply the service account:

    ```sh
    kubectl apply -f service-account.yaml
    ```

Now, the EKS pod using this service account can assume the cross-account IAM role to access CloudWatch logs securely.


## Step 5: Update the Kubernetes Deployment YAML
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-gateway-logging
  namespace: <namespace>
spec:
  replicas: 1
  selector:
    matchLabels:
      app: api-gateway-logging 
  template:
    metadata:
      labels:
        app: api-gateway-logging 
    spec:
      serviceAccountName: service-account-eks
      containers:
      - image: aktosecurity/mirror-api-logging:api-gateway-logging-temp-cred
        name: api-gateway-logging 
        imagePullPolicy: Always
        resources: {}
        env:
          - name: AKTO_BYTES_IN_THRESHOLD
            value: "100"
          - name: AKTO_TRAFFIC_BATCH_TIME_SECS
            value: "10"
          - name: AKTO_TRAFFIC_BATCH_SIZE
            value: "100"
          - name: AKTO_KAFKA_BROKER_MAL
            value: ""
          - name: CLOUDWATCH_READ_BATCH_SIZE
            value: "5"
          - name: CROSS_ACCOUNT_ROLE_ARN
            value: ""
          - name: LOG_GROUP_PREFIX
            value: "API-Gateway-Execution-Logs"
          - name: SESSION_NAME
            value: ""
          - name: AWS_REGION
            value: ""
          - name: DATABASE_ABSTRACTOR_TOKEN
            value: ""
```

- Replace `<namespace>` with the Kubernetes namespace used in Steps 3.3 and 4.  
- For `AKTO_KAFKA_BROKER_MAL`, use the value of the `mini-runtime` service deployed in Step 1.1.  
- For `<LOG_GROUP_ARN>`, enter the value obtained in Step 1.2.5. (This is optional if you want to use multiple CloudWatch log groups)
- Replace `<DATABASE_ABSTRACTOR_TOKEN>`, with the database abstractor token from Akto dashboard.
- For `<SESSION_NAME>`, use any name you want for the session.  
- Replace `<AWS_REGION>` with the AWS region where your EKS cluster is located.

## Note:

1. If fetching logs from multiple accounts, make sure that the cross account role [ generally which belongs to the monitoring account ] attached to the module can read logs from all the aforementioned accounts.
2. If adding multiple role ARNs, in Akto, make sure that the eks pod created here, has the correct IAM policies to be able to assume these role ARNs.

----------

With this setup, Akto can fetch CloudWatch logs from API Gateway across AWS accounts using temporary credentials.

----------

## Get Support for your Akto setup

-   **In-app support**: Message us in the Akto dashboard.
-   **Join our** **[Discord channel](https://www.akto.io/community)** **for community support.**
-   **Email**: Contact `help@akto.io`.
-   **Contact us** **[here](https://www.akto.io/contact-us)**.
