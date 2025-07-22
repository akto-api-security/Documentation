# Akto DAST

Akto DAST (Dynamic Application Security Testing) allows you to automatically scan and collect API endpoints and traffic data directly from your machine. This enables effective security testing without traffic mirroring or cloud agent setup.

<figure><img src="../.gitbook/assets/image (123).png" alt=""><figcaption></figcaption></figure>

***

### Getting Started

**✅ Pre-requisite**

* **Start Akto DAST Module**:
  Ensure the DAST module (`aktojax`) is running using the following Docker Compose file:

  ```yaml
  version: '3.3'

  services:
    aktojax:
      image: tangobeeakto/aktojax:latest
      ports:
        - "8088:8088"
      restart: always
  ```

  After running the above Docker Compose setup, set the environment variable on the machine where your Akto dashboard is running:

  ```bash
  export AKTOJAX_SERVICE_URL=http://<IP_ADDRESS_OF_DAST>:8088
  ```

  Replace `<IP_ADDRESS_OF_DAST>` with the actual IP address of the machine running the Docker container.

* **Akto X-API-Key**: Generate this from your Akto dashboard under **Settings > Integrations > Akto API.**

**Steps to Start:**

1. Navigate to the **Quick Start > Akto DAST** section in your Akto dashboard.
2. Enter your **website URL** and **Akto X-API-Key**.
3. (Optional) If your site requires login, check the box and provide your email and password.
4. Adjust crawl configurations as needed.
5. Click **Crawl** to start capturing traffic and discovering APIs.

***

### Akto DAST Options

| Option                    | Description                                                         |
| ------------------------- | ------------------------------------------------------------------- |
| **Maximum page visits**   | Maximum visits per page during crawling (e.g., `2`).                |
| **DOM load timeout (ms)** | Time to wait for DOM to fully load before analyzing (e.g., `3000`). |
| **Click external links**  | Allow the crawler to navigate to external domains (checkbox).       |

***

### After Crawling

Once the crawl is complete:

* A new **Collection** will be created based on your domain name.\
  For example, if your website is `https://app.akto.io`, a collection named **`app.akto.io`** will be created.
* If a collection with that domain name already exists, the new data will be **merged** into the existing collection instead of creating a duplicate.

You can view and manage this collection under the **API Discovery > Collections** page in your Akto dashboard.

***

### Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
