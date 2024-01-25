---
description: Import APIs into Akto from a HAR (HTTP Archive Format) file
---

# HAR File

You can capture API traffic and generate HAR files using built-in developer tools provided by Chrome or Firefox.

## Create HAR from Chrome

Launch your Chrome browser and navigate to the web page for which you want to capture the traffic. Open **DevTools > Network tab** and right click. Select **Save all as HAR with content** option.  For demonstration purposes, we will capture the traffic from https://juiceshop.akto.io

{% embed url="https://demo.arcade.software/BH0MqjSjw2zLqbfBaIw6?embed=" %}
HAR from Chrome
{% endembed %}

## Create HAR from Firefox

Launch your Firefox browser and navigate to the web page for which you want to capture the traffic. Open **Developer Tools > Network tab** and right click. Select **Save all as HAR** option. In the demonstration below, we have navigated to https://juiceshop.akto.io to capture the API traffic.&#x20;

{% embed url="https://demo.arcade.software/T5qA0H6ygcV4feMmVCax?embed=" %}
HAR from Firefox
{% endembed %}

## Upload HAR file to Akto

Open any API Collection to import APIs from the HAR file. You can also **Create new collection** to start from a blank API Collection. Click on **Upload traffic** button and select the HAR file.&#x20;

{% embed url="https://demo.arcade.software/wNY4kML6ooabUp9ppCcC?embed=" %}
Upload HAR file to Akto
{% endembed %}
