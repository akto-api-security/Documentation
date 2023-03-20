# Run tests in CICD

## Introduction

You can trigger Akto's API Security tests in your CI/CD pipelines too. Generate your **Akto token** and send API requests to Akto dashboard to start running tests. 

### Generate Akto token

<img width="1440" alt="Screenshot 2023-03-20 at 11 30 01 AM" src="https://user-images.githubusercontent.com/91221068/226259539-45f9e910-671e-4a60-9aac-2160231804a6.png">

* Go to `My account > Settings > Integrations`
* Select `Akto API` under `Automation category`
* Click on `Generate token` button to generate a fresh token or copy an existing token.

### Add trigger in your CI/CD tool

This is a bit dirty right now - involves getting the request from your browser's console.

* Open the API collection where you want to run the tests.
* Open your browser's Console. For Chrome, right-click and select `Inspect` option from the menu. For Safari, right-click and choose `Inspect Element`. Select the `Network` tab in the console.
* By default, the API collection view shows all APIs. You can filter the APIs on which you want to run the tests. For example, to run tests only on `GET` endpoints, we can add a filter to show only `GET` endpoints.
<img width="1439" alt="Screenshot 2023-03-20 at 11 49 36 AM" src="https://user-images.githubusercontent.com/91221068/226262115-ea443e8f-1b65-4a09-83e0-51c189448a4d.png">

* Click on the `Run test` button on the top right.
* Select the tests you want to run as part of CI/CD pipeline. Please keep `Select time = Now` and `Run daily` should be unchecked. Feel free to edit the `Name`, `Test run time` and `Max concurrent requests`.
* Click on `Run once now` (if the button name says anything else, read the previous point 🙄)
* Observe a new entry named `startTest` in the `Network` tab. Please select it.
* Go to `Payload` tab > right-click > choose `Copy value`
<img width="1440" alt="Screenshot 2023-03-20 at 11 56 29 AM" src="https://user-images.githubusercontent.com/91221068/226263357-be430b06-8a44-47b7-9512-14be1d30f526.png">

* Prepare the following curl command by replacing `akto-dashboard-url`, `akto-token` and `run-test-payload`\
`curl "https://<akto-dashboard-url>/api/startTest" \
              -H \'X-API-KEY: <akto-token>\' \
              -H \'account: 1000000\' \
              -H \'content-type: application/json\' \
              -d \'<run-test-payload>\' \
              --compressed`
* Add a post deployment hook in your CI/CD tool. Add the above curl command as part of post deployment. For example, Jenkins post deployment hook should look like - 
<img width="1069" alt="Untitled" src="https://user-images.githubusercontent.com/91221068/226264229-71f8cdd8-63ba-4fd2-a363-01804e923831.png">

* If you have hosted Akto in your VPC, please ensure the CI/CD machine can reach Akto's dashboard. You might have to change Security rules on Akto-Load-Balancer accordingly.
* If you want this to become better, please create a GitHub issue [here](https://github.com/akto-api-security/akto/issues). Or even better, contribute! We are open source! 



