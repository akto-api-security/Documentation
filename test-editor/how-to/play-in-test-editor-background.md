# Play in Test Editor Background

## Overview

You can run a test from the Test Editor against a selected API endpoint. Verify how the test modifies requests and evaluates responses before saving the test for execution across the API inventory.

## Steps

{% stepper %}
{% step %}
### Select a Test YAML

Select any default test of your choice and replace the 3 sections (api\_selection\_filters, execute, validate) with the above YAML text. Please refer the [Edit test](edit-test.md) section for a better understanding of how to edit a test YAML.

You can change the Test YAML. Learn [here](create-a-custom-test.md).
{% endstep %}

{% step %}
### **Select your Sample API For Testing**

Click on the API endpoint to select the API you want to check for testing the above YAML.

Select your desired API collection and then select the desired API.

Click on save. You will now see your sample API req and res in the right column.
{% endstep %}

{% step %}
### Run Test

Click on Run Test at the Top right. Selecting **Run Test** opens the **Test configuration** dialog. The dialog defines the execution context for the test.

#### Configure the Test Execution

1. Select the **API collection** that contains the endpoint used for testing.
2. Select the **API endpoint** that Akto will use to execute the test request.
3. Select the **Role** that defines the authorisation context for the request.
4. Select the **Testing Module** that executes the test request.
5.  (Optional) Enable **Use different target for testing** and provide a value in **Override test app host** when the test should run against a different host.

    <div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (2).png" alt="" width="563"><figcaption></figcaption></figure></div>
6. Select **Save** to start the test execution.
{% endstep %}

{% step %}
### Validate test results

We ran the above test and discovered the vulnerability. In the bottom-right section, you will see the text "HIGH" indicating the severity level of the vulnerability.

Click on the "**High vulnerability found**" section to view all the attempts made during the test. This will open a pop-up window that looks similar to this:

<figure><img src="../../.gitbook/assets/Untitled (13).png" alt=""><figcaption></figcaption></figure>

In this example, we requested a `limit of 100 entities` from the server, and received `34 in the response`, which is much higher than the sample call. If there were more entities, we could have fetched them all in a single call.
{% endstep %}

{% step %}
### Save your test

Click on **Save** to save your test. You can now run this test on all your APIs in the API inventory.
{% endstep %}
{% endstepper %}
