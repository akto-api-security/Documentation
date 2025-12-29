# MCP Endpoint Shield

## Overview

MCP Endpoint Shield provides **runtime security** and auto-discovery of local MCP servers configured on your machine. It acts as a protective layer between the MCP client (e.g., Cursor, VS Code, Claude) and the MCP servers—requiring no changes to your setup.

***

### ✨ Features

* ✅ Continuous safety checks on all requests and responses to the MCP servers
* ✅ Automatic blocking of unsafe interactions (via standard JSON-RPC errors)
* ✅ Works out-of-the-box with popular MCP clients (Cursor, VS Code, Claude)
* ✅ Zero changes required in your MCP server

***

### 📦 Installation

* The application is provided as an installble package (.app, .deb, .exe)
* Please reach out to Akto Support to get your installer.
* Please refer to the Manaul Run section if you wish to run the tool without an installer

***

### 🔍 Auto-Detection

Akto MCP Endpoint Shield automatically detects MCP client configurations:

* **Cursor** → Reads `~/.cursor/mcp.json`
* **Visual Studio Code** → Reads `.vscode/mcp.json` inside your workspace
* **Claude Desktop** → Reads Claude’s MCP config JSON

For each detected MCP server config:

1. The JSON file is parsed.
2. Each server entry is automatically wrapped with **Akto MCP Endpoint Shield**.
3. Your MCP clients transparently run through the shield without requiring manual reconfiguration.

👉 You don’t need to manually edit your MCP config files — the wrapper handles this for you.

***

#### 📄 Example — Cursor `mcp.json`

**Original file (before wrapping):**

```json
{
  "mcpServers": {
    "chrome-devtools-mcp": {
      "command": "npx",
      "args": [
        "-y"
        "chrome-devtools-mcp@latest"
      ]
    }
  }
}
```

**Automatically wrapped file (after Akto MCP Endpoint Shield):**

```json
{
  "mcpServers": {
    "chrome-devtools-mcp": {
      "command": "mcp-endpoint-shield",
      "args": [
        "stdio",
        "--name",
        "chrome-devtools-mcp",
        "--exec",
        "npx",
        "-y",
        "chrome-devtools-mcp@latest"
      ]
    }
  }
}
```

<figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2Fgit-blob-a71682de7c1df47b6a5ea827fc2bf83af6fde9ff%2Fmcp_endpoint_shield_example.png?alt=media" alt=""><figcaption></figcaption></figure>

**What changed:**

* `mcp-endpoint-shield` is now the entry command.
* Original server command (`npx -y chrome-devtools-mcp@latest`) is passed through `--exec`.

***

### 🔧 Manual Setup

Follow these steps to manually set up and run MCP Endpoint Shield to protect your MCP servers.

#### Prerequisites

* You have the `mcp-endpoint-shield` binary available
* You have an Akto API token
* uninstall MCP Endpoint Shield if installed previously using installers

#### Step 1: Set Your API Token

Set the `AKTO_API_TOKEN` environment variable:

```bash
export AKTO_API_TOKEN="your-actual-token-here"
```

**Make it permanent** (optional):

For **bash** users, add to `~/.bashrc`:

```bash
echo 'export AKTO_API_TOKEN="your-actual-token-here"' >> ~/.bashrc
source ~/.bashrc
```

For **zsh** users, add to `~/.zshrc`:

```bash
echo 'export AKTO_API_TOKEN="your-actual-token-here"' >> ~/.zshrc
source ~/.zshrc
```

Verify it's set:

```bash
echo $AKTO_API_TOKEN
```

#### Step 2: Start the Agent

The agent automatically discovers and protects your MCP servers.

```bash
./mcp-endpoint-shield agent
```

**Expected output:**

```
Starting akto agent...
Starting RunAgent...
Agent mode started. Press Ctrl+C to stop...
```

**Keep this terminal running.** The agent will:

* Find your MCP configuration files (Cursor, VS Code, Claude Desktop)
* Wrap your MCP servers with security
* Sync security policies from Akto backend
* Watch for changes and auto-update configs

**Note:** If you want the agent to run in the background, use:

```bash
nohup ./mcp-endpoint-shield agent > agent.log 2>&1 &
```

