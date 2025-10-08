# Schema Conformance

Detects API requests that deviate from the expected schema defined for an endpoint. This includes missing required fields, incorrect data types, or unexpected properties. In the example above, a `PUT` request to `/api/v3/pet` triggered a **Medium severity** alert because the required properties `name` and `photoUrls` were missing in the request payload. These violations may indicate probing activity or misuse of the API by an attacker or misconfigured client. Akto flags such schema validation errors in real-time, enabling quick triage and response, including blocking IPs or creating issue tickets directly from the dashboard.

<figure><img src="../../.gitbook/assets/image (2) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
