# Sidecar Egress Proxy

## Overview

Akto Egress Proxy is a transparent mitmproxy-based security layer that intercepts and governs outbound AI API calls made by your agents or applications to LLM providers (OpenAI, Anthropic, Amazon Bedrock). It applies request and response guardrails on every AI API call — without requiring any changes to your agent code.

## Key Features

* **Outbound LLM Guardrails**: Inspect and enforce policies on every prompt your agent sends to OpenAI, Anthropic, or Bedrock before it reaches the provider
* **Response Guardrails**: Scan and filter LLM responses for PII, sensitive data, or policy violations before your agent consumes them
* **Request Modification**: Automatically rewrite prompts flagged for modification (e.g., strip PII, enforce system prompt constraints)
* **Selective Interception**: Only intercepts traffic to known AI providers — all other traffic passes through untouched
* **Zero Code Changes**: Routes through standard `HTTP_PROXY` / `HTTPS_PROXY` env vars; your agent code is unchanged
* **Open Source**: The proxy script and Docker setup are fully open source at [akto-api-security/akto-ai-egress](https://github.com/akto-api-security/akto-ai-egress)

## Architecture

```mermaid
flowchart LR
    A[AI Agent / App\nyour container] -->|all outbound traffic\nvia HTTP_PROXY| B[Akto Egress Proxy\nmitmproxy :8087]
    B -->|AI provider traffic\nintercepted + inspected| C[Akto Guardrails]
    C -->|allowed / modified| B
    B -->|forwarded to LLM| D[LLM Provider\nOpenAI / Anthropic / Bedrock]
    B -->|non-AI traffic\npassed through| E[Other External Services]
```

### Traffic Flow

1. Your agent makes an LLM API call (e.g., `POST https://api.anthropic.com/v1/messages`)
2. The call is transparently routed through the Egress Proxy via `HTTP_PROXY` / `HTTPS_PROXY`
3. The proxy intercepts the request and sends the message payload to Akto's guardrails endpoint
4. Akto evaluates the prompt against configured guardrails:
   * **Blocked**: Proxy returns a `403` error immediately; the LLM is never called
   * **Modified**: Proxy rewrites the request body before forwarding
   * **Allowed**: Request is forwarded to the LLM provider unchanged
5. The LLM response is intercepted and evaluated by Akto's response guardrails
6. The response is returned to the agent (original, blocked, or rewritten)

## Deployment

The proxy is published as a prebuilt image, `public.ecr.aws/aktosecurity/akto-egress-proxy:latest`, which bundles the `akto_guardrails.py` addon. Deploy it next to your agent with [Docker Compose](#deploy-with-docker-compose) or on [Kubernetes](#deploy-on-kubernetes).

## Deploy with Docker Compose

{% hint style="info" %}
**Prerequisites**

* Docker and Docker Compose installed
* An Akto instance (self-hosted or cloud) with your `AKTO_URL`
* Your AI agent or application running as a Docker container
{% endhint %}

{% stepper %}
{% step %}
### Set environment variables

```bash
export AKTO_URL=https://akto.example.com   # your Akto instance base URL
export APP_NAME=my-ai-agent                # identifies your app in Akto guardrails
```

| Variable   | Required | Description                                                                                                 |
| ---------- | -------- | ----------------------------------------------------------------------------------------------------------- |
| `AKTO_URL` | Yes      | Base URL of your Akto instance (e.g. `https://akto.example.com`). The proxy appends `/api/http-proxy`.      |
| `APP_NAME` | Yes      | Name of your application. Sent as the `host` header to Akto so traffic is grouped per app in the dashboard. |
| `AI_HOSTS` | No       | Comma-separated hosts to intercept and run guardrails on. `*` matches any run of characters. See [Supported AI Providers](#supported-ai-providers) for the default list. |
{% endstep %}

{% step %}
### Create `docker-compose.yml`

Create a `docker-compose.yml` with the proxy and your agent. Replace `your-ai-agent:latest` with your agent's image:

```yaml
services:
  your-agent:
    image: your-ai-agent:latest
    depends_on:
      - akto-egress-proxy
    environment:
      HTTP_PROXY: http://akto-egress-proxy:8087
      HTTPS_PROXY: http://akto-egress-proxy:8087
      SSL_CERT_FILE: /etc/ssl/certs/ca-certificates.crt
      REQUESTS_CA_BUNDLE: /etc/ssl/certs/ca-certificates.crt
      AWS_CA_BUNDLE: /etc/ssl/certs/ca-certificates.crt
    volumes:
      - ./mitmproxy-data/mitmproxy-ca-cert.pem:/usr/local/share/ca-certificates/mitmproxy-ca-cert.crt:ro

  akto-egress-proxy:
    image: public.ecr.aws/aktosecurity/akto-egress-proxy:latest
    container_name: akto-egress-proxy
    command:
      - mitmdump
      - --listen-host
      - 0.0.0.0
      - --listen-port
      - "8087"
      - --ignore-hosts
      - ^(?!((api\.openai\.com|api\.anthropic\.com|chatgpt\.com|bedrock-runtime\.[^:]*\.amazonaws\.com|bedrock-agent-runtime\.[^:]*\.amazonaws\.com):\d+$$))(?!(\d+\.\d+\.\d+\.\d+|\[?[0-9a-f:]+\]?):\d+$$).*
      - -s
      - /addons/akto_guardrails.py
    environment:
      AKTO_URL: ${AKTO_URL}
      APP_NAME: ${APP_NAME:-}
      AI_HOSTS: ${AI_HOSTS:-}
    volumes:
      - ./mitmproxy-data:/home/mitmproxy/.mitmproxy
```
{% endstep %}

{% step %}
### Start the proxy

Start the proxy on its own first. On first run, it generates its CA certificate at `./mitmproxy-data/mitmproxy-ca-cert.pem`:

```bash
docker compose up -d akto-egress-proxy
ls ./mitmproxy-data/mitmproxy-ca-cert.pem
```

{% hint style="warning" %}
Start the proxy before your agent. If the agent starts first, the cert file doesn't exist yet, so Docker creates an empty directory at that path and the agent can't trust the proxy. If this happens, run `docker compose down`, delete `./mitmproxy-data`, and start again from this step.
{% endhint %}
{% endstep %}

{% step %}
### Start your agent

```bash
docker compose up -d
```

{% hint style="info" %}
**CA Certificate**

Your agent container must trust `mitmproxy-data/mitmproxy-ca-cert.pem`, or intercepted calls fail with `CERTIFICATE_VERIFY_FAILED`:

1. Mount it into `/usr/local/share/ca-certificates/` as shown above.
2. Run `update-ca-certificates` to add it to `/etc/ssl/certs/ca-certificates.crt`.
3. Point Python clients at that bundle with `SSL_CERT_FILE`, `REQUESTS_CA_BUNDLE` and `AWS_CA_BUNDLE` — they ignore the system store by default.

Point those variables at the **combined** bundle, not at `mitmproxy-ca-cert.pem` alone: they replace the trust store entirely, so a file holding only the mitmproxy cert breaks every call the proxy does not intercept.

Node.js uses `NODE_EXTRA_CA_CERTS` (which adds rather than replaces, so the cert alone is fine). Go, curl and Ruby read the system bundle, so steps 1–2 suffice. Java needs `keytool`.
{% endhint %}
{% endstep %}

{% step %}
### Verify

Confirm the proxy is intercepting traffic by checking its logs:

```bash
docker logs -f akto-egress-proxy
```

You should see `[AKTO] URL: <your-akto-url>/api/http-proxy` and `[AKTO] AI hosts: [...]` on startup, and `evaluating request` / `evaluating response` log lines when your agent makes LLM calls.
{% endstep %}
{% endstepper %}

## Deploy on Kubernetes

On Kubernetes, the proxy runs as a sidecar in your agent's pod and listens on `127.0.0.1:8087`, so only containers in that pod can use it. Certificates are supplied through volume mounts:

* **CA key and certificate**: stored in a Secret and mounted into the proxy. Every pod and replica signs with the same CA, so restarts and rescheduling don't change it.
* **Public CA certificate**: stored in a ConfigMap. An init container combines it with the system CAs into a bundle that the agent reads. The agent doesn't need root or `update-ca-certificates`.

{% hint style="info" %}
**Prerequisites**

* Kubernetes 1.29 or later, for native sidecar containers
* `kubectl` access to the cluster and the namespace your agent runs in
* Nodes that can pull from `public.ecr.aws` and reach your AI providers
* An Akto instance reachable from the cluster, with your `AKTO_URL`
{% endhint %}

{% stepper %}
{% step %}
### Create a CA certificate

The proxy needs a CA certificate and key to sign intercepted connections. To use an existing CA, skip to the next step. It must be a signing CA (`CA:TRUE`, `keyCertSign`) with an unencrypted key.

```bash
openssl req -x509 -newkey rsa:2048 -nodes -days 3650 \
  -keyout ca.key -out ca.crt -subj "/CN=Akto Egress Proxy CA" \
  -addext "basicConstraints=critical,CA:TRUE" \
  -addext "keyUsage=critical,keyCertSign,cRLSign"
cat ca.key ca.crt > mitmproxy-ca.pem
```

`mitmproxy-ca.pem` holds the private key and certificate, and only the proxy gets it. `ca.crt` is the public certificate that your agent trusts.
{% endstep %}

{% step %}
### Create the Secret and ConfigMaps

Create them in the namespace your agent runs in:

```bash
export NS=my-namespace
kubectl -n $NS create secret generic akto-egress-ca --from-file=mitmproxy-ca.pem=mitmproxy-ca.pem
kubectl -n $NS create configmap akto-egress-ca-cert --from-file=mitmproxy-ca-cert.pem=ca.crt
kubectl -n $NS create configmap akto-egress-config \
  --from-literal=AKTO_URL=https://akto.example.com \
  --from-literal=APP_NAME=my-ai-agent
```

| Resource              | Contains                                    | Mounted into           |
| --------------------- | ------------------------------------------- | ---------------------- |
| `akto-egress-ca`      | CA private key and certificate              | Proxy only             |
| `akto-egress-ca-cert` | Public CA certificate                       | `ca-bundle` init container |
| `akto-egress-config`  | `AKTO_URL`, `APP_NAME`, optional `AI_HOSTS` | Proxy                  |
{% endstep %}

{% step %}
### Add the proxy sidecar to your Deployment

Add the two init containers, the agent environment variables, and the volumes to your agent's Deployment. Replace `your-agent` and `your-ai-agent:latest` with your own values:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: your-agent
spec:
  replicas: 1
  selector:
    matchLabels:
      app: your-agent
  template:
    metadata:
      labels:
        app: your-agent
    spec:
      initContainers:
        # Builds a CA bundle of the system CAs plus the proxy CA.
        - name: ca-bundle
          image: public.ecr.aws/aktosecurity/akto-egress-proxy:latest
          command: ["sh", "-c", "cat /etc/ssl/certs/ca-certificates.crt /akto-ca/mitmproxy-ca-cert.pem > /ca-bundle/ca-certificates.crt"]
          volumeMounts:
            - name: akto-ca-cert
              mountPath: /akto-ca
              readOnly: true
            - name: ca-bundle
              mountPath: /ca-bundle
        # Native sidecar: starts before the agent and keeps running.
        - name: akto-egress-proxy
          image: public.ecr.aws/aktosecurity/akto-egress-proxy:latest
          restartPolicy: Always
          args:
            - mitmdump
            - --listen-host
            - 127.0.0.1
            - --listen-port
            - "8087"
            - --ignore-hosts
            - '^(?!((api\.openai\.com|api\.anthropic\.com|chatgpt\.com|bedrock-runtime\.[^:]*\.amazonaws\.com|bedrock-agent-runtime\.[^:]*\.amazonaws\.com):\d+$))(?!(\d+\.\d+\.\d+\.\d+|\[?[0-9a-f:]+\]?):\d+$).*'
            - -s
            - /addons/akto_guardrails.py
          envFrom:
            - configMapRef:
                name: akto-egress-config
          env:
            - name: PYTHONUNBUFFERED
              value: "1"
          startupProbe:
            exec:
              command: ["python", "-c", "import socket; socket.create_connection(('127.0.0.1', 8087), 1)"]
            periodSeconds: 2
            failureThreshold: 30
          volumeMounts:
            # mitmproxy writes mitmproxy-dhparam.pem here, so it must be writable.
            - name: mitmproxy-confdir
              mountPath: /home/mitmproxy/.mitmproxy
            - name: akto-ca
              mountPath: /home/mitmproxy/.mitmproxy/mitmproxy-ca.pem
              subPath: mitmproxy-ca.pem
              readOnly: true
      containers:
        - name: agent
          image: your-ai-agent:latest
          env:
            - name: HTTP_PROXY
              value: http://127.0.0.1:8087
            - name: HTTPS_PROXY
              value: http://127.0.0.1:8087
            - name: NO_PROXY
              value: localhost,127.0.0.1,169.254.169.254,169.254.170.23,.svc,.cluster.local
            - name: SSL_CERT_FILE
              value: /ca-bundle/ca-certificates.crt
            - name: REQUESTS_CA_BUNDLE
              value: /ca-bundle/ca-certificates.crt
            - name: AWS_CA_BUNDLE
              value: /ca-bundle/ca-certificates.crt
          volumeMounts:
            - name: ca-bundle
              mountPath: /ca-bundle
              readOnly: true
      volumes:
        - name: akto-ca
          secret:
            secretName: akto-egress-ca
            defaultMode: 0400
        - name: akto-ca-cert
          configMap:
            name: akto-egress-ca-cert
        - name: ca-bundle
          emptyDir: {}
        - name: mitmproxy-confdir
          emptyDir: {}
```

Apply it:

```bash
kubectl -n $NS apply -f deployment.yaml
kubectl -n $NS rollout status deploy/your-agent
```

{% hint style="info" %}
**How the manifest works**

* **Proxy directory is an `emptyDir`.** mitmproxy writes `mitmproxy-dhparam.pem` to `/home/mitmproxy/.mitmproxy` on startup. Secret mounts are read-only, so mounting the Secret over the whole directory makes the proxy crash. Only `mitmproxy-ca.pem` is mounted from the Secret, with `subPath`.
* **`startupProbe`** holds the agent back until the proxy accepts connections.
* **`NO_PROXY`** keeps in-cluster traffic and the AWS credential endpoints (`169.254.169.254` for instance metadata, `169.254.170.23` for EKS Pod Identity) off the proxy. Add other internal hosts your agent calls.
* **Non-Python runtimes**: Node.js reads `NODE_EXTRA_CA_CERTS`, so point it at `/ca-bundle/ca-certificates.crt`. Go, curl and Ruby read `SSL_CERT_FILE`.
* **Regex escaping**: write the `--ignore-hosts` regex with single `$`. The `$$` form is only for `docker-compose.yml`.
{% endhint %}
{% endstep %}

{% step %}
### Verify

Check the proxy's logs:

```bash
kubectl -n $NS logs -f deploy/your-agent -c akto-egress-proxy
```

You should see `[AKTO] URL: <your-akto-url>/api/http-proxy` on startup, and `evaluating request` / `evaluating response` when your agent makes LLM calls. A request blocked by a guardrail shows `<< 403 Forbidden`, and the agent receives a `403` response.

To check the agent's own output:

```bash
kubectl -n $NS logs deploy/your-agent -c agent
```
{% endstep %}
{% endstepper %}

{% hint style="info" %}
**Calling Amazon Bedrock with an IAM role**

Agents on EKS can use EKS Pod Identity or IRSA instead of access keys. Credential requests go to `169.254.170.23` (Pod Identity) or STS, which the proxy doesn't intercept, so no extra configuration is needed beyond `NO_PROXY` above. Grant the role `bedrock:InvokeModel` and `bedrock:InvokeModelWithResponseStream` on the models and inference profiles your agent uses.
{% endhint %}

### Rotate the CA

Update the Secret and ConfigMap, then restart the Deployment. Mounts that use `subPath` don't pick up Secret changes, and the agent's bundle is only built at pod start:

```bash
kubectl -n $NS create secret generic akto-egress-ca --from-file=mitmproxy-ca.pem=mitmproxy-ca.pem --dry-run=client -o yaml | kubectl -n $NS apply -f -
kubectl -n $NS create configmap akto-egress-ca-cert --from-file=mitmproxy-ca-cert.pem=ca.crt --dry-run=client -o yaml | kubectl -n $NS apply -f -
kubectl -n $NS rollout restart deploy/your-agent
```

### Troubleshooting

| Symptom | Cause | Fix |
| --- | --- | --- |
| `Init:CrashLoopBackOff`; the proxy logs `Read-only file system: ... mitmproxy-dhparam.pem` | The Secret is mounted over the whole `/home/mitmproxy/.mitmproxy` directory | Use the `emptyDir` plus `subPath` mounts shown above |
| `CERTIFICATE_VERIFY_FAILED` in the agent | The bundle variables aren't set, or the ConfigMap certificate doesn't match the Secret | Set `SSL_CERT_FILE`, `REQUESTS_CA_BUNDLE` and `AWS_CA_BUNDLE`, and recreate both from the same CA |
| `unknown field "restartPolicy"` | The cluster is older than 1.29 | Move `akto-egress-proxy` from `initContainers` to `containers`. The agent may then start before the proxy is ready, so retry early calls. |
| `ImagePullBackOff` | Nodes can't reach `public.ecr.aws` | Allow outbound access, for example through a NAT gateway |
| `[AKTO] URL: None` in the proxy logs | `AKTO_URL` isn't set in `akto-egress-config` | Update the ConfigMap and restart the Deployment |

## Supported AI Providers

By default, the proxy intercepts traffic only to these hosts; all other traffic passes through unmodified:

* `api.openai.com`
* `api.anthropic.com`
* `chatgpt.com`
* `bedrock-runtime.*.amazonaws.com` (Amazon Bedrock)
* `bedrock-agent-runtime.*.amazonaws.com` (Amazon Bedrock Agents and Knowledge Bases)

Other AWS traffic, such as S3 or STS, passes through without inspection.

A host is intercepted only if it is in both the `AI_HOSTS` list and the proxy's `--ignore-hosts` regex, which is in `docker-compose.yml` or your Kubernetes Deployment. To add a provider, update both.

1. Set `AI_HOSTS` to a comma-separated list of hosts, either as an environment variable for Docker Compose or in the `akto-egress-config` ConfigMap on Kubernetes. The value replaces the default list, so include every host you want intercepted:

   ```bash
   export AI_HOSTS="api.openai.com,api.anthropic.com,bedrock-runtime.*.amazonaws.com,api.mistral.ai"
   ```

2. Add the host to the first group in the `--ignore-hosts` regex, for example `|api\.mistral\.ai`.

{% hint style="info" %}
**All outbound traffic is routed through the proxy container**

Because `HTTP_PROXY` / `HTTPS_PROXY` are set on the agent container, every outbound request not listed in `NO_PROXY` — not just AI API calls — is sent through the mitmproxy process as a network hop. Mitmproxy only performs SSL interception and guardrail evaluation on the AI provider hosts listed above; all other traffic is tunnelled through without inspection.
{% endhint %}

## How Guardrails Work

See [Guardrail Schema](https://github.com/akto-api-security/Documentation/blob/agentic_security/akto-argus-agentic-ai-security-for-homegrown-ai/connectors/concepts/guardrail-schema.md) for the full data model and [Agent Guard](https://github.com/akto-api-security/Documentation/blob/agentic_security/akto-argus-agentic-ai-security-for-homegrown-ai/connectors/concepts/agent-guard.md) for how guardrails are evaluated against agentic traffic.

The proxy evaluates both the outbound request (prompt sent to the LLM) and the inbound response (LLM output) against Akto's guardrails. For each, Akto returns one of three decisions:

| Akto Decision                          | Proxy Behaviour                                                                                                                           |
| -------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| `Allowed: true`                        | Request or response forwarded unchanged                                                                                                   |
| `Modified: true`                       | Payload replaced with `ModifiedPayload` before forwarding                                                                                 |
| `Allowed: false` or `behaviour: block` | Returns `403` with `{"error": "<reason>"}` and header `X-Akto-Guardrails-Decision: blocked`; the LLM is never called on a blocked request |

## Guardrail Configuration

All guardrail policies are configured in the Akto dashboard — no proxy restart is required when policies change.

* [Create guardrail policies](https://github.com/akto-api-security/Documentation/blob/agentic_security/akto-argus-agentic-ai-security-for-homegrown-ai/connectors/how-to/create-guardrail-policies.md) — set up rules for prompt injection detection, PII filtering, disallowed topics, and response redaction
* [Manage guardrail policies](https://github.com/akto-api-security/Documentation/blob/agentic_security/akto-argus-agentic-ai-security-for-homegrown-ai/connectors/how-to/manage-guardrail-policies.md) — edit, clone, or delete existing policies
* [Enable or disable guardrails](https://github.com/akto-api-security/Documentation/blob/agentic_security/akto-argus-agentic-ai-security-for-homegrown-ai/connectors/how-to/enable-or-disable-guardrails.md) — toggle guardrails per policy without deleting them

Policies are scoped per app using the `APP_NAME` identifier set in your environment variables.

## Monitoring

All intercepted traffic is ingested into Akto (`ingest_data=true`) and visible in the dashboard under your `APP_NAME`:

* [Guardrail Activity](https://github.com/akto-api-security/Documentation/blob/agentic_security/akto-argus-agentic-ai-security-for-homegrown-ai/connectors/concepts/guardrail-activity.md) — view all guardrail events, decisions, and flagged payloads
* [Guardrail Activity — Detailed View](https://github.com/akto-api-security/Documentation/blob/agentic_security/akto-argus-agentic-ai-security-for-homegrown-ai/connectors/how-to/guardrail-activity-detailed-view.md) — inspect individual blocked or modified requests
* [Threat Dashboard](https://github.com/akto-api-security/Documentation/blob/agentic_security/akto-argus-agentic-ai-security-for-homegrown-ai/connectors/concepts/threat-dashboard.md) — monitor threat actors, IPs, and anomalous LLM usage patterns

## Get Support

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
