# Detecting changes in APIs

Akto lets you know when a new API endpoint is added or when a new parameter to an endpoint is added.

#### Review all new APIs detected

* Go to API changes tab in your left nav. Go to the new endpoints tab. You can see here all the new endpoints discovered in the last two months.&#x20;

![](<../../.gitbook/assets/Frame 63.png>)

* You can also see the trend of new endpoints and params addition. Typically these are added on every release.

![](<../../.gitbook/assets/Frame 65.png>)

* You can sort here by recency or filter by a specific date.&#x20;

![](<../../.gitbook/assets/Frame 64.png>)

* You should add these endpoints in your security testing specially the ones which are marked as sensitive or are unauthenticated. Checkout how to [manage sensitive data leak](../sensitive-data.md) for these endpoints.

#### Review all new parameters detected in old endpoints

Akto allows you to discover whenever a new parameter is added to an existing endpoint. Sometimes developers add sensitive params to existing endpoints specially the ones which are unauthenticated.&#x20;

* Go to API changes tab in your left nav. Go to the new params tab. You can see here all the new params discovered in the last two months.&#x20;

![](<../../.gitbook/assets/Frame 66.png>)

* You can filters this list for only sensitive params.

![](<../../.gitbook/assets/Frame 67.png>)

* You can now [manage these sensitive params ](../sensitive-data.md)and make sure to remove them if not necessary for functionality.&#x20;
