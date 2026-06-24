# Session-Based Guardrails

## Overview

Session-based guardrails enable stateful, context-aware threat detection by maintaining session memory across multiple agent interactions. When your agent includes a session ID in the request header, Akto automatically analyzes prompts within the context of that entire session's history rather than evaluating each prompt in isolation.

This enables detection of threats that only become visible across multiple interactions, such as behavioral anomalies, gradual privilege escalation attempts, and incremental data exfiltration patterns.

## How Session-Based Guardrails Work

Akto's guardrail evaluation operates in two modes:

### Standard Guardrails (Stateless)
- Evaluate each prompt independently against configured policies
- No context from previous interactions
- Effective for detecting single-prompt threats (credentials in user input, prompt injection, etc.)
- Resets between requests

### Session-Based Guardrails (Stateful)
- Evaluate prompts within the context of the entire session's conversation history
- Maintain session memory across multiple interactions
- Correlate patterns across multiple prompts within a session
- Detect threats that emerge only when viewed across a timeline

**Automatic Activation**: Session-based guardrails activate automatically when your agent includes a session ID in the request header. No additional configuration is required on Akto's side.

## Standard vs Session-Based Guardrails

| Aspect | Standard Guardrails | Session-Based Guardrails |
|--------|-------------------|-------------------------|
| **Analysis Scope** | Individual prompt | Session conversation history |
| **Context** | Current prompt only | Full interaction timeline |
| **Memory** | None | Session memory maintained |
| **Threat Detection** | Single-prompt threats | Multi-interaction patterns |
| **Activation** | Always active | Via `X-Session-ID` header |
| **Use Case** | Quick, stateless checks | Behavioral analysis, anomaly detection |

## When to Use Session-Based Guardrails

Deploy session-based guardrails when you need to detect threats that span multiple interactions:

- **Behavioral Anomalies**: Detect unusual patterns in agent behavior across consecutive requests (e.g., privilege escalation attempts, role changes, access pattern drift)
- **Gradual Exfiltration**: Identify slow, incremental data leakage across multiple prompts (small amounts per request, cumulative risk)
- **Privilege Escalation**: Detect patterns of incrementally requesting higher permissions or access levels
- **Prompt Injection Chains**: Identify coordinated injection attempts across multiple turns
- **Session Compromise**: Detect indicators that a user session may have been compromised
- **Policy Violation Escalation**: Track progressive violations of guardrail policies within a session

## How to Enable Session-Based Guardrails

Enabling session-based guardrails is automatic and requires no configuration on Akto's side.

### Steps:

1. **Generate a Session ID**: Your agent generates a unique identifier for each user session
2. **Include in Request Header**: Attach the session ID to the `X-Session-ID` header when sending requests to Akto's guardrail service
3. **Automatic Activation**: Akto automatically detects the session ID and enables session-based threat detection

### Example Request Header

```
X-Session-ID: session_abc123xyz789
```

### Integration Points

Session IDs can be passed via:
- **Guardrail Service API**: Include `X-Session-ID` header in direct API calls
- **Proxy Integration**: Proxy layer forwards the session ID header to Akto
- **Other Integration Methods**: Any integration that preserves the `X-Session-ID` header

{% hint style="info" %}
**Need Help**

If you want session-based guardrails enabled for your agents, please contact the Akto support team for assistance with provisioning and setup.
{% endhint %}

## Benefits of Session-Based Guardrails

### 1. Enhanced Threat Detection
Detects sophisticated attacks that disguise themselves across multiple interactions rather than appearing malicious in a single prompt.

### 2. Behavioral Context
Provides guardrails with the full conversation context, enabling detection of behavioral drift and anomalous patterns.

### 3. Anomaly Scoring
Correlates actions across a session timeline to identify statistically unusual behavior that would appear benign in isolation.

### 4. Compliance & Audit
Maintains session-scoped audit trails for compliance requirements, enabling investigation of user behavior across full sessions.

### 5. User-Centric Detection
Moves from prompt-level detection to user-session-level detection, reducing false positives caused by legitimate context switches.

## Related Concepts

- [[agent-guard]] — Complete reference of all guardrail types and their capabilities
- [[guardrail-activity]] — Monitoring and analyzing guardrail detections across sessions
- [[threat-dashboard]] — Dashboard visualization of threats including session-scoped analysis
