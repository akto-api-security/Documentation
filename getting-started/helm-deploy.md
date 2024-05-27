# Helm Deploy

You can install Akto via Helm charts. Read [announcement blog](https://www.akto.io/blog/introducing-akto-with-helm-charts-in-kubernetes).

## Resources

Akto's Helm chart repo is on GitHub [here](https://github.com/akto-api-security/helm-charts). You can also find Akto on Helm.sh [here](https://artifacthub.io/packages/helm/akto/akto).

## Prerequisites

Please ensure you have the following -

1. A Kubernetes cluster where you have deploy permissions
2. `helm` command installed. Check [here](https://helm.sh/docs/intro/install/)

## Steps

Here are the steps to install Akto via Helm charts -

1. Prepare Mongo Connection string - You can set up a fresh mongo cluster using [this](mongo-cluster-setup.md). For best experience we strongly recommend a mongo cluster. You can also use an existing mongo.
2. Install Akto via Helm
3. Verify Installation and harden security

### Prepare Mongo Connection string

Akto Helm setup needs a Mongo connection string as input. It can come from either of the following -

1.  **Your own Mongo** Ensure your machine where you setup Mongo is NOT exposed to public internet. It shouldn't have a public IP. You can setup Mongo by running the following commands.

    ```
    sudo yum update -y
    sudo yum install -y docker
    sudo dockerd&
    docker run --name mongo --restart always -v ./data:/data/db -p 27017:27017 mongo
    sudo systemctl enable /usr/lib/systemd/system/docker.service
    ```

    The connection string would then be `mongodb://<YOUR_INSTANCE_PRIVATE_IP>:27017/admini`

    <figure><img src="https://github.com/akto-api-security/Documentation/assets/91221068/0b6b87e8-9797-4729-ab01-fd48f99efbd3" alt=""><figcaption></figcaption></figure>
2. **Mongo Atlas** You can use Mongo Atlas connection as well
   1. Go to `Database Deployments` page for your project
   2. Click on `Connect` button
   3. Choose `Connect your application` option
   4.  Copy the connection string. It should look like `mongodb://....`

       <figure><img src="https://github.com/akto-api-security/Documentation/assets/91221068/1128e098-3618-4d19-b9c3-2c7482b4714e" alt=""><figcaption></figcaption></figure>
3.  **AWS Document DB** If you are on AWS, you can use AWS Document DB too. You can find the connection string on the Cluster page itself.

    <figure><img src="https://github.com/akto-api-security/Documentation/assets/91221068/4ce4d84d-6e8a-4d4d-bc0b-e5d03e3f824a" alt=""><figcaption></figcaption></figure>
4. **Existing Akto setup** If you have previously installed Akto via CloudFormation template, and you want to move to Helm, please execute the following steps. This guide should be used only if you are NOT using AWS Traffic Mirroring. If you are indeed using AWS Traffic Mirroring, please contact us at support@akto.io.
   1. Go to AWS > EC2 > Auto Scaling Groups and search for `Akto`.
   2. Edit all autoscaling groups and set min/max/desired to 0.
   3. This shuts down all existing Akto infra and just leaves Akto-Mongo running.
   4. **\[Optional - If you want to delete CloudFormation Stacks once migration completes]** - We have to "clone" this Akto Mongo Instance. You can create an AMI and launch a new instance with the same AMI. Alternatively, you can also -
      * Go to AWS > EC2 > Instances > Search for "Akto Mongo instance". Launch a new instance using this template.
      * SSH on new Mongo and run `sudo su -` and then `docker stop mongo`.
      * Run `rm -rf /akto/infra/data/` on new Mongo.
      * Copy `/akto/infra/data/` from old Mongo instance to this new Mongo instance at the same directory location of `/akto/infra/data/` using SCP
      * Run `docker start mongo`
   5. If you have installed Akto's K8s agent in your K8s cluster in the previous CloudFormation setup, please run `kubectl delete -f akto-daemonset-config.yml` to halt the traffic processing too.
   6. Use the private ip of this Mongo instance while installing helm chart (refer [Install Akto via Helm](helm-deploy/#install-akto-via-helm) section)
   7. Once you setup Akto via Helm chart, try logging in with your previous credentials and check the data. All your data must be retained.
   8. Change the `AKTO_NLB` to the output of `kubectl get services/flash-akto-runtime -n staging -o jsonpath="{.spec.clusterIP}"`
   9. Run `kubectl apply -f akto-daemonset-config.yml`
   10. Confirm Akto dashboard has started receiving new data.
   11. Please **Do Not Delete** AWS CloudFormation Stacks. This will delete the Mongo Instance too and you'll lose the data. If you want to delete AWS CloudFormation stacks, please setup new a duplicate Mongo Instance from step (4). Use private IP of this new instance for step (6).
5. **Mongo on K8s with Persistent volume** You can setup a Mongo on K8s cluster itself with a Persistent volume. A sample template is provided [here](https://github.com/akto-api-security/infra/blob/kubernetes/mongo.yml). Use the IP of this service as Mongo private IP in [Install Akto via Helm](helm-deploy/#install-akto-via-helm) section. If you are migrating from previous Akto installation, you have to bootstrap the persistent volume with original Mongo Instance's data before you start Mongo service.

Note: Please ensure your K8S cluster has connectivity to Mongo.

### Install Akto via Helm

1. Add Akto repo `helm repo add akto https://akto-api-security.github.io/helm-charts`
2. Install Akto via helm `helm install akto akto/akto -n dev --set mongo.aktoMongoConn="<AKTO_CONNECTION_STRING>"`
3.  Run `kubectl get pods -n <NAMESPACE>` and verify you can see 4 pods

    <figure><img src="https://github.com/akto-api-security/Documentation/assets/91221068/3a5a4d26-3305-4eb2-94f9-ae598817252d" alt=""><figcaption></figcaption></figure>

### Verify Installation and harden security

1. Run the following to get Akto dashboard url `kubectl get services/akto-dashboard -n dev | awk -F " " '{print $4;}'`
2. Open Akto dashboard on port 8080. eg `http://a54b36c1f4asdaasdfbd06a259de2-acf687643f6fe4eb.elb.ap-south-1.amazonaws.com:8080/`
3. For good security measures, you should enable HTTPS by adding a certificate and put it behind a VPN. If you are on AWS, follow the guide [here](https://docs.akto.io/getting-started/aws-ssl).
