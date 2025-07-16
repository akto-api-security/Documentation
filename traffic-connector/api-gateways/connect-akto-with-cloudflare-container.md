# Connect Akto with Cloudflare Container

(Traffic Connector Worker on CloudFlare sending traffic data to IngestData API in CloudFlare Container to enable API discovery)

Cloudflare is a global network security platform that provides CDN, DDoS protection, and API security services. Integrating Cloudflare with Akto will enable automatic discovery of all APIs passing through your Cloudflare infrastructure, helping you maintain continuous visibility and protection of your edge-distributed APIs.

<figure><img src="../../.gitbook/assets/image (11).png" alt=""><figcaption></figcaption></figure>

To connect Akto with Cloudflare, follow these steps -

## Step 1: Deploy the Akto Mini-Runtime-Service as Cloudflare Container

Before configuring the Cloudflare Worker Traffic Connector, you need to deploy the Akto Mini-Runtime Service. 

1. The Akto-Mini-Runtime-Service is a container that runs on Cloudflare and is responsible for receiving traffic logs from the Cloudflare Worker.
2. Docker-image for the Akto Mini-Runtime Service will be available to be configured.


Deploying Docker Image as Container on Cloudflare :

1. Make Cloudflare Account . Buy Workers Paid Plan to deploy containers through worker.

2. Go to terminal of your system and configure to access cloud flare account by exporting cloud flare API token.

You need to create Account API Token by visiting https://dash.cloudflare.com/53a10bdb35f546522193c9670ad3e7e5/api-tokens

Create token with below permissions :
Containers:Edit, Queues:Edit, Workers R2 Storage:Edit, Workers Tail:Read, Workers KV Storage:Edit, Workers Scripts:Edit,
 Workers Scripts:Read, Account Settings:Read

Add below command in terminal :
export CLOUDFLARE_API_TOKEN=<Your-Cloudflare-API-Token>

wrangler whoami  - Command to check locally the account you are pointing to.

3. Create first project through terminal with below command :

npm create cloudflare@latest -- --template=cloudflare/templates/containers-template

The template will create a folder with below file content :

Dockerfile			container_src			package-lock.json		src				worker-configuration.d.ts
README.md			node_modules			package.json			tsconfig.json			wrangler.jsonc

* Wrangler.json - is the imp file where details of our account where container is to be deployed and docker image details are present.
* src/index.ts - This is the the startup file and we configure our api endpoint in this file which is inside docker image and needs to be called.

4. Push the existing mini-runtime-service image on cloudflare registry

docker pull --platform linux/amd64 aktosecurity/mini-runtime-service:mrs   - Pull from docker hub
docker tag aktosecurity/mini-runtime-service:mrs mrs:testing      - Tag with any name apart from ‘latest’

For wranglers containers push command to work, make a folder with a file wrangler.jsonc and add the below details, then run the push command.

{
"name": "akto-mini-runtime-1",
"account_id": "53a10bdb35f546522193c9670ad3e7e5",
"compatibility_date": "2025-07-11",
"container": {
"image": "mrs:testing"
}
}


wrangler containers push mrs:testing      - push it in cloudflare registry

You will see below output :

Login Succeeded
The push refers to repository [registry.cloudflare.com/53a10bdb35f546522193c9670ad3e7e5/akto-mini-runtime]


This is the path of image to be configured in wrangler.jsonc - registry.cloudflare.com/53a10bdb35f546522193c9670ad3e7e5/akto-mini-runtime:latest



5. Now in the initial project made of cloud flare do the below change in wrangler.jsonc


     "containers": [
                {
                        "class_name": "MyContainer",
                        "image": "registry.cloudflare.com/53a10bdb35f546522193c9670ad3e7e5/mrs:testing",
                        "max_instances": 10,
                        "instance_type": "standard",
                        "name": "hello-containers"
                }
        ]


6. Below changes in src/index.ts

import { Container, loadBalance, getContainer } from "@cloudflare/containers";
import { Hono } from "hono";

