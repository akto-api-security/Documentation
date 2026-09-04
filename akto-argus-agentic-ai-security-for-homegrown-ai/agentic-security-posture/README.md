# Agentic Security Posture

Agentic Security Posture gives you an executive view of your AI agent risk: how much of your agentic surface you have visibility into, how urgent your open risk is, and where it's concentrated. It rolls up findings from every AI agent, MCP endpoint, and LLM component Akto has discovered, so you can track posture over time and decide where to direct security investment without digging into individual findings.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (243).png" alt="" width="563"><figcaption></figcaption></figure></div>

When you need that level of detail, the [**Analysis**](analysis.md) tab turns this same data into a prioritized, team-assigned action list.

## At a Glance

Four headline numbers summarize the state of your agentic AI surface, each showing how much it has changed over the time range you've selected:

<table><thead><tr><th width="200">Metric</th><th>What it tells you</th></tr></thead><tbody><tr><td><strong>Total Agentic Components</strong></td><td>How large your agentic AI surface is: every agent, MCP endpoint, and LLM component you've discovered</td></tr><tr><td><strong>Issues</strong></td><td>How much open security risk currently exists across that surface</td></tr><tr><td><strong>Agentic Risk Score</strong></td><td>A single aggregate risk score for your agentic surface, so you can track whether your overall exposure is trending up or down</td></tr><tr><td><strong>Test Coverage</strong></td><td>How much of what you've discovered you've actually tested. A low number means you have visibility into components you haven't validated yet</td></tr></tbody></table>

## Is Your Coverage Keeping Up?

### Recent Scans

A row of cards for your most recently run scans, each showing the scan name, when it ran, issues found by severity, and how many agentic components it tested. This is the fastest way to see whether your scanning is keeping pace with how fast your agentic surface is growing. If it's falling behind, **Increase scan coverage** takes you to where your team can close the gap.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (244).png" alt="" width="563"><figcaption></figcaption></figure></div>

## Is Your Risk Trending Up or Down?

### Critical or High Severity Components Over Time

A line chart tracking, month over month, how many of your agentic components carry an unsecured critical- or high-severity issue. A rising line means new risk is outpacing what your team is closing out. **Fix critical issues** takes you to that queue.

### Issues by Severity

A donut chart of your open issues by severity (**Critical**, **High**, **Medium**, **Low**), the fastest read on how much of your current risk needs your team's immediate attention.

## What Kind of Risk Are You Exposed To?

### Vulnerabilities Findings

A bar chart of vulnerability types (e.g. Model Context Protocol (MCP) Security, Tool Misuse and Exploitation, Agent Goal Hijack, Identity and Privilege Abuse, Human-Agent Trust Exploitation) ranked by number of issues found, showing which classes of vulnerability are most common across your agentic surface.

### Threat Actor Activity

A line chart tracking threat actor activity against your agentic surface over time, so you can see whether attack attempts are increasing or tapering off. **View threat details** takes you to the specifics.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (245).png" alt="" width="563"><figcaption></figcaption></figure></div>

## What Threats Have Been Detected?

### Threats by Severity

A donut chart of detected threats by severity (**Critical**, **High**, **Medium**, **Low**). Where "Issues" reflects misconfigurations and vulnerabilities, "Threats" reflects active guardrail and policy violations Akto has observed in your agent traffic. **View all threats** takes you to the full list.

### Top Threat Categories

A bar chart of threats grouped by the guardrail or policy category that flagged them (e.g. Prompt Injection, Sensitive Info Policy, Harmful Content, Direct Prompt Injection, Supply Chain Vulnerability, LLM Excessive Agency, Indirect Prompt Injection, Malicious Code). **View all categories** takes you to the full breakdown.

## Where Is Your Risk Concentrated?

### Agentic Components by Risk Score

A bar chart bucketing your agentic components into risk score bands (0 to 5) by how many fall into each band, showing you whether your risk is spread thin or concentrated in a small number of high-risk components worth naming to your team directly. **Check out** takes you to them.

### Agentic Components by Access Type

A donut chart of your components by access type: **Partner**, **Internal**, **External**, **Third Party**, and **Need more data** for components Akto hasn't classified yet. Your externally and third-party accessible components carry more business risk than internal-only ones, keep an eye on that split. **Check out** takes you to the components behind it.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (246).png" alt="" width="563"><figcaption></figcaption></figure></div>

### Agentic Components by Authentication

A donut chart of your components by the authentication mechanism detected: **Session token**, **Bearer**, **Unauthenticated**, **Authorization header**, **JWT**, and **Need more data**. A high **Unauthenticated** count is a governance gap worth flagging on its own. **Check out** takes you to the components behind it.

### New Domains

Domains and hosts you've discovered recently, each with its current test coverage percentage and number of associated issues. New, untested domains are attack surface your team hasn't validated yet, worth raising with them. **Increase test coverage** takes you to where they can get it done.

### Agentic Component Type

A bar chart of your components by request protocol: **REST**, **GraphQL**, **gRPC**, and **SOAP**, useful context for prioritizing which protocols your security tooling and processes need to cover. **Check out** takes you to the components behind it.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (247).png" alt="" width="563"><figcaption></figcaption></figure></div>
