# API reference

You will need the following inputs for each of the API endpoints:

* <mark style="color:purple;">`YOUR_API_KEY`</mark> : Go to settings/ integrations and fetch API key under external API.
* <mark style="color:purple;">`URL`</mark> : This is the url of your Akto dashboard.

1. **api/getAPICollection:** This endpoint is to fetch all the APIs of one collection
   * Query parameters: <mark style="color:purple;">`Collection_ID`</mark> You can get this by going to a collection and copying the number from url.
   * Command: \*\*\*\* ` curl -H "X-API-KEY:`` `` `<mark style="color:purple;">`YOUR_API_KEY`</mark>`" "`<mark style="color:purple;">`URL`</mark>`/api/getAPICollection?apiCollectionId=`<mark style="color:purple;">`Collection_ID`</mark>`"`
   * Output: You will get list of all the params from all the urls in that collection under `data.endpoints.`

```json
{
	"data": {
		"name": "Main application",
		"endpoints": [
		  	{
			  "apiCollectionId": 1641506725,
			  "isHeader": false,
			  "method": "POST",
			  "param": "category#id",
			  "responseCode": 200,
		 	  "subType": "INTEGER_32",
			  "timestamp": 1641509240,
			  "url": "https:\/\/petstore.swagger.io\/v2\/pet"
			},
		    ....
		]
	}
}
```

**2. api/loadRecentParameters:** This endpoint is to fetch all the new params of your complete API inventory.

* Command: \*\*\*\* ` curl -H "X-API-KEY:`` `` `<mark style="color:purple;">`YOUR_API_KEY`</mark>`" "`<mark style="color:purple;">`URL`</mark>`/api/loadRecentParameters"`
* Output: You will get list of all the new params under `data.endpoints.`

```json
{
	"data": {
		"name": "Main application",
		"endpoints": [
		  	{
			  "apiCollectionId": 1641506725,
			  "isHeader": false,
			  "method": "POST",
			  "param": "category#id",
			  "responseCode": 200,
		 	  "subType": "INTEGER_32",
			  "timestamp": 1641509240,
			  "url": "https:\/\/petstore.swagger.io\/v2\/pet"
			},
		    ....
		]
	}
}
```

**3. api/loadSensitiveParameters:** This endpoint is to fetch all the sensitive params of your complete API inventory.

* Command: \*\*\*\* ` curl -H "X-API-KEY:`` `` `<mark style="color:purple;">`YOUR_API_KEY`</mark>`" "`<mark style="color:purple;">`URL`</mark>`/api/loadSensitiveParameters"`
* Output: You will get list of all the new params under `data.endpoints.`

```json
{
	"data": {
		"name": "Main application",
		"endpoints": [
		  	{
			  "apiCollectionId": 1641506725,
			  "isHeader": false,
			  "method": "POST",
			  "param": "username",
			  "responseCode": 200,
		 	  "subType": "EMAIL",
			  "timestamp": 1641509240,
			  "url": "https:\/\/petstore.swagger.io\/v2\/pet"
			},
		    ....
		]
	}
}
```

**4. api/fetchEndpointTrafficData:** This endpoint is to fetch all the traffic data of a particular endpoint.

