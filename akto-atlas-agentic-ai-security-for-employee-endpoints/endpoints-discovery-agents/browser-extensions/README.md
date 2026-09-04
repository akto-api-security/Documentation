# Browser Extensions

Discover and govern the AI agents, MCP servers, and GenAI tools your employees use directly from their browser. Akto's browser extensions track 80+ AI tools out of the box, capturing agent interactions in real time as your employees browse, and enforce your guardrail policies inline, blocking sensitive data leaks and policy violations before they leave the browser.

## What They Do

* Discover AI agent API calls, MCP server interactions, tool invocations, and the authentication tokens and headers involved, as your employees use AI applications in the browser.
* Enforce your [guardrail policies](../../atlas-guardrails.md) on that traffic inline: block sensitive data exposure, flag policy violations, and log every policy-relevant event.
* Report everything back to [Agentic AI Discovery](../../ai-agent-activity/) so it shows up alongside every other connector.

## Available Extensions

* [Chrome Extension](chrome/) - for Google Chrome and Chromium-based browsers (Edge, Brave, Opera, and so on)
* [Firefox Extension](firefox.md) - for Mozilla Firefox
* [Safari Extension](safari.md) - for Safari on macOS

## When to Use Browser Extensions

Browser extensions cover AI usage inside the browser itself, web apps like ChatGPT web or Claude.ai, rather than the local CLIs, IDEs, and MCP servers that [AI Endpoint Shield](../ai-endpoint-shield/) covers on the device. Use them when:

* You want visibility and enforcement on web-based AI tools your employees use in the browser.
* You need to cover devices where you can't (or haven't yet) rolled out AI Endpoint Shield.
* You want to catch shadow AI usage and personal-account sign-ins as they happen in the browser.
* You're piloting Akto before a fleet-wide rollout.
