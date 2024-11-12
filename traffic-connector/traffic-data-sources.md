# Traffic Data Sources

<table data-view="cards"><thead><tr><th></th><th></th><th></th><th data-hidden data-card-cover data-type="files"></th></tr></thead><tbody><tr><td><strong>Kubernetes Daemonset</strong></td><td></td><td>You can deploy Akto in Kubernetes and collect traffic through a daemonset on your Kubernetes configuration.</td><td><a href="../.gitbook/assets/image (50).png">image (50).png</a></td></tr><tr><td></td><td></td><td></td><td></td></tr><tr><td></td><td></td><td></td><td></td></tr></tbody></table>



### Kubernetes

![](https://app.akto.io/public/kubernetes.svg) **Kubernetes Daemonset**

You can deploy Akto in Kubernetes and collect traffic through a daemonset on your Kubernetes configuration.



![](https://app.akto.io/public/openshift.svg) **OpenShift**

OpenShift should be used as a traffic connector if you are deploying and managing containerized applications using OpenShift.



![](https://app.akto.io/public/ebpf.svg) **eBPF**

Akto-eBPF setup is recommended for mTLS systems when TLS termination happens at a proxy.



![](https://app.akto.io/public/ebpf.svg) **eBPF on mTLS**

Akto-eBPF-mTLS setup is recommended for mTLS systems where TLS termination occurs at the application.



### API Gateways

***

![](https://app.akto.io/public/apigee.svg) **Apigee**

Apigee setup is recommended if you are using Google's Apigee API Management platform to design, secure, and scale your APIs.



![](https://app.akto.io/public/azure.svg) **Azure API Gateway**

Azure API Gateway setup is recommended if you are using Azure's API Management service to manage, secure, and analyze your APIs.



![](https://app.akto.io/public/cloudflare.svg) **Cloudflare**

You should use Cloudflare as a traffic connector if you are leveraging Cloudflare's CDN and security features to manage and optimize your API traffic.



![](https://app.akto.io/public/f5.svg) **F5**

F5 setup is recommended if you are using F5's BIG-IP as an API gateway or load balancer to manage and control your API traffic.



![](https://app.akto.io/public/kongmesh.svg)

**Kong Mesh**

Use this set-up if you are utilizing Kong's service mesh capabilities to manage and secure your microservices and APIs.



![](https://app.akto.io/public/layer7.svg)

**Layer 7**

Layer7 is recommended if you are using CA Technologies' Layer7 API Management for securing and managing your APIs.



![](https://app.akto.io/public/threescale.svg)

**3Scale**

This setup is recommended if your APIs are managed by 3scale.



![](https://app.akto.io/public/Nginx.svg)

**NGINX**

This setup is recommended if your APIs are routed by NGINX.



![](https://app.akto.io/public/haproxy.svg)

**HA Proxy**

HA Proxy should be used as a traffic connector if you are leveraging HA Proxy for load balancing, high availability, and proxying HTTP and TCP-based applications.



![](https://app.akto.io/public/envoy.svg)

**Envoy**

Akto-Envoy setup is recommended if your APIs are routed by Envoy.



![](https://app.akto.io/public/istio.svg)

**Istio**

Akto-Istio setup is recommended if your APIs are routed by Istio.



![](https://app.akto.io/public/kong.svg)

**Kong**

Kong Gateway is an open source API gateway, built for multi-cloud and hybrid, and optimized for microservices and distributed architectures.



![](https://app.akto.io/public/ibmapiconnect.svg)

**IBM API Connect**

This setup is recommended if your APIs are managed by IBM API Connect



![](https://app.akto.io/public/citrix.svg)

**Citrix**

Citrix setup is recommended if you are using ADC (NetScaler) to manage, secure, and optimize your API traffic.



![](https://app.akto.io/public/azureappservice.svg)

**Azure App Services**

Azure App Services setup is recommended if you are using Microsoft's web app service with sidecar containers to collect and analyze your API traffic.



![](https://app.akto.io/public/mulesoft.svg)

**MuleSoft**

Mulesoft setup is recommended if you are using API management and ESB capabilities to manage, secure, and analyze your APIs.



### Mirroring

***

![](https://app.akto.io/public/aws.svg)

**AWS Mirroring**

You can deploy Akto in AWS and collect traffic through traffic mirroring.



![](https://app.akto.io/public/gcp.svg)

**GCP Mirroring**

This setup only takes ten minutes. Once you connect GCP, Akto will process GCP traffic to create an API Inventory in real time.



### AWS Services

***

![](https://app.akto.io/public/aws\_api\_gateway.svg)

**AWS API Gateway**

Akto-AWS-API-Gateway setup is recommended if you are using AWS API Gateway.



![](https://app.akto.io/public/eks.svg)

**AWS EKS**

You can deploy Akto in AWS and collect traffic through a daemonset on your AWS EKS configuration.



![](https://app.akto.io/public/fargate.svg)

**AWS Fargate**

AWS Fargate allows you to use Amazon ECS to run containers without having to manage servers or clusters of Amazon EC2 instances.



![](https://app.akto.io/public/beanstalk.svg)

**AWS Beanstalk**

You can deploy Akto in AWS and collect traffic through mirroring on your AWS Beanstalk setup.



![](https://app.akto.io/public/ecs.svg)

**AWS ECS**

You can deploy Akto in AWS and collect traffic through containers on your AWS ECS cluster.



### Manual

***

![](https://app.akto.io/public/burp.svg)

**Burp Suite**

You can deploy Akto on your machine and download Akto's Burp extension to collect API traffic.



![](https://app.akto.io/public/postman.svg)

**Postman**

This setup is recommended if you have updated API collections maintained in Postman.



![](https://app.akto.io/public/HAR.svg)

**Har File Upload**

For a very quick view of your inventory, you can upload a HAR file that contains traffic to Akto.



![](https://app.akto.io/public/openApi.svg)

**OpenAPI**

Upload Open API/Swagger specification file to Akto to create an API inventory.



### Akto SDK

***

![](https://app.akto.io/public/go.svg)

**Go**

Use where Go-based services are deployed.



![](https://app.akto.io/public/java.svg)

**Java**

You can use Akto's Java agent to capture API traffic directly from your Java applications.



![](https://app.akto.io/public/nodejs.svg)

**NodeJS**

This setup is ideal for environments where NodeJS-based services are deployed, ensuring seamless integration and real-time traffic monitoring.



![](https://app.akto.io/public/python.svg)

**Python**

Use where Python-based services are deployed.



### Virtual Machines

***

![](https://app.akto.io/public/docker.svg)

**Docker**

This setup is recommended only if other setups for AWS or GCP don't work.



![](https://app.akto.io/public/TCP.svg)

**TCP Agent**

This setup is recommended only if other setups for AWS or GCP do not work.



### Source Code

***

![](https://app.akto.io/public/favicon.svg)

**API inventory from source code**

Create API inventory from your source code using our code analysis tool.



![](https://app.akto.io/public/github.svg)

**GitHub**

We recommend setting up GitHub if you want to connect and retrieve APIs directly from your source code hosted on GitHub.



![](https://app.akto.io/public/gitlab.svg)

**GitLab**

We recommend setting up GitLab if you want to connect and retrieve APIs directly from your source code hosted on GitLab.



![](https://app.akto.io/public/bitbucket.svg)

**Bitbucket**

We recommend setting up Bitbucket if you want to connect and retrieve APIs directly from your source code hosted on Bitbucket.

