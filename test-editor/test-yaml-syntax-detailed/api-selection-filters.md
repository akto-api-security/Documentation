---
layout:
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: true
---

# API Selection Filters

This section describes the `conditions` that act as selection criteria for choosing APIs that are eligible for a particular test. It also filters out APIs that are not eligible.

Example:

{% code title="Example of API Selection filter" fullWidth="true" %}
```yaml
# THIS IS API SELECTION FILTER
api_selection_filters:
  response_code:
    gte: 200
    lt: 300
  url:
    contains_either:
      - login
      - signin
      - sign-in
      - log-in
  request_payload:
    for_one:
      key: 
        contains_either:
          - password
          - pwd
          - pass
          - passwd
  request_headers:
    for_one:
      key:
        contains_either: cookie
        extract: header_key
```
{% endcode %}

## **Syntax**

1. Parent Operators
2. Data Operators
3. Collection Operators
4. Combining Conditions using Boolean Operators



## **Parent Operators**

Each `condition` block begins with a parent operator. Parent Operators indicate the `property of the API` you are testing. All the conditions will apply to these parent operators. Parent Operators can have the following values:

<table><thead><tr><th width="212.5">Parent Operator</th><th>Description</th></tr></thead><tbody><tr><td>response_code</td><td>This denotes that the conditions will be applied on response code of the api</td></tr><tr><td>method</td><td>This denotes that the conditions will be applied on http method of the api</td></tr><tr><td>url</td><td>This denotes that the conditions will be applied on http url of the api</td></tr><tr><td>request_payload</td><td>This denotes that the conditions will be applied on request payload of the api</td></tr><tr><td>response_payload</td><td>This denotes that the conditions will be applied on response payload of the api</td></tr><tr><td>request_headers</td><td>This denotes that the condition will be applied on request headers of the api</td></tr><tr><td>response_headers</td><td>This denotes that the condition will be applied on response headers of the api</td></tr><tr><td>query_param</td><td>This denotes that the condition will be applied on query params of the api</td></tr></tbody></table>

###

## Data Operators

Each Parent Operator should contain one or more `Data Operators` that describe the exact condition to be applied to the Parent Property. Data Operators can have the following values:

<table><thead><tr><th width="199">Data Operator</th><th width="183">Expected Arguments</th><th>Description</th></tr></thead><tbody><tr><td>contains_either</td><td>List/Non List</td><td>Checks whether the parent property contains the specified input. If input is an array, any one of the input element should satisfy this condition.</td></tr><tr><td>contains_all</td><td>List/Non List</td><td>Checks whether the parent property contains the specified input. If input is an array, all of the input element should satisfy this condition.</td></tr><tr><td>regex</td><td>List/Non List</td><td>Checks whether the parent property contains a match for the regex specified in the specified input. If input is an array, one of the regex input should have a match</td></tr><tr><td>eq</td><td>Non List</td><td>Checks whether the parent property is equal to the specified input.</td></tr><tr><td>neq</td><td>Non List</td><td>Checks whether the parent property is not equal equal to the specified input.</td></tr><tr><td>gt</td><td>Non List</td><td>Checks whether the parent property is greater than to the specified input.</td></tr><tr><td>gte</td><td>Non List</td><td>Checks whether the parent property is greater than equal to the specified input.</td></tr><tr><td>lt</td><td>Non List</td><td>Checks whether the parent property is lesser than the specified input.</td></tr><tr><td>lte</td><td>Non List</td><td>Checks whether the parent property is lesser than equal to to the specified input.</td></tr><tr><td>not_contains</td><td>List/Non List</td><td>Checks whether the parent property does not contain the specified input. If input is an array, all of the input element should satisfy this condition.</td></tr><tr><td>not_contains_either</td><td>List/Non List</td><td>Checks whether the parent property does not contain the specified input. If input is an array, any one of the input element should satisfy this condition.</td></tr><tr><td>contains_jwt</td><td>boolean</td><td>Checks whether the parent property contains/not contains a jwt token</td></tr></tbody></table>



### <mark style="color:red;">`contains_either`</mark>

Checks whether the parent property contains the specified input. If input is an array, `any one` of the input element should satisfy this condition.

**Example 1**

{% code title="Example of contains_either" fullWidth="true" %}
```yaml
url:
	contains_either: login
# Endpoints that contain login substring would match the above condition.
# Match Example - https://xyz.com/user/login
# Invalid Example - https://xyz.com/user/register
```
{% endcode %}

**Example 2**

