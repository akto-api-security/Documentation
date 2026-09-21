# Connect AWS Lambda to Akto Guardrails and Discovery

AWS Lambda functions that make outgoing calls to services such as Amazon Bedrock can be connected to Akto for traffic interception, guardrails, and agentic discovery.

The Lambda function routes its outgoing HTTPS traffic through the Akto proxy using the following environment variables:

```plaintext
HTTPS_PROXY=http://<AKTO_PROXY_HOST>:<PORT>
HTTP_PROXY=http://<AKTO_PROXY_HOST>:<PORT>
AWS_CA_BUNDLE=/var/task/mitmproxy-ca-cert.pem
SSL_CERT_FILE=/var/task/mitmproxy-ca-cert.pem
```

## Configuration

### 1. Configure the proxy

Set the proxy environment variables to the Akto proxy endpoint:

```plaintext
HTTPS_PROXY=http://<AKTO_PROXY_HOST>:<PORT>
HTTP_PROXY=http://<AKTO_PROXY_HOST>:<PORT>
```

These variables route the Lambda's outgoing HTTP and HTTPS requests through the Akto proxy.

### 2. Configure the Akto CA certificate

Because the proxy performs HTTPS interception, the Lambda must trust the Akto/MITM proxy CA certificate.

Add the certificate to the Lambda deployment package at:

```plaintext
/var/task/mitmproxy-ca-cert.pem
```

Then configure the following environment variables:

```plaintext
AWS_CA_BUNDLE=/var/task/mitmproxy-ca-cert.pem
SSL_CERT_FILE=/var/task/mitmproxy-ca-cert.pem
```

`AWS_CA_BUNDLE` allows AWS SDK clients such as boto3 to trust the proxy certificate, while `SSL_CERT_FILE` provides the CA bundle to Python SSL-based clients.

## Result

Once these four environment variables are configured, the traffic flow is:

```text
AWS Lambda
    |
    | HTTP_PROXY / HTTPS_PROXY
    v
Akto Proxy
    |
    | HTTPS interception
    v
AWS Bedrock / External Services
```

Akto can then inspect the intercepted traffic and apply configured guardrails, including blocking or allowing requests and generating alerts.

The same traffic can also be used for agentic discovery, allowing Akto to identify the services, APIs, and agent interactions originating from the Lambda function.

## Verification

Invoke the Lambda function and verify that:

1. The Lambda successfully makes its Bedrock or API calls.
2. The Akto proxy receives the requests.
3. Guardrails are evaluated and can block or allow traffic.
4. The captured traffic appears in Akto Agentic Discovery.

If HTTPS requests fail with certificate errors, verify that the following variables point to the certificate included in the Lambda deployment package:

```plaintext
AWS_CA_BUNDLE=/var/task/mitmproxy-ca-cert.pem
SSL_CERT_FILE=/var/task/mitmproxy-ca-cert.pem
```

> **Note:** The proxy endpoint must support HTTPS `CONNECT` tunneling. A webhook endpoint such as Webhook.site cannot be used directly as `HTTP_PROXY` or `HTTPS_PROXY`.
