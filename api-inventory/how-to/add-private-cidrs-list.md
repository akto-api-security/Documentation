# Add Private CIDRs list

Private CIDRs (Classless Inter-Domain Routing) in Akto are used to mark specific endpoints as PRIVATE. This feature helps in categorizing and managing your API endpoints based on their network location.

### Add a Private CIDR

{% @arcade/embed flowId="vT9yABBk15QuDEEuGeli" url="https://app.arcade.software/share/vT9yABBk15QuDEEuGeli" %}

### Managing Private CIDRs

* To remove a CIDR: Click on the "x" next to the CIDR tag you wish to remove.
* To add multiple CIDRs: Repeat the adding process for each CIDR you want to include.

### Applying Changes

After making your desired changes to the Private CIDRs list:

1. Click the "Apply" button on the right side of the Private CIDRs list section.
2. This will save your changes and update the system to recognize these CIDRs as private.

### Important Notes

* CIDRs added to this list will mark all endpoints within these IP ranges as PRIVATE in Akto.
* Ensure you enter valid CIDR notations to avoid errors.
* Common private IP ranges include:
  * 10.0.0.0/8
  * 172.16.0.0/12
  * 192.168.0.0/16

### Use Cases

* Marking internal API endpoints as private
* Distinguishing between public-facing and internal-only APIs
* Configuring security policies based on endpoint privacy

By correctly configuring your Private CIDRs list, you can better manage and secure your API ecosystem, ensuring proper categorization of your endpoints based on their network location.
