# Connect Akto Guardrails with Cloudflare

## Overview

Cloudflare sits in front of your APIs at the edge. This integration uses a Cloudflare Worker that does two things: it **mirrors** traffic into Akto for discovery and inventory (same idea as the standard Akto Cloudflare proxy), and it optionally **enforces Akto Guardrails** on selected HTTP traffic before and after your origin. That lets you validate and, when needed, block or rewrite agentic and Gen AI–style API calls while still feeding Akto’s data ingestion pipeline.

<figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2Fgit-blob-a9d941b3e4abe2bf3ba452ff79360db8d9a6d084%2Fimage.png?alt=media" alt=""><figcaption></figcaption></figure>

Akto provides the **Guardrails service URL** and the **data ingestion base URL** you configure on the Worker. Use the steps below to deploy the Worker and attach it to your zones.

## Steps to Deploy

{% stepper %}
{% step %}
### Deploy the Guardrails Worker

Use the Worker script from Akto’s published source:

**Worker code:** [akto-cloudflare-proxy-guardrails `index.js`](https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/akto-cloudflare-proxy-guardrails/src/index.js)

Deploy using the Cloudflare dashboard and the steps below.

#### Dashboard path (high level)

1. Open the [Cloudflare Dashboard](https://dash.cloudflare.com/) and select your account.
2.  Go to **Workers & Pages**.

    <div data-with-frame="true"><figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2Fgit-blob-9b498acc1e5cde4d33ea4921ec3b3c669c06df31%2Fcloudflare_workers_pages.png?alt=media" alt="" width="563"><figcaption></figcaption></figure></div>
3.  Create a **Worker** (you can start from the Hello World template, deploy once, then **Edit code**).

    <div data-with-frame="true"><figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2Fgit-blob-ecc654ab1a223529e9d168708214f994b0398e2a%2Fcloudflare-hello-world-worker.png?alt=media" alt="" width="563"><figcaption></figcaption></figure></div>
4. Replace the editor contents with the full script from the link above.
5. Save and deploy.

<div data-with-frame="true"><figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2Fgit-blob-88941adf7ef76ca875ad24039e647c1958c18d70%2Fcloudflare-hello-world-worker-deploy.png?alt=media" alt="" width="563"><figcaption></figcaption></figure></div>

#### What this Worker does (so you can verify your deployment)

* **WebSocket upgrades** are proxied as-is. The Worker logs metadata suitable for mirroring; it does not run Guardrails body validation on the upgrade handshake in the same way as full HTTP bodies.
* **HTTP(S)**
  * If Guardrails are **off** (see variables below), behavior is essentially **mirror-only**: request and response streams are teed where needed, the client still talks to your origin normally, and eligible traffic is sent to Akto ingestion.
  * If Guardrails are **on** for a given request, the Worker:
    1. After reading the request body (when present), calls Guardrails for the **request** phase. If the policy **blocks**, the client receives HTTP **400** with a small JSON error payload (including a reason when the service provides one). If the policy **modifies** the payload, the upstream request uses the modified body.
    2. After receiving the origin response and reading the response body (when present), calls Guardrails for the **response** phase. Again, **block** yields **400** to the client; **modify** replaces the body returned to the client.
    3. Regardless of block/modify/proceed, mirroring to Akto ingestion follows the same content-type and status rules as the simpler proxy Worker.

**Guardrails are not applied** to `GET` or `DELETE` requests (those methods are always treated as mirror-only from a Guardrails perspective).

**Path scoping:** When Guardrails are enabled globally, you can limit which paths are validated by setting a comma-separated list of path **fragments** (the Worker matches them as substrings of the URL path, case-insensitive, after normalizing leading slashes). If that list is unset or empty, all non–GET/DELETE methods are candidates for Guardrails (subject to the enable flag).

**Ingestion payload tagging:** Mirrored entries are tagged so Akto can treat them as Gen AI–related traffic (`tag` includes `service: cloudflare` and a Gen AI marker).

<details>

<summary>Environment variables and secrets</summary>

Configure these in the Worker’s **Settings → Variables** (plain vars) and **Secrets** (sensitive values). Use the **Guardrails URL**, **data ingestion URL**, and **ingestion token** supplied by Akto.

<table><thead><tr><th width="228.09375">Name</th><th>Purpose</th></tr></thead><tbody><tr><td><code>APPLY_AKTO_GUARDRAILS</code></td><td>Set to <code>true</code> or <code>1</code> (string or boolean) to enable request/response Guardrails for applicable methods and paths. Any other value disables Guardrails while keeping mirroring.</td></tr><tr><td><code>AKTO_GUARDRAILS_URL</code></td><td>Base URL of the Guardrails service (Akto-provided), <strong>no trailing slash</strong>. Required for validation calls; if missing, the Worker skips Guardrails and only mirrors.</td></tr><tr><td><code>AKTO_ENDPOINTS_TO_GUARD</code></td><td>Optional. Comma-separated path fragments; if non-empty, Guardrails run only when the request path contains one of these fragments (after lowercasing). If empty, all eligible methods/paths (except GET/DELETE) are guarded when Guardrails are on.</td></tr><tr><td><code>AKTO_DATA_INGESTION_URL</code></td><td>Base URL of the Akto data-ingestion host (Akto-provided), <strong>no trailing slash</strong>. The Worker appends <code>/api/ingestData</code>. If this or the token is missing, ingest calls are skipped (logged in Worker logs).</td></tr><tr><td><code>AKTO_DATA_INGESTION_TOKEN</code></td><td>Secret sent as the <strong><code>Authorization</code></strong> header on ingest POSTs. Add it under <strong>Settings → Variables and Secrets</strong> as a <strong>Secret</strong>. You can copy the value from <strong>Akto Dashboard → Quick Setup → Hybrid SaaS</strong> as <code>databaseAbstractorToken</code>.</td></tr></tbody></table>



</details>
{% endstep %}

{% step %}
### Configure Worker Routing

Attach the Worker to the hostnames and paths that should pass through Akto mirroring (and Guardrails when enabled):

1. In Cloudflare, open **Workers & Pages** → your Worker → **Settings** → **Domains & Routes**.
2.  **Add route** and pick the zone; use a pattern that covers your APIs, for example:

    ```
    *.yourdomain.com/*
    ```

Traffic matching the route is handled by this Worker; everything else is unchanged.
{% endstep %}

{% step %}
### Verify the setup

1. **Ingestion:** Generate API traffic on a routed hostname. In **Akto Dashboard → API Collections** (e.g. by hostname), confirm new endpoints and traffic appear as with the standard Cloudflare proxy connector.
2. **Guardrails:** With `APPLY_AKTO_GUARDRAILS` enabled, exercise a **POST** or **PUT** (or other non-GET/DELETE) path that should be guarded. Confirm allowed traffic still reaches your origin; intentionally trigger a policy that **blocks** and confirm the client receives **400** with the JSON error shape; if your policies **modify** payloads, confirm the client sees the rewritten body.
3. **Worker logs:** In **Workers & Pages → your Worker → Logs**, look for guardrails phase logs, ingest success/failure, and any warnings about missing `AKTO_GUARDRAILS_URL` or ingest URL/token.
{% endstep %}
{% endstepper %}

## Get support for your Akto setup

1. In-app **Intercom** in the Akto dashboard.
2. [Discord community](https://www.akto.io/community).
3. [Contact Akto](https://www.akto.io/contact-us).
