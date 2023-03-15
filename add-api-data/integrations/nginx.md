# NGINX

If your API calls are being routed through NGINX, you can use Akto's NGINX module to send traffic to Akto dashboard. Below guide will help you do this:

{% hint style="info" %}
This methods is recommended when you have end to end TLS and SSL termination happens at NGINX.
{% endhint %}

1. Record all API calls using `nginx-module-njs`. (njs is a standard NGINX module built and shipped in every release of NGINX). You can install it by running <mark style="color:purple;">`apt install nginx-module-njs`</mark>
2. The data is sent to Akto installed in your VPC using [nginx-kafka-log-module](https://github.com/kaltura/nginx-kafka-log-module). You can install it by using nginx dynamic modules functionality as described [here](https://www.nginx.com/blog/compiling-dynamic-modules-nginx-plus/)
3. Download the [js file](https://raw.githubusercontent.com/akto-api-security/nginx-middleware/master/api\_log.js) and save as `/etc/nginx/njs/api_log.js`
4. In your NGINX conf file - `/etc/nginx/nginx.conf` , add the following:

```lua
load_module /usr/lib/nginx/modules/ngx_http_js_module.so;
load_module /usr/lib/nginx/modules/ngx_http_kafka_log_module.so;
```

add the following lines in `http` section of `/etc/nginx/nginx.conf`:&#x20;

```lua
subrequest_output_buffer_size 8k;
js_path "/etc/nginx/njs/";
js_var $responseBo "{}";
js_import main2 from api_log.js;
kafka_log_kafka_brokers <AKTO_NLB_IP>:9092;
kafka_log_kafka_buffer_max_messages 100000;
```

5\. In `/etc/nginx/conf.d/default.conf`, add 2 lines in `server > location` section

```lua
server {
    location / {
        .....
        js_body_filter main2.to_lower_case;
		kafka_log kafka:quickstart-events $responseBo;
    }
}
```

6\. Restart NGINX by `nginx -s reload`. This will start logging all the request-response logs to akto.&#x20;

Note: We have benchmarked the an nginx server with and without akto nginx traffic module. The results for the same are as follows: 

| metrics           | vanilla nginx | nginx with akto module |
|-------------------|---------------|------------------------|
| avg. cpu usage    | upto 35%      | upto 40%               |
| avg. memory usage | 0.5%          | 0.5%                   |

The server setup being used is an AWS EC2 (t3a.small: 2CPU + 2GB RAM), with around 1600-1800 requests being fired per second to the server continuously for over a minute (~110k requests per minute). Here nginx is configured as a reverse proxy to a node.js backend server.