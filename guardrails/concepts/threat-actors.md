# Guardrail Actors

## What are **Guardrail Actors?**

Guardrail actors are individuals, groups, or entities responsible for carrying out malicious activities targeting your AI agents, MCP endpoints, and autonomous systems. They are often motivated by financial gain, espionage, ideology, or disruption. Guardrail actors targeting agentic systems may attempt prompt injections, tool abuse, data exfiltration through agent interactions, or unauthorized access to agent capabilities. They can range from lone hackers to organized crime groups, nation-states, or insider threats.

## **Key Metrics to Monitor**

**Critical Actors**: Guardrail actors posing a high risk to your agentic systems due to their capability and intent

**Active Actors**: The total number of guardrail actors currently engaging in malicious activities against agent components

**Guardrail Activity Timeline**: Tracks the frequency and volume of attacks over time (e.g., agent component invocations, tool abuse attempts)

**Guardrail Actor Map**: Geographically maps the origin of guardrail actors targeting your autonomous systems

<figure><img src="../../.gitbook/assets/image (9) (1).png" alt="" width="563"><figcaption></figcaption></figure>

## Threat Actor Types and Observed Attributes

Akto identifies threat actors based on interaction origin and records contextual metadata for agentic security investigation.

### Threat Actor Classification

**User**\
A User represents an external or internal client that directly interacts with agentic endpoints or tools. User actors typically invoke completion APIs, public agent endpoints, or tool execution interfaces.&#x20;

**MCP Server**\
An MCP Server represents a machine-to-machine actor participating in agent workflows through the Model Context Protocol. MCP Server actors commonly invoke tools or exchange agent context indirectly.&#x20;

### Threat Actor Attributes

<table><thead><tr><th width="150.8515625">Attribute</th><th>Description</th><th>Investigation Value</th></tr></thead><tbody><tr><td>Actor ID</td><td>Unique identifier derived from the source IP address or MCP identity.</td><td>Enables correlation of events across agent workflows.</td></tr><tr><td>Actor IP</td><td>Network address associated with the actor.</td><td>Supports network-level investigation and blocking decisions.</td></tr><tr><td>Country</td><td>Geolocation inferred from the actor IP.</td><td>Helps identify regional anomalies and risk patterns.</td></tr><tr><td>IP Reputation</td><td>Third-party–provided reputation metadata associated with the actor IP.</td><td>Prioritises high-risk actors for review.</td></tr><tr><td>Latest Host</td><td>Hostname or service last accessed by the actor.</td><td>Identifies the infrastructure surface targeted.</td></tr><tr><td>Latest Agentic Component</td><td>Most recent agent endpoint or tool invoked.</td><td>Shows which agent capability was targeted.</td></tr><tr><td>Latest Policy Triggered</td><td>Guardrail policy violated by the actor.</td><td>Indicates the agentic risk category observed.</td></tr><tr><td>Rule Violated</td><td>Specific rule within the policy that was breached.</td><td>Provides granular context for root-cause analysis.</td></tr><tr><td>Access Type</td><td>Mode of access used during the interaction.</td><td>Distinguishes public, internal, or privileged access paths.</td></tr><tr><td>Sensitive Data</td><td>Indicator of whether sensitive data was involved.</td><td>Highlights potential data exposure or leakage risk.</td></tr><tr><td>Status</td><td>Current state of the detection.</td><td>Shows whether the threat is active or resolved.</td></tr><tr><td>Detected At</td><td>Timestamp of initial detection.</td><td>Supports incident timeline reconstruction.</td></tr></tbody></table>

{% hint style="success" %}
## Note

IP reputation information is sourced from a third-party threat intelligence provider and includes contextual signals such as ISP, usage type, abuse reports, and whitelist status.&#x20;

Akto consumes this data for risk context and does not generate or modify reputation scores.
{% endhint %}

The structured visibility helps you to correlate actor behavior across users, tools, and agent workflows without relying on manual log analysis.
