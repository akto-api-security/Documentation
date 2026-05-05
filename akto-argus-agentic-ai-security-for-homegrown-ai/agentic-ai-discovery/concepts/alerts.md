---
description: Configure webhook alerts to stay informed about changes and security issues in your agentic systems.
---

# Alerts

Configuring alerts in Akto helps you stay informed about the latest developments in your agentic infrastructure. Alerts enable proactive monitoring and rapid response to security issues, new discoveries, and system changes.

## Why Alerts Matter for Agentic Systems

AI agents and MCP servers are dynamic systems that evolve rapidly. Alerts help you:

- **Detect New Agents**: Know immediately when new agents or MCP servers are discovered
- **Monitor Security**: Get notified about new vulnerabilities in agent components
- **Track Sensitive Data**: Alert when agents start handling sensitive information
- **Prevent Breaches**: Rapid notification enables quick incident response
- **Ensure Compliance**: Track changes that might affect compliance posture

## Alert Types

### Discovery Alerts

**New Agent Components**
- Alert when new AI agents are discovered in your inventory
- Includes agent framework, LLM provider, and capabilities
- Helps track shadow agents and unauthorized deployments

**New MCP Endpoints**
- Notification when new MCP servers or tools are detected
- Details about tool permissions and resource access
- Identify potentially risky MCP integrations

**Sensitive Data Detection**
- Alert when an agent component starts processing sensitive data
- Includes data type (PII, credentials, financial, etc.)
- Helps maintain data governance

**Configuration Changes**
- Notification when agent configurations change
- MCP server permission changes
- Authentication method updates

### Security Alerts

**New Vulnerabilities**
- Daily or real-time updates on security issues found by Akto
- Includes severity, affected components, and remediation guidance
- Prompt injection, tool misuse, data leakage, etc.

**Critical Findings**
- Immediate alerts for high-severity vulnerabilities
- Production agent security issues
- Unauthorized access attempts
- MCP tool abuse

**Risk Score Changes**
- Alert when an agent's risk score increases
- Helps prioritize security efforts
- Tracks security posture over time

### Operational Alerts

**Traffic Monitoring**
- Alert if Akto stops receiving traffic for an agent collection
- Helps identify monitoring gaps or agent failures
- Ensures continuous visibility

**Anomaly Detection**
- Unusual traffic patterns in agent communications
- Unexpected tool invocations by MCP servers
- Abnormal LLM token usage

**Performance Issues**
- Agent response time degradation
- MCP tool failures or errors
- Rate limit violations

## Alert Channels

Akto supports multiple notification channels:

### Webhook Alerts
- POST notifications to your webhook endpoint
- Custom JSON payloads with alert details
- Integrate with any system supporting webhooks

### Common Integrations
- **Slack**: Real-time team notifications
- **Microsoft Teams**: Enterprise messaging
- **PagerDuty**: On-call escalation
- **Jira**: Automatic ticket creation
- **Email**: Traditional email notifications
- **Custom SIEM**: Security information and event management