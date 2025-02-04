# Connect Akto with Istio

If your API calls are being routed through Istio service mesh, you can use Akto's Istio filter to send traffic to Akto dashboard. Below guide will help you do this:

<figure><img src="../../.gitbook/assets/image (4).png" alt=""><figcaption></figcaption></figure>

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

## Adding Akto traffic collector

1. Download the GitHub repo [here](https://github.com/akto-api-security/istio-filter) and `cd` into it.&#x20;
2. Create your own Docker image of `istio-proxy` by running following commands:

```bash
docker build . -t <your-docker-account-id>:istio-proxy
docker push <your-docker-account-id>:istio-proxy
```

{% hint style="info" %}
Please make sure you are building docker image on the same platform as your app server.&#x20;
{% endhint %}

3. Add this custom istio-proxy image to containers you want to collect traffic from. You can get the value of `AKTO_NLB_IP` from the dashboard itself.&#x20;

```yaml
      - name: istio-proxy
        image: <your-docker-id>/istio-proxy:latest
        env:
        - name: AKTO_KAFKA_IP
          # you will find this on your akto dashboard after you've deployed the Data-processing stack using Akto.
          value: "<AKTO_NLB_IP>:9092"
```

4. Re-apply the config to restart all your pods with the added `istio-proxy` container.

```
kubectl apply -f <your-deployment-file>
```

5. Apply `akto-envoy-filter.yaml` to start capturing API calls and send to Akto dashboard.

```
kubectl apply -f akto-envoy-filter.yaml
```
