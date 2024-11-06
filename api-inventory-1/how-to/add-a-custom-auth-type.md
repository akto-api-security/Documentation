---
description: Explore about adding a custom auth type
---

# Add a Custom Auth Type

Akto is designed to automatically detect standard authentication methods like JWT and Bearer authorization headers. This helps in identifying and addressing potential security threats. However, not all APIs follow standard practices. Hence, Akto also supports custom authentication methods.

For example, suppose your API uses a non-standard authentication method, such as sending the auth token under a non-standard header. In that case, Akto provides the flexibility to set this up as a custom auth type.&#x20;

In the demonstration below, let's add a custom auth type with the name **`New_Auth_Type_1`**.&#x20;

Go to **Settings > Auth types**. Click on Create new auth type and enter the required details, then click on the **Save** button to create a custom auth type.

{% embed url="https://demo.arcade.software/Fh2L5kP2Td0EDF0Vj2Ab?embed=" %}
Add a Custom Auth Type
{% endembed %}

In the above demonstration, we have added a new custom auth type named **`"New_Auth_Type_1"`** Akto. This custom auth type contains conditions for both the header and payload key. Now Akto will recognize this custom authentication method when processing the API requests.
