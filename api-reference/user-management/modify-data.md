# Modify Data

## User, Auth & Access Control

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="420">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/logout</strong></td><td>Logs out the current user, clears session and auth cookies, and returns a redirect URL.</td></tr><tr><td>2</td><td><strong>POST /api/createNewAccount</strong></td><td>Creates a new Akto account under the current user and initialises it with default agentic collections and settings.</td></tr><tr><td>3</td><td><strong>POST /api/goToAccount</strong></td><td>Switches the active session context to a different account that the current user has access to.</td></tr><tr><td>4</td><td><strong>POST /api/updateUsernameAndOrganization</strong></td><td>Updates the current user's display name and, if the user is an ADMIN, the organisation name.</td></tr><tr><td>5</td><td><strong>POST /api/removeInvitation</strong></td><td>Removes a pending invitation for the given email address. Only the invitation issuer or an ADMIN can remove invitations.</td></tr><tr><td>6</td><td><strong>POST /api/resetUserPassword</strong></td><td>Generates a password reset token for the specified user. Token is valid and can only be generated once every 2 hours.</td></tr><tr><td>7</td><td><strong>POST /api/createCustomRole</strong></td><td>Creates a new custom role with specified base role, collection access, and feature permissions.</td></tr><tr><td>8</td><td><strong>POST /api/updateCustomRole</strong></td><td>Updates an existing custom role's base role, collection access, and feature permissions.</td></tr><tr><td>9</td><td><strong>POST /api/deleteCustomRole</strong></td><td>Deletes a custom role by name. The role must not be assigned to any users or pending invites.</td></tr><tr><td>10</td><td><strong>POST /api/makeAdmin</strong></td><td>Updates the role of a user within the current account.</td></tr><tr><td>11</td><td><strong>POST /api/updateUserScopeRoleMapping</strong></td><td>Updates the per-product-scope role mapping for a user, enabling fine-grained access control across product areas.</td></tr><tr><td>12</td><td><strong>POST /api/applyAccessType</strong></td><td>Triggers a background job to recalculate Agentic Component access types for all components based on current private CIDR and partner IP rules.</td></tr><tr><td>13</td><td><strong>POST /api/resetCollectionAccessTypes</strong></td><td>Starts a background job to reset access types for all Agentic Components across all collections.</td></tr><tr><td>14</td><td><strong>POST /api/addApiToken</strong></td><td>Creates a new Agentic Request token of the specified utility type for the current user.</td></tr><tr><td>15</td><td><strong>POST /api/deleteApiToken</strong></td><td>Deletes the specified Agentic Request token. Only the owning user can delete their own tokens.</td></tr><tr><td>16</td><td><strong>POST /api/saveSubscription</strong></td><td>Saves a web push notification subscription for the current user.</td></tr><tr><td>17</td><td><strong>POST /api/provisionSubscription</strong></td><td>Creates a billing checkout session via Stigg for the specified plan, and returns the checkout result.</td></tr><tr><td>18</td><td><strong>POST /api/refreshUsageDataForOrg</strong></td><td>Triggers a background job to recalculate and sync usage metrics for all accounts in the current organisation.</td></tr></tbody></table>

{% openapi-operation spec="akto-agentic-security-api" path="/api/logout" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/createNewAccount" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/goToAccount" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateUsernameAndOrganization" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/removeInvitation" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/resetUserPassword" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/createCustomRole" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateCustomRole" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteCustomRole" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/makeAdmin" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/updateUserScopeRoleMapping" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/applyAccessType" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/resetCollectionAccessTypes" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/addApiToken" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/deleteApiToken" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/saveSubscription" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/provisionSubscription" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/refreshUsageDataForOrg" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}
