---
description: Access types can be public, internal or partner.
---

# Access Type

## Access Type

Akto provides visibility into your agent components and MCP endpoints, regardless of whether they're accessed from a public network or internally. This feature enables you to monitor and ensure that internal agent components aren't exposed to the public network, thus enhancing your security measures.

Learn [here](../how-to/configure-access-types.md) how to configure Access Type CIDRs.

### Possible Access Types

1. [Public](access-type.md#what-is-public-component)
2. [Internal](access-type.md#what-is-internal-component)
3. [Partner](access-type.md#what-is-partner-component)
4. None

### How it works?

Akto uses `X-Forwarded-For` header to understand the list of IPs through which the request was routed. The evaluation rules are in the following order:

1. If any 1 IP is present which is not in `Private` or `Partner` IP list, it is marked as `Public`.
2. If any 1 IP in the header is from `Partner` and rest of the IPs are in `Private` list, it is marked as `Partner`
3. If all IPs are in `Private` IPs list, then the component is marked as `Private`
4. If header is absent, then we mark it as `None`

### What is Public Component?

Public components refer to agent endpoints or MCP servers that are exposed to the public network. These components are typically used by web interfaces, mobile apps, or external client applications. For example, a customer-facing chat agent or a public-facing AI assistant would be classified as public.

### What is Internal Component?

Internal components refer to agent components or MCP endpoints that are used strictly internally and are NOT exposed to the public network. These are typically used by other microservices and internal tools. For example, an internal RAG system or an agent that processes backend data would be classified as internal.

### What is Partner Component?

Partner components refer to agent endpoints or MCP servers that can be accessed by IPs outside your VPC, but access is limited to a specific set of IPs. For example, an agent that integrates with a third-party service (like Salesforce or Stripe) might be classified as a partner component. Companies might set up VPC peering or whitelist specific partner IPs.



### Detect Access Types

Go to **Agentic Discovery > Collections**. Select a collection and filter by Access type to view public, internal, or partner components.

You can use access type filtering to identify which agent components or MCP endpoints are exposed to the public network and require additional security controls.
