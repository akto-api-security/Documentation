# NGINX

If your API calls are being routed through NGINX, you can use Akto's NGINX module to send traffic to Akto dashboard. Below guide will help you do this:

{% hint style="info" %}
This methods is recommended when you have end to end TLS and SSL termination happens at NGINX.
{% endhint %}

1. Record all API calls in a log file using `nginx-module-njs`. (njs is a standard NGINX module built and shipped in every release of NGINX). You can install it by running <mark style="color:purple;">`apt install nginx-module-njs`</mark>
2. Download the [js file](https://raw.githubusercontent.com/akto-api-security/nginx-middleware/master/api\_log.js) and save as `/etc/nginx/njs/api_log.js`
3. In your NGINX conf file - `/etc/nginx/nginx.conf` , add the following:

```lua
load_module /usr/lib/nginx/modules/ngx_ http_js_module.so;
```

add the following lines in `http` section of `/etc/nginx/nginx.conf`:&#x20;

```lua
subrequest_output_buffer_size 8k;
js_path "/etc/nginx/njs/";
js_var $responseBo "{}";
js_import main2 from api_log.js;
log_format access_debug escape=none $responseBo;
access_log /var/log/nginx/access_debug.log access_debug;
```

4\. In `/etc/nginx/conf.d/default.conf`, add 1 line in `server > location` section

```lua
server {
    location / {
        .....
        js_body_filter main2.to_lower_case
    }
}
```

5\. Restart NGINX by `nginx -s reload`. This will start saving all the request-response logs in /var/log/nginx/access\_debug.log.&#x20;

6\. Save this log file in an S3 bucket.

7\. Run a lambda which reads the file and sends data to Akto’s Kafka. Each message should be of the following format

```json
{
	"path": "/api/v1/orders",
	"requestHeaders": '{}', // json
	"responseHeaders": '{}',// json 
	"method": "GET",
	"requestPayload": '{}',// json 
	"responsePayload": json.dumps({}),// json 
	"ip": "", // source ip
	"time": "1643966693", 
	"statusCode": "200",
	"type":"HTTP/1.1",
	"status": "OK",
	"akto_account_id": "1000000", 
	"akto_vxlan_id": "123", // collection id to populate 
	"is_pending" :"false",
	"source":"OTHER"
}
```

