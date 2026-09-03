# Run Scan

Running security probes in Akto involves assessing agent components to evaluate their security posture. You can run probes instantly or schedule them for later, making it useful for planning probing sessions or implementing regular security validation.

## Running Probes on Agent Components

{% stepper %}
{% step %}
Navigate to **Agentic AI Discovery > Collections**
{% endstep %}

{% step %}
Select the collection containing the agent components you want to probe
{% endstep %}

{% step %}
Choose specific agent components or select all components in the collection
{% endstep %}

{% step %}
Click **Run Scan** to open the **Configure scan** window

<figure><img src="../../../.gitbook/assets/image (3).png" alt="" width="563"><figcaption></figcaption></figure>
{% endstep %}

{% step %}
(Optional) Edit the **Name** field to identify this scan run.&#x20;

Akto auto-generates a name based on the target and selected tests, but you can rename it or click **Clear selection** to reset the test selection.
{% endstep %}

{% step %}
Select **Test Categories** and **Tests** to run.

The window shows two panels:

* **Test Categories** (left): broad groupings such as Model Context Protocol (MCP) Security, MCP - Broken Authentication, MCP - Denial of Service, MCP - Indirect Prompt Injection, MCP - Input Validation, and MCP - Malicious Code Execution. Each category shows how many tests within it are selected (e.g., `43 out of 43 selected`).
* **Tests** (right): the individual tests inside the selected categories, each with its own checkbox. Tests you or your org have created show a **Custom** tag. Use the checkbox at the top to select/deselect all, or use **More filters** and the search icon to narrow the list.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (2).png" alt="" width="563"><figcaption></figcaption></figure></div>

{% hint style="success" %}
**Estimated Usage** at the bottom of the panel shows the projected token consumption for the current selection, updating live as you add or remove tests. Use this to evaluate expected LLM consumption before starting the scan.
{% endhint %}
{% endstep %}

{% step %}
Configure the scan execution parameters.

<details>

<summary>Scan Execution Parameters</summary>

<table><thead><tr><th width="181.08203125">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><strong>Run Type</strong></td><td>Defines how the scan runs. You can run the scan <strong>once</strong> or configure scheduled execution.</td></tr><tr><td><strong>Select Date</strong></td><td>Defines the date when the scan execution starts.</td></tr><tr><td><strong>Select Time</strong></td><td>Defines the time when the scan execution begins.</td></tr><tr><td><strong>Scan Run Time</strong></td><td>Defines the maximum duration allowed for the scan execution. The scan stops automatically when the configured duration expires.</td></tr><tr><td><strong>Select Scan Role</strong></td><td>Associates a predefined scan role that defines permissions and execution behavior for the scan.</td></tr><tr><td><strong>Max Concurrent Requests</strong></td><td>Controls the number of parallel probe requests executed during the scan. Higher concurrency increases scan speed but also increases request load.</td></tr><tr><td><strong>Max Agent Tokens</strong></td><td>Defines the maximum number of tokens that the agent can consume during the scan. The <strong>No limit</strong> option allows unrestricted token usage.</td></tr><tr><td><strong>Select Testing Module(s)</strong></td><td>Chooses which probing module(s) execute the scan. See <a href="testing-module-selector-in-akto.md">Scanning Module Selector in Akto</a>.</td></tr></tbody></table>

</details>

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (227).png" alt="" width="563"><figcaption></figcaption></figure></div>


{% endstep %}

{% step %}
(Optional) Turn on post-scan actions:

* **Send slack alert post test completion**: sends a notification to the selected **Slack Channel** once the scan finishes.
* **Send MS Teams alert post test completion**: sends a Microsoft Teams notification once the scan finishes.
* **Auto-create tickets**: automatically opens tickets for issues found by the scan.
* **Use different target for scanning**: lets you point this scan at a target other than the one associated with the collection.
* **Mark issues as fixed if they don't show up again**: automatically closes previously reported issues that no longer reproduce in this scan run.
* **Smart Automated Testing**: lets Akto adapt test execution automatically instead of running the fixed selection as-is.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (226).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
(Optional) Click **Show advance configurations** to add custom headers or conditions to the scan's requests.&#x20;

* Choose **Add Header**, enter a key/value pair, and use **Add condition** to chain multiple headers with **AND**/**OR** logic.&#x20;

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (228).png" alt="" width="563"><figcaption></figcaption></figure></div>

This is useful for authentication tokens or agent-specific request requirements.
{% endstep %}

{% step %}
Click **Run once now** (the button label follows the selected **Run Type**, e.g. **Schedule scan** for scheduled runs) to start the security scan.
{% endstep %}
{% endstepper %}
