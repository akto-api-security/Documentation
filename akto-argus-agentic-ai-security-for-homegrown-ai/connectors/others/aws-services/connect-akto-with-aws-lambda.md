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

## Deployment Options

The Akto proxy is typically placed behind a Network Load Balancer (NLB), and `HTTPS_PROXY` / `HTTP_PROXY` point to the NLB's DNS name. The same setup works for other AWS workloads that make outbound calls, such as Bedrock AgentCore Runtime and containers (ECS/EKS).

There are two ways to expose the proxy:

```mermaid
%%{init: {"flowchart": {"curve": "basis", "nodeSpacing": 50, "rankSpacing": 70}, "themeVariables": {"fontSize": "15px", "edgeLabelBackground": "#ffffff"}}}%%
flowchart TB
    subgraph EXT["External Workloads"]
        direction LR
        C2("Container") ~~~ L2("Lambda") ~~~ R2("AgentCore Runtime")
    end

    subgraph VPC["VPC"]
        subgraph APPS["Workloads in the same VPC"]
            direction LR
            C1("Container") ~~~ L1("Lambda") ~~~ R1("AgentCore Runtime")
        end
        INLB("Internal NLB<br/>(Recommended)")
        P1("Akto Proxy")
        PNLB("Public NLB")
        P2("Akto Proxy")
    end

    B("Amazon Bedrock")

    EXT ~~~ APPS
    APPS -->|"<span style='color:#15803d'>HTTPS_PROXY=Internal_NLB</span>"| INLB
    EXT -->|"<span style='color:#b91c1c'>HTTPS_PROXY=Public_NLB</span>"| PNLB
    INLB --> P1
    PNLB --> P2
    P1 --> B
    P2 --> B

    classDef workload fill:#ffffff,stroke:#d97706,stroke-width:1.5px,color:#1f2937,font-weight:bold
    classDef rec fill:#dcfce7,stroke:#16a34a,stroke-width:2px,color:#14532d,font-weight:bold
    classDef pub fill:#fee2e2,stroke:#dc2626,stroke-width:1.5px,color:#7f1d1d,font-weight:bold
    classDef dest fill:#ffedd5,stroke:#ea580c,stroke-width:2px,color:#7c2d12,font-weight:bold
    class C1,L1,R1,C2,L2,R2 workload
    class INLB,P1 rec
    class PNLB,P2 pub
    class B dest

    style EXT fill:#f8fafc,stroke:#94a3b8,stroke-width:1.5px,stroke-dasharray:6 4,color:#334155
    style VPC fill:#f1f5f9,stroke:#64748b,stroke-width:2px,color:#1e293b
    style APPS fill:#f0fdf4,stroke:#16a34a,stroke-width:1.5px,stroke-dasharray:6 4,color:#166534

    linkStyle 0,1,2,3,4 stroke:transparent,stroke-width:0px
    linkStyle 5,7,9 stroke:#16a34a,stroke-width:2.5px
    linkStyle 6,8,10 stroke:#dc2626,stroke-width:2px,stroke-dasharray:6 4
```

| Option | Proxy endpoint | When to use |
| --- | --- | --- |
| **Same VPC + Internal NLB** (recommended) | `http://<INTERNAL_NLB_DNS>:<PORT>` | The Lambda is VPC-attached (or can be) and runs in the same VPC as the Akto proxy, or in a peered / Transit Gateway-connected VPC. |
| **Public NLB** | `http://<PUBLIC_NLB_DNS>:<PORT>` | The Lambda is not attached to a VPC and cannot reach a private endpoint. |

> **Recommendation:** Deploy the Akto proxy in the **same VPC** as your Lambda functions and expose it through an **internal NLB**, rather than a public-facing load balancer.
>
> * Traffic, including prompts, responses, and AWS request signatures, stays on the private network and is never exposed to the internet.
> * The proxy is not reachable from the internet, which reduces the attack surface and removes the need to lock down a public listener.
> * Latency is lower because traffic does not leave the VPC to reach the proxy.
> * Access can be restricted with security groups to only the Lambda functions' security groups.
>
> If you must use a public NLB, restrict inbound access to known source IP ranges (for example, the Elastic IPs of your NAT gateways) using security groups on the NLB.

To route a Lambda through an internal NLB, attach the Lambda to the VPC (subnets and security group), and allow outbound traffic from the Lambda's security group to the NLB on the proxy port.

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
