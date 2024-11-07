# Add an API Collection

You can add your API collection to Akto to centralize and organize your APIs. It allows you to organize your APIs by function, making it easier to find and fix issues. It also helps keep your API security consistent and makes teamwork on APIs simpler. There are two methods to add your API collection:

* Create a New API Collection
* Create Automated Collections

### Add a New API Collection

In the demonstration below, we have illustrated the steps to create a New collection.

Go to the **API Discovery > API Collection**. Click on the **Create New API Collection** button. Enter a name for your new collection and click on the **Create** button.

{% embed url="https://demo.arcade.software/2eqG8XuT3CvB0Ow5BgSt?embed=" %}
Create a New API Collection
{% endembed %}

In the above demonstration, we have created a new API collection with the name **My New API Collection**. After creating your API collection, you can upload your API traffic data to the collection and start running API Security tests on top of your APIs.

### Create Automated Collection

Akto populates API inventory by connecting to your traffic source. This traffic source is called a traffic connector. Akto offers integration to multiple traffic connectors as discussed below.

**AWS Traffic Mirroring**

Connect Akto seamlessly with **`AWS Traffic Mirroring`** for comprehensive network visibility. Gain real-time insights into your traffic flow and enhance monitoring capabilities effortlessly. [Click here](https://docs.akto.io/traffic-connections/traffic-data-sources/amazon-aws) for detailed steps.

#### **AWS EKS**

Easily integrate Akto with **`AWS EKS`** for streamlined container orchestration. Manage and scale your containers effortlessly within the AWS Kubernetes environment. For detailed steps, [click here](https://docs.akto.io/traffic-connections/traffic-data-sources/aws-eks).

#### **AWS Fargate**

Effortlessly link Akto with **`AWS Fargate`** for seamless serverless container management. Streamline deployment and scaling of containers without managing the underlying infrastructure. For detailed steps, [click here](https://docs.akto.io/traffic-connections/traffic-data-sources/aws-fargate).

#### **AWS Beanstalk**

Connect Akto seamlessly with **`AWS Elastic Beanstalk`** for simplified application deployment and management. Easily scale and monitor your applications within the AWS environment. For more information, please refer to the [Connect Akto with AWS Beanstalk](https://docs.akto.io/traffic-connections/traffic-data-sources/aws-beanstalk) documentation.

#### **Kubernetes in AWS**

You can add Akto DaemonSet to your **`Kubernetes`** cluster. It is very lightweight and will run 1 per node in your Kubernetes cluster. It will intercept all the node traffic and send it to the Akto traffic analyzer. For detailed information, please refer to the [Connect Akto with Kubernetes in AWS](https://docs.akto.io/traffic-connections/traffic-data-sources/kubernetes) documentation.

#### **AWS API Gateway**

You can connect Akto with **`AWS API Gateway`** for automated API detection, as it simplifies the process of discovering, accessing, and integrating a wide range of APIs from AWS services. Please refer to the [Connect Akto with AWS API Gateway](https://docs.akto.io/traffic-connections/traffic-data-sources/aws-api-gateway) documentation.

#### **Kong**

You can connect Akto with **`Kong`** for automated API detection which enhances the platform's agility, accelerates API integration, improves API management, and ensures a more secure and efficient ecosystem for developers and users leveraging APIs within the Akto environment. [Click here](https://docs.akto.io/traffic-connections/traffic-data-sources/kong) for detailed steps.

#### **NGINX**

You can effortlessly connect Akto with **`NGINX`** for enhanced web server performance and reliability. Optimize traffic handling and boost your application's speed with this seamless integration. Please refer to the [Connect Akto with NGINX](https://docs.akto.io/traffic-connections/traffic-data-sources/nginx) documentation for detailed steps.

#### **Envoy**

Integrate Akto seamlessly with **`Envoy`** for advanced service mesh capabilities. Enhance traffic management and secure communication between services effortlessly. Check out the [Connect Akto with Envoy](https://docs.akto.io/traffic-connections/traffic-data-sources/envoy) documentation for detailed information.

#### **Docker**

You can effortlessly link Akto with **`Docker`** for streamlined containerization by adding the Akto-traffic-collector service to your docker-compose file. Please refer to the [Connect Akto with Docker](https://docs.akto.io/traffic-connections/traffic-data-sources/docker) documentation for detailed steps.

#### **TCP Agent**

Connect Akto seamlessly with **`TCP Agent`** for efficient TCP traffic monitoring and analysis. Enhance visibility and control over network communication effortlessly. [Click here](https://docs.akto.io/traffic-connections/traffic-data-sources/tcp-agent) for detailed steps.

#### **eBPF**

You can connect Akto with **`eBPF`** for automated API detection as it offers an immediate understanding of how APIs are used, ensures a complete list of all available APIs, boosts security, and helps Akto adjust quickly to changes in the API world. This connection makes Akto work better and more smoothly overall. [Click here](https://docs.akto.io/traffic-connections/traffic-data-sources/ebpf) for the detailed steps.

#### **GCP Packet Mirroring**

Packet Mirroring is a GCP feature that clones the traffic of specified instances in your Virtual Private Cloud (VPC) network and forwards it to Akto. Packet Mirroring captures all traffic and packet data, including payloads and headers. The capture can be configured for both egress and ingress traffic, only ingress traffic, or only egress traffic. For detailed information, [click here](https://docs.akto.io/traffic-connections/traffic-data-sources/google-cloud-gcp).
