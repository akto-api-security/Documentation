# Agent Guard

## Introduction

Akto's Agent Guard provides a comprehensive security layer for AI-powered applications through intelligent scanners that detect and prevent threats in real-time. This reference covers all scanners available in the Agent Guard system, grouped by what they protect against.

## What are Guardrails?

Guardrail scanners are specialized security modules that analyze content flowing through your AI systems. They act as intelligent checkpoints, examining both user inputs and AI-generated outputs to identify security threats, policy violations, data leaks, and content safety issues before they cause harm.

## How Guardrails Work

Akto's Agent Guard operates on a dual-layer approach:

* **Input Layer**: Guardrails validate user messages before they reach your AI models, blocking malicious prompts, credential leaks, and policy violations
* **Output Layer**: Guardrails verify AI-generated responses before delivery to users, preventing data exposure, harmful content, and compliance violations

Each scanner specializes in detecting specific guardrail categories, from credential exposure and prompt injection attacks to toxic content and sensitive data leaks. Guardrails can be combined to create custom security policies tailored to your application's needs.

## When to Use Which Guardrails

**For Agentic Applications**:

* Use input scanners to protect your AI endpoints from malicious prompts
* Use output scanners to prevent your AI from exposing API vulnerabilities or credentials

**For Customer-Facing Applications**:

* Deploy content safety scanners (Toxicity, Bias, BanTopics) to maintain appropriate communication
* Enable PII detection scanners (Sensitive, Secrets) to ensure privacy compliance

**For Enterprise AI Systems**:

* Implement comprehensive scanner suites covering security, compliance, and content policies
* Layer multiple scanners for defense-in-depth protection

## Scanner Reference

Each scanner entry includes its purpose, detection capabilities, risk prevention benefits, use cases, and example detections. Select a scanner to open its entry, or see the category pages in the sidebar. The last column shows where to configure the scanner in the [guardrail policy form](../how-to/create-guardrail-policies.md).

