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

# Execute

After determining that an endpoint is eligible for a YAML Test, it is forwarded to the execution step. This section is used to describe actions/modifications to achieve the desired test request body.

## Syntax

Execute operators can be of the following types -

| Operator              | Description                                                                                                                                                    |
| --------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| add\_body\_param      | Add a new key/value pair in the request payload at the root                                                                                                    |
| modify\_body\_param   | Modify value of an existing key in the request payload at any position. If the key is missing, executor engine ignores the step and moves on to next operation |
| delete\_body\_param   | Delete an existing key in the request payload at any position. If the key is missing, executor engine ignores the step and moves on to next operation          |
| replace\_body         | Replace the entire request body with the supplied input                                                                                                        |
| add\_header           | Add a new key/value pair in the request headers                                                                                                                |
| modify\_header        | Modify value of an existing header key in the request headers. If the header key is missing, executor engine ignores the step and moves on to next operation   |
| delete\_header        | Delete an existing header key in the request headers. If the header key is missing, executor engine ignores the step and moves on to next operation            |
| add\_query\_param     | Add a new key/value pair in the query params                                                                                                                   |
| modify\_query\_param  | Modify value of an existing key in the query params. If the key is missing, executor engine ignores the step and moves on to next operation                    |
| delete\_query\_param  | Delete an existing key in the query params. If the key is missing, executor engine ignores the step and moves on to next operation                             |
| modify\_url           | Modify url to desired value. Supports entire url replacement, as well as replacing just a substring                                                            |
| modify\_method        | Modify http method to desired method value                                                                                                                     |
| remove\_auth\_header  | Remove Auth Headers in the request headers. If auth headers are missing, this operation throws an error and aborts the test for the endpoint                   |
| replace\_auth\_header | Replace the auth header by headers in `User config` section. If you are using JWT tokens, you can replace them too using JWT-specific instructions             |
| follow\_redirect      | Specify whether the test attempt should follow redirect or not. By default follow redirect is set to $true$                                                    |
| attach\_file          | Replaces the request body by the contents of the file                                                                                                          |
| jwt\_replace\_body    | Replace JWT body with given content                                                                                                                            |

### add\_body\_param

Used for `adding a new key/value pair` in the request payload at the root. This takes 2 params, key and value.

**Example 1**

`Original` request body of the endpoint you are trying to test:

{% code title="Original request body" %}
```json
{
  "user": "John Doe",
  "email": "johndoe@example.com"
}
```
{% endcode %}

Let’s say we want to add key (”status”) with value → “admin”

`Sample Yaml` to modify request body

{% code title="Sample yaml to modify request" %}
```yaml
execute:
	add_body_param:
		status: admin
```
{% endcode %}

`Modified` request body of the endpoint you are trying to test:

{% code title="Modified request body" %}
```json
{
  "user": "John Doe",
  "email": "johndoe@example.com",on
	"status": "admin"
}
```
{% endcode %}

### modify\_body\_param

Used for `modifying value of an existing key` in the request payload at any position. If the key is missing, executor engine ignores the step and moves on to next operation. This takes 2 params, `key` and `value`.

**Example 1**

`Original` request body of the endpoint you are trying to test:

{% code title="Original request body" %}
```yaml
{
  "user": "John Doe",
  "email": "johndoe@example.com"
}
```
{% endcode %}

Let’s say we want to modify key (”user”) with value → “admin”

`Sample Yaml` to modify request body

{% code title="Sample yaml to modify body" %}
```yaml
execute:
  type: single
  requests:
    - req: 	
			-	modify_body_param:
					user: admin
```
{% endcode %}

`Modified` request body of the endpoint you are trying to test:

{% code title="Modified request body" %}
```json
{
  "user": "admin",
  "email": "johndoe@example.com"
}
```
{% endcode %}

### delete\_body\_param

Used for `deleting an existing key` in the request payload at any position. If the key is missing, executor engine ignores the step and moves on to next operation. This takes single param, key.

**Example 1**

`Original` request body of the endpoint you are trying to test:

{% code title="original body request" %}
```yaml
{
  "user": "John Doe",
  "email": "johndoe@example.com"
	"isActive": false
}
```
{% endcode %}

Let’s say we want to remove key (”isActive”)

`Sample Yaml` to modify request body

{% code title="Sample yaml to modify body" %}
```yaml
execute:
  type: single
  requests:
    - req: 	
				- delete_body_param: isActive
```
{% endcode %}

`Modified` request body of the endpoint you are trying to test:

{% code title="Modified request body" %}
```json
{
  "user": "admin",
  "email": "johndoe@example.com"
}
```
{% endcode %}

### replace\_body

Used for `replacing the entire request body` with the supplied input. This takes 1 param, new payload.

`Original` request body of the endpoint you are trying to test:

{% code title="original req body" %}
```json
{
  "user": "John Doe",
  "email": "johndoe@example.com",
	"isActive": false
}
```
{% endcode %}

Let’s say we want to replace the above payload with below `new payload`

{% code title="new payload" %}
```json
{
		"id": 5,
		"admin": true
}
```
{% endcode %}

`Sample Yaml` to modify request body

