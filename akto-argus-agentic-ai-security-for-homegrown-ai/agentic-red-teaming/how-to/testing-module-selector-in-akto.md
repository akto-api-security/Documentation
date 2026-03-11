# Probing Module Selector in Akto

The **Probing Module Selector** in Akto allows you to choose which probing module (engine) to use when running API security probes. This is useful when multiple modules are available or when targeting a specific deployment.

You can use the selector to:

* Choose which module will execute the probe
* Run probes using a specific configured module

***

### How to Use the Probing Module Selector

1. Go to **AI Red Teaming > API Collections**.
2. Click **Run probe** to open the Configure Probe window.
3. In **Select Probing Module**, use the dropdown to pick the module you want (e.g., `Default_b5f3`).
4. Complete the other probe configurations.
5. Click **Run once now** to start the probe.

{% hint style="info" %}
If unsure, leave the default module selected—Akto will use the active probing module automatically.
{% endhint %}

<figure><img src="../../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

***

### Viewing Available Modules

You can see a list of available modules under:

**Settings > Logs > Module Information**

This section shows:

* Module type
* Version
* Start time
* Last heartbeat (to verify module is active)

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

***

### How to Set a Custom Probing Module Name

In your `docker-compose-probing.yml` file, add the environment variable `MINI_PROBING_NAME` under the `akto-api-security-probing` service.

```yaml
version: '3.8'
services:
  akto-api-security-probing:
    image: public.ecr.aws/aktosecurity/akto-api-security-mini-probing:latest
    environment:
      RUNTIME_MODE: hybrid
      DATABASE_ABSTRACTOR_SERVICE_TOKEN: <Paste_token_here>
      PUPPETEER_REPLAY_SERVICE_URL: "http://akto-puppeteer-replay:3000"
      MINI_PROBING_NAME: <your_mini_probing_name>
    restart: always
```

Replace `<your_mini_probing_name>` with the desired module name (e.g., `staging_module`, `us_east_1`, `qa_env`).

✅ This name will be listed in the **Select Probing Module** dropdown when configuring a probe.
