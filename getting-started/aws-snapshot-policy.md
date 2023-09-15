
## Optionally, set up a snapshot policy of the database

1. Go to AWS EC2 > Instances.
<img width="876" alt="Screenshot 2023-09-15 at 3 03 32 PM" src="https://github.com/akto-api-security/Documentation/assets/91221068/498a7d8e-58d9-49d9-8a85-c75651aaea31">

2. Search for *Akto Mongo instance* and click on it
<img width="862" alt="Screenshot 2023-09-15 at 3 03 41 PM" src="https://github.com/akto-api-security/Documentation/assets/91221068/f4d13c2e-fa0b-4289-9d2e-07e6ffa9b5bf">

3. Go to *Storage* tab.
<img width="1006" alt="Screenshot 2023-09-15 at 3 04 07 PM" src="https://github.com/akto-api-security/Documentation/assets/91221068/971a0089-d33b-4050-9fed-9e7838dc4cff">

4. Open volume labelled as /dev/xvda
   <img width="913" alt="Screenshot 2023-09-15 at 3 04 14 PM" src="https://github.com/akto-api-security/Documentation/assets/91221068/bfb45a8a-5cf2-4b62-811d-f9a2a437bd87">

6. Select *Create snapshot lifecycle policy*
   <img width="1440" alt="Screenshot 2023-09-15 at 3 04 30 PM" src="https://github.com/akto-api-security/Documentation/assets/91221068/1b6a00c4-a95d-4185-a19d-b9657e5969e8">

8. Follow the instructions [here](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/snapshot-ami-policy.html#create-snap-policy)
   

