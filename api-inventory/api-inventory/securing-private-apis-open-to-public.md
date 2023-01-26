# Securing private APIs open to public ⚠️

<mark style="color:purple;">You can now view all your private endpoints and see if they are accidentally open to public.</mark>

{% hint style="warning" %}
OWASP lists <mark style="color:purple;">API security misconfigurations</mark> as one of the top 10 API vulnerabilities [here](https://github.com/OWASP/API-Security/blob/master/2019/en/src/0xa7-security-misconfiguration.md)
{% endhint %}

1. Go to your API inventory and click on a collection you want to review.

![](<../../.gitbook/assets/Frame 27 (1).png>)

&#x20; 2\. Filter all the endpoints which are detected as public by Akto.

![](<../../.gitbook/assets/Frame 49.png>)

&#x20;3\. Review if any of these endpoints should be private. It's a big problem if an endpoint which is supposed to be private is actually public.

![](<../../.gitbook/assets/Frame 50.png>)

&#x20;4\. If you find a misconfigured endpoint, work with your engineering team to fix it.
