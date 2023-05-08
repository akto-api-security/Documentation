# Kubernetes

## Introduction

If you are on Kubernetes or AWS-EKS, you can add a daemonset config to populate APIs in Akto.

## Configuring Daemonset

Follow these steps to add daemonset config to your Kubernetes setup - 

- Go to Quick Start on your Akto dashboard and expand the *Connect traffic data* section.<img width="1440" alt="Step 1" src="https://user-images.githubusercontent.com/91221068/236832212-603647ca-fceb-46fc-baf7-150c2e6b7ec0.png">

- Scroll down to *Kubernetes Daemonset* section.<img width="1440" alt="Step 2" src="https://user-images.githubusercontent.com/91221068/236832259-cac91fd0-c6a1-4ab2-ab2b-2b9f3d4244b3.png">

- Copy the policy json and click on the link pointing to Akto Dashboard role. <img width="1440" alt="Step 3" src="https://user-images.githubusercontent.com/91221068/236832267-1e22802b-caa9-4af6-8cf9-06a8b0cacc5d.png">

- Click on the *JSON* tab and paste the policy<img width="1440" alt="Step 4" src="https://user-images.githubusercontent.com/91221068/236832279-70340e39-3ccb-4118-9ee9-039711c7e22d.png">

- Click on *Review policy* button<img width="1440" alt="Step 5" src="https://user-images.githubusercontent.com/91221068/236832289-afe2931b-c11a-44b8-a946-79cf0e106dfa.png">

- Enter *AktoDashboardRole* as the role name and click on "Create Policy" button<img width="1440" alt="Step 6" src="https://user-images.githubusercontent.com/91221068/236832299-996d635d-5c0d-43d3-8ee3-eb53f7de952d.png">
- Come back to Akto dashboard and refresh the page

- You should now see a *Setup daemonset stack* button. Click on this button to setup a traffic processing stack which will process your API traffic data and populate APIs on the dashboard. This might take a few minutes to complete.<img width="1440" alt="Step 8" src="https://user-images.githubusercontent.com/91221068/236832351-220ee84e-5d34-4a82-8819-a11bdeeefb5b.png">

-  Once complete, you should now see a daemonset config. Copy the config and paste in a text editor.<img width="1440" alt="Step 9" src="https://user-images.githubusercontent.com/91221068/236832394-4a3dabc6-60f2-4112-b1cb-127c4a129c6d.png">

-  Replace {NAMESPACE} with your app namespace and {APP_NAME} with the name of your app<img width="1440" alt="Step 10" src="https://user-images.githubusercontent.com/91221068/236832427-2506df70-2040-440d-9347-c81152b110d4.png">

-  Create a file `akto-daemonset-config.yaml` with the above YAML config<img width="1440" alt="Step 11" src="https://user-images.githubusercontent.com/91221068/236832456-67c34a4b-12d8-46f6-902d-16747771036a.png">

-  Call `kubectl apply -f akto-daemonset-config.yaml -n <NAMESPACE>` on your *kubectl* terminal<img width="1440" alt="Step 12" src="https://user-images.githubusercontent.com/91221068/236832475-1a20f62c-05e8-4ca7-85c6-c5bc1d4a9946.png">

-  Confirm the daemonsets are up by running `kubectl get daemonsets`. It should show *akto-k8s* daemonset.<img width="1440" alt="Step 13" src="https://user-images.githubusercontent.com/91221068/236832493-35b27843-dce9-482a-803a-033999c55aef.png">

-  Go to API Inventory on Akto dashboard to see your new APIs<img width="1440" alt="Step 14" src="https://user-images.githubusercontent.com/91221068/236832509-8e8c84ff-633e-4ffe-b11b-344d02ca6e74.png">

