# Run test

## Introduction

Akto's testing module helps you run 100s of test for your APIs. It's a 2 steps process.

## Step 1: Select endpoints you want to test

* Go to `Observe -> Inventory`.

<figure><img src="../.gitbook/assets/Frame 20 (2).png" alt=""><figcaption></figcaption></figure>

* Click on any `collection` you want to run test on.
* To effectively test your endpoints, you have the option to select specific endpoints to test. If you do not select any endpoints, all endpoints will be tested. Additionally, you can use the filter on the `Method` column and select `GET` to only run tests on GET endpoints. You can also apply filters on other columns in the table, such as `Last seen`, `Access Type`, and `Auth Type`, to narrow down the endpoints that you want to test.

<figure><img src="../.gitbook/assets/Frame 21 (1).png" alt=""><figcaption></figcaption></figure>

* Click on `run test` button.

<figure><img src="../.gitbook/assets/Frame 22 (1).png" alt=""><figcaption></figcaption></figure>

##

## Step 2: Select and run tests

* `Select tests` to be run from the Akto test library. Some of the tests might require you to set user config before you run test. Follow steps to [create user config](create-user-config.md). **Example:** For all the broken authentication and authorization tests, you will need to specify auth value in `testing - > user config`.

<figure><img src="../.gitbook/assets/Screenshot 2023-01-26 at 4.10.52 PM.png" alt=""><figcaption></figcaption></figure>

* Select `max test run time` and `max concurrent requests`
* Click `Run once now`.
* Go to `Testing -> Test results -> Test` to see results of the test you have just run.

<figure><img src="../.gitbook/assets/Frame 23 (1).png" alt=""><figcaption></figcaption></figure>

## TROUBLESHOOTING

If you are having problems running tests in Akto, here are some things you can try:

1. **Check the Akto logs.** The Akto logs can provide valuable information about the problem you are experiencing. To view the Akto logs, navigate to the Akto dashboard and click on the **Logs** tab.

2. **Contact Akto support.** If you are still having problems running tests in Akto, you can contact Akto support for assistance. To contact Akto support, navigate to the Akto website and click on the **Support** tab.

### Common Akto Problems and Solutions

**Problem:** Akto is not able to connect to my API server.

**Solution:** Make sure that Akto has permission to connect to your API server. You can check this by navigating to the Akto dashboard and clicking on the **API Servers** tab. Make sure that the API server that you are trying to connect to is listed in the table. If it is not, click on the **Add API Server** button and add the API server.

**Problem:** Akto is not able to find any API endpoints on my API server.

**Solution:** Make sure that Akto is able to access the API endpoints on your API server. You can check this by navigating to the Akto dashboard and clicking on the **API Endpoints** tab. Make sure that the API endpoints that you are trying to test are listed in the table. If they are not, click on the **Add API Endpoint** button and add the API endpoints.

**Problem:** Akto is reporting false positives.

**Solution:** Akto's powerful testing engine uses traffic data to understand API traffic patterns, which leads to reduced false positives. However, if you are still getting false positives, you can try the following:

* Increase the number of tests that Akto runs.
* Increase the time that Akto waits between tests.
* Use a different Akto test profile.
* Contact Akto support for assistance.

**Problem:** Akto is not able to generate a test report.

**Solution:** Make sure that Akto has permission to generate test reports. You can check this by navigating to the Akto dashboard and clicking on the **Settings** tab. Make sure that the **Generate Test Reports** checkbox is enabled.

### Additional Troubleshooting Tips

If you are still having problems running tests in Akto, here are some additional troubleshooting tips:

* Make sure that you are using the latest version of Akto.
* Make sure that your API server is running and accessible.
* Make sure that you have the correct permissions to run tests on your API server.
* Try running the tests in a different environment, such as a different browser or on a different computer.
* Try running the tests using a different test profile.
* Contact Akto support for assistance.

I hope this troubleshooting documentation is helpful.