| Scanner | What it does | Direction | Category | Policy form section |
|---|---|---|---|---|
| [PromptInjection](agent-guard/prompt-and-agent-attacks.md#promptinjection-guardrail) | Detects attempts to manipulate AI system instructions or bypass security controls | Input | Prompt and Agent Attacks | [Content and Policy Guardrails](../how-to/guardrail-policy-fields/content-and-language-safety.md#content-and-policy-guardrails) |
| [Context Poisoning](agent-guard/prompt-and-agent-attacks.md#context-poisoning-guardrail) | Detects and blocks attempts to poison agent memory, context, or conversation state | Input | Prompt and Agent Attacks | [Content and Policy Guardrails](../how-to/guardrail-policy-fields/content-and-language-safety.md#content-and-policy-guardrails) |
| [Behavioural Anomaly](agent-guard/prompt-and-agent-attacks.md#behavioural-anomaly-guardrail) | Identifies abnormal or suspicious input patterns based on historical interaction behavior | Input and output | Prompt and Agent Attacks | [Anomaly Detection](../how-to/guardrail-policy-fields/custom-usage-and-anomaly.md#anomaly-detection) |
| [Intent](agent-guard/prompt-and-agent-attacks.md#intent-guardrail) | Enforces policies based on the inferred intent of incoming requests | Input and output | Prompt and Agent Attacks | [Content and Policy Guardrails](../how-to/guardrail-policy-fields/content-and-language-safety.md#content-and-policy-guardrails) |
| [Tool Guardrails](agent-guard/prompt-and-agent-attacks.md#tool-guardrails) | Detects and blocks malicious or untrusted tools before execution | Input and output | Prompt and Agent Attacks | [Tool Guardrails](../how-to/guardrail-policy-fields/tool-and-enterprise.md#tool-guardrails) |
| [Block Host/Path](agent-guard/prompt-and-agent-attacks.md#block-hostpath-guardrail) | Prevents agents from making outbound requests to unauthorised hosts or paths | Input | Prompt and Agent Attacks | [Access Restrictions](../how-to/guardrail-policy-fields/access-restrictions-and-exceptions.md#access-restrictions) |
| [Secrets](agent-guard/data-protection.md#secrets-guardrail) | Detects exposed credentials, API keys, tokens, and passwords in user messages | Input | Data Protection | [Sensitive Information](../how-to/guardrail-policy-fields/sensitive-data-and-code.md#sensitive-information-guardrails) |
| [Anonymize and Deanonymize](agent-guard/data-protection.md#anonymize-and-deanonymize-guardrail) | Automatically removes or masks personally identifiable information (PII) | Input and output | Data Protection | [Sensitive Information](../how-to/guardrail-policy-fields/sensitive-data-and-code.md#sensitive-information-guardrails) |
| [Sensitive](agent-guard/data-protection.md#sensitive-guardrail) | Detects personally identifiable information (PII) and sensitive data in AI outputs | Output | Data Protection | [Sensitive Information](../how-to/guardrail-policy-fields/sensitive-data-and-code.md#sensitive-information-guardrails) |
| [Regex Pattern](agent-guard/data-protection.md#regex-pattern-guardrail) | Detects and filters sensitive information using custom regex patterns | Input | Data Protection | [Sensitive Information](../how-to/guardrail-policy-fields/sensitive-data-and-code.md#sensitive-information-guardrails) |
| [LLM Based Redaction](agent-guard/data-protection.md#llm-based-redaction-guardrail) | Masks sensitive content in user prompts using a plain-language redaction instruction, instead of blocking the request outright | Input and output | Data Protection | [Custom Guardrails](../how-to/guardrail-policy-fields/custom-usage-and-anomaly.md#custom-guardrails) |
| [Personal Account](agent-guard/data-protection.md#personal-account-guardrail) | Detects and blocks access from users authenticated using personal accounts instead of organization-approved accounts | Input | Data Protection | [Access Restrictions](../how-to/guardrail-policy-fields/access-restrictions-and-exceptions.md#access-restrictions) |
| [MaliciousURLs](agent-guard/data-protection.md#maliciousurls-guardrail) | Identifies suspicious, malicious, or inappropriate URLs in AI responses | Output | Data Protection | Not a separate form field |
| [Toxicity](agent-guard/content-safety.md#toxicity-guardrail) | Identifies offensive, abusive, or harmful language in user inputs | Input and output | Content Safety | [Content and Policy Guardrails](../how-to/guardrail-policy-fields/content-and-language-safety.md#content-and-policy-guardrails) |
| [Profanity](agent-guard/content-safety.md#profanity-guardrail) | Detects and redacts offensive, abusive, or inappropriate language from inputs and outputs | Input and output | Content Safety | [Language Safety and Abuse](../how-to/guardrail-policy-fields/content-and-language-safety.md#language-safety-and-abuse-guardrails) |
| [Sentiment](agent-guard/content-safety.md#sentiment-guardrail) | Analyzes emotional tone and sentiment in user messages | Input and output | Content Safety | [Language Safety and Abuse](../how-to/guardrail-policy-fields/content-and-language-safety.md#language-safety-and-abuse-guardrails) |
| [Bias](agent-guard/content-safety.md#bias-guardrail) | Detects discriminatory, biased, or unfair content in AI responses | Output | Content Safety | Not a separate form field |
| [Relevance](agent-guard/content-safety.md#relevance-guardrail) | Ensures AI responses are relevant and on-topic to user queries | Output | Content Safety | Not a separate form field |
| [NoRefusal](agent-guard/content-safety.md#norefusal-guardrail) | Detects when AI inappropriately refuses to answer legitimate queries | Output | Content Safety | Not a separate form field |
| [BanTopics](agent-guard/topics-and-language.md#bantopics-guardrail) | Identifies messages discussing prohibited subjects or sensitive topics | Input and output | Topics and Language | [Content and Policy Guardrails](../how-to/guardrail-policy-fields/content-and-language-safety.md#content-and-policy-guardrails) |
| [BanCompetitors](agent-guard/topics-and-language.md#bancompetitors-guardrail) | Identifies and blocks mentions of competitor brands, products, or services | Input and output | Topics and Language | Not a separate form field |
| [BanSubstrings](agent-guard/topics-and-language.md#bansubstrings-guardrail) | Blocks messages containing specific words, phrases, or character patterns | Input and output | Topics and Language | Not a separate form field |
| [Language](agent-guard/topics-and-language.md#language-guardrail) | Validates that messages are in expected/allowed languages | Input and output | Topics and Language | Not a separate form field |
| [BanCode](agent-guard/code-detection.md#bancode-guardrail) | Detects code snippets, scripts, or programming commands in user messages | Input and output | Code Detection | [Advanced Code Detection](../how-to/guardrail-policy-fields/sensitive-data-and-code.md#advanced-code-detection-filters) |
| [Code](agent-guard/code-detection.md#code-guardrail) | Detects and identifies programming language used in messages | Input and output | Code Detection | [Advanced Code Detection](../how-to/guardrail-policy-fields/sensitive-data-and-code.md#advanced-code-detection-filters) |
| [LLM Prompt Rule](agent-guard/custom-and-compliance.md#llm-prompt-rule-guardrail) | Evaluates inputs against custom rules defined using LLM prompts | Input and output | Custom, Usage, and Compliance | [Custom Guardrails](../how-to/guardrail-policy-fields/custom-usage-and-anomaly.md#custom-guardrails) |
| [External Model Evaluation](agent-guard/custom-and-compliance.md#external-model-evaluation-guardrail) | Evaluates inputs using external model endpoints configured with custom security or validation criteria | Input and output | Custom, Usage, and Compliance | [Custom Guardrails](../how-to/guardrail-policy-fields/custom-usage-and-anomaly.md#custom-guardrails) |
| [Enterprise License Compliance](agent-guard/custom-and-compliance.md#enterprise-license-compliance-guardrail) | Blocks prompts that would breach your LLM provider's acceptable-use policy, protecting your organization's enterprise license standing | Input and output | Custom, Usage, and Compliance | [Enterprise License Compliance](../how-to/guardrail-policy-fields/tool-and-enterprise.md#enterprise-license-compliance-guardrails) |
| [Gibberish](agent-guard/custom-and-compliance.md#gibberish-guardrail) | Filters nonsensical, random, or meaningless text | Input | Custom, Usage, and Compliance | [Language Safety and Abuse](../how-to/guardrail-policy-fields/content-and-language-safety.md#language-safety-and-abuse-guardrails) |
| [TokenLimit](agent-guard/custom-and-compliance.md#tokenlimit-guardrail) | Enforces maximum length limits on user messages | Input | Custom, Usage, and Compliance | [Usage Based](../how-to/guardrail-policy-fields/custom-usage-and-anomaly.md#usage-based-guardrails) |

## Custom Policies

You can create Custom Policies to define application-specific guardrails beyond the default scanners. These policies allow you to control agent behavior across inputs, outputs, and tool execution based on your requirements.

#### Overview

A Custom Policy consists of:

* **Rules** - conditions evaluated on inputs, outputs, or actions
* **Actions** - enforcement applied when conditions are met

You can configure policies to run during request and response processing within Agent Guard.

#### Where Policies Apply

You can apply Custom Policies at:

* Input scanning (before execution)
* Output scanning (after execution)
* Tool execution (during actions)

#### What You Can Do

* Define rules based on request or response content
* Enforce role-based or context-aware restrictions
* Control tool access and execution
* Update policies without changing agent logic

#### Enforcement

When a policy condition is met, you can:

* **Block**
* **Alert**
* **Human Approval**

Multiple policies can be combined to enforce layered controls. See: [Create Guardrail Policies](../how-to/create-guardrail-policies.md) to learn more.

## Configuration Best Practices

### Guardrail Selection

**High-Risk Applications** (Banking, Healthcare):

```
Input: Secrets + PromptInjection + Toxicity
Output: Sensitive + MaliciousURLs + Bias
```

**Customer Support Chatbots**:

```
Input: Toxicity + Sentiment + Gibberish
Output: Toxicity + Relevance + Sensitive
```

**Developer Tools**:

```
Input: Secrets + PromptInjection
Output: Sensitive + Code (selective)
```

**Content Moderation**:

```
Input: Toxicity + BanTopics + BanSubstrings
Output: Toxicity + Bias + BanTopics
```

### Threshold Tuning

* **Strict Mode**: Lower thresholds (0.3-0.5) for maximum safety
* **Balanced Mode**: Medium thresholds (0.5-0.7) for production
* **Permissive Mode**: Higher thresholds (0.7-0.9) for internal tools

## Getting Started

* **Identify your use case**: Review the configuration examples above to find patterns matching your application.
* **Select core guardrails**: Start with 3-5 scanners covering your primary risks (for example Secrets, PromptInjection, and Toxicity).
* **Configure thresholds**: Begin with balanced mode (0.5-0.7) and tune based on your false positive tolerance.
* **Deploy incrementally**: Set the policy's Rule Behaviour to **Alert** first, then switch to **Block** once detections look right.
* **Monitor and optimize**: Track detection patterns in [Guardrail Activity](guardrail-activity.md) and adjust scanner combinations over time.

## Next Steps

* [Create Guardrail Policies](../how-to/create-guardrail-policies.md)
* [Guardrail Activity](guardrail-activity.md)

{% hint style="info" %}
Need help? Visit [Akto Support](https://docs.akto.io/support) or join our [Discord Community](https://discord.com/invite/Wpc6xVME4s) for assistance with guardrail configuration and deployment.
{% endhint %}
