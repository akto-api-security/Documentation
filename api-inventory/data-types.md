# Data types

Akto comes with a set of pre-defined data types already eg Email, Phone number, IP address etc. 
You can find the list of data types in your dashboard by checking out `Settings` > `Data types`.

<img width="978" alt="Data types" src="https://user-images.githubusercontent.com/91221068/230909109-c926ad5a-b108-4376-87d0-885bdd4e3568.png">

Akto provides a lot of ways to customize data types.
1. [Set or unset a data type as sensitive](#modify-sensitive-settings)
2. [Activate or deactivate a data type](#activate-or-deactivate)
3. [Add your own data types](#add-custom-types)

## Modify sensitive settings
1. Go to `My accounts` > `Settings` > select `Data types`<img width="978" alt="Data types" src="https://user-images.githubusercontent.com/91221068/230910995-c2a4b682-1e02-4c35-9e3f-78ba9efbb035.png">

2. Select the data type you want to modify<img width="883" alt="Select data type" src="https://user-images.githubusercontent.com/91221068/230911017-9241c4a4-33c1-41a7-9ec9-f6f6e3dac42a.png">

3. Look for the `Sensitive in Request` and `Sensitive in Response` options<img width="894" alt="Modify sensitive settings" src="https://user-images.githubusercontent.com/91221068/230911034-5224b1cf-e7bf-4072-b98e-701ea34a67ae.png">

4. If you set it to `True`, Akto will start marking the pattern as sensitive across all your APIs for all your collections.
   Note that the new type will be detected as new data is processed. No old data will be processed.
   <img width="565" alt="Sensitive data" src="https://user-images.githubusercontent.com/91221068/230911719-f294f2c8-5ac9-40ef-848f-a0ddc8b07c60.png">

5. If both are set to `False`, Akto will still detect it, but won't show up in sensitive data

## Activate or deactivate
1. Go to `My accounts` > `Settings` > select `Data types`<img width="978" alt="Data types" src="https://user-images.githubusercontent.com/91221068/230910995-c2a4b682-1e02-4c35-9e3f-78ba9efbb035.png">

2. Hover on the data type and click on the `Trash` icon to deactivate the data type. <img width="1013" alt="Deactivate" src="https://user-images.githubusercontent.com/91221068/230912257-7981af10-e3ce-40ed-a680-b4597b077163.png">

3. Akto will stop detecting this type as new data comes in. 

4. If you want to reactivate it, you can scroll to the bottom to find the deactivated type and click on the `Check` icon to activate. 
   <img width="409" alt="Reactivate" src="https://user-images.githubusercontent.com/91221068/230912448-5963c07c-4643-43e0-86bb-3da05528419d.png">

## Add custom types
1. Go to `My accounts` > `Settings` > select `Data types`<img width="978" alt="Data types" src="https://user-images.githubusercontent.com/91221068/230910995-c2a4b682-1e02-4c35-9e3f-78ba9efbb035.png">

2. Click on the `Plus` button at the top
   <img width="794" alt="Add" src="https://user-images.githubusercontent.com/91221068/230913509-313f3fac-d5e3-40e5-a3f2-e653f7597b65.png">

3. Name your data type eg. `TXN_ID`

4. Add patterns to identify it. You can match against the key (eg. key contains `txn_id`) or you can match against the value as shown. 
   <img width="793" alt="Regex" src="https://user-images.githubusercontent.com/91221068/230913538-ba61dd2a-21f8-41e7-a7f6-b813c38f3ffb.png">

5. Adjust the sensitivity. Here, we want `TXN_ID` to be sensitive only in responses

6. Click on `Save`
