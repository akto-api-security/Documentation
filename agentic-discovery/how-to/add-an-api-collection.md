---
description: >-
  Learn how to add agent and MCP collections to Akto for centralized agentic
  security management.
---

# Create Collection

You can add your agent and MCP collections to Akto to centralize and organize your agentic components. It allows you to organize your AI agents and MCP servers by function, making it easier to discover, monitor, and secure them. This helps maintain consistent security across your agentic systems and simplifies team collaboration. There are two methods to add your collections:

* Create a New Collection Manually
* Create Automated Collections via Traffic Connectors

## Add a New Collection Manually

You can create a new empty collection and then populate it with agent components.

### How to Create a New Collection

1. Navigate to **Agentic Discovery > Collections**
2. Click on the **Create New Collection** button
3. Enter a name for your new collection (e.g., "Production AI Agents", "MCP Servers - Customer Service")
4. Select the collection type (Agent Collection or MCP Collection)
5. Click on the **Create** button

After creating your collection, you can start monitoring agent traffic and running Agentic Security tests on your AI agents and MCP components.

## Create Automated Collection

Akto automatically populates your agentic inventory by connecting to your traffic sources. This traffic source is called a traffic connector. Akto offers integration to multiple traffic connectors for capturing agentic system traffic.

### Supported Traffic Connectors

#### **AWS Traffic Mirroring**

Connect Akto seamlessly with **AWS Traffic Mirroring** for comprehensive network visibility of your agentic systems. Gain real-time insights into AI agent traffic flow and enhance monitoring capabilities effortlessly. [Click here](https://docs.akto.io/traffic-connections/traffic-data-sources/amazon-aws) for detailed steps.

#### **AWS EKS**

Easily integrate Akto with **AWS EKS** for streamlined container orchestration. Manage and scale your containerized AI agents effortlessly within the AWS Kubernetes environment. For detailed steps, [click here](https://docs.akto.io/traffic-connections/traffic-data-sources/aws-eks).

#### **AWS Fargate**

Effortlessly link Akto with **AWS Fargate** for seamless serverless container management. Streamline deployment and scaling of agent containers without managing the underlying infrastructure. For detailed steps, [click here](https://docs.akto.io/traffic-connections/traffic-data-sources/aws-fargate).

#### **AWS Beanstalk**

Connect Akto seamlessly with **AWS Elastic Beanstalk** for simplified agentic application deployment and management. Easily scale and monitor your AI agents within the AWS environment. For more information, please refer to the [Connect Akto with AWS Beanstalk](https://docs.akto.io/traffic-connections/traffic-data-sources/aws-beanstalk) documentation.

#### **Kubernetes in AWS**

You can add Akto DaemonSet to your **Kubernetes** cluster. It is very lightweight and will run 1 per node in your Kubernetes cluster. It will intercept all the node traffic (including agentic traffic) and send it to the Akto traffic analyzer. For detailed information, please refer to the [Connect Akto with Kubernetes in AWS](https://docs.akto.io/traffic-connections/traffic-data-sources/kubernetes) documentation.

#### **AWS API Gateway**

You can connect Akto with **AWS API Gateway** for automated agent component detection, as it simplifies the process of discovering, accessing, and integrating a wide range of agent endpoints and MCP servers. Please refer to the [Connect Akto with AWS API Gateway](https://docs.akto.io/traffic-connections/traffic-data-sources/aws-api-gateway) documentation.

#### **Kong**

You can connect Akto with **Kong** for automated agent detection which enhances the platform's agility, accelerates integration, improves management, and ensures a more secure and efficient ecosystem for developers leveraging agentic systems. [Click here](../../akto-argus-agentic-ai-security-for-homegrown-ai/homegrown-discovery-agents/api-gateways/connect-akto-with-kong.md) for detailed steps.

#### **NGINX**

You can effortlessly connect Akto with **NGINX** for enhanced web server performance and reliability. Optimize traffic handling for your agentic systems and boost your application's speed with this seamless integration. Please refer to the [Connect Akto with NGINX](https://docs.akto.io/traffic-connections/traffic-data-sources/nginx) documentation for detailed steps.

#### **Envoy**

Integrate Akto seamlessly with **Envoy** for advanced service mesh capabilities. Enhance traffic management and secure communication between agentic services effortlessly. Check out the [Connect Akto with Envoy](https://docs.akto.io/traffic-connections/traffic-data-sources/envoy) documentation for detailed information.

#### **Docker**

You can effortlessly link Akto with **Docker** for streamlined containerization by adding the Akto-traffic-collector service to your docker-compose file. Perfect for monitoring containerized AI agents. Please refer to the [Connect Akto with Docker](https://docs.akto.io/traffic-connections/traffic-data-sources/docker) documentation for detailed steps.

#### **TCP Agent**

Connect Akto seamlessly with **TCP Agent** for efficient TCP traffic monitoring and analysis. Enhance visibility and control over agentic network communication effortlessly. [Click here](https://docs.akto.io/traffic-connections/traffic-data-sources/tcp-agent) for detailed steps.

#### **eBPF**

You can connect Akto with **eBPF** for automated agent detection as it offers an immediate understanding of how AI agents are used, ensures a complete list of all available agent components, boosts security, and helps Akto adjust quickly to changes in your agentic ecosystem. This connection makes Akto work better and more smoothly overall. [Click here](https://docs.akto.io/traffic-connections/traffic-data-sources/ebpf) for the detailed steps.

#### **GCP Packet Mirroring**

Packet Mirroring is a GCP feature that clones the traffic of specified instances in your Virtual Private Cloud (VPC) network and forwards it to Akto. Packet Mirroring captures all agentic traffic and packet data, including payloads and headers. The capture can be configured for both egress and ingress traffic. For detailed information, [click here](https://docs.akto.io/traffic-connections/traffic-data-sources/google-cloud-gcp).

## Best Practices

* Organize collections by environment (production, staging, development)
* Separate agent collections from MCP collections for clarity
* Use descriptive names that reflect the collection's purpose
* Regularly review and update collection memberships
* Monitor collection growth to identify new agent components