{% code title="Example of contains_either" fullWidth="true" %}
```yaml
url:
	contains_either:
			- https
			- login
# Endpoints that contain either https or login substring would match the above condition.
# Match Examples - https://xyz.com/user/login | https://xyz.com/user/register
# Invalid Example - http://xyz.com/user/data
```
{% endcode %}



{% hint style="info" %}
👉🏻 **In simple language:** The above yaml syntax is filtering APIs with url containing the keywords ‘https’  or ‘login’
{% endhint %}



### <mark style="color:red;">`contains_all`</mark>

Checks whether the parent property contains the specified input. If input is an array, `all` of the input mlelement should satisfy this condition.

**Example 1**

{% code title="Example 1" fullWidth="true" %}
```yaml
url:
	contains_all: login
# Endpoints that contain login substring would match the above condition.
# Match Example - https://xyz.com/user/login 
# Invalid Example - https://xyz.com/user/register
```
{% endcode %}

**Example 2**

{% code title="Example for contains_all" fullWidth="true" %}
```yaml
url:
	contains_all:
			- https
			- login
# Endpoints that contain both https and login substring would match the above condition.
# Match Example - https://xyz.com/user/login 
# Invalid Example - http://xyz.com/user/login | https://xyz.com/user/register
```
{% endcode %}



{% hint style="info" %}
👉🏻 In simple language: The above yaml syntax is filtering APIs with url containing the keywords ‘https’ **and** ‘login’
{% endhint %}



### <mark style="color:red;">`regex`</mark>

Checks whether the parent property contains a match for the `regex` specified in the specified input. If input is an array, one of the regex input should have a match.

**Example 1**

{% code title="Example for regex" fullWidth="true" %}
```yaml
request_payload:
	contains_either: .*user*.
# If any part of request payload matches the above regex, it would be considered a match.
# Match Example - {”id”: 123, “data”:{”userName”: “abc”}} - userName is a valid match for above regex
# Invalid Example - {”id”: 123, “data”:{”name”: “abc”}} - no part of the request payload matches the above regex
```
{% endcode %}

####

### <mark style="color:red;">`eq`</mark>

Checks whether the parent property is equal to the specified input.

**Example 1**

{% code title="Example for eq" overflow="wrap" %}
```yaml
method:
	eq: POST
# All the Post Endpoints will match the above condition.
# Match Example - POST https://xyz.com/getById
# Invalid Example - GET https://xyz.com/getById
```
{% endcode %}



### <mark style="color:red;">`gt`</mark>

Checks whether the parent property is greater than the specified input.

**Example 1**

{% code title="Example for gt" %}
```yaml
response_code:
	gt: 204
# Endpoints with response greater than 204 will match the above condition.
# Match Example - Response codes like 205, 302
# Invalid Example - Response codes like 200, 201
```
{% endcode %}

### <mark style="color:red;">`gte`</mark>

Checks whether the parent property is greater than or equal to the specified input.

**Example 1**

{% code title="Example for gte" %}
```yaml
response_code:
	gte: 204
# Endpoints with response greater than or equal to 204 will match the above condition.
# Match Example - Response codes like 204, 302
# Invalid Example - Response codes like 200, 201
```
{% endcode %}



### <mark style="color:red;">`lt`</mark>

Checks whether the parent property is lesser than the specified input.

**Example 1**

{% code title="Example for lt" %}
```yaml
response_code:
	lt: 204
# Endpoints with response less than 204 will match the above condition.
# Match Example - Response codes like 200, 201
# Invalid Example - Response codes like 204, 205
```
{% endcode %}



### <mark style="color:red;">`lte`</mark>

Checks whether the parent property is lesser than or equal to the specified input.

**Example 1**

{% code title="" %}
```yaml
response_code:
	lte: 204
# Endpoints with response less than or equal to 204 will match the above condition.
# Match Example - Response codes like 200, 204
# Invalid Example - Response codes like 205, 302
```
{% endcode %}



### <mark style="color:red;">`not_contains`</mark>

Checks whether the parent property does not contain the specified input. If input is an array, all of the input element should satisfy this condition.

**Example 1**

{% code title="Example of not_contains" %}
```yaml
response_payload:
	not_contains: 
		- "normal_user"
		- "new"
# Response Payloads not containing strings ("normal_user", "new") will match the above condition.
```
{% endcode %}

Match Example for above

```
{"id": 100, "userdata": {"name": "xyz", "status": "admin", "identifier": "old"}}
```

Invalid Example for above

```
1. {"id": 100, "userdata": {"name": "xyz", "status": "normal_user", "identifier": "old"}}
```

