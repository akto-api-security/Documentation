# Connect Akto with IIS

Microsoft IIS (Internet Information Services) is a widely used web server for hosting web applications on Windows. Integrating IIS with Akto enables you to automatically mirror API traffic (including headers and payloads) to the Akto backend, empowering deep visibility and continuous API security analysis.

To connect Akto with your IIS server, follow the steps below:

----------

## Step 1: Deploy the Akto Data-Ingestion Service

Before configuring the IIS Traffic Connector, you need to deploy the Akto Data-Ingestion Service. Ensure that the service is running and accessible via a publicly available URL.

### 1.1 Download the Required Files

SSH into the instance where you want to deploy the data-ingestion service and run these commands:

```bash
wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/docker-compose-data-ingestion-runtime.yml
wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/data-ingestion-docker.env
wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/docker-mini-runtime.env
wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/watchtower.env

```

### 1.2 Retrieve the `DATABASE_ABSTRACTOR_SERVICE_TOKEN`

-   Log in to the [Akto Dashboard](https://app.akto.io/)
    
-   Navigate to the **Quick Start** tab in the left panel
    <figure><img src="../../.gitbook/assets/Quick-Start.png" alt=""><figcaption></figcaption></figure>
    
-   Select **Hybrid SaaS Connector**

    <figure><img src="../../.gitbook/assets/HybridSaaSConnector.png" alt=""><figcaption></figcaption></figure>
    
-   Copy the token from the **Runtime Service Command** section
    

### 1.3 Update the `docker-mini-runtime.env` File

Open the `docker-mini-runtime.env` file and replace `token` with the token you just copied:

```plaintext
DATABASE_ABSTRACTOR_SERVICE_TOKEN=token

```

### 1.4 Deploy the Data-Ingestion Service

Run the following command:

```bash
docker-compose -f docker-compose-data-ingestion-runtime.yml up -d

```

### 1.5 Note the IP Address of the Data-Ingestion Service

Ensure this IP is reachable from your IIS server. You will need this to forward the traffic data to Akto.

----------

## Step 2: Install the IIS Traffic Connector

Akto provides a native IIS module that can capture HTTP request and response headers and payloads. This module supports both 64-bit and 32-bit environments.

You can install the module **globally (all sites)** or **per-site**. Choose the method that fits your use case:

----------

### 2.1 Install the Module Globally (Recommended)

We provide a PowerShell script to simplify global installation. Follow these steps:

#### 📦 Download the Installation Script and DLLs

1.  Download the script and binaries:
    
    ```powershell
    Invoke-WebRequest -Uri https://akto.io/downloads/iis/install-akto-module.ps1 -OutFile install-akto-module.ps1
    Invoke-WebRequest -Uri https://akto.io/downloads/iis/AktoTrafficConnector_x64.dll -OutFile AktoTrafficConnector_x64.dll
    Invoke-WebRequest -Uri https://akto.io/downloads/iis/AktoTrafficConnector_x86.dll -OutFile AktoTrafficConnector_x86.dll
    
    ```
    
2.  Run the script (as Administrator):
    
    ```powershell
    .\install-akto-module.ps1 -AktoIngestionURL "http://<YOUR_AKTO_INGESTION_SERVICE_URL>"
    
    ```
    
    Replace `<YOUR_AKTO_INGESTION_SERVICE_URL>` with the IP or hostname of your deployed Akto ingestion service.
    

This script:

-   Detects system architecture (x64/x86)
    
-   Installs the appropriate DLL
    
-   Registers the `AktoTrafficConnector` globally in IIS
    
-   Ensures it loads on every site
    

----------

### 2.2 Add Module to a Specific Website Only (Alternative Method)

If you want to install the module for **just one website**, follow these steps:

1.  Copy the appropriate DLL (x64 or x86) into a directory named `bin` under your site’s root folder (e.g., `C:\inetpub\wwwroot\MySite\bin`).
    
2.  Update the `web.config` of that website:
    

```xml
<configuration>
  <system.webServer>
    <modules>
      <add name="AktoTrafficConnector" type="AktoTrafficConnector" />
    </modules>
  </system.webServer>
</configuration>

```

3.  Ensure the app pool identity has access to read this folder and its DLLs.
    

----------

## Step 3: Verify the Integration

Once installed:

1.  Make a few requests to your IIS-hosted APIs.
    
2.  In your Akto dashboard, go to **API Collections** tab and confirm that traffic is appearing.

If no traffic is appearing, check:

-   IIS logs for module load errors.
    
-   Akto Data-Ingestion Service logs to ensure it’s receiving traffic.
    

----------

## Additional Notes

-   The IIS module works with HTTP/1.1 traffic on both .NET and non-.NET apps hosted on IIS.
    
-   Ensure the firewall allows outbound traffic from IIS to the Akto ingestion service.
    

----------

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24×7 available through the following:

1.  In-app `Intercom` support — message us via the chat icon in the Akto dashboard.
    
2.  Join our [Discord channel](https://www.akto.io/community) for community support.
    
3.  Email us at [help@akto.io](mailto:help@akto.io).
    
4.  Visit our [Contact page](https://www.akto.io/contact-us).
    