# Threat Dashboard

## Overview

The Threats dashboard provides a centralised view of security threats detected across API traffic. The Threats dashboard focuses on **runtime API security risks**, including authorization flaws, sensitive data exposure, and malicious request patterns observed during live API interactions.

This view helps you identify vulnerable APIs, understand the security impact of each issue, and prioritise remediation based on severity, exposure, and compliance requirements.

<div data-with-frame="true"><figure><img src="../.gitbook/assets/Screenshot 2026-02-09 at 1.33.36 PM.png" alt="" width="563"><figcaption></figcaption></figure></div>

### Threat States and Lifecycle

The main table lists all detected API threats. Each entry represents a consolidated security finding derived from one or more API requests.

Threats are organised into the following operational states:

* **Active**\
  Threats that require investigation or remediation.
* **Under Review**\
  Threats currently being analysed or validated.
* **Ignored**\
  Threats marked as non-actionable for the environment.

This lifecycle allows structured triage without suppressing underlying detection signals.

## Threat Metadata Fields

The following table describes each column displayed in the **Threats** dashboard and explains how the data supports API security analysis.

<table><thead><tr><th width="186.6015625">Field</th><th>Description</th></tr></thead><tbody><tr><td><strong>Severity</strong></td><td>Indicates the risk level of the detected API security issue based on exploitability and potential impact on data or access control.</td></tr><tr><td><strong>Threat Name</strong></td><td>Identifies the type of API security vulnerability detected, such as Broken Object Level Authorization (BOLA) or parameter manipulation.</td></tr><tr><td><strong>Detection Type</strong></td><td>Specifies the detection logic or rule that identified the API security issue based on request behavior and access patterns.</td></tr><tr><td><strong>Number of Endpoints</strong></td><td>Represents the count of unique API endpoints affected by the same security issue.</td></tr><tr><td><strong>Domains</strong></td><td>Lists the API domains where the vulnerable endpoints were observed.</td></tr><tr><td><strong>Compliance Mapping</strong></td><td>Shows the compliance frameworks impacted by the detected API security issue, enabling regulatory and audit alignment.</td></tr><tr><td><strong>Discovered Timestamp</strong></td><td>Indicates the date when Akto first detected the API security threat.</td></tr></tbody></table>

## Compliance-Based Threat Filtering

#### Compliance Framework Selector

The Threats dashboard allows you to filter threats by compliance framework to support audit and governance workflows.

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
* PCI DSS
* SOC 2
* OWASP

<div data-with-frame="true"><figure><img src="../.gitbook/assets/Screenshot 2026-02-09 at 1.32.37 PM.png" alt="" width="563"><figcaption></figcaption></figure></div>

The filter helps you isolate API risks that directly impact specific regulatory or security standards.

## Navigating to Threat Breakdown

Selecting any threat from the Threats dashboard opens the **Threat Activity Breakdown** view. The Threat Activity Breakdown view provides request-level visibility into how the threat was identified.

From that view, you can analyse:

* API endpoints involved in the threat
* HTTP methods and request patterns
* Parameters contributing to the violation
* Repeated or anomalous access behaviour

Detailed documentation for request-level analysis is covered separately in the following page:

[👉 **View Threat Activity Breakdown**<br>](../api-protection/how-to/view-threat-activity-breakdown.md)
