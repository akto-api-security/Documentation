# AI Endpoint Shield

## Overview

**Akto's AI Endpoint Shield** is the background agent you deploy to your employees' devices to discover and protect local AI activity. It auto-detects the MCP servers configured in your employees' IDEs and CLIs, wraps them with runtime security, installs the guardrail hooks for your AI tooling, and reports everything back to your Akto dashboard, with no changes required to how your employees work.

## What It Does

Once installed on an employee's device, AI Endpoint Shield:

* **Discovers** every AI agent, MCP server, skill, and plugin present on the device, including MCP server configs inside clients like Cursor, VS Code, and Claude Desktop.
* **Protects what it finds** by installing the [IDE and CLI hooks](../) for the device's AI tools, which enforce guardrails wherever the hook supports it, and by wrapping local (STDIO) and remote (HTTP) MCP servers with runtime security, transparently forwarding safe traffic and blocking unsafe requests or responses with a clear JSON-RPC error.
* **Covers standalone desktop apps** that don't expose hooks, such as Claude Desktop, GitHub Copilot, and the ChatGPT desktop app, through the bundled [Akto System Proxy](../akto-system-proxy.md).
* **Reports everything back** to the [Endpoint Shield](../../ai-agent-activity/view-endpoint-shield-details.md) page, so you always have a live view of what's protected.
* **Stays current on its own**, checking a version manifest so one deployment policy handles the initial install and every future update.

## How You Deploy It

AI Endpoint Shield supports macOS, Windows, and Linux. Roll it out fleet-wide through whichever MDM you already run, or install it standalone on a single machine:

| Platform | Fleet deployment | Standalone install |
| --- | --- | --- |
| macOS | [Jamf MDM](jamf-mdm-deployment.md), [Mosyle MDM](mosyle-deployment.md), or [NinjaOne](ninjaone-macos-deployment.md) | [macOS standalone install](macos-standalone-installation.md) |
| Windows | [Microsoft Intune](intune-deployment.md), [NinjaOne](ninjaone-windows-deployment.md), or [Automox](automox-deployment.md) | Available |
| Linux | Available | Available |

Every method runs the same underlying installation script per platform, so behavior is consistent no matter which MDM you deploy it from. These guides walk you through the install steps only, they don't include the installer file itself.

{% hint style="info" %}
**Getting the installer**

AI Endpoint Shield ships as a client-specific installer, with your Akto API token and base URL already embedded, so nothing sensitive lives in your MDM configuration. 
For the installer or installation package, for any platform, **contact Akto Support** first and we'll get you the file configured for your deployment method.
{% endhint %}

## After Deployment

* [Allowlist AI Endpoint Shield](allowlist-in-security-software.md) in your antivirus, EDR, and endpoint management tools so it isn't quarantined or blocked.
* If a device installs but doesn't show up in Akto, use the [macOS](macos-troubleshooting.md) or [Windows](windows-troubleshooting.md) troubleshooting guide to validate the install.
* Review every protected device and its MCP servers on the [Endpoint Shield](../../ai-agent-activity/view-endpoint-shield-details.md) page.

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24x7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `support@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
