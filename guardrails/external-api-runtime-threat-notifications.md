---
hidden: true
---

# External Agent Runtime Threat Notifications

To notify external systems (e.g., SIEM tools, alerting systems, incident management platforms) about **agent runtime threats** detected by Akto, including high-frequency 4XX errors, SSRF, prompt injection, broken auth logic, tool abuse, and other agentic security threats.

### Setup in Akto

When setting up your webhook in Akto:

1. Go to **Settings → Integrations → Webhooks → Create Custom Webhook**
2. Fill in:
   * **Name**: e.g., `External Threat Monitor`
   * **URL**: Your receiving API endpoint
   * **Headers**: `{ "content-type": "application/json" }`
3. Select **Traffic option** → `New agent runtime threats`
4.  Configure:

    * **Run every**: 15 min / 1 hour (as per need)
    * **Batch size**: e.g., `20 payloads`
    * **Alert frequency**: `Periodic` or `Instant`
5. Click **Save**

### 📤 Webhook Payload Format (JSON)

````json

{
  "maliciousEvents": [
      {
          "actor": "14.143.179.162",
          "apiCollectionId": 0,
          "country": "IN",
          "eventType": "AGGREGATED",
          "filterId": "4XX_FILTER",
          "ip": "14.143.179.162",
          "method": "POST",
          "subCategory": "API_LEVEL_RATE_LIMITING",
          "timestamp": 1747162308,
          "type": "Rule-Based",
          "url": "v1\/api\/test\/orders",
          "maliciousPayloadsResponses": [
            {
                "orig": "{}",
                "ts": 1747161046
            }
        ]
      }
  ],
  "overview": {
    "description": "The High4XXAlertFilter vulnerability in agent threat protection at runtime occurs when security systems generate excessive alerts for 4XX response codes, potentially leading to alert fatigue and missed critical agentic threats. Attackers can exploit this by flooding agent components with benign 4XX errors, masking real attacks like prompt injections or tool abuse in the noise. Proper rate limiting, anomaly detection, and intelligent alert filtering can help mitigate this risk.",
    "details": "The High4XXAlertFilter vulnerability affects agent threat protection by overwhelming monitoring systems with excessive 4XX errors, making it harder to detect real threats. Attackers can abuse this by triggering numerous client-side errors (e.g., 401, 403, 404) to drown out malicious activity targeting agent components. Effective mitigation involves adaptive alerting, contextual analysis, and filtering noise from genuine security incidents.",
    "impact": "The High4XXAlertFilter vulnerability can lead to alert fatigue, causing security teams to overlook real threats hidden within a flood of 4XX errors. This increases the risk of undetected attacks, such as credential stuffing, agent enumeration, or token abuse. It can also degrade agent component performance and overwhelm logging systems, impacting overall security visibility."
  },
  "remediation": {
    "title": "# Remediation for 2FA_BROKEN_LOGIC_AUTH_TOKEN_TEST",
    "steps": [
      {
        "title": "Validate Auth token API",
        "text": "Ensure that your API thoroughly validates the auth token before deciding whether a request is authenticated or not. A proper validation should include checking for the matching user id and validity of the auth token. Here is an example in Python
          ```python
          def validate_auth_token(user_id, auth_token):
              user = User.query.filter_by(id=user_id).first()
              if user is None or not user.check_auth_token(auth_token):
                  return False
              return True
          ```"
      }
    ]
  }
}
````
