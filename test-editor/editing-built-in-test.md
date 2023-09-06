# Editing built in test

## Editing built-in test

## Overview

This document guides users on how to edit built-in tests using the Akto dashboard. It provides instructions on selecting and editing pre-existing tests. You can select any test from the test-library and start editing. Here are the steps to follow:

## Step 1: Open the Test Editor Page

On the Akto dashboard, navigate to **`Test Editor`** section in the left navigation bar.

<figure><img src="../.gitbook/assets/Untitled (2).png" alt=""><figcaption><p>Select test editor from Left-nav</p></figcaption></figure>

## Step 2: Select test to edit

Click on any test from the list of tests in the test editor. For instance, let's click on `Broken User Authentication` and then on the test named `Broken Authentication by removing auth token`. This will display a YAML template with an ID of `REMOVE_TOKEN`.

<figure><img src="../.gitbook/assets/Untitled (3).png" alt=""><figcaption></figcaption></figure>

## Step 3: Make your edits

Click on the YAML file to make changes. For example, if you want a custom description for a test, simply delete the old description and replace it with a new one, such as `My Custom Description for Broken Authentication Test`.

```yaml
description: My Custom Description for Broken Authentication Test
```

<figure><img src="../.gitbook/assets/Untitled (4).png" alt=""><figcaption><p>Edit the YAML</p></figcaption></figure>

## Step 4: Save edited test

Click on the Save icon located at the top of the page to create your first custom template. Your new template will be visible in the **Custom** section.

<figure><img src="../.gitbook/assets/Untitled (5).png" alt=""><figcaption><p>The new test shows up in Custom section</p></figcaption></figure>



{% hint style="success" %}
👉🏻 Please note that these changes will not affect the default Akto template. It will only create a new edited template available only to you.
{% endhint %}

## Some Example use cases

Let's take a few more examples to see how the custom template feature can be useful and how to use it to create tests specific to your requirements.

1. Search for the test `Possible Dos by Pagination misconfiguration`, type this in the search bar in the top left corner. Click on `Possible Dos by Pagination misconfiguration`

<figure><img src="../.gitbook/assets/Untitled (6).png" alt=""><figcaption></figcaption></figure>

2. If we review the API selection filters of the above yaml, we will see the following:

{% code title="API selection filters" %}
```yaml
api_selection_filters:
  query_param:
    for_one:
      key:
        or:
          - regex: .*limit.*
          - regex: .*size.*
          - regex: .*page.*
        extract: limitKey
      value:
        extract: limitValue
  response_payload:
    length:
      extract: original_length
```
{% endcode %}

The above YAML code is part of the API selection filters in the Akto dashboard. It applies a condition on query parameter keys where it should satisfy at least one of the three regex conditions, namely `.*limit.*`, `.*size.*`, and `.*page.*`. If a query parameter key satisfies the above condition, it's extracted in the variable `limitKey`, and the value associated with the key is extracted in `limitValue`. Finally, the response payload length is extracted at the end in the variable `original_length`.

3. Suppose we only want to run this test on endpoints that have a response code of 2xx. We can easily make these changes and create our own custom test. Yaml Syntax for the new filter -

{% code title="yaml with response code filter" %}
```yaml
response_code:
	gte: 200
	lte: 205
```
{% endcode %}

4. Final filter would like like this

{% code title="Final filter" %}
```yaml
api_selection_filters:
  response_code:
		gte: 200
		lte: 205
  query_param:
    for_one:
      key:
        or:
          - regex: .*limit.*
          - regex: .*size.*
          - regex: .*page.*
        extract: limitKey
      value:
        extract: limitValue
  response_payload:
    length:
      extract: original_length
```
{% endcode %}

5. Let’s do these changes in the Akto test

<figure><img src="../.gitbook/assets/Untitled (7).png" alt=""><figcaption></figcaption></figure>

6. Let’s save the changes. This would now create your own custom template. Yay!

<figure><img src="../.gitbook/assets/Untitled (8).png" alt=""><figcaption></figcaption></figure>
