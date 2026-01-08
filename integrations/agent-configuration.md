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

The API key must have sufficient permissions to invoke the selected model.
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
