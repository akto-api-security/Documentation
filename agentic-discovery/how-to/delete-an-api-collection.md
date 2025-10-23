---
description: Learn how to delete agent and MCP collections in Akto.
hidden: true
---

# Delete an Agentic Collection

Akto allows you to delete your agent and MCP collections when needed. You can delete collections for reasons such as removing outdated collections, cleaning up after testing and development phases, or removing decommissioned agentic systems.

If you no longer need a collection or wish to remove it, you can delete the collection. Akto will then remove all associated agent components, MCP endpoints, and their data. The collection will no longer be available in the collections list.

## How to Delete a Collection

1. Navigate to **Agentic Discovery > Collections**
2. Check the collection(s) that you want to delete
3. Click on the **Remove Collections** button at the bottom
4. Confirm the deletion in the pop-up dialog

## What Gets Deleted

When you delete a collection, the following are removed:

- All agent components in the collection
- All MCP endpoints in the collection
- Associated traffic data and metadata
- Security test results and vulnerability findings
- Component usage statistics and analytics

{% hint style="warning" %}
**This action is permanent and cannot be undone.** Make sure you have exported any necessary data before deleting a collection.
{% endhint %}

## Before You Delete

Consider these steps before deleting a collection:

1. **Export Important Data**: Export security findings or component data if needed
2. **Notify Your Team**: Ensure other team members are aware of the deletion
3. **Check Dependencies**: Verify that no active security policies or alerts depend on this collection
4. **Review Alternatives**: Consider deactivating instead if you might need it again

## Alternative: Deactivate Instead

If you're unsure about permanently deleting a collection, consider deactivating it instead:

- Deactivated collections stop ingesting new data
- Historical data is retained for future reference
- Collections can be reactivated if needed later
- Useful for seasonal or intermittent agentic systems
