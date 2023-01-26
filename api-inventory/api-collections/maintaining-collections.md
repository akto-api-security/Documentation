# Maintaining Collections

#### Auto-create collections based on service

Akto enables you to maintain your collections mapped to each service. It builds various collection of all your endpoints mapping the services you you have used to mirror your traffic. For example, if traffic of all your payment services goes to particular machine, Akto will group those endpoints in one collection by the name of that machine/ service. Below is an example of auto-generated collections through traffic mirroring.&#x20;

![](<../../.gitbook/assets/Frame 62.png>)

This allows you to better manage your endpoints.&#x20;

### Custom-create collections

&#x20;You can also create your own collection and upload traffic. Follow the steps below to do that:

1. Go to API inventory tab and click add collection button.

![](<../../.gitbook/assets/Frame 59.png>)

2\. Enter the name you want to give to the collection.

![](<../../.gitbook/assets/Frame 60.png>)

![](<../../.gitbook/assets/Screen Shot 2022-03-09 at 1.40 1.png>)

&#x20;**You can also delete any of the collection you created by clicking on delete collection.**

![](<../../.gitbook/assets/Frame 61.png>)

1. You can now add traffic to this collection using the following five methods:
   * [Using NGINX](../../add-api-data/integrations/nginx.md)
   * [Using Java Agent](../../add-api-data/integrations/akto-java-agent.md)
   * [Using Burp](broken-reference)
   * [Uploading HAR file of all your network traffic](../../add-api-data/har-file-upload.md)
   * [Uploading TCP dump](broken-reference)&#x20;
2. After you add traffic, you will be able to see all the endpoints present in the traffic data.

{% hint style="info" %}
Manually uploaded traffic will be analyzed and handled in the same way as mirrored traffic.
{% endhint %}
