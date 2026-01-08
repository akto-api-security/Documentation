# Evidence

The Evidence tab in the Issue details provides in-depth information about the specific API interactions associated with the detected vulnerability. When examining an issue, the evidence tab offers detailed insights into the API calls that triggered the security concern.&#x20;

This includes both the requests sent to the API and the responses received, allowing for a comprehensive analysis of the vulnerability context.

### Request

The request section typically displays:

* HTTP method used
* Endpoint path
* Headers sent with the request
* Any data or parameters included in the request body

This information helps in understanding how the API was called and what data was sent, which is crucial for identifying the root cause of the security issue.

### Response

The response section usually shows:

* HTTP status code
* Response headers
* Body of the response

Analysing the response data is essential for understanding how the API reacted to the potentially vulnerable request and what information may have been exposed.

{% hint style="info" %}
#### Change Legend in Evidence

The legend under the Evidence tab explains how Akto highlights differences between compared requests and responses.

*   **Added**

    Marks fields or values that appear in the current request or response but were not present earlier.
*   **Removed**

    Marks fields or values that were present earlier but are missing in the current request or response.
*   **Updated**

    Marks fields or values that exist in both comparisons but have different values.

![](<../../.gitbook/assets/image (177).png>)
{% endhint %}

### Usage

Examining the Evidence tab allows you to:

1. Understand the exact nature of the vulnerability by seeing the raw data exchanged.
2. Identify specific headers or payload elements that may be causing the security issue.
3. Verify the severity and impact of the vulnerability based on the actual data exposed or manipulated.
4. Guide the development of precise fixes by pinpointing the problematic parts of the request or response.

The Evidence tab is a crucial to gain a detailed understanding of each detected vulnerability, facilitating more effective and targeted remediation efforts.
