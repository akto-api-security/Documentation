# Traffic Data Sources



### Kubernetes

<table data-view="cards"><thead><tr><th></th><th></th><th></th><th data-hidden data-card-cover data-type="files"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody>


<tr><td><strong>![](https://app.akto.io/public/kubernetes.svg) Kubernetes Daemonset
</strong></td><td></td><td>
You can deploy Akto in Kubernetes and collect traffic through a daemonset on your Kubernetes configuration.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/openshift.svg) OpenShift
</strong></td><td></td><td>
OpenShift should be used as a traffic connector if you are deploying and managing containerized applications using OpenShift.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/ebpf.svg) eBPF
</strong></td><td></td><td>
Akto-eBPF setup is recommended for mTLS systems when TLS termination happens at a proxy.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/ebpf.svg) eBPF on mTLS
</strong></td><td></td><td>
Akto-eBPF-mTLS setup is recommended for mTLS systems where TLS termination occurs at the application.</td></tr>


</tbody></table>

### API Gateways

<table data-view="cards"><thead><tr><th></th><th></th><th></th><th data-hidden data-card-cover data-type="files"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody>


<tr><td><strong>![](https://app.akto.io/public/apigee.svg) Apigee
</strong></td><td></td><td>
Apigee setup is recommended if you are using Google's Apigee API Management platform to design, secure, and scale your APIs.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/azure.svg) Azure API Gateway
</strong></td><td></td><td>
Azure API Gateway setup is recommended if you are using Azure's API Management service to manage, secure, and analyze your APIs.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/cloudflare.svg) Cloudflare
</strong></td><td></td><td>
You should use Cloudflare as a traffic connector if you are leveraging Cloudflare's CDN and security features to manage and optimize your API traffic.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/f5.svg) F5
</strong></td><td></td><td>
F5 setup is recommended if you are using F5's BIG-IP as an API gateway or load balancer to manage and control your API traffic.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/kongmesh.svg)

Kong Mesh
</strong></td><td></td><td>
Use this set-up if you are utilizing Kong's service mesh capabilities to manage and secure your microservices and APIs.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/layer7.svg)

Layer 7
</strong></td><td></td><td>
Layer7 is recommended if you are using CA Technologies' Layer7 API Management for securing and managing your APIs.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/threescale.svg)

3Scale
</strong></td><td></td><td>
This setup is recommended if your APIs are managed by 3scale.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/Nginx.svg)

NGINX
</strong></td><td></td><td>
This setup is recommended if your APIs are routed by NGINX.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/haproxy.svg)

HA Proxy
</strong></td><td></td><td>
HA Proxy should be used as a traffic connector if you are leveraging HA Proxy for load balancing, high availability, and proxying HTTP and TCP-based applications.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/envoy.svg)

Envoy
</strong></td><td></td><td>
Akto-Envoy setup is recommended if your APIs are routed by Envoy.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/istio.svg)

Istio
</strong></td><td></td><td>
Akto-Istio setup is recommended if your APIs are routed by Istio.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/kong.svg)

Kong
</strong></td><td></td><td>
Kong Gateway is an open source API gateway, built for multi-cloud and hybrid, and optimized for microservices and distributed architectures.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/ibmapiconnect.svg)

IBM API Connect
</strong></td><td></td><td>
This setup is recommended if your APIs are managed by IBM API Connect.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/citrix.svg)

Citrix
</strong></td><td></td><td>
Citrix setup is recommended if you are using ADC (NetScaler) to manage, secure, and optimize your API traffic.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/azureappservice.svg)

Azure App Services
</strong></td><td></td><td>
Azure App Services setup is recommended if you are using Microsoft's web app service with sidecar containers to collect and analyze your API traffic.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/mulesoft.svg)

MuleSoft
</strong></td><td></td><td>
Mulesoft setup is recommended if you are using API management and ESB capabilities to manage, secure, and analyze your APIs.</td></tr>


</tbody></table>

### Mirroring

<table data-view="cards"><thead><tr><th></th><th></th><th></th><th data-hidden data-card-cover data-type="files"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody>


<tr><td><strong>![](https://app.akto.io/public/aws.svg)

AWS Mirroring
</strong></td><td></td><td>
You can deploy Akto in AWS and collect traffic through traffic mirroring.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/gcp.svg)

