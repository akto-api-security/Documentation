---
description: Real-time threat protection for AI agents and MCP endpoints
---

# Overview

Akto Guardrails provides real-time protection for AI agents, LLM components, and MCP endpoints. This module detects and blocks agentic threats as they occur, protecting your autonomous systems from prompt injections, tool abuse, and unauthorized access patterns. With customizable policies, you can tailor detection rules to meet your specific agentic security needs.

#### Getting Started

To enable Akto Guardrails, set the following environment variable in your Akto traffic connector module: `AKTO_THREAT_ENABLED=true`

Supported traffic connectors for Guardrails:
- [MCP Scan](../traffic-connector/mcp-scan/README.md)
- [Agentic Scan](../traffic-connector/agentic-scan/README.md)
- [eBPF Traffic Connector](../traffic-connector/ebpf/README.md)
- [Kubernetes Traffic Connector](../traffic-connector/kubernetes/kubernetes.md)
- [Virtual Machines Traffic Connector](../traffic-connector/virtual-machines/README.md)

### Key Features

- **Real-Time Threat Detection**: Identify and respond to agentic security threats as they occur
- **OWASP Core Rule Set Support**: Detect common attack patterns including XSS and SQL injection in agent interactions
- **Prompt Injection Protection**: Block malicious prompts attempting to manipulate agent behavior
- **Tool Permission Enforcement**: Prevent unauthorized tool access and permission escalation
- **Schema Conformance**: Ensure agent requests comply with expected MCP schemas
- **Geofencing**: Restrict agent component access based on geographic locations
- **IP-Based Blocking**: Block or allow traffic from specific IP addresses or CIDR ranges



