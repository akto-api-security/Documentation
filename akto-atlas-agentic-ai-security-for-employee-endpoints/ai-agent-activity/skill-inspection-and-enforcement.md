# Skill Inspection & Enforcement

## Overview

Once Akto identifies and scores a skill as malicious or risky, it enforces controls at runtime to prevent dangerous skill execution. This page covers how Akto monitors agent behavior, blocks threats in real time, and gives you governance controls over skill usage across your environment.

For how Akto discovers skill files and determines whether a skill is malicious, see [Skills Discovery](./skills-discovery.md).

## Runtime Detection & Enforcement

Akto monitors agent behavior at runtime to detect dangerous actions triggered by skill execution and enforce policy-based restrictions in real time.

### What Akto Monitors

* **Agent tool usage** — file access, shell commands, and network calls initiated by skill execution
* **Skill-triggered system actions** — system-level operations spawned directly by a skill
* **Data movement** — files, environment variables, or sensitive content leaving the endpoint
* **Outbound network activity** — destinations contacted during or after skill execution

### What Akto Detects

* Data exfiltration: environment variable leakage, credential forwarding, or file uploads to external destinations
* Unauthorized filesystem activity: access to sensitive paths such as `.env` files or credential stores
* Anomalous tool invocation patterns: unusual sequences or frequencies of tool calls that indicate abuse
* Pre-authorized dangerous tools configured within skill definitions
* Skills requesting excessive privileges beyond their stated purpose

### Enforcement

Akto enforces controls in real time without requiring manual intervention:

* **Block dangerous commands** immediately upon detection
* **Restrict filesystem access** to sensitive paths based on policy
* **Limit outbound destinations** to approved endpoints only

**Integrations**

* **EDR / XDR platforms** — Akto correlates skill-triggered events with endpoint telemetry for unified threat visibility
* **Runtime agent gateways and proxies** — Akto integrates with agent middleware to enforce controls at the execution layer

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

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1).png" alt="" width="563"><figcaption></figcaption></figure></div>
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

**Steps to Block Skills for a Specific Agent**

{% stepper %}
{% step %}
Navigate to **Users and Devices**.
{% endstep %}

{% step %}
Select the device where you want to enforce the restriction.
{% endstep %}

{% step %}
Open the list of agents associated with the selected device and select the agent.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (2) (1) (1).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Choose the skills that you want to block.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (3) (1) (1).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Click **Block Skills** from the action bar.
{% endstep %}

{% step %}
Confirm the blocking action.
{% endstep %}
{% endstepper %}

**Expected Result After Blocking**

Akto blocks execution of the selected skills only for the chosen agent on the selected device.\
Other agents on the same device retain access unless explicitly restricted.\
Agents on other devices continue to operate without any impact.


## Governance & Compliance

### Skill Allowlists & Approval Workflows

Akto gives you controls to govern which skills can be introduced and activated across your environment.

* Maintain **approved skill registries** and allowlists to define which skills are permitted
* Require **approval workflows** before new skills can be introduced to a team or project
* Enforce **code review gates** so skill files go through review before activation
* Apply **policy gating** to prevent skills from being activated without explicit authorization

### Usage Tracking & Compliance Reporting

* Track skill usage across teams, projects, and devices
* Generate compliance reports covering skill inventory and usage history
* Align skill governance with security and regulatory requirements

***

## Detection Coverage

Akto measures detection effectiveness across four key risk categories for skills:

| Risk Category | What Is Measured |
|---|---|
| **Prompt Injection** | Detection rate for injected instructions within skill files |
| **Malicious Scripts** | Detection rate for dangerous execution logic embedded in or linked from skills |
| **Credential Leakage** | Detection rate for hardcoded secrets and sensitive identifiers in skill content |
| **Supply Chain Attacks** | Detection rate for compromised or malicious skills introduced via third-party registries or repositories |

{% hint style="info" %}
Detection rates are measured against a benchmark set of known-malicious skill samples covering each risk category. Methodology details are available on request.
{% endhint %}