GCP Mirroring
</strong></td><td></td><td>
This setup only takes ten minutes. Once you connect GCP, Akto will process GCP traffic to create an API Inventory in real time.</td></tr>


</tbody></table>

### AWS Services

<table data-view="cards"><thead><tr><th></th><th></th><th></th><th data-hidden data-card-cover data-type="files"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody>


<tr><td><strong>![](https://app.akto.io/public/aws\_api\_gateway.svg)

AWS API Gateway
</strong></td><td></td><td>
Akto-AWS-API-Gateway setup is recommended if you are using AWS API Gateway.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/eks.svg)

AWS EKS
</strong></td><td></td><td>
You can deploy Akto in AWS and collect traffic through a daemonset on your AWS EKS configuration.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/fargate.svg)

AWS Fargate
</strong></td><td></td><td>
AWS Fargate allows you to use Amazon ECS to run containers without having to manage servers or clusters of Amazon EC2 instances.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/beanstalk.svg)

AWS Beanstalk
</strong></td><td></td><td>
You can deploy Akto in AWS and collect traffic through mirroring on your AWS Beanstalk setup.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/ecs.svg)

AWS ECS
</strong></td><td></td><td>
You can deploy Akto in AWS and collect traffic through containers on your AWS ECS cluster.</td></tr>


</tbody></table>

### Manual

<table data-view="cards"><thead><tr><th></th><th></th><th></th><th data-hidden data-card-cover data-type="files"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody>


<tr><td><strong>![](https://app.akto.io/public/burp.svg)

Burp Suite
</strong></td><td></td><td>
You can deploy Akto on your machine and download Akto's Burp extension to collect API traffic.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/postman.svg)

Postman
</strong></td><td></td><td>
This setup is recommended if you have updated API collections maintained in Postman.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/HAR.svg)

Har File Upload
</strong></td><td></td><td>
For a very quick view of your inventory, you can upload a HAR file that contains traffic to Akto.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/openApi.svg)

OpenAPI
</strong></td><td></td><td>
Upload Open API/Swagger specification file to Akto to create an API inventory.</td></tr>


</tbody></table>

### Akto SDK

<table data-view="cards"><thead><tr><th></th><th></th><th></th><th data-hidden data-card-cover data-type="files"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody>


<tr><td><strong>![](https://app.akto.io/public/go.svg)

Go
</strong></td><td></td><td>
Use where Go-based services are deployed.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/java.svg)

Java
</strong></td><td></td><td>
You can use Akto's Java agent to capture API traffic directly from your Java applications.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/nodejs.svg)

NodeJS
</strong></td><td></td><td>
This setup is ideal for environments where NodeJS-based services are deployed, ensuring seamless integration and real-time traffic monitoring.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/python.svg)

Python
</strong></td><td></td><td>
Use where Python-based services are deployed.</td></tr>


</tbody></table>

### Virtual Machines

<table data-view="cards"><thead><tr><th></th><th></th><th></th><th data-hidden data-card-cover data-type="files"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody>


<tr><td><strong>![](https://app.akto.io/public/docker.svg)

Docker
</strong></td><td></td><td>
This setup is recommended only if other setups for AWS or GCP don't work.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/TCP.svg)

TCP Agent
</strong></td><td></td><td>
This setup is recommended only if other setups for AWS or GCP do not work.</td></tr>


</tbody></table>

### Source Code

<table data-view="cards"><thead><tr><th></th><th></th><th></th><th data-hidden data-card-cover data-type="files"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody>


<tr><td><strong>![](https://app.akto.io/public/favicon.svg)

API inventory from source code
</strong></td><td></td><td>
Create API inventory from your source code using our code analysis tool.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/github.svg)

GitHub
</strong></td><td></td><td>
We recommend setting up GitHub if you want to connect and retrieve APIs directly from your source code hosted on GitHub.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/gitlab.svg)

GitLab
</strong></td><td></td><td>
We recommend setting up GitLab if you want to connect and retrieve APIs directly from your source code hosted on GitLab.</td></tr>



<tr><td><strong>![](https://app.akto.io/public/bitbucket.svg)

Bitbucket
</strong></td><td></td><td>
We recommend setting up Bitbucket if you want to connect and retrieve APIs directly from your source code hosted on Bitbucket.</td></tr>

