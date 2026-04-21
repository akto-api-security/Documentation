---
description: Snowflake Cortex Code CLI hooks for Akto Atlas
---

# Snowflake Cortex Code CLI hooks (Akto Atlas)

This page mirrors the canonical GitBook URL used in the Akto dashboard:

**[https://ai-security-docs.akto.io/akto-atlas-agentic-ai-security-for-employee-endpoints/endpoints-discovery-agents/snowflake-cortex-cli-hooks](https://ai-security-docs.akto.io/akto-atlas-agentic-ai-security-for-employee-endpoints/endpoints-discovery-agents/snowflake-cortex-cli-hooks)**

## Summary

Install Akto hook scripts into Snowflake Cortex Code CLI so prompts and tool calls are validated and ingested through Akto’s existing `/api/http-proxy` path, consistent with Claude Code CLI, GitHub Copilot CLI, and Cursor hooks.

## Source in the Akto repository

Implementation and README live at:

`apps/mcp-endpoint-shield/snowflake-cortex-cli-hooks/`

## Install (high level)

1. Copy the `snowflake-cortex-cli-hooks` directory to the user machine (for example `~/.snowflake/cortex/akto-hooks/`).
2. Configure `.env` with `AKTO_DATA_INGESTION_URL`, `MODE=atlas`, and optional `DEVICE_ID`.
3. Merge the `hooks` section from `hooks.json.example` into `~/.snowflake/cortex/hooks.json` or project `.cortex/settings.json`, replacing `INSTALL_DIR` with the install path.
4. Set file permissions on `.env` and hook directories per [Snowflake Cortex Code security](https://docs.snowflake.com/en/user-guide/cortex-code/security).

## Snowflake references

- [Cortex Code CLI extensibility (hooks, MCP)](https://docs.snowflake.com/en/user-guide/cortex-code/extensibility)
- [Security best practices for Cortex Code CLI](https://docs.snowflake.com/en/user-guide/cortex-code/security)

## Troubleshooting

- Confirm `python3` resolves and wrappers are executable (`chmod +x *.sh`).
- Check logs under `LOG_DIR` (default `~/.snowflake/cortex/akto/logs`).
- If hooks do not run, verify JSON merge did not drop required keys and that `command` paths are absolute.
