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

    <figure><img src="../../.gitbook/assets/image (6).png" alt="" width="563"><figcaption></figcaption></figure>

### Fill the Configuration Form

The configuration form is organised into nine sections, each targeting a specific enforcement layer.

<details>

<summary>1. Provide Guardrail Policy Details (Mandatory)</summary>

This section defines identifying metadata and user-facing enforcement messages.

* Enter a **policy name** and **description**.
* Define the **blocked message** shown when a request is denied.
* Enable the option to **apply the same blocked message to responses**, if consistent messaging is required across requests and responses.

{% hint style="info" %}
This section is required to create a guardrail policy.
{% endhint %}

<figure><img src="../../.gitbook/assets/image (114).png" alt="" width="563"><figcaption></figcaption></figure>

</details>

<details>

<summary>2. Configure Content Filters</summary>

Content filters control category-based and attack-based detection.

**Harmful Content Categories**

* Enable the harmful content filter using the category checkbox.
* Configure enforcement strength for **hate, insults, sexual content, violence, and misconduct** by adjusting the category sliders.
* Enable the option to apply category filtering to **responses**, if required.

**Prompt Attack Detection**

* Enable the prompt attack filter to detect jailbreaks and manipulation attempts.
* Adjust detection strength using the horizontal slider.

<figure><img src="../../.gitbook/assets/image (17).png" alt="" width="563"><figcaption></figcaption></figure>

</details>

<details>

<summary>3. Add Denied Topics</summary>

Denied topics block specific concepts in user inputs or model responses.

* Select **Add Denied Topic** to open the topic configuration form.
* Provide a **topic name**, **definition**, and optional **sample phrases**.
* Use **+ Add** to include additional topics.
* Select **Save Topic** after completing topic configuration.

{% hint style="info" %}
You can add up to **30 denied topics** per guardrail policy.
{% endhint %}

<figure><img src="../../.gitbook/assets/image (29).png" alt="" width="563"><figcaption></figcaption></figure>

</details>

<details>

<summary>4. Add Word Filters</summary>

Word filters enforce keyword- and phrase-based restrictions.

* Enable **profanity filtering** to redact offensive language.
* Add **custom words or phrases**:
  * Enter a word or phrase and select **Add Word**.

{% hint style="info" %}
Akto support for up to **10,000 custom entries**.
{% endhint %}

<figure><img src="../../.gitbook/assets/image (30).png" alt="" width="563"><figcaption></figcaption></figure>

</details>

<details>

<summary>5. Add Sensitive Information Filters</summary>

Sensitive information filters prevent exposure of regulated data.

* **Personally Identifiable Information**
  * Select predefined **PII types** to detect and block.
  * For each selected PII type, configure the **guardrail behavior**:
    * **Block** to deny the request or response containing the detected PII.
    * **Mask** to redact the detected PII before processing or returning the content.
* **Regex-Based Detection**
  * Add up to **10 custom regex patterns** for structured data detection.

<figure><img src="../../.gitbook/assets/image (32).png" alt="" width="563"><figcaption></figcaption></figure>

</details>

<details>

<summary>6. LLM Prompt-Based Rule</summary>

This rule uses an LLM to classify content against a custom prompt.

* Define the **evaluation prompt**.
* Configure a **confidence score threshold**.
* Content is blocked when the model confidence exceeds the configured threshold.

<figure><img src="../../.gitbook/assets/image (33).png" alt="" width="563"><figcaption></figcaption></figure>

</details>

<details>

<summary>7. Intent Verification Using Base Prompt (AI Agents)</summary>

Intent verification validates agent behavior against a defined base prompt.

* The evaluation checks whether agent requests align with the expected intent of the base prompt.
* Requests that deviate from the defined intent are flagged or blocked based on policy behaviour.

<figure><img src="../../.gitbook/assets/image (34).png" alt="" width="563"><figcaption></figcaption></figure>

</details>

<details>

<summary>8. External Model-Based Evaluation</summary>

External evaluation allows integration with third-party or internal scoring systems.

* Provide the **external evaluation endpoint URL**.
* Configure a **confidence threshold** that determines enforcement actions based on the external response.

<figure><img src="../../.gitbook/assets/Screenshot 2025-12-20 at 6.53.28 PM.png" alt="" width="563"><figcaption></figcaption></figure>

</details>

<details>

<summary>9. Server and Application Settings</summary>

This section defines where the guardrail policy is enforced.

* Select the **MCP servers** and **agent servers** where the policy applies.
* Enable enforcement for **requests**, **responses**, or both.

<figure><img src="../../.gitbook/assets/image (37).png" alt="" width="563"><figcaption></figcaption></figure>

</details>

{% hint style="warning" %}
#### Guardrail Deployment Scope Behaviour

By default, Akto does not apply a newly created guardrail policy to any server or agent server.\
A guardrail policy becomes active only after you explicitly select the target **MCP servers** and **agent servers** in the **Server and Application Settings** section.
{% endhint %}

### Save the Guardrail Policy

After completing the required and optional configurations:

*   Click on **Create Guardrail** to save the policy and applies enforcement to the selected scope.

    <figure><img src="../../.gitbook/assets/image (38).png" alt="" width="563"><figcaption></figcaption></figure>

## What’s Next

You can modify, disable, or delete existing guardrail policies after creation.

To continue, learn how to manage guardrail policies from the [manage-guardrail-policies.md](manage-guardrail-policies.md "mention").
