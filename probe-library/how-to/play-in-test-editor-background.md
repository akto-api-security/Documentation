# Play in Probe Editor Background

## Step 1: Select a Probe YAML

Select any default probe of your choice and replace the 3 sections (api\_selection\_filters, execute, validate) with the above YAML text. Please refer the [Edit test](edit-test.md) section for a better understanding of how to edit a probe YAML.

You can change the Probe YAML. Learn [here](create-a-custom-test.md).

## Step 2: **Select your Sample Agent Component For Testing**

Click on the agent component endpoint to select the component you want to check for testing the above YAML.

Select your desired agent collection and then select the desired component endpoint.

Click on save. You will now see your sample agent component request and response in the right column.

## Step 3: Run Probe

Click on Run Probe at the Top right.

## Step 4: Validate probe results

We ran the above probe and discovered the vulnerability. In the bottom-right section, you will see the text "HIGH" indicating the severity level of the vulnerability.

Click on the "**High vulnerability found**" section to view all the attempts made during the probe. This will open a pop-up window with details.

In this example, we requested a `limit of 100 entities` from the server, and received `34 in the response`, which is much higher than the sample call. If there were more entities, we could have fetched them all in a single call.

## Step 5: Save your probe

Click on **Save** to save your probe. You can now run this probe on all your agent components in the component inventory.
