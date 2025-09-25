---
description: You can execute and compare responses from multiple API calls in YAML tests
---

# Conditional flows

This instruction is required when you want to fire multiple API calls and compare their responses. A simple use case is testing for **Username enumeration vulnerability** using password-reset endpoint.

To configure Akto test YAML for multiple requests, set `type: true`

```yaml
execute: 
  type: multiple    # this means multiple requests are configured
  requests: 
   - req: 
     ...
   - req:
     ...  
```

### Instructions available -&#x20;

For each request, you can now use&#x20;

* `validate` block to test for a certain response
* `success` to specify which request to execute next if `validate` block returns true
* `failure` to specify which request to execute next if `validate` block returns false
* Anywhere, you can set `success` or `failure` as `vulnerable` (to mark a vulnerability) or `exit`
* Requests are named as `x1` `x2` etc. automatically. You can use this to jump to a node on `success` or `failure` . You can also use them in data operators (eg response payload of `x1` should have length > 80 characters)

If `success` or `failure` isn't specified, we jump to the next request. If it's the last request, then we jump to the `validate` block of the test.&#x20;



Example - Try a wrong password. If API returns 4xx, then try with wrong usernames

```yaml
execute:
  type: multiple
  requests:
  - req:
    - modify_body_param:
        password: IncorrectPassword1!   
    - validate:
        response_code:
          gte: 400
          lt: 410
    - success: x2 #move to next request 
    - failure: exit #exit if response is not 4xx
  - req: ....  
```

Next step -&#x20;

try with invalid usernames, and check if the response string is different. If they are different, then the application is vulnerable to username enumeration.&#x20;

{% code overflow="wrap" %}
```yaml
  - req:
    - modify_body_param:
        username: invalid_user@email.com
    - validate:    # check if response payload for incorrect user is same as incorrect password
      - response_payload:
          neq: "${x1.response.body}" #x1.response.body refers to the response body of 1st request
    - success: vulnerable #if response payloads differ, then mark it as a vuln.
```
{% endcode %}

Complete YAML -&#x20;

```yaml
wordLists:
  dummyUsernames:
    - dummy
    - "dummymail@dummy.com"
execute:
  type: multiple
  requests:
  - req:
    - modify_body_param:
        password: Default1!
    - validate:
        response_code:
          gte: 400
          lt: 410
    - success: x2
    - failure: exit
  - req:
    - modify_body_param:
        username: ${dummyUsernames}
    - validate:
      - response_payload:
          neq: ${x1.response.body}
    - success: vulnerable
```