{% code title="Modified request body" %}
```yaml
execute:
  type: single
  requests:
    - req: 	
			 - replace_body: '{"id": 5, "admin": true}'
```
{% endcode %}

### add\_header

Used for `adding a new key/value pair` in the request headers. This takes 2 params, key and value.

**Example 1**

`original` header of the endpoint you are trying to test:

{% code title="original API header" %}
```json
Content-Type: application/json
Authorization: <Bearer-Token>
```
{% endcode %}

Let’s say we want to add a new header (”Host”) with value → “xyz.evil.com”

`Sample Yaml` to modify request header

{% code title="Sample yaml to modify header" %}
```yaml
execute:
  type: single
  requests:
    - req: 
				- add_header:
						Host: xyz.evil.com
```
{% endcode %}

`Modified` request header of the endpoint you are trying to test:

{% code title="modified header" %}
```json
Content-Type: application/json
Authorization: <Bearer-Token>
Host: xyz.evil.com
```
{% endcode %}

### modify\_header

Used for modifying value of an existing header key in the request headers. If the header key is missing, executor engine ignores the step and moves on to next operation. This takes 2 params, key and value.

**Example**

`original` header of the endpoint you are trying to test:

```json
Content-Type: application/json
Authorization: <Bearer-Token>
```

Let’s say we want to modify key (”Authorization”) with a different user token value →

`Sample Yaml` to modify request header

```yaml
jsexecute:
  type: single
  requests:
    - req: 
				- modify_header:
						Authorization: <Bearer-Token2>
```

`Modified` request header of the endpoint you are trying to test:

```json
Content-Type: application/json
Authorization: <Bearer-Token2>
```

### delete\_header

Used for deleting an existing header key in the request headers. If the header key is missing, executor engine ignores the step and moves on to next operation. This takes a single param, key.

**Example 1**

`original` header of the endpoint you are trying to test:

```json
Content-Type: application/json
Authorization: <Bearer-Token>
```

Let’s say we want to modify key (”Authorization”) with a different user token value →

`Sample Yaml` to delete request header

```yaml
execute:
  type: single
  requests:
    - req: 	
				- delete_header: Authorization
```

`Modified` request header of the endpoint you are trying to test:

```yaml
Content-Type: application/json
```

### add\_query\_param

Used for adding a new key/value pair in the query params. This takes 2 params, key and value.

**Example 1**

`original` url of the endpoint you are trying to test:

```jsx
http://xyz.com?user=1
```

Let’s say we want to add a new query param (”admin”) with value → true

`Sample Yaml` to add query params

```yaml
execute:
  type: single
  requests:
    - req: 
			- add_query_param:
					admin: true
```

`New` query params in the url of the endpoint you are trying to test:

```jsx
http://xyz.com?user=1&admin=true
```

### modify\_query\_param

Used for `modifying value of an existing key in the query params`. If the key is missing, executor engine ignores the step and moves on to next operation. This takes 2 params, key and value.

**Example 1**

`original` url of the endpoint you are trying to test:

```jsx
http://xyz.com?user=1
```

Let’s say we want to modify query param (”user”) with value → 4

`Sample Yaml` to modify query params

```yaml
execute:
  type: single
  requests:
    - req: 
				- modify_query_param:
						user: 4
```

`modified` query params in the url of the endpoint you are trying to test:

```jsx
http://xyz.com?user=4
```

### delete\_query\_param

Used for `deleting an existing key in the query params`. If the key is missing, executor engine ignores the step and moves on to next operation. This takes single params, key.

**Example 1**

`original` url of the endpoint you are trying to test:

```jsx
http://xyz.com?user=1&active=true
```

Let’s say we want to delete query param (”active”)

`Sample Yaml` to modify query params

```yaml
execute:
  type: single
  requests:
    - req: 	
			- delete_query_param: active
```

`modified` query params in the url of the endpoint you are trying to test:

```jsx
http://xyz.com?user=1
```

### modify\_url

Used for modifying url to desired value. Supports `entire` url replacement, as well as replacing just a `substring`.

#### **Replace entire url**

`original` url of the endpoint you are trying to test:

```jsx
http://xyz.com/api/v1/user
```

Let’s say you want to replace this with the below url -

```jsx
http://xyz.evil.com/api/v2/users
```

`Sample Yaml` to modify url

```yaml
execute:
  type: single
  requests:
    - req: 
				- modify_url: http://xyz.evil.com/api/v2/users
```

#### **Replace based on regex**

`original` url of the endpoint you are trying to test:

```jsx
http://xyz.com/api/v2/user
```

Let’s say i just want to replace v2 with v1 in the above url -

`Sample Yaml` to modify url

```yaml
execute:
  type: single
  requests:
    - req: 
      - modify_url:
          regex_replace:
            regex: v[\d+]/
            replace_with: v1/
```

👉🏻 \*\*In simple language:\*\* The above yaml syntax is modifying request url by replacing specified regex string match with v1/

`modified` url of the endpoint you are trying to test:

```jsx
http://xyz.com/api/v1/user
```

#### Insert token in url

You can use `token_insert` to insert a token (Eg `123`) in the url.&#x20;

