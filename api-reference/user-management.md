# User Management

## Overview

User management APIs in Akto allow you to manage access control and team membership within your organization. You can use these APIs to retrieve team details, invite new users, and remove existing users.

#### Available Endpoints

<table><thead><tr><th width="105.796875">Method</th><th width="223.45703125">Endpoint</th><th>Description</th></tr></thead><tbody><tr><td>POST</td><td><code>/api/getTeamData</code></td><td>Retrieves information about the current team, including user roles and details</td></tr><tr><td>POST</td><td><code>/api/inviteUsers</code></td><td>Sends invitations to new users to join your Akto workspace</td></tr><tr><td>POST</td><td><code>/api/removeUser</code></td><td>Removes an existing user from your Akto workspace</td></tr></tbody></table>

{% openapi-operation spec="lastestscanresultv1" path="/api/getTeamData" method="post" %}
[OpenAPI lastestscanresultv1](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/main/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/inviteUsers" method="post" %}
[OpenAPI lastestscanresultv1](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/main/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="lastestscanresultv1" path="/api/removeUser" method="post" %}
[OpenAPI lastestscanresultv1](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/main/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}
