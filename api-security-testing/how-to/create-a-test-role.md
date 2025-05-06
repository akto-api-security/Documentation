---
description: >-
  Easily establish custom test roles to streamline API testing processes and
  enhance security protocols
---

# Create a Test Role

If you use role-based access control in your APIs and applications, you should check for privilege escalation issues. This often entails determining if a lower-privilege user has access to all higher-privilege APIs. If such an API exists, the development team should fix its privileges.

Akto lets you automate privilege escalation security tests. The information can also be used to create custom tests using Test YAML templates.

You should define as many roles as there are in your application. For example, if you're running a B2B SaaS program, you might have ADMIN, BILLING, MEMBER, and GUEST. Role creation is a one-time configuration.

In the demonstration below, let's create a Test Role and specify the role endpoint conditions.

Go to **Testing > Test Roles**. Click on the **Create New Test Role** button. Enter the details for the new test role, including the **name** and specific **role endpoint conditions**.

{% embed url="https://demo.arcade.software/GFJXOoqb6wZAcGCyjWn2?embed=" %}
Create a Test Role
{% endembed %}

In the above demonstration, we created a test role with the condition that it **“Belongs to”** the **"juice\_shop\_demo"** API collection. We chose to apply this role to the endpoints **`rest/basket/6`** and **`rest/languages`**. This setup allows us to simulate and verify the behavior of these endpoints under the defined role's permissions.\


### Adding Auth token for Role

You can [add a hard-coded token](create-a-test-role.md#hard-coded-auth-token) for quickly executing a test. However, for daily tests or setting up tests in CI/CD, we highly recommend that you use [Automated Auth setup](create-a-test-role.md#automated-auth-token-generation).
If you have a TLS based authentication, you can configure that using [TLS Authentication](create-a-test-role.md#tls-authentication)

#### Hard-coded Auth token

You can add a hard-coded auth token using the following steps -&#x20;

1.  Go to **Test Roles** and click on the `...` at the end of the row

    <figure><img src="../../.gitbook/assets/Screenshot 2024-03-18 at 12.00.52 PM.png" alt=""><figcaption></figcaption></figure>
2.  Click on `Add Auth` button

    <figure><img src="../../.gitbook/assets/Screenshot 2024-03-18 at 11.58.07 AM (1).png" alt=""><figcaption></figcaption></figure>
3.  Enter the auth header key and the auth header value (eg. `Authorization` and `Bearer some.auth.token`)

    <figure><img src="../../.gitbook/assets/Screenshot 2024-03-18 at 11.59.14 AM (1).png" alt=""><figcaption></figcaption></figure>
4.  Click on `Save` button and verify that the auth is created.

    <figure><img src="../../.gitbook/assets/Screenshot 2024-03-18 at 11.59.21 AM (1).png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
If you want to use the auth token only for a specific account, you can add `API Header condition`. For example, `X-Account-Id: 10000` would mean the the auth token will be used only if the API request has `X-Account-Id: 10000` in its headers.&#x20;
{% endhint %}

#### Automated Auth token generation

For one-time testing or a quick tryout, you might need to manually add an auth token, because the token expires quickly, within a day. This means you can only use it occasionally for testing. Instead, you can set Akto to automatically fetch a fresh auth token to ensure that tests are always up-to-date before each test run. This way, Akto uses a new token for every test, ensuring the tests are always valid.

To add an auth token automatically while performing API testing, you need to follow these steps:

1. **Configure API Call Details**&#x20;

Configuring API call details ensures that the server knows how to process the request and can generate and return a new auth token. This is key for keeping tests current and valid, as it allows the system to automatically get a fresh token before each test run. &#x20;

In the demonstration, we're setting up the details for an API call, including the URL, method, headers, and body, to ensure the request is correctly configured and can successfully obtain the token.

{% embed url="https://demo.arcade.software/1cD5Jrrb3jjPbxtPXwE6" %}

2. **Execute the API Call**

After configuring the details, execute the API call. If successful, the server will respond with an auth token.

In the demonstration below, we make an API call and receive an authentication token from the server.

{% embed url="https://demo.arcade.software/dki4Cx8ivOboJ6YjR2wu" %}

3. **Extract Token**

After testing the API call, you need to extract the auth token from the response. This typically involves identifying the header or body parameter where the token is located. For example, if the token is returned in a header named Authorization, you would extract it.

In the demonstration below, we extract the auth token from the response. This token can then be used for subsequent API calls that require authentication.

{% embed url="https://demo.arcade.software/uPcoJyAcE8UMmMcy8oeL" %}

Once you have extracted the token, Akto will automatically use it for subsequent API calls in your tests.

Akto will now execute this entire API sequence before running a test to fetch a fresh auth token. You can now execute all the daily tests and CI/CD tests without worrying about the expiry of the hard-coded token.

#### TLS Authentication

You can add TLS authentication configuration to any role using the following steps:

1. Create a [test role](create-a-test-role.md#create-a-test-role). Click on the test role and click on `Add auth`.

    <figure><img src="../../.gitbook/assets/add-auth.png" alt=""><figcaption></figcaption></figure>

2. Click on `TLS Authentication` to reveal the configuration inputs.

    <figure><img src="../../.gitbook/assets/tls-auth-1.png" alt=""><figcaption></figcaption></figure>

3. For `PEM` certificate type:
    1. Input the client certificate
    <figure><img src="../../.gitbook/assets/tls-auth-2.png" alt=""><figcaption></figcaption></figure>
    2. Input the client private key
    <figure><img src="../../.gitbook/assets/tls-auth-4.png" alt=""><figcaption></figcaption></figure>
    3. Input the certificate authority certificate (optional, leave the input blank if you do not have one) 
    <figure><img src="../../.gitbook/assets/tls-auth-3.png" alt=""><figcaption></figcaption></figure>

4. Click on `Save`
    <figure><img src="../../.gitbook/assets/tls-auth-5.png" alt=""><figcaption></figcaption></figure>

##### Notes:

1. Please enter the keys only in the format shown in the images. Do not enter any additional details.
2. If you have a `P12` type key you can convert it to a `PEM` key using the commands given below. Here `client.p12` is your original key, `client.crt` is the client certificate and `client.key` is the client private key. While running these commands, you may be asked for an `Import Password`. You can leave that blank.

```bash
openssl pkcs12 -in ./client.p12 -out client.crt -clcerts -nokeys
openssl pkcs12 -in ./client.p12 -out client.key -nocerts -nodes
```

> 📌 **Note**: You can now limit visibility of a Test Role using RBAC. Use the **"Scope Role"** dropdown while creating or editing a Test Role. For details, see [Restrict Access to a Test Role Using RBAC](https://docs.akto.io/api-security-testing/how-to/restrict-test-role-rbac).

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
