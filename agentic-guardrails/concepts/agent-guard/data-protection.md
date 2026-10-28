# Data Protection

Guardrails that detect, mask, or block credentials, personal data, and other sensitive content, plus malicious links in responses.

Part of [Agent Guard](../agent-guard.md). Each entry notes whether it runs on **input** (user prompts and tool requests), **output** (model and tool responses), or both.

## Secrets Guardrail

**Direction**: Input

**Configure in**: [Sensitive Information](../../how-to/guardrail-policy-fields/sensitive-data-and-code.md#sensitive-information-guardrails)

**Purpose**: Detects exposed credentials, API keys, tokens, and passwords in user messages.

**What it Catches**:

* API keys (AWS, OpenAI, Stripe, etc.)
* Authentication tokens (Bearer, JWT, OAuth)
* Database credentials
* Private keys and certificates
* Password strings

**Risk Prevention**: Prevents users from accidentally or intentionally exposing sensitive credentials that could be logged, stored, or processed by AI systems.

**Use Cases**:

* Prevent credential leakage in support chat
* Block API key exposure in developer queries
* Protect authentication tokens in logs

**Example Detection**:

* ✅ Blocks: "My API key is sk-proj-abc123def456"
* ✅ Blocks: "Password: P@ssw0rd123!"
* ✅ Blocks: "AWS\_SECRET\_KEY=abcd1234efgh5678"

## Anonymize and Deanonymize Guardrail

**Direction**: Input and output

**Configure in**: [Sensitive Information](../../how-to/guardrail-policy-fields/sensitive-data-and-code.md#sensitive-information-guardrails)

**Purpose**: Automatically removes or masks personally identifiable information (PII).

**What it Detects & Masks**:

* Names and personal identifiers
* Email addresses
* Phone numbers
* Social Security Numbers
* Credit card numbers
* Addresses

**Risk Prevention**: Protects user privacy by anonymizing PII before processing, enabling safe data handling.

**Use Cases**:

* GDPR compliance
* Privacy-first AI applications
* Safe data logging and storage

**Example Transformation**:

* Input: "Contact John at [john@email.com](mailto:john@email.com)"
* Output: "Contact \[NAME] at \[EMAIL]"

**On outputs**: Restores previously anonymized data when safe and authorized.

On the output side, example transformation:

* Anonymized: "Contact \[NAME] at \[EMAIL]"
* Deanonymized: "Contact John at [john@email.com](mailto:john@email.com)" (when authorized)

## Sensitive Guardrail

**Direction**: Output

**Configure in**: [Sensitive Information](../../how-to/guardrail-policy-fields/sensitive-data-and-code.md#sensitive-information-guardrails)

**Purpose**: Detects personally identifiable information (PII) and sensitive data in AI outputs.

**What it Catches**:

* Email addresses
* Phone numbers
* Social Security Numbers (SSN)
* Credit card numbers
* Physical addresses
* Names and identifiers
* Medical information
* Financial data

**Risk Prevention**: Prevents AI models from inadvertently exposing sensitive or private information in responses.

**Use Cases**:

* Data loss prevention (DLP)
* GDPR/CCPA compliance
* Privacy protection

**Example Detection**:

* ✅ Blocks: "Contact John Doe at [john.doe@company.com](mailto:john.doe@company.com) or 555-123-4567"
* ✅ Blocks: Responses containing SSN: 123-45-6789
* ✅ Flags: Any PII exposure in AI-generated content

**Performance**: ONNX-optimized for fast detection.

## Regex Pattern Guardrail

**Direction**: Input

**Configure in**: [Sensitive Information](../../how-to/guardrail-policy-fields/sensitive-data-and-code.md#sensitive-information-guardrails)

**Purpose:** Detects and filters sensitive information using custom regex patterns.

**What it Does:**

* Matches content against configured regex patterns
* Detects custom sensitive data formats
* Filters or blocks matching inputs and outputs
* Supports organization-specific pattern definitions

**Risk Prevention:** Prevents exposure of sensitive information that follows identifiable patterns or formats.

**Use Cases:**

* Detecting custom identifiers or tokens
* Filtering internal reference numbers
* Preventing exposure of account or employee IDs
* Enforcing organization-specific data protection rules

**Example Transformation:**

* Configured Regex Pattern:\
  `\d{3}-\d{2}-\d{4}`
* Input:\
  "Customer SSN: 123-45-6789"
* Detected Match:\
  `123-45-6789`
* Enforced Output:\
  "Customer SSN: \[REDACTED]"

## LLM Based Redaction Guardrail

**Direction**: Input and output

**Configure in**: [Custom Guardrails](../../how-to/guardrail-policy-fields/custom-usage-and-anomaly.md#custom-guardrails)

**Purpose:** Masks sensitive content in user prompts using a plain-language redaction instruction, instead of blocking the request outright.

**What it Does:**

* Evaluates prompts against a custom redaction instruction written in plain language
* Uses an LLM to identify content matching that instruction
* Replaces matching text in place with a redacted value
* Allows the request through after redaction, rather than blocking it

**Risk Prevention:** Prevents sensitive data described in your own words, beyond fixed PII types or regex patterns, from reaching AI models or third-party tools, while still letting the underlying request complete.

**Use Cases:**

* Masking business-specific identifiers that don't fit a standard PII category, such as internal case numbers or deal codes
* Redacting customer names and addresses before a prompt reaches an external AI tool
* Layering with the Anonymize or Regex Pattern guardrails for categories that need a free-text description

**Example Transformation:**

* Redaction Instruction:\
  "Redact customer full names and home addresses"
* Input:\
  "Ship the order to John Carter at 42 Baker Street"
* Enforced Output:\
  "Ship the order to \[REDACTED] at \[REDACTED]"

**On outputs**: Masks sensitive content in AI-generated responses using a plain-language redaction instruction, instead of blocking the response outright.

On the output side, example transformation:

* Redaction Instruction:\
  "Redact customer full names and home addresses"
* Generated Output:\
  "The order was shipped to John Carter at 42 Baker Street"
* Enforced Output:\
  "The order was shipped to \[REDACTED] at \[REDACTED]"

## Personal Account Guardrail

**Direction**: Input

**Configure in**: [Access Restrictions](../../how-to/guardrail-policy-fields/access-restrictions-and-exceptions.md#access-restrictions)

**Purpose:** Detects and blocks access from users authenticated using personal accounts instead of organization-approved accounts.

**What it Does:**

* Identifies personal email domains during authentication
* Validates user accounts against approved organization domains
* Detects sign-ins using non-corporate accounts
* Restricts access for unauthorized personal accounts

**Risk Prevention:** Prevents unauthorized access, data leakage, and policy violations caused by usage of unmanaged personal accounts.

**Use Cases:**

* Enforcing enterprise-only account access
* Blocking Gmail or personal email sign-ins
* Restricting access to organization-managed users
* Preventing unauthorized external access

**Example Transformation:**

* User Sign-In:\
  `john.doe@gmail.com`
* Allowed Domain:\
  `@company.com`
* Detected Issue:\
  Personal account detected
* Enforced Output:\
  "Access blocked: personal accounts are not allowed"

{% hint style="info" %}
Requires the Akto browser extension v1.0.69 or later. Currently supported only through the browser extension; AI Endpoint Shield Agent support is coming soon.
{% endhint %}

## MaliciousURLs Guardrail

**Direction**: Output

**Purpose**: Identifies suspicious, malicious, or inappropriate URLs in AI responses.

**What it Catches**:

* Phishing links
* Malware distribution sites
* Suspicious domains
* Unverified URLs
* Known bad actors

**Risk Prevention**: Protects users from clicking dangerous links that AI models might generate or reference.

**Use Cases**:

* Phishing prevention
* Link safety verification
* Brand protection

**Example Detection**:

* ✅ Blocks: "Visit [http://suspicious-phishing-site.xyz](http://suspicious-phishing-site.xyz)"
* ✅ Verifies URL reputation
* ✅ Protects against social engineering

**Performance**: ONNX-optimized for real-time URL analysis.
