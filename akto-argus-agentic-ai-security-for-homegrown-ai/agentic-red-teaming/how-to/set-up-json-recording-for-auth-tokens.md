# Set Up JSON Recording for Auth Tokens

Akto allows you to use Chrome Recordings to extract and reuse authentication data like tokens or cookies during API testing. This guide walks you through recording creation, upload, extraction, and configuration.

<figure><img src="../../../.gitbook/assets/image (124).png" alt=""><figcaption></figcaption></figure>

***

### 1. How to Create Chrome Recording

To extract **auth tokens or cookies** from API calls:

1. Open Chrome DevTools (`Cmd + Option + I` on Mac or `Ctrl + Shift + I` on Windows/Linux).
2. Navigate to the **Recorder** tab (enable from Chrome Experiments if hidden).
3.  Click **"Start a New Recording"** and name the session.

    <figure><img src="../../../.gitbook/assets/image (125).png" alt=""><figcaption></figcaption></figure>
4. Perform your complete **login flow**, ensuring any request with `access_token`, session cookies, or `auth_token` is triggered.
5. Stop the recording.
6. Click the **download icon** and select **“Export as JSON”**.

<figure><img src="../../../.gitbook/assets/image (127).png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
⏱️ **Ensure all API calls, especially login/auth, complete within 40 seconds** to avoid timeout issues.
{% endhint %}

***

### 2. How to Upload Chrome Recording

1. Go to **Akto Dashboard > Testing > Test Roles**.
2. Paste a **Token Fetch Command** to extract the token or cookie (see below).
3. Click **Upload JSON Recording**.
4. Akto will extract and verify the token/cookie within a couple of minutes.

{% hint style="info" %}
⏱️ Akto requires the command and processing to complete within **40 seconds**.
{% endhint %}

***

### 3. Add Timeouts of 40 Seconds

Keep in mind:

* Chrome recording session (especially login flow) should complete in **under 40 seconds**.
* Token fetch command execution is limited to **40 seconds** in Akto.
* If extraction or upload takes longer, the process will fail.

***

### 4. Intercept and Locate Auth Tokens / Cookies

During recording, inspect the following sources in DevTools:

* **Auth Tokens**: Look in response bodies for keys like `access_token`, `auth_token`, `id_token`.
* **Cookies**: Look under response headers (`Set-Cookie`) or browser storage (`localStorage`, `sessionStorage`).

Knowing where your token is returned helps when writing the **Token Fetch Command**.

***

### 5. How to Write Command to Extract cookieMap or Auth Token

Paste the appropriate **JavaScript command** into the **Token Fetch Command** field in Akto.

**✅ To extract all cookies as a header:**

```js
Object.entries(cookieMap).map(([key, value]) => `${encodeURIComponent(key)}=${encodeURIComponent(value)}`).join('; ')
```

**✅ To extract an auth token from localStorage:**

```js
"Bearer " + JSON.parse(Object.values(window.localStorage).find(x => x.indexOf("access_token") > -1)).body.access_token
```

<figure><img src="../../../.gitbook/assets/image (126).png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
⏱️ Keep this execution under 40 seconds for successful validation.
{% endhint %}

***

### 6. How to Use the "Extract" Section

After the token is fetched, define how Akto should use it for authentication.

1. Scroll to the **Extract** section.
2. Choose the source:
   * `Header` — to send the token in a request header (e.g., `Authorization`)
   * `Body` — if the token must be sent in the request body
3. Specify:
   * **Key**: e.g., `Authorization`
   * **Value**: Reference the token using `${x1.response.body.token}` or your specific token path.

Example:

| Type   | Key           | Value                       |
| ------ | ------------- | --------------------------- |
| Header | Authorization | `${x1.response.body.token}` |

This lets Akto inject the token into future requests dynamically.

***

### Get Support for your Akto setup <a href="#get-support-for-your-akto-setup" id="get-support-for-your-akto-setup"></a>

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
