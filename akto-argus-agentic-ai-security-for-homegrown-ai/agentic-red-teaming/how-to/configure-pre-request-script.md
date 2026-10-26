---
description: Run custom JavaScript before or after the prompt request when your agent needs more than one call per probe.
---

# Configure Pre and Post Request Scripts

Some agents cannot be probed with a single request. They need a setup call first (for example, creating a conversation or session), or a follow-up call afterwards (for example, fetching the response). Pre and post request scripts let you run custom JavaScript around the request that carries the probe prompt, so Akto can complete the full sequence for every probe.

## When to use which script

Look at where your agent expects the prompt in its two-request flow:

| Your agent's flow                                                                                       | Use              | Why                                                                                          |
| ------------------------------------------------------------------------------------------------------- | ---------------- | -------------------------------------------------------------------------------------------- |
| Request 1 sets things up (creates a conversation or session). Request 2 carries the prompt.             | **Pre script**   | The script makes request 1 first, then puts the returned value (such as an id) into the prompt request. |
| Request 1 carries the prompt. Request 2 is needed afterwards (for example, to retrieve the response).   | **Post script**  | The script makes the follow-up call after the prompt request has been sent, then returns the final response to Akto. |

{% hint style="info" %}
If your agent accepts the prompt in one standalone request, you do not need either script. The scripts are only for multi-request flows or for adjusting requests dynamically.
{% endhint %}

## Add a script

{% stepper %}
{% step %}
Go to **User Config**.
{% endstep %}

{% step %}
Enter your JavaScript in the **pre-request** or **post-request** script text area (for example, "Enter pre-request javascript here..."). Each script type has its own section below with the variables it can use and an example.
{% endstep %}

{% step %}
Click **Save** to apply your changes.

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt="" width="563"><figcaption></figcaption></figure>
{% endstep %}
{% endstepper %}

{% hint style="warning" %}
The script runs for every probe request, so limit it to the requests it is meant for. Check `url` at the start of the script and skip the rest if it does not match, as the example below does.
{% endhint %}

## Pre-request script

The pre-request script runs **before** the probe request is sent. Use it to make a setup call and put the result into the probe request, or to change the request itself. Assign a new value to a variable to change what Akto sends. For example, assigning a new value to `payload` changes the request body.

### Pre-request script variables

| Variable      | Description                                       |
| ------------- | ------------------------------------------------- |
| `method`      | The HTTP method of the request (e.g., GET, POST). |
| `headers`     | The headers of the request.                       |
| `url`         | The URL of the request.                           |
| `payload`     | The body of the request.                          |
| `queryParams` | The query parameters of the request.              |

### Example: create a conversation, then send the prompt

This pre script is for an agent that works in two requests:

1. `POST https://agent.example.com/api/conversations` creates a conversation and returns `{ "data": { "id": "..." }, "status": "success" }`.
2. `POST https://agent.example.com/api/chat` sends the prompt, and the body must contain that conversation `id`.

The script runs only for the chat request. It calls the create endpoint, reads the id from the response, and writes it into the probe request body.

```mermaid
sequenceDiagram
    autonumber
    participant Akto as Akto scan
    participant Pre as Pre script
    participant Agent as Your agent

    Akto->>Pre: Probe is ready to send
    Pre->>Agent: Request 1: create conversation
    Agent-->>Pre: Conversation id
    Note over Pre: Put the id into the prompt request body
    Pre-->>Akto: Updated request
    Akto->>Agent: Request 2: send probe prompt with id
    Agent-->>Akto: Agent response
```

<details>

<summary>Pre script example</summary>

