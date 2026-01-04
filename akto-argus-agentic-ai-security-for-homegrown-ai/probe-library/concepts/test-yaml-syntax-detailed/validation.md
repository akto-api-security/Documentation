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

There 2 extra instructions in the validation block -

### <mark style="color:red;">`percentage_match`</mark>

Percentage Match operator is used for applying conditions on how similar sample response and test response are. Let’s explore this more through the below example

{% code title="Example of percentage_match" %}
```yaml
#Example 1
response_payload:
	percentage_match:
		gt: 90

# Here we want to apply a condition, where we want to check that test response payload should be highly similar to sample response payload(i.e by more than 90%)
# We use percentage_match operator, and combine it with data operator(gt), where we specify percentage_match to be higher than 90
 
```
{% endcode %}

```
// 100% match
Original request - 
{
   "name" : "Jane",
   "dob" : "01/28/1989",
   "position" : "Attorney General"
}

Attempt request - 
{
   "name" : "Jane",
   "dob" : "01/28/1989",
   "position" : "Attorney General"
}
```

```
// 0% match
Original request - 
{
   "name" : "Jane",
   "dob" : "01/28/1989",
   "position" : "Attorney General"
}

Attempt request - 
{
   "name" : "John",
   "state" : "California",
   "year" : "2023"
}
```

### <mark style="color:red;">`percentage_match_schema`</mark>

This operator is used for applying conditions on how structurally similar sample response and test response are. Here we look at keys of the json payloads. Values are ignored.

{% code title="Example of percentage_match" %}
```yaml
#Example 1
response_payload:
	percentage_match_schema:
		gt: 90

# Here we want to apply a condition, where we want to check that test response payload should be structurally similar to sample response payload(i.e by more than 90%)
# We use percentage_match_schema operator, and combine it with data operator(gt), where we specify percentage_match of the schema to be higher than 90
 
```
{% endcode %}

```
// 100% match
Original request - 
{
   "name" : "Jane",
   "position" : "Attorney General"
}

Attempt request - 
{
   "name" : "John",
   "position" : "Partner"
}
```

```
// 20% match ("name" is same across 5 keys - name, city, position, state & year)
Original request - 
{
   "name" : "Jane",
   "city" : "San Francisco",
   "position" : "Attorney General"
}

Attempt request - 
{
   "name" : "John",
   "state" : "California",
   "year" : "2023"
}
```
