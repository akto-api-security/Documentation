# MCP Registry Integration

## Overview

Configure MCP (Model Context Protocol) Registries to discover and validate MCP servers. Akto reads a CSV file you host at a URL you provide and ingests the MCP server names listed in it, so you can keep your MCP server inventory in sync with your own source of truth.

## How to Add a URL

You can configure the MCP registry from **Settings → Integrations → MCP Registry**.

{% stepper %}
{% step %}
**Open the form**

Click **Add URL** to open the form.
{% endstep %}

{% step %}
**Enter the URL**

Enter the URL pointing to your CSV file (e.g. `https://example.com/path/to/mcp_servers.csv`). The file at this URL will be read to extract MCP endpoints.

Use **Download sample CSV** on this page to get a template.
{% endstep %}

{% step %}
**Add authentication (if required)**

If the file requires authentication, click **Add Header** and add a header, for example key `Authorization` and value `Bearer <your_token>`.
{% endstep %}

{% step %}
**Submit**

Click **Add Registry**. MCP server entries will be ingested automatically from the CSV.
{% endstep %}
{% endstepper %}

## Important Notes

{% hint style="warning" %}
**Only one registry URL is supported.**
{% endhint %}

### CSV Format

Your CSV must have a header row with a `mcp_server_name` column. Each row is one MCP server name.

```
mcp_server_name
api.githubcopilot.com
mcp.notion.com
filesystem-local
my-postgres
```

* For **remote** MCP servers, use the domain name (e.g. `api.example.com`).
* For **local** MCP servers, use the name your team has given it (e.g. `filesystem-local`, `my-postgres`).

Use **Download sample CSV** on this page for a ready-to-edit template.

{% hint style="info" %}
### Syncing

Updated your CSV? Wait 5 minutes for changes to propagate, then click **Sync now** to pull in the latest entries.
{% endhint %}
