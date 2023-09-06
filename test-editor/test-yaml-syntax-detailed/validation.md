# Validation

This section describes the `conditions` that serve as validation criteria for determining whether a particular endpoint is vulnerable to a given test.

## **Syntax**

The syntax is the similar to `API Selection Filters`. The operators used for filtering or selecting APIs to run for testing are also used to validate whether the test attempt is vulnerable.

Let’s look at few examples and understand how to write validations -

**Example 1**

{% code lineNumbers="true" %}
```yaml
# Validation Scenario - 
# condition 1: Response Code Should be either 200 or 201.
# condition 2: Response Payload Should contain a key whose value contains substring “admin”
# condition 3: Response Headers Should contain a key “origin”
# All conditions are mandatory.
# Sample Yaml - 

validate:
  response_code:
    or:
      eq: 200
      eq: 201
  response_payload:
    for_one:
      value:
        contains_either: admin
  response_headers:
    for_one:
      key:
        eq: origin
```
{% endcode %}

**Example 2**

{% code lineNumbers="true" %}
```yaml
# Validation Scenario 
# condition 1: Response Length Should be greater than 0
# condition 2: Response Payload Should contain a key named username whose value contains substring testuser or defaultuser
# condition 3: Response Headers Should contain a value which is of url type
# All conditions are mandatory.

validate:
  response_code:
    or:
      eq: 200
      eq: 201
  response_payload:
    for_one:
      key:
        eq: user
      value:
        contains_either: 
            - testuser
            - defaultuser
  response_headers:
    for_one:
      value:
        regex: https?:.*
```
{% endcode %}