```
2. {"id": 100, "userdata": {"name": "xyz", "status": "admin", "identifier": "new"}}
```

```
3. {"id": 100, "userdata": {"name": "xyz", "status": "normal_user", "identifier": "new"}}
```



### <mark style="color:red;">`not_contains_either`</mark>

Checks whether the parent property does not contain the specified input. If input is an array, any one of the input element should satisfy this condition.

**Example 1**

{% code title="Example of not_contains_either" %}
```yaml
response_payload:
	not_contains_either: 
		- "normal_user"
		- "new"
# Response Payloads which does not contain either ("normal_user") or ("new") will match the above condition.


# Match Example - 
1. {"id": 100, "userdata": {"name": "xyz", "status": "admin",
	    "identifier": "old"}}
2. {"id": 100, "userdata": {"name": "xyz", "status": "normal_user",
	    "identifier": "old"}}
3. {"id": 100, "userdata": {"name": "xyz", "status": "admin",
	    "identifier": "new"}}
# Invalid Example - 
1. {"id": 100, "userdata": {"name": "xyz", "status": "normal_user",
	    "identifier": "new"}}
```
{% endcode %}



### <mark style="color:red;">`contains_jwt`</mark>

Checks whether the parent property contains/not contains a JWT token.

**Example 1**

{% code title="Example of contains_jwt" %}
```yaml
request_headers:
	for_one:
		value:
			contains_jwt: true 

# Request Headers which contain jwt token will match the above condition.
# Match Example - 
	1. Headers - 
			Content-Type: application/json
			Authorization: <Bearer-Token>
# Invalid Example - 
	1. Headers -
			Content-Type: application/json
			Authorization: 23sdf234r3aaa
```
{% endcode %}

###

## **Collection Operators**

These operators are useful for queries that involve individual keys and values in payloads and headers, rather than applying the condition to the entire payload as a string. To achieve the desired result, they must be combined with a data operator.



### <mark style="color:red;">`for_one`</mark>

This collection operator is used to imply that either of `key` or `value` in the entire payload should satisfy the condition.

**Example 1**

R**equest Payload** `{”id”: 123, “data”:{”Username”: “abc”}}`

Let’s say we want to check if there is a key present in request payload which contains name. We can represent that in the following yaml syntax -

{% code title="Example of for_one" %}
```yaml
api_selection_filters:
	request_payload:
		for_one:
			key:
				contains_either: name

# ”for_one” here specified that the condition is applied on key. 
# Data operand 'contains_either' checks whether any key in the request payload contains string (”name”)
```
{% endcode %}

{% hint style="info" %}
👉🏻 In simple language: The above yaml syntax is filtering APIs with any key of the request payload containing the keyword ‘name’
{% endhint %}



**Example 2**

**Request Payload** `{”id”: 123, ”status”: “admin”, “createdAt”: 1688364964}`

Let’s say we want to check if there is a `key` present in request payload which is equal to `status`, and contains a `value` like (`admin`). We can represent that in the following yaml syntax -

{% code title="Example of for_one" %}
```yaml
api_selection_filters:
	request_payload:
		for_one:
			key:
				eq: status
			value:
				regex: .*admin.*
# ”for_one” here specified that the condition is applied on both key and value. 
# Data operand 'eq' checks whether any key in the request payload is exactly equalt to (”status”).
# Data operand 'regex' checks whether any value in the status key matches the provided regex.
```
{% endcode %}

{% hint style="info" %}
👉🏻 In simple language: The above yaml syntax is filtering APIs with any key of the request payload equal to ‘status’ and the same key having value which matches specified regex.
{% endhint %}

**Matching Payloads**

1. {”id”: 123, ”status”: “admin”, “createdAt”: 1688364964}
2. {”status”: “administrator”, “active”: true}
3. {”userInfo”: {”name”: “testUser”, “status”: “admin”}, “lastLoginTs”: 1688364964}

**Invalid Examples**

1. {”id”: 123, “createdAt”: 1688364964}
2. {”id”: 123, ”status”: “normal”, “createdAt”: 1688364964}
3. {”id”: 123, ”access”: “admin”, “status”: “active”} `Here key is named status, and a value matches regex .*admin*., but there is no single key value pair which satisfies both conditions.`



## **Body Operators**

These operators are useful for applying conditions specifically on request payload, response payload strings. To achieve the desired result, they must be combined with a data operator. Currently there are 2 types of body operators -



### <mark style="color:red;">`length`</mark>

Length operator is used for applying conditions on the request/response payload length. Let’s explore this more through the below example

