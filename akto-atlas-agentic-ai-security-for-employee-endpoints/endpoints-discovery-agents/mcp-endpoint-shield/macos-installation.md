# MacOS Installation

## Overview

This document is designed for MacOS Installation and end-user reference. It explains the installation flow of **MCP Endpoint Shield** on macOS and the permissions users may be prompted to approve.

## Steps Guide

{% stepper %}
{% step %}
#### Gatekeeper Security Warning on First Launch

When the user double-clicks the **MCP Endpoint Shield Installer**, macOS may display a warning stating that the application could not be verified and was blocked to protect the system.

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1).png" alt="" width="375"><figcaption></figcaption></figure>

This is expected behaviour for applications distributed outside the Mac App Store.

**User Action (Required):**

1. Open **System Settings**
2. Navigate to **Privacy & Security**
3. Scroll to the **Security** section
4. Click **Open Anyway** for **mcp-endpoint-shield**
{% endstep %}

{% step %}
#### Allowing the Application in Privacy & Security

This screen confirms that the user has explicitly approved the installer. Once approved, macOS will allow the installer to run normally.

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1).png" alt="" width="563"><figcaption></figcaption></figure>

No administrator privileges are required at this stage.
{% endstep %}

{% step %}
#### Installer Wizard – Introduction Screen

After approval, the installer wizard launches.

<figure><img src="../../../.gitbook/assets/image (2) (1) (1) (1) (1) (1).png" alt="" width="563"><figcaption></figcaption></figure>

The introduction screen explains:

* What MCP Endpoint Shield does
* The installation location (user directory)
* That no root or administrator permissions are required

Click **Continue** to proceed.
{% endstep %}

{% step %}
#### Installation Type Confirmation

<figure><img src="../../../.gitbook/assets/image (3) (1) (1).png" alt="" width="563"><figcaption></figcaption></figure>

Click **Install** to begin installation.

This screen confirms:

* Disk space required
* Installation scope (current user only)
* Target disk (e.g., Macintosh HD)
{% endstep %}

{% step %}
#### Background Item Registration

After installation, macOS displays a notification indicating that **mcp\_endpoint\_shield.sh** has been added as a background item.

<figure><img src="../../../.gitbook/assets/image (4) (1).png" alt="" width="512"><figcaption></figcaption></figure>

This means:

* MCP Endpoint Shield runs automatically in the background
* It starts on user login
* It can be managed via **Login Items & Extensions**

This is required for continuous endpoint monitoring.
{% endstep %}

{% step %}
#### Folder Access Permissions (Optional)

After installation, MCP Endpoint Shield may request permission to access specific folders in the user’s home directory:

* Desktop
* Documents
* Downloads

<div><figure><img src="../../../.gitbook/assets/image (5) (1).png" alt="" width="369"><figcaption></figcaption></figure> <figure><img src="../../../.gitbook/assets/image (7).png" alt="" width="375"><figcaption></figcaption></figure> <figure><img src="../../../.gitbook/assets/image (6).png" alt="" width="351"><figcaption></figcaption></figure></div>

These permissions are used to:

* Scan MCP-related files
* Validate configurations
* Monitor relevant artifacts within the user environment

**User Choice:**

* **Allow** – Enables folder-level scanning
* **Don’t Allow** – Skips access to that folder

{% hint style="info" %}
These permissions are optional. The application will continue to function even if access is denied, but scanning coverage may be limited.
{% endhint %}
{% endstep %}
{% endstepper %}
