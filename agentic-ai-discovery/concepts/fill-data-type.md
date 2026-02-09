# Fill Data Type

## Overview

The **Fill Data Types** capability allows you to synchronise your Akto instance with the latest sensitive data type definitions maintained by Akto. This synchronisation helps your sensitive data detection stay aligned with evolving data formats, regulatory requirements, and industry patterns without affecting local customisations.

## Akto Behaviour When Fill Data Types Runs

When you trigger **Fill Data Types**, Akto performs a controlled synchronisation with its maintained data type repositories.

The synchronisation process performs the following actions:

* Downloads the latest sensitive data type definitions curated by Akto
* Creates new data types that are not present in your instance
* Updates Akto managed data types that have not been customised
* Preserves all user-defined configurations and overrides

The synchronisation process runs in the background and does not interrupt active scans or traffic processing.

## Scenarios Where Fill Data Types Adds Value

### Recommended Usage Scenarios

Using **Fill Data Types** is useful in the following situations:

* During initial Akto setup to populate a complete baseline of sensitive data types
* After Akto releases updates containing new or improved detection patterns
* When certain sensitive fields are not being detected as expected
* As part of a quarterly maintenance cycle to refresh detection coverage

### Scenarios Where Fill Data Types Is Not Required

Running **Fill Data Types** is usually unnecessary when:

* All required data types are already present and current
* Your organization relies exclusively on fully custom data types
* You are actively editing detection patterns and want to avoid interim updates

## Steps to Run Fill Data Types

You can run the synchronization directly from the Akto dashboard:

{% stepper %}
{% step %}
Navigate to **Agentic AI Discovery → Sensitive Data**
{% endstep %}

{% step %}
Select **Fill Data Types** from the top-right corner of the page

<figure><img src="../../.gitbook/assets/image (8).png" alt="" width="563"><figcaption></figcaption></figure>
{% endstep %}

{% step %}
Allow the background sync process to complete
{% endstep %}

{% step %}
Refresh the page to view updated and newly added data types
{% endstep %}
{% endstepper %}

{% hint style="info" %}
### Operational Characteristics and Performance

The **Fill Data Types** operation has minimal operational impact:

* Runs asynchronously in the background
* Typically completes within 10–30 seconds
* Does not pause or restart running scans
* Safe to execute during normal production usage
{% endhint %}

## Troubleshooting Common Issues

{% tabs %}
{% tab title="Fill Data Types Action Does Not Complete" %}
Possible causes and checks include:

* Network connectivity restrictions preventing repository access
* Insufficient user permissions within Akto
* Browser-side errors visible in developer console logs
{% endtab %}

{% tab title="Expected Data Types Are Not Visible" %}
If certain data types do not appear after synchronization:

* Re-run **Fill Data Types** to recover from an incomplete sync
* Verify the data types are marked active in Akto-maintained sources
* Contact Akto support when required data types remain unavailable
{% endtab %}
{% endtabs %}

## Recommended Operational Practices

You may improve long-term accuracy and governance by following these practices:

* Run **Fill Data Types** quarterly or after major Akto releases
* Review newly added data types and adjust priorities as needed
* Validate detection behaviour with a targeted test scan after updates
* Maintain internal documentation for any custom data types

## Support and Additional Resources

* Learn about [Sensitive Data Concepts](sensitive-data.md)
* [Akto Support](../../troubleshooting/support.md): Contact the Akto support team through official channels
