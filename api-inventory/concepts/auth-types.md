# Auth types

Akto is designed to automatically detect standard authentication methods like JWT and Bearer authorization headers. This helps in identifying and addressing potential security threats. However, not all APIs follow standard practices. Hence, Akto also supports custom authentication methods.

For example, if your API uses a non-standard authentication method, such as sending the auth token under a non-standard header, Akto provides the flexibility to set this up as a custom auth type. This means you can customize Akto to suit the unique requirements of your API. Even if your authentication method doesn't align with standard practices, Akto can still analyze and secure it properly.
