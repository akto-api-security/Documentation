---
description: A quick overview of Akto's Real Time API Threat Protection
---

# Overview

Akto API Protection is a powerful new module designed to detect and block threats in real time as they occur in your APIs. With customizable policies you can tailor the detection rules to meet your specific security needs.

#### Getting Started

To enable Akto API Protection, set the following environment variable in your Akto traffic connector module : `AKTO_THREAT_ENABLED=true`

Supported Akto traffic connectors for Akto API protection module are
- [eBPF Traffic Connector](../../traffic-connector/ebpf/README.md)
- [Kubernetes Traffic Connector](../../traffic-connector/kubernetes/kubernetes.md)
- [Virtual Machines Traffic Connector](../../traffic-connector/virtual-machines/README.md)

### Key Features

- **Real-Time Threat Detection**: Identify and respond to API security threats as they occur.  
- **OWASP Core Rule Set Support**: Detect common attack patterns in APIs such as XSS and SQL Injection.  
- **Geofencing**: Restrict API access based on geographic locations.  
- **IP-Based Blocking**: Block or allow API traffic from specific IP addresses or CIDR ranges.

#### Dashboard
<figure><img src="../../.gitbook/assets/threat-protection.png" alt=""><figcaption></figcaption></figure>



