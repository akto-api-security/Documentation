# Custom, Usage, and Anomaly Guardrails

Configure custom LLM-based rules, usage limits, and anomaly detection for a guardrail policy.

This page covers part of the [Create Guardrail Policies](../create-guardrail-policies.md) form.

## Custom Guardrails

**LLM prompt based rule**

This rule uses an LLM to classify content against a custom prompt.

* Define the **evaluation prompt**.
* Configure a **confidence score threshold**.
* Content is blocked when the model confidence exceeds the configured threshold.

**LLM based redaction**

This rule uses an LLM to mask sensitive content described in plain language, instead of blocking the request or response outright.

* Enable **LLM based redaction**.
* Define the **redaction instruction** describing what to mask, for example "Redact customer full names and home addresses." Be specific: only content matching the instruction is masked, and anything not described is left untouched. To redact a second, unrelated category, create another policy.
* Matching text is replaced in place and the request is allowed through, instead of being blocked.

**External model based evaluation**

External evaluation allows integration with third-party or internal scoring systems.

* Provide the **external evaluation endpoint URL**.
* Configure a **confidence threshold** that determines enforcement actions based on the external response.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (223).png" alt="" width="563"><figcaption></figcaption></figure></div>

## Usage Based Guardrails

**Token Limit Detection**

Akto can evaluate input size and detects requests that exceed acceptable token limits.

* Enable token limit detection and set the confidence threshold.

**Behaviour**

* Higher threshold values allow larger inputs.
* Lower threshold values enforce stricter limits and block oversized requests.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (166).png" alt="" width="563"><figcaption></figcaption></figure></div>

## Anomaly Detection

Configure anomaly detection rules to identify unusual patterns in agent behaviour, tool usage, and system metrics.

Anomaly detection guardrails are tagged with the OWASP Agentic risk categories they help mitigate, for example **ASI07 – Insecure Inter-Agent Communication**, **ASI08 – Cascading Failures**, and **ASI10 – Rogue Agents**.

**Statistical Anomalies**

* Enable **anomaly detection** to detect and alert on abnormal tool call counts and error counts per session.
* Set the **Tool call limit (per session)**: total tool calls allowed per session before triggering an anomaly.
* Set the **Error limit (per session)**: total errors (4xx/5xx) per session before triggering an anomaly.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (219).png" alt="" width="563"><figcaption></figcaption></figure></div>

**Structural Anomalies**

Detects irregularities in request structure or interaction flows, with configuration options rolling out.

**Behavioral Anomalies**

Identifies unexpected agent actions or tool usage patterns, with configuration options rolling out.
