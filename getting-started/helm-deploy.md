# Helm Deploy

You can install Akto via Helm charts. 

## Resources
Akto's Helm chart repo is on GitHub [here](https://github.com/akto-api-security/helm-charts).
You can also find Akto on Helm.sh [here](https://artifacthub.io/packages/helm/akto/akto).

## Prerequisites
Please ensure you have the following -
1. A Kubernetes cluster where you have deploy permissions
2. `helm` command installed. Check [here](https://helm.sh/docs/intro/install/)

## Steps 
Here are the steps to install Akto via Helm charts - 

1. Prepare Mongo Connection string
2. Install Akto via Helm
3. Verify Installation and harden security

### Create Mongo instance
Akto Helm setup needs a Mongo connection string as input. It can come from either of the following -
1. **Your own Mongo**
   Ensure your machine where you setup Mongo is NOT exposed to public internet. It shouldn't have a public IP. You can setup Mongo by running the following commands.
   ```
   sudo yum update -y
   sudo yum install -y docker
   sudo dockerd&
   docker run --name mongo --restart always -v ./data:/data/db -p 27017:27017 mongo
   sudo systemctl enable /usr/lib/systemd/system/docker.service
   ```
   <img width="1161" alt="AWS EC2 Mongo" src="https://github.com/akto-api-security/Documentation/assets/91221068/0b6b87e8-9797-4729-ab01-fd48f99efbd3">

   The connection string would then be `mongodb://<YOUR_INSTANCE_PRIVATE_IP>:27017/admini`
2. **Mongo Atlas**
   You can use Mongo Atlas connection as well
   1. Go to `Database Deployments` page for your project
   2. Click on `Connect` button
   3. Choose `Connect your application` option
   4. Copy the connection string. It should look like `mongodb://....`
      <img width="567" alt="Mongo Atlas" src="https://github.com/akto-api-security/Documentation/assets/91221068/1128e098-3618-4d19-b9c3-2c7482b4714e">

3. **AWS Document DB**
   If you are on AWS, you can use AWS Document DB too. You can find the connection string on the Cluster page itself.
   <img width="1399" alt="AWS DocDB" src="https://github.com/akto-api-security/Documentation/assets/91221068/4ce4d84d-6e8a-4d4d-bc0b-e5d03e3f824a">

Note: Please ensure your K8S cluster has connectivity to Mongo. 

### Install Akto via Helm

1. Add Akto repo
   ```helm repo add  akto https://akto-api-security.github.io/helm-charts```
2. Install Akto via helm
   ```helm install akto akto/akto -n dev --set mongo.aktoMongoConn="<AKTO_CONNECTION_STRING>"```
3. Run `kubectl get pods -n <NAMESPACE>` and verify you can see 4 pods
   <img width="862" alt="Screenshot 2023-11-16 at 10 08 23 AM" src="https://github.com/akto-api-security/Documentation/assets/91221068/3a5a4d26-3305-4eb2-94f9-ae598817252d">

### Verify Installation and harden security

1. Run the following to get Akto dashboard url
   ```kubectl get services/akto-dashboard -n dev | awk -F " " '{print $4;}'```
2. Open Akto dashboard on port 8080. eg `http://a54b36c1f4asdaasdfbd06a259de2-acf687643f6fe4eb.elb.ap-south-1.amazonaws.com:8080/`
3. For good security measures, you should enable HTTPS by adding a certificate and put it behind a VPN. If you are on AWS, follow the guide [here](https://docs.akto.io/getting-started/aws-ssl).

