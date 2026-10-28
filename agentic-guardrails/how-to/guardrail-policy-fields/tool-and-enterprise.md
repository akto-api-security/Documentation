# Tool and Enterprise License Guardrails

Configure tool-level protections and enterprise license compliance categories for a guardrail policy.

This page covers part of the [Create Guardrail Policies](../create-guardrail-policies.md) form.

## Enterprise License Compliance Guardrails

Block prompts and responses that would breach your LLM provider's acceptable-use policy, keeping your usage compliant so your enterprise license isn't put at risk.

Enable the categories you want enforced:

* **Child Sexual Abuse Material (CSAM)**: Blocks content that sexualizes, exploits, grooms, or endangers minors.
* **Malicious Code & Cyberattacks**: Blocks requests to create or deploy malware, ransomware, exploits, phishing, hacking, DDoS, or other cyberattacks.
* **Weapons of Mass Destruction (CBRN)**: Blocks assistance with chemical, biological, radiological, or nuclear weapons, including synthesis, weaponization, delivery, or procurement.
* **Violent Extremism & Terrorism**: Blocks content that facilitates, promotes, or incites terrorism, mass violence, genocide, or extremist attacks, including planning and recruitment.
* **Hate Speech & Discrimination**: Blocks content that dehumanizes or incites hatred against individuals or groups based on race, ethnicity, religion, gender, sexual orientation, disability, or national origin.
* **Human Trafficking & Sexual Exploitation**: Blocks content facilitating human trafficking, forced labor, sexual exploitation, or modern slavery, including recruitment scripts and coercion methods.
* **Non-consensual Surveillance & Tracking**: Blocks assistance building covert tracking tools, stalkerware, or unauthorized monitoring systems targeting individuals without consent.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (218).png" alt="" width="563"><figcaption></figcaption></figure></div>

Select the **info** icon next to a category for its full detection scope.

## Tool Guardrails

**Tool Misuse**

Evaluate tool invocation patterns and blocks suspicious activity.

* Enable tool misuse detection to identify unauthorized or unsafe tool usage by agents.

**Detect Malicious Tool**

Block tools that exhibit unsafe or exploitative characteristics.

* Enable malicious tool detection to identify tools with harmful behavior or intent.

**Detect Tool Name and Description Mismatch**

Detect cases where tool behavior does not align with declared metadata.

* Enable mismatch detection to identify inconsistencies between tool name and description.

<figure><img src="../../../.gitbook/assets/image (1) (1) (3).png" alt="" width="563"><figcaption></figcaption></figure>
