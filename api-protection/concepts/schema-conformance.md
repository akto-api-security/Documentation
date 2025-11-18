# Schema Conformance

Detects API requests that deviate from the expected schema defined for an endpoint. This includes missing required fields, incorrect data types, or unexpected properties. In the example above, a `PUT` request to `/api/v3/pet` triggered a **Medium severity** alert because the required properties `name` and `photoUrls` were missing in the request payload. These violations may indicate probing activity or misuse of the API by an attacker or misconfigured client. Akto flags such schema validation errors in real-time, enabling quick triage and response, including blocking IPs or creating issue tickets directly from the dashboard.


#### How to configure

Add this policy to Api Threat Detection -> Threat Policies
```
id: SchemaConform
filter:
  request_payload:
    conform_schema: true

info:
  name: "SchemaConform"
  description: "The SchemaConform vulnerability occurs when API requests fail to adhere to the defined schema, potentially allowing malicious or malformed inputs to bypass validation checks."
  details: |
    The SchemaConform vulnerability arises in API runtime threat protection when incoming requests do not conform to the expected schema, such as OpenAPI or JSON Schema definitions. This can occur due to missing required fields, incorrect data types, or unexpected parameters. Such vulnerabilities may allow attackers to exploit APIs by sending malformed requests that could lead to data corruption, unauthorized access, or system crashes. For example, an attacker might send a string in a field expecting a number, causing unexpected behavior in the application logic. Proper schema validation and runtime checks are essential to mitigate this risk.
  impact: |
    The SchemaConform vulnerability poses significant risks to API security and system stability. When requests fail to adhere to the defined schema, attackers may exploit weak validation to inject malicious inputs, leading to data corruption, unauthorized access to sensitive resources, or application crashes that cause denial-of-service conditions. This can compromise data integrity, disrupt service availability, and potentially violate regulatory compliance requirements, such as GDPR or HIPAA, if sensitive data is mishandled. Robust schema validation, input sanitization, and continuous API traffic monitoring are critical to mitigating these threats and ensuring secure API operations.
  category:
    name: "SchemaConform"
    displayName: "SchemaConform"
  subCategory: "SchemaConform"
  severity: MEDIUM
```

<figure><img src="../../.gitbook/assets/image (2) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
