# Create Guardrail Policies

## Overview

The **Create Guardrail Policies** page allows you to define enforcement rules that evaluate agent requests and responses against security, safety, and compliance criteria.

Each guardrail policy combines metadata, content filters, detection logic, and deployment scope into a single configuration that applies consistently across selected agents and servers.

## Access Guardrail Policies

You can access guardrail policy configuration from the Akto console.

* Navigate to the **Agentic Security** product.
* Select **Agentic Guardrails → Guardrail Policies**.

The guardrail policies list displays existing policies and provides access to policy creation.

## Create a Guardrail Policy

### Access the Create Guardrail Form

1. Locate the **Create Guardrail** button in the top-right corner of the Guardrail Policies page.
2.  Select **Create Guardrail** to open the guardrail configuration form.

    <figure><img src="../../.gitbook/assets/image (27).png" alt="" width="563"><figcaption></figcaption></figure>

### Fill the Configuration Form

The configuration form is organised into 13 sections, each targeting a specific enforcement layer. Only **Policy Details** is required. Select a section to open its fields.

| # | Form section | What it controls |
|---|---|---|
| 1 | [Policy Details (mandatory)](guardrail-policy-fields/policy-details-and-scope.md#provide-guardrail-policy-details-mandatory) | Name, description, severity, blocked message |
| 2 | [Content and Policy Guardrails](guardrail-policy-fields/content-and-language-safety.md#content-and-policy-guardrails) | Prompt injection, context poisoning, denied topics, harmful categories, intent |
| 3 | [Language Safety and Abuse](guardrail-policy-fields/content-and-language-safety.md#language-safety-and-abuse-guardrails) | Gibberish, sentiment, profanity |
| 4 | [Sensitive Information](guardrail-policy-fields/sensitive-data-and-code.md#sensitive-information-guardrails) | PII, regex, secrets, anonymisation |
| 5 | [Advanced Code Detection](guardrail-policy-fields/sensitive-data-and-code.md#advanced-code-detection-filters) | Code detection, ban code |
| 6 | [Custom Guardrails](guardrail-policy-fields/custom-usage-and-anomaly.md#custom-guardrails) | LLM prompt rule, LLM redaction, external model |
| 7 | [Usage Based](guardrail-policy-fields/custom-usage-and-anomaly.md#usage-based-guardrails) | Token limit |
| 8 | [Anomaly Detection](guardrail-policy-fields/custom-usage-and-anomaly.md#anomaly-detection) | Statistical, structural, behavioral anomalies |
| 9 | [Enterprise License Compliance](guardrail-policy-fields/tool-and-enterprise.md#enterprise-license-compliance-guardrails) | Provider acceptable-use categories |
| 10 | [Tool Guardrails](guardrail-policy-fields/tool-and-enterprise.md#tool-guardrails) | Tool misuse, malicious tool, name/description mismatch |
| 11 | [Access Restrictions](guardrail-policy-fields/access-restrictions-and-exceptions.md#access-restrictions) | Block host/path, personal accounts, public sharing |
| 12 | [Exceptions](guardrail-policy-fields/access-restrictions-and-exceptions.md#exceptions) | Ignore phrases |
| 13 | [Scope](guardrail-policy-fields/policy-details-and-scope.md#scope) | Assets, users, devices, rule behaviour, request/response |

### Save the Guardrail Policy

After completing the required and optional configurations:

* Click on **Create Policy** to save the policy and apply enforcement to the selected scope.

## Test guardrail behaviour in the playground

The playground allows your team to validate guardrail behaviour before updating the policy.

* Enter a prompt in the **Test your guardrail policy** field to simulate a request against the configured guardrail policy.
* The playground evaluates the prompt using the selected guardrail configuration and displays the enforcement result.
* You can also use the **Quick Test Prompts** provided in the playground to test common scenarios such as sensitive data exposure, prompt injection attempts, or abusive language.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (1) (1).png" alt="" width="563"><figcaption></figcaption></figure></div>

Playground probing helps your security team verify that guardrail conditions correctly detect violations and return the expected blocked response message before the policy is finalized.

## Preview Change Impact Before Saving

When you edit an existing guardrail policy, the right-hand panel shows **Change impact analysis** instead of the plain **Impact analysis** view shown while creating a new policy. It replays recent activity through both the currently saved policy and your unsaved changes, so you can see how an edit would affect detections before you save it.

* Switch between the **Violations** and **Traffic** tabs before running:
  * **Violations** replays the policy's last few recorded violations.
  * **Traffic** replays the latest agent traces.
* Select **Run** to open the **Change impact analysis** window and replay that activity against both versions of the policy.
* The **Saved policy** and **Your changes** counts show the total detections under each version, with a badge (e.g. `-1`) highlighting the net change.
* The results table lists each replayed **Prompt** alongside two columns, **Saved** and **Draft**, each marked **Detected** or **Missed** so you can see exactly which prompts change outcome under your edits.
* Use **Page Size** and the pagination controls to page through results, or select **Export CSV** to download the full comparison.
* Select **Close** to return to the policy editor.

{% hint style="info" %}
Change impact analysis is only available when editing an existing guardrail policy. While creating a new policy, this panel appears as **Impact analysis** and previews how the new policy would perform against recent agent traffic once you select **Run**.
{% endhint %}

## What’s Next

You can modify, disable, or delete existing guardrail policies after creation.

To continue, learn how to manage guardrail policies from the [manage-guardrail-policies.md](manage-guardrail-policies.md "mention").