```javascript
// PRE_REQUEST: create a conversation, then put its id into the request body
// Applies only to: https://agent.example.com/api/chat

var method;
var headers;
var url;
var payload;
var queryParams;
var parsedPayloadTemp;
var cachedUrl;

var executeOncePerConversation = false;

// ---------------- config ----------------
var TARGET_URL_REGEX = /\/api\/chat\/?(?:[?#]|$)/i;

var CREATE_CONVERSATION_URL = "https://agent.example.com/api/conversations";
var CREATE_CONVERSATION_BODY = {
    "user_id": "akto-scan-user"
};
var HTTP_TIMEOUT_MS = 15000;
// -----------------------------------------

function isTargetUrl(requestUrl) {
    return requestUrl != null && TARGET_URL_REGEX.test(String(requestUrl));
}

function isBlank(value) {
    return value == null || String(value).trim().length === 0;
}

function readStream(stream) {
    var text = "";
    if (stream != null) {
        var BufferedReader = Java.type("java.io.BufferedReader");
        var InputStreamReader = Java.type("java.io.InputStreamReader");
        var reader = new BufferedReader(new InputStreamReader(stream, "UTF-8"));
        var line;
        while ((line = reader.readLine()) !== null) {
            text += line + "\n";
        }
        reader.close();
    }
    return text;
}

function postApiCall(targetUrl, jsonData) {
    var URL = Java.type("java.net.URL");
    var BufferedWriter = Java.type("java.io.BufferedWriter");
    var OutputStreamWriter = Java.type("java.io.OutputStreamWriter");

    var connection = new URL(targetUrl).openConnection();
    connection.setRequestMethod("POST");
    connection.setConnectTimeout(HTTP_TIMEOUT_MS);
    connection.setReadTimeout(HTTP_TIMEOUT_MS);
    connection.setRequestProperty("Content-Type", "application/json");
    connection.setRequestProperty("Accept", "application/json");
    // Add any auth header your create endpoint needs, for example:
    // connection.setRequestProperty("Authorization", "Bearer <token>");
    connection.setDoOutput(true);

    var outputStream = connection.getOutputStream();
    var writer = new BufferedWriter(new OutputStreamWriter(outputStream, "UTF-8"));
    writer.write(JSON.stringify(jsonData));
    writer.flush();
    writer.close();
    outputStream.close();

    var code = connection.getResponseCode();
    var stream = code >= 400 ? connection.getErrorStream() : connection.getInputStream();
    return { code: Number(code), text: readStream(stream) };
}

function createConversationId() {
    var res = postApiCall(CREATE_CONVERSATION_URL, CREATE_CONVERSATION_BODY);
    if (res.code >= 400) {
        print("pre-script: create conversation failed: http", res.code, res.text.substring(0, 200));
        return null;
    }
    var parsed = JSON.parse(res.text.trim());
    var id = (parsed != null && parsed.data != null) ? parsed.data.id : null;
    return isBlank(id) ? null : String(id);
}

function replaceIdInPayload(newId) {
    var obj = typeof payload === "string" ? JSON.parse(payload) : JSON.parse(JSON.stringify(payload));
    obj.id = newId;
    payload = JSON.stringify(obj);
}

try {
    if (!isTargetUrl(url)) {
        print("pre-script: url does not match TARGET_URL_REGEX, skipping:", url);
    } else if (isBlank(payload)) {
        print("pre-script: empty payload, nothing to replace");
    } else {
        var conversationId = createConversationId();
        if (conversationId != null) {
            replaceIdInPayload(conversationId);
            print("pre-script: payload.id replaced with", conversationId);
        }
    }
} catch (e) {
    print("pre-script error:", e);
}
```

</details>

#### Adapt the example to your agent

Change only the values in the `config` block:

| Setting                    | What to change                                                                                           |
| -------------------------- | -------------------------------------------------------------------------------------------------------- |
| `TARGET_URL_REGEX`         | A pattern that matches only the request that carries the probe prompt.                                   |
| `CREATE_CONVERSATION_URL`  | The endpoint that creates the conversation or session.                                                   |
| `CREATE_CONVERSATION_BODY` | The body that endpoint expects.                                                                          |
| `HTTP_TIMEOUT_MS`          | How long to wait for the create call, in milliseconds.                                                   |

If the id has a different name or location, update `createConversationId` (where the id is read from the response) and `replaceIdInPayload` (where it is written into the probe request).

{% hint style="success" %}
Use `print(...)` to log what the script is doing, as the example does. If a probe fails, these messages show whether the script skipped the request, the create call failed, or the id was replaced.
{% endhint %}


