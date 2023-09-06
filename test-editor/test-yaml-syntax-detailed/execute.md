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

| Operator             | Description                                                                                                                                                    |
| -------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| add\_body\_param     | Add a new key/value pair in the request payload at the root                                                                                                    |
| modify\_body\_param  | Modify value of an existing key in the request payload at any position. If the key is missing, executor engine ignores the step and moves on to next operation |
| delete\_body\_param  | Delete an existing key in the request payload at any position. If the key is missing, executor engine ignores the step and moves on to next operation          |
| replace\_body        | Replace the entire request body with the supplied input                                                                                                        |
| add\_header          | Add a new key/value pair in the request headers                                                                                                                |
| modify\_header       | Modify value of an existing header key in the request headers. If the header key is missing, executor engine ignores the step and moves on to next operation   |
| delete\_header       | Delete an existing header key in the request headers. If the header key is missing, executor engine ignores the step and moves on to next operation            |
| add\_query\_param    | Add a new key/value pair in the query params                                                                                                                   |
| modify\_query\_param | Modify value of an existing key in the query params. If the key is missing, executor engine ignores the step and moves on to next operation                    |
| delete\_query\_param | Delete an existing key in the query params. If the key is missing, executor engine ignores the step and moves on to next operation                             |
| modify\_url          | Modify url to desired value. Supports entire url replacement, as well as replacing just a substring                                                            |
| modify\_method       | Modify http method to desired method value                                                                                                                     |
| remove\_auth\_header | Remove Auth Headers in the request headers. If auth headers are missing, this operation throws an error and aborts the test for the endpoint                   |
| follow\_redirect     | Specify whether the test attempt should follow redirect or not. By default follow redirect is set to $true$                                                    |

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

**Example 1 for replacing entire url**

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

**Example 2 for replacing part of the url**

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

#### **Combining multiple conditions in Execute**

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

