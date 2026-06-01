# Connect Akto with Kong

Discover and monitor every API flowing through your **Kong API Gateway** with Akto. The `akto-api-discovery` plugin captures request and response metadata from traffic passing through Kong and asynchronously ships it to Akto's ingest service for automatic API discovery, schema inference, sensitive data detection, and security testing. The plugin is built around a strict guarantee: **it never affects the original request, response, status code, or latency** — even if the Akto backend is slow or completely unreachable.

<figure><img src="../../.gitbook/assets/image (92).png" alt="Kong API Discovery"><figcaption></figcaption></figure>

## Prerequisites

Before you begin, make sure you have:

* Kong Gateway **2.0 or later** already running with your services and routes configured
* Access to Kong's Admin API (default: `http://localhost:8001`)
* A server or Kubernetes cluster to host the Akto ingest backend
* Your **Akto API Token** (available from your Akto dashboard → Quick Start → Hybrid SaaS → Connect → Copy your `databaseAbstractorToken`)

***

## Step 1: Install the Plugin in Kong

{% stepper %}
{% step %}
**Download the Plugin Files**

Clone the Akto Kong integration repository:

```bash
git clone https://github.com/akto-api-security/kong-integration.git
cd kong-integration
```

Inside the `api_plugin/` directory you will find two files:

* `handler.lua` — plugin logic
* `schema.lua` — configuration schema

{% hint style="info" %}
You only need these two files. Nothing else from the repository is required for the plugin itself.
{% endhint %}
{% endstep %}

{% step %}
**Copy the Plugin Files into Kong**

Create the plugin directory inside Kong and copy both files into it:

```bash
mkdir -p /usr/local/share/lua/5.1/kong/plugins/akto-api-discovery

cp api_plugin/handler.lua /usr/local/share/lua/5.1/kong/plugins/akto-api-discovery/
cp api_plugin/schema.lua  /usr/local/share/lua/5.1/kong/plugins/akto-api-discovery/
```

**Using Docker?** Mount the plugin directory as a volume instead:

```yaml
volumes:
  - /path/to/kong-integration/api_plugin:/usr/local/share/lua/5.1/kong/plugins/akto-api-discovery:ro
```

{% endstep %}

{% step %}
**Register the Plugin with Kong**

Add `akto-api-discovery` to Kong's plugins list. How you do this depends on how Kong is configured:

**Via `kong.conf`:**

```
plugins = bundled,akto-api-discovery
```

**Via environment variable:**

```bash
KONG_PLUGINS=bundled,akto-api-discovery
```

{% hint style="info" %}
If you are using Docker Compose, set this as an environment variable on the Kong service.
{% endhint %}
{% endstep %}

{% step %}
**Restart Kong**

```bash
kong restart
```

Or if using Docker:

```bash
docker compose restart kong
```

{% endstep %}
{% endstepper %}

***

## Step 2: Enable the Plugin on Your Service or Route

You can attach the plugin to a specific service, a specific route, or globally across all traffic.

**Enable on a specific service** (recommended — scopes discovery to one upstream service):

```bash
curl -X POST http://localhost:8001/services/<YOUR_SERVICE_NAME>/plugins \
  --data "name=akto-api-discovery" \
  --data "config.service_url=http://<AKTO_INGEST_URL>"
```

**Enable on a specific route:**

```bash
curl -X POST http://localhost:8001/routes/<YOUR_ROUTE_NAME>/plugins \
  --data "name=akto-api-discovery" \
  --data "config.service_url=http://<AKTO_INGEST_URL>"
```

**Enable globally** (monitors all traffic through Kong):

```bash
curl -X POST http://localhost:8001/plugins \
  --data "name=akto-api-discovery" \
  --data "config.service_url=http://<AKTO_INGEST_URL>"
```

Replace `<AKTO_INGEST_URL>` with your Akto ingest service URL:

* **If Akto provided you a URL** (e.g., `https://17*******0-ingest.akto.io`), use that directly.
* **Otherwise**, complete Step 3 to self-host the backend and use the URL you get from there.

{% hint style="info" %}
**Configuration Parameters**
{% endhint %}

| Parameter     | Required | Default | Description                                                                                                            |
| ------------- | -------- | ------- | ---------------------------------------------------------------------------------------------------------------------- |
| `service_url` | Yes      | —       | Base URL of your deployed Akto ingest backend (e.g., `http://10.0.1.4:8080`). The plugin POSTs to `/api/ingestData`.   |
| `timeout`     | No       | `30000` | Request timeout in milliseconds for the async ingest call. The plugin enforces a hard cap regardless of this value.    |
| `log_level`   | No       | `warn`  | One of `debug`, `info`, `warn`, `error`. Keep at `warn` in production; use `info` or `debug` only for troubleshooting. |

