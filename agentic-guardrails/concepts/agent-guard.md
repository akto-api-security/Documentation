# Agent Guard

## Introduction

Akto's Agent Guard provides a comprehensive security layer for AI-powered applications through intelligent guardrails that detect and prevent threats in real-time. This page lists every guardrail available in Agent Guard, grouped by what it protects against.

## What are Guardrails?

Guardrails are specialized security modules that analyze content flowing through your AI systems. They act as intelligent checkpoints, examining both user inputs and AI-generated outputs to identify security threats, policy violations, data leaks, and content safety issues before they cause harm.

## How Guardrails Work

Akto's Agent Guard operates on a dual-layer approach:

* **Input Layer**: Guardrails validate user messages before they reach your AI models, blocking malicious prompts, credential leaks, and policy violations
* **Output Layer**: Guardrails verify AI-generated responses before delivery to users, preventing data exposure, harmful content, and compliance violations

Each guardrail specializes in detecting specific threat categories, from credential exposure and prompt injection attacks to toxic content and sensitive data leaks. Guardrails can be combined to create custom security policies tailored to your application's needs.

## When to Use Which Guardrails

**For Agentic Applications**:

* Use input guardrails to protect your AI endpoints from malicious prompts
* Use output guardrails to prevent your AI from exposing API vulnerabilities or credentials

**For Customer-Facing Applications**:

* Deploy content safety guardrails (Toxicity, Bias, BanTopics) to maintain appropriate communication
* Enable PII detection guardrails (Sensitive, Secrets) to ensure privacy compliance

**For Enterprise AI Systems**:

* Implement comprehensive sets of guardrails covering security, compliance, and content policies
* Layer multiple guardrails for defense-in-depth protection

## Available Guardrails

Each guardrail entry includes its purpose, detection capabilities, risk prevention benefits, use cases, and example detections, and where to configure it in the policy form. Select a guardrail to open its entry, or use the category pages in the sidebar.

{% hint style="info" %}
**Applies to** shows where a guardrail applies by default: user prompts and tool requests (input), model and tool responses (output), or both. In a policy, you choose whether it applies to requests, responses, or both under **Application Settings**. See [Policy Details and Scope](../how-to/guardrail-policy-fields/policy-details-and-scope.md).
{% endhint %}

