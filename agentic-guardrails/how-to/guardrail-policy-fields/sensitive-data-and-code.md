# Sensitive Data and Code Detection

Configure controls to detect, block, or anonymise sensitive data, and to detect programming code in prompts and responses.

This page is part of the [Create Guardrail Policies](../create-guardrail-policies.md) form reference.

## Sensitive Information Guardrails

Configure controls to detect, block, or anonymise sensitive data.

**Personally Identifiable Information Types**

* Select predefined **PII types** to detect and block.
* For each selected PII type, configure the **guardrail behavior**:
  * **Block** to deny the request or response containing the detected PII.
  * **Mask** to redact the detected PII before processing or returning the content.

**Regex Pattern**

Akto detects sensitive data based on defined patterns.

* Add up to **10 custom regex patterns** for structured data detection.

**Secrets Detection**

Akto detects API keys, passwords, and similar sensitive values.

* Just enable secrets detection and set the confidence threshold.

**Sensitive Data Anonymisation**

Akto replaces detected sensitive data with placeholders while preserving original values securely for controlled restoration.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (170).png" alt="" width="563"><figcaption></figcaption></figure></div>

## Advanced Code Detection Filters

You configure detection and blocking of programming code and code injection attempts.

**Code Detection Filter**

Akto detects code patterns across supported programming languages and blocks content based on the configured level.

* Enable the code detection filter and set the **Code Detection Level**.

**Ban Code Detection**

Enable ban code detection to block all code regardless of programming language.

* Set the **Confidence Threshold (0–1)** to control detection strictness.

**Behaviour**

* Lower threshold values enforce stricter blocking.
* Higher threshold values allow more permissive detection.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (169).png" alt="" width="563"><figcaption></figcaption></figure></div>

<br>
