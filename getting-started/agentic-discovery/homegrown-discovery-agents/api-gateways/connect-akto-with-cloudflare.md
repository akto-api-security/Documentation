# Connect Akto with Cloudflare

Cloudflare is a global network security platform that provides CDN, DDoS protection, and API security services. Integrating Cloudflare with Akto will enable automatic discovery of all APIs passing through your Cloudflare infrastructure, helping you maintain continuous visibility and protection of your edge-distributed APIs.

<figure><img src="../../../../.gitbook/assets/image (11).png" alt=""><figcaption></figcaption></figure>

To connect Akto with Cloudflare, follow these steps -

## Step 1: Deploy the Akto Data-Ingestion Service

Before configuring the Cloudflare Worker Traffic Connector, you need to deploy the Akto Data-Ingestion Service. Ensure that the service is running and accessible via a publicly available URL.\
Set up and configure Akto Traffic Processor. The steps are mentioned [here](../../../hybrid-saas.md).\
Ensure this instance is publicly accessible, as it will receive traffic logs from your Cloudflare Worker.

***

## Step 2: Set Up Your Cloudflare Worker Script

1. Navigate to the [Cloudflare Dashboard](https://dash.cloudflare.com/) and select your account.
2.  Go to **Workers & Pages**.

    <figure><img src="../../../../.gitbook/assets/cloudflare_workers_pages.png" alt=""><figcaption></figcaption></figure>
3.  Click **Create** and choose **Worker**.

    <figure><img src="../../../../.gitbook/assets/cloudflare-hello-world-worker.png" alt=""><figcaption></figcaption></figure>
4.  Click the **Hello World** button and deploy it.

    <figure><img src="../../../../.gitbook/assets/cloudflare-hello-world-worker-deploy.png" alt=""><figcaption></figcaption></figure>
5. Click **Edit code** and replace the default script with the following example:

```javascript
export default {
  async fetch(request, env, ctx) {
    const [reqForFetch, reqForCollector] = await duplicateRequest(request); // At the starting of your fetch method
    const backendResponse = await fetch(reqForFetch);
    return collectTraffic(reqForCollector, backendResponse, env, ctx); // just after getting response
  },
};

async function duplicateRequest(request) {
  if (!request.body) {
    return [request, request.clone()];
  }
  const [stream1, stream2] = request.body.tee();
  const req1 = new Request(request, { body: stream1 });
  const req2 = new Request(request, { body: stream2 });
  return [req1, req2];
}

function collectTraffic(request, backendResponse, env, ctx) {
  const contentType = (request.headers.get("content-type") || "").toLowerCase();
  const isAllowed = isAllowedContentType(contentType);
  const shouldCapture = isAllowed && isValidStatus(backendResponse.status);

  if (!shouldCapture) return backendResponse;

  // Split response stream
  let responseForClient = backendResponse;
  let responseForLogging = null;

  if (backendResponse.body) {
    const [respStream1, respStream2] = backendResponse.body.tee();

    // Return one response to client
    responseForClient = new Response(respStream1, {
      headers: backendResponse.headers,
      status: backendResponse.status,
      statusText: backendResponse.statusText
    });

    // Keep the other for logging
    responseForLogging = respStream2;
  }

  ctx.waitUntil((async () => {
    let requestBody = "";
    if (request.body) requestBody = await streamToString(request.body);
    let responseBody = "";
    if (responseForLogging) responseBody = await streamToString(responseForLogging);
    await sendToAkto(request, requestBody, backendResponse, responseBody, env);
  })());

  return responseForClient;
}

function isAllowedContentType(contentType) {
  const allowedTypes = [
    "application/json",
    "application/xml",
    "text/xml",
    "application/grpc",
    "application/x-www-form-urlencoded",
    "application/soap+xml"
  ];
  return allowedTypes.some(type => contentType.includes(type));
}

function isValidStatus(status) {
  return (status >= 200 && status < 300) || [301, 302, 304].includes(status);
}

async function streamToString(stream) {
  const reader = stream.getReader();
  const decoder = new TextDecoder();
  let result = "";
  while (true) {
    const { done, value } = await reader.read();
    if (done) break;
    result += decoder.decode(value, { stream: true });
  }
  return result;
}

async function sendToAkto(request, requestBody, response, responseBody, env) {
  const aktoAPI = "https://<your-ingestion-service-address>/api/ingestData";
  const logs = generateLog(request, requestBody, response, responseBody);
  const aktoRequest = new Request(aktoAPI, {
    method: "POST",
    body: logs,
    headers: { "Content-Type": "application/json", "x-api-key": "<YOUR_AKTO_API_KEY>" },
  });
  const aktoResponse = await env.data_ingest_worker.fetch(aktoRequest);
  if (aktoResponse.status === 400) {
    console.error(`Akto response: ${aktoResponse.status} ${aktoResponse.statusText}, Body: ${await aktoResponse.text()}`);
  }
}

function generateLog(req, requestBody, res, responseBody) {
  const url = new URL(req.url);
  const value = {
    path: url.pathname,
    requestHeaders: JSON.stringify(Object.fromEntries(req.headers)),
    responseHeaders: JSON.stringify(Object.fromEntries(res.headers)),
    method: req.method,
    requestPayload: requestBody,
    responsePayload: responseBody,
    ip: req.headers.get("x-forwarded-for") || req.headers.get("cf-connecting-ip") || req.headers.get("x-real-ip") || "",
    time: Math.round(Date.now() / 1000).toString(),
    statusCode: res.status.toString(),
    type: "HTTP/1.1",
    status: res.statusText,
    akto_account_id: "1000000",
    akto_vxlan_id: "0",
    is_pending: "false",
    source: "MIRRORING",
    tag: "{\n  \"service\": \"cloudflare\"\n}"
  };
  return JSON.stringify({ batchData: [value] });
}
```

***

## Step 3: Configure Worker Routing

If you'd like to route specific domains or paths through this Worker:

1. In the Cloudflare Dashboard, go to **Workers & Pages**.
2. Under **Overview**, select your Worker.
3. Navigate to **Settings** > **Domains & Routes**.
4. Click **Add Route**.
5.  Select the appropriate zone (domain), and enter a route pattern such as:

    ```
    *.yourdomain.com/*
    ```

This ensures all traffic matching the route is intercepted and mirrored to Akto.

***

## Step 4: Verify the Setup

1. Confirm that agent traffic data (requests and responses) are captured on the Akto dashboard under the respective api collection.
2. Check logs of your Lambda function for any initialization messages from the extension.
3. Go back to the [Akto Dashboard](https://app.akto.io/).
4. Navigate to **Api Collections** > **Hostname**.
5. You should start seeing the agent traffic from your Cloudflare Worker.

***

### Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
