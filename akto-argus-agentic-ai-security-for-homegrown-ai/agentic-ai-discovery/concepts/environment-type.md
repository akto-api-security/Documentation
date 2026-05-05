---
description: Categorize agent and MCP collections by environment for better security management and scanning prioritization.
---

# Environment Type

The Environment Type feature in Akto allows users to tag agent and MCP collections as Development, Staging, or Production. This helps teams prioritize AI Red Teaming and triage alerts based on the environment's criticality.

## What is Environment Type?

Environment Type is a classification that helps you organize your agentic systems by deployment stage. This distinction is crucial for applying appropriate security policies and managing scanning efforts effectively.

### Available Environment Types

- **Development**: Agent components under active development and scanning
- **Staging**: Pre-production agents being validated before release
- **Production**: Live, customer-facing agent systems

## Benefits

### 1. Tagging Collections

Label agent and MCP collections by environment for better organization:
- Quickly identify which agents are in production
- Separate scanning and development systems
- Track agent lifecycle across environments

### 2. Environment-Specific Scanning

Adjust AI Red Teaming efforts based on the environment:
- **Production**: Prioritize critical security probes, limit intrusive scanning
- **Staging**: Run comprehensive security scan suites
- **Development**: Enable aggressive scanning and experimentation

This prevents unnecessary or risky probe in production while ensuring thorough security validation in pre-production environments.

### 3. Efficient Alert Triaging

Alerts and security findings are automatically prioritized based on environment:
- **Production Alerts**: Highest priority - immediate attention required
- **Staging Alerts**: Medium priority - fix before promotion
- **Development Alerts**: Lower priority - address during development

For example, a prompt injection vulnerability detected in a production agent triggers a critical alert, while the same issue in development is tracked for resolution but doesn't create an incident.

## Use Cases

### Security Prioritization

- Focus red teaming efforts on production agents first
- Validate fixes in staging before production deployment
- Experiment with new security probes in development

### Compliance Management

- Ensure production agents meet compliance requirements
- Track which environments handle sensitive data
- Audit security controls by environment

### Resource Optimization

- Allocate security resources based on environment criticality
- Reduce scanning overhead in production
- Increase probe coverage in pre-production environments

### Change Management

- Track agent promotions across environments
- Validate security posture before production deployment
- Monitor configuration drift between environments

## How It Works with Agentic Systems

### For AI Agents

- Development agents can probe experimental prompts and tools
- Staging agents validate security before customer exposure
- Production agents have stricter monitoring and controls

### For MCP Servers

- Development MCP servers can have relaxed permissions for probing
- Staging MCP servers mirror production configuration
- Production MCP servers have strict access controls and auditing

