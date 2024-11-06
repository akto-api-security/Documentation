---
description: Explore about setting sensitivity of a data type.
---

# Set Sensitivity of a Data Type

Akto not only allows you to create a custom data type but also offers you the option to set the sensitivity of the data type. This helps in specifying which data types should be treated with extra caution because they contain sensitive information.

For example, if you want to flag tokens as sensitive whenever they appear in API responses, you need to set the **`"TOKEN"`** data type to be sensitive in the API response. After specifying the **`"TOKEN`**" data type to be sensitive in the API response, whenever any token appears in an API response, Akto will automatically flag it as sensitive data.

In the demonstration below, let's set the **`"TOKEN"`** data type to be as sensitive only in API response.

Go to **API Discovery> Sensitive data**. Click on **"…"** of the Data Type and select **Edit** to set the sensitivity of the data type.

{% embed url="https://demo.arcade.software/a56KiVd6fD0GIthN15PG?embed=" %}
Set sensitivity of a data type
{% endembed %}

In the above demonstration, we have set the sensitivity of the **`“TOKEN”`** data type to be sensitive only in API response. Now Akto will flag all the tokens present in API responses as sensitive data across all your API collections.
