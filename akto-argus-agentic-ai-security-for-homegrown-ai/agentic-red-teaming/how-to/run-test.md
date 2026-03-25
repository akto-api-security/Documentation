# Run Scan

Running security probes in Akto involves assessing agent components to evaluate their security posture. You can run probes instantly or schedule them for later, making it useful for planning probing sessions or implementing regular security validation.

## Running Probes on Agent Components

{% stepper %}
{% step %}
Navigate to **Agentic Discovery > Collections**
{% endstep %}

{% step %}
Select the collection containing the agent components you want to probe
{% endstep %}

{% step %}
Choose specific agent components or select all components in the collection
{% endstep %}

{% step %}
Click **Run Scan**
{% endstep %}

{% step %}
Select probe categories to run (Prompt Injection, MCP Security, LLM Security, etc.)

{% hint style="success" %}
The **Scan** panel displays the estimated token usage for every probe. Token estimation helps enterprise teams evaluate expected LLM consumption before starting the scan.
{% endhint %}
{% endstep %}

{% step %}
Configure probe parameters if needed.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (151).png" alt="" width="375"><figcaption></figcaption></figure></div>

<details>

<summary>Scan Execution Parameters</summary>

<table><thead><tr><th width="181.08203125">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><strong>Run Type</strong></td><td>Defines how the scan runs. You can run the scan <strong>once</strong> or configure scheduled execution.</td></tr><tr><td><strong>Select Date</strong></td><td>Defines the date when the scan execution starts.</td></tr><tr><td><strong>Select Time</strong></td><td>Defines the time when the scan execution begins.</td></tr><tr><td><strong>Scan Run Time</strong></td><td>Defines the maximum duration allowed for the scan execution. The scan stops automatically when the configured duration expires.</td></tr><tr><td><strong>Select Scan Role</strong></td><td>Associates a predefined scan role that defines permissions and execution behavior for the scan.</td></tr><tr><td><strong>Max Concurrent Requests</strong></td><td>Controls the number of parallel probe requests executed during the scan. Higher concurrency increases scan speed but also increases request load.</td></tr><tr><td><strong>Max Agent Tokens</strong></td><td>Defines the maximum number of tokens that the agent can consume during the scan. The <strong>No limit</strong> option allows unrestricted token usage.</td></tr><tr><td><strong>Slack Alert Integration</strong></td><td>Enables Slack notifications after scan completion. The Slack integration sends alerts for scan results.</td></tr><tr><td><strong>Microsoft Teams Alert Integration</strong></td><td>Enables Microsoft Teams notifications after scan completion. The Microsoft Teams integration sends alerts for scan results.</td></tr></tbody></table>

</details>
{% endstep %}

{% step %}
Click **Run once now** to start the security scan.
{% endstep %}
{% endstepper %}

## Probe Categories

When running probes, you can select from specialised categories:

* **Prompt Injection**: Probes for direct and indirect prompt injection vulnerabilities
* **LLM Security**: Validates model-specific security controls
* **MCP Security**: Probes Model Context Protocol implementations
* **Sensitive Information Disclosure**: Detects credential and PII exposure
* **Excessive Agency**: Validates tool permission boundaries
* **Supply Chain**: Identifies dependency vulnerabilities

and more...

## Modify Probe Parameters

You can add, modify, or remove headers and parameters directly from the probe configuration without editing YAML files. This allows you to customize probes for specific agent behaviors or authentication requirements.