{% code title="Examples of length" %}
```yaml
#Example 1
request_payload:
	length:
		gt: 0

# Here we want to apply a condition, where api's should have a non-empty request payload.
# We use length operator, and combine it with data operator(gt), where we specify length to be greater than 0
 
#Example 2
response_payload:
	length:
		gte: 10

# Here we want to apply a condition, where api's should have a non-empty response payload.
# We use length operator, and combine it with data operator(gt), where we specify length to be greater than equal to 10 
```
{% endcode %}



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

## Extract Operators

These operators can be used to save parent entity’s value into a variable at any point during the api\_selection\_filters phase, which can be used later on in the test template yaml. Let’s see it in action in the below example -

{% code title="Example of extract" %}
```yaml
#Example 1
url:
  contains_either: https
  extract: urlVar

# Here we have defined an extract operator, which will copy the complete url into a new variable named urlVar, in case the contains_either operand satisfies the condition

#Example 2
method:
  extract: methodVar

# Here we have defined an extract operator, which will copy the http method values into a new variable named methodVar
```
{% endcode %}

We can also extract an individual key/value inside the parent entities like (request\_payload, response\_payload, request\_headers, response\_headers, query\_params).

{% code title="Example 1:" %}
```
Request Payload** {”id”: 123, “data”:{”Username”: “abc”, "userStatus": "admin"}}
```
{% endcode %}

{% code title="Example of extract" %}
```yaml
#request_payload:
  for_one;
    key:
      contains_either: status
      extract: keyVar

# Here we have defined an extract operator, which will copy the key("userStatus") into a new variable named keyVar, since ("userStatus") satisfies the contains_either operand. In simple words - keyVar = userStatus
```
{% endcode %}

{% code title="Example 2" %}
```
Request Payload** {”id”: 123, “data”:{”Username”: “abc”, "userStatus": "admin"}}
```
{% endcode %}

{% code title="Example of extract" %}
```yaml
request_payload:
  for_one;
    key:
      contains_either: status
      extract: keyVar
    value:
      extract: valVar

# Here we have defined an extract operator, which will copy the key("userStatus") into a new variable named keyVar, since ("userStatus") satisfies the contains_either operand.
# We also defined a second extract operator inside value operand, which will copy the value associated with the matching key("userStatus") into the variable, i.e. ("admin").
# In other words - keyVar = userStatus, valVar = admin  
```
{% endcode %}

## **Combining conditions using Boolean Operators**

Security tests can be complex in nature. Often, a specific test requires multiple filter conditions to evaluate whether a given endpoint is eligible for the test.

**Default Behavior**

For a test to consider an endpoint valid, `all conditions` specified in the YAML template must be satisfied. By default, yaml considers `and` operator for all conditions. However, you can easily override this behavior using other boolean operators.

**Boolean Operators**

Boolean operators are of 2 types:

### <mark style="color:red;">**`and`**</mark>

The `and` operator requires all of the specified conditions to be satisfied, which is also the `default` behavior. It can be applied on top of any operator, including `data`, `collection`, and `parent` operands.

**Example 1**

{% code title="Example of and" %}
```yaml
#Test Description - 
# condition 1: Consider only post endpoints.
# condition 2: Status code must be between 200-205(including both)
# condition 3: Request Headers should contain a header named origin.
# All conditions are mandatory.

api_selection_filters:
  and:
    - method:
        eq: POST
    - response_code:
        and:
          - gte: 200
          - lte: 205
    - request_headers:
        for_one:
          key:
            eq: origin 
```
{% endcode %}

Since applying `and` operator is default behaviour, we don’t need to explicitly write `and` operator. See below

{% code title="Example of and" %}
```yaml
# removed 'AND' as it is default behavior

api_selection_filters:
  method:
    eq: POST
  response_code:
    gte: 200
    lte: 205
  request_headers:
    for_one:
      key:
        eq: origin
```
{% endcode %}

### <mark style="color:red;">**`or`**</mark>

The OR operator requires that at least one of the specified conditions is satisfied. It can be applied to any operator, including data, collection, and parent operands.

**Example 1**

{% code title="Example of or" %}
```yaml
# Test Description 
# condition 1: Status code must be equal to either 200 or 302
# condition 2: Request Headers should contain a header named origin.
# An endpoint should either satisfy either of the above two conditions

api_selection_filters:
  or:
    - response_code:
        or:
          - eq: 200
          - eq: 302
    - request_headers:
        for_one:
          key:
            eq: origin 
```
{% endcode %}

