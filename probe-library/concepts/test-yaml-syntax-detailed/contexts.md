---
description: You can use information from all of your Akto dashboard in your YAML test.
---

# Contexts

Simple API Security testing involves fuzzing API with standard wordlists. However, to make testing really powerful, you'd need real data from your application. Eg. instead of trying incremental user\_id=1, user\_id=2, user\_id=3, etc., you would want to try with user\_ids that actually exist in your system eg. user\_id=3489, user\_id=3259.

Contexts will help you query all your data from Akto dashboard - which you can then use in your YAML tests.

Akto supports 4 types of contexts -

1. [Roles](contexts.md#roles-access-context) (`roles_access_context`) - You can access tokens from [Test roles](../../../agentic-red-teaming/concepts/test-role.md) that you have configured in the dashboard
2. [API Inventory](contexts.md#api-inventory-context) (`endpoint_in_traffic_context`) - You can use this context to check if an endpoint already exists in API Inventory. This is useful while discovering shadow APIs. An endpoint is a shadow endpoint only if it exists and is NOT being used by the application.
3. [Parameters](contexts.md#parameters-context) (`param_context`) - You can use this context to query all parameters (JSON/form-data etc.). For example, you want to run a BOLA test that tries to access `cart` details by changing `cart_id` parameter in the request body. You can use `param_context` to query all keys that match `.*cart_id.*` and use this wordlist in your BOLA test.
4. [Private variable](contexts.md#private-variable-context) (`private_variable_context)` - You can use this context to find out if a particular value is being used by exactly 1 user or multiple users. A `cart_id` or a `transaction_id` is particular to a user, whereas `product_id` can be queried by multiple users

### Roles access context

Once you [create a Test role](../../../agentic-red-teaming/how-to/create-a-test-role.md) in Akto dashboard and [configure auth tokens](../../../agentic-red-teaming/how-to/create-a-test-role.md#adding-auth-token-for-role) for that role, you can use the auth tokens in your YAML test.

**Example** - You want to test each admin API if they can be accessed using a member token. To carry out this test, you can create a role called `MEMBER_TOLE` . You would also have to add auth token to the role (eg `Authorization: Bearer member.role.token`) . You can now use it in your YAML to replace the auth token header.

Sample YAML -

```yaml
api_selection_filters:
  url:
    contains: "/admin"
execute:
  type: single
  requests:
    - req:
      - modify_header:
          ${roles_access_context.MEMBER}: 1       
validate:
  response_code:
    gt: 200
    lt: 300          

```

This YAML runs only on endpoints that contain `/admin` (assuming these are admin APIs). It replaces the auth token in the original request by `MEMBER` auth token. If the response is 2xx, it is a vulnerability

### API Inventory context

You can use this context to find out if an endpoint exists in API Inventory.

**Example** - You want to fuzz and find out all shadow endpoints which are NOT a part of API Inventory already.

{% code overflow="wrap" %}
```yaml
wordlists:
  fuzzWords:
    user
    account
    customer
execute:
  requests:
    - req:
        modify_url: ${url}/${fuzzWords}
        
validate:
  response_code:
    gt: 200
    lt: 300
  endpoint_in_traffic_context: false   
  # raise Shadow-endpoint-found vuln only if the fuzzed endpoint is NOT in API Inventory
```
{% endcode %}

### Parameters context

You can query all if your API traffic to extract list of `user_id`. You can extract this info in a variable (eg `user_context`). Say your API traffic contains the following parameters (across payloads, query params etc.) -

* `user: 23`
* `user: 89`
* `user_id: 56723`
* `customer: 78193`

You can then use `user_context.key` and `user_context.value`

```yaml
api_selection_filter:
  param_context:
    param: user|customer    # find all user or customer values from API traffic.
    extract: user_context
execute:
  type: single
  requests:
    - req:
      - add_query_param:
          user_context.key: ${user_context.value} # add query param user=123 
```

This will fire 4 API calls - with the following query param one by one -

* `user=23`
* `user=89`
* `user_id=56723`
* `customer=78193`

### Private variable context

You can use this context to find out if a particular value is being used by exactly 1 user or multiple users. Consider an e-commerce application (eg juice-shop).

**Example of a public variable** - The product-details of sku\_id `9` is fetched using `/api/v1/product?sku_id=9` . It is accessible by all users. We can validate it from the traffic also. Multiple users will be accessing the same endpoint - `/api/v1/product?sku_id=9` successfully. Here `sku_id` is sort-of a public variable because all products can be accessed by all users.

**Example of a private variable** - Imagine a similar scenario, but for cart\_id this time. The cart details of cart\_id `98` are fetched using `/api/v1/cart?cart_id=98`. Unlike `product_id`, `cart_id` should NOT be accessible by more than 1 user.

Akto can differentiate between the usage behavior of cart\_id and product\_id. Akto will classify `cart_id` as **private** and `product_id` as **public**.

{% hint style="info" %}
Note that private vs public variable depends a lot on traffic. These work very well if you are using [automated traffic connectors](../../../test-editor/concepts/test-yaml-syntax-detailed/broken-reference/). If you connect your staging or prod server, Akto will receive traffic from multiple users across several sessions that really improves this private vs public classification. If you are using BurpSuite, Postman etc., it is very likely that they contain only 1 user's data. The result in that case aren't good.
{% endhint %}

Say, you want to test APIs that use private variables (eg /api/v1/cart/123, /api/v1/order/78 etc.) for BOLA vulnerability. Simply replace the auth header by an attacker token (note that running the same test on /api/v1/product/9 will give a false positive and should NOT be tested for BOLA)

```yaml
api_selection_filters:
  private_variable_context:
    gt: 0
execute:
  type: single
  requests:
    - req:
        modify_header:
          replace_auth_header: true

```

This will exclude /api/v1/product/9 and filter only cart and order APIs - /api/v1/cart/123, /api/v1/order/78.

By default, all variables are considered to be private. Only with more data (from multiple users across several sessions), Akto will start marking some variables as private.

You can also associate other operators such as `regex: ".*user.*"` - to filter only those vars that contain the string `user`.