## Post-request script

The post-request script runs **after** the probe request has been sent and the response is received. Use it when the response to the probe is not the final answer, for example when the agent returns a job id and you need a follow-up call to retrieve the real response. Assign a new value to `body` to change the response Akto evaluates.

### Post-request script variables

| Variable    | Description                                                                                           |
| ----------- | ----------------------------------------------------------------------------------------------------- |
| `statusCode` | The HTTP status code of the prompt request's response.                                               |
| `body`      | The response body of the prompt request. Assign a new value to replace the response Akto evaluates.   |
| `headers`   | The headers available to the script. The example copies them onto the polling request (for example, a session cookie or auth header). |
| `url`       | The URL of the prompt request.                                                                        |
| `payload`   | The body of the prompt request.                                                                       |

### Example: poll for the final response

Some agents answer a prompt asynchronously. The prompt request only returns a job id, and the real answer is available from a second endpoint once the job finishes. Without a post script, Akto would evaluate the "job accepted" message instead of the agent's answer.

This post script is for an agent that works in two requests:

1. `POST https://agent.example.com/api/ask` sends the prompt and returns `{ "job_id": "...", "status": "queued" }`.
2. `GET https://agent.example.com/api/ask/{job_id}` returns the job status, and once finished, `{ "status": "succeeded", "response": { "text": "..." } }`.

The script runs only for the prompt request. It reads the job id from the response, polls the second endpoint until the job finishes, and replaces the response `body` with the agent's final text.

```mermaid
sequenceDiagram
    autonumber
    participant Akto as Akto scan
    participant Agent as Your agent
    participant Post as Post script

    Akto->>Agent: Request 1: send probe prompt
    Agent-->>Akto: job_id, status queued
    Akto->>Post: Run post script with the response
    loop Until job finishes or timeout
        Post->>Agent: Request 2: GET job status
        Agent-->>Post: status
    end
    Note over Post: Replace body with the final text
    Post-->>Akto: Final agent response
```

<details>

<summary>Post script example</summary>

