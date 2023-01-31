---
description: API3:2019 Excessive Data Exposure
---

# Sensitive data

Sensitive data is all types of PII data which if leaked can cause problems such as compliance violations, brand damage, loss of users and more. Akto helps you protect from any kind of sensitive data leakage.&#x20;

{% hint style="warning" %}
OWASP lists this as one of the top 10 API vulnerabilities [here](https://github.com/OWASP/API-Security/blob/master/2019/en/src/0xa3-excessive-data-exposure.md)
{% endhint %}

{% tabs %}
{% tab title="Auto-detect sensitive data leak ↻" %}
Akto auto detects the following sensitive data leaking from your APIs in request or response:

* Email 📧
* Phone Number ☎️
* Credit Card number 💳
* IP Address 🔢
* SSN 🆔
* URL 🌐
* PAN Card 💵
* JWT, Bearer token 🔑

\*We are adding more data types continuously.

![](<../.gitbook/assets/Frame 34.png>)
{% endtab %}

{% tab title="Add custom sensitive data type ✍🏽" %}
Akto allows you to mark your own custom parameter as sensitive. Here is an example of how to do it:

1. Go to API changes tab.

![](<../.gitbook/assets/Frame 35 (1).png>)

&#x20;&#x20;

2\. Click on New parameters tab.

![](<../.gitbook/assets/Screen Shot 2022-03-09 at 10.51.01 AM.png>)



&#x20; 3\. Click on mark sensitive icon.

![](<../.gitbook/assets/Frame 36.png>)

&#x20;&#x20;

4\. A pop up will appear. Search here for all the parameters you want to mark sensitive.   Select all and click on mark sensitive.

![](<../.gitbook/assets/Frame 37.png>)



That's it! You have now custom marked sensitive parameters based on your business use case.

![](<../.gitbook/assets/Frame 38.png>)
{% endtab %}
{% endtabs %}

#### You can also mark individual parameters as sensitive by hovering over any parameter and clicking on mark sensitive icon.&#x20;

![](<../.gitbook/assets/Frame 39.png>)

### **Review sensitive data leak**

Once Akto detects any sensitive data leak, you can start your review in the sensitive data tab. Let's review an example:&#x20;

1. Go to the sensitive data tab and click on a sensitive endpoint or parameter.

![](<../.gitbook/assets/Frame 41.png>)

&#x20;2\. It will take you to the endpoints details page.

![](<../.gitbook/assets/Frame 42.png>)

&#x20; 3\. Now review the endpoint and see if the sensitive data is being passed in request or response.

![](<../.gitbook/assets/Frame 43.png>)

&#x20; 5\. It's a problem is sensitive data is not necessary to be passed for the functionality of the endpoint. If that's the case, you can mark it as an issue for the developer to fix it.&#x20;

&#x20; 6\. You can also click on values tab and see the sample value of that sensitive parameter.&#x20;

![](<../.gitbook/assets/Frame 47.png>)

### Protect from sensitive data leak

Once you have reviewed all your sensitive data leakage, you can now work with your dev team to solve the issues:

1. Create a collection of all your sensitive data in [postman](../integrations/postman.md) or download csv to share with your dev team. Alternatively you can [invite](broken-reference) your dev team to Akto dashboard.&#x20;

![](<../.gitbook/assets/Frame 45 (1).png>)

![](<../.gitbook/assets/Frame 44.png>)

&#x20; 2\. The above step will allow your dev team to review the sensitive data leakage issues and fix them in code.

> **POSSIBLE ATTACK SCENARIO:**
>
> The mobile team uses the `/api/articles/{articleId}/comments/{commentId}` endpoint in the articles view to render comments metadata. Sniffing the mobile application traffic, an attacker finds out that other sensitive data related to comment’s author is also returned. The endpoint implementation uses a generic `toJSON()` method on the `User` model, which contains PII, to serialize the object.

