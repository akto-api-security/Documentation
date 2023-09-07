
# Add subdomain to Akto on AWS

[Akto](https://www.akto.io/) creates a load balancer for your akto dashboard. You can put this dashboard behind your organization's subdomain for easier access across teams. Moreover, adding SSL certificate make the dashboard more secure.

## To configure HTTPS and add SSL certificate to akto dashboard load-balancer

1. Navigate to AWS dashboard > EC2 > load balancers and select the akto dashboard load balancer.

<figure><img src="../.gitbook/assets/aws-ssl-1.png" alt="Navigate to load balancers and select akto dashboard load balancer"><figcaption></figcaption></figure>

2. Go to `Listeners and rules` and select the `HTTP:80` rule.

<figure><img src="../.gitbook/assets/aws-ssl-2.png" alt="Select HTTP 80 rule"><figcaption></figcaption></figure>

3. Click on `Edit listener` 

<figure><img src="../.gitbook/assets/aws-ssl-3.png" alt="Click on edit listener"><figcaption></figcaption></figure>

4. Change protocol from `HTTP` to `HTTPS`.

<figure><img src="../.gitbook/assets/aws-ssl-4.png" alt="Change protocol to HTTPS"><figcaption></figcaption></figure>

5. Add your SSL certificate to the listener.

<figure><img src="../.gitbook/assets/aws-ssl-5.png" alt="Add SSL cert"><figcaption></figcaption></figure>

6. Click on save changes. The protocol should be changed by this. To make it reachable by the load balancer we would edit its security group.

<figure><img src="../.gitbook/assets/aws-ssl-6.png" alt="Save changes"><figcaption></figcaption></figure>

7. On the same page, click on security and click on the associated security group.

<figure><img src="../.gitbook/assets/aws-ssl-7.png" alt="Go to the associated security group"><figcaption></figcaption></figure>

8. Click on edit inbound rules.

<figure><img src="../.gitbook/assets/aws-ssl-8.png" alt="Edit inbound rules"><figcaption></figcaption></figure>

9. Change the type of protocol from HTTP to HTTPS and save the inbound rule of the security group.

<figure><img src="../.gitbook/assets/aws-ssl-9.png" alt="Set type to HTTPS"><figcaption></figcaption></figure>

10. You should now be able to access akto dashboard's load-balancer IP on HTTPS and it should give an invalid SSL certificate error, because the certificate belongs to your organization and would have been mapped to your organization's domain name.

<figure><img src="../.gitbook/assets/aws-ssl-10.png" alt=""><figcaption></figcaption></figure>
<figure><img src="../.gitbook/assets/aws-ssl-11.png" alt=""><figcaption></figcaption></figure>

## To configure custom subdomain for akto dashboard load-balancer

1. Navigate to Route 53 on the AWS dashboard. Go to hosted zones.

<figure><img src="../.gitbook/assets/aws-ssl-12.png" alt="Go to route 53"><figcaption></figcaption></figure>

2. Select the hosted zone in which you want to route akto dashboard and click on create record.

<figure><img src="../.gitbook/assets/aws-ssl-13.png" alt="Create a new record in a hosted zone"><figcaption></figcaption></figure>

3. Select the record name as `akto` and record type as `A - Routes traffic to an IPv4 address and some AWS resources`. Then toggle the alias button.

<figure><img src="../.gitbook/assets/aws-ssl-14.png" alt=""><figcaption></figcaption></figure>

4. Select on `Application and classic load balancer` in the endpoints menu. 

<figure><img src="../.gitbook/assets/aws-ssl-15.png" alt="Select on application and classic load balancer"><figcaption></figcaption></figure>

5. Select the region in which the load balancer is deployed.

<figure><img src="../.gitbook/assets/aws-ssl-16.png" alt="Select region"><figcaption></figcaption></figure>

6. Choose akto dashboard's load balancer in the menu and click on `Create records`.

<figure><img src="../.gitbook/assets/aws-ssl-17.png" alt="choose your LB and create records"><figcaption></figcaption></figure>

Now, you have added a custom subdomain and SSL certificate to your akto deployment on AWS.