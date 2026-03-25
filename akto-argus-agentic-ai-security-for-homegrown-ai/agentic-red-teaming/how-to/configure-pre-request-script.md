# Configure Pre-request Script

## Configure Pre-request Script

The Pre-request script feature in Akto allows you to execute custom JavaScript code before each probe is run. This powerful functionality enables you to dynamically modify request parameters or perform any necessary pre-scan operations.

{% @arcade/embed url="https://app.arcade.software/share/y9rVLnnM4hZKDB4428FM" flowId="y9rVLnnM4hZKDB4428FM" %}

### Setting Up the Pre-request Script

1. In the text area labeled "Enter pre-request javascript here...", input your JavaScript code.
2. The script has access to several predefined variables:
   * `method`: The HTTP method of the request (e.g., GET, POST)
   * `headers`: The headers of the request
   * `url`: The URL of the request
   * `payload`: The body of the request
   * `queryParams`: The query parameters of the request
3. Write your custom logic using these variables and any additional JavaScript you need.

### Example Pre-request Script

Here's an example of a pre-request script This pre-request script is an example of **conditional request modification based on url content**.:

```javascript
var body;
var method;
var requestHeaders;
var url;
var payload;
var queryParams;
var parsedPayloadTemp;

try {
    if (url.indexOf("prompt") > -1) {
        method = "PATCH";
    }
} catch (e) {
    print("[agent] Pre-request script error: " + e);
    print(e);
}
```

### Saving Your Configuration

After entering your pre-request script, click the "Save" button at the bottom right of the page to apply your changes.

<figure><img src="../../../.gitbook/assets/image (1).png" alt="" width="563"><figcaption></figcaption></figure>

### Usage Notes

* The pre-request script runs before every probe in your Akto environment.
* You can use this feature to:
  * Add authentication tokens dynamically
  * Modify request data based on external factors
  * Implement custom logic that needs to run before each probe
* Be cautious when modifying core request properties, as it may affect the intended behaviour of your scans.
* For complex operations, consider breaking your code into functions for better readability and maintenance.

By effectively using the Pre-request script feature, you can enhance the flexibility and power of your red teaming process in Akto.