```javascript
// POST_REQUEST: poll for the final response, then replace the body with it
// Applies only to: https://agent.example.com/api/ask

var statusCode;
var headers;
var body;
var url;
var payload;

// ---------------- config ----------------
var SUBMIT_URL_REGEX = /\/api\/ask\/?(?:[?#]|$)/i;
var POLL_URL_PREFIX = "https://agent.example.com/api/ask/";
var TERMINAL_STATUSES = ["succeeded", "failed", "cancelled", "error"];

var POLL_INTERVAL_MS = 500;
var MAX_WAIT_MS = 60000;
var CONNECT_TIMEOUT_MS = 10000;
var READ_TIMEOUT_MS = 15000;

// headers never copied onto the polling request
var SKIP_HEADERS = ["host", "content-length", "content-type", "connection",
    "transfer-encoding", "accept-encoding", "expect", "upgrade", "via"];
// -----------------------------------------

function isBlank(value) {
    return value == null || String(value).trim().length === 0;
}

function buildPollHeaders() {
    var out = {};
    if (headers != null) {
        var it = headers.entrySet().iterator();
        while (it.hasNext()) {
            var e = it.next();
            var name = String(e.getKey());
            var value = e.getValue();
            if (value instanceof java.util.Collection) {
                var parts = [];
                var vi = value.iterator();
                while (vi.hasNext()) { parts.push(String(vi.next())); }
                value = parts.join(name.toLowerCase() === "cookie" ? "; " : ", ");
            }
            if (value != null && SKIP_HEADERS.indexOf(name.toLowerCase()) < 0) {
                out[name] = String(value);
            }
        }
    }
    out["Accept"] = "application/json";
    return out;
}

function httpGet(target, requestHeaders) {
    var conn = new java.net.URL(target).openConnection();
    conn.setRequestMethod("GET");
    conn.setConnectTimeout(CONNECT_TIMEOUT_MS);
    conn.setReadTimeout(READ_TIMEOUT_MS);
    for (var name in requestHeaders) {
        conn.setRequestProperty(name, String(requestHeaders[name]));
    }
    var code = conn.getResponseCode();
    var stream = code >= 400 ? conn.getErrorStream() : conn.getInputStream();
    var text = "";
    if (stream != null) {
        var reader = new java.io.BufferedReader(new java.io.InputStreamReader(stream, "UTF-8"));
        var line;
        while ((line = reader.readLine()) != null) { text += line + "\n"; }
        reader.close();
    }
    return { code: Number(code), text: text };
}

function pollUntilDone(pollUrl, pollHeaders) {
    var started = java.lang.System.currentTimeMillis();
    var attempts = 0;

    while (java.lang.System.currentTimeMillis() - started < MAX_WAIT_MS) {
        attempts++;
        var res = httpGet(pollUrl, pollHeaders);
        if (res.code >= 300 && res.code < 500) {
            return "poll failed: http " + res.code;
        }
        var parsed = null;
        try { parsed = JSON.parse(res.text); } catch (e) {
            print("post-script: attempt", attempts, "non-JSON, http=", res.code);
        }
        if (parsed != null && TERMINAL_STATUSES.indexOf(String(parsed.status).toLowerCase()) >= 0) {
            print("post-script: done after", attempts, "attempt(s), status=", parsed.status);
            if (parsed.response != null && !isBlank(parsed.response.text)) {
                return String(parsed.response.text);
            }
            return "status=" + parsed.status;
        }
        java.lang.Thread.sleep(POLL_INTERVAL_MS);
    }
    return "timed out after " + MAX_WAIT_MS + "ms";
}

try {
    if (!SUBMIT_URL_REGEX.test(String(url))) {
        print("post-script: url does not match SUBMIT_URL_REGEX, skipping:", url);
    } else if (isBlank(body)) {
        print("post-script: empty body");
    } else {
        var submitted = JSON.parse(String(body));
        if (isBlank(submitted.job_id)) {
            print("post-script: no job_id in response");
        } else {
            var pollUrl = POLL_URL_PREFIX + String(submitted.job_id);
            body = pollUntilDone(pollUrl, buildPollHeaders());
        }
    }
} catch (e) {
    print("post-script error:", e);
    body = "post-script error: " + e;
}
```

</details>

#### Adapt the example to your agent

| Setting                           | What to change                                                                                   |
| --------------------------------- | ------------------------------------------------------------------------------------------------ |
| `SUBMIT_URL_REGEX`                | A pattern that matches only the request that carries the probe prompt.                           |
| `POLL_URL_PREFIX`                 | The endpoint you poll. The job id is appended to it.                                             |
| `TERMINAL_STATUSES`               | The status values your agent uses when a job is finished, including failure states.              |
| `POLL_INTERVAL_MS`                | How often to poll, in milliseconds.                                                              |
| `MAX_WAIT_MS`                     | The longest the script waits for the job. When it expires, `body` contains a timeout message.    |
| `READ_TIMEOUT_MS`                 | How long a single poll can wait for a reply. Raise it if your endpoint holds the request open until the job is done. |

If your agent names the job id or the answer differently, update the lines that read `submitted.job_id` and `parsed.response.text`. If your agent streams the answer in chunks, collect the chunks on each poll and join them once the job is done.

{% hint style="info" %}
The example reuses the headers from the prompt request so the polling call is authenticated the same way. If your agent needs a different token for the status endpoint, set it in `buildPollHeaders`.
{% endhint %}

{% hint style="warning" %}
Keep `MAX_WAIT_MS` finite. A script that never returns holds up the scan, and the scan stops when **Scan run time** expires.
{% endhint %}

You can use both scripts together. For example, a pre script creates the conversation and a post script polls for the answer.

## Usage notes

* Scripts apply to the probes of the scans you run after saving.
* Scripts can add authentication tokens, modify request data, or call other endpoints before or after the probe request.
* Be cautious when modifying core request properties, as it may affect the intended behavior of your scans.
* For complex operations, break your code into functions for readability and maintenance.
* Keep credentials out of the script where possible. Prefer a [scan role](create-a-test-role.md) for authentication.

