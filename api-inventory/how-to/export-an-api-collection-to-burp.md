---
description: Explore about exporting an API collection to Burp.
---

# Export an API Collection to Burp

Akto allows you to take any of your API collections and download them to your Burp Suite setup. This means you can use Burp Suite to interact with and test the APIs however you want. It's a handy way to explore and experiment with APIs right from your local Burp software.

In the demonstration below, we connected Akto and Burp Suite by downloading a **`.jar`** file (Akto extension file) from the **Quick Start** page, adding the same to the Burp account, and enabling the extension in Burp using **`AKTO_IP`** and **`AKTO_TOKEN`.**&#x20;

A **`.jar`** file is used to install extensions in Burp Suite, which are additional functionalities or modules that enhance the capabilities of this security testing software. In this case, the .jar file from Akto helps to install the Akto extension right into your Burp Suite account.&#x20;

Go to **Quick Start > Burp Suite > Configure.** Click on the Download to download the executable "Jar file" to add the Akto extension to your Burp Suite account.&#x20;

Open Burp and add the downloaded jar file in the extension tab. Once the plugin is loaded, click on the **"Options"** tab inside the plugin. Copy the **`AKTO_IP`** and **`AKTO_TOKEN`** values from your Akto account and paste them into the options tab of your Burp Suite account. Enter the name of the collection that you want to export then click on **"Import from Akto".**

{% embed url="https://app.arcade.software/share/RyMBHnUJaFJ5f65pVyRp" %}
Export an API collection to Burp
{% endembed %}

In the demonstration above, we installed the Akto plugin in Burp Suite to export API collections from Akto. Then, we directly exported the **`"juice_shop_demo"`** collection into our Burp Suite account.
