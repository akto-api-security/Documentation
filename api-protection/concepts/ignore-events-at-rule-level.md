#### Ignore Events at Rule Level

You can configure threat rules to skip evaluation for specific APIs by adding an `ignore:` block. When an API matches the conditions in the `ignore:` block, the rule will not be evaluated further for that particular API.

#### How to configure

Add an `ignore:` block to any threat rule following the similar syntax as `filters:` block.

**Syntax Reference:** For detailed syntax on how to define API selection filters, see [API Selection Filters](https://docs.akto.io/test-editor/concepts/test-yaml-syntax-detailed/api-selection-filters).

<figure><img src="" alt=""><figcaption></figcaption></figure>

#### Example: Ignoring Specific Endpoints

This example shows how to ignore evaluation for APIs that contain `/health` or `/status` in their URL:

```yaml
id: ExampleThreatRule
ignore:
  url:
    contains_either:
      - "/health"
      - "/status"

filter:
  # Your threat detection filters here

info:
  name: "Example Threat Rule"
  description: "Detects potential threats"
  severity: HIGH
```

When this rule is processed, any API with `/health` or `/status` in the URL will be skipped and the rule will not be evaluated for those APIs.
