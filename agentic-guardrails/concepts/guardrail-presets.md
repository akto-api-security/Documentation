# Guardrail Presets

## Overview

A Guardrail Preset is a pre-filled starting point for a guardrail policy, built around a specific regulatory, industry, or security framework. Selecting a preset opens the same guardrail configuration form used for manual policy creation, with filters, denied topics, and sensitive data settings already populated to match that framework.

Access presets from the **Presets** dropdown on the **Guardrail Policies** page (**Agentic Security → Agentic Guardrails → Guardrail Policies**).

## How Presets Work

A preset only changes the form's starting values. It does not create or enforce a policy by itself.

1. Select a framework from the **Presets** dropdown.
2. Review the pre-filled configuration and adjust it for your environment.
3. Set **Scope** and **Rule Behaviour** as you would for any policy.
4. Save the policy with **Create Policy**.

Nothing is created or enforced until you save, so you can open and discard a preset without affecting existing policies. For details on each form field, see [Create Guardrail Policies](../how-to/create-guardrail-policies.md).

## Available Presets

| Preset | Focus |
|--------|-------|
| **HIPAA** | Protecting health information handled by agents |
| **PCI DSS Guardrail** | Detecting exposure of payment card data |
| **SOC 2 Compliance** | Security, availability, and confidentiality controls |
| **OWASP Agentic Top 10** | Risks specific to autonomous agent behavior |
| **OWASP LLM Top 10** | Common risks in LLM-based applications |
| **NIST AI Risk Management Framework** | AI risk governance |
| **CIS Controls** | Baseline cybersecurity safeguards |
| **CMMC** | Controls for U.S. defense contractors |
| **CSA CCM** | Cloud security controls |
| **FISMA** | Controls for federal information systems |
| **FedRAMP** | Authorization for federal cloud services |
| **ISO 27001** | Information security management |
| **NIST 800-171** | Protecting sensitive government information |
| **NIST 800-53** | Federal security and privacy controls |
| **OWASP** | General web application security risks |
| **MITRE ATLAS** | Adversarial threats to AI and ML systems |

The list can grow as Akto adds support for more frameworks. Check the **Presets** dropdown in your console for the current list.

## Why Use Presets

* **Faster setup** for a known compliance or security requirement.
* **Fewer gaps**, since the preset already covers control categories the framework typically expects.
* **Fully editable** — a preset is a starting point, not a fixed template.

## Related Concepts

* [Guardrail Policy](threat-policy.md) — what a guardrail policy enforces
* [Create Guardrail Policies](../how-to/create-guardrail-policies.md) — the form presets pre-fill
* [Manage Guardrail Policies](../how-to/manage-guardrail-policies.md) — editing, disabling, and deleting policies
* [Threat Dashboard](threat-dashboard.md) — filter detections by compliance framework
* [Guardrail Activity Detailed View](../how-to/guardrail-activity-detailed-view.md) — see which frameworks a detection maps to
