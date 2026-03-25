---
description: Create custom Scan roles for role-based red teaming.
---

# Create a Scan Role

If you use role-based access control in your agentic systems, you should scan for privilege escalation issues. This involves determining if a lower-privilege role has access to higher-privilege agent components or tools.

Akto lets you automates privilege escalation security scans for agentic systems. You should define as many roles as exist in your application. For example, if you're running a B2B SaaS with AI agents, you might have ADMIN, MEMBER, VIEWER, and GUEST roles. Role creation is a one-time configuration.

## Creating a Scan Role

1. Navigate to **AI Red Teaming > Scan Roles**
2. Click **Create New Scan Role**
3. Enter the role name
4. Specify role component conditions (which collections or components this role can access)
5. Click **Save**

## Adding Auth token for Role

There are multiple ways you can Auth token with in Akto:

* You can add a hard-coded token for quickly executing a scan.
* However, for daily scans or setting up scans in CI/CD, we highly recommend that you use Automated Auth setup.
* And, If you have a TLS based authentication, you can configure that using TLS Authentication

{% hint style="success" %}
You can configure **multiple authentication methods within a single Scan Role**.

And using **Advanced Settings**, you can control exactly which token should be applied to which agentic requests.
{% endhint %}

### 1. Hard-coded Auth token

You can add a hard-coded auth token using the following steps -

{% stepper %}
{% step %}
Click on a particular **Scan Roles.**
{% endstep %}

{% step %}
Click on `Add Auth` button.
{% endstep %}

{% step %}
Under the hard coded section, enter the auth header key and the auth header value (eg. `Authorization` and `Bearer some.auth.token`)

<div data-with-frame="true"><figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2FYi8lETd6lPFPtNLH87AZ%2Fimage.png?alt=media&#x26;token=6125fc87-961f-4ed0-9451-08658c47b99f" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Click on `Save` button and verify that the auth is created.
{% endstep %}
{% endstepper %}

{% hint style="info" %}
#### Note

If you want to use the auth token only for a specific account, you can add `Header condition`.

For example, `X-Account-Id: 10000` would mean the the auth token will be used only if the agentic request has `X-Account-Id: 10000` in its headers.
{% endhint %}

### 2. Use Tokens from Traffic

Akto allows you to automatically use authentication tokens observed in your agentic traffic. This is useful when valid tokens are already present in captured traffic and you want to reuse them for scanning without manually configuring or generating new ones.

To use tokens from traffic, follow these steps:

{% stepper %}
{% step %}
Go to **Scan Roles** and create or edit a Scan Role.
{% endstep %}

{% step %}
Click on **Add Auth**.
{% endstep %}

{% step %}
Select **From traffic**.
{% endstep %}

{% step %}
Under **Use tokens from traffic**, configure the following:

* **Location (Header / Query / Body)**\
  Select where the token is expected in the request. In most cases, this will be **Header**.
* **Key**\
  Enter the name of the parameter that contains the token.\
  Example: `Authorization`
* **Value (Optional)**\
  Specify a value pattern if you want to filter tokens.\
  Example: `Bearer .*`\
  This ensures only tokens matching the defined pattern are used.

<div data-with-frame="true"><figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2FPzxObOB17Jsr50zkoSm1%2Fimage.png?alt=media&#x26;token=0e01ceef-d838-4666-a21d-510974ead5fb" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
You can click the **+** icon to add multiple token extraction rules if required.
{% endstep %}

{% step %}
Click **Save** to apply the configuration.
{% endstep %}
{% endstepper %}

Once configured, Akto will automatically pick matching tokens from observed traffic and use them during scan execution.

### 3. Automated Auth token generation

For one-time scanning or a quick tryout, you might need to manually add an auth token, because the token expires quickly, within a day. This means you can only use it occasionally for scanning. Instead, you can set Akto to automatically fetch a fresh auth token to ensure that scans are always up-to-date before each scan run. This way, Akto uses a new token for every scan, ensuring the scans are always valid.

To add an auth token automatically while performing red teaming, you need to follow these steps:

{% stepper %}
{% step %}
**Configure the Call Details**

Configuring the call details ensures that the server knows how to process the request and can generate and return a new auth token. This is key for keeping scans current and valid, as it allows the system to automatically get a fresh token before each scan run.

In the demonstration, we're setting up the details for an agentic call, including the URL, method, headers, and body, to ensure the request is correctly configured and can successfully obtain the token.
{% endstep %}

