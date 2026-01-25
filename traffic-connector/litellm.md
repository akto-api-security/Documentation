# Connect Akto with LiteLLM

LiteLLM is a unified interface for calling 100+ LLM APIs in a consistent format. This setup is recommended if you want to monitor API traffic from your LiteLLM proxy and ensure your AI-powered applications maintain security standards.

The Akto LiteLLM connector automatically:

* Validates AI requests and responses against security policies
* Detects PII, prompt injection, and policy violations
* Ingests traffic into Akto for monitoring and analysis
* Blocks malicious requests (sync mode) or logs violations (async mode)

## Prerequisites

Before integrating Akto with LiteLLM, ensure you have:

* Existing LiteLLM proxy installation (running or ready to configure)
* Akto guardrails service endpoint (URL and authentication token)

## Step 1: Download the Custom Hook

Download the `custom_hooks.py` file to your LiteLLM configuration directory:

```bash
# Navigate to your LiteLLM config directory
cd /path/to/your/litellm/config

# Download the hook file
curl -O https://raw.githubusercontent.com/akto-api-security/akto/master/apps/mcp-endpoint-shield/litellm/custom_hooks.py
```

## Step 2: Configure Environment Variables

Add these environment variables to your LiteLLM environment (`.env` file or system environment):

```bash
LITELLM_URL=http://your-litellm-instance-url

# Akto's Data Ingestion Service URL
DATA_INGESTION_SERVICE_URL=http://data-ingestion-service-url

# Optional: Operation Mode
SYNC_MODE=true              # true = block violations, false = async logging only, default true
```

**Note:** `SYNC_MODE` determines behavior:
* `SYNC_MODE=true`: Requests are validated BEFORE being sent to the LLM. Violations block the request immediately.
* `SYNC_MODE=false`: Requests proceed immediately, validation happens in background.

## Step 3: Update LiteLLM Configuration

Edit your `config.yaml` to enable the custom hook:

```yaml
model_list:
  # Your existing models

litellm_settings:
  callbacks: [custom_hooks.proxy_handler_instance]  # ← Add this line
  drop_params: true
  set_verbose: false
  request_timeout: 600
  num_retries: 2

# ... rest of your config ...
```

The critical change is adding `callbacks: [custom_hooks.proxy_handler_instance]` to activate the Akto guardrails hook.

## Step 4: Ensure Hook File is Accessible

**If using Docker**, mount the hook file in your docker-compose.yaml:

```yaml
services:
  litellm:
    image: docker.litellm.ai/berriai/litellm:main-stable
    volumes:
      - ./config.yaml:/app/config.yaml
      - ./custom_hooks.py:/app/custom_hooks.py
    environment:
      - DATA_INGESTION_SERVICE_URL=${DATA_INGESTION_SERVICE_URL}
      - SYNC_MODE=${SYNC_MODE}
    # ... rest of config ...
```

**If running LiteLLM directly**, ensure `custom_hooks.py` is in the same directory as config.yaml:

```bash
# Set environment variables
export DATA_INGESTION_SERVICE_URL=http://data-ingestion-service-url
export SYNC_MODE=true

# Start LiteLLM
litellm --config config.yaml
```

## Step 5: Start LiteLLM

```bash
# If using Docker Compose
docker-compose restart litellm

# If using Docker run
docker restart litellm-container

# If running directly
# Stop LiteLLM (Ctrl+C) and restart:
litellm --config config.yaml
```

## Step 6: Verify Integration

Check that LiteLLM starts successfully with the hook:

```bash
# Check logs for hook initialization
docker-compose logs litellm | grep GuardrailsHandler

# Expected output:
# GuardrailsHandler initialized | sync_mode=True, timeout=5
```

Send a test request:

```bash
curl -X POST http://localhost:4000/chat/completions \
  -H "Authorization: Bearer YOUR_LITELLM_MASTER_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gpt-4",
    "messages": [{"role": "user", "content": "Hello!"}]
  }'
```

Verify in Akto dashboard:
* Log into your Akto dashboard
* Navigate to Collections section
* Verify you see requests from LiteLLM appearing

## How It Works

### Request Flow (SYNC_MODE=true)

```
1. Client → LiteLLM Proxy
2. Hook intercepts request (pre-call hook)
3. Request sent to Akto Data Ingestion Service API
4. Data Ingestion Service validates against policies
   ├─ If BLOCKED: Return error to client (LLM never called)
   └─ If ALLOWED: Continue to step 5
5. Request forwarded to LLM Provider
6. LLM response received
7. Hook intercepts response (post-call hook)
8. Response sent to Akto Data Ingestion Service API
9. Data Ingestion Service validates response
   ├─ If BLOCKED: Return error to client
   └─ If ALLOWED: Return response to client
```

### Request Flow (SYNC_MODE=false)

```
1. Client → LiteLLM Proxy
2. Hook starts background validation task (non-blocking)
3. Request immediately forwarded to LLM Provider
4. Response returned to client
5. Validation completes in background (violations logged only)
```

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
