# Data Protection

Guardrails that detect, mask, or block credentials, personal data, and other sensitive content, plus malicious links in responses.

Part of [Agent Guard](../agent-guard.md). Each entry notes whether it runs on **input** (user prompts and tool requests), **output** (model and tool responses), or both.

## Secrets Guardrail

Detects exposed credentials, API keys, tokens, and passwords in user messages.

| Direction | Configure in |
|---|---|
| Input | [Sensitive Information](../../how-to/guardrail-policy-fields/sensitive-data-and-code.md#sensitive-information-guardrails) |

**What it catches**

* API keys (AWS, OpenAI, Stripe, etc.)
* Authentication tokens (Bearer, JWT, OAuth)
* Database credentials
* Private keys and certificates
* Password strings

{% hint style="info" %}
**Risk prevention**: Prevents users from accidentally or intentionally exposing sensitive credentials that could be logged, stored, or processed by AI systems.
{% endhint %}

**Use cases**

* Prevent credential leakage in support chat
* Block API key exposure in developer queries
* Protect authentication tokens in logs

**Example**

| Input | Result |
|---|---|
| "My API key is sk-proj-abc123def456" | Blocked |
| "Password: P@ssw0rd123!" | Blocked |
| "AWS\_SECRET\_KEY=abcd1234efgh5678" | Blocked |

## Anonymize and Deanonymize Guardrail

Automatically removes or masks personally identifiable information (PII).

| Direction | Configure in |
|---|---|
| Input and output | [Sensitive Information](../../how-to/guardrail-policy-fields/sensitive-data-and-code.md#sensitive-information-guardrails) |

**What it detects and masks**

* Names and personal identifiers
* Email addresses
* Phone numbers
* Social Security Numbers
* Credit card numbers
* Addresses

{% hint style="info" %}
**Risk prevention**: Protects user privacy by anonymizing PII before processing, enabling safe data handling.
{% endhint %}

**Use cases**

* GDPR compliance
* Privacy-first AI applications
* Safe data logging and storage

**Example**

| Stage | Example |
|---|---|
| Input | "Contact John at [john@email.com](mailto:john@email.com)" |
| Output | "Contact \[NAME] at \[EMAIL]" |

**On outputs**: Restores previously anonymized data when safe and authorized.

**Output example**

| Stage | Example |
|---|---|
| Anonymized | "Contact \[NAME] at \[EMAIL]" |
| Deanonymized | "Contact John at [john@email.com](mailto:john@email.com)" (when authorized) |

## Sensitive Guardrail

Detects personally identifiable information (PII) and sensitive data in AI outputs.

| Direction | Configure in |
|---|---|
| Output | [Sensitive Information](../../how-to/guardrail-policy-fields/sensitive-data-and-code.md#sensitive-information-guardrails) |

**What it catches**

* Email addresses
* Phone numbers
* Social Security Numbers (SSN)
* Credit card numbers
* Physical addresses
* Names and identifiers
* Medical information
* Financial data

{% hint style="info" %}
**Risk prevention**: Prevents AI models from inadvertently exposing sensitive or private information in responses.
{% endhint %}

**Use cases**

* Data loss prevention (DLP)
* GDPR/CCPA compliance
* Privacy protection

**Example**

| Input | Result |
|---|---|
| "Contact John Doe at [john.doe@company.com](mailto:john.doe@company.com) or 555-123-4567" | Blocked |
| Responses containing SSN: 123-45-6789 | Blocked |
| Any PII exposure in AI-generated content | Flagged |

**Performance**: ONNX-optimized for fast detection.

## Regex Pattern Guardrail

Detects and filters sensitive information using custom regex patterns.

| Direction | Configure in |
|---|---|
| Input | [Sensitive Information](../../how-to/guardrail-policy-fields/sensitive-data-and-code.md#sensitive-information-guardrails) |

**What it does**

* Matches content against configured regex patterns
* Detects custom sensitive data formats
* Filters or blocks matching inputs and outputs
* Supports organization-specific pattern definitions

{% hint style="info" %}
**Risk prevention**: Prevents exposure of sensitive information that follows identifiable patterns or formats.
{% endhint %}

**Use cases**

* Detecting custom identifiers or tokens
* Filtering internal reference numbers
* Preventing exposure of account or employee IDs
* Enforcing organization-specific data protection rules

**Example**

| Stage | Example |
|---|---|
| Configured Regex Pattern | `\d{3}-\d{2}-\d{4}` |
| Input | "Customer SSN: 123-45-6789" |
| Detected Match | `123-45-6789` |
| Enforced Output | "Customer SSN: \[REDACTED]" |

## LLM Based Redaction Guardrail

Masks sensitive content in user prompts using a plain-language redaction instruction, instead of blocking the request outright.

| Direction | Configure in |
|---|---|
| Input and output | [Custom Guardrails](../../how-to/guardrail-policy-fields/custom-usage-and-anomaly.md#custom-guardrails) |

**What it does**

* Evaluates prompts against a custom redaction instruction written in plain language
* Uses an LLM to identify content matching that instruction
* Replaces matching text in place with a redacted value
* Allows the request through after redaction, rather than blocking it

{% hint style="info" %}
**Risk prevention**: Prevents sensitive data described in your own words, beyond fixed PII types or regex patterns, from reaching AI models or third-party tools, while still letting the underlying request complete.
{% endhint %}

**Use cases**

* Masking business-specific identifiers that don't fit a standard PII category, such as internal case numbers or deal codes
* Redacting customer names and addresses before a prompt reaches an external AI tool
* Layering with the Anonymize or Regex Pattern guardrails for categories that need a free-text description

**Example**

| Stage | Example |
|---|---|
| Redaction Instruction | "Redact customer full names and home addresses" |
| Input | "Ship the order to John Carter at 42 Baker Street" |
| Enforced Output | "Ship the order to \[REDACTED] at \[REDACTED]" |

**On outputs**: Masks sensitive content in AI-generated responses using a plain-language redaction instruction, instead of blocking the response outright.

**Output example**

| Stage | Example |
|---|---|
| Redaction Instruction | "Redact customer full names and home addresses" |
| Generated Output | "The order was shipped to John Carter at 42 Baker Street" |
| Enforced Output | "The order was shipped to \[REDACTED] at \[REDACTED]" |

## Personal Account Guardrail

Detects and blocks access from users authenticated using personal accounts instead of organization-approved accounts.

| Direction | Configure in |
|---|---|
| Input | [Access Restrictions](../../how-to/guardrail-policy-fields/access-restrictions-and-exceptions.md#access-restrictions) |

**What it does**

* Identifies personal email domains during authentication
* Validates user accounts against approved organization domains
* Detects sign-ins using non-corporate accounts
* Restricts access for unauthorized personal accounts

{% hint style="info" %}
**Risk prevention**: Prevents unauthorized access, data leakage, and policy violations caused by usage of unmanaged personal accounts.
{% endhint %}

**Use cases**

* Enforcing enterprise-only account access
* Blocking Gmail or personal email sign-ins
* Restricting access to organization-managed users
* Preventing unauthorized external access

**Example**

| Stage | Example |
|---|---|
| User Sign-In | `john.doe@gmail.com` |
| Allowed Domain | `@company.com` |
| Detected Issue | Personal account detected |
| Enforced Output | "Access blocked: personal accounts are not allowed" |

{% hint style="info" %}
Requires the Akto browser extension v1.0.69 or later. Currently supported only through the browser extension; AI Endpoint Shield Agent support is coming soon.
{% endhint %}

## MaliciousURLs Guardrail

Identifies suspicious, malicious, or inappropriate URLs in AI responses.

| Direction |
|---|
| Output |

**What it catches**

* Phishing links
* Malware distribution sites
* Suspicious domains
* Unverified URLs
* Known bad actors

{% hint style="info" %}
**Risk prevention**: Protects users from clicking dangerous links that AI models might generate or reference.
{% endhint %}

**Use cases**

* Phishing prevention
* Link safety verification
* Brand protection

**Example**

| Input | Result |
|---|---|
| "Visit [http://suspicious-phishing-site.xyz](http://suspicious-phishing-site.xyz)" | Blocked |

* Verifies URL reputation
* Protects against social engineering

**Performance**: ONNX-optimized for real-time URL analysis.