{% step %}
**Execute the agentic Call**

After configuring the details, execute the agentic call. If successful, the server will respond with an auth token.

In the demonstration below, we make an agentic call and receive an authentication token from the server.
{% endstep %}

{% step %}
**Extract Token**

After scanning the agentic call, you need to extract the auth token from the response. This typically involves identifying the header or body parameter where the token is located. For example, if the token is returned in a header named Authorisation, you would extract it.

In the demonstration below, we extract the auth token from the response. This token can then be used for subsequent agentic calls that require authentication.

Once you have extracted the token, Akto will automatically use it for subsequent agentic calls in your scans.
{% endstep %}
{% endstepper %}

Akto will now execute this entire sequence before running a scan to fetch a fresh auth token. You can now execute all the daily scans and CI/CD scans without worrying about the expiry of the hard-coded token.

### 4. TLS Authentication

You can add TLS authentication configuration to any role using the following steps:

{% stepper %}
{% step %}
Create a scan role. Click on the scan role and click on `Add auth`.

<div data-with-frame="true"><figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2Fgit-blob-d10c648b8ce26c6db5e1b7bf5a7ccaf6866073ec%2Fadd-auth.png?alt=media" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Click on `TLS Authentication` to reveal the configuration inputs.

<div data-with-frame="true"><figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2Fgit-blob-8fbf7adaa1129ac38645f98d6fd1b0a7330b4dbf%2Ftls-auth-1.png?alt=media" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
For `PEM` certificate type:

1. Input the client certificate

<div data-with-frame="true"><figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2Fgit-blob-270a031ef41857c446d5911a259a167f0e10c2db%2Ftls-auth-2.png?alt=media" alt="" width="563"><figcaption></figcaption></figure></div>

2\. Input the client private key

<div data-with-frame="true"><figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2Fgit-blob-24ae82165ba67823ad1643b8b64dc9cac10b44f2%2Ftls-auth-4.png?alt=media" alt="" width="563"><figcaption></figcaption></figure></div>

3\. Input the certificate authority certificate (optional, leave the input blank if you do not have one)

<div data-with-frame="true"><figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2Fgit-blob-9225edbca16f9d3e2adc7253eb0ff25a24d67ecd%2Ftls-auth-3.png?alt=media" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Click on `Save`

<div data-with-frame="true"><figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2Fgit-blob-456ea1986729398153a1edd5ffccaf53a986561b%2Ftls-auth-5.png?alt=media" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}
{% endstepper %}

{% hint style="warning" %}
#### **Notes**

1. Please enter the keys only in the format shown in the images. Do not enter any additional details.
2. If you have a `P12` type key you can convert it to a `PEM` key using the commands given below. Here `client.p12` is your original key, `client.crt` is the client certificate and `client.key` is the client private key. While running these commands, you may be asked for an `Import Password`. You can leave that blank.

```bash
openssl pkcs12 -in ./client.p12 -out client.crt -clcerts -nokeys
openssl pkcs12 -in ./client.p12 -out client.key -nocerts -nodes
```
{% endhint %}

