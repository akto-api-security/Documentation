---
description: You can execute and compare responses from multiple API calls in parallel in YAML tests
---

# Parallel flows

This instruction is required when you want to fire multiple API calls in **parallel** and compare their responses. A simple use case is testing for **Username enumeration vulnerability** using a password-reset endpoint, where different requests can be sent at the same time and their responses compared.

To configure Akto test YAML for multiple parallel requests, set `type: parallel`. All the `requests` defined under this block are fired **at the same time**.

```yaml
execute: 
  type: parallel    # this means multiple requests are configured to run in parallel
  requests: 
   - req: 
     ...
   - req:
     ...  
```

### Instructions available -&#x20;

For each request in a parallel flow, you can now use&#x20;

* A global `validate` block to test for a certain response. 
* A local  `validate` block for all requests. 
* A local `validate` block and global `validate` block.

If multiple `validate` blocks are used all the validate blocks will be evaluated using `logical AND` policy. 

Example 1 - Try adding body parameters to each request with a global validate block applying to all of them.

```yaml
execute:
  type: parallel
  requests:
  - req:
    - add_body_param:
        test: one
  - req:
    - add_body_param:
        test: two
  - req:
    - add_body_param:
        test: three
validate:
  response_code:
    gte: 200
    lt: 300
```

Example 2 - Use local  `validate` blocks on each parallel request, and a global `validate` block for a common condition.

```yaml
execute:
  type: parallel
  requests:
  - req:
    - add_body_param:
        country: US
    - validate:
        response_payload:
          regex: ".*\"region\":\"north_america\".*"
  - req:
    - add_body_param:
        country: IN
    - validate:
        response_payload:
          regex: ".*\"region\":\"asia\".*"
  - req:
    - add_body_param:
        country: DE
    - validate:
        response_payload:
          regex: ".*\"region\":\"europe\".*"
validate:
  response_code:
    gte: 200
    lt: 300
```



