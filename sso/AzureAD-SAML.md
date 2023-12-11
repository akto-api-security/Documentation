---
description: >-
  Learn how to enable Single-Sign-On(SSO) through Azure AD using SAML configuration.
---

# Configure Azure AD SAML SSO

Follow these steps to configure SAML SSO using Azure Active Directory.

### 1. Create new application.
Step 1: <br/>
Navigate to `Enterprise applications`.

Step 2: <br />
Add a new application

Step 3: 
1. Click on the `+ New application` button.

<figure><p align="center"><img src="../.gitbook/assets/Azure-saml-1.png" alt="Create new application" height= '250px'></p></figure> 
<br />

2. After clicking on `+Create your own Application` write `Akto` as the name of your app.
Choose the `Integrate any other application you don't find in the gallery (Non-gallery)` option and then click on `Create`.
m

<figure><p align="center"><img src="../.gitbook/assets/Azure-saml-2.png" alt="Create your own application" height= '300px' width="450px"></p></figure> 
<br />

### 2. Assign users and groups

To enable users to access Akto using Azure Active Directory Single Sign-On (SSO), the following prerequisites must be met:

1. **Assigned to the Application:**
   Users must be assigned to the 'Akto' application within the Azure Active Directory.

2. **User Profile Attributes:**
   Users should have the following attributes defined on their profile:
   - First Name
   - Last Name
   - User Principal Name
   - Email

<figure><p align="center"><img src="../.gitbook/assets/Azure-saml-3.png" alt="Assign roles" height= '300px' width="650px"></p></figure> 
<br />


### 3. Set up SAML settings

In the Azure Active Directory admin center, select the 'Akto' Enterprise application. Set up single sign on for the 'Akto' application, selecting `SAML` as the sign-on method. Use the following SAML settings.
Here `{ hostname }` is the value of your domain hostname where you are hosting the Akto application.


**NOTE:**
  `Sign on URL` must be in `https:` format and not `http` for configuring SAML.

1. Under `Set up single sign on`, click on `SAML`.
2. **Basic SAML Configuration**

    | Setting     | Value        |
    | -------- | ----------------  |
    | Identifier (Entity ID)     | { hostname } |
    | Reply URL (Assertion Consumer Service URL)    | { hostname }/signup-azure-saml    |
    | Sign on URL    | { hostname }/signup-azure-request       |

<figure><p align="center"><img src="../.gitbook/assets/Azure-saml-4.png" alt="SAML configs" height= '300px' width='750px'></p></figure> 
<br />


### 4. Import Azure Federation Metadata into Akto Dashboard
1. On the same page you configured SAML settings in the Azure Active Directory admin center, download the `Federation Metadata XML` file (listed under the SAML Signing Certificate).

<br/>
<figure><p align="center"><img src="../.gitbook/assets/Azure-saml-5.png" alt="Download certificate" height= '300px' width="600px"></p></figure> 
<br />

2. Navigating in Akto dashboard.<br />
    **Settings => Integrations => Azure SSO SAML**
    
3. Click on `Configure`, and then upload the metadata xml file.
    <figure><p align="center"><img src="../.gitbook/assets/Azure-saml-6.png" alt="Upload file" width='600px'></p></figure> 
    <br />

4. `Logout` to test the configuration by clicking "Sign in with Azure SSO".

<figure><p align="center"><img src="../.gitbook/assets/Azure-saml-7.png" alt="Test" height="400px"></p></figure> 
    <br />