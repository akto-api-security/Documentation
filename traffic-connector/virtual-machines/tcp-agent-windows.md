# Connect Akto with TCP Agent on Windows

## Introduction

You can use Akto traffic collector on Windows servers to collect and send traffic to Akto. It runs as a Windows service and needs no Docker or Npcap. Your APIs from this traffic will show up in Akto dashboard.

## Adding Akto traffic processor

1. Set up and configure Akto Traffic Processor and save the mini-runtime service URL. The steps are mentioned [here](https://docs.akto.io/getting-started/traffic-processor/hybrid-saas). Alternatively, if you're on on-premise deployment, save the runtime service URL.

## Adding Akto traffic collector service

1. Copy `akto-traffic-mirroring-windows-amd64.zip` to the server.

2. Open PowerShell as Administrator and extract it:

```powershell
Expand-Archive akto-traffic-mirroring-windows-amd64.zip -DestinationPath C:\akto-setup -Force
cd C:\akto-setup\akto-traffic-mirroring-windows-amd64
Get-ChildItem | Unblock-File
Set-ExecutionPolicy -Scope Process Bypass -Force
```

3. Install the collector. Replace `<AKTO_NLB>` with the mini-runtime/runtime service URL saved earlier.

```powershell
.\install.ps1 -KafkaUrl "<AKTO_NLB>:9092"
```

4. Check the logs at `C:\ProgramData\Akto\logs\mirroring.log` for `connection establishing with kafka successfully`.

To uninstall, run `.\uninstall.ps1` from the same folder.

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
