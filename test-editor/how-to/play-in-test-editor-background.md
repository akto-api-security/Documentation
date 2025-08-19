# Play in Test Editor Background

## Step 1: Select a Test YAML

Select any default test of your choice and replace the 3 sections (api\_selection\_filters, execute, validate) with the above YAML text. Please refer the [Edit test](edit-test.md) section for a better understanding of how to edit a test YAML.

You can change the Test YAML. Learn [here](create-a-custom-test.md).

## Step 2: **Select your Sample API For Testing**

Click on the API endpoint to select the API you want to check for testing the above YAML.

<figure><img src="../../.gitbook/assets/image (5) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

Select your desired API collection and then select the desired API.

Click on save. You will now see your sample API req and res in the right column.

<figure><img src="../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

## Step 3: Run Test

Click on Run Test at the Top right.

## Step 4: Validate test results

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

We ran the above test and discovered the vulnerability. In the bottom-right section, you will see the text "HIGH" indicating the severity level of the vulnerability.

Click on the "**High vulnerability found**" section to view all the attempts made during the test. This will open a pop-up window that looks similar to this:

<figure><img src="../../.gitbook/assets/Untitled (13).png" alt=""><figcaption></figcaption></figure>

In this example,t we requested a `limit of 100 entities` from the server, and received `34 in the response`, which is much higher than the sample call. If there were more entities, we could have fetched them all in a single call.

## Step 5: Save your test

Click on **Save** to save your test. You can now run this test on all your APIs in the API inventory.
