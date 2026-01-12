# Getting Started with Akto DAST (On-Premise)

Akto DAST (Dynamic Application Security Testing) can be deployed on-premise to scan and collect API endpoints from private/internal services that are not publicly accessible. This setup includes testing and browser automation services for comprehensive security testing.

<figure><img src="../.gitbook/assets/image (167).png" alt="" width="563"><figcaption></figcaption></figure>

## **Deployment Steps**

1. Create a new instance with the following requirements
   1. Platform
      1. Linux
   2. Spec
      1. 2 vCPU
      2. 4GB RAM
      3. 20GB Hard disk
      4. Don't use burstable instances
   3. Network
      1. Private subnet
      2. connectivity to internet (typically via NAT)
      3. connectivity to your staging service
   4. Security groups
      1. Inbound - No ports required
      2. Outbound - Open all
2. SSH into this new instance in your Cloud
3. Run `sudo su -`
4. Install [docker and docker-compose](https://docs.docker.com/engine/install/).
5. Create a `.env` file with the following environment variables:

```env
# Database Abstractor Configuration
DATABASE_ABSTRACTOR_URL=https://cyborg.akto.io
DATABASE_ABSTRACTOR_SERVICE_TOKEN=<DATABASE_ABSTRACTOR_SERVICE_TOKEN>

# DAST Module Configuration
DAST_MODULE_NAME=akto_dast

# Testing Service Configuration
RUNTIME_MODE=hybrid
PUPPETEER_REPLAY_SERVICE_URL=http://akto-api-security-puppeteer-replay:3000

# Puppeteer Configuration
NODE_ENV=production

# Watchtower Configuration
WATCHTOWER_CLEANUP=true
WATCHTOWER_POLL_INTERVAL=1800
```

**Environment Variables**:
- `DATABASE_ABSTRACTOR_SERVICE_TOKEN`: Your database abstractor service token (You can find this from **Akto dashboard > Quick Start > Hybrid Saas (click connect button) > databaseAbstractorToken under Runtime Service Command section**)
  <figure><img src="../.gitbook/assets/database_abstractor_token_helper_img.png" alt="" width="563"><figcaption></figcaption></figure>
- `DAST_MODULE_NAME`: A unique name for this DAST module (e.g., `prod-dast-01`, `staging-dast`)

6. Paste the following in `docker-compose-dast.yml` file:

```yaml
version: '3.8'

services:
  aktojax:
    image: aktosecurity/aktojax:latest
    env_file:
      - .env
    restart: always

  akto-api-security-testing:
    image: public.ecr.aws/aktosecurity/akto-api-security-mini-testing:latest
    env_file:
      - .env
    restart: always

  akto-api-security-puppeteer-replay:
    image: public.ecr.aws/aktosecurity/akto-puppeteer-replay:latest
    ports:
      - "3000:3000"
    env_file:
      - .env
    restart: always

  watchtower:
    image: containrrr/watchtower
    restart: always
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    env_file:
      - .env
    labels:
      com.centurylinklabs.watchtower.enable: "false"
```

7. Run `docker-compose -f docker-compose-dast.yml up -d` to start all services in detached mode.
8. Run `systemctl enable /usr/lib/systemd/system/docker.service` to ensure Docker starts up in case of instance restarts.

{% hint style="info" %}
**Note**: If no modules are available, Akto automatically uses the internal DAST service for your crawl.
{% endhint %}

## **Steps to Start**

To start a DAST crawl for your application, follow the steps below:

{% stepper %}
{% step %}
Open the DAST section from the top-left product selector in your Akto account.
{% endstep %}

{% step %}
In the left sidebar, select Quick Start under the DAST feature.
{% endstep %}

{% step %}
In the Akto DAST card, select Connect to open the configuration form.
{% endstep %}

{% step %}
Select a DAST Module from the available list.

{% hint style="info" %}
The dropdown shows all active DAST modules (If you have). If no modules appear, the internal DAST service will be used automatically.
{% endhint %}
{% endstep %}

{% step %}
Configure your crawl settings using the available DAST options:

<details>

<summary>Options Available</summary>

| Option                           | Description                                                                                                                   |
| -------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| **Out-of-Scope URLs**            | List of URLs the crawler must not visit. For example: adding `/admin/*` prevents crawling admin pages.                        |
| **Maximum Page Visits**          | Limits how many pages the crawler explores. For example: setting _200_ restricts the crawl to the first 200 discovered pages. |
| **DOM Load Timeout (ms)**        | Maximum wait time for a page's DOM to load before moving on. For example: _3000 ms_ waits up to 3 seconds.                    |
| **Wait Time After Timeout (ms)** | Additional wait time after DOM timeout before the crawler proceeds. For example: _1000 ms_ adds a 1-second buffer.            |
| **Enable JavaScript Rendering**  | Allows the crawler to load and execute JavaScript content. Useful for SPAs like React or Vue apps.                            |
| **Parse SOAP Web Services**      | Enables the crawler to detect and process SOAP endpoints.                                                                     |
| **Parse REST Web Services**      | Enables the crawler to identify REST API patterns, such as `/v1/users`.                                                       |
| **Click External Link**          | Allows the crawler to follow links that point outside the primary hostname. Helpful on apps that redirect to subdomains.      |

</details>

{% hint style="success" %}
All configuration fields are optional. You can proceed without modifying them.
{% endhint %}
{% endstep %}

{% step %}
Enter your Website URL and Akto-X-API-Key.
{% endstep %}

{% step %}
Select either of the Authentication Type:

* **None**
*   **Email & Password** (enter your credentials when selected)

    <div align="left"><figure><img src="../.gitbook/assets/image (168).png" alt="" width="188"><figcaption></figcaption></figure></div>
*   **Test Role** that matches your expected access level.

    <div align="left"><figure><img src="../.gitbook/assets/image (169).png" alt="" width="188"><figcaption></figcaption></figure></div>


{% endstep %}

{% step %}
Select Crawl to begin the capturing traffic and discovering APIs.
{% endstep %}
{% endstepper %}

## After Crawling

Akto begins exploring your application based on the configurations you provided and discovers all reachable APIs for further testing. Once the crawl is complete:

* A new **Collection** will be created based on your domain name.\
  For example, if your website is `https://app.akto.io`, a collection named **`app.akto.io`** will be created.
* If a collection with that domain name already exists, the new data will be **merged** into the existing collection instead of creating a duplicate.

You can view and manage this collection under the **API Discovery > Collections** page in your Akto dashboard.

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
