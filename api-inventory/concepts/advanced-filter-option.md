# Advanced Filter Option

By using these Advanced Filter Options, you can tailor Akto's analysis to focus on the specific aspects of your API traffic that are most relevant to your current needs.

### Use Case

Filter for successful POST and GET requests (status codes 200-299).

### Steps to Configure

{% @arcade/embed flowId="CTMTUrQxSuYh1Zkftd2F" url="https://app.arcade.software/share/CTMTUrQxSuYh1Zkftd2F" %}

1. Go to Settings > Advanced traffic filters.
2. Click "Add new" to create a filter.
3. Enter the following YAML configuration:

```yaml
id: DEFAULT_ALLOW_FILTER
filter:
  response_code:
    gte: 200
    lt: 300
  method:
    eq: POST
  method:
    eq: GET
```

4. Click "Save" to apply the filter.

### Explanation

* `id`: Unique identifier for the filter
* `response_code`: Filters status codes 200-299
* `method`: Includes both POST and GET requests

This filter will only allow traffic that meets all specified conditions. For more details on advanced filtering options, visit [API Selection Filters](../../test-editor/concepts/test-yaml-syntax-detailed/api-selection-filters.md).
