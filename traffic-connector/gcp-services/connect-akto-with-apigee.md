## Connect Akto with Apigee

Before setting up the APIgee connector, you need to deploy the Akto Data-Ingestion Service. Follow these steps:

1.  **Download the required Docker Compose and environment files**  
    SSH into the instance where you want to deploy the data-ingestion service and run the following commands to download the necessary files:
    
    ```bash
    wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/docker-compose-data-ingestion-runtime.yml
    wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/data-ingestion-docker.env
    wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/docker-mini-runtime.env
    
    ```
    
2.  **Retrieve the `DATABASE_ABSTRACTOR_SERVICE_TOKEN`**
    
    -   Go to [Akto Dashboard](https://app.akto.io/) and log in to your account.
    -   Navigate to the **Quick Start** tab in the left navigation panel. <figure><img src="../../.gitbook/assets/Quick-Start.png" alt=""><figcaption></figcaption></figure>
    -   Select the **Hybrid SaaS Connector** and copy the token provided in the **Runtime Service Command** section <figure><img src="../../.gitbook/assets/HybridSaaSConnector.png" alt=""><figcaption></figcaption></figure>
3.  **Update the `docker-mini-runtime.env` file**
    
    -   Open the `docker-mini-runtime.env` file and replace the `<token>` placeholder with the `DATABASE_ABSTRACTOR_SERVICE_TOKEN` obtained from the Akto dashboard. <figure><img src="../../.gitbook/assets/TokenReplace.png" alt=""><figcaption></figcaption></figure>
4.  **Deploy the Data-Ingestion Service**
    
    -   Run the following command to start the data-ingestion service:
        
        ```bash
        docker-compose -f docker-compose-data-ingestion-runtime.yml up -d
        
        ```
        
5.  **Get the IP Address of the Data-Ingestion Service**
    
    -   Ensure the instance is accessible from the instances where APIgee is hosted.
    -   Note down the IP address of this instance as it will be required by the APIgee connector to send traffic data.

----------

To enable this premium connector for your account, please reach out to our team at [help@akto.io](mailto:help@akto.io) for pricing and setup information.