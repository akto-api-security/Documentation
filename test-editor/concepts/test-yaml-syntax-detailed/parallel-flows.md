---
description: You can execute and compare responses from multiple API calls in parallel in YAML tests
---

# Parallel flows

This instruction is required when you want to fire multiple API calls in **parallel** and compare their responses. 
A simple use case for this would be to test for race conditions in an API by sending multiple requests in parallel.

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

* A global `validate` block to test for a certain response across all parallel requests. 
* A local  `validate` block for each individual request. 
* A local `validate` block and global `validate` block.

If multiple `validate` blocks are used, all the validate blocks will be evaluated using the `Logical AND` operation. 

Example 1 - Try adding body parameters to each request with a global validate block applying to all of them.

```yaml
execute:
  type: parallel
  requests:
  - req:
    - add_body_param:
        test1: one
  - req:
    - add_body_param:
        test2: two
  - req:
    - add_body_param:
        test3: three
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
        test1: one
    - validate:
        response_payload:
          regex: ".*\"test1\":\"one\".*" 
  - req:
    - add_body_param:
        test2: two
    - validate:
        response_payload:
          regex: ".*\"test2\":\"two\".*" 
  - req:
    - add_body_param:
        test3: three
    - validate:
        response_payload:
          regex: ".*\"test3\":\"three\".*"
validate:
  response_code:
    gte: 200
    lt: 300
```

**Note**: A maximum of 10 requests can be made in parallel. 



