# Connect Akto with IBM Connect

IBM API Connect is IBM's comprehensive API management solution designed specifically for enterprises running hybrid cloud environments. By integrating IBM API Connect with Akto, you'll be able to automatically discover and test the security of all agentic components across your IBM Cloud and on-premise environments, helping you maintain consistent security standards across your entire infrastructure.

<figure><img src="../../../../.gitbook/assets/image (10).png" alt=""><figcaption></figcaption></figure>

To connect Akto with IBM API Connect, follow the steps below.

***

## Step 1: Deploy the Akto Data-Ingestion Service

Before configuring your API Connect global policies, ensure that the Akto Data-Ingestion Service is up and running.

### 1.1 Download Required Files

SSH into the server where you want to deploy the data-ingestion service and run the following commands:

```bash
wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/docker-compose-data-ingestion-runtime.yml
wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/data-ingestion-docker.env
wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/docker-mini-runtime.env
wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/watchtower.env
```

### 1.2 Retrieve the Akto Token

1. Log in to the [Akto Dashboard](https://app.akto.io/).
2.  Navigate to the **Quick Start** tab.

    <figure><img src="../../../../.gitbook/assets/Quick-Start.png" alt=""><figcaption></figcaption></figure>
3.  Select **Hybrid SaaS Connector** and copy the token shown under **Runtime Service Command**.

    <figure><img src="../../../../.gitbook/assets/HybridSaaSConnector.png" alt=""><figcaption></figcaption></figure>

### 1.3 Configure the Environment File

Edit the `docker-mini-runtime.env` file and add your Akto token:

```plaintext
DATABASE_ABSTRACTOR_SERVICE_TOKEN=your_token_here
```

### 1.4 Deploy the Service

Start the data-ingestion service using Docker:

```bash
docker-compose -f docker-compose-data-ingestion-runtime.yml up -d
```

Make sure this instance is accessible over the network from IBM API Connect's gateway service.

***

## Step 2: Deploy Akto Gateway Interceptor Scripts

IBM API Connect allows global prehook and posthook scripts to intercept API traffic. You’ll use custom GatewayScript-based policies to forward request and response data to Akto.

### 2.1 Download the Pre and Post Global Policy Files

Make sure you have the following two files:

* `global-pre.yaml`

```yaml
global-policy: 1.0.0
info:
  name: akto_global_pre
  title: Akto IBM Agent PreRequest
  version: 1.0.0
  mode: after-builtin
gateways:
  - datapower-api-gateway
assembly:
  execute:
    - gatewayscript:
        version: 2.0.0
        title: akto-ibm-agent
        source: |
          context.set("start_time", new Date().getTime());
          context.request.body.readAsBuffer(function (error, buffer) {
            try {
              if (!error && buffer && buffer.length > 0) {
                var bufferStr = new Buffer(buffer).toString("base64");
                context.set("request_body", bufferStr);
              } else {
                context.set("request_body", "");
              }
            } catch (e) {
              context.set("request_body", "");
            }
          });

```

* `global-post.yaml`

```yaml
global-policy: 1.0.0
info:
  name: akto_global_post
  title: Akto IBM Agent PostRequest
  version: 1.0.0
gateways:
  - datapower-api-gateway
assembly:
  execute:
    - gatewayscript:
        version: 2.0.0
        title: akto-ibm-agent
        source: |
          var urlopen = require("urlopen");

          var friendlyHttpStatus = {
            '200': 'OK',
            '201': 'Created',
            '202': 'Accepted',
            '203': 'Non-Authoritative Information',
            '204': 'No Content',
            '205': 'Reset Content',
            '206': 'Partial Content',
            '300': 'Multiple Choices',
            '301': 'Moved Permanently',
            '302': 'Found',
            '303': 'See Other',
            '304': 'Not Modified',
            '305': 'Use Proxy',
            '306': 'Unused',
            '307': 'Temporary Redirect',
            '400': 'Bad Request',
            '401': 'Unauthorized',
            '402': 'Payment Required',
            '403': 'Forbidden',
            '404': 'Not Found',
            '405': 'Method Not Allowed',
            '406': 'Not Acceptable',
            '407': 'Proxy Authentication Required',
            '408': 'Request Timeout',
            '409': 'Conflict',
            '410': 'Gone',
            '411': 'Length Required',
            '412': 'Precondition Required',
            '413': 'Request Entry Too Large',
            '414': 'Request-URI Too Long',
            '415': 'Unsupported Media Type',
            '416': 'Requested Range Not Satisfiable',
            '417': 'Expectation Failed',
            '418': 'I\'m a teapot',
            '429': 'Too Many Requests',
            '500': 'Internal Server Error',
            '501': 'Not Implemented',
            '502': 'Bad Gateway',
            '503': 'Service Unavailable',
            '504': 'Gateway Timeout',
            '505': 'HTTP Version Not Supported',
          };

          function lowerHeaders(headers) {
            var key, keys = Object.keys(headers);
            var loweredHeaders = {};
            var n = keys.length;
            for (var i = 0; i < n; i++) {
              key = keys[i];
              if (typeof headers[key] == "object") {
                if (Array.isArray(headers[key])) {
                  loweredHeaders[key.toLowerCase()] = headers[key].join(",").toString();
                  continue;
                } else {
                  continue;
                }
              }
              loweredHeaders[key.toLowerCase()] = headers[key];
            }
            return loweredHeaders;
          }

          var headers = context.get("request.headers");
          var contentType = headers["content-type"] || headers["Content-Type"] || "";
          var request_headers = lowerHeaders(headers);
          var resp_headers = context.get("message.headers");
          var response_headers = lowerHeaders(resp_headers);

          if (contentType.indexOf("application/json") !== -1) {
            var req_body_base64 = context.get("request_body") || "";
            var req_body_str = "";
            var allStrings = true;

            if (req_body_base64.length > 0) {
              try {
                var req_buffer = new Buffer(req_body_base64, "base64");
                req_body_str = req_buffer.toString("utf-8");

                var parsedJson = JSON.parse(req_body_str);
                for (var key in parsedJson) {
                  if (typeof parsedJson[key] !== "string") {
                    allStrings = false;
                    break;
                  }
                }

                if (!allStrings) {
                  req_body_str = "";
                }
              } catch (e) {
                req_body_str = "";
              }
            }

            var path =
              context.get("api.org.name") + "/" +
              context.get("api.catalog.path") + "/" +
              context.get("request.path") +
              context.get("request.search");
            var verb = context.get("request.verb");
            var host = context.get("api.endpoint.hostname");
            var status = context.get("message.status.code");
            var client_addr = context.get("session.clientAddress");
            var http_version = "HTTP/" + (context.get("request.version") || "1.1");

            var start_time = context.get("start_time");

            context.message.body.readAsBuffer(function (error, buffer) {
              var res_body = "";
              if (!error && buffer != null && buffer.length > 0) {
                try {
                  res_body = buffer.toString("utf-8");
                } catch (e) {
                  res_body = "";
                }
                context.message.body.write(buffer);
              }

              var sendData = {
                batchData: [
                  {
                    path: path,
                    requestHeaders: JSON.stringify(request_headers),
                    responseHeaders: JSON.stringify(response_headers),
                    method: verb,
                    requestPayload: req_body_str,
                    responsePayload: res_body,
                    ip: client_addr || "0.0.0.0",
                    time: "" + Math.floor(start_time / 1000),
                    statusCode: "" + status,
                    type: "HTTP/" + http_version,
                    status: "" + friendlyHttpStatus[(status + "")],
                    akto_account_id: "1000000",
                    akto_vxlan_id: "0",
                    is_pending: "false",
                    source: "MIRRORING"
                  }
                ]
              };

              var request_final = {
                target: "https://"+<data-ingestion-service-ip>+"/api/ingestData",
                method: "POST",
                headers: {
                  "content-type": "application/json",
                },
                timeout: 5,
                data: JSON.stringify(sendData),
              };

              urlopen.open(request_final, function (error, response) {
                if (error) {
                  console.error(
                    "error: " + error + " info: connection failed trying to secure backup"
                  );
                  return;
                }
              });
            });
          }
```

These files define global prehook and posthook behavior using GatewayScript.

### 2.2 Run the Setup Script

We provide a shell script to automatically upload and configure these global policies.

#### Script: `setup-akto-gateway-hooks.sh`

```bash
#!/bin/bash

server="your_server_here"
org="your_org_here"
gateway="your_gateway_here"
data_ingestion_service_ip="your_data-ingestion-service-ip_here"
catalog="your_catalog_here"

echo $data_ingestion_service_ip 
sed -i '' "s|data-ingestion-service-ip|${data_ingestion_service_ip}|g" global-post.yaml

apic global-policies:create --catalog $catalog --configured-gateway-service $gateway --org $org --server $server --scope catalog global-pre.yaml > temp
preurl=$(cut -d " " -f 4 temp)
echo -e "global_policy_url: >-\n  $preurl" > GlobalPolicy.yaml
apic global-policy-prehooks:create --catalog $catalog --configured-gateway-service $gateway --org $org --server $server --scope catalog GlobalPolicy.yaml

apic global-policies:create --catalog $catalog --configured-gateway-service $gateway --org $org --server $server --scope catalog global-post.yaml > temp
posturl=$(cut -d " " -f 4 temp)
echo -e "global_policy_url: >-\n  $posturl" > GlobalPolicy.yaml
apic global-policy-posthooks:create --catalog $catalog --configured-gateway-service $gateway --org $org --server $server --scope catalog GlobalPolicy.yaml
```

### 2.3 Modify the Script

Update the following variables in the script:

```bash
server="https://<your-apic-server>"
org="<your-org-name>"
gateway="<your-configured-gateway-service-name>"
data_ingestion_service_ip="<your-data-ingestion-service-ip (Step 1)>"
catalog="<your-catalog-name>"
```

### 2.4 Execute the Script

Make the script executable and run it:

```bash
chmod +x setup-akto-gateway-hooks.sh
./setup-akto-gateway-hooks.sh
```

This will upload and register both prehook and posthook global policies with your IBM API Connect Gateway.

***

## Step 3: Confirm Traffic is Flowing to Akto

After setup:

* Make a few requests from your applications.
* Go to the **Agent Collections** in Akto dashboard.
* You should begin seeing real-time traffic, including headers, payloads, status codes, and timestamps.

***

## Notes

* Ensure that your gateway has outbound access to the Akto Data-Ingestion Service.