#### Step 3: Protecting Local MCP Servers (STDIO)

**Option A: Let the Agent Wrap It (Recommended)**

If the agent is running (Step 2), it will **automatically** detect and wrap your config. Your MCP configuration will be automatically modified to route through the security shield.

**Example transformation:**

Before:

```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": ["-y", "chrome-devtools"]
    }
  }
}
```

After (automatic):

```json
{
  "mcpServers": {
    "chrome-devtools-endpoint-shield": {
      "command": "mcp-endpoint-shield",
      "args": [
        "stdio",
        "--name",
        "chrome-devtools",
        "--akto-api-token",
        "your-actual-token-here",
        "--exec",
        "npx",
        "-y",
        "chrome-devtools"
      ]
    }
  }
}
```

**Restart your MCP client** (Cursor/VS Code) to apply changes.

**Option B: Manual Wrapping (If Not Using Agent)**

If you're not running the agent, manually edit your MCP config file (e.g., `~/.cursor/mcp.json`):

**Before:**

```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": ["-y", "chrome-devtools"]
    }
  }
}
```

**After:**

```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "/path/to/mcp-endpoint-shield",
      "args": [
        "stdio",
        "--name",
        "chrome-devtools",
        "--akto-api-token",
        "your-actual-token-here",
        "--exec",
        "npx",
        "-y",
        "chrome-devtools"
      ]
    }
  }
}
```

**Key changes:**

1. Change `command` to the full path of `mcp-endpoint-shield`
2. Add `"stdio", "--name", "<server-name>", "--akto-api-token", "<your-token>", "--exec"` to the start of `args`
3. Place the original command (`npx`) and arguments (`-y`, `chrome-devtools`) after `--exec`

**Restart your MCP client** to apply changes.

#### Step 4: Protecting Remote MCP Servers (HTTP)

For HTTP-based MCP servers, run the HTTP proxy in a **new terminal**:

```bash
export AKTO_API_TOKEN="your-actual-token-here"
./mcp-endpoint-shield http
```

**Expected output:**

```
Starting MCP HTTP Proxy on 127.0.0.1:57294
Project: default, Skip Threat: false
```

**Keep this terminal running.**

**Note:** The proxy runs on port `57294` by default.

**Configure Your Remote MCP Server**

**Original config** (direct connection to remote server):

```json
{
  "mcpServers": {
    "remote-mcp": {
      "url": "https://remote-mcp-server.example.com/mcp",
      "headers": {
        "Authorization": "Basic <token>"
      }
    }
  }
}
```

**Protected config** (route through proxy):

```json
{
  "mcpServers": {
    "remote-mcp": {
      "url": "http://localhost:57294/mcp/streamable",
      "headers": {
        "Authorization": "Basic <token>",
        "mcp-server-base-url": "https://remote-mcp-server.example.com/mcp"
      }
    }
  }
}
```

**Key changes:**

1. Change `url` to `http://localhost:57294/mcp/streamable`
2. Keep your existing `Authorization` header (or any other headers)
3. Add new header `mcp-server-base-url` with the original remote server URL

The proxy will:

* Receive requests at `http://localhost:57294/mcp/streamable`
* Read the `mcp-server-base-url` header to know where to forward
* Apply security policies
* Forward to your actual remote MCP server
* Return the response back to your client

**Restart your MCP client** to apply changes.

#### Step 5: Verify Everything is Working

**Check Agent Status**

Look at the agent terminal - you should see:

```
Agent mode started. Press Ctrl+C to stop...
```

No errors means it's working!

**Check HTTP Proxy Status**

Look at the proxy terminal:

```
Starting MCP HTTP Proxy on 127.0.0.1:57294
```

**Test Your MCP Server**

Open your MCP client (Cursor, VS Code, Claude Desktop) and try using your wrapped MCP server. It should work normally, but now with security protection.

#### Quick Command Reference

**Terminal 1 - Agent:**

```bash
export AKTO_API_TOKEN="your-token"
./mcp-endpoint-shield agent
```

**Terminal 2 - HTTP Proxy:**

```bash
export AKTO_API_TOKEN="your-token"
./mcp-endpoint-shield http
```

