#### Ignored Malicious Events Policy

Customizable filters that mark detected security threats by Akto's Runtime Threat Protection as ignored in the Threat Activity dashboard. 


#### How to configure
Go to **API Threat Detection → Threat Activity** in the left sidebar. Click **More Actions → Configure Ignored Events**.

**Note:** Policies must use category name `IgnoredEvent`

**Syntax Reference:** For detailed syntax on how to define API selection filters, see [API Selection Filters](https://docs.akto.io/test-editor/concepts/test-yaml-syntax-detailed/api-selection-filters).

<figure><img src="../../.gitbook/assets/configure-ingored.png" alt=""><figcaption></figcaption></figure>

#### Example Ignored Events Policy
Marks all threats as ignored when when the URL contains `test`.
```
id: IgnoredEvent
filter:
  url:
    contains_all:
      - "test"

info:
  name: "IgnoredEvent"
  description: "Marks threats as ignored events"
  details: "Identifies which threat activities to ignore"
  impact: "Sets the events status as ignored."
  category:
    name: "IgnoredEvent"
    displayName: "IgnoredEvent"
  subCategory: "IgnoredEvent"
  severity: HIGH
```

<figure><img src="../../.gitbook/assets/threat-ignored-policy.png" alt=""><figcaption></figcaption></figure>