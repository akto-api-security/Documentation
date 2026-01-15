# Add Private CIDRs list

Private CIDRs (Classless Inter-Domain Routing) in Akto are used to mark specific agent components and MCP endpoints as PRIVATE. This feature helps in categorizing and managing your components based on their network location.

### Add a Private CIDR

Go to **Settings > Access Types** to add private CIDRs.

### Managing Private CIDRs

* To remove a CIDR: Click on the "x" next to the CIDR tag you wish to remove.
* To add multiple CIDRs: Repeat the adding process for each CIDR you want to include.

### Applying Changes

After making your desired changes to the Private CIDRs list:

1. Click the "Apply" button on the right side of the Private CIDRs list section.
2. This will save your changes and update the system to recognize these CIDRs as private.

### Important Notes

* CIDRs added to this list will mark all components within these IP ranges as PRIVATE in Akto.
* Ensure you enter valid CIDR notations to avoid errors.
* Common private IP ranges include:
  * 10.0.0.0/8
  * 172.16.0.0/12
  * 192.168.0.0/16

### Use Cases

* Marking internal agent components as private
* Distinguishing between public-facing and internal-only components
* Configuring security policies based on component privacy

By correctly configuring your Private CIDRs list, you can better manage and secure your agentic system, ensuring proper categorization of your components based on their network location.
