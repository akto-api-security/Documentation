# Integrate AWS Lambda using Egress Proxy

AWS Lambda functions that make outgoing calls to services such as Amazon Bedrock can be connected to Akto for **traffic interception, guardrails, and agentic discovery**.

The Lambda function routes its outgoing HTTP/HTTPS traffic through the Akto proxy and trusts the Akto MITM CA certificate using a Lambda Layer.

## Configuration

### 1. Configure the Akto proxy

Set the following environment variables in the Lambda function:

```text
HTTPS_PROXY=http://<AKTO_PROXY_HOST>:<PORT>
HTTP_PROXY=http://<AKTO_PROXY_HOST>:<PORT>
```

These variables route the Lambda's outgoing HTTP/HTTPS requests through the Akto proxy.

### 2. Add the Akto CA certificate using a Lambda Layer

The Akto/MITM CA certificate can be provided through a **Lambda Layer**, so the certificate does not need to be included directly in the Lambda function's deployment package.

Create a Lambda Layer containing:

```text
mitm-ca-layer.zip
└── certs/
    └── mitmproxy-ca-cert.pem
```

Lambda mounts the contents of the layer under `/opt`. The certificate will therefore be available at:

```text
/opt/certs/mitmproxy-ca-cert.pem
```

Attach this Layer to the Lambda function.

### 3. Configure the certificate environment variables

Set the following environment variables:

```text
AWS_CA_BUNDLE=/opt/certs/mitmproxy-ca-cert.pem
SSL_CERT_FILE=/opt/certs/mitmproxy-ca-cert.pem
```

`AWS_CA_BUNDLE` allows AWS SDK clients such as boto3 to trust the Akto proxy certificate.

`SSL_CERT_FILE` configures Python SSL-based clients to use the same CA certificate.

## Required Environment Variables

The Lambda function requires these four environment variables:

```text
HTTPS_PROXY=http://<AKTO_PROXY_HOST>:<PORT>
HTTP_PROXY=http://<AKTO_PROXY_HOST>:<PORT>
AWS_CA_BUNDLE=/opt/certs/mitmproxy-ca-cert.pem
SSL_CERT_FILE=/opt/certs/mitmproxy-ca-cert.pem
```

The first two configure the proxy, while the last two configure trust for the MITM CA certificate provided through the Lambda Layer.

## Traffic Flow

Once configured, the traffic flow is:

```mermaid
flowchart TD
    A["AWS Lambda<br/>Application / SDK"] -->|"HTTP_PROXY<br/>HTTPS_PROXY"| B["Akto Proxy<br/>HTTPS interception · Guardrails · Discovery"]
    B --> C["AWS Bedrock / APIs"]
```

Akto can inspect the intercepted traffic and apply configured **guardrails**, including allowing, blocking, or alerting on requests.

The intercepted traffic can also be used for **agentic discovery**, allowing Akto to discover services, APIs, and agent interactions originating from the Lambda function.

## Verification

After configuring the Lambda:

1. Attach the CA certificate Lambda Layer.
2. Verify that the certificate exists at:

   ```text
   /opt/certs/mitmproxy-ca-cert.pem
   ```
3. Verify all four environment variables are configured.
4. Invoke the Lambda and make a Bedrock or other outbound API call.
5. Verify that the request reaches the Akto proxy.
6. Verify that Akto evaluates the request against the configured guardrails.
7. Verify that the traffic appears in Akto Agentic Discovery.

If HTTPS requests fail with certificate errors, verify that the Lambda Layer is attached and that both certificate environment variables point to:

```text
/opt/certs/mitmproxy-ca-cert.pem
```

> **Note:** The proxy endpoint must support HTTPS `CONNECT` tunneling. A webhook endpoint such as Webhook.site cannot be used directly as `HTTP_PROXY` or `HTTPS_PROXY`.