export class MyContainer extends Container {
// Port the container listens on (default: 8080)
defaultPort = 8080;
// Time before container sleeps due to inactivity (default: 30s)
sleepAfter = "2h";
// Environment variables passed to the container
envVars = {
MESSAGE: "I was passed in via the container class!",
AKTO_LOG_LEVEL: "DEBUG",
DATABASE_ABSTRACTOR_SERVICE_TOKEN: "eyJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJBa3RvIiwic3ViIjoiaW52aXRlX3VzZXIiLCJhY2NvdW50SWQiOjE3NDg4MDU3NTQsImlhdCI6MTc1MjQ5NzA4NiwiZXhwIjoxNzY4Mzk0Njg2fQ.Z8tu1eOv9LQVpiMQp6L_P-VIyNtODAJIUtNWNOidwZ-AFcj1SBtJTc0G05UAoVxOCE1MsZQwOpbLB3Ci_b7S7OYco40opx3GumKLmOcTChplvGR8tMOEjut7B-j--y99r9g0i0UhCiuk64yDmVjBcLKRiX_0J9GBgMcy14lkFeIQQ5o6FnAXxQd27agireZPR6qQb0PZku5V_b-5E9Am65cLwmUmqyRzSshn1aL1RgXUb1Fo93x-XLtyn4UpYgSvCZEAyhzKMRc9HDH4UvW8Z44ctm25rGb8OAklTrhwfsoNQZoDPgoiffayCBFzEt1x9wmzCy3U0zFNZdiZgGyOPw",
AKTO_TRAFFIC_QUEUE_THRESHOLD: "100",
AKTO_INACTIVE_QUEUE_PROCESSING_TIME: "5000",
AKTO_TRAFFIC_PROCESSING_JOB_INTERVAL: "10",
AKTO_CONFIG_NAME: "STAGING",
RUNTIME_MODE: "HYBRID"
};

// Optional lifecycle hooks
override onStart() {
console.log("Container successfully started");
}

override onStop() {
console.log("Container successfully shut down");
}

override onError(error: unknown) {
console.log("Container error:", error);
}

}

// Create Hono app with proper typing for Cloudflare Workers
const app = new Hono<{
Bindings: { MY_CONTAINER: DurableObjectNamespace<MyContainer> };
}>();

// Home route with available endpoints
app.get("/", (c) => {
return c.text(
"Available endpoints:\n" +
"GET /container/<ID> - Start a container for each ID with a 2m timeout\n" +
"GET /lb - Load balance requests over multiple containers\n" +
"GET /error - Start a container that errors (demonstrates error handling)\n" +
"GET /singleton - Get a single specific container instance",
);
});

// Route requests to a specific container using the container ID
app.get("/container/:id", async (c) => {
const id = c.req.param("id");
const containerId = c.env.MY_CONTAINER.idFromName(`/container/${id}`);
const container = c.env.MY_CONTAINER.get(containerId);
return await container.fetch(c.req.raw);
});

// Demonstrate error handling - this route forces a panic in the container
app.get("/error", async (c) => {
const container = getContainer(c.env.MY_CONTAINER, "error-test");
return await container.fetch(c.req.raw);
});

// Load balance requests across multiple containers
app.get("/lb", async (c) => {
const container = await loadBalance(c.env.MY_CONTAINER, 3);
return await container.fetch(c.req.raw);
});

// Get a single container instance (singleton pattern)
app.post("/api/ingestData", async (c) => {

const id = 1;
const containerId = c.env.MY_CONTAINER.idFromName(`/container/${id}`);
const container = c.env.MY_CONTAINER.get(containerId);
return await container.fetch(c.req.raw);

});


export default app;



/api/ingestData - Is the endpoint in our docker image to be called from container in cloud flare


7. Now deploy container to cloud flare - wrangler deploy
   After successful deployment, you will see the URL of your deployed container in the terminal output. It will look something like this:

   ```
   https://super-resonance-827f.billing-53a.workers.dev
   


***

## Step 2: Set Up Your Cloudflare Worker Script

1. Navigate to the [Cloudflare Dashboard](https://dash.cloudflare.com/) and select your account.
2.  Go to **Workers & Pages**.

    <figure><img src="../../.gitbook/assets/cloudflare_workers_pages.png" alt=""><figcaption></figcaption></figure>
3.  Click **Create** and choose **Worker**.

    <figure><img src="../../.gitbook/assets/cloudflare-hello-world-worker.png" alt=""><figcaption></figcaption></figure>
4.  Click the **Hello World** button and deploy it.

    <figure><img src="../../.gitbook/assets/cloudflare-hello-world-worker-deploy.png" alt=""><figcaption></figcaption></figure>
5. Click **Edit code** and replace the default script with the following example:

```javascript
export default {
  async fetch(request, env, ctx) {
    const requestClone = request.clone();
    const backendResponse = await fetch("https://httpbin.org/get");

    try {
      const contentType = (request.headers.get("content-type") || "").toLowerCase();
      const shouldCapture = isAllowedContentType(contentType) && isValidStatus(backendResponse.status);

      if (shouldCapture) {
        const requestBody = await requestClone.text();
        const responseClone = backendResponse.clone();
        const responseBody = await responseClone.text();

        ctx.waitUntil(sendToAkto(request, requestBody, backendResponse, responseBody, env));
      }
    } catch (error) {
      console.error("Error while processing original request or response: ", error);
    }

    return backendResponse;
  },
};

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

