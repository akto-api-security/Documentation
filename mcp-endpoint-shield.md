# Akto MCP Endpoint Shield

Akto MCP Endpoint Shield adds **runtime security** to any MCP server while preserving your normal workflow. It acts as a protective layer between your MCP client (e.g., Cursor, VS Code, Claude) and your server—**with zero code changes required**.

---

## ✨ Features
- ✅ Continuous safety checks on all requests and responses  
- ✅ Automatic blocking of unsafe interactions (via standard JSON-RPC errors)  
- ✅ Lightweight analytics to help uncover issues faster  
- ✅ Works out-of-the-box with popular MCP clients (Cursor, VS Code, Claude)  
- ✅ Zero changes required in your MCP server  

---

## 📦 Installation
- The tool is provided as an **installable binary** for your platform (Linux, macOS, Windows).  
- Download the binary from the official release page and place it in your system path (`$PATH`) for easy CLI access.  

Example (macOS/Linux):  
```bash
chmod +x mcp-endpoint-shield
mv mcp-endpoint-shield /usr/local/bin/
```

---

## 🔍 Configuration Auto-Detection
Akto MCP Endpoint Shield automatically detects MCP client configurations:  
- **Cursor** → Reads `~/.cursor/mcp.json`  
- **Visual Studio Code** → Reads `.vscode/mcp.json` inside your workspace  
- **Claude Desktop** → Reads Claude’s MCP config JSON  

For each detected MCP server config:  
1. The JSON file is parsed.  
2. Each server entry is automatically wrapped with **Akto MCP Endpoint Shield**.  
3. Your MCP clients transparently run through the shield without requiring manual reconfiguration.  

👉 You don’t need to manually edit your MCP config files — the wrapper handles this for you.  

---

### 📄 Example — Cursor `mcp.json`

**Original file (before wrapping):**  
```json
{
  "mcpServers": {
    "playwright-mcp": {
      "command": "npx",
      "args": [
        "-y"
        "@playwright/mcp@latest"
      ]
    }
  }
}
```

**Automatically wrapped file (after Akto MCP Endpoint Shield):**  
```json
{
  "mcpServers": {
    "playwright-mcp-endpoint-shield": {
      "command": "mcp-endpoint-shield",
      "args": [
        "stdio",
        "--name",
        "playwright-mcp",
        "--akto-api-token",
        "<your akto api token>",
        "--exec",
        "npx",
        "-y",
        "@playwright/mcp@latest"
      ]
    }
  }
}
```

**What changed:**  
- The server is renamed from `playwright-mcp` → `playwright-mcp-endpoint-shield`.  
- `mcp-endpoint-shield` is now the entry command.  
- Original server command (`npx @playwright/mcp@latest`) is passed through `--exec`.  
- Security flags (`--akto-api-token`) are automatically injected.  

---

## 🚀 Quick Start (Manual Run)

If you want to run manually (instead of auto-detection):  

```bash
mcp-endpoint-shield stdio   --name <project_name>   --akto-api-token <token>   --exec <your_mcp_server_command> [args...]
```

### Examples
- Python server:
  ```bash
  mcp-endpoint-shield stdio --name my-mcp --akto-api-token <TOKEN> --exec uv run server.py
  ```
- Dockerized server:
  ```bash
  mcp-endpoint-shield stdio     --name my-mcp     --akto-api-token <TOKEN>     --env AKTO_API_KEY=<TOKEN>     --exec docker run --rm -i -e AKTO_API_KEY=<TOKEN> your/mcp-image:latest
  ```

---

## ⚙️ Common Flags
- `--name <project_name>` → Friendly label used in logs and insights  
- `--akto-api-token <token>` → Your Akto API token  
- `--exec <command> [args...]` → Command to start your MCP server  
- `--env KEY=VALUE` (repeatable) → Pass additional environment variables to the MCP process  

---

## 🛠 How It Works (Behind the Scenes)
1. The wrapper launches your MCP server.  
2. Every request/response line is intercepted.  
3. Safe traffic passes through unchanged.  
4. Unsafe traffic is blocked, returning a **clear JSON-RPC error** to the client.  
5. Metadata is recorded (lightweight, opt-in) to improve detection and insights.  

---

## 📜 Logging
- Location: `$HOME/.akto/mcp_endpoint_shield.log`  
- Format: human-readable text logs  
- Includes: project name (`--name`) for easy filtering  
- Rotation: automatic (size-based) to prevent unbounded growth  

---

## 💻 Using with Cursor (at a glance)
- In Cursor settings, configure your MCP server to run through the wrapper.  
- Place your original MCP server command after `--exec`.  
- *(Optional: Add a diagram/screenshot here for clarity.)*  

---

## 🧩 Troubleshooting

**Issue:** Auto-detection didn’t work  
➡ Cause: Custom MCP config location or unsupported client.  
➡ Fix: Run your server manually with `--exec`.  

**Issue:** `Unexpected end of JSON input`  
➡ Cause: Your MCP server is writing non-protocol logs to stdout.  
➡ Fix: Use `stderr` for logs instead.  

**Issue:** `ERROR writing to MCP stdin: file already closed`  
➡ Cause: MCP server exited or closed stdin prematurely.  
➡ Fix: Run your server standalone to confirm stability.  

**Issue:** No insights appearing  
➡ Cause: Some tools don’t use standard JSON-RPC IDs.  
➡ Fix: Safety still applies, but insights may be limited.  

---

## 🔒 Guarantees
- ✅ **Transparency**: Safe traffic is never altered.  
- ✅ **Clarity**: Unsafe traffic always results in a clear JSON-RPC error.  
- ✅ **Minimal footprint**: Designed to stay invisible unless an issue occurs.  

---

### Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
