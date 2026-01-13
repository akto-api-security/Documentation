# Mark a Collection Out of Testing Scope

In Akto, you may not always want to test every API collection. For example, sandbox collections, third-party APIs, or deprecated services may not be relevant for active security testing.\
The **“Mark collections as out of testing scope”** option lets you exclude such collections from scans, ensuring tests only run on meaningful targets

<figure><img src="../../.gitbook/assets/image (3) (1) (1).png" alt=""><figcaption></figcaption></figure>

***

### Steps to Mark a Collection Out of Testing Scope

1. Go to **API Discovery → Collections** in the left navigation.
2. Select the collection(s) you want to exclude by checking the box next to their name.
3. Click the **Mark collections as out of testing scope** button at the bottom of the page.
4. The selected collections will now be excluded from future security tests.

***

### Notes

* Collections marked out of scope will still appear in your inventory, but they won’t be part of **API Security Testing**.
* You can always bring them back into scope by re-enabling testing.
* Use this feature to keep test results clean and focused on **critical APIs only**.

***

### Best Practice

* Regularly review collections and mark **staging, deprecated, or irrelevant collections** as out of scope.
* Keep only **production and business-critical APIs** in testing scope for the most accurate security posture.
