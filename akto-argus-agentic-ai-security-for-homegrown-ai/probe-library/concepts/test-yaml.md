# Test YAML

YAML probes are a powerful tool to identify security vulnerabilities in your AI agents, MCP endpoints, and LLM components. Using Akto YAML format, you can define probes with metadata, component filters, execution details, and validation checks. These probes can be customized to target agentic-specific vulnerabilities including prompt injections, tool abuse, and permission escalation. Akto Probe Library provides a user-friendly interface to create and edit these probes, making it easy to integrate them into your agentic security workflow.

### What is YAML Probe?

A YAML probe in Akto is a configuration file written in YAML (YAML Ain't Markup Language) that defines a set of instructions for testing agent components to find security vulnerabilities. It includes details about the probe, how to select which components to test, how to execute the probe, and how to validate the results. The probe is executed against agent components and MCP endpoints, and the results are used to identify any agentic security issues.

You can create and run probes to detect vulnerabilities in your autonomous systems. Probes are written in Akto's YAML format, which includes sections for metadata, selection filters, execution details, and validation checks.

## 6 Blocks of Probe Editor

### Block 1: ID

<table><thead><tr><th width="201.5">Name</th><th>Desciption</th></tr></thead><tbody><tr><td><code>id</code></td><td>The ID field serves as a unique, descriptive identifier for a particular test YAML file.</td></tr></tbody></table>

### Block 2: Info

<table><thead><tr><th width="176.5">Name</th><th>Desciption</th></tr></thead><tbody><tr><td><code>info</code></td><td><mark style="color:red;"><code>Name</code></mark>, <mark style="color:red;"><code>Description</code></mark>, <mark style="color:red;"><code>Details</code></mark>, <mark style="color:red;"><code>Impact</code></mark>, <mark style="color:red;"><code>Category</code></mark>, <mark style="color:red;"><code>SubCategory</code></mark>, <mark style="color:red;"><code>Severity</code></mark>, <mark style="color:red;"><code>Tags</code></mark>, <mark style="color:red;"><code>Reference</code></mark></td></tr></tbody></table>

### Block 3: API Selection Filters

<table><thead><tr><th width="228.5">Name</th><th>Desciption</th></tr></thead><tbody><tr><td>api_selection_filters</td><td>This section describes the conditions that act as selection criteria for choosing APIs that are eligible for a particular test. It also filters out APIs that are not eligible.</td></tr><tr><td>Parent Operators</td><td><mark style="color:red;"><code>response_code</code></mark>, <mark style="color:red;"><code>method</code></mark>, <mark style="color:red;"><code>url</code></mark>, <mark style="color:red;"><code>request_payload</code></mark>, <mark style="color:red;"><code>response_payload</code></mark>, <mark style="color:red;"><code>request_headers</code></mark>, <mark style="color:red;"><code>response_headers</code></mark>, <mark style="color:red;"><code>query_param</code></mark></td></tr><tr><td>Data Operators</td><td><mark style="color:red;"><code>regex</code></mark>, <mark style="color:red;"><code>eq</code></mark>, <mark style="color:red;"><code>neq</code></mark>, <mark style="color:red;"><code>gt</code></mark>, <mark style="color:red;"><code>gte</code></mark>, <mark style="color:red;"><code>lt</code></mark>, <mark style="color:red;"><code>lte</code></mark><br><br><mark style="color:red;"><code>not_contains</code></mark>, <mark style="color:red;"><code>not_contains_either</code></mark>, <mark style="color:red;"><code>contains_jwt</code></mark>, <mark style="color:red;"><code>contains_all</code></mark>, <mark style="color:red;"><code>contains_either</code></mark></td></tr><tr><td>Collection Operators</td><td><mark style="color:red;"><code>for_one</code></mark></td></tr><tr><td>Combining Conditions using Boolean Operators</td><td><mark style="color:red;"><code>or</code></mark>, <mark style="color:red;"><code>and</code></mark></td></tr></tbody></table>

### Block 4: Execute

<table><thead><tr><th width="228.5">Name</th><th>Desciption</th></tr></thead><tbody><tr><td>execute</td><td><p><mark style="color:red;"><code>add_body_param</code></mark>, <mark style="color:red;"><code>modify_body_param</code></mark>, <mark style="color:red;"><code>delete_body_param</code></mark>, <mark style="color:red;"><code>add_query_param</code></mark>, <mark style="color:red;"><code>modify_query_param</code></mark>, <mark style="color:red;"><code>delete_query_param</code></mark></p><p><mark style="color:red;"><code>modify_url</code></mark>,</p><p><mark style="color:red;"><code>modify_method</code></mark>,</p><p><mark style="color:red;"><code>replace_body</code></mark>,</p><p><mark style="color:red;"><code>add_header</code></mark>, <mark style="color:red;"><code>modify_header</code></mark>, <mark style="color:red;"><code>delete_header</code></mark>, <mark style="color:red;"><code>remove_auth_header</code></mark>,</p><p><mark style="color:red;"><code>follow_redirect</code></mark></p></td></tr><tr><td>Combining Conditions using Boolean Operators</td><td><mark style="color:red;"><code>or</code></mark>, <mark style="color:red;"><code>and</code></mark></td></tr></tbody></table>

### Block 5: Auth \[Optional block]

<table><thead><tr><th width="201.5">Name</th><th>Desciption</th></tr></thead><tbody><tr><td><code>auth</code></td><td>This section describes the conditions that serve as validation criteria for determining whether a particular endpoint is vulnerable to a given test.</td></tr></tbody></table>

### Block 6: Validate

<table><thead><tr><th width="266.5">Name</th><th>Description</th></tr></thead><tbody><tr><td>validate</td><td>This section describes the conditions that serve as validation criteria for determining whether a particular endpoint is vulnerable to a given test.</td></tr><tr><td>Parent Operators</td><td><mark style="color:red;"><code>response_code</code></mark>, <mark style="color:red;"><code>method</code></mark>, <mark style="color:red;"><code>url</code></mark>, <mark style="color:red;"><code>request_payload</code></mark>, <mark style="color:red;"><code>response_payload</code></mark>, <mark style="color:red;"><code>request_headers</code></mark>, <mark style="color:red;"><code>response_headers</code></mark>, <mark style="color:red;"><code>query_param</code></mark></td></tr><tr><td>Data Operators</td><td><mark style="color:red;"><code>regex</code></mark>, <mark style="color:red;"><code>eq</code></mark>, <mark style="color:red;"><code>neq</code></mark>, <mark style="color:red;"><code>gt</code></mark>, <mark style="color:red;"><code>gte</code></mark>, <mark style="color:red;"><code>lt</code></mark>, <mark style="color:red;"><code>lte</code></mark><br><br><mark style="color:red;"><code>not_contains</code></mark>, <mark style="color:red;"><code>not_contains_either</code></mark>, <mark style="color:red;"><code>contains_jwt</code></mark>, <mark style="color:red;"><code>contains_all</code></mark>, <mark style="color:red;"><code>contains_either</code></mark></td></tr><tr><td>Collection Operators</td><td><mark style="color:red;"><code>for_one</code></mark></td></tr><tr><td>Combining Conditions using Boolean Operators</td><td><mark style="color:red;"><code>or</code></mark>, <mark style="color:red;"><code>and</code></mark></td></tr></tbody></table>

## Learn with Example

### **Example API**

{% code title="Example API" lineNumbers="true" %}
```json
POST https://xyz.abc.com/api/v1/users?userId=500&creationFlow=true
Request Payload

{
  "userData": {
      "name": "user1"
      "status": "normalUser"
      "age": 20
  },
  "profileData": {
      "isActive": true,
      "createdAt": 1254345343
  }
}

Response Payload
{
  "id": 500,
  "created": true,
  "username": "user1", 
}

Request Headers

Content-Type: application/json
Authorization: <Bearer-Token>
Host: https://xyz.abc.com

Response Headers

access-control-allow-origin: "*"
date: "Wed, 05 Jul 2023 09:53:32 GMT"
content-length: "14871"
server: "uvicorn"
access-control-allow-credentials: "true"
content-type: "application/json"
```
{% endcode %}

Let’s have a comprehensive look at all the possible operators in 1 single yaml.

### Example Yaml with all possible operators

{% code title="YAML with all operators" lineNumbers="true" %}
```yaml
id: Vulnerable_Test
info:
  name: ""                           # specifies the name or title of the test
  description: ""                    # provides a detailed explanation of the test. describes objectives, methodologies, and scope of the test
  details: ""                        # allows inclusion of additional information and context about the test
  impact: ""                         # describes the potential risks or consequences associated with the identified vulnerabilities
  category:                          # classifies the test into a specific category or domain
    name: ""                          
    shortName: ""
    displayName: ""
  subCategory: ""                    # this key also specifies the name or title of the test. should always contain the same value as id key
  severity: ""                       # indicates the severity level assigned to the identified vulnerabilities
  tags: ""                           # provides descriptive labels or keywords associated with the test
  references: ""                     # contains a list of relevant resources, documentation, or external links related to the test
auth:
  authenticated: true               # makes sure that only authentiated api's get considered for a test.
api_selection_filters:  
  response_code:                    # Filters API calls that return a response code between 200 and 300 (inclusive).      
    gte: 200                        
    lte: 300 
  url:       
    contains_all:                   # Filters API calls that contain the word "user" in the URL.
      - user
    extract: urlVar                 # extracts the url value into a variable named urlVar
  method:    
    contains_either:                # Filters API calls that use either the POST, PATCH, or PUT HTTP methods
      - POST
      - PATCH
      - PUT
  request_payload:                  # Filters API calls whose request payload contains a key-value pair where the key matches the regex ".*age*." and the value is between 15 and 40 (inclusive)
    for_one:      
      key:
        regex: .*age*. 
        extract: ageVar             # extracts the matching key value into a variable named ageVar
      value:
        gt: 15  
        lt: 40  
  response_payload:                 # Filters API calls whose response payload does not contain the string "user2."
    not_contains: user2
  request_headers:                  # Filters API calls whose request header contains a whose value has a JWT token in it.
    for_one:
      key:
        contains_jwt: true          
  response_headers:                 # Filters API calls whose response header contains a key that exactly matches "server" and a value that matches the regex "nginx/1.8.0."
    for_one:
      key:
        eq: server
      value:
        regex: nginx/1.8.0
execute: 
  type: single
  requests:
    - req:
      - modify_url: https://xyz.abc.com/api/v2/users    # Changes the URL of the API call to "[https://xyz.abc.com/api/v2/users."](https://xyz.abc.com/api/v2/users.%22)
      - modify_method: PATCH        # Changes the HTTP method of the API call to PATCH.
      - add_body_param:             # Adds a key-value pair "k1: v1" to the request body.
          k1: v1
      - modify_body_param:          # Changes the value of the "status" key in the request body to "admin."
          status: admin
      - delete_body_param: age      # Deletes the "age" key-value pair from the request body.
      - add_header:                 # Adds a "h1: v2" key-value pair to the request header.
          h1: v2
      - modify_header:              # Changes the value of the "host" key in the request header to "[https://xyz.evil.com](https://xyz.evil.com/)."
          host: https://xyz.evil.com
      - delete_header: authorization # Deletes the "authorization" key-value pair from the request header.
      - add_query_param:            # Adds a "q1: v3" key-value pair to the query string.
          q1: v3
      - modify_query_param:         # Changes the value of the "userId" key in the query string to "501."
          userId: 501
      - delete_query_param: creationFlow # Deletes the "creationFlow" key-value pair from the query string.
      - replace_body: '{"user": "newUser", "status": "admin"}'
      - remove_auth_header: true   # Replaces the entire request body with the JSON object 
      - follow_redirect: true      # Follows any HTTP redirects returned by the API call.
validate:
  response_code:                   # Validates that the response code of the API call is 201.
    eq: 201
  response_payload:                # Validates that the response payload is not empty and contains atleast one key named "success". Also it checks whether test response payload and sample response payload content are not similar(difference should be higher than 50%)
    length:
      gt: 0
    percentage_match:
      lt: 50
    contains_either:
      for_one:
        key: success
```
{% endcode %}

### Explanation of the above yaml

#### Info

The Info section contains metadata about the test:

* <mark style="color:red;">`Name`</mark>: The name or title of the test.
* <mark style="color:red;">`Description`</mark>: A detailed explanation of the test, including objectives, methodologies, and scope.
* <mark style="color:red;">`Details`</mark>: Additional context about the test.
* <mark style="color:red;">`Impact`</mark>: The potential risks or consequences associated with the identified vulnerabilities.
* <mark style="color:red;">`Category`</mark>: The category or domain the test falls into.
* <mark style="color:red;">`SubCategory`</mark>: Further categorization of the test.
* <mark style="color:red;">`Severity`</mark>: The severity level assigned to the identified vulnerabilities.
* <mark style="color:red;">`Tags`</mark>: Descriptive labels or keywords associated with the test.
* <mark style="color:red;">`Reference:`</mark> A list of relevant resources, documentation, or external links related to the test.

#### API Selection Filters

This section contains a set of filters that can be used to select specific API calls based on various criteria. The filters include:

* <mark style="color:red;">`response_code`</mark>: Filters API calls that return a response code between 200 and 300 (inclusive).
* <mark style="color:red;">`url`</mark>: Filters API calls that contain the word "user" in the URL.
* <mark style="color:red;">`method`</mark>: Filters API calls that use either the POST, PATCH, or PUT HTTP methods.
* <mark style="color:red;">`request_payload`</mark>: Filters API calls whose request payload contains a key-value pair where the key matches the regex "._age_." and the value is between 15 and 40 (inclusive).
* <mark style="color:red;">`response_payload`</mark>: Filters API calls whose response payload does not contain the string "user2."
* <mark style="color:red;">`request_headers`</mark>: Filters API calls whose request header contains a key that matches "contains\_jwt."
* <mark style="color:red;">`response_headers`</mark>: Filters API calls whose response header contains a key that exactly matches "server" and a value that matches the regex "nginx/1.8.0."

#### Execute

This section contains a set of operations that can be performed on API calls that match the selection criteria specified above. The operations include:

* <mark style="color:red;">`modify_url`</mark>: Changes the URL of the API call to "`https://xyz.abc.com/api/v2/users.`"
* <mark style="color:red;">`modify_method`</mark>: Changes the HTTP method of the API call to PATCH.
* <mark style="color:red;">`add_body_param`</mark>: Adds a key-value pair "k1: v1" to the request body.
* <mark style="color:red;">`modify_body_param`</mark>: Changes the value of the "status" key in the request body to "admin."
* <mark style="color:red;">`delete_body_param`</mark>: Deletes the "age" key-value pair from the request body.
* <mark style="color:red;">`add_header`</mark>: Adds a "h1: v2" key-value pair to the request header.
* <mark style="color:red;">`modify_header`</mark>: Changes the value of the "host" key in the request header to "`https://xyz.evil.com.`"
* <mark style="color:red;">`delete_header`</mark>: Deletes the "authorization" key-value pair from the request header.
* <mark style="color:red;">`add_query_param`</mark>: Adds a "q1: v3" key-value pair to the query string.
* `modify_query_param`: Changes the value of the "userId" key in the query string to "501."
* <mark style="color:red;">`delete_query_param`</mark>: Deletes the "creationFlow" key-value pair from the query string.
* <mark style="color:red;">`replace_body`</mark>: Replaces the entire request body with the JSON object `{"user": "newUser", "status": "admin"}`.
* <mark style="color:red;">`remove_auth_header`</mark>: Removes the "authorization" header from the request.
* <mark style="color:red;">`follow_redirect`</mark>: Follows any HTTP redirects returned by the API call.

#### Validate

This section contains a set of validation criteria that can be used to validate the response of the API call after it has been modified by the operations specified in the "Execute" section. The validation criteria include:

* <mark style="color:red;">`response_code`</mark>: Validates that the response code of the API call is 201.
* <mark style="color:red;">`response_payload`</mark>: Validates that the response payload is not empty and contains either a key "success".
