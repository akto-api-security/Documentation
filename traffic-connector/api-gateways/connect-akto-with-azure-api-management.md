# Connect Akto with Azure API Management

Azure API Management is Microsoft's fully managed service for securing, publishing, and analyzing APIs in the Azure cloud. Integrating Azure API Management with Akto enables automatic discovery and security testing of all APIs running in your Azure environment, providing seamless security coverage across your cloud infrastructure.

<figure><img src="../../.gitbook/assets/image (26).png" alt=""><figcaption></figcaption></figure>

To connect Akto with Azure API Management, please follow these steps -

## Step 1: Deploy the Akto Data-Ingestion Service

Before configuring the Azure API Management (APIM) Traffic Connector, you need to deploy the Akto Data-Ingestion Service. Ensure that the service is running and accessible via a publicly available URL.

### 1.1 Download the Required Files

SSH into the instance where you want to deploy the data-ingestion service and run these commands:

```bash
wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/docker-compose-data-ingestion-runtime.yml
wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/data-ingestion-docker.env
wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/docker-mini-runtime.env
wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/watchtower.env

```

### 1.2 Retrieve the `DATABASE_ABSTRACTOR_SERVICE_TOKEN`

* Log in to the [Akto Dashboard](https://app.akto.io/).
*   Navigate to the **Quick Start** tab in the left panel.

    <figure><img src="../../.gitbook/assets/Quick-Start.png" alt=""><figcaption></figcaption></figure>
*   Select **Hybrid SaaS Connector** and copy the token from the **Runtime Service Command** section.

    <figure><img src="../../.gitbook/assets/HybridSaaSConnector.png" alt=""><figcaption></figcaption></figure>

### 1.3 Update the `docker-mini-runtime.env` File

* Open the `docker-mini-runtime.env` file and replace `token` with the `DATABASE_ABSTRACTOR_SERVICE_TOKEN` you retrieved earlier.

```plaintext
DATABASE_ABSTRACTOR_SERVICE_TOKEN=token
```

### 1.4 Deploy the Data-Ingestion Service

Run the following command to start the data-ingestion service:

```bash
docker-compose -f docker-compose-data-ingestion-runtime.yml up -d
```

### 1.5 Note the IP Address of the Data-Ingestion Service

Ensure the instance is accessible from the network where your Azure APIM is configured. Note the instance's IP address, as it will be required by the Azure APIM connector to send traffic data.

***

## Step 2: Create an API Management Service in Azure Portal

1.  Go to the [Azure Portal](https://portal.azure.com/) and navigate to "API Management Services."

    <figure><img src="../../.gitbook/assets/Screenshot 2025-03-05 at 12.19.23 AM.png" alt=""><figcaption></figcaption></figure>
2. Click on the **Create** button.
3. Fill in the required details:
   * **Subscription**: Select your Azure subscription.
   * **Resource Group**: Choose an existing resource group or create a new one.
   * **Instance Details**:
     * **Region**: Select the region for your API Management service.
     * **Resource Name**: Provide a unique name for the service.
     * **Organization Name**: Enter your organization’s name.
     * **Administrator Email**: Provide an administrator email.
   * **Pricing Tier**: Select the appropriate pricing tier.
   * **Units**: Define the number of units as per your requirement.
4.  Click **Review + Create** and then **Create** to deploy the API Management service.

    <figure><img src="../../.gitbook/assets/Screenshot 2025-03-05 at 12.21.45 AM.png" alt=""><figcaption></figcaption></figure>

## Step 3: Import/Create APIs in API Management

1. Once the APIM service is created, navigate to the service in the Azure Portal.
2. Go to the **APIs** section.
3. Either import an existing API or create a new API.
4. Select the API where you want to add the policy for the traffic connector.

## Step 4: Configure the Traffic Connector Policy

1. Navigate to the **Inbound Policies** section of the selected API operation.
2.  Click on the **Edit Policy** button.

    <figure><img src="../../.gitbook/assets/Screenshot 2025-03-05 at 12.24.53 AM.png" alt=""><figcaption></figcaption></figure>
3. Paste the following policy configuration:

```xml
<policies>
    <inbound>
        <base />
        <set-variable name="regexList" value="" />
        <choose>
            <when condition="@{
                try
                {
                    var regexList = context.Variables.GetValueOrDefault<string>("regexList", "")
                        .Split(';')
                        .Where(r => !string.IsNullOrWhiteSpace(r))
                        .ToArray();
                    return regexList.Length == 0 || regexList.Any(r =>
                        System.Text.RegularExpressions.Regex.IsMatch(context.Request.OriginalUrl.Path, r.Trim()));
                }
                catch
                {
                    return false;
                }
            }">
                <set-variable name="reqBody" value="@{
                    try {
                        var body = context.Request.Body?.As<string>(preserveContent: true);
                        return body != null ? Newtonsoft.Json.JsonConvert.SerializeObject(body) : "\"\"";
                    } catch {
                        return "\"\"";
                    }
                }" />
                <set-variable name="requestTime" value="@(DateTime.UtcNow.ToString("o"))" />
            </when>
        </choose>
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <base />
        <choose>
            <when condition="@{
                try
                {
                    var regexList = context.Variables.GetValueOrDefault<string>("regexList", "")
                        .Split(';')
                        .Where(r => !string.IsNullOrWhiteSpace(r))
                        .ToArray();
                    return regexList.Length == 0 || regexList.Any(r =>
                        System.Text.RegularExpressions.Regex.IsMatch(context.Request.OriginalUrl.Path, r.Trim()));
                }
                catch
                {
                    return false;
                }
            }">
                <set-variable name="reqMethod" value="@(context.Request.Method)" />
                <set-variable name="reqUrl" value="@(context.Request.OriginalUrl.Path)" />
                <set-variable name="reqHeaders" value="@{
                    try {
                        return Newtonsoft.Json.JsonConvert.SerializeObject(
                            Newtonsoft.Json.JsonConvert.SerializeObject(
                                context.Request.Headers.ToDictionary(k => k.Key, v => string.Join(", ", v.Value))
                            )
                        );
                    } catch {
                        return "\"\"";
                    }
                }" />
                <set-variable name="requestTime" value="@(DateTime.UtcNow.ToString("o"))" />
                <set-variable name="clientIp" value="@(context.Request.IpAddress)" />
                <set-variable name="respStatus" value="@((context.Response.StatusCode).ToString())" />
                <set-variable name="respHeaders" value="@{
                    try {
                        return Newtonsoft.Json.JsonConvert.SerializeObject(
                            Newtonsoft.Json.JsonConvert.SerializeObject(
                                context.Response.Headers.ToDictionary(k => k.Key, v => string.Join(", ", v.Value))
                            )
                        );
                    } catch {
                        return "\"\"";
                    }
                }" />
                <set-variable name="respBody" value="@{
                    try {
                        var body = context.Response.Body?.As<string>(preserveContent: true);
                        return body != null ? Newtonsoft.Json.JsonConvert.SerializeObject(body) : "\"\"";
                    } catch {
                        return "\"\"";
                    }
                }" />
                <set-variable name="unixTimestamp" value="@{
                    return ((long)(DateTime.UtcNow - new DateTime(1970, 1, 1)).TotalSeconds).ToString();
                }" />
                <set-variable name="statusMessage" value="@{
                    try {
                        var friendlyHttpStatus = new Dictionary<int, string>
                        {
                            {200, "OK"}, {201, "Created"}, {202, "Accepted"}, {203, "Non-Authoritative Information"},
                            {204, "No Content"}, {205, "Reset Content"}, {206, "Partial Content"}, {300, "Multiple Choices"},
                            {301, "Moved Permanently"}, {302, "Found"}, {303, "See Other"}, {304, "Not Modified"},
                            {305, "Use Proxy"}, {306, "Unused"}, {307, "Temporary Redirect"}, {400, "Bad Request"},
                            {401, "Unauthorized"}, {402, "Payment Required"}, {403, "Forbidden"}, {404, "Not Found"},
                            {405, "Method Not Allowed"}, {406, "Not Acceptable"}, {407, "Proxy Authentication Required"},
                            {408, "Request Timeout"}, {409, "Conflict"}, {410, "Gone"}, {411, "Length Required"},
                            {412, "Precondition Failed"}, {413, "Payload Too Large"}, {414, "URI Too Long"},
                            {415, "Unsupported Media Type"}, {416, "Range Not Satisfiable"}, {417, "Expectation Failed"},
                            {418, "I'm a teapot"}, {429, "Too Many Requests"}, {500, "Internal Server Error"},
                            {501, "Not Implemented"}, {502, "Bad Gateway"}, {503, "Service Unavailable"},
                            {504, "Gateway Timeout"}, {505, "HTTP Version Not Supported"}
                        };

                        return friendlyHttpStatus.ContainsKey(context.Response.StatusCode) 
                            ? friendlyHttpStatus[context.Response.StatusCode] 
                            : "Unknown Status";
                    } catch {
                        return "Unknown Status";
                    }
                }" />
                <set-variable name="missingKeys" value="@{
                    var missing = new List<string>();
                    var keys = new[] {
                        "reqUrl", "reqHeaders", "respHeaders", "reqMethod", "reqBody",
                        "respBody", "clientIp", "unixTimestamp", "respStatus", "statusMessage"
                    };
                    foreach (var key in keys)
                    {
                        if (!context.Variables.ContainsKey(key))
                        {
                            missing.Add(key);
                        }
                    }
                    return string.Join(",", missing);
                }" />
                <choose>
                    <when condition="@(!string.IsNullOrEmpty(context.Variables.GetValueOrDefault<string>("missingKeys", "")))">
                        <trace source="akto-apim-debug" severity="verbose">
                            <message>@((string)context.Variables["missingKeys"])</message>
                        </trace>
                    </when>
                </choose>
                <send-one-way-request>
                    <set-url>https://<YOUR_AKTO_INGESTION_SERVICE_URL>/api/ingestData</set-url>
                    <set-method>POST</set-method>
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>@{
                        try {
                            return "{ \"batchData\": [" +
                                "{ \"path\": \"" + context.Variables.GetValueOrDefault<string>("reqUrl", "") + "\", " +
                                "\"requestHeaders\": " + context.Variables.GetValueOrDefault<string>("reqHeaders", "\"\"") + ", " +
                                "\"responseHeaders\": " + context.Variables.GetValueOrDefault<string>("respHeaders", "\"\"") + ", " +
                                "\"method\": \"" + context.Variables.GetValueOrDefault<string>("reqMethod", "") + "\", " +
                                "\"requestPayload\": " + context.Variables.GetValueOrDefault<string>("reqBody", "\"\"") + ", " +
                                "\"responsePayload\": " + context.Variables.GetValueOrDefault<string>("respBody", "\"\"") + ", " +
                                "\"ip\": \"" + context.Variables.GetValueOrDefault<string>("clientIp", "") + "\", " +
                                "\"time\": \"" + context.Variables.GetValueOrDefault<string>("unixTimestamp", "") + "\", " +
                                "\"statusCode\": \"" + context.Variables.GetValueOrDefault<string>("respStatus", "") + "\", " +
                                "\"type\": \"HTTP/1.1\", " +
                                "\"status\": \"" + context.Variables.GetValueOrDefault<string>("statusMessage", "") + "\", " +
                                "\"akto_account_id\": \"1000000\", " +
                                "\"akto_vxlan_id\": \"0\", " +
                                "\"is_pending\": \"false\", " +
                                "\"source\": \"MIRRORING\" } ] }";
                        } catch {
                            return "{}";
                        }
                    }</set-body>
                </send-one-way-request>
            </when>
        </choose>
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>
```

4. **Important Note**:\
   If you remove the `<base />` element from the policy configuration at the API scope, **only** the policies defined at the API scope will be applied. Policies configured at **product**, **global**, or other broader scopes will **not** be inherited or executed. Always include `<base />` in the appropriate sections (`<inbound>`, `<backend>`, `<outbound>`, and `<on-error>`) unless you explicitly intend to override all inherited behavior. (For more info [click here](https://learn.microsoft.com/en-us/azure/api-management/api-management-howto-policies).)
5. Add the regex patterns for the paths you want to **include** in the `regexList` variable value in the inbound policy, ensuring that the **entire regex is properly escaped**. Separate multiple patterns using `;` (e.g., `"api\/v1\/.*;\/api\/getUsers.*"`).
   * If you leave the `regexList` variable value empty, all APIs will be processed.
6. Replace `YOUR_AKTO_INGESTION_SERVICE_URL` with the URL of your Akto Data-Ingestion Service (Step 1.5).
7. Click **Save** to apply the policy.

## Step 5: Verify the Integration

1. Send test requests to the configured API endpoint.
2. Check the Akto Data-Ingestion Service logs to verify that the traffic data is being ingested correctly.

### Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
