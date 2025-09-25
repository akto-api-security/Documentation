# Create a Custom Test

## Overview

You can write custom tests using Akto and automate running them in your CI/CD.

### Step 1: Select your vulnerable API

Let’s start writing our custom tests. We will look at a scenario to illustrate how easily we can transform it into an Akto Test Yaml Template. Let’s take an example scenario -

**Exploit Possible DOS attack by Pagination Misconfiguration**

Check if there is any param, which can be modified to get more data from the server. Here is an example API from a vulnerable app on which we will build our test

<figure><img src="../../.gitbook/assets/Untitled (9).png" alt=""><figcaption></figcaption></figure>

We notice that there is a **limit** query param being passed with value = `10`. We can try to exploit this parameter through our test.

### Step 2: **Approach Yaml Test Syntax**

We need to think of three sections before writing the test:

1. `Filter your APIs:` We can add a filter to only run the test on endpoints that contain the **limit** keyword in the query parameters. This can be accomplished using either the `contains_either` or `regex` keywords.
2. `Modify Request:` During test execution, if the "**limit**" keyword is found, we should increase its value. We aim for a 10x increase from the original value.
3. `Validate Response:` After sending the test request, we need to validate if the API is actually vulnerable. One way to do this is to check if the response payload is larger than the original payload length.

### Step 3: Write **API Selection Filters**

{% code title="Write API selection filters" %}
```yaml
api_selection_filters:
  query_param:
    for_one:
      key:
         regex: .*limit.*
	       extract: limitKey
      value:
        extract: limitValue
  response_payload:
    length:
      extract: original_length
```
{% endcode %}

1. We begin with the `queryparam` filter, which places a `condition on the key`. The collection operand "for\_one" specifies that only one key needs to match the condition inside it, which in this case is the regular expression (._limit._). Therefore, any key containing the word "limit" will be matched.
2. The `extract` operator retrieves the matched value from the previous condition and assigns it to a variable called "`limitKey`" (i.e. limitKey = the name of the matched key, in this case, "limit").
3. We then `extract` the `value` present inside the "limit" key, which in the above example is 10. This value is stored in the "limitValue" variable, which will be required in the executor section below.
4. Finally, we `extract` the `length` of the sample response payload and store it in a variable called "original\_length."

### Step 4: Write **Execute**

{% code title="Write execute block" %}
```yaml
execute:
  type: single
  requests:
    - req:
        - modify_query_param:
		        limitKey: ${limitValue}0
```
{% endcode %}

1. Here, we use the operator `modify_query_param` to update the value of the limit. We provide the key (limitKey) and the value (limitValue).
   1. `limitKey` resolves to the key name **"limit"**, which was extracted in the API selection filters above.
   2. `limitValue` resolves to **10**. We append an additional 0 to modify its value to **100**.
   3. The new test URL will now look something like this. `GET http://localhost:8000/api/articles?limit=100&offset=0`

### Step 5: Write **Validate**

{% code title="Write validate block" %}
```yaml
validate:
  response_code:
    and:
      gte: 200
      lt: 300
  response_payload:
    length:
      gt: ${original_length}
```
{% endcode %}

1. To avoid failed response codes, we added validation that checks if the response code is greater than or equal to 200 and less than 300. The `and` the operator ensures that both `gte` and `lt` operators are satisfied.
2. We also check if the length of the test response is greater than the length of the original sample response body. In the `Api Selection Filters` section above, we extracted the `original_length` variable.

You can set the `name` and `id` of the test as **My Test on DOS attack by Pagination.** You can now click on the **Save** button to save this test.&#x20;



All blocked combined -

{% code title="My Test.yaml" %}
```yaml
api_selection_filters:
  query_param:
    for_one:
      key:
         regex: .*limit.*
	       extract: limitKey
      value:
        extract: limitValue
  response_payload:
    length:
      extract: original_length

execute:
  type: single
  requests:
    - req:
        modify_query_param:
          limitKey: ${limitValue}0

validate:
  response_code:
    and:
      gte: 200
      lt: 300
  response_payload:
    length:
      gt: ${original_length}
```
{% endcode %}