eg. if you want to convert /api/v1/user/orders to /api/v1/user/123/orders, you can do:

```
  - modify_url:
      token_insert:
        location: 4
        replace_with: 123
```

#### Replace token in url

You can use `token_replace` to insert a token (Eg `123`) in the url.&#x20;

eg. if you want to convert /api/v1/user/456/orders to /api/v1/user/123/orders, you can do:

```
  - modify_url:
      token_replace:
        location: 4
        replace_with: 123
```

### modify\_method

Used for modifying http method to desired method value. This takes a single param, new method value.

**Example 1**

`original` url of the endpoint you are trying to test:

```jsx
POST http://xyz.com/api/v1/user
```

Let’s say we want to modify method value to PUT

`Sample Yaml` to modify method

```yaml
execute:
  type: single
  requests:
    - req: 
      - modify_method: PUT
```

`modified` url of the endpoint you are trying to test:

```jsx
PUT http://xyz.com/api/v1/user
```

### remove\_auth\_header

Used for `Removing Auth Headers in the request headers`. If auth headers are missing, this operation throws an error and aborts the test for the endpoint. (Refer to Auth section for better understanding on how auth headers are picked by yaml execution engine.)

**Example 1**

`original` headers of the endpoint you are trying to test:

```json
Content-Type: application/json
Authorization: <Bearer-Token>
```

Let’s say we want to remove the auth header for the test request(in this case auth header is - “Authorization”). Prerequisite: the auth has to be configured in auth types in the dashboard for the below execute section to identify authorization key.

`Sample Yaml` to remove auth headers

```yaml
execute:
  type: single
  requests:
    - req: 	
				- remove_auth_header: true
```

`modified` headers of the endpoint you are trying to test:

```json
Content-Type: application/json
```

### replace\_auth\_header

Used in many tests where we need to replace the auth header and inject a malicous auth header instead. This flag removes **all** the auth headers (including custom auth types) before adding malicious auth headers.&#x20;

#### Example 1 - replace auth token by attacker's token

This assumes you have set attacker credentials in `User config` section.&#x20;

Sample YAML to replace headers by attacker's tokens

```yaml
execute:
  type: single
  requests:
    - req:
	- replace_auth_header : true
```

modified headers will now look like:

```
Authorization: Bearer attacker.token.here
```

#### Example 2 - modify JWT auth token&#x20;

Used in Broken Authentication tests to exploit JWT-related vulnerabilities. For example, invalidating signature, setting algo to `None` etc. Possible values are&#x20;

* `${auth_context.none_algo_token}` - modify JWT token and set algo=NONE
* `${auth_context.invalid_signature_token}` - modify JWT token and make signature invalid (by appending extra characters to signature)
* `${auth_context.jku_added_token}` - modify JWT token by adding a JKU parameter in headers
* `${auth_context.jwk_added_token}` - modify JWT token by adding JWK-related parameters in headers
* `${auth_context.kid_added_token}` - modify JWT token by adding kid parameter in headers

Sample YAML to use the above instructions -

```yaml
execute:
  type: single
  requests:
    - req:
	- replace_auth_header : ${auth_context.invalid_signature_token}
```

Modifies the headers by invalidating signature

```
Authorization: Bearer eyJewqafsd.eafsdzcx.some_invalid_signature_here
```

### f**ollow\_redirect**

Used for specifying whether the test attempt should `follow redirect or not`, in case the response received if of redirect type. By default follow redirect is set to true. This takes a single boolean argument(true/false)

`Sample Yaml` \*\*\*\*For Disabling Redirect

```yaml
execute:
  type: single
  requests:
    - req:
	- follow_redirect: false
```

### attach\_file

Used to replace the request body by the contents of the file. This is useful for APIs that take file an input. Users can test such APIs by passing files with malicious content.&#x20;

Sample Yaml for attach\_file

```yaml
execute:
  type: single
  requests:
    - req:
        - attach_file: https://some.url.here/file.pdf
```

### jwt\_replace\_body

Used to replace the jwt body. This just replaces the payload. It keeps headers and signature the same as original JWT token

Sample yaml

```
execute:
  type: single
  requests:
  - req:
    - jwt_replace_body: ey.new_body.new_signature

```

Modified token looks like -&#x20;

```
Authorization: ey.new_body.old_signature
```

## **Combining multiple conditions in Execute**

Let’s see a few examples on how we can combine multiple execution operations into a test -

**Example 1**

Scenario -

1. `add` body\_param (”status”) with value → “admin” in request payload
2. `modify` Request Method To Post
3. `delete` QueryParam with key (”userId”)

### **Sample Yaml -**

```yaml
execute:
	type: single
  requests:
    - req:
      - add_body_param:
      	  status: admin
      - modify_method: POST
      - delete_query_param: userId
```

**Example 2**

Scenario -

1. `delete` auth header from request
2. `add` Header (”origin”) with value → xyz.evil.com

**Sample Yaml -**

```yaml
auth:
  authenticated: true
execute:
  type: single
  requests:
    - req:
        - delete_auth_header: true
        - add_header:
            origin: xyz.evil.com 
        - delete_query_param: userId
```

