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

Note: You can schedule daily tests by clicking on select time in the run test dialog. The test will be scheduled to run everyday on the specified time.