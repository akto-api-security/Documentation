---
hidden: true
---

# Bot Policy

Bot detection happens using a combination of abnormal request patterns. You can write your own patterns - including rate limiting, the sequence of APIs and schema conformance.

#### **Request Pattern Analysis**

* **Rate limiting**: Too many requests in a short time. The "threshold" is calculated dynamically - separately for each API. A "payment" or "login" API should enforce a stricter rate limit that "product search" APIs.
* **Endpoint access sequence**: Bots may not follow normal navigation flow.
* **Schema conformance**: Missing headers or malformed requests - you can use Akto to find the schema or you can upload your own.

```yaml
id: AdaptiveBotDetection
filter:
  or:
    - rate_limit:
        strategy: adaptive
        learnedBaseline: true
        deviationThresholdPercent: 200
    - endpoint_sequence:
        strategy: learnedFlow
        parameters:
          deviationScoreThreshold: 0.7
          minFlowLength: 3
          maxOutOfOrderEvents: 1
          ignoreStaticAssets: true
          matchAcrossSessions: false
    - schema_conformance:
        strategy: dynamicSchema
        parameters:
          confidenceThreshold: 0.9           # Confidence Akto has in learned schema
          allowExtraFields: false            # Disallow unknown keys
          allowMissingFields: false          # Flag missing required fields
          skipIpRange:
            - internal
            - partner
            - 141.1.34.31                    # Any IPs for where you want to skip the analysis
          valueTypeStrictness: high          # Enforce type validation strictly
          arrayLengthDeviationTolerance: 20  # % tolerance on array size deviations
          enumValueMismatchTolerance: 0      # No tolerance for invalid enum values
          nestedDepthLimit: 5                # Limit nested structure depth to detect abuse
          maxPayloadSizeKB: 100              # Flag payloads larger than expected

info:
  name: "AdaptiveBotDetection"
  description: "Bot detection via adaptive rate limits, learned API call flows, and strict schema conformity. Tuned for precision using Akto’s runtime learning."
  details: "This rule leverages Akto’s learned request schemas and flags payloads with anomalies in structure, types, fields, or suspicious key patterns. Parameters control how strict or lenient the detection should be."
  impact: "Bots often submit malformed or overly large payloads, inject debug/test fields, or violate expected schema structure. Early schema anomaly detection helps block abuse and prevents deserialization attacks."
  category:
    name: "Bot"
    displayName: "Bot Detection"
  subCategory: "Adaptive"
  severity: HIGH

aggregation_rules:
  - rule:
      name: "rate_limit"
      condition:
        matchCount: 20
        windowThreshold: 15
  - rule:
      name: "endpoint_sequence"
      condition:
        matchCount: 5
        windowThreshold: 60
  - rule:
      name: "dynamicSchema"
      condition:
        matchCount: 10
        windowThreshold: 30
```
