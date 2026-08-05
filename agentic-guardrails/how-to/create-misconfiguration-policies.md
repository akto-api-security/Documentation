# Create Misconfiguration Policies

## Overview

Enforce and monitor configuration settings across Claude environments. Flag drift in model versions, MCP servers, and tool permissions before they become incidents.

{% hint style="info" %}
Misconfigurations is currently in **Beta**.
{% endhint %}

## Access Misconfiguration Policies

You can access misconfiguration policy configuration from the Akto console.

* Navigate to the **Akto Atlas** product.
* Select **Agentic Guardrails → Misconfigurations**.
* Select the **Config Field Policies** tab.

The Config Field Policies page lists existing policies and provides access to policy creation.

## Create a Config Field Policy

A config field policy pins a single field in an agent's configuration file to an expected value. Akto flags and reverts any local edit that drifts away from that value.

### **Steps**

{% stepper %}
{% step %}
Navigate to the **Akto Atlas** product.
{% endstep %}

{% step %}
Select **Agentic Guardrails → Misconfigurations → Config Field Policies**.
{% endstep %}

{% step %}
Select **New Policy** in the top-right corner to open the **New Claude Config Policy** form.
{% endstep %}

{% step %}
Enter a **policy name**, or leave it blank to auto-generate one from the config field below.
{% endstep %}

{% step %}
Select the **Agent** the policy applies to.

{% hint style="warning" %}
Only **Claude** is supported as an agent for config field policies today. Support for additional agents is planned.
{% endhint %}
{% endstep %}

{% step %}
Paste the **config field to pin** exactly as it should appear in the agent's settings file (for example, Claude's `settings.json`):

```json
{
  "availableModels": ["sonnet", "haiku"]
}
```

If the field is missing on a device, Akto creates it automatically. If a local edit changes the field's value, Akto reverts it back to the pinned value.
{% endstep %}

{% step %}
Click **Save** to apply the policy.
{% endstep %}
{% endstepper %}

{% hint style="info" %}
Use config field policies to guard against drift in model versions, MCP server endpoints, and tool permissions, catching unauthorised configuration changes before they turn into incidents.
{% endhint %}