**Get Help:**

```bash
./mcp-endpoint-shield help
```

This protects:

* **STDIO servers** (like `npx -y chrome-devtools`) via agent
* **HTTP servers** (remote MCP servers) via proxy

***

### ⚙️ Common Flags

* `--name <project_name>` → Friendly label used in logs and insights
* `--akto-api-token <token>` → Your Akto API token
* `--exec <command> [args...]` → Command to start your MCP server
* `--env KEY=VALUE` (repeatable) → Pass additional environment variables to the MCP process

***

### 📜 Logging

#### Log File Locations

**Manual Run**

When you manually run `mcp-endpoint-shield`, logs are written to:

```
~/.akto-mcp-endpoint-shield/logs/
```

**Example:**

```bash
# If you wrapped a server with --name chrome-devtools
tail -f ~/.akto-mcp-endpoint-shield/logs/chrome-devtools.log

# View all logs
ls -la ~/.akto-mcp-endpoint-shield/logs/
tail -f ~/.akto-mcp-endpoint-shield/logs/*.log
```

**MacOS System Service (LaunchDaemon)**

When installed and running as a system service on macOS:

**Agent logs:**

```
/var/log/akto-mcp-endpoint-shield/agent.log
/var/log/akto-mcp-endpoint-shield/agent-error.log
```

**HTTP Proxy logs:**

```
/var/log/akto-mcp-endpoint-shield/proxy-server.log
/var/log/akto-mcp-endpoint-shield/proxy-error.log
```

**View logs:**

```bash
sudo tail -f /var/log/akto-mcp-endpoint-shield/*.log
```

**Linux System Service (systemd)**

When installed and running as a systemd service on Linux:

**Agent logs:**

```
/var/log/akto-mcp-endpoint-shield/agent.log
```

**HTTP Proxy logs:**

```
/var/log/akto-mcp-endpoint-shield/proxy-server.log
```

**View logs:**

```bash
# Direct log files
sudo tail -f /var/log/akto-mcp-endpoint-shield/*.log

# Via systemd journalctl
sudo journalctl -u mcp-endpoint-shield-agent -f
sudo journalctl -u mcp-endpoint-shield -f
```

**STDIO Wrapped MCP servers (Manual and Installer)**

Each wrapped STDIO MCP server gets its own log file named after the `--name` attribute:

```
~/.akto-mcp-endpoint-shield/logs/<name>.log
```

***

## Troubleshooting

**Issue:** `AKTO_API_TOKEN is not set` ➡ Cause: Environment variable not configured. ➡ Fix: Set the token with `export AKTO_API_TOKEN="your-token"` and verify with `echo $AKTO_API_TOKEN`.

**Issue:** `Port already in use` (HTTP Proxy) ➡ Cause: Port 57294 is already being used by another process. ➡ Fix 1: Find and kill the process with `lsof -i :57294` and `kill -9 PID`. ➡ Fix 2: Use a different port with `./mcp-endpoint-shield http --port 8080` and update your config.

**Issue:** MCP server not working after wrapping ➡ Cause: Multiple possible causes. ➡ Fix:

1. Restart your MCP client,
2. Verify binary path with `which mcp-endpoint-shield`,
3. Check logs at `~/.akto-mcp-endpoint-shield/logs/` or `/var/log/akto-mcp-endpoint-shield/` (if installed using installer)
4. Test original command works standalone.

**Issue:** `permission denied: ./mcp-endpoint-shield` ➡ Cause: Binary doesn't have execute permissions. ➡ Fix: Run `chmod +x ./mcp-endpoint-shield`.

**Issue:** `command not found: mcp-endpoint-shield` ➡ Cause: Binary not in PATH or wrong path used. ➡ Fix: Use full path (`./mcp-endpoint-shield` or `/usr/local/bin/mcp-endpoint-shield`) or add to PATH with `export PATH=$PATH:/path/to/binary/directory`.

***

### 🔒 Guarantees

* ✅ **Transparency**: Safe traffic is never altered.
* ✅ **Clarity**: Unsafe traffic always results in a clear JSON-RPC error.
* ✅ **Minimal footprint**: Designed to stay invisible unless an issue occurs.

***

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
