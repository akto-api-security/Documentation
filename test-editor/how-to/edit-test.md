---
description: Explore about how to edit the Akto test.
---

# Edit Test

If you want to make small changes in Akto Test Library, you can use Akto's test editor.

Customization of tests assists in improving security coverage, adaptability to change, and incorporation of business knowledge.

In the demonstration below, let’s edit an Akto test by selecting a pre-existing test named **“Broken Authentication by removing auth token”** under the test category **“Broken User Authentication (BUA).”**

Go to **Test Editor** to edit Akto's test. Choose **test collection > pre-existing test**. Customize the **YAML file** based on your requirements, then click on **Save** to save the custom test.

{% embed url="https://demo.arcade.software/t1enI0PX4dxzfi9NcJvB?embed=" %}

In the demonstration above, we have selected a pre-existing test named **“Broken Authentication by removing auth token”** under the test category **“Broken User Authentication (BUA)”** and customized the YAML file by changing **“api\_selection\_filters”** for **“response\_code”** between 500 and 700. It will create a new test in the list.

{% hint style="info" %}
#### Enhanced Multipart Form-Data Support in the Test Editor

You can now configure **multipart form-data requests with multiple file attachments** directly in the Test Editor. Multipart form-data continues to support combined text and file inputs, and the Test Editor now extends that support with **multiple file upload handling**. T

he Test Editor also allows **adding, modifying, and deleting multipart parameters**, including both text fields and file fields. This enhancement helps you model real-world API requests that accept multiple files and dynamic form parameters during security testing.
{% endhint %}

