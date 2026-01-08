# Event Retention Control

## Overview

Event retention control allows you to define how long Akto stores malicious security events before automatic deletion. Event retention configuration helps you align event storage with compliance requirements, investigation timelines, and storage management policies.

## Event Deletion Mechanism

Akto uses a scheduled deletion process to remove malicious events that exceed the configured retention duration.

* The deletion process is controlled using the **Enable deletion cron** option.
* When the deletion cron option is enabled, Akto periodically evaluates stored malicious events.
* Malicious events older than the configured retention duration are automatically deleted.
* When the deletion cron option remains disabled, Akto retains malicious events indefinitely.

### Retention Duration Options

The **Retention Time** dropdown defines the maximum age of malicious events before deletion.

Available retention durations include:

* 30 days
* 60 days
* 90 days

Retention duration selection does not trigger deletion unless the deletion cron option is enabled.

## Steps to Configure

{% stepper %}
{% step %}
Log in to the Akto dashboard.
{% endstep %}

{% step %}
Click the **Settings** icon located in the top-right corner of the Akto interface.
{% endstep %}

{% step %}
Navigate to **Threat Configuration** from the settings menu.
{% endstep %}

{% step %}
Scroll to the **Deletion Configuration** section.

<figure><img src="../../.gitbook/assets/Screenshot 2026-01-08 at 2.36.11 PM.png" alt="" width="563"><figcaption></figcaption></figure>
{% endstep %}

{% step %}
Select a value from the **Retention Time** dropdown to define the retention window.
{% endstep %}

{% step %}
Enable the **Enable deletion cron** checkbox to activate automatic deletion.
{% endstep %}

{% step %}
Click **Save** to apply the configuration.
{% endstep %}
{% endstepper %}

## Resulting Behaviour

After configuration:

* Akto automatically deletes malicious events that exceed the selected retention duration.
* Newly generated malicious events remain available until the retention window expires.
* Event deletion occurs without manual intervention.

The updated configuration now provides a predictable and controlled lifecycle for malicious security events within Akto.
