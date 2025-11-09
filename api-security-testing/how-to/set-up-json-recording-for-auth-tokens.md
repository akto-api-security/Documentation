# Set Up JSON Recording for Auth Tokens

Akto allows you to use Chrome Recordings to extract and reuse authentication data like tokens or cookies during API testing. This guide walks you through recording creation, upload, extraction, and configuration.

<figure><img src="../../.gitbook/assets/image (124).png" alt=""><figcaption></figcaption></figure>

***

### 1. How to Create Chrome Recording

To extract **auth tokens or cookies** from API calls:

1. Open Chrome DevTools (`Cmd + Option + I` on Mac or `Ctrl + Shift + I` on Windows/Linux).
2. Navigate to the **Recorder** tab (enable from Chrome Experiments if hidden).
3.  Click **"Start a New Recording"** and name the session.

    <figure><img src="../../.gitbook/assets/image (125).png" alt=""><figcaption></figcaption></figure>
4. Perform your complete **login flow**, ensuring any request with `access_token`, session cookies, or `auth_token` is triggered.
5. Stop the recording.
6. Click the **download icon** and select **“Export as JSON”**.

<figure><img src="../../.gitbook/assets/image (127).png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
⏱️ **Ensure all API calls, especially login/auth, complete within 40 seconds** to avoid timeout issues.
{% endhint %}

***

### 2. Add Timeouts of 40 Seconds

1. Add timeout in each step in the JSON

```
"timeout": 40000,
```

<figure><img src="../../.gitbook/assets/image (50).png" alt="" width="375"><figcaption></figcaption></figure>



2. Each step in Chrome recording session (especially login flow) should complete in **under 40 seconds**.

***

### 3. Intercept and Locate Auth Tokens / Cookies

Observe where are auth tokens being used in your application.

* If your auth tokens are present in cookie, Akto will record it automatically
* If your auth tokens are part of headers (eg. `authorization` or `x-csrf-token`), then you should tell Akto how to record these tokens while login happening&#x20;

You can configure which API would have these tokens. eg. say, your token is present in `authorization` header in `/api/v1/user/details` , please enter the following in the first section of your json -&#x20;

```json
            "requests": [
                {
                    "urlRegex": ".*/api/v1/user/.*", // you can use regex too to match more than 1 API
                    "position": "header",
                    "name": "authorization",
                    "saveAs": "authTokenHeader" // we will use this variable name later
                }
            ],

```

<figure><img src="../../.gitbook/assets/image (59).png" alt="" width="375"><figcaption></figcaption></figure>

> The `authTokenHeader` value will be returned as `cookieMap` under `aktoOutput.authTokenHeader` object

***

### 4. How to Write Command to Extract cookieMap or Auth Token

Paste the appropriate **JavaScript command** into the **Token Fetch Command** field in Akto.

**✅ To extract all cookies as a header (including header-based auth token as described in step(3)):**

```js
Object.entries(cookieMap).map(([key, value]) => `${encodeURIComponent(key)}=${encodeURIComponent(value)}`).join('; ')
```

<figure><img src="../../.gitbook/assets/image (126).png" alt=""><figcaption></figcaption></figure>

**✅ To extract, say, `access_token` from localStorage:**

```js
"Bearer " + JSON.parse(Object.values(window.localStorage).find(x => x.indexOf("access_token") > -1)).body.access_token
```

***

### 5. How to Upload Chrome Recording

1. Go to **Akto Dashboard > Testing > Test Roles**.
2. Paste a **Token Fetch Command** to extract the token or cookie (step 4).
3. Click **Upload JSON Recording**. Select the recording file after editing (step3)
4. Akto will extract and verify the token/cookie within a couple of minutes.

***

After the token is fetched, define how Akto should use it for authentication.

1. Scroll to the **Extract** section.
2. Choose the source:
   * `Header` — to send the token in a request header (e.g., `Authorization`)
   * `Body` — if the token must be sent in the request body
3. If you want to extract cookie and use that as the auth token, do the following -&#x20;
   1. **Key**: `Cookie`
   2. **Value**:  `${x1.response.body.token}`&#x20;
4. If you want to extract token using step (3) from a different header, please set the following -&#x20;
   * **Key**:  `Authorization`
   * **Value:** If you are extracting tokens using step(3) above, use  `${x1.response.body.aktoOutput.authTokenHeader}` to extract the token

***

### Get Support for your Akto setup <a href="#get-support-for-your-akto-setup" id="get-support-for-your-akto-setup"></a>

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
