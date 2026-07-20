# Manage Human Approval Requests

## Overview

**Human Approval** is a Rule Behaviour option for guardrail policies. The first time the policy is triggered, Akto blocks the attempt and sends it to a reviewer instead of blocking every future attempt or only alerting after the fact. The reviewer then approves the specific actor, always or for a fixed number of days, to allow future attempts through.

## How It Works

1. You create or edit a guardrail policy and set **Rule Behaviour** to **Human Approval**.
2. The next time that policy's condition is triggered, Akto **blocks the attempt**, the same as a Block rule would.
3. The event is logged to the **Needs Approval** tab in **Guardrail Activity**, instead of **Active**.
4. A reviewer opens the event and selects **Approve**.
5. In the confirmation dialog, the reviewer chooses how long the approval lasts: **Always**, or a specific **number of days**.
6. For that duration, Akto stops enforcing that policy against the approved actor. Once the window expires, enforcement resumes and the next attempt is blocked and logged to **Needs Approval** again.

{% hint style="info" %}
There is no separate reject action. If an event is left un-approved in the **Needs Approval** tab, the policy simply keeps blocking that actor's attempts, and each new attempt is logged as its own event.
{% endhint %}

## Set a Policy's Rule Behaviour to Human Approval

{% stepper %}
{% step %}
Navigate to **Guardrails → Guardrail Policies**.
{% endstep %}

{% step %}
Open an existing policy, or select **Create Guardrail** to configure a new one.
{% endstep %}

{% step %}
Go to the **Scope** section and locate **Rule Behaviour**.
{% endstep %}

{% step %}
Select **Human Approval**.
{% endstep %}

{% step %}
Save the policy using **Create Policy** or **Update Guardrail**.
{% endstep %}
{% endstepper %}

For the rest of the policy configuration, see [Create Guardrail Policies](create-guardrail-policies.md).

## Review a Human Approval Request

{% stepper %}
{% step %}
Navigate to **Guardrails → Guardrail Activity**.
{% endstep %}

{% step %}
Select the **Needs Approval** tab. This lists every blocked attempt that is waiting on a reviewer decision.
{% endstep %}

{% step %}
Review the event's columns for context:

| Column          | Description                                                  |
| --------------- | ------------------------------------------------------------- |
| Severity        | Risk level assigned to the detection                          |
| Actor           | The user, host, or endpoint that triggered the policy          |
| Username        | The signed-in user associated with the attempt, if available   |
| Policy Triggered| The guardrail policy that blocked the attempt                  |
| Detection Type  | The layer the violation was detected at (e.g. Session)         |
| Rule Violated   | The specific rule within the policy that matched (e.g. BlockedHost) |
| Behaviour       | Shows **Human Approval** for events in this tab                |
| Compliance      | Compliance frameworks associated with the violated rule        |
| Collection      | Associated data collection                                      |
| Detected        | Timestamp when the attempt occurred                             |
{% endstep %}

{% step %}
Select **Approve** in the **Action** column for the event.
{% endstep %}

{% step %}
In the confirmation dialog, review the actor named (e.g. a specific server or domain) and the policy it will bypass.
{% endstep %}

{% step %}
Under **Approve for**, choose:

* **Always** – Permanently stop enforcing this policy against this actor.
* **Number of days** – Enter a duration. Enforcement resumes automatically once it elapses.
{% endstep %}

{% step %}
Select **Approve** to confirm.
{% endstep %}
{% endstepper %}

{% hint style="warning" %}
Approving a request does not retroactively unblock the attempt that triggered it. The original attempt was already blocked. Approval only changes enforcement for that actor going forward, for the duration you set.
{% endhint %}

{% hint style="info" %}
**Needs Approval** is currently in **Beta**.
{% endhint %}

## What's Next

* [Create Guardrail Policies](create-guardrail-policies.md): configure the full set of detection and scope settings for a policy.
* [Guardrail Activity Detailed View](guardrail-activity-detailed-view.md): review the full event context available for any guardrail activity, including Needs Approval requests.