async function sendToAkto(request, requestBody, response, responseBody, env) {
  const aktoAPI = "https://<your-cloudflare-container-ingestion-service-address>/api/ingestData";

  const logs = generateLog(request, requestBody, response, responseBody);

  const aktoRequest = new Request(aktoAPI, {
    method: "POST",
    body: logs,
    headers: {
      "Content-Type": "application/json",
      "x-api-key": "<your-api-key>"
    },
  });

  try {
    const aktoResponse = await fetch(aktoRequest);
    const responseText = await aktoResponse.text(); // always read body

    // Always print the response
    console.log(`Akto response: ${aktoResponse.status} ${aktoResponse.statusText}, Body: ${responseText}`);

    // Optionally, you can handle specific status codes
    if (!aktoResponse.ok) {
      console.warn("Non-2xx response from Akto.");
    }

  } catch (err) {
    console.error("Error sending data to Akto:", err);
  }
}

function generateLog(req, requestBody, res, responseBody) {
  const url = new URL(req.url);
  const path = url.pathname;
  const value = {
    path: path,
    requestHeaders: JSON.stringify(Object.fromEntries(req.headers)),
    responseHeaders: JSON.stringify(Object.fromEntries(res.headers)),
    method: req.method,
    requestPayload: requestBody,
    responsePayload: responseBody,
    ip: req.headers.get('x-forwarded-for') || req.headers.get('cf-connecting-ip') || req.headers.get('x-real-ip') || '',
    time: Math.round(Date.now() / 1000).toString(),
    statusCode: res.status.toString(),
    type: "HTTP/1.1",
    status: res.statusText,
    akto_account_id: "1000000",
    akto_vxlan_id: "0",
    is_pending: "false",
    source: "MIRRORING",
    tag: "{\n  \"service\": \"lambda\"\n}"
  };

  return JSON.stringify({ "batchData": [value] });
}
```

***

## Step 3: Configure Worker Routing

As the traffic connector worker & mini-runtime-service container are in the same Cloudflare account ie. same zone, the global_fetch_strictly_public compatibility flag is enabled.
This ensures that the Worker can make requests to the Akto Mini-Runtime Service Container without any issues.

1. In the Cloudflare Dashboard, go to **Workers & Pages**.
2. Under **Overview**, select your Worker.
3. Navigate to **Settings** > **Runtime**.
4. Edit **Compatibility Flags** and add `global_fetch_strictly_public` to the list of flags.'

    <figure><img src="../../.gitbook/assets/cloudflare-compatibility-flags.png" alt=""><figcaption></figcaption></figure>

If you'd like to route specific domains or paths through this Worker:

5. In the Cloudflare Dashboard, go to **Workers & Pages**.
6. Under **Overview**, select your Worker.
7. Navigate to **Settings** > **Domains & Routes**.
8. Click **Add Route**.
9. Select the appropriate zone (domain), and enter a route pattern such as:

    ```
    *.yourdomain.com/*
    ```

This ensures all traffic matching the route is intercepted and mirrored to Akto.

***


## Step 4: Verify the Setup

1. Confirm that API traffic data (requests and responses) are captured on the Akto dashboard under the respective api collection.
2. Check logs of your Cloudflare container for any initialization messages from the extension.
3. Go back to the [Akto Dashboard](https://app.akto.io/).
4. Navigate to **Api Collections** > **Hostname**.
5. You should start seeing the traffic from your Cloudflare Worker.

***

### Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
