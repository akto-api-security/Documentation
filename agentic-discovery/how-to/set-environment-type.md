# Set environment type

If you are tracking and testing multiple environments through Akto, you can mark your API collections as **Staging** or **Production**.

It will help you in triaging alerts - for example, urgency for a new Sensitive Data in `Production` vs `Staging` . Similarly, testing shouldn't be done on collections marked as `Production`.

To set environment type for an API collection, go to **API Discovery** > **API Collections**. Select any number of API Collections from the table and click on `Set env type`.

Note that collections that have the word `demo` or `staging` in them are already marked as `Staging`.

{% embed url="https://demo.arcade.software/8BoWUglWUDmOpPnSbbNG" %}

### Custom Environment Type

In addition to the default Production and Staging environments, you can set custom environment types for your API collections in Akto.&#x20;

This flexibility allows you to better organize and manage your API collections according to your specific deployment stages, testing requirements, or organizational needs. For example, you might want to create environment types like 'Development', 'QA', or 'Pre-Production' to match your workflow.

<figure><img src="../../.gitbook/assets/image (3) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
