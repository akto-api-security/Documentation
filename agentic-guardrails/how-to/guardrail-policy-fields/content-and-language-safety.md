# Content and Language Safety

Configure content moderation, policy-based controls, and language-level abuse detection for a guardrail policy.

This page is part of the [Create Guardrail Policies](../create-guardrail-policies.md) form reference.

## Content and Policy Guardrails

Configure content moderation and policy-based control:

**Prompt Injection Attack Filter**

* Enable the prompt attack filter to detect jailbreaks and manipulation attempts.
* Adjust detection strength using the horizontal slider.

**Context Poisoning Attacks**

* Enable the context poisoning filter to detect attempts to manipulate agent memory or context.

**Add Denied Topics**

Denied topics block specific concepts in user inputs or model responses.

{% stepper %}
{% step %}
**Open the topic form**

Select **Add Denied Topic** to open the topic configuration form.
{% endstep %}

{% step %}
**Describe the topic**

Provide a **topic name**, **definition**, and optional **sample phrases**.
{% endstep %}

{% step %}
**Add more topics (optional)**

Use **+ Add** to include additional topics.
{% endstep %}

{% step %}
**Save the topic**

Select **Save Topic** after completing topic configuration.
{% endstep %}
{% endstepper %}

Alternatively, select **Add Akto Default Topics** to instantly add Akto's predefined denied topics, grouped by category:
  * **Safety-critical**: Weapons & Firearms, Explosives & Bombs, Self-harm & Suicide, Illegal Drugs.
  * **Professional advice**: Medical / Health Advice, Financial / Investment Advice, Legal Advice.

{% hint style="info" %}
You can add up to **30 denied topics** per guardrail policy.
{% endhint %}

**Map Topics to Compliance Frameworks**

Akto auto-tags each custom denied topic against supported compliance frameworks, including **SOC 2**, **HIPAA**, **GDPR**, and **ISO 27001**. Every topic maps to the controls it enforces, so you can see at a glance which compliance requirements a guardrail policy helps satisfy.

* Review the frameworks suggested under **Compliance frameworks supported by this guardrail**.
* Select **+ Add** to map the topic to additional frameworks.
* Select the **x** on a framework tag to remove that mapping.

{% hint style="warning" %}
Compliance mappings are AI-generated suggestions and may not be fully accurate. Review and validate them before relying on them for compliance.
{% endhint %}

**Harmful Categories Filter**

* Enable the harmful content filter using the category checkbox.
* Configure enforcement strength for **hate, insults, sexual content, violence, and misconduct** by adjusting the category sliders.
* Enable the option to apply category filtering to **responses**, if required.

**Agent Intent Verification**

Enable Intent verification to validate whether agent-generated requests align with expected intent.

* Set **Confidence Threshold (0–1)**. Higher values require more confidence to block content.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (2) (4).png" alt="" width="563"><figcaption></figcaption></figure></div>

## Language Safety and Abuse Guardrails

**Gibberish Detection**

Identify nonsensical or meaningless inputs that may disrupt agent processing or indicate misuse.

* Enable gibberish detection and define a confidence threshold.

**Sentiment Detection**

You can just enable sentiment detection to evaluate inputs for negative, toxic, or inappropriate sentiment and configure a confidence threshold.

**Profanity**

Word filters enforce keyword- and phrase-based restrictions.

* Enable **profanity filtering** to redact offensive language.
* Add **custom words or phrases**:
  * Enter a word or phrase and select **Add Word**.

{% hint style="info" %}
Akto support for up to **10,000 custom entries**.
{% endhint %}

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (172).png" alt="" width="563"><figcaption></figcaption></figure></div>