* Query parameters:
  1. <mark style="color:purple;">`Collection_ID`</mark> You can get this by going to a collection and copying the number from url.
  2. <mark style="color:purple;">`Endpoint_Url`</mark> This is endpoint url for which you want to get the traffic. ( example: api/board")
  3. <mark style="color:purple;">`Method`</mark> The http method for which you want to get the traffic.
  4. <mark style="color:purple;">`Start_Epoch`</mark> The starting time stamp of the traffic you want to fetch. ( example: 1641748269)
  5. <mark style="color:purple;">`End_Epoch`</mark> The starting time stamp of the traffic you want to fetch. ( example: 1646932269)
* Command: \*\*\*\* `curl -H "X-API-KEY:`<mark style="color:purple;">`YOUR_API_KEY`</mark>` ``" -d '{"method":`` `<mark style="color:purple;">`Method`</mark>` , "url":`` `` `<mark style="color:purple;">`Endpoint_Url`</mark>` , "apiCollectionId":`` `` `<mark style="color:purple;">`Collection_ID`</mark>`, "startEpoch":`<mark style="color:purple;">`Start_Epoch`</mark>` , "endEpoch":`` `` `<mark style="color:purple;">`End_Epoch`</mark>`}' -H "Content-type: application/json" -X POST "`<mark style="color:purple;">`URL`</mark>`/api/fetchEndpointTrafficData"`
* Output: You will get daily traffic trend under `traffic` key.

```json
{
	"traffic": {
		"20220212": 19923,
		"20220213": 20427,
		"20220214": 21142,
		"20220215": 20477,
		...
	}
}
```

**5. api/fetchApiInfoList:** This endpoint is to fetch metadata of all the APIs of one collection

* Query parameters: <mark style="color:purple;">`Collection_ID`</mark> You can get this by going to a collection and copying the number from url.
* Command: \*\*\*\* ` curl -H "X-API-KEY:`` `` `<mark style="color:purple;">`YOUR_API_KEY`</mark>`" "`<mark style="color:purple;">`URL`</mark>`/api/fetchApiInfoList?apiCollectionId=`<mark style="color:purple;">`Collection_ID`</mark>`"`
* Output: You will get list of all the params from all the urls in that collection under `apiInfoList`

```json
{
	"apiInfoList": [
	  {
		  "actualAuthType": ["BASIC"],
		  "allAuthTypesFound": [
			  ["BASIC"]
		  ],
		  "apiAccessTypes": ["PRIVATE"],
		  "id": {
			  "apiCollectionId": 0,
			  "method": "GET",
			  "url": "\/api\/getCardInsights"
		  },
		  "lastSeen": 1646763449,
		  "violations": {}
	   },
	   .....
	]
}
```

**6. api/fetchSampleData:** This endpoint is to fetch all the sample data entries stored for a particular endpoint. Note that Akto stores only latest 10 samples for any endpoint.

* Query parameters:
  1. <mark style="color:purple;">`Collection_ID`</mark> You can get this by going to a collection and copying the number from url.
  2. <mark style="color:purple;">`Endpoint_Url`</mark> This is endpoint url for which you want to get the traffic. ( example: api/board")
  3. <mark style="color:purple;">`Method`</mark> The http method for which you want to get the traffic.
* Command: \*\*\*\* `curl -H "X-API-KEY:`<mark style="color:purple;">`YOUR_API_KEY`</mark>` ``" -d '{"method":`` `<mark style="color:purple;">`Method`</mark>` , "url":`` `` `<mark style="color:purple;">`Endpoint_Url`</mark>` , "apiCollectionId":`` `` `<mark style="color:purple;">`Collection_ID`</mark>`}' -H "Content-type: application/json" -X POST "`<mark style="color:purple;">`URL`</mark>`/api/fetchSampleData"`
* Output: You will get sample request response stored for the queried endpoint

```json
{
	"sampleDataList": {
		{
			"id": {
		        "apiCollectionId": "<apiCollectionId>",
		        "bucketEndEpoch": 0,
		        "bucketStartEpoch": 0,
		        "method": "<method>",
		        "responseCode": -1,
		        "url": "<endpointUrl>"
		    },
		    "samples": []
		}
		.....
	}
}
```

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchTestRunResultDetails" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchDataTypes" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchAffectedEndpoints" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchTagConfigs" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/loadContent" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/retrieveAllCollectionTests" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchPostmanWorkspaces" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchQuickStartPageState" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/importDataFromPostmanFile" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchAPICollection" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchAllSubCategories" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchNewParametersTrend" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchFilters" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchTestRoles" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchSubTypeCountMap" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchIssueFromTestRunResultDetails" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchSearchTestResults" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchSensitiveSampleData" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/loadParamsOfEndpoint" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/getAllCollections" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/updateIssueStatus" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchAktoGptConfig" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchDataTypeNames" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/loadRecentEndpoints" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchAllIssues" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/addTestRoles" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchTestingRunResults" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchAllMarketplaceSubcategories" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchSensitiveParamsForEndpoints" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/getPostmanCredential" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/importPostmanWorkspace" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchChanges" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/addSensitiveField" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchWorkflowTests" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/updateTestRoles" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/loadSensitiveParameters" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchAuthMechanismData" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/stopAllTests" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchCustomAuthTypes" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchEndpointTrafficData" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/saveAktoDataType" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchTestingRunResultSummaries" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchSampleData" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchTestingSources" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}

{% swagger src="../.gitbook/assets/AktoSwagger.json" path="/api/fetchActiveLoaders" method="post" %}
[AktoSwagger.json](../.gitbook/assets/AktoSwagger.json)
{% endswagger %}
