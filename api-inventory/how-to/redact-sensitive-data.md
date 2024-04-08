# Redact sensitive data

Redacting data in API security is critical to protect sensitive information from unauthorized access. It allows businesses to comply with data privacy regulations and prevent potential data breaches. By enabling granular redaction controls, you can specify exactly what data to hide, reducing the risk of exposing sensitive data to Akto dashboard users.

You can redact data at multiple levels - &#x20;

1. [Redact for a data type](redact-sensitive-data.md#redact-for-a-data-type)
2. [Redact for an API Collection](redact-sensitive-data.md#redact-for-api-collection)
3. [Redact for all APIs](redact-sensitive-data.md#redact-for-all-apis)

{% hint style="info" %}
Note that redacting data affects security testing. Because we aren't storing values, most likely the API can't be replayed and hence can't be tested.
{% endhint %}

### How it works?

Once redact is on, Akto processes API calls, but doesn't store the values. You can expect to see `{"name": "*****", password: "*****"}` for the APIs. If redact is on for an API collection, Akto won't show sample API calls as well.&#x20;

### Redact for a data type

Go to **API Inventory** > **Sensitive data**. Select the data type and click on `Edit`. Scroll down and set the **Redact this data type** to either `True` or `False`.

{% embed url="https://demo.arcade.software/SqSssV6nI66CIeDU4pyv" %}

### Redact for API collection

Open the API collection where you want to redact values. Click on **More options** at the top and select `Redact`. Click on **Enable** on the confirmation dialog box.&#x20;

{% embed url="https://demo.arcade.software/kJAfG2by8TjAV3vsUwee" %}

### Redact for all APIs

Go to **Settings** > **About** . Click on `redact data`. This will hide all values in all the API calls.&#x20;
