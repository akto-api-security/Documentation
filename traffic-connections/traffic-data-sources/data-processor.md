# Configuring Akto traffic processing stack and creating AWS policy

## Creating AWS Policy

1\. Go to Quick Start on your Akto dashboard and expand the `Connect traffic data` section.

<figure><img src="https://user-images.githubusercontent.com/91221068/236832212-603647ca-fceb-46fc-baf7-150c2e6b7ec0.png" alt=""><figcaption></figcaption></figure>

2\. Scroll down to `Data processors setup` section.

<figure><img src="https://user-images.githubusercontent.com/91221068/237100095-67164c73-2a0b-4505-8268-c932df4a1d27.png" alt=""><figcaption></figcaption></figure>

3\. Copy the `policy json` and click on the Akto Dashboard role link.

<figure><img src="https://user-images.githubusercontent.com/91221068/237100542-c3df31bc-9f7d-4be0-a626-038a31d33ce8.png" alt=""><figcaption></figcaption></figure>

4\. `Click` on the `JSON` tab and `paste the policy`

<figure><img src="https://user-images.githubusercontent.com/91221068/236832279-70340e39-3ccb-4118-9ee9-039711c7e22d.png" alt=""><figcaption></figcaption></figure>

5\. Click on `Review policy` button.

<figure><img src="https://user-images.githubusercontent.com/91221068/236832289-afe2931b-c11a-44b8-a946-79cf0e106dfa.png" alt=""><figcaption></figcaption></figure>

6\. Enter _`AktoDashboardPolicy`_ as the policy name and `click` on `Create Policy` button

<figure><img src="https://user-images.githubusercontent.com/91221068/236832299-996d635d-5c0d-43d3-8ee3-eb53f7de952d.png" alt=""><figcaption></figcaption></figure>

8\. Once the policy is created, go back to the `dashboard`.

## Setting up Data processors

1\. Click on `Setup traffic processors` button.

<figure><img src="https://github.com/akto-api-security/Documentation/assets/91221068/c3e08f08-ec81-4c47-b3b0-fbc1eacc4fe0" alt=""><figcaption></figcaption></figure>

2\. This will bring up infra that will process your traffic.&#x20;

<figure><img src="https://github.com/akto-api-security/Documentation/assets/91221068/7d7d437d-1370-4628-aa10-908b33b907b0" alt=""><figcaption></figcaption></figure>

3\. Check that you have `AKTO_NLB` and `AKTO_MONGO_IP` vars once setup is complete.&#x20;

<figure><img src="https://github.com/akto-api-security/Documentation/assets/91221068/7c79c400-7a0a-4421-96ed-fbb063e025f5" alt=""><figcaption></figcaption></figure>

**Note**: After this has been setup, please follow your specific guides to add akto traffic collectors.