You can also configure the plugin via **Kong Manager UI**: go to **Plugins → New Plugin → search for `akto-api-discovery`**.

***

## Step 3: Deploy the Akto Ingest Backend

{% hint style="info" %}
If you already have the Akto ingest backend deployed (or have been given a `service_url` by your team), skip this step and use that URL directly in Step 2.
{% endhint %}

The ingest backend is a set of services that receive traffic metadata from the Kong plugin and store it for API discovery and analysis. You can deploy it using **Docker Compose** (any Linux VM) or **Helm** (Kubernetes).

### Option A: Docker Compose — Any Linux VM

This is the fastest way to get started. You need a Linux server with at least **4 vCPUs and 8 GB RAM**.

The deployment files are available at:\
`https://github.com/akto-api-security/infra/tree/feature/quick-setup/guardrail-service-e2e-setup`

{% stepper %}
{% step %}
**Clone the Setup Repository**

```bash
git clone -b feature/quick-setup https://github.com/akto-api-security/infra.git
cd infra/guardrail-service-e2e-setup
```

{% endstep %}

{% step %}
**Set Up Environment Files**

Navigate into the `docker-compose` folder, then copy each template and fill in your Akto API token:

```bash
cd docker-compose

# Kafka IP (only variable substituted by docker-compose itself)
cp .env.example .env
# Edit .env — set AKTO_KAFKA_IP to your server's private IP

# Service env files — copy each template and replace <YOUR_AKTO_API_TOKEN>
cp docker-mini-runtime.env.template     docker-mini-runtime.env
cp data-ingestion-docker.env.template   data-ingestion-docker.env
```

Open each `.env` file you just created and replace every `<YOUR_AKTO_API_TOKEN>` with your token from the Akto dashboard (Settings → API Tokens).

{% hint style="warning" %}
Never publish `.env` files in public — they contain your API token.
{% endhint %}
{% endstep %}

{% step %}
**Start the Services**

```bash
docker compose up -d
```

This starts the following services:

| Service                     | Port | Purpose                                                                |
| --------------------------- | ---- | ---------------------------------------------------------------------- |
| `zoo1`                      | 2181 | ZooKeeper (Kafka coordination)                                         |
| `kafka1`                    | 9092 | Kafka message broker                                                   |
| `akto-api-security-runtime` | —    | Processes API traffic from Kafka for discovery and schema inference    |
| `data-ingestion-service`    | 8080 | Receives traffic from Kong and ingests it — **this is the plugin endpoint** |

{% endstep %}

{% step %}
**Verify All Services Are Running**

```bash
docker compose ps
```

All services should show status `Up`. If any are restarting, check their logs:

```bash
docker compose logs data-ingestion-service
docker compose logs akto-api-security-runtime
```

Test the ingest endpoint directly:

```bash
curl -sf http://localhost:8080/health && echo "data-ingestion OK"
```

{% endstep %}

{% step %}
**Update the Kong Plugin with the Service URL**

Your ingest service is now available at `http://<YOUR_SERVER_IP>:8080`. Update the Kong plugin configuration:

```bash
# Update an existing plugin (replace <PLUGIN_ID> with your plugin's ID)
curl -X PATCH http://localhost:8001/plugins/<PLUGIN_ID> \
  --data "config.service_url=http://<YOUR_SERVER_IP>:8080"
```

Or if you haven't enabled the plugin yet, use this URL in the Step 2 commands above.

{% hint style="info" %}
If your Kong instance and ingest server are on different networks, make sure port `8080` is accessible from the Kong host. If you want HTTPS, place a reverse proxy (nginx, Caddy) or load balancer in front of the ingest service.
{% endhint %}
{% endstep %}
{% endstepper %}

***

### Option B: Kubernetes (Helm Charts)

Use this option if your infrastructure runs on Kubernetes.

{% stepper %}
{% step %}
**Add the Akto Helm Repository**

```bash
helm repo add akto https://akto-api-security.github.io/helm-charts
helm repo update
```

{% endstep %}

{% step %}
**Install the Charts in Order**

Deploy the following two charts **in the exact order shown**. The second chart depends on the first.

**Chart 1 — Database Abstractor**

Sets up the data access layer.

```bash
helm install akto-database-abstractor akto/akto-setup-database-abstractor \
  -n <NAMESPACE> \
  --set mongo.aktoMongoConn="<MONGODB_CONNECTION_STRING>"
```

**Chart 2 — Data Ingestion + Runtime**

Processes and stores the traffic captured by the Kong plugin.

```bash
helm install akto-mrs-runtime-combined akto/akto-mrs-runtime-combined \
  -n <NAMESPACE> \
  --set mini_runtime.aktoApiSecurityRuntime.env.databaseAbstractorUrl="https://ultron.akto.io" \
  --set mini_runtime.aktoApiSecurityRuntime.env.databaseAbstractorToken="<YOUR_AKTO_API_TOKEN>" \
  --set mini_runtime.aktoApiSecurityRuntime.env.aktoLogLevel="INFO"
```

