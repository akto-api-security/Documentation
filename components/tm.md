Akto traffic mirroring

# Prerequisites



# FAQs
### What all resources are required to run Akto traffic mirroring?
Akto requires total 4 EC2 servers to start capturing and processing your data via traffic mirroring. For production setup we suggest m5a.xlarge instances, but
this can be easily tweaked as per your requirements.

### What is the cost of running Akto traffic mirroring?
Link to cost document

### How does Akto traffic mirroring work?
Traffic mirroring is a feature provided by cloud providers using which we can send a copy of all traffic data on a cloud instance to a destination for processing.
Akto traffic mirroring uses this feature to send a copy of all traffic data to Akto for processing. While deploying Akto on your environment, you will configure a 
load balancer or a target group related to your app servers, Akto will seamlessly create mirroring sessions for all your app servers and start processing traffic data.




# Troublshooting guide [WIP]

### I tried installing Akto via cloudformation template from stairway.akto.io, but the stack creation failed.
This can happen due to multiple reasons, 1st step is to navigate to AWS console > Cloudformation > Stacks and check the events tab for the Akto stack. Navigate to the 1st event
where the errors started coming and check the error message. Some of the common errors are listed below:
1. Private subnets selected for Akto dashboard load balancer: Akto dashboard load balancer should be created in public subnets, if we give private subnets for Akto dashboard load balancer, then the stack creation will fail.
2. Select a private subnet with no internet access: Akto resources will be created in a private subnet, but if this private subnet has no internet access, then the stack creation will fail. Please make sure the private subnet you select has internet access i.e. it has a NAT gateway attached to it.


### I have installed Akto, I have configured a load balancer as well, but I am not able to see any traffic data on Akto dashboard.
There can be multiple reasons for this, please follow the below steps to troubleshoot this issue:
1. Akto setup incorrectly.
2. Incorrect load balancer configured.

Lets look at each of these scenarios in detail.
#### Akto setup incorrectly
Verify the private subnet where Akto is deployed should be same as the private subnet where your app servers are deployed.
If they are different, then you will need to update route tables of both the subnets to allow traffic between them. Else, you can redeploy 
Akto in the same subnet as your app servers.

#### Incorrect load balancer configured
Verify the load balancer you have configured is the same load balancer where your app servers are attached.
If the load balancer is correct, then navigate to AWS console > VPC > Traffic mirroring > Mirroring sessions. You should see a few mirroring sessions here where the source eni is the eni of your app servers.
If you do not see any mirroring sessions here then reach out to us on discord or support@akto.io and we will help you out.


