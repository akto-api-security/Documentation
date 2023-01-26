---
description: API2:2019 Broken User Authentication
---

# Unauthenticated APIs   🔑

Unauthenticated APIs, specially the ones which are public facing are highly vulnerable to attacks. This is especially true for APIs that handle sensitive user or business information. This could be a big compliance issue for some companies.&#x20;

{% hint style="info" %}
**Business impact:** Attackers can gain control to other users’ accounts in the system, read their personal data, and perform sensitive actions on their behalf, like money transactions and sending personal messages.
{% endhint %}

### **Review all unauthenticated endpoints**

<mark style="color:purple;">**Akto will auto detect if an API can be accessed without an auth token and will mark it unauthenticated.**</mark> Here is an example of how you can review unauthenticated endpoints in Akto:

1. Go to the open APIs tab. This will show you list of all the endpoints which are unauthenticated. 🔐&#x20;

![](<../../.gitbook/assets/Frame 46.png>)

&#x20; 2\. If an endpoint is intentionally unauthenticated, ignore it.&#x20;

&#x20; 3\. Click on the endpoint that shouldn't be unauthenticated. You will be taken to the endpoint  .  details page.

![](<../../.gitbook/assets/Screen Shot 2022-03-09 at 12.15.19 PM.png>)

&#x20; 4\. Check its sample values in the values tab. Click on curl command.

![](<../../.gitbook/assets/Frame 47.png>)

5\. Test these these sample values in your terminal using curl command.

![](<../../.gitbook/assets/Screen Shot 2022-03-09 at 12.52.02 PM.png>)

{% hint style="warning" %}
OWASP lists this as one of the top 10 API vulnerabilities [here](https://github.com/OWASP/API-Security/blob/master/2019/en/src/0xa2-broken-user-authentication.md)
{% endhint %}

### Fix unauthenticated APIs

Once you have reviewed all your unauthenticated endpoints, you can now work with your dev team to solve the issues:

1. Create a collection of all your unauthenticated APIs in postman or download csv to share with your dev team. Alternatively you can [invite](../../akto-account/adding-new-users.md) your dev team to Akto dashboard. 🤝

![](<../../.gitbook/assets/Frame 48.png>)

&#x20;2\. The above step will allow your dev team to review all the authentication issues and fix them in code.