| Guardrail | What it does | Applies to | Category |
|---|---|---|---|
| [PromptInjection](agent-guard/prompt-and-agent-attacks.md#promptinjection-guardrail) | Detects attempts to manipulate AI system instructions or bypass security controls | Input | Prompt and Agent Attacks |
| [Context Poisoning](agent-guard/prompt-and-agent-attacks.md#context-poisoning-guardrail) | Detects and blocks attempts to poison agent memory, context, or conversation state | Input | Prompt and Agent Attacks |
| [Behavioural Anomaly](agent-guard/prompt-and-agent-attacks.md#behavioural-anomaly-guardrail) | Identifies abnormal or suspicious input patterns based on historical interaction behavior | Input and output | Prompt and Agent Attacks |
| [Intent](agent-guard/prompt-and-agent-attacks.md#intent-guardrail) | Enforces policies based on the inferred intent of incoming requests | Input and output | Prompt and Agent Attacks |
| [Tool Guardrails](agent-guard/prompt-and-agent-attacks.md#tool-guardrails) | Detects and blocks malicious or untrusted tools before execution | Input and output | Prompt and Agent Attacks |
| [Block Host/Path](agent-guard/prompt-and-agent-attacks.md#block-hostpath-guardrail) | Prevents agents from making outbound requests to unauthorised hosts or paths | Input | Prompt and Agent Attacks |
| [Secrets](agent-guard/data-protection.md#secrets-guardrail) | Detects exposed credentials, API keys, tokens, and passwords in user messages | Input | Data Protection |
| [Anonymize and Deanonymize](agent-guard/data-protection.md#anonymize-and-deanonymize-guardrail) | Automatically removes or masks personally identifiable information (PII) | Input and output | Data Protection |
| [Sensitive](agent-guard/data-protection.md#sensitive-guardrail) | Detects personally identifiable information (PII) and sensitive data in AI outputs | Output | Data Protection |
| [Regex Pattern](agent-guard/data-protection.md#regex-pattern-guardrail) | Detects and filters sensitive information using custom regex patterns | Input | Data Protection |
| [LLM Based Redaction](agent-guard/data-protection.md#llm-based-redaction-guardrail) | Masks sensitive content in user prompts using a plain-language redaction instruction, instead of blocking the request outright | Input and output | Data Protection |
| [Personal Account](agent-guard/data-protection.md#personal-account-guardrail) | Detects and blocks access from users authenticated using personal accounts instead of organization-approved accounts | Input | Data Protection |
| [MaliciousURLs](agent-guard/data-protection.md#maliciousurls-guardrail) | Identifies suspicious, malicious, or inappropriate URLs in AI responses | Output | Data Protection |
| [Toxicity](agent-guard/content-safety.md#toxicity-guardrail) | Identifies offensive, abusive, or harmful language in user inputs | Input and output | Content Safety |
| [Profanity](agent-guard/content-safety.md#profanity-guardrail) | Detects and redacts offensive, abusive, or inappropriate language from inputs and outputs | Input and output | Content Safety |
| [Sentiment](agent-guard/content-safety.md#sentiment-guardrail) | Analyzes emotional tone and sentiment in user messages | Input and output | Content Safety |
| [Bias](agent-guard/content-safety.md#bias-guardrail) | Detects discriminatory, biased, or unfair content in AI responses | Output | Content Safety |
| [Relevance](agent-guard/content-safety.md#relevance-guardrail) | Ensures AI responses are relevant and on-topic to user queries | Output | Content Safety |
| [NoRefusal](agent-guard/content-safety.md#norefusal-guardrail) | Detects when AI inappropriately refuses to answer legitimate queries | Output | Content Safety |
| [BanTopics](agent-guard/topics-and-language.md#bantopics-guardrail) | Identifies messages discussing prohibited subjects or sensitive topics | Input and output | Topics and Language |
| [BanCompetitors](agent-guard/topics-and-language.md#bancompetitors-guardrail) | Identifies and blocks mentions of competitor brands, products, or services | Input and output | Topics and Language |
| [BanSubstrings](agent-guard/topics-and-language.md#bansubstrings-guardrail) | Blocks messages containing specific words, phrases, or character patterns | Input and output | Topics and Language |
| [Language](agent-guard/topics-and-language.md#language-guardrail) | Validates that messages are in expected/allowed languages | Input and output | Topics and Language |
| [BanCode](agent-guard/code-detection.md#bancode-guardrail) | Detects code snippets, scripts, or programming commands in user messages | Input and output | Code Detection |
| [Code](agent-guard/code-detection.md#code-guardrail) | Detects and identifies programming language used in messages | Input and output | Code Detection |
| [LLM Prompt Rule](agent-guard/custom-and-compliance.md#llm-prompt-rule-guardrail) | Evaluates inputs against custom rules defined using LLM prompts | Input and output | Custom, Usage, and Compliance |
| [External Model Evaluation](agent-guard/custom-and-compliance.md#external-model-evaluation-guardrail) | Evaluates inputs using external model endpoints configured with custom security or validation criteria | Input and output | Custom, Usage, and Compliance |
| [Enterprise License Compliance](agent-guard/custom-and-compliance.md#enterprise-license-compliance-guardrail) | Blocks prompts that would breach your LLM provider's acceptable-use policy, protecting your organization's enterprise license standing | Input and output | Custom, Usage, and Compliance |
| [Gibberish](agent-guard/custom-and-compliance.md#gibberish-guardrail) | Filters nonsensical, random, or meaningless text | Input | Custom, Usage, and Compliance |
| [TokenLimit](agent-guard/custom-and-compliance.md#tokenlimit-guardrail) | Enforces maximum length limits on user messages | Input | Custom, Usage, and Compliance |

## Getting Started

* **Identify your use case**: Review the guardrails above to find the ones matching your application.
* **Select core guardrails**: Start with 3-5 guardrails covering your primary risks (for example Secrets, PromptInjection, and Toxicity).
* **Deploy incrementally**: Set the policy's Rule Behaviour to **Alert** first, then switch to **Block** once detections look right.
* **Monitor and optimize**: Track detection patterns in [Guardrail Activity](guardrail-activity.md) and adjust guardrail combinations over time.

## Next Steps

* [Create Guardrail Policies](../how-to/create-guardrail-policies.md)
* [Guardrail Activity](guardrail-activity.md)

{% hint style="info" %}
Need help? Visit [Akto Support](https://docs.akto.io/support) or join our [Discord Community](https://discord.com/invite/Wpc6xVME4s) for assistance with guardrail configuration and deployment.
{% endhint %}
