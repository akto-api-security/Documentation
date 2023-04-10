# Data types

Akto comes with a set of pre-defined data types already eg Email, Phone number, IP address etc. 
You can find the list of data types in your dashboard by checking out `Settings` > `Data types`.

<figure><img width="978" alt="Data types" src="../.gitbook/assets/Data types.png"></figure>

Akto provides a lot of ways to customize data types.
1. [Set or unset a data type as sensitive](#modify-sensitive-settings)
2. [Activate or deactivate a data type](#activate-or-deactivate)
3. [Add your own data types](#add-custom-types)

## Modify sensitive settings
1. Go to `My accounts` > `Settings` > select `Data types`
   <figure><img width="978" alt="Data types" src="../.gitbook/assets/Data types.png"></figure>

2. Select the data type you want to modify
   <figure><img width="883" alt="Select data type" src="../.gitbook/assets/Select data type.png"></figure>

3. Look for the `Sensitive in Request` and `Sensitive in Response` options
   <figure><img width="894" alt="Modify sensitive settings" src="../.gitbook/assets/Modify sensitive settings.png"></figure>

4. If you set it to `True`, Akto will start marking the pattern as sensitive across all your APIs for all your collections.
   Note that the new type will be detected as new data is processed. No old data will be processed.
   <figure><img width="565" alt="Sensitive data" src="../.gitbook/assets/Sensitive data dashboard.png"></figure>

5. If both are set to `False`, Akto will still detect it, but won't show up in sensitive data

## Activate or deactivate
1. Go to `My accounts` > `Settings` > select `Data types`
   <figure><img width="978" alt="Data types" src="../.gitbook/assets/Data types.png"></figure>

2. Hover on the data type and click on the `Trash` icon to deactivate the data type. 
   <figure><img width="1013" alt="Deactivate" src="../.gitbook/assets/Deactivate.png"></figure>

3. Akto will stop detecting this type as new data comes in. 

4. If you want to reactivate it, you can scroll to the bottom to find the deactivated type and click on the `Check` icon to activate. 
   <figure><img width="409" alt="Reactivate" src="../.gitbook/assets/Reactivate.png"></figure>

## Add custom types
1. Go to `My accounts` > `Settings` > select `Data types`
   <figure><img width="978" alt="Data types" src="../.gitbook/assets/Data types.png"></figure>

2. Click on the `Plus` button at the top
   <figure><img width="794" alt="Add" src="../.gitbook/assets/Add.png"></figure>

3. Name your data type eg. `TXN_ID`

4. Add patterns to identify it. You can match against the key (eg. key contains `txn_id`) or you can match against the value as shown. 
   <figure><img width="793" alt="Regex" src="../.gitbook/assets/Regex.png"></figure>

5. Adjust the sensitivity. Here, we want `TXN_ID` to be sensitive only in responses

6. Click on `Save`
