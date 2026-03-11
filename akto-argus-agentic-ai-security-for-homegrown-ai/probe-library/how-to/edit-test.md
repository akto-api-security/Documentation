---
description: Explore about how to edit the Akto probe.
---

# Edit Probe

If you want to make small changes in Akto Probe Library, you can use Akto’s probe editor.

Customization of probes assists in improving security coverage, adaptability to change, and incorporation of business knowledge.

In the demonstration below, let’s edit an Akto probe by selecting a pre-existing probe named **”Broken Authentication by removing auth token”** under the probe category **”Broken User Authentication (BUA).”**

Go to **Probe Editor** to edit Akto’s probe. Choose **probe collection > pre-existing probe**. Customize the **YAML file** based on your requirements, then click on **Save** to save the custom probe.

{% embed url=”https://demo.arcade.software/t1enI0PX4dxzfi9NcJvB?embed=” %}

In the demonstration above, we have selected a pre-existing probe named **”Broken Authentication by removing auth token”** under the probe category **”Broken User Authentication (BUA)”** and customized the YAML file by changing **”api\_selection\_filters”** for **”response\_code”** between 500 and 700. It will create a new probe in the list.
