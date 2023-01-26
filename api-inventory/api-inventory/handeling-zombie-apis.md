---
description: API9:2019 Improper Assets Management
---

# Handeling Zombie APIs 🧟

Zombie APIs are APIs that organizations assume have been deprecated but actually aren't properly retired. Because they are assumed to be deprecated, they are forgotten and aren't checked for vulnerabilities by security teams. These become a great entry door for hackers!

{% hint style="warning" %}
Improper asset management is actually one of the top 10 API vulnerabilities in OWASP list [here](https://github.com/OWASP/API-Security/blob/master/2019/en/src/0xa9-improper-assets-management.md)
{% endhint %}

#### Finding Zombie APIs:

Akto helps you find zombie APIs (deprecated APIs) in two ways:

1. All the APIs which are documented, doesn't have any traffic in the last one month but accessible.
2. All the APIs which are not documented, doesn't have any traffic in the last one month but accessible.

You can find all the zombie APIs 🧟 by going to unused tab of every collection.

![](<../../.gitbook/assets/Frame 51.png>)

**Retire zombie APIs properly:**

1. Once **** you have identified all the zombie APIs, [document](../api-documentation.md) them using open API spec file,  postman documentation or downloading a csv.

![](<../../.gitbook/assets/Frame 52 (1).png>)

&#x20;2\. Work with your engineering team to create a retirement plan for these zombie APIs.

> #### Attack scenario:
>
> After redesigning their applications, a local search service left an old API version (`api.someservice.com/v1`) running, unprotected, and with access to the user database. While targeting one of the latest released applications, an attacker found the API address (`api.someservice.com/v2`). Replacing `v2` with `v1` in the URL gave the attacker access to the old, unprotected API, exposing the personal identifiable information (PII) of over 100 Million users. 😨
