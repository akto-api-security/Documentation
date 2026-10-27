# Access Restrictions and Exceptions

Restrict which hosts, paths, and accounts can interact with your agents, and define phrases a policy should treat as safe.

This page is part of the [Create Guardrail Policies](../create-guardrail-policies.md) form reference.

## Access Restrictions

Configure controls to restrict which hosts, paths, and account types can interact with your agents.

**Block host / path**

Block outbound traffic by host or path pattern to prevent agents from reaching unauthorised external services or endpoints.

* Enter a host or path pattern in the **Host or path pattern** field.
* Select **Add** to include the pattern in the blocked list.

The **Blocked patterns** list displays all configured entries. You can review and remove patterns from this list at any time.

{% hint style="info" %}
Akto sits between your agents and their outbound traffic. When a request is made, Akto checks the destination host or path against the blocked patterns and denies any match before it reaches the target.
{% endhint %}

**Block personal accounts**

Prevent users with personal or consumer email accounts from accessing the AI agent. Enterprise accounts using company email domains are allowed through.

* Enable **personal account blocking** to restrict access to organisation-managed accounts only.

**Block public sharing**

Block chats and artifacts from being shared through public links, so conversations and generated content stay inside your organisation.

* Enable **public sharing blocking** to stop users from creating public links to chats and artifacts in supported AI tools.

{% hint style="info" %}
Personal account blocking is enforced through the [browser extension](../../../akto-atlas-agentic-ai-security-for-employee-endpoints/endpoints-discovery-agents/browser-extensions/chrome/extension-usage-behaviour.md), and currently supports the following browser LLMs: **chatgpt.com**, **gemini.google.com**, **claude.ai**, **copilot.microsoft.com**, and **grok.com**. Requires Akto browser extension v1.0.69 or later; it is currently supported only through the browser extension, with AI Endpoint Shield Agent support coming soon.
{% endhint %}

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (177).png" alt="" width="563"><figcaption></figcaption></figure></div>

## Exceptions

Configure phrases that this policy's own detectors should treat as safe and skip, without affecting how other guardrail policies evaluate the same traffic.

**Ignore Phrases**

* Enter a phrase in the **Ignore phrases** field (e.g. your product name or sample test data). Phrases are matched as a whole word by default.
* Enable **Regex** to match the entry as a regular expression instead of literal text.
* Enable **Case sensitive** to match the phrase's casing exactly.
* Select **Add phrase** to include it in the ignored list.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (220).png" alt="" width="563"><figcaption></figcaption></figure></div>

The **Ignored phrases** list displays a count of configured entries and lets you remove any phrase at any time.

{% hint style="info" %}
Ignore phrases only affect this policy's own detectors, so other guardrail policies evaluated on the same traffic still see the real text.
{% endhint %}
