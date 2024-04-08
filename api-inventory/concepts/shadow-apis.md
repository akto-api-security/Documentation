---
description: Akto can detect and alert about Shadow APIs
---

# Shadow APIs

Shadow APIs are APIs that exist within the system but are not documented or known to the managers or owners of the API ecosystem. These can pose a significant security risk as they can be exploited without detection.

For example, a software development team might create new version of an API (`/v3/`) for but forgets to remove `/v2/` . If the team removes security controls and forgets to secure `/v2` API when the feature goes live, it becomes a Shadow API. Unauthorized users who discover this API might be able to access sensitive data or perform actions that could harm the system.&#x20;

Because `v2` is still active, but not documented anymore, it will most likely bypass all future security checks. This unnoticed API poses significant risk.&#x20;

### Detect Shadow APIs

Akto now creates an API collection titled ‘Shadow APIs’ when testing your APIs.

You can test your collection for this Improper Inventory Management vulnerability through the test `BOLA in old api versions`

Here’s how you can do it on Akto:

{% embed url="https://demo.arcade.software/6RM70qc19XYu6q7MIVJL" %}
