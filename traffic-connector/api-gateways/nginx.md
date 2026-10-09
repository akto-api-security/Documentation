# Connect Akto with NGINX

<figure><img src="../../.gitbook/assets/image (91).png" alt=""><figcaption></figcaption></figure>

If your API calls are being routed through NGINX, you can use Akto's NGINX module to send traffic to Akto dashboard. Below guide will help you do this:

## Step 1: Configure Akto Traffic Processor

Set up and configure Akto Traffic Processor. The steps are mentioned [here](https://docs.akto.io/getting-started/traffic-processor/hybrid-saas).

## Step 2: Add NGINX module

{% hint style="info" %}
This methods is recommended when you have end to end TLS and SSL termination happens at NGINX.
{% endhint %}

The Akto nginx module uses the dynamic module functionality supported by nginx. This requires nginx to be build from source for which the exact steps can be slightly varied depending on the linux flavour, the core process though, remains the same.

<mark style="background-color:purple;">Note: For</mark> <mark style="background-color:purple;"></mark><mark style="background-color:purple;">`AKTO_NLB_IP`</mark> <mark style="background-color:purple;"></mark><mark style="background-color:purple;">in below configurations, use the value of the</mark> <mark style="background-color:purple;"></mark><mark style="background-color:purple;">`mini-runtime`</mark> <mark style="background-color:purple;"></mark><mark style="background-color:purple;">service we deployed in step 1.</mark>

<details>

<summary>Ubuntu / Debian based</summary>

1. Record all API calls using `nginx-module-njs`. (njs is a standard NGINX module built and shipped in every release of NGINX). You can install it by running <mark style="color:purple;">`apt install nginx-module-njs`</mark>. This package comes from the [nginx.org repository](https://nginx.org/en/linux_packages.html) and works with nginx.org's NGINX. If `nginx -v` shows `(Ubuntu)` or `(Debian)`, your NGINX came from your distribution, so install NGINX from nginx.org first ([Ubuntu](https://nginx.org/en/linux_packages.html#Ubuntu) / [Debian](https://nginx.org/en/linux_packages.html#Debian)).
2. The data is sent to Akto installed in your VPC using [nginx-kafka-log-module](https://github.com/akto-api-security/nginx-kafka-log-module). You can install it by using nginx dynamic modules functionality as described [here](https://www.f5.com/company/blog/nginx/compiling-dynamic-modules-nginx-plus.html), or by running the build script below. It installs the dependencies, builds the module for your installed NGINX version and copies it to `/usr/lib/nginx/modules/`:

```bash
git clone https://github.com/akto-api-security/nginx-kafka-log-module.git
cd nginx-kafka-log-module
scripts/build-linux.sh --install-deps --install
```

The script supports Debian 11, 12, 13 and Ubuntu 20.04, 22.04, 24.04. Run it again after upgrading NGINX.

3. Download the [js file](https://raw.githubusercontent.com/akto-api-security/nginx-middleware/master/api_log.js) and save as `/etc/nginx/njs/api_log.js`
4. In your NGINX conf file - `/etc/nginx/nginx.conf` , add the following:

```lua
load_module /usr/lib/nginx/modules/ngx_http_js_module.so;
load_module /usr/lib/nginx/modules/ngx_http_kafka_log_module.so;
```

add the following lines in `http` section of `/etc/nginx/nginx.conf`:

```lua
subrequest_output_buffer_size 8k;
js_path "/etc/nginx/njs/";
js_var $responseBo "{}";
js_import main2 from api_log.js;
kafka_log_enable on;
kafka_log_kafka_brokers <AKTO_NLB_IP>:9092;
kafka_log_kafka_buffer_max_messages 100000;
```

5\. In `/etc/nginx/conf.d/default.conf`, add 2 lines in `server > location` section

```lua
server {
    location / {
        .....
        js_body_filter main2.to_lower_case buffer_type=buffer;
		kafka_log kafka:akto.api.logs $responseBo;
    }
}
```

6\. Check the configuration, restart NGINX, and make sure worker processes are running:

```bash
nginx -t
systemctl restart nginx
ps -eo pid,command | grep "[n]ginx: worker"
```

At least one `nginx: worker` line must be listed. This will start logging all the request-response logs to akto.

</details>

<details>

<summary>Optional: Kafka with SASL authentication (Ubuntu / Debian based)</summary>

Use this if the Kafka broker that NGINX sends to requires a username and password. It needs the module built from Akto's fork in step 2 above. The example uses SASL/PLAIN. Any [librdkafka setting](https://github.com/confluentinc/librdkafka/blob/master/CONFIGURATION.md) can be passed with `kafka_log_rdkafka_property` (see also [Using SASL with librdkafka](https://github.com/confluentinc/librdkafka/wiki/Using-SASL-with-librdkafka)).

**Kafka side: add a SASL listener**

Add a listener that uses SASL/PLAIN for NGINX to connect to, and keep your other listeners as they are. The example below uses a listener named `SASLHOST` on port `29094` with the user `akto` and the password `akto-secret`.

For the Kafka image used in Akto's docker-compose setup (replace `...` with your existing values; the listener name in the variable names must not contain underscores):

```yaml
    ports:
      - "29094:29094"
    environment:
      KAFKA_LISTENERS: "...,SASLHOST://0.0.0.0:29094"
      KAFKA_ADVERTISED_LISTENERS: "...,SASLHOST://<KAFKA_HOST>:29094"
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: "...,SASLHOST:SASL_PLAINTEXT"
      KAFKA_LISTENER_NAME_SASLHOST_SASL_ENABLED_MECHANISMS: PLAIN
      KAFKA_LISTENER_NAME_SASLHOST_PLAIN_SASL_JAAS_CONFIG: 'org.apache.kafka.common.security.plain.PlainLoginModule required user_akto="akto-secret";'
```

The same listener in a standard Kafka `server.properties` (the listener name is lowercase in the last two keys):

```properties
listeners=PLAINTEXT://0.0.0.0:9092,SASLHOST://0.0.0.0:29094
advertised.listeners=PLAINTEXT://<KAFKA_HOST>:9092,SASLHOST://<KAFKA_HOST>:29094
listener.security.protocol.map=PLAINTEXT:PLAINTEXT,SASLHOST:SASL_PLAINTEXT
listener.name.saslhost.sasl.enabled.mechanisms=PLAIN
listener.name.saslhost.plain.sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required user_akto="akto-secret";
```

`<KAFKA_HOST>` must be a hostname or IP address that the NGINX machine can reach (not `localhost`), because Kafka tells clients to reconnect to the advertised address. Restart Kafka after changing listeners. See the [Kafka security documentation](https://kafka.apache.org/documentation/#security) for other mechanisms.

**NGINX side**

1. Create `/etc/nginx/kafka.env` with your editor (so the password does not end up in your shell history) containing the credentials, then restrict it:

```
KAFKA_SASL_USERNAME=akto
KAFKA_SASL_PASSWORD=akto-secret
```

```bash
chmod 600 /etc/nginx/kafka.env
```

2. Tell systemd to load this file for NGINX:

```bash
mkdir -p /etc/systemd/system/nginx.service.d
printf '[Service]\nEnvironmentFile=/etc/nginx/kafka.env\n' > /etc/systemd/system/nginx.service.d/kafka-env.conf
systemctl daemon-reload
```

3. Add these two lines to the top of `/etc/nginx/nginx.conf`, next to the `load_module` lines:

```lua
env KAFKA_SASL_USERNAME;
env KAFKA_SASL_PASSWORD;
```

4. In the `http` section of `/etc/nginx/nginx.conf`, replace the `kafka_log_kafka_brokers` line with the SASL listener and add the four properties below. The username and password are read from the environment variables, so they are not written in `nginx.conf`:

```lua
kafka_log_kafka_brokers <KAFKA_HOST>:29094;
kafka_log_rdkafka_property security.protocol SASL_PLAINTEXT;
kafka_log_rdkafka_property sasl.mechanism PLAIN;
kafka_log_rdkafka_property_env sasl.username KAFKA_SASL_USERNAME;
kafka_log_rdkafka_property_env sasl.password KAFKA_SASL_PASSWORD;
```

5. Check the configuration, restart NGINX, and make sure worker processes are running:

```bash
export $(cat /etc/nginx/kafka.env) && nginx -t
systemctl restart nginx
ps -eo pid,command | grep "[n]ginx: worker"
```

Notes:

* `kafka_log_rdkafka_property_env <property> <VARIABLE>` sets a librdkafka property from an environment variable. If the variable is missing or empty, NGINX refuses to start and the error names the variable. If you prefer, `kafka_log_rdkafka_property <property> <value>` puts the value directly in `nginx.conf`.
* Restart NGINX (not reload) after you change the credentials.
* `SASL_PLAINTEXT` sends the password unencrypted. If the network between NGINX and Kafka is not trusted, use `SASL_SSL` and set the `ssl.*` properties.
* With wrong credentials, requests are still served but nothing reaches Kafka, and `/var/log/nginx/error.log` shows `SASL authentication error`.
* If NGINX is not started by systemd (for example in a container), skip step 2 and pass the two variables to the NGINX process with your platform's own mechanism. Keep the `env` lines from step 3.

</details>

<details>

<summary>Amazon linux 2</summary>

1. sudo su -
2.  To set up the yum repository for Amazon Linux 2 for nginx, create the file named `/etc/yum.repos.d/nginx.repo` with the following content. This is needed to install `nginx` (if not present) and `nginx-module-njs`.

    ```bash
    [nginx-stable]
    name=nginx stable repo
    baseurl=http://nginx.org/packages/amzn2/$releasever/$basearch/
    gpgcheck=1
    enabled=1
    gpgkey=https://nginx.org/keys/nginx_signing.key
    module_hotfixes=true
    priority=9

    [nginx-mainline]
    name=nginx mainline repo
    baseurl=http://nginx.org/packages/mainline/amzn2/$releasever/$basearch/
    gpgcheck=1
    enabled=0
    gpgkey=https://nginx.org/keys/nginx_signing.key
    module_hotfixes=true
    priority=9
    ```
3. If nginx is not present install it using `yum install nginx` else you can skip this step.
4. Check your nginx version using `nginx -v` and download/extract the source for the same using the following commands.

```bash
wget http://nginx.org/download/nginx-{version}.tar.gz
tar -zxvf nginx-{version}.tar.gz

e.g.

wget http://nginx.org/download/nginx-1.26.0.tar.gz
tar -zxvf nginx-1.26.0.tar.gz
```

4. Install nginx-module-njs using `yum install nginx-module-njs` ( In case of any problem, please refer to the [official nginx docs to install nginx-module-njs](https://nginx.org/en/docs/njs/install.html) )
5. We will send data to Akto traffic processor using [nginx-kafka-log-module](https://github.com/kaltura/nginx-kafka-log-module). To clone it run: `git clone https://github.com/kaltura/nginx-kafka-log-module.git`
6. We can install nginx-kafka-log-module using the steps below. For the official nginx docs to install nginx dynamic modules refer [this](https://www.f5.com/company/blog/nginx/compiling-dynamic-modules-nginx-plus.html).

```bash
# Enable EPEL repository if not already enabled
amazon-linux-extras install epel -y
# Install librdkafka and its development package
yum install librdkafka librdkafka-devel -y
yum install pcre pcre-devel -y
yum groupinstall "Development Tools" -y
# go to nginx directory, which we downloaded in step 3
cd nginx-1.26.0/
./configure --with-compat --add-dynamic-module=../nginx-kafka-log-module --with-cc-opt="-I/usr/include" --with-ld-opt="-L/usr/lib"
make modules
cp objs/ngx_http_kafka_log_module.so /etc/nginx/modules/
```

9. Add the Akto njs code to nginx njs directory using the following commands.

```bash
mkdir /etc/nginx/njs
curl -o /etc/nginx/njs/api_log.js https://raw.githubusercontent.com/akto-api-security/nginx-middleware/master/api_log.js
```

10. To configure nginx, in your nginx configuration file ( `/etc/nginx/nginx.conf` ), add the following lines to top:

```bash
load_module /etc/nginx/modules/ngx_http_js_module.so;
load_module /etc/nginx/modules/ngx_http_kafka_log_module.so;
```

11. Also add this in http section of `/etc/nginx/nginx.conf`. Replace the `AKTO_NLB_IP`, with the one you obtained in setting up data processors.

```bash
subrequest_output_buffer_size 8k;
js_path "/etc/nginx/njs/";
js_var $responseBo "{}";
js_import main2 from api_log.js;
kafka_log_kafka_brokers "<AKTO_NLB_IP>:9092";
kafka_log_kafka_buffer_max_messages 100000;
```

12. Add this to .conf \[ You can get the path of this file in the include section of /etc/nginx/nginx.conf file ]. Make sure that the traffic here is being proxied/sent to your actual application.

```
location / {
    js_body_filter main2.to_lower_case buffer_type=buffer;
    kafka_log kafka:akto.api.logs $responseBo;
    ......
}
```

13. nginx -s reload \[ Use this command if nginx is already running, else use : systemctl start nginx ]

</details>

<details>

<summary>Amazon linux 2023</summary>

1. sudo su -
2.  To set up the yum repository for Amazon Linux 2023 for nginx, create the file named `/etc/yum.repos.d/nginx.repo` with the following content. This is needed to install `nginx` (if not present) and `nginx-module-njs`.

    ```bash
    [nginx-stable]
    name=nginx stable repo
    baseurl=http://nginx.org/packages/amzn/2023/$basearch/
    gpgcheck=1
    enabled=1
    gpgkey=https://nginx.org/keys/nginx_signing.key
    module_hotfixes=true
    priority=9

    [nginx-mainline]
    name=nginx mainline repo
    baseurl=http://nginx.org/packages/mainline/amzn/2023/$basearch/
    gpgcheck=1
    enabled=0
    gpgkey=https://nginx.org/keys/nginx_signing.key
    module_hotfixes=true
    priority=9
    ```
3. If nginx is not present install it using `yum install nginx -y` else you can skip this step.
4. Check your nginx version using `nginx -v` and download/extract the source for the same using the following commands.

```bash
wget http://nginx.org/download/nginx-{version}.tar.gz
tar -zxvf nginx-{version}.tar.gz

e.g.

wget http://nginx.org/download/nginx-1.26.0.tar.gz
tar -zxvf nginx-1.26.0.tar.gz
```

4. Install nginx-module-njs using `yum install nginx-module-njs` ( In case of any problem, please refer to the [official nginx docs to install nginx-module-njs](https://nginx.org/en/docs/njs/install.html) )
5. We will send data to Akto traffic processor using [nginx-kafka-log-module](https://github.com/kaltura/nginx-kafka-log-module). To clone it run: `git clone https://github.com/kaltura/nginx-kafka-log-module.git`
6.  We can install nginx-kafka-log-module using the steps below. For the official nginx docs to install nginx dynamic modules refer [this](https://www.f5.com/company/blog/nginx/compiling-dynamic-modules-nginx-plus.html).

    i. To set up the yum repository for Amazon Linux 2023 for confluent, create the file named `/etc/yum.repos.d/confluent.repo` with the following content.

    ```bash
    [Confluent-Clients]
    name=Confluent Clients repository
    baseurl=https://packages.confluent.io/clients/rpm/centos/9/$basearch
    gpgcheck=1
    gpgkey=https://packages.confluent.io/clients/rpm/archive.key
    enabled=1
    ```

    ii. Run the following commands:

    ```bash
    yum install librdkafka1 librdkafka-devel -y
    yum install pcre pcre-devel -y
    yum groupinstall "Development Tools" -y
    # go to nginx directory, which we downloaded in step 3
    cd nginx-1.26.0/
    ./configure --with-compat --add-dynamic-module=../nginx-kafka-log-module --with-cc-opt="-I/usr/include" --with-ld-opt="-L/usr/lib"
    make modules
    cp objs/ngx_http_kafka_log_module.so /etc/nginx/modules/
    ```
7. Add the Akto njs code to nginx njs directory using the following commands.

```bash
mkdir /etc/nginx/njs
curl -o /etc/nginx/njs/api_log.js https://raw.githubusercontent.com/akto-api-security/nginx-middleware/master/api_log.js
```

10. To configure nginx, in your nginx configuration file ( `/etc/nginx/nginx.conf` ), add the following lines to top:

```bash
load_module /etc/nginx/modules/ngx_http_js_module.so;
load_module /etc/nginx/modules/ngx_http_kafka_log_module.so;
```

11. Also add this in http section of `/etc/nginx/nginx.conf`. Replace the `AKTO_NLB_IP`, with the one you obtained in setting up data processors.

```bash
subrequest_output_buffer_size 8k;
js_path "/etc/nginx/njs/";
js_var $responseBo "{}";
js_import main2 from api_log.js;
kafka_log_kafka_brokers "<AKTO_NLB_IP>:9092";
kafka_log_kafka_buffer_max_messages 100000;
```

12. Add this to .conf \[ You can get the path of this file in the include section of /etc/nginx/nginx.conf file ]. Make sure that the traffic here is being proxied/sent to your actual application.

```
location / {
    js_body_filter main2.to_lower_case buffer_type=buffer;
    kafka_log kafka:akto.api.logs $responseBo;
    ......
}
```

13. nginx -s reload \[ Use this command if nginx is already running, else use : systemctl start nginx ]

</details>

Note: We have benchmarked an nginx server with and without akto nginx traffic module. The results for the same are as follows:

| metrics           | vanilla nginx | nginx with akto module |
| ----------------- | ------------- | ---------------------- |
| avg. cpu usage    | upto 36%      | upto 38%               |
| avg. memory usage | 0.5%          | 0.5%                   |

The server setup being used is an AWS EC2 (t3a.small: 2CPU + 2GB RAM), with around 1600-1800 requests being fired per second to the server continuously for over a minute (\~110k requests per minute). Here nginx is configured as a reverse proxy to a node.js backend server.
