# Move From Self Hosted Setup To SaaS

## **Introduction**

This guide will help you to move your On-Prem Setup to Akto SaaS setup. 
In case you want to restore your Akto Data and move it to your SaaS account, proceed with Step 1(Restore Original Data). Else proceed with Step 2(Connect Akto with Hybrid SaaS)

## Step 1: Restore Original Data

1. Run the below command and copy mongo container id
```bash 
kubectl get pods -n <namespace> 
```
2. Run the below command 
```bash 
kubectl exec -it <mongo_container_id> bash  
```
3. Run the below command 
```bash 
mongodump --db 1000000 --out /data/dump/1000000 
```
4. Run the below command 
```bash 
kubectl cp -n default <container_id>:data/dump/1000000 ~/copy-1000000 -n <namespace> 
```
5. Run the below command  
```bash 
mkdir akto_data_folder 
```
6. Run the below command  
```bash 
mv ~/copy-1000000 ~/akto_data_folder 
```
7. zip the folder akto_data_folder
8. Contact Akto Support to share the file in a secure manner and to restore the data in your SaaS account.
9. Proceed to next step only after you receive an acknowledgement from Akto team.

## Step 2: Connect Akto with Hybrid SaaS

1. Go to app.akto.io
2. Login/Signup into your account.
3. Go to quick start tab and search for connector Hybrid SaaS Connector and click on connect
4. Copy the command provided.
5. Download helm chart for mini-runtime service 
	https://github.com/akto-api-security/helm-charts/tree/master/charts/mini-runtime
6. Run the command copied in step no. 4
7. Setup New DaemonSet Pods with 
	```bash AKTO_NLB_IP = aktoruntime-mini-runtime.dev.svc.cluster.local:9092 ```
8. Go to app.akto.io and check if traffic data is getting populated in your account.

## Step 3: Removing Old Akto Helm Setup

1. Once step 2 is finished and Akto is setup with Hybrid SaaS, confirm you can see new traffic in Akto dashboard.
2. Now,  we can remove old Akto Helm Setup. Run helm uninstall <cluster_name> -n <namespace>
3. Delete old DaemonSet Pods

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
