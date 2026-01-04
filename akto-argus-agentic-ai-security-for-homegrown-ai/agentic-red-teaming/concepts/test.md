---
description: Comprehensive security testing for AI agents and agentic systems.
---

# Test

Akto provides specialized security testing for AI agents, LLM applications, and agentic systems. The platform includes pre-built test suites covering OWASP Top 10 for LLMs, prompt injection attacks, MCP security, tool misuse, and other agentic-specific vulnerabilities.

You can schedule tests to run at times that fit your workflow, ensuring continuous security validation without disrupting operations. For scheduling information, refer to [Schedule Test](../how-to/schedule-tests.md).

## Test Categories

Akto organizes agentic security tests into specialized categories:

**LLM Security**: Tests for model-specific vulnerabilities including prompt injection, jailbreaking, and output manipulation.

**Prompt Injection**: Comprehensive testing for direct and indirect prompt injection attacks across various agent workflows.

**MCP Security**: Validates Model Context Protocol implementations, tool authorization, and resource access controls.

**Agent Identity**: Tests for agent impersonation, role escalation, and identity validation bypasses.

**Sensitive Information Disclosure**: Detects exposure of credentials, PII, internal system details, and training data leakage.

**Supply Chain**: Identifies vulnerabilities in agent dependencies, third-party integrations, and model providers.

**Excessive Agency**: Validates tool permissions, autonomous action limits, and guardrail effectiveness.

**Data Poisoning**: Tests for manipulation of agent memory, context windows, and retrieval systems.

## Akto's Approach

Akto uses real agent traffic to enhance testing effectiveness:

**Real-World Context**: Tests use actual agent interactions, tool calls, and conversation patterns to identify vulnerabilities that static analysis would miss.

**Shadow Agent Detection**: Discovers undocumented agents, unauthorized LLM integrations, and rogue tool usage across your infrastructure.

**Dynamic Test Coverage**: Adapts tests based on observed agent behaviors, tool chains, and conversation flows.

## Protocol Support

Akto supports testing across multiple protocols used in agentic systems:

**REST & GraphQL**: Tests HTTP-based agent endpoints and tool integrations.

**gRPC**: Validates agent-to-agent communication and microservice interactions.

**WebSocket**: Tests real-time agent streams and persistent connections.

**MCP (Model Context Protocol)**: Specialized testing for MCP server implementations and tool definitions.
