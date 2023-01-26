# Handeling shadow APIs 👤

Shadow APIs are APIs which are not properly documented and hence not part of the security testing process. Outdated documentation makes it difficult to find and/or fix vulnerabilities.

### Finding shadow APIs:

Akto auto detects shadow endpoints ( endpoints which are undocumented but used). To find shadow endpoints, do the following:

1. Update your API documentation by going to the `documented` tab.

![](<../../.gitbook/assets/Frame 53.png>)

&#x20; 2\. Click on upload and upload your open API spec file here.

![](<../../.gitbook/assets/Frame 55.png>)

3\. Click on paths. you will see all the endpoints you uploaded from swagger file.

![](<../../.gitbook/assets/Frame 56.png>)

4\. Go to the shadow tab and find all the endpoints which are undocumented but used.

![](<../../.gitbook/assets/Frame 57.png>)

### **Document shadow APIs properly:**

Once **** you have identified all the shadow APIs, [document](../api-documentation.md) them using open API spec file or postman documentation.

**Read more** [**here**](https://threatpost.com/apis-out-of-shadows-protect-your-business/169334/) **"why shadow API end points are dangerous"**

> #### Attack Scenario:
>
> A social network implemented a rate-limiting mechanism that blocks attackers from using brute-force to guess reset password tokens. This mechanism wasn’t implemented as part of the API code itself, but in a separate component between the client and the official API (`www.socialnetwork.com`). A researcher found a beta API host (`www.mbasic.beta.socialnetwork.com`) that runs the same API, including the reset password mechanism, but because of <mark style="color:purple;">lack of documentation</mark> the rate limiting mechanism was not implemented on this endpoint. The researcher was able to reset the password of any user by using a simple brute-force to guess the 6 digits token. 😱

