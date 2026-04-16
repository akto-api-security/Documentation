# Fetch Data

## User, Auth & Access Control

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="400">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/me</strong></td><td>Fetches the current logged-in user's profile information including login, name, role, and associated accounts.</td></tr><tr><td>2</td><td><strong>POST /api/fetchUserLastLoginTs</strong></td><td>Fetches the Unix timestamp of the current user's last login.</td></tr><tr><td>3</td><td><strong>POST /api/getCustomRoles</strong></td><td>Retrieves all custom roles defined in the system for the current account.</td></tr><tr><td>4</td><td><strong>POST /api/getRoleHierarchy</strong></td><td>Returns the role hierarchy that the current user is permitted to assign to others.</td></tr><tr><td>5</td><td><strong>POST /api/getAccessTypes</strong></td><td>Fetches access-type information (public, private, partner) for a given list of Agentic Component URLs.</td></tr><tr><td>6</td><td><strong>POST /api/fetchApiTokens</strong></td><td>Fetches all API Request tokens (including Slack webhook tokens) belonging to the current user in the current account.</td></tr><tr><td>7</td><td><strong>POST /api/getCustomerStiggDetails</strong></td><td>Fetches a signed Stigg customer token for authenticating the Stigg in-app widget on the client side.</td></tr><tr><td>8</td><td><strong>POST /api/getUserAnalysis</strong></td><td>Fetches user analysis data for a given MCP agent and device, used by the Endpoint Shield agent.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/me" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchUserLastLoginTs" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getCustomRoles" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getRoleHierarchy" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getAccessTypes" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchApiTokens" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getCustomerStiggDetails" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getUserAnalysis" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}
