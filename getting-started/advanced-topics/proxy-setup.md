# Setting up proxy on Akto

[Akto](https://www.akto.io/) deploys multiple services in your cloud, which primarily include a dashboard, a traffic processing module and a testing module. These modules need internet access. In case, the cluster/VPC in which Akto is deployed, doesn't have internet connectivity, you can configure a proxy as follows to provide internet connectivity to Akto modules.

## Configure the given environment variables to setup proxy

1. `PROXY_URI`

This is the URI of your internet proxy. All requests (HTTP/HTTPS) will be proxied through this URI. You can take reference from the below examples to configure it properly. 

```bash
PROXY_URI=192.168.0.0 // if no protocol is mentioned, we assume the protocol to be HTTP
PROXY_URI=http://192.168.0.0
PROXY_URI=https://192.168.0.0
PROXY_URI=http://192.168.0.0:9000
PROXY_URI=https://192.168.0.0:444
PROXY_URI=http://user:password@192.168.0.0 // example for authenticated proxy. By default, the proxy is assumed to be unauthenticated
PROXY_URI=user:password@192.168.0.0
PROXY_URI=user:password@192.168.0.0:9000
PROXY_URI=http://user:password@192.168.0.0:9000
PROXY_URI=https://user:password@192.168.0.0:5000
```

2. `NO_PROXY`

This is a comma separated list of IP/URLs which you do want to be proxied. This may include localhost/127.0.0.1 , internal IPs or any other URL. You can take reference from the below examples to configure it properly.

```bash
NO_PROXY=127.0.0.1
NO_PROXY=127.0.0.1,localhost
NO_PROXY=127.0.0.1, localhost, 192.168.0.0
NO_PROXY=127.0.0.1,localhost,192.168.0.0,example.com
NO_PROXY=127.0.0.1, localhost, 192.168.0.0/20, example.com
```

## Frequently Asked Questions (FAQs)

**The requests are not being proxied through the given proxy**

Please check the protocol and port for the proxy you've configured. In case this doesn't help, please reach out to use at `support@akto.io`.

**I don't see my error on this list here.**

Please send us all details at `support@akto.io` or reach out via Intercom on your Akto dashboard. We will definitely help you out.

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).