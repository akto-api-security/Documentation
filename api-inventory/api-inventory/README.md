# API inventory

Akto needs traffic to create API inventory. You can create API inventory by integrating with [Burp](../../traffic-connections/burp-suite.md), [AWS traffic Mirroring](../../traffic-connections/amazon-aws.md), HAR file upload, [Postman](../../traffic-connections/postman.md). Your API inventory will look like below.

![](<../../.gitbook/assets/Frame 25 (2) (1) (1) (1) (1) (1) (1) (1) (1) (1).png>)

You will find all the API endpoints with rich metadata

### API metadata:

* **Request and Response:** Click on any endpoint to see the request and response parameters. All the endpoints marked <mark style="color:red;">red</mark> are sensitive endpoints passing sensitive data in parameters while all <mark style="color:green;">green</mark> endpoints are good endpoints with no sensitive params.

![](<../../.gitbook/assets/Screen Shot 2022-03-09 at 12.48.53 AM.png>)

* **Method :** This is the API method used - `GET, POST, PUT, DELETE`.

![](<../../.gitbook/assets/Frame 25 (1).png>)

* **Sensitive params:** You can see all the sensitive params that are present in the the endpoint once you click the endpoint.&#x20;

![](<../../.gitbook/assets/Frame 28.png>)

* **Access Type:** You can check if the endpoint is public or private. See below. This information helps you discover private endpoints which are accidentally [publicly accessible](broken-reference). :hushed:

![](<../../.gitbook/assets/Frame 27 (1).png>)

* **Auth type** 🔑 **:** You can check what auth token type is detected in the endpoint.&#x20;

![](<../../.gitbook/assets/Frame 29.png>)

* **Sample Values:** You can check sample values of each API. Only last ten sample values are shown here for each endpoint. You can click on next to see other values.&#x20;

![](<../../.gitbook/assets/Frame 47.png>)

* **Traffic trend:** You can also see traffic trend of each API endpoint. :chart\_with\_downwards\_trend:

![](<../../.gitbook/assets/Frame 31.png>)

* **Discovered:** You can see when was the endpoint first discovered&#x20;

![](<../../.gitbook/assets/Frame 30.png>)

* **Last seen:** You can see when was the API endpoint hit last.&#x20;

![](<../../.gitbook/assets/Frame 32.png>)

* **Changes:** You can see how many new params got added.

![](<../../.gitbook/assets/Frame 33.png>)
