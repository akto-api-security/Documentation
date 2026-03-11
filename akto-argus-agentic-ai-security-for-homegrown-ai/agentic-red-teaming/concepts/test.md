---
description: Comprehensive security Probing for AI agents and agentic systems.
---

# Probe

Akto provides specialized security probing for AI agents, LLM applications, and agentic systems. The platform includes pre-built probe suites covering OWASP Top 10 for LLMs, prompt injection attacks, MCP security, tool misuse, and other agentic-specific vulnerabilities.

You can schedule probes to run at times that fit your workflow, ensuring continuous security validation without disrupting operations. For scheduling information, refer to [Schedule Probes](../how-to/schedule-tests.md).

## Probe Categories

Akto organizes agentic security probes into specialized categories:

**LLM Security**: Probes for model-specific vulnerabilities including prompt injection, jailbreaking, and output manipulation.

**Prompt Injection**: Comprehensive probing for direct and indirect prompt injection attacks across various agent workflows.

**MCP Security**: Validates Model Context Protocol implementations, tool authorization, and resource access controls.

**Agent Identity**: Probes for agent impersonation, role escalation, and identity validation bypasses.

**Sensitive Information Disclosure**: Detects exposure of credentials, PII, internal system details, and training data leakage.

**Supply Chain**: Identifies vulnerabilities in agent dependencies, third-party integrations, and model providers.

**Excessive Agency**: Validates tool permissions, autonomous action limits, and guardrail effectiveness.

**Data Poisoning**: Probes for manipulation of agent memory, context windows, and retrieval systems.

## Akto's Approach

Akto uses real agent traffic to enhance probing effectiveness:

**Real-World Context**: Probes use actual agent interactions, tool calls, and conversation patterns to identify vulnerabilities that static analysis would miss.

**Shadow Agent Detection**: Discovers undocumented agents, unauthorized LLM integrations, and rogue tool usage across your infrastructure.

**Dynamic Probe Coverage**: Adapts probes based on observed agent behaviors, tool chains, and conversation flows.

## Protocol Support

Akto supports probing across multiple protocols used in agentic systems:

**REST & GraphQL**: Probe HTTP-based agent endpoints and tool integrations.

**gRPC**: Validates agent-to-agent communication and microservice interactions.

**WebSocket**: Probe real-time agent streams and persistent connections.

**MCP (Model Context Protocol)**: Specialized probing for MCP server implementations and tool definitions.
