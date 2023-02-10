# Creating and attaching a load balancer to an EC2 instance

1. Create a Tagret group for the akto EC2 instance

    a. Go to AWS Management console and search for ```target groups``` in EC2 panel. Then click on ```Create target group```.
    <figure><img src="../../.gitbook/assets/lb-ec2-1.png" alt=""><figcaption></figcaption></figure>

    b. Give the target group name as ```akto-target-group```, protocol as ```HTTP```, port as ```8080``` and the VPC should be the same VPC in which you've deployed akto. Then click on next.
     <figure><img src="../../.gitbook/assets/lb-ec2-2.png" alt=""><figcaption></figcaption></figure>
    
    c. Select the ```Akto Mongo Instance``` 
    <figure><img src="../../.gitbook/assets/lb-ec2-3.png" alt=""><figcaption></figcaption></figure>

    d. Enter the port as ```8080``` and click on ```Include as pending below```
    <figure><img src="../../.gitbook/assets/lb-ec2-4.png" alt=""><figcaption></figcaption></figure>

    e. Click on ```Create target group``` to create the target group.
    <figure><img src="../../.gitbook/assets/lb-ec2-5.png" alt=""><figcaption></figcaption></figure>

2. Go to AWS Management console and search for ```load balancers``` in EC2 panel. Then click on ```Create load balancer```. Then select ```Application load balancer``` in ```load balancer types```
<figure><img src="../../.gitbook/assets/lb-ec2-6.png" alt=""><figcaption></figcaption></figure>
<figure><img src="../../.gitbook/assets/lb-ec2-7.png" alt=""><figcaption></figcaption></figure>

3. Set the load balancer name as ```akto-load-balancer```
<figure><img src="../../.gitbook/assets/lb-ec2-8.png" alt=""><figcaption></figcaption></figure>

4. Set the same vpc in which you've deployed akto in network mapping. Then Select a public subnet in atleast 2 availability Zones.
<figure><img src="../../.gitbook/assets/lb-ec2-9.png" alt=""><figcaption></figcaption></figure>

5. Select a security group with ```8080 inbound rule``` and ```all allowed outbound rule```
<figure><img src="../../.gitbook/assets/lb-ec2-10.png" alt=""><figcaption></figcaption></figure>

6. Set the port to ```8080``` and select ```akto-target-group```, which we created earlier in default action.
<figure><img src="../../.gitbook/assets/lb-ec2-11.png" alt=""><figcaption></figcaption></figure>

7. Click on ```Create load balancer``` to finally create the load balancer.

8. Now go to the load balancer, and copy its DNS name. Akto Dashboard will be available on ```<DNS name>:8080``` . Signup and get started.
<figure><img src="../../.gitbook/assets/lb-ec2-12.png" alt=""><figcaption></figcaption></figure>