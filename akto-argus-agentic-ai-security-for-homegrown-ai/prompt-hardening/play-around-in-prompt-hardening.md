# Play Around in Prompt Hardening

This page focuses on **hands-on probing workflows** using Prompt Hardening. You can configure probes, execute prompts, and evaluate AI agent responses in real time.

## Editing Prompt Injection Probes

The Probe Editor allows you to configure prompt injection probes using a YAML-based definition.

You can use the Probe Editor to:

* Define prompt injection and adversarial attack patterns.
* Configure detection rules for unsafe or non-compliant responses.
* Assign severity levels to classify identified risks.

The YAML-based configuration enables iterative probing without redeploying AI agents, which helps maintain rapid feedback during security validation.

## Probing Prompts

The Playground provides an interactive environment for executing prompt hardening probes against AI agents.

#### Navigating to the Playground

You can access the Playground using the following navigation path:

**Agentic Security → Prompt Hardening → Playground**

<figure><img src="../../.gitbook/assets/image (31).png" alt="" width="563"><figcaption></figcaption></figure>

The Playground supports real-time prompt execution and response inspection.

### Playground Input Areas

Each Playground session separates trusted instructions from adversarial input to support controlled probing.

{% tabs %}
{% tab title="System Prompts" %}
System Prompts define the baseline instructions provided to the AI agent. System Prompts represent the trusted control layer under probe.

<figure><img src="../../.gitbook/assets/image (2) (2).png" alt="" width="563"><figcaption></figcaption></figure>
{% endtab %}

{% tab title="User Input" %}
User Input allows injection of malicious or adversarial content. You can manually enter prompts or generate them automatically.

The **Auto-generate prompt** option creates adversarial input using predefined attack templates.

<figure><img src="../../.gitbook/assets/image (29).png" alt="" width="563"><figcaption></figcaption></figure>
{% endtab %}

{% tab title="Auto Generate Prompt" %}
Auto Generate Prompt uses Akto-defined attack patterns to create custom malicious prompts. This option supports rapid scanning without manual prompt design.
{% endtab %}
{% endtabs %}

### Executing Prompt Probes

After configuring System Prompts and User Input, you can start scanning by selecting **Probe System Prompt**.

The Playground sends the combined prompt to the AI agent and captures the response for analysis.

### Reviewing Agent Responses

After execution, the Playground displays the AI agent response.

Each result includes:

* The complete agent output.
* A safety status indicating whether the response complied with expected controls.
* A vulnerability indication when unsafe behavior or policy violations are detected.

<figure><img src="../../.gitbook/assets/image (36).png" alt="" width="563"><figcaption></figcaption></figure>

Response visibility helps you quickly identify prompt injection risks and unsafe AI agent behaviour during scanning.
