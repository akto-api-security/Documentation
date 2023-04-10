# HAR file upload

The HTTP Archive format, or HAR, is a JSON-formatted archive file format for logging of a web browser's interaction with a site. 
The common extension for these files is .har. You can use this method if you quickly want to try out Akto. Akto can process HAR (Http ARchive) files and populate inventory from it.

## How to capture traffic in a .har file and upload to Akto

1. Go to any website. Let's use https://juiceshop.akto.io for a demo.

2. Open the developer tools in Chrome and switch to the network tab.

3. Browse the website as usual to generate traffic, then right-click anywhere in the network and click on `save as har with content`

<figure><img src="../.gitbook/assets/juiceshop.png" alt=""><figcaption></figcaption></figure>


## How to upload a HAR file on Akto dashboard

1. Open any API Collection where you want to add traffic data. 
 - You can also [create a new collection](https://docs.akto.io/api-inventory/api-collections#custom-create-collections) for this purpose. 
 - Open the newly created API Collection 
2. Click on the **Upload Har file** button on the top right<img width="16" alt="upload_icon" src="https://user-images.githubusercontent.com/91221068/230879293-c4042fe0-5cc2-4072-ac1b-765905255579.png">
   <img width="1440" alt="Empty collection" src="https://user-images.githubusercontent.com/91221068/230879325-93d93bf8-715a-4ea0-a8a7-207a554c5f6e.png">
3. Select the HAR file from the file browser.
   <img width="999" alt="Select HAR file" src="https://user-images.githubusercontent.com/91221068/230879518-4d92d2f3-ab17-40d1-9db7-445087792cc8.png">
4. Click on the Refresh icon on the top right. 
   <img width="721" alt="Refresh icon" src="https://user-images.githubusercontent.com/91221068/230879588-261e9813-625b-4855-995c-4c78035a8909.png">
5. You should be able to see APIs imported in your collection from the HAR file. 
   <img width="1440" alt="API Collection populated" src="https://user-images.githubusercontent.com/91221068/230879681-9f4c849f-990d-4cec-8786-f216b0529135.png">
