# Install testing module in your Cloud

## Introduction

API Security testing involves sending malicious API requests to your (staging) server. By default, these malicious testing requests are sent from the Testing module installed within Akto Cloud.

There could be multiple reasons why you'd want to install testing module within your Cloud.

1. Whitelisting Akto's IP in Security Group or WAF isn't an option
2. The staging server isn't reachable from public domain
3. The WAF would block most requests (or block Akto's IP)
4. The API domain isn't resolvable from public domain
5. The API is completely internal

## Testing from Customer Cloud

1. Login to Akto dashboard at [app.akto.io](https://app.akto.io)
2. Go to Quick Start > Hybrid Saas > Click on “Connect” button
3. Copy the JWT token (marked in red) [ Also referred as `Database Abstractor Token` later]

You can now use a Helm-chart to install Akto Security Testing module in your cloud or install manually

### Terraform

1. To install using Terraform, use the Terraform script [here](https://github.com/akto-api-security/infra/blob/feature/quick-setup/templates/mini-testing.tf).
   1. Please make sure you install it in a private subnet from your application VPC.
   2. This private subnet should also have network connectivity (typically via NAT).
2. For `Database Abstractor Service Token` input in the terraform script specify the JWT token copied in the earlier step.
3. Once the terraform script has finished running, you should be able to see a new autoscaling group created with 1 Akto Testing EC2 instance running.

### Helm-chart

1. Add akto helm repository.
```bash
helm repo add akto https://akto-api-security.github.io/helm-charts/
```
##### Note: If you've already added akto helm repository, update the helm repository using:
```bash
helm repo update akto
```
2. Using the dashboard abstractor token saved in the above steps, deploy the helm chart below.
```bash
helm install akto-mini-testing akto/akto-mini-testing -n <your-namespace> --set testing.aktoApiSecurityTesting.env.databaseAbstractorToken="<your-database-abstractor-token>"
```
##### Note: If you want to modify the helm chart according to your needs, you can clone the same from https://github.com/akto-api-security/helm-charts/tree/master/charts/mini-testing:

### Linux VM

1. Create a new instance with the following requirements
   1. Platform
      1. Amazon Linux 2023
   2. Spec
      1. 2 vCPU
      2. 4GB RAM
      3. 20GB Hard disk
      4. Don’t use burstable instances
   3. Network
      1. Private subnet
      2. connectivity to internet (typically via NAT)
      3. connectivity to your staging service
   4. Security groups
      1. Inbound - Open only port 22 for SSH
      2. Outbound - Open all
2. SSH into this new instance in your Cloud
3. Run `sudo su -`
4. Install [docker](https://github.com/akto-api-security/infra/blob/feature/quick-setup/get-docker.sh) and [docker-compose](https://github.com/akto-api-security/infra/blob/feature/quick-setup/get-docker-compose.sh).
5.  Paste the following in `docker-compose-testing.yml` file. Use token from step(3) for DATABASE\_ABSTRACTOR\_SERVICE\_TOKEN value

    ```
    version: '3.8'
    services:
      akto-api-security-testing:
        image: public.ecr.aws/aktosecurity/akto-api-security-mini-testing:latest
        environment:
          RUNTIME_MODE: hybrid
          DATABASE_ABSTRACTOR_SERVICE_TOKEN: <Paste_token_here>
          PUPPETEER_REPLAY_SERVICE_URL: "http://akto-puppeteer-replay:3000"
        restart: always

      akto-api-security-puppeteer-replay:
        image: public.ecr.aws/aktosecurity/akto-puppeteer-replay:latest
        ports:
          - "3000:3000"
        environment:
          NODE_ENV: production
        restart: always

      watchtower:
        image: containrrr/watchtower
        restart: always
        volumes:
          - /var/run/docker.sock:/var/run/docker.sock
        environment:
          WATCHTOWER_CLEANUP: true
          WATCHTOWER_POLL_INTERVAL: 1800
        labels:
          com.centurylinklabs.watchtower.enable: "false"
    ```
6. Run `docker-compose -f docker-compose-testing.yml up -d`
7. Run `systemctl enable /usr/lib/systemd/system/docker.service` to ensure Docker starts up in case of instance restarts

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).