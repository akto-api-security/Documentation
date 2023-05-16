# AWS multi-VPC deploy

## Steps to setup Akto in AWS multi-VPC environment

### Step 1: Log on to [stairway](https://stairway.akto.io) and deploy Akto dashboard and mongo

### Step 2: Setup VPC peering
We need to connect the VPC where Akto is deployed (AktoVPC) and the VPC where App servers (AppServerVPC) are present

#### Step 2.a: Initiate VPC peering between AppServerVPC and AktoVPC
Initiate VPC peering connection from AppServerVPC to AktoVPC
<figure><img src="../.gitbook/assets/multi_cloud_setup/Create peering connection.png" alt=""><figcaption></figcaption></figure>

Once a peering connection request has been initiated, you will see a screen like this
<figure><img src="../.gitbook/assets/multi_cloud_setup/VPC Peering connection successful.png" alt=""><figcaption></figcaption></figure>

#### Step 2.b: Accept VPC peering between AppServerVPC and AktoVPC
Log on to AktoVPC and navigate to VPC > Peering connections.
Click on `Accept request` to accept the peering connection request.

<figure><img src="../.gitbook/assets/multi_cloud_setup/VPC Peering connection accept 1.png" alt=""><figcaption></figcaption></figure>

Clicking on `Accept request` will open up this pop-up where you can confirm the peering connection request.
<figure><img src="../.gitbook/assets/multi_cloud_setup/VPC Peering connection accept 2.png" alt=""><figcaption></figcaption></figure>

After a few seconds the connection status will change to `Active` and you will see a screen like this
<figure><img src="../.gitbook/assets/multi_cloud_setup/VPC peering connections final page.png" alt=""><figcaption></figcaption></figure>

#### Step 2.c: Update route tables
We need to update route tables of both VPCs to allow traffic to flow between them.

##### Step 2.c.1: Update route table of AppServerVPC
Log on to AppServerVPC and navigate to VPC > Route tables.

Click on `Edit routes` and add a route to AktoVPC CIDR block with the peering connection as the target.
<figure><img src="../.gitbook/assets/multi_cloud_setup/Update RT 2.png" alt=""><figcaption></figcaption></figure>

##### Step 2.c.2: Update route table of AktoVPC
Log on to AktoVPC and navigate to VPC > Route tables.

Click on `Edit routes` and add a route to AppServerVPC CIDR block with the peering connection as the target.
<figure><img src="../.gitbook/assets/multi_cloud_setup/Update RT 1.png" alt=""><figcaption></figcaption></figure>

### Step 3: Update security groups to allow traffic between VPCs
Update security group for AktoMongoInstance in AktoVPC to allow the data processors to send data to Mongo.
Once data processors are up and running  (to be setup in step #4), they will start sending data to AktoMongoInstance deployed in AktoVPC. But to make sure that the data reaches mongo instance, we need to update AktoMongoInstance’s security group as follows:

<figure><img src="../.gitbook/assets/multi_cloud_setup/Update SG.png" alt=""><figcaption></figcaption></figure>
Here we will add Type: Custom TCP, Port range: 27017, CIDR block: 10.0.0.0/16 (Cidr block of the AppServerVPC)

### Step 4: Setup data processors
We need to setup data processors in AppServerVPC to send data to AktoMongoInstance deployed in AktoVPC.
Use the following cloud formation template to setup data processors in AppServerVPC [here](https://akto-setup.s3.amazonaws.com/templates/data_processing_stack.json)
To setup this stack you will need to give the following paramenters:
* SubnetId: This should be the subnet id where Akto data processor will be deployed.
* KeyPair: This key pair will be used to login to the data processor for debugging purposes.
* MongoIp: Value here will be :  mongodb://{{AKTO_MONGO_IP}}:27017/admini 
AKTO_MONGO_IP’s value will the AktoMongoInstance's private ip. This can be fetched from AktoVPC > EC2 > AktoMongoInstance > Networking > Private ip address.

That's it! Once all these steps are down, you will now see APIs from your app servers show up on your Akto dashboard.
