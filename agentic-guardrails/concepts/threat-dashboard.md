# Threat Dashboard

## Overview

The Threats dashboard provides a centralised view of security threats detected across **AI agents, prompts, and tool invocations**. The Threats dashboard focuses on **runtime agentic security risks**, including prompt injection, unauthorised tool access, sensitive data leakage, and malicious agent behaviour.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (123).png" alt="" width="563"><figcaption></figcaption></figure></div>

## Threat States and Lifecycle

The main table lists all detected agentic security threats. Each row represents a consolidated security finding derived from one or more prompts, tool calls, or agent executions.

Threats are organized into the following operational states:

* **Active**\
  Threats that require investigation or remediation.
* **Under Review**\
  Threats currently being analyzed or validated.
* **Ignored**\
  Threats marked as non-actionable for the environment.

This lifecycle enables structured triage while preserving full execution context.

## Threat Attributes Displayed

Each threat entry includes the following attributes:

<table><thead><tr><th width="193.6640625">Attribute</th><th>Description</th></tr></thead><tbody><tr><td><strong>Severity</strong></td><td>Represents the risk level of the agentic threat based on exploitability and potential security impact.</td></tr><tr><td><strong>Threat Name</strong></td><td>Identifies the detected agentic security issue, such as prompt injection, excessive sensitive data exposure, or unauthorized tool access.</td></tr><tr><td><strong>Detection Type</strong></td><td>Indicates the detection category used to identify the threat, such as single-prompt analysis or tool invocation analysis.</td></tr><tr><td><strong>Number of Endpoints</strong></td><td>Indicates the count of agent-accessible endpoints or tools affected by the threat.</td></tr><tr><td><strong>Domains</strong></td><td>Lists the domains or agent platforms where the threat activity was observed.</td></tr><tr><td><strong>Compliance Mapping</strong></td><td>Shows the governance and compliance frameworks impacted by the detected agent behavior.</td></tr><tr><td><strong>Discovered</strong></td><td>Displays the timestamp when Akto first detected the threat.</td></tr></tbody></table>

## Compliance-Based Threat Filtering

#### Compliance Framework Selector

The Threats dashboard allows filtering agentic threats by compliance framework to support governance and audit workflows.

<figure><img src="../../.gitbook/assets/image (128).png" alt="" width="375"><figcaption></figcaption></figure>

Supported frameworks include:

* CIS Controls
* CMMC
* CSA CCM
* FedRAMP
* FISMA
* GDPR
* HIPAA
* ISO 27001
* NIST 800-53
* NIST 800-171
* SOC 2
* OWASP

This filter helps you focus on agent behaviours that directly impact regulatory and internal security requirements.

## Navigating to Guardrail Activity Details

From the Threats dashboard, you can navigate to detailed guardrail activity views for request- and prompt-level investigation.

Selecta threat from the Threats dashboard opens the **Guardrail Activity Detailed View**, which provides execution-level visibility into how the threat was detected.

From the detailed view, you can analyse:

* Prompts associated with the threat
* Tool invocations triggered by the agent
* Sensitive data accessed or exposed
* Guardrails violated during execution
* Repeated or anomalous agent behaviour patterns

Detailed documentation for this investigation flow is available at:

[👉 **Guardrail Activity Detailed View**](../how-to/guardrail-activity-detailed-view.md)
