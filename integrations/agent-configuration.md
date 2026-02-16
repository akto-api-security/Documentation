# Agent Configuration

## Overview

The Agents Configuration integration allows you to connect and manage large language model (LLM) providers used during agentic workflows. This integration defines the models and credentials Akto relies on to execute agent-driven analysis and automation.

## Adding an Agent Model

{% stepper %}
{% step %}
**Open Agent integration settings**

Navigate to **Settings → Integrations → Agents** to view existing configured models.
{% endstep %}

{% step %}
**Start adding a new model**

Select **Add Model** to open the model configuration form.
{% endstep %}

{% step %}
**Select the model provider**

Choose the provider from the dropdown, such as OpenAI.\
The selected provider determines the supported model options and authentication requirements.
{% endstep %}

{% step %}
**Provide model details**

Enter the following information:

* **Name**: A descriptive name to identify the model configuration inside Akto.
* **API Key**: The authentication key used to access the selected provider.
* **Model**: The specific model version exposed by the provider.

<figure><img src="../.gitbook/assets/Screenshot 2026-01-08 at 7.30.00 PM.png" alt="" width="563"><figcaption></figcaption></figure>

The API key must have sufficient permissions to invoke the selected model.

{% hint style="success" %}
### Supported Models

Akto supports the following providers when you configure a model in **Add Model**:

* **OpenAI**\
  Supported models: `gpt-4o`, `gpt-4o-mini`
* **Anthropic**\
  Supported models: Claude 3.5 Haiku, Claude 3 Haiku, Claude 3.7 Sonnet, Claude 3.5 Sonnet
* **Azure OpenAI**\
  **Additional** **Requirement**: Azure OpenAI server endpoint
* **Ollama**\
  Supported models: `qwen2.5:0.5b`, `qwen3:8b`, `qwen3:latest`\
  **Additional** **Requirement**: Ollama server endpoint
{% endhint %}
{% endstep %}

{% step %}
**Save the model configuration**

Save the configuration to make the model available to Akto.
{% endstep %}
{% endstepper %}

You can configure multiple models across providers. Each saved model can be independently used by agentic workflows.

#### Use Cases

Configured agent models define:

* The LLM providers Akto can invoke.
* The model versions available for agentic analysis.
* The authentication boundaries for external model access.

This integration helps you manage model access centrally while keeping agent execution predictable and auditable.
