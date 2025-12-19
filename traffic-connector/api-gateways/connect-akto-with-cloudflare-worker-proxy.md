# Connect Akto with Cloudflare Worker Proxy

Cloudflare is a global network security platform that provides CDN, DDoS protection, and API security services. Integrating Cloudflare with Akto enables automatic discovery of all APIs passing through your Cloudflare infrastructure, helping you maintain continuous visibility and protection of your edge-distributed APIs.

<figure><img src="../../.gitbook/assets/image (11).png" alt=""><figcaption></figcaption></figure>

## Deployment Options

Choose the deployment approach that fits your needs:

### Option 1: Simple Traffic Mirroring (Basic Setup)

**Use this if you:**
- Want to start quickly with minimal setup
- Only need API discovery and monitoring
- Don't need MCP-specific security features
- Have a single worker to proxy

**What you get:**
- Automatic API discovery
- Request/response logging
- Traffic monitoring in Akto dashboard

**Setup:** Follow [Simple Traffic Mirroring Setup](#simple-traffic-mirroring-setup) below.

---

### Option 2: MCP Guardrails with Proxy (Advanced Security)

**Use this if you:**
- Need to protect MCP (Model Context Protocol) servers
- Want real-time threat detection and blocking

**What you get:**
- Everything from Option 1, plus:
- Real-time MCP security guardrails
- Two operational modes: Async (monitoring) or Blocked (active protection)

**Setup:** Follow [MCP Guardrails Proxy Setup](#mcp-guardrails-proxy-setup) below.

---

## Simple Traffic Mirroring Setup

This is a basic setup that mirrors traffic from one Cloudflare Worker to Akto for API discovery and monitoring.

> **Important Note:** This configuration works for proxying traffic to **one worker only**. The worker must have a service binding configured in the Cloudflare Worker Proxy with the variable name `MCP`. This binding is used to forward all incoming requests to your target worker.

### Step 1: Deploy the Akto Data-Ingestion Service

Before configuring the Cloudflare Worker Traffic Connector, you need to deploy the Akto Data-Ingestion Service. Ensure that the service is running and accessible via a publicly available URL.
Set up and configure Akto Traffic Processor. The steps are mentioned [here](https://docs.akto.io/getting-started/traffic-processor/hybrid-saas).
Ensure this instance is publicly accessible, as it will receive traffic logs from your Cloudflare Worker.

---

### Step 2: Set Up Your Cloudflare Worker Script

1. Navigate to the [Cloudflare Dashboard](https://dash.cloudflare.com/) and select your account.
2. Go to **Workers & Pages**.

   <figure><img src="../../.gitbook/assets/cloudflare_workers_pages.png" alt=""><figcaption></figcaption></figure>
3. Click **Create** and choose **Worker**.

   <figure><img src="../../.gitbook/assets/cloudflare-hello-world-worker.png" alt=""><figcaption></figcaption></figure>
4. Click the **Hello World** button and deploy it.

   <figure><img src="../../.gitbook/assets/cloudflare-hello-world-worker-deploy.png" alt=""><figcaption></figcaption></figure>
5. Click **Edit code** and replace the default script with your Worker code that proxies traffic and mirrors it to Akto using **service binding**.

    ```javascript
    export default {
        async fetch(request, env, ctx) {
        console.log("🚀 Worker handling:", request.method, request.url);

        // Detect WebSocket upgrade
        const upgradeHeader = request.headers.get("Upgrade") || "";
        const isWebSocket = upgradeHeader.toLowerCase() === "websocket";

        if (isWebSocket) {
            console.log("🔄 WebSocket upgrade detected");

            // Just proxy the connection
            const response = await env.MCP.fetch(request);

            // Clone headers only (no body to tee here)
            ctx.waitUntil(logTraffic(request, response, env, { isWebSocket: true }));

            return response;
        }

        // Normal HTTP(S) traffic
        let requestForFetch, requestForLog;
        if (request.body) {
            const [req1, req2] = request.body.tee();
            requestForFetch = new Request(request, { body: req1 });
            requestForLog = new Request(request, { body: req2 });
        } else {
            requestForFetch = request;
            requestForLog = request.clone();
        }

        const response = await env.MCP.fetch(requestForFetch);
        console.log("⬅️ Upstream response:", response.status);

        let responseForClient, responseForLog;
        if (response.body) {
            const [res1, res2] = response.body.tee();
            responseForClient = new Response(res1, response);
            responseForLog = new Response(res2, response);
        } else {
            responseForClient = response;
            responseForLog = response.clone();
        }

        ctx.waitUntil(logTraffic(requestForLog, responseForLog, env));

        return responseForClient;
        },
    };

    async function logTraffic(request, response, env, opts = {}) {
        try {
        console.log("📝 logTraffic running...");

        const reqContentType = request.headers.get("content-type") || "";
        const resContentType = response.headers.get("content-type") || "";
        const status = response.status;

        let reqBody = "";
        let resBody = "";

        if (!opts.isWebSocket) {
            // Only attempt to read bodies for HTTP
            reqBody = await readBodyAsText(request);
            resBody = await readBodyAsText(response);

            if (!(status >= 200 && status < 400)) {
            console.log("⚠️ Skipped log: status", status);
            return;
            }

            if (!reqContentType && !resContentType) {
            console.log("⚠️ Skipped log: no content-type in request or response");
            return;
            }

            if (!shouldCapture(reqContentType) && !shouldCapture(resContentType)) {
            console.log("⚠️ Skipped log: not a target content-type", { reqContentType, resContentType });
            return;
            }
        }

        const url = new URL(request.url);
        const logEntry = {
            path: url.pathname,
            method: request.method,
            requestHeaders: JSON.stringify(Object.fromEntries(request.headers)),
            responseHeaders: JSON.stringify(Object.fromEntries(response.headers)),
            requestPayload: reqBody,
            responsePayload: resBody,
            ip: request.headers.get("cf-connecting-ip") || "127.0.0.1",
            time: Math.floor(Date.now() / 1000).toString(),
            statusCode: status.toString(),
            type: opts.isWebSocket ? "WebSocket" : "HTTP/1.1",
            status: response.statusText || "OK",
            akto_account_id: "1000000",
            akto_vxlan_id: "0",
            is_pending: "false",
            source: "MIRRORING",
            tag: "{\n  \"service\": \"cloudflare\"\n}"
        };

        console.log("📤 Sending log entry to webhook...");

        const aktoReq = new Request("https://<DATA_INGESTION_SERVICE>/api/ingestData", {
            method: "POST",
            headers: { "content-type": "application/json" },
            body: JSON.stringify({ batchData: [logEntry] }),
        });

        // await env.<CONTAINER_BINDING_VARIABLE_NAME>.fetch(aktoReq);
        const aktoResp = await fetch(aktoReq);

        if (aktoResp.status == 200) {
            console.log("✅ Log sent to akto");
        } else {
            console.log("❌ Failed to send data to Akto. Response Status: " + aktoResp?.status);
        }
        } catch (err) {
        console.error("❌ Log error:", err);
        }
    }

    function shouldCapture(contentType) {
        const targets = ["json", "xml", "x-www-form-urlencoded", "soap", "grpc"];
        return targets.some((t) => contentType.toLowerCase().includes(t));
    }

    async function readBodyAsText(obj, maxSize = 64 * 1024) {
        try {
        const buf = await obj.arrayBuffer();
        const bytes = new Uint8Array(buf).slice(0, maxSize);
        return new TextDecoder().decode(bytes);
        } catch {
        return "";
        }
    }
    ```

#### Important Notes while editing the Worker code

* Replace `<DATA_INGESTION_SERVICE>` with the URL of the Akto Data-Ingestion Service you deployed in **Step 1**.
* If you are using Cloudflare **Service Binding** to send traffic to your ingestion service hosted inside a Cloudflare container, use the following line instead of a public URL:

  ```javascript
  // use this line to send data internally to data ingestion service
  // hosted in your Cloudflare container
  await env.<CONTAINER_BINDING_VARIABLE_NAME>.fetch(aktoReq);

  // for example
  await env.data_inject_worker.fetch(aktoReq);
  ```

---

### Step 3: Configure Service Binding (MCP)

After adding the worker code, you need to configure a service binding to connect this proxy worker to your target worker.

1. In the Cloudflare Dashboard, navigate to your **Worker** (the proxy worker you just created).
2. Go to **Settings** > **Bindings**.
3. Click **Add binding** and select **Service binding**.
4. Configure the binding with the following details:
   * **Variable name:** `MCP` (this must match the variable used in the worker code: `env.MCP.fetch()`)
   * **Service:** Select the target worker you want to proxy traffic to
   * **Environment:** Choose the appropriate environment

5. Click **Save**.

> **Note:** The variable name `MCP` is used in the worker code on lines where `env.MCP.fetch(request)` is called. This service binding routes all incoming requests to your specified target worker while mirroring the traffic to Akto.

---

### Step 4: Configure Worker Routing

If you'd like to route specific domains or paths through this Worker:

1. In the Cloudflare Dashboard, go to **Workers & Pages**.
2. Under **Overview**, select your Proxy Worker that you created in above steps.
3. Navigate to **Settings** > **Domains & Routes**.
4. Click **Add Route**.
5. Select the appropriate zone (domain), and enter a route pattern such as:

   ```
   *.yourdomain.com/*
   ```

This ensures all traffic matching the route is intercepted and mirrored to Akto.

---

### Step 5: Verify the Setup

1. Confirm that API traffic data (requests and responses) are captured on the Akto dashboard under the respective API collection.
2. Check logs of your Worker for any initialization or forwarding messages.
3. Go back to the [Akto Dashboard](https://app.akto.io/).
4. Navigate to **API Collections** > **Hostname**.
5. You should start seeing the traffic from your Cloudflare Worker.

---

## MCP Guardrails Proxy Setup

This advanced setup deploys a transparent proxy with MCP-specific security guardrails that can either monitor or actively block malicious traffic.

### Architecture Overview

The MCP Guardrails Proxy consists of three workers:

```
Client → akto-cloudflare-proxy (Proxy) → Your MCP Server
              ↓
         Validation/Ingestion
              ↓
    akto-ingest-guardrails (Main)
         ↙           ↘
    Executor      Container
    Worker        (Traffic)
         ↓             ↓
    ML Scans      Database
                  Abstractor
                      ↓
                 Akto Dashboard
```

**Workers:**
1. **akto-guardrails-executor** - Hosts ML container for security scanning (prompt injection, toxicity, PII, etc.)
2. **akto-ingest-guardrails** - Core validation and traffic ingestion worker
3. **akto-cloudflare-proxy** - Transparent proxy with async/blocked modes

---

### Prerequisites

- Node.js 18+ and npm
- Docker with buildx (for container images)
- Cloudflare account with Workers enabled
- Wrangler CLI: `npm install -g wrangler`
- Authenticated: `wrangler login`
- Cloudflare account ID (found in your dashboard)

---

### Deployment Steps

**IMPORTANT:** Deploy workers in this exact order due to service binding dependencies.

#### Step 1: Deploy akto-guardrails-executor

```bash
# Clone repository
git clone https://github.com/akto-api-security/akto-cloudflare-deployments.git
cd akto-cloudflare-deployments

# Switch to the blocked_mode_guardrails branch
git checkout feature/blocked_mode_guardrails

# Navigate to the executor worker
cd workers/akto-guardrails-executor

# Install dependencies
npm install

# Push container image
docker pull --platform linux/amd64 public.ecr.aws/aktosecurity/akto-agent-guard-executor:1.12.1_local
docker buildx build --platform linux/amd64 --load -t agent-guard-executor:testing - <<'EOF'
FROM public.ecr.aws/aktosecurity/akto-agent-guard-executor:1.12.1_local
EOF
npx wrangler containers push agent-guard-executor:testing

# Update wrangler.jsonc with your account ID, then deploy
npx wrangler deploy
```

#### Step 2: Deploy akto-ingest-guardrails

```bash
cd ../akto-ingest-guardrails
npm install

# Push MRS container image
docker pull --platform linux/amd64 aktosecurity/mini-runtime-service:latest
docker buildx build --platform linux/amd64 --load -t mrs:testing - <<'EOF'
FROM aktosecurity/mini-runtime-service:latest
EOF
npx wrangler containers push mrs:testing

# Set secrets (get token from Akto Dashboard → Quick Start → Hybrid Saas → Connect → eyJhbGciO.......ag97I5MeHg)
npx wrangler secret put DATABASE_ABSTRACTOR_SERVICE_TOKEN # (Akto Dashboard → Quick Start → Hybrid Saas → Connect → eyJhbGciO.......ag97I5MeHg)
npx wrangler secret put THREAT_BACKEND_TOKEN # (Akto Dashboard → Quick Start → Hybrid Saas → Connect → eyJhbGciO.......ag97I5MeHg)

# Update wrangler.jsonc with your account ID, then deploy
npx wrangler deploy
```

**wrangler.jsonc configuration:**
```jsonc
"vars": {
  "DATABASE_ABSTRACTOR_SERVICE_URL": "https://cyborg.akto.io",
  "THREAT_BACKEND_URL": "https://tbs.akto.io",
  "ENABLE_MCP_GUARDRAILS": "true"
}
```

#### Step 3: Deploy akto-cloudflare-proxy

```bash
cd ../akto-cloudflare-proxy
npm install

# Update wrangler.jsonc - configure service bindings and mode
npx wrangler deploy
```

**wrangler.jsonc configuration:**

1. **Configure service bindings:**
```jsonc
"services": [
  {
    "binding": "MCP",
    "service": "your-mcp-server-name"  // Replace with your actual MCP server
  },
  {
    "binding": "AKTO_GUARDRAILS",
    "service": "akto-ingest-guardrails"
  },
  {
    "binding": "AKTO_INGEST_GUARDRAILS",
    "service": "akto-ingest-guardrails"
  }
]
```

2. **Choose guardrails mode:**
```jsonc
"vars": {
  "GUARDRAILS_MODE": "async"  // or "blocked"
}
```

3. **Configure routes (optional):**
```jsonc
"routes": [
  {
    "pattern": "mcp.yourdomain.com/*",
    "zone_name": "yourdomain.com"
  }
]
```

> **Note:** Routes are optional. If not configured, use the workers.dev URL for testing.

---

### Modes: Async vs Blocked

#### Async Mode (Monitoring)
```jsonc
"vars": {
  "GUARDRAILS_MODE": "async"
}
```

**Behavior:**
- ✅ All traffic passes through to your MCP server
- ✅ Threats are detected and reported to Akto dashboard
- ✅ Zero impact on latency
- ❌ Malicious requests are NOT blocked

**Use Case:** Production monitoring, threat intelligence gathering, compliance auditing

**Log Example:**
```
🚀 Worker handling: POST https://mcp.yourdomain.com/message
🔧 Guardrails mode: async
📤 [Async Mode] Forwarding request without validation
⬅️ Upstream response: 200
📝 logTraffic running...
✅ Log sent
```

---

#### Blocked Mode (Active Protection)
```jsonc
"vars": {
  "GUARDRAILS_MODE": "blocked"
}
```

**Behavior:**
- ✅ Requests validated before reaching MCP server
- ✅ Malicious requests blocked with JSON-RPC error response (HTTP 200)
- ✅ Threats reported to Akto dashboard
- ✅ Traffic data ingested to Akto
- ⚠️ Fail-open: If validation times out, traffic is allowed

**Use Case:** High-security environments, preventing prompt injection, protecting sensitive tools

**Log Example (Success):**
```
🚀 Worker handling: POST https://mcp.yourdomain.com/message
🔧 Guardrails mode: blocked
🛡️ [Blocked Mode] Starting validation flow
🔍 [Blocked Mode] Phase 1: Validating request
✅ [Blocked Mode] Request validation passed
📤 [Blocked Mode] Phase 2: Forwarding to MCP server
⬅️ [Blocked Mode] MCP response: 200
```

**Log Example (Blocked):**
```
🚫 [Blocked Mode] Request BLOCKED: Blocked by scanner: PromptInjection (risk score: 1)
```

**Blocked Response Format (JSON-RPC 2.0 compliant):**
```json
{
  "jsonrpc": "2.0",
  "id": null,
  "error": {
    "code": -32000,
    "message": "Request blocked by security policy",
    "data": {
      "reason": "Blocked by scanner: PromptInjection (risk score: 1)",
      "blockedBy": "Akto-Guardrails"
    }
  }
}
```

---

### Verification

After deployment, verify everything is working:

```bash
# Check all deployments
npx wrangler deployments list

# View logs for each worker
npx wrangler tail akto-guardrails-executor
npx wrangler tail akto-ingest-guardrails
npx wrangler tail akto-cloudflare-proxy

# Test your MCP endpoint
curl https://mcp.yourdomain.com/
```

**Verify in Akto Dashboard:**
1. Go to [Akto Dashboard](https://app.akto.io/)
2. Navigate to **Agentic Security** → **Agentic Collections** → **Hostname**
3. Verify traffic is being captured
4. Check **Agentic Guardrails** for threat detections (if using blocked/async mode)

---

### Mode Comparison

| Feature | Async Mode | Blocked Mode |
|---------|------------|--------------|
| Traffic Monitoring | ✅ | ✅ |
| Threat Detection | ✅ | ✅ |
| Threat Blocking | ❌ | ✅ |
| Original Payload Reporting | ✅ | ✅ |
| Fail-Open | ✅ Yes | ✅ Yes |

---

### Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support — message us inside the Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Reach us [here](https://www.akto.io/contact-us).