{% hint style="info" %}
You can now limit visibility of a Scan Role using RBAC. Use the **"Scope Role"** dropdown while creating or editing a Scan Role. For details, see [Restrict Access to a Scan Role Using RBAC](https://docs.akto.io/api-security-testing/how-to/restrict-test-role-rbac).
{% endhint %}

### 5. Digest Authentication

Digest Authentication allows red teaming to authenticate with agentic componentes that require HTTP digest-based authentication. Digest authentication uses a challenge-response mechanism where credentials are hashed before transmission, preventing passwords from being sent in plain text.

**How Digest Authentication Works**

1. The client sends an initial request to the server without credentials.
2. The server responds with **401 Unauthorised** and returns a challenge containing parameters such as **nonce** and **realm**.
3. The client computes a digest hash using the username, password, and challenge parameters.
4. The client sends the request again with the computed digest in the **Authorisation** header.
5. Red Teaming automatically performs the digest authentication flow for each scan request.

**Setup Guide**

{% stepper %}
{% step %}
Navigate to **AI Red Teamin → Scan Roles**.
{% endstep %}

{% step %}
Click **Add Authentication** and select **Digest Authentication**.

<div data-with-frame="true"><figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2FTEweAJ6QudwE66FskGAn%2Fimage.png?alt=media&#x26;token=7487df54-5a6b-4b43-8857-2f4be6116da2" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Enter the required configuration details:

<table><thead><tr><th width="159.35546875">Field</th><th>Description</th></tr></thead><tbody><tr><td><strong>Username</strong></td><td>Username represents the identity used during digest authentication.</td></tr><tr><td><strong>Password</strong></td><td>Password participates in the digest hash computation and is not transmitted in plain text.</td></tr><tr><td><strong>Target URL</strong></td><td>Target URL represents the endpoint that returns the digest authentication challenge.</td></tr><tr><td><strong>HTTP Method</strong></td><td>HTTP method defines the request method used for the initial challenge request. Default value is <strong>GET</strong>.</td></tr><tr><td><strong>Algorithm</strong></td><td>Algorithm defines the hashing algorithm used for digest computation. Supported algorithms include <strong>SHA-256</strong> and <strong>MD5</strong>.</td></tr></tbody></table>
{% endstep %}

{% step %}
Click **Save** to store the authentication configuration.
{% endstep %}
{% endstepper %}

## Advance Settings

### Header Conditions

Advanced Settings allow you to control **which authentication configuration is applied to which agentic request** when multiple auth methods are configured within the same Scan Role.

Since a Scan Role can have multiple auth setups (Hard-coded token, Automated token, TLS Authentication, Tokens from Traffic, etc.), Advanced Settings help Akto determine **which token should be used for a specific request**.

{% hint style="info" %}
#### Use case

* The same role is used across multiple accounts.
* You want to apply an auth token only for specific tenants.
* You need fine-grained control over which endpoints use a particular authentication setup.
{% endhint %}

**Configure Header Conditions**

Follow these steps to configure  Header Conditions:

{% stepper %}
{% step %}
While creating or editing a Scan Role, navigate to **Advanced Settings**.
{% endstep %}

{% step %}
*   Enter the following details:

    * **Header key**\
      Specify the request header name.\
      Example: `X-Account-Id`
    * **Header value**\
      Specify the expected value of the header.\
      Example: `10000`
    *   **URL path regex**\
        Provide a regular expression to match specific agentic paths.\
        This ensures the condition applies only to endpoints matching the defined pattern.

        Leave this empty to skip path matching.

    <figure><img src="https://2916937215-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FRc4KTKGprZI2sPWKoaLe%2Fuploads%2F2GyJspbBx4YIA5qdyJga%2Fimage.png?alt=media&#x26;token=b9a39bd6-5da5-4d7b-9c66-f62ff9dca274" alt="" width="563"><figcaption></figcaption></figure>
{% endstep %}

{% step %}
Click on **Save** to apply the configuration.
{% endstep %}
{% endstepper %}

{% hint style="warning" %}
#### Important Behaviour

* Advanced Settings act as conditional routing for auth configurations.
* An auth configuration without Advanced Settings behaves as a fallback/default.
* This enables fine-grained authentication control within a single Scan Role.
* You can combine different auth types (Hard-coded, Automated, TLS, From Traffic) and control exactly when each one should apply.
{% endhint %}

### Auth Selection Flow

A Scan Role can have multiple authentication methods configured simultaneously. Akto determines which token to use at runtime based on Advanced Settings.

**Execution Flow**

When the Scan Role runs on a collection:

1. For each agentic request, Akto evaluates all configured auth setups.
2. If a request matches the Advanced Settings of a specific auth configuration:
   * That auth configuration is applied.
3. If multiple auth configurations exist:
   * The one whose conditions match the request is used.
4. If no Advanced Settings match:
   * The auth configuration without any Advanced Settings acts as the default.

{% hint style="warning" %}
#### **Important**

If multiple auth configurations match the same request (for example, they have the same regex), Akto uses the **first configured or first discovered token** during evaluation.

The order of configuration in UI determines which token gets applied.
{% endhint %}

{% hint style="success" %}
#### Example Scenario

A Scan Role has two auth configurations:

1. **Hard-coded token**
   * Advanced Setting: URL path regex = `.*v1.*`
2. **Automated Auth token**
   * No Advanced Settings configured

**Based on the Example**

* For components whose path matches `.*v1.*`\
  → The **Hard-coded token** (with Advanced Settings) is used.
* For ones that do not match the regex\
  → The **Automated Auth token** (without Advanced Settings) is used by default.
{% endhint %}

