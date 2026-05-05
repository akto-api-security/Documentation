# Guardrail Schema

## Overview

Guardrail schema allows you to enforce structural validation on request messages and response messages exchanged with agentic components and MCP tools.

Guardrail schema validation checks whether request payloads and response payloads follow the expected JSON structure. Akto starts with evaluating configured JSON paths in request messages and response messages for the selected component.

Akto blocks the transaction when required fields are missing or when payload structure deviates from configured schema rules. The validation helps you maintain consistent data contracts between agents, MCP tools, and enterprise services.

## Steps to Configure

Follow the steps below to configure guardrail schema validation for a component.

{% stepper %}
{% step %}
#### Navigate to Guardrail Schema Configuration

1. Navigate to **Agentic AI Discovery**.
2. Open the required **Agentic Collection**.
3. Locate the required **component**.
4. Click the **three-dot horizontal menu** at the end of the component row.
5.  Select **Configure Guardrail schema**.

    <div data-with-frame="true"><figure><img src="../../.gitbook/assets/Screenshot 2026-03-16 at 10.33.14 AM.webp" alt="" width="563"><figcaption></figcaption></figure></div>

The guardrail schema configuration dialog opens for the selected component.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/Screenshot 2026-03-16 at 10.34.00 AM.webp" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
#### Configure Request Message Fields

1. Locate the **Request message fields** section.
2. Click **Add field**.
3. Enter the required **JSON path** representing a request field that must exist in the request payload.
4. Add additional fields when multiple request attributes require validation.

Akto validates incoming request payloads against the configured JSON paths.
{% endstep %}

{% step %}
#### Configure Response Message Fields

1. Locate the **Response message fields** section.
2. Click **Add field**.
3. Enter the required **JSON path** representing a response field that must exist in the response payload.
4. Add additional fields when multiple response attributes require validation.

Akto validates tool response payloads against the configured response field definitions.
{% endstep %}

{% step %}
#### Configure Guardrail Blocking Behaviour

Define the response returned when schema validation fails.

<table><thead><tr><th width="236.40625">Field</th><th>Description</th></tr></thead><tbody><tr><td><strong>Blocked response code</strong></td><td>HTTP status code returned when Akto blocks a transaction. Example: <code>403</code>.</td></tr><tr><td><strong>Blocked response body</strong></td><td>Response payload returned when Akto blocks the request or response. Example: <code>{ "error": "Request blocked by guardrail" }</code>.</td></tr><tr><td><strong>Blocked response content type</strong></td><td>Content type returned for the blocked response. Example: <code>application/json</code>.</td></tr></tbody></table>

Click **Save** to apply the schema validation configuration.
{% endstep %}
{% endstepper %}

## Result

Akto then starts evaluating request messages and response messages for the selected component after you save the configuration.

Akto will block transactions when request payloads or response payloads violate configured schema validation rules. And Akto returns the configured blocked response when guardrail enforcement occurs.
