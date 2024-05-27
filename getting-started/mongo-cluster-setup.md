# Setup a Mongo Cluster

## Using a cloudformation template

Use the following cloud formation template [link](https://github.com/akto-api-security/infra/blob/feature/quick-setup/templates/mongo-cluster-template.yml)

This cfn template requires 2 inputs:
1. PrivateSubnetId: Select the private subnet in which you want the cluster to be created. Make sure this subnet has a route to a Nat Gateway connectivity.
2. KeyPair: This keypair will be used to ssh into the instance

The default instance type in the template is m6a.large. You can change it as per your requirement in the template. We recommend not to use `t` type of instances for running a cluster.

Once this template is executed successfully you will see 3 EC2 instances created. 
The connection url for connecting to the cluster will be as follows:
``mongodb://{INSTANCE_1_IP}:27017,{INSTANCE_2_IP}:27017,{INSTANCE_3_IP}:27017/admini``

## Using kubernetes

### Step 1: Prerequisites
Ensure you have created a file system like efs or nfs.

### Step 2: Kubernetes commands
#### Create a storage class using the following:
````
# storage-class.yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
name: mongo-storage
provisioner: efs.csi.aws.com
parameters:
provisioningMode: efs-ap
fileSystemId: fs-0a64ff88e3f61684d # mention your fs id
directoryPerms: "700"
gidRangeStart: "1000"
gidRangeEnd: "2000"
basePath: "/akto"
# optional: specify access point
# accessPointId: <your-access-point-id>
reclaimPolicy: Retain
volumeBindingMode: Immediate
````
#### Create a headless service using the following yaml file

````
# service.yaml
apiVersion: v1
kind: Service
metadata:
  name: mongo
spec:
  ports:
  - port: 27017
    targetPort: 27017
  clusterIP: None
  selector:
    app: mongo
````

#### Create a stateful set using the following yaml file. This will create 3 pods running mongo.
````
# statefulsets.yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mongo
spec:
  selector:
    matchLabels:
      app: mongo
  serviceName: "mongo"
  replicas: 3
  template:
    metadata:
      labels:
        app: mongo
    spec:
      containers:
        - name: mongo
          image: mongo:6.0.1
          args: ["--dbpath", "/data/db"]
          startupProbe:
            exec:
              command:
                - mongosh
                - --eval
                - "db.adminCommand('ping')"
            initialDelaySeconds: 1
            periodSeconds: 10
            timeoutSeconds: 5
            successThreshold: 1
            failureThreshold: 2
          livenessProbe:
            exec:
              command:
                - mongosh
                - --eval
                - "db.adminCommand('ping')"
            initialDelaySeconds: 1
            periodSeconds: 10
            timeoutSeconds: 5
            successThreshold: 1
            failureThreshold: 2
          readinessProbe:
            exec:
              command:
                - mongosh
                - --eval
                - "db.adminCommand('ping')"
            initialDelaySeconds: 1
            periodSeconds: 10
            timeoutSeconds: 5
            successThreshold: 1
            failureThreshold: 2
          command:
            - mongod
            - "--bind_ip_all"
            - "--replSet"
            - rs0
          volumeMounts:
            - name: mongo-volume
              mountPath: /data/db
  volumeClaimTemplates:
    - metadata:
        name: mongo-volume
      spec:
        accessModes: ["ReadWriteOnce"]
        storageClassName: mongo-storage
        resources:
          requests:
            storage: 1Gi
````

#### Execute the above created yaml file using the following commands
````bash
kubectl apply -f storage-class.yaml -n {{namespace}}
kubectl apply -f statefulsets.yaml -n {{namespace}}
kubectl apply -f service.yaml -n {{namespace}}
````

#### Execute the following commands to initialize the cluster

````
kubectl exec -it mongo-0 mongosh -n {{namespace}}

# execute the next command from within mongo shell
rs.initiate({
    _id: "rs0",
    members: [
        {_id: 0, host:"mongo-0.mongo.default.svc.cluster.local:27017"},
        {_id: 1, host:"mongo-1.mongo.default.svc.cluster.local:27017"},
        {_id: 2, host:"mongo-2.mongo.default.svc.cluster.local:27017"}
    ]
})
````

Connection url for connecting to the cluster will be as follows:
````mongodb://mongo-0.mongo.default.svc.cluster.local:27017,mongo-1.mongo.default.svc.cluster.local:27017,mongo-2.mongo.default.svc.cluster.local:27017/admini````


