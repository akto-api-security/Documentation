# Testing Module Selector in Akto

The **Testing Module Selector** in Akto allows you to choose which testing module (engine) to use when running API security tests. This is useful when multiple modules are available or when targeting a specific deployment.

You can use the selector to:

* Choose which module will execute the test
* Run tests using a specific configured module

## How to Use the Testing Module Selector

{% stepper %}
{% step %}
Go to **Testing > API Collections**.
{% endstep %}

{% step %}
Click **Run test** to open the Configure Test window.
{% endstep %}

{% step %}
In **Select Testing Module**, use the dropdown to pick the modules you want (e.g., `Default_b5f3`).

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (194).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Complete the other test configurations.
{% endstep %}

{% step %}
Click **Run once now** to start the test.
{% endstep %}
{% endstepper %}

{% hint style="info" %}
## Note

* If unsure, leave the default module selected, Akto will use the active testing module automatically.
* You can also choose multiple modules. Akto will run the tests on the first available module it finds from your selected options.
{% endhint %}



## Viewing Available Modules

You can see a list of available modules under:

**Settings > Logs > Module Information**

This section shows:

* Module type
* Version
* Start time
* Last heartbeat (to verify module is active)

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

## How to Set a Custom Testing Module Name

In your `docker-compose-testing.yml` file, add the environment variable `MINI_TESTING_NAME` under the `akto-api-security-testing` service.

```yaml
version: '3.8'
services:
  akto-api-security-testing:
    image: public.ecr.aws/aktosecurity/akto-api-security-mini-testing:latest
    environment:
      RUNTIME_MODE: hybrid
      DATABASE_ABSTRACTOR_SERVICE_TOKEN: <Paste_token_here>
      PUPPETEER_REPLAY_SERVICE_URL: "http://akto-puppeteer-replay:3000"
      MINI_TESTING_NAME: <your_mini_testing_name>
    restart: always
```

Replace `<your_mini_testing_name>` with the desired module name (e.g., `staging_module`, `us_east_1`, `qa_env`).

✅ This name will be listed in the **Select Testing Module** dropdown when configuring a test.
