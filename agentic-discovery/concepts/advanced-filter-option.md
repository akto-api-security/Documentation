# Advanced Filter Option

By using these Advanced Filter Options, you can tailor Akto's analysis to focus on the specific aspects of your API traffic that are most relevant to your current needs.

### Overview

Advanced filters allow you to:

* Include or exclude specific API endpoints based on criteria
* Focus analysis on particular HTTP methods, response codes, or content types
* Target specific hosts or domains for monitoring
* Create complex filtering rules using logical operators (AND, OR)

### Steps to Configure

* Go to Settings > Advanced traffic filters.
* Click "Add new" to create a filter.
* Enter the YAML configuration based on your requirements.
* Click "Save" to apply the filter.

{% @arcade/embed url="https://app.arcade.software/share/CTMTUrQxSuYh1Zkftd2F" flowId="CTMTUrQxSuYh1Zkftd2F" %}

### Default Blocking Filter

Akto comes with a pre-configured default filter that automatically focuses your analysis on the most relevant API traffic by excluding common noise.

Ignores the following APIs:

1. APIs with response code greater than or equal to 400
2. APIs which are of HTML type
3. APIs which are from your localhost server

```yaml
id: DEFAULT_BLOCK_FILTER
filter:
  or:
    - response_code:
        gte: 400
    - response_headers:
        for_one:
          key:
            eq: content-type
          value:
            contains_either:
              - html
              - text/html
    - request_headers:
        for_one:
          key:
            eq: host
          value:
            regex: .*localhost.*
```

### Use Cases

Here are some use cases that demonstrate how you can customize the Advanced Filter Options:

#### Case 1: Selective Host Content Filtering

Ignore APIs from specific hosts that have content-type text or HTML.

**When to use:** When you want to exclude HTML/text content from specific domains but continue monitoring other content types.

```yaml
id: DEFAULT_BLOCK_FILTER
filter:
  and:
    - request_headers:
        for_one:
          key:
            eq: host
          value:
            contains_either:
              - app.akto.io
              - juiceshop.akto.io
    - response_headers:
        for_one:
          key:
            eq: content-type
          value:
            contains_either:
              - html
              - text
```

#### Case 2: API Version and Method Filtering

Only allow APIs with specific version path (api/v1) and restrict to certain HTTP methods.

**When to use:** When you want to focus on a specific API version and limit the HTTP methods being analyzed.

```yaml
id: DEFAULT_ALLOW_FILTER
filter:
  and:
    method:
      contains_either:
        - GET
        - POST
        - PUT
        - DELETE
    url:
      regex: '.*api\/v1.*'
```

#### Case 3: Host Merging

Merge traffic from multiple development environments into a single Akto collection.

**When to use:** When different ports are opened for the same host or you have different hosts that should be treated as one collection.

```yaml
id: MODIFY_CLAIMED_SITE_HOST_AUDITS
filter:
  request_headers:
    for_one:
      key:
        eq: host
      value:
        regex: '^akto-dev-\d+\.in

execute:
  type: single
  requests:
    - req:
      - modify_header:
          host: akto-dev-NUMBER.in
```

### Explanation of Key Concepts

* **id**: Unique identifier for the filter
* **filter**: The main block containing filtering conditions
* **response\_code**: Filters based on HTTP status codes
* **method**: Filters based on HTTP methods (GET, POST, PUT, DELETE, etc.)
* **url**: Filters based on the request URL pattern
* **request\_headers/response\_headers**: Filters based on HTTP headers
* **and/or**: Logical operators to combine multiple conditions
* **contains\_either**: Matches if any of the listed values are present
* **regex**: Uses regular expressions for pattern matching
* **for\_one**: Applies conditions to at least one of the headers

This filter will only allow traffic that meets all specified conditions. For more details on advanced filtering options, visit [API Selection Filters](../../probe-library/concepts/test-yaml-syntax-detailed/api-selection-filters.md).

### Best Practices

* Start with broader filters and narrow down as needed
* Test filters on a small subset of traffic before applying widely
* Use the `regex` pattern carefully; overly complex patterns may impact performance
* When using multiple conditions, understand how `and` and `or` operators affect your filter logic
* Regularly review and update your filters as your API landscape evolves
