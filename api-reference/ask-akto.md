# Ask Akto

## Table of Contents

* [#ai-queries](ask-akto.md#ai-queries "mention")
* [#conversations](ask-akto.md#conversations "mention")

## AI Queries

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="430">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/ask_ai</strong></td><td>Routes a query to the appropriate LLM handler based on type (suggest tests, generate regex, analyze vulnerability, etc.).</td></tr><tr><td>2</td><td><strong>POST /api/analyze_vulnerability</strong></td><td>Passes structured content to an AI handler to analyze a vulnerability or test result, with in-process caching.</td></tr><tr><td>3</td><td><strong>POST /api/saveAktoGptConfig</strong></td><td>Saves the enabled/disabled state of the AI feature for one or more API collections.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/ask_ai" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/analyze_vulnerability" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/saveAktoGptConfig" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

## Conversations

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="430">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/chatAndStore</strong></td><td>Sends a user message to the Akto MCP agent, stores the conversation turn, and returns the assistant's reply with conversation metadata.</td></tr><tr><td>2</td><td><strong>POST /api/fetchHistory</strong></td><td>Returns the most recent conversations grouped by conversation ID, sorted by last updated timestamp.</td></tr><tr><td>3</td><td><strong>POST /api/deleteConversationHistory</strong></td><td>Permanently deletes all conversation documents sharing a given conversation ID.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/chatAndStore" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchHistory" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteConversationHistory" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}
