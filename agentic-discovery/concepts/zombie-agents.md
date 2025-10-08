# Zombie APIs

### **Akto can detect and alert about Zombie APIs**

Zombie APIs are APIs that were once in use but are now outdated, deprecated, or no longer intended to be used — yet remain accessible within the system. These stale APIs may be overlooked during regular maintenance but can still expose sensitive data or functionality to attackers.

For example, an older API endpoint used during a previous product release might still be running (`/v1/legacy-endpoint`) even after the product has migrated to newer endpoints (`/v3/`). If this endpoint isn’t properly decommissioned, it becomes a Zombie API.

Zombie APIs are dangerous because they:

* Often lack current security protections
* Are forgotten in documentation and audits
* Provide attackers with an unmonitored entry point

Since these endpoints are not in active use or visible to developers, they can easily go undetected while remaining exposed.

***

### Detect Zombie APIs

Akto automatically flags outdated and unused APIs by identifying those with little or no traffic over a significant period — marking them as **Zombie APIs**.

You can monitor and test your API collection for these stale endpoints using Akto’s built-in logic under the **Zombie API** tag. This uses behavioral analysis and endpoint activity tracking to highlight potential zombie endpoints.

<figure><img src="../../.gitbook/assets/image (107).png" alt=""><figcaption></figcaption></figure>
