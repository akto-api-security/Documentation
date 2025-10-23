---
description: Intelligent rate limiting and abuse prevention for AI agents and agentic systems.
---

# Agent Rate Limiting & Abuse Prevention

## Akto's Next-Gen Agent Rate Limit Discovery

Traditional rate limits require predefined request-per-minute (RPM) thresholds per endpoint. At scale (hundreds of agent components), this is impractical. As agentic systems evolve, traffic patterns change dramatically, making static limits brittle and ineffective.

Agent traffic varies significantly by component type (e.g., `/chat-agent` vs `/data-retrieval-agent`) and over time (e.g., peak usage hours, marketing campaigns, or viral AI features). Akto learns per-component baselines and adapts as patterns shift, providing intelligent protection against agent abuse.

## Key Innovations

**Adaptive Learning**: Learns real agent usage patterns over time
- Analyzes historical invocation patterns for each agent component
- Distinguishes between normal usage spikes and abusive behavior
- Continuously updates baselines as your agentic system evolves

**Component-Specific Baselines**: Builds per-component rate limits
- Different limits for different agent types (chat agents, tool agents, MCP servers)
- Accounts for varying computational costs of different agents
- Adapts to individual component characteristics

**Dynamic Adaptation**: Adjusts to traffic spikes and longer-term shifts
- Handles legitimate usage increases gracefully
- Detects and blocks abnormal agent invocation patterns
- Protects against resource exhaustion and denial-of-service

## How to Configure

By default, Akto Threat Protection applies a global rate limit rule to all agent components.

To change settings, go to **Settings → Threat Configuration → Agent Rate Limits**.

### Default Configuration

Global dynamic rule that auto-learns per-component baselines over 2 days. Uses p75 with 20% overflow and 0.5 confidence to throttle anomalies.

**Configuration Parameters:**

- **Rule Name**: `Global Agent Rate Limit Rule`
  - Applies to all agent components unless overridden

- **Period**: `5 minutes`
  - Sliding window duration for rate limit calculations

- **Behaviour**: `Dynamic`
  - Uses auto-learned limits based on historical traffic
  - Alternative: Static (manual threshold definition)

- **Baseline Period**: `2 days`
  - Days used to learn agent usage patterns
  - Longer periods provide more stable baselines

- **Percentile**: `p75`
  - Requests made by 75% of users/agents
  - Higher percentiles (p90, p95) allow more bursting

- **Overflow Percentage**: `20`
  - Allowed burst above baseline (20% = 1.2x baseline)
  - Accommodates legitimate usage spikes

- **Rate Limit Confidence**: `0.5`
  - Minimum confidence in learned patterns before enforcement
  - Higher values reduce false positives but may miss attacks

## Agent-Specific Use Cases

### Protecting Expensive Agents

For computationally expensive agents (e.g., complex RAG pipelines, multi-step reasoning):
- Lower overflow percentage to prevent resource exhaustion
- Shorter baseline period to adapt quickly to changes
- Higher confidence threshold to avoid blocking legitimate users

### Protecting Public-Facing Chat Agents

For customer-facing chat agents:
- Higher percentile (p90) to accommodate usage variability
- Moderate overflow for peak hours
- Lower confidence to ensure abuse is caught quickly

### MCP Server Rate Limits

For MCP tool invocations:
- Component-specific rules per tool type
- Lower limits for expensive operations (file writes, database queries)
- Higher limits for read-only operations

## Custom Rate Limit Rules

You can create custom rules for specific agent components or collections:

1. Navigate to **Settings → Threat Configuration → Custom Rate Limits**
2. Click **Add Rule**
3. Select agent collection or specific components
4. Configure parameters based on component characteristics
5. Enable monitoring mode to test before enforcement

## Monitoring and Alerts

Akto provides real-time monitoring of rate limit enforcement:

- **Blocked Requests**: View blocked agent invocations in real-time
- **User Patterns**: Identify users or systems triggering limits
- **False Positives**: Review and adjust rules based on blocks
- **Alert Configuration**: Set up notifications for rate limit violations