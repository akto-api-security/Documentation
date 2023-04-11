# AktoGPT

Harness the power of ChatGPT for API Security on your fingertips now! Akto integrates with ChatGPT to bring you insights from the most powerful bot.

### Data concerns

Here is how and what of your data -

1. No data is sent out unless you click on the Send button [![Screenshot 2023-04-09 at 10 54 33 PM](https://user-images.githubusercontent.com/91221068/230789406-c1e898ab-52e1-45b2-b3b8-d4810e6d78ae.png)](https://user-images.githubusercontent.com/91221068/230789406-c1e898ab-52e1-45b2-b3b8-d4810e6d78ae.png)
2. Your Login email is sent with every request to AktoGPT
3. For Auto-group APIs and Filter APIs, a list of the API endpoint URLs is sent to Akto backend
4. For detecting Sensitive and PII data, request and response payload under the _Values_ tab is sent to Akto backend
5. Akto retains only your email id. All the data is sent to ChatGPT in form of a prompt
6. Akto discards the data after the response is returned irrespective of success or failure

### How to use it?

You will find **Ask AktoGPT** button on the dashboard at the top right. Currently, only a few pages have support for it. We will be extending the support to remaining pages as well soon.

#### Auto-group APIs

You can use AktoGPT to automatically group APIs based on their functionality. Follow these steps

1.  Open any API collection and click on the **AktoGPT** button on the screen&#x20;

    <figure><img src="https://user-images.githubusercontent.com/91221068/230788491-239a8200-fb3b-4392-ad3f-2bb4dcd76bab.png" alt=""><figcaption></figcaption></figure>
2.  From the list of prompts, select **Create API groups**&#x20;

    <figure><img src="https://user-images.githubusercontent.com/91221068/230788500-ef8f768d-7c5d-4284-96c4-d0148dfd457f.png" alt=""><figcaption></figcaption></figure>
3.  Click on the Send button to the right of the prompt&#x20;

    <figure><img src="https://user-images.githubusercontent.com/91221068/230788506-2333edbc-2319-4f7a-a338-85d10d99cfdb.png" alt=""><figcaption></figcaption></figure>
4.  It should now classify all the APIs on the screen in multiple groups&#x20;

    <figure><img src="https://user-images.githubusercontent.com/91221068/230788537-8f50238f-1d42-46e0-b6a2-782201495ae0.png" alt=""><figcaption></figcaption></figure>

#### Filter APIs

You can use AktoGPT to automatically filter APIs based on a search phrase. Follow these steps

1.  Open any API collection and click on the **AktoGPT** button on the screen&#x20;

    <figure><img src="https://user-images.githubusercontent.com/91221068/230788491-239a8200-fb3b-4392-ad3f-2bb4dcd76bab.png" alt=""><figcaption></figcaption></figure>
2.  From the list of prompts, select **Tell me APIs related to**&#x20;

    <figure><img src="https://user-images.githubusercontent.com/91221068/230788923-a947dbb5-b758-47df-898b-9eb117c86ae3.png" alt=""><figcaption></figcaption></figure>
3.  Type a search phrase and click on the Send button to the right of the prompt&#x20;

    <figure><img src="https://user-images.githubusercontent.com/91221068/230788833-00aa65e2-2d4a-4124-bad0-0643c65ceb3d.png" alt=""><figcaption></figcaption></figure>
4.  It should now show only APIs related to the search phrase&#x20;

    <figure><img src="https://user-images.githubusercontent.com/91221068/230788838-577f53fa-aa04-41a1-a5d8-c09116139bd4.png" alt=""><figcaption></figcaption></figure>

#### Sensitive and PII data

You can use AktoGPT to look for any sensitive or PII parameters in the API payload. Follow these steps -

1.  Open any API and click on the **AktoGPT** button on the screen

    <figure><img src="https://user-images.githubusercontent.com/91221068/230789179-8f0ef41b-d653-4fcf-8d52-016fdec2c71b.png" alt=""><figcaption></figcaption></figure>
2.  Select the **Fetch sensitive params** prompt

    <figure><img src="https://user-images.githubusercontent.com/91221068/230789205-5861ce8c-d5e0-4a97-970a-2a3b778eac5a.png" alt=""><figcaption></figcaption></figure>
3.  Click on the Send button to the right of the prompt

    <figure><img src="https://user-images.githubusercontent.com/91221068/230789215-567e4a5b-52b9-4b07-85b6-196713b0de50.png" alt=""><figcaption></figcaption></figure>
4.  It should now show sensitive or PII params from the API payloads

    <figure><img src="https://user-images.githubusercontent.com/91221068/230789223-b5505cdb-1583-484e-aa93-00d4481ae302.png" alt=""><figcaption></figcaption></figure>

\
