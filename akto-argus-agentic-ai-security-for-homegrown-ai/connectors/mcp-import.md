# MCP Import

## Overview

Akto now supports direct import of **MCPs** (tools, resources, and prompts) into **MCP Inventory** via **Connectors**. With just your SSE endpoint URL, you can auto-discover all active MCP tools, resources, and prompts; no manual setup required.

<figure><img src="../../.gitbook/assets/image (96).png" alt="" width="563"><figcaption></figcaption></figure>

## What You Need

* **MCP SSE Endpoint URL** (e.g., ends with `/sse`)
*   **(Optional) Authorization headers** – only if your MCP server requires them:

    ```
    Header Key: Authorization
    Header Value: Bearer <your-token>
    ```

{% hint style="warning" %}
**If your MCP server requires authentication, set up the scan role correctly first**

Most failed MCP imports happen because the scan role used for authentication is not configured correctly. If the server needs a token that expires or is issued per login, a pasted header value stops working and the import fails. Use an **automated auth** scan role so Akto fetches a fresh token for the import.
{% endhint %}

## Set Up the Scan Role (Authenticated Servers Only)

Skip this section if your MCP server is not secured.

{% stepper %}
{% step %}
**Create the scan role**

Create a scan role by following [Create a Scan Role](../agentic-red-teaming/how-to/create-a-test-role.md#adding-auth-token-for-role) and choose **Automated Auth token generation**.
{% endstep %}

{% step %}
**Configure the call details**

Enter the URL, method, headers and body exactly as your token endpoint expects.
{% endstep %}

{% step %}
**Execute the call**

Run the call and confirm the server returns a token.

{% hint style="info" %}
Do not save the role if the call fails. Fix the call details first.
{% endhint %}
{% endstep %}

{% step %}
**Extract the token**

Extract the token from the correct place in the response (the right header or body parameter, for example `Authorization`).
{% endstep %}

{% step %}
**Use the scan role for the import**

Use that scan role for authentication when you import the MCP server in the steps below.
{% endstep %}
{% endstepper %}

{% hint style="info" %}
If the import still fails, re-run the call in the role and check that the extracted token is the one your MCP server expects.
{% endhint %}

## Steps to Import

{% stepper %}
{% step %}
_Open_ **Akto Argus Dashboard** _→ Go to Connectors._
{% endstep %}

{% step %}
Select **MCP Import.**
{% endstep %}

{% step %}
**Fill in MCP Initialize URL**

*   SSE Endpoint URL: e.g., `https://mcp.example.com/sse`

    <figure><img src="../../.gitbook/assets/image (98).png" alt="" width="188"><figcaption></figcaption></figure>
* If your MCP server is secured, choose the `This site requires login?` tick box.
{% endstep %}

{% step %}
**Fill in the Authentication Credentials (Optional)**

Enter the following details:

*   _(Optional)_ Add Auth Headers:

    ```
    Header Key: Authorization
    Header Value: Bearer your-token
    ```

<figure><img src="../../.gitbook/assets/image (101).png" alt="" width="188"><figcaption></figcaption></figure>

{% hint style="info" %}
**Example With Authorisation**

```
SSE Endpoint URL: https://mcp.example.com/sse
Header Key: Authorization
Header Value: Bearer abc123
```
{% endhint %}
{% endstep %}

{% step %}
**Click Import**

Akto will then:

* Start listening to the SSE stream
* Scan events like `tool_call`, `resource_call`, and `prompt_response`
* Auto-register all observed MCP endpoints
{% endstep %}
{% endstepper %}

## What Gets Imported?

Akto will detect and add:

* All **tool endpoints** (`/v1/tools/...`) → tagged as `mcp-tools`
* All **resource endpoints** (`/v1/resources/...`) → tagged as `mcp-resources`
* All **prompt endpoints** (`/v1/prompts/...`) → tagged as `mcp-prompts`

These will appear in **MCP Inventory**, ready for monitoring and scanning.

{% hint style="success" %}
**Security**

* Auth headers (if any) are used **only once** during import and are **not stored**
* Akto uses **read-only access** to your SSE stream
{% endhint %}

#### Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
