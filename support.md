# Support

## Troubleshooting guide

1. To update akto to the latest version, go through the following steps, as per your setup
   * Setup using AWS cloudformation template
     1. SSH inside the dashboard EC2 instance. You can find the dashboard instance, using the AktoDashboard auto scaling group or by looking at the security group of the instances.
     2.  Run the following commands

         ```bash
         sudo su -
         cd ~/akto/infra
         docker-compose -f docker-compose-dashboard.yml pull
         docker-compose -f docker-compose-dashboard.yml up -d
         ```
     3. Alternatively, you can go to the AktoDashboard auto scaling group and downscale the desired units to 0 and then upscale the desired units to the previous value. This will force the auto scaling group to issue a new instance with the latest image and terminate the old one.
   * Setup using helm-charts
     1. Check the `akto` deployment `kubectl get deployments -n <your-namespace>` in the namespace in which you deployed akto. You can get the akto dashboard pod from there using `kubectl describe deployments akto -n <your-namespace>`. Alternatively you can run `kubectl get pods -n <your-namespace>` directly to get the pods.
     2. Kill this pod using `kubectl delete pods <akto-dashboard-pod> -n <your-namespace>`. Since this pod is a part of the akto-deployment, a new pod, with the latest akto-dashboard-image will be spawned. Alternatively, you can change the desired no. of replicaSet to 0 and then back to the original value in the akto-dashboard deployment. This will trigger a pod refresh, which will spawn new pods with the latest image and destroy the old ones, automatically.
   * Setup using GCP template or any other self-hosted setup
     1. SSH inside the dashboard compute instance.
     2.  Run the following commands

         ```bash
         sudo su -
         cd ~/akto/infra
         docker-compose -f docker-compose-dashboard.yml pull
         docker-compose -f docker-compose-dashboard.yml up -d
         ```
2. Please ensure internet connectivity from your deployed instance. You can run the following command to check the same.

```bash
ping www.google.com
```

3. Contact us at support@akto.io and we will respond back to you as soon as possible.

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
