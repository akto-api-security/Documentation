# Skills Discovery

## Overview

Skills Discovery helps you understand what actions your AI agents can perform across your environment. Each skill represents a callable capability exposed by an agent and mapped to underlying APIs or system operations.

You can view skills by navigating through the Akto Atlas interface:

* **Akto Atlas → Agentic AI Discovery → Agentic Assets → Skills tab**

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image.png" alt="" width="563"><figcaption></figcaption></figure></div>

The Skills table shows endpoint coverage, sensitive data indicators, and last observed activity for each skill.  The visibility into usage patterns helps you make informed enforcement decisions.



{% hint style="info" %}
## Skill Discovery Updates

Akto continuously identifies skills configured in your agents.

**New skills are discovered every 6 hours.**\
Regular updates keep your inventory aligned with agent configuration changes.
{% endhint %}

## Blocking Skills Capability

### Block Skills by Device

You can block a skill directly from the Skills view by selecting the devices where enforcement should apply. Device selection automatically includes all agents running on the selected endpoints.

This approach helps you restrict a capability only where required while allowing normal operation elsewhere.

**Steps to Block a Skill for Selected Devices**

{% stepper %}
{% step %}
Navigate to the **Skills** tab under Agentic Assets.
{% endstep %}

{% step %}
Select the skill that you want to restrict and open its skill details view.
{% endstep %}

{% step %}
Select the endpoint IDs (devices) where you want to block the skill.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (1).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Click **Block skill** from the action bar at the bottom.
{% endstep %}

{% step %}
Confirm the blocking action.
{% endstep %}
{% endstepper %}

**Expected Result After Blocking**

Akto prevents execution of the selected skill on all chosen devices.\
All agents running on the selected endpoint IDs lose access to the blocked skill.\
Agents on other devices continue to use the skill without interruption.

### Block Skills by Agent

You can block skills for a specific agent within a specific device using the Users and Devices view. Agent-level enforcement allows you to apply tighter controls without affecting other agents on the same device.

This approach supports environments where different agents require different access levels.

#### **Steps to Block Skills for a Specific Agent**

{% stepper %}
{% step %}
Navigate to **Users and Devices**.
{% endstep %}

{% step %}
Select the device where you want to enforce the restriction.
{% endstep %}

{% step %}
Open the list of agents associated with the selected device and select the agent.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (2).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Choose the skills that you want to block.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (4).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Click **Block Skills** from the action bar.
{% endstep %}

{% step %}
Confirm the blocking action.
{% endstep %}
{% endstepper %}

#### **Expected Result After Blocking**

Akto blocks execution of the selected skills only for the chosen agent on the selected device.\
Other agents on the same device retain access unless explicitly restricted.\
Agents on other devices continue to operate without any impact.

## Continue with Guardrails

Skills Discovery shows available capabilities. Guardrails control execution.

You can:

* Map skills to guardrail policies
* Enforce restrictions on sensitive actions
* Monitor violations

Refer to:

* [Agentic Guardrails](/broken/pages/GqT7atAXg9l9FDBVe7BX)
* [Guardrail Policies](../../agentic-guardrails/concepts/threat-policy.md)
