# NGINX

If your API calls are being routed through NGINX, you can use Akto's NGINX module to send traffic to Akto dashboard. Below guide will help you do this:

## Creating AWS Policy

1\. Go to Quick Start on your Akto dashboard and expand the `Connect traffic data` section.

<figure><img src="https://user-images.githubusercontent.com/91221068/236832212-603647ca-fceb-46fc-baf7-150c2e6b7ec0.png" alt=""><figcaption></figcaption></figure>

2\. Scroll down to `Data processors setup` section.

<figure><img src="https://user-images.githubusercontent.com/91221068/237100095-67164c73-2a0b-4505-8268-c932df4a1d27.png" alt=""><figcaption></figcaption></figure>

3\. Copy the `policy json` and click on the Akto Dashboard role link.

<figure><img src="https://user-images.githubusercontent.com/91221068/237100542-c3df31bc-9f7d-4be0-a626-038a31d33ce8.png" alt=""><figcaption></figcaption></figure>

4\. `Click` on the `JSON` tab and `paste the policy`

<figure><img src="https://user-images.githubusercontent.com/91221068/236832279-70340e39-3ccb-4118-9ee9-039711c7e22d.png" alt=""><figcaption></figcaption></figure>

5\. Click on `Review policy` button.

<figure><img src="https://user-images.githubusercontent.com/91221068/236832289-afe2931b-c11a-44b8-a946-79cf0e106dfa.png" alt=""><figcaption></figcaption></figure>

6\. Enter _`AktoDashboardPolicy`_ as the policy name and `click` on `Create Policy` button

<figure><img src="https://user-images.githubusercontent.com/91221068/236832299-996d635d-5c0d-43d3-8ee3-eb53f7de952d.png" alt=""><figcaption></figcaption></figure>

8\. Once the policy is created, go back to the `dashboard`.

## Setting up Data processors

1\. Click on `Setup traffic processors` button.

<figure><img src="https://github.com/akto-api-security/Documentation/assets/91221068/c3e08f08-ec81-4c47-b3b0-fbc1eacc4fe0" alt=""><figcaption></figcaption></figure>

2\. This will bring up infra that will process your traffic.&#x20;

<figure><img src="https://github.com/akto-api-security/Documentation/assets/91221068/7d7d437d-1370-4628-aa10-908b33b907b0" alt=""><figcaption></figcaption></figure>

3\. Check that you have `AKTO_NLB` and `AKTO_MONGO_IP` vars once setup is complete.&#x20;

<figure><img src="https://github.com/akto-api-security/Documentation/assets/91221068/7c79c400-7a0a-4421-96ed-fbb063e025f5" alt=""><figcaption></figcaption></figure>

## Add NGINX module

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
		kafka_log kafka:akto.api.logs $responseBo;
    }
}
```

6\. Restart NGINX by `nginx -s reload`. This will start logging all the request-response logs to akto.&#x20;

Note: We have benchmarked an nginx server with and without akto nginx traffic module. The results for the same are as follows: 

| metrics           | vanilla nginx | nginx with akto module |
|-------------------|---------------|------------------------|
| avg. cpu usage    | upto 36%      | upto 38%               |
| avg. memory usage | 0.5%          | 0.5%                   |

The server setup being used is an AWS EC2 (t3a.small: 2CPU + 2GB RAM), with around 1600-1800 requests being fired per second to the server continuously for over a minute (~110k requests per minute). Here nginx is configured as a reverse proxy to a node.js backend server.
