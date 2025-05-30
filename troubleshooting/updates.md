# How to update helm deployments

You can either upgrade the entire helm chart or choose to update individual container images based on your preference.

## Upgrading helm chart version

1. Update the helm repo

    ```bash
    helm repo update
    ```

    <figure><img src="../.gitbook/assets/updates-6.png" alt=""><figcaption></figcaption></figure>

2. Check the latest version for your deployment.

    ```bash
    helm show chart akto/akto-mini-runtime
    ```

    <figure><img src="../.gitbook/assets/updates-7.png" alt=""><figcaption></figcaption></figure>

3. Upgrade the helm chart to the latest version for your deployment in your namespace.

    ```bash
    helm upgrade akto-mini-runtime akto/akto-mini-runtime -n <namespace> --version 0.1.6
    ```

    <figure><img src="../.gitbook/assets/updates-8.png" alt=""><figcaption></figcaption></figure>

## Directly updating container images

1. Check the image pull policy for the deployment. To check the image pull policy run the following commands.

    ```bash
    kubectl get deployments -n dev
    kubectl get deployment akto-mini-runtime-mini-runtime -n dev -o yaml
    ```

    <figure><img src="../.gitbook/assets/updates-1.png" alt=""><figcaption></figcaption></figure>
    <figure><img src="../.gitbook/assets/updates-2.png" alt=""><figcaption></figcaption></figure>

2. According to your image pull policy, follow ahead:

    1. **imagePullPolicy: Always** : If image pull policy is set to always, first check if the tag for the image is set to `latest`, if not then set it. Then run the rollout command. This will restart the pods in the deployment and download the latest builds.

        ```bash
        kubectl set image deployment/akto-mini-runtime-mini-runtime akto-api-security-runtime=aktosecurity/mini-runtime:latest -n dev
        kubectl rollout restart deployment akto-mini-runtime-mini-runtime -n dev
        ```
        <figure><img src="../.gitbook/assets/updates-3.png" alt=""><figcaption></figcaption></figure>
        <figure><img src="../.gitbook/assets/updates-4.png" alt=""><figcaption></figcaption></figure>

    2. **imagePullPolicy: IfNotPresent** : If image pull policy is set to IfNotPresent, we would need to use versioned images for the modules which would contain the newer builds.

        ```bash
        kubectl set image deployment/akto-mini-runtime-mini-runtime akto-api-security-runtime=aktosecurity/mini-runtime:1.42.3_local -n dev
        ```
        <figure><img src="../.gitbook/assets/updates-5.png" alt=""><figcaption></figcaption></figure>

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