{% endstep %}

{% step %}
**Verify All Pods Are Running**

```bash
kubectl get pods -n <NAMESPACE>
```

You should see pods for both charts in `Running` status. If any pod is stuck in `CrashLoopBackOff` or `Pending`, check its logs:

```bash
kubectl logs -n <NAMESPACE> <POD_NAME>
```

{% endstep %}

{% step %}
**Get the Ingest Service URL**

```bash
kubectl get services -n <NAMESPACE> | grep data-ingestion
```

Use the service's `CLUSTER-IP` (for in-cluster access) or set up an `Ingress` / `LoadBalancer` service for external access. Update the Kong plugin `config.service_url` with this URL.
{% endstep %}
{% endstepper %}

***

## How the Plugin Works

The plugin is intentionally minimal on the request path and does all heavy work in the background.

| Phase          | What happens                                                                                                                                                                                |
| -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `access`       | Opportunistically reads the request body **only if Kong has already buffered it**. Never forces buffering — that would add upload-time latency.                                             |
| `body_filter`  | Copies response bytes already in nginx's memory into a small buffer. Never modifies the bytes sent to the client. Capped at 256 KB per response.                                            |
| `log`          | Runs **after** the response is fully sent to the client. Snapshots metadata and fires an `ngx.timer.at(0,...)` callback. All JSON encoding and the HTTP call to Akto happen inside that timer. |
| Async timer    | Detached light-thread. Posts to `<service_url>/api/ingestData`. Uses aggressive timeouts (3s connect, 5s send, 3s read) and an in-flight cap of 20 timers so a slow Akto can never build a backlog. |

**Latency impact: near zero.** In paired benchmarks against an identical backend, the plugin adds **+0.03 ms at p50, +1.96 ms at p95, and +5.19 ms at p99**. Per individual paired request, the plugin is "slower" only 52% of the time — statistically indistinguishable from baseline.

**Fail-open by design.** Every phase is wrapped in `pcall`. If Akto is unreachable, the timer fails inside its detached coroutine and is silently dropped — your client traffic is never affected, never delayed, never blocked.

***

## Verify the Integration

After setup, send a test request through Kong (use the port Kong is listening on in your environment):

```bash
curl -X GET http://<KONG_HOST>:<KONG_PROXY_PORT>/<YOUR_ROUTE>
```

Check Kong logs to confirm the plugin is active. Set `KONG_LOG_LEVEL=info` (or set `config.log_level=info` on the plugin) to see per-request logs:

```bash
# Docker
docker compose logs kong | grep "\[akto-api\]"

# Kubernetes
kubectl logs -n <NAMESPACE> <KONG_POD_NAME> | grep "\[akto-api\]"
```

You should see lines like:

```
[akto-api] [async] → GET /your-route 200
[akto-api] [async] ingest ok
```

Once the data is flowing, your discovered APIs will start appearing in the **Akto Dashboard → Inventory** within a few minutes.

***

## Troubleshooting

**Plugin not loading after restart**\
Verify that `akto-api-discovery` appears in `KONG_PLUGINS` and that both `handler.lua` and `schema.lua` are present in the correct directory. Run `kong check` to validate the configuration.

**`[akto-api] [async] connect failed (Akto unreachable)`**\
The ingest service is not reachable from Kong within the 3-second connect timeout. Check:

1. The `config.service_url` is correct and reachable from the Kong host
2. Firewall/NSG rules allow traffic on port `8080` (or your configured port)
3. The hostname resolves correctly inside Kong's container (use the container's internal hostname, not `localhost`, when both run in Docker)

**`[akto-api] ingest dropped — N timers in-flight`**\
The plugin's in-flight timer guard fired (max 20 concurrent ingests per worker). This usually means the Akto ingest backend is slow or unreachable. Your client traffic is **not affected** — only some ingest samples are dropped. Investigate the ingest backend's health.

**No `[akto-api]` lines in Kong logs**\
The plugin defaults to `log_level=warn`, which only logs failures. To see per-request `[async] ingest ok` lines, set `config.log_level=info` on the plugin. Also ensure `KONG_LOG_LEVEL=info` (or lower) in Kong itself.

**Request body is empty in ingested data**\
By design, the plugin does not force request-body buffering — doing so would add upload-time latency to every POST/PUT/PATCH request. The request body is captured only when another plugin or Kong itself has already buffered it. Response body, headers, method, path, and status code are always captured.

***

## Get Support

* Raise an issue in the [Kong Integration GitHub repository](https://github.com/akto-api-security/kong-integration)
* Contact the team via Slack or your assigned support channel
* For enterprise support, email the engineering team with your Kong version, plugin version, and relevant log snippets
