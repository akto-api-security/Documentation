# Play in Editor Background

## Overview

You can run a probe from the editor against a selected agentic component. Verify how the probe modifies requests and evaluates responses before saving the scan for execution across the agentic inventory.

## Steps

{% stepper %}
{% step %}
### Select a Probe YAML

Select any default probe of your choice and replace the 3 sections (api\_selection\_filters, execute, validate) with the above YAML text. Please refer the [edit-test.md](edit-test.md "mention") section for a better understanding of how to edit a probe YAML. (Note: link refers to the Probe Editor page)

You can change the Probe YAML. [Learn here](../concepts/template-yamls/).
{% endstep %}

{% step %}
### **Select your Sample Agent Component For Probing**

Click on the agent component endpoint to select the component you want to check for probing the above YAML.

Select your desired agent collection and then select the desired component endpoint.

Click on save. You will now see your sample agent component request and response in the right column.
{% endstep %}

{% step %}
### Run Probe

Click on Run Probe at the Top right.

Selecting **Run Probe** opens the **Probe configuration** dialog. The dialog defines the execution context for the probe.

#### Configure the Probe Execution

1. Select the **Agentic collection** that contains the endpoint used for probing.
2. Select the **Agentic Component** that Akto will use to execute the probe request.
3. Select the **Role** that defines the authorisation context for the request.
4. Select the **Probing Module** that executes the probe request.
5.  (Optional) Enable **Use different target for scanning** and provide a value in **Override probe app host** when the probe should run against a different host.

    <div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (146).png" alt="" width="563"><figcaption></figcaption></figure></div>
6. Select **Save** to start the probe execution.
{% endstep %}

{% step %}
### Validate probe results

We ran the above probe and discovered the vulnerability. In the bottom-right section, you will see the text "HIGH" indicating the severity level of the vulnerability.

Click on the "**High vulnerability found**" section to view all the attempts made during the probe. This will open a pop-up window with details.

In this example, we requested a `limit of 100 entities` from the server, and received `34 in the response`, which is much higher than the sample call. If there were more entities, we could have fetched them all in a single call.
{% endstep %}

{% step %}
### Save your probe

Click on **Save** to save your probe. You can now run this probe on all your agent components in the component inventory.
{% endstep %}
{% endstepper %}
