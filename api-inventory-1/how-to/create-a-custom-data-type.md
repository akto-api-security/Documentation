---
description: Explore about Creating a custom data type.
---

# Create a Custom Data Type

Akto comes with over 40 built-in data types by default. However, some businesses might have unique data types, such as a transaction ID prefixed with **"TXN\_ID"**. These are specific to your business. If you want Akto to recognize these data types, you can configure them in the application.

If you have a highly sensitive, non-standard data type, you can define the pattern in Akto. Afterward, Akto will inform you about which API is sharing this data.

In the demonstration below, let's create a custom data type named **TXN\_ID** specifically for handling sensitive information found only in API responses.\
\
Go to **API Discovery > Sensitive data**. Click on the **Create Custom Data Type** and enter the data type details and conditions.

{% embed url="https://demo.arcade.software/p9oqszsEUzWcnFV3ou6h?embed=" %}
Add custom data type
{% endembed %}

In the above demonstration, we have created a data type named **`TXN_ID`** for handling sensitive information found only in API responses.

## Add Data Type Condition

While creating custom data types within Akto, it's essential to add specific data type conditions to ensure the integrity and validity of the data stored in those types. The specific conditions you set are dependent on the needs of your application. There are two data type conditions that you can set when creating custom data types: **`Key condition`** and **`Value condition`**.

### Key Conditions

You can set key conditions and define your requirements to instruct Akto on how you would like to detect the key. For example, you should ensure that a key follows a certain regex pattern or is equal to the data type (**e.g.** **`TXN_ID`**).&#x20;

In the demonstration below, we have added a key condition that is equal to the specific key named  **“TXN\_ID”**, which means instructing Akto to find it within our API data.

{% embed url="https://demo.arcade.software/ha1KAVihKpRjDZJXRXh4?embed=" %}
Add Key Conditions
{% endembed %}

In the above demonstration, we set the key condition to **"Equals to"** and specified the key name as **"TXN\_ID"**. Now Akto will search for the condition where the key matches **"TXN\_ID"** within the API data.

### Value Conditions

You can set value conditions and define your requirements to instruct Akto on how you would like to detect the value. For example, you might want to ensure that a value follows a certain regex pattern or is equal to the data type (**e.g.** **`\btxn_id\b`**).

In the demonstration below, we selected the condition type **"Matches regex"** and specified the value name as **`\btxn_id\b`**, which represents the regex pattern for transaction ID.

{% embed url="https://demo.arcade.software/OJhWdKLlFJmQpiR0izld?embed=" %}
Add Value Conditions
{% endembed %}

In the above demonstration, we selected the condition type **"Matches regex"** and specified the value name as **`\btxn_id\b`**. The system will now search the data for values that match this regex pattern. Any values that contain the specified regex pattern will be identified by this condition.

## AktoGPT

AktoGPT is a powerful AI tool integrated into the Akto platform that greatly simplifies the task of creating custom data types by generating regex patterns. With AktoGPT, you can define complex patterns that are tailored to your specific application needs, thereby ensuring the accuracy and security of your data handling processes.

In the demonstration below, we have generated a regex pattern for a **`credit card number`** and added it to Akto.

Go to **API Discovery > Sensitive data**. Click on the **AktoGPT** and select the prompt to generate a Regix pattern.

{% embed url="https://demo.arcade.software/RekxtkzRue4w3v3Yl0J9?embed=" %}
Add Regix using AktoGPT
{% endembed %}

In the above demonstration, we successfully generated a regex pattern to detect **`credit card numbers`** and added it directly to Akto for monitoring and protection against unauthorized data exposure.
