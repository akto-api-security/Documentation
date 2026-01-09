# MCP Import

Akto now supports direct import of **MCPs** (tools, resources, and prompts) into **MCP Inventory** via **Quick Start**. With just your SSE endpoint URL, you can auto-discover all active MCP tools, resources, and prompts — no manual setup required.

<figure><img src="../.gitbook/assets/image (138).png" alt=""><figcaption></figcaption></figure>

***

### 🔧 What You Need

* **MCP SSE Endpoint URL** (e.g., ends with `/sse`)
*   **(Optional) Authorization headers** – only if your MCP server requires them:

    ```
    Header Key: Authorization
    Header Value: Bearer <your-token>
    ```

***

### ✅ Steps to Import

1. **Open Akto Dashboard** → Go to _Quick Start_
2. **Select**: _Import from MCP_
3. **Fill in SSE Details**
   * SSE Endpoint URL: e.g., `https://mcp.example.com/sse`
   *   _(Optional)_ Add Auth Headers:

       ```
       Header Key: Authorization
       Header Value: Bearer your-token
       ```
   * If your MCP server is not secured, leave auth fields blank.
4. **Click Import**

Akto will then:

* Start listening to the SSE stream
* Scan events like `tool_call`, `resource_call`, and `prompt_response`
* Auto-register all observed MCP endpoints

**Example With Authorization**

```
SSE Endpoint URL: https://mcp.example.com/sse
Header Key: Authorization
Header Value: Bearer abc123
```

**Without Authorization**

```
SSE Endpoint URL: https://mcp.example.com/sse
```

***

### 🔍 What Gets Imported?

Akto will detect and add:

* All **tool endpoints** (`/v1/tools/...`) → tagged as `mcp-tools`
* All **resource endpoints** (`/v1/resources/...`) → tagged as `mcp-resources`
* All **prompt endpoints** (`/v1/prompts/...`) → tagged as `mcp-prompts`

These will appear in **MCP Inventory**, ready for monitoring and testing.

***

### 🔒 Security

* Auth headers (if any) are used **only once** during import and are **not stored**
* Akto uses **read-only access** to your SSE stream

***

### Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
