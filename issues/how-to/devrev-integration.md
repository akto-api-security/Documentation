# DevRev Integration

This guide will help you set up DevRev Integration in Akto to automatically create and track security issues in your DevRev workspace.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Setting Up DevRev Integration](#setting-up-devrev-integration)
- [Updating DevRev Integration](#updating-devrev-integration)
- [Removing DevRev Integration](#removing-devrev-integration)
- [Troubleshooting](#troubleshooting)

---

## Prerequisites

Before setting up the DevRev Integration, ensure you have:

1. **DevRev Account**: An active DevRev organization account
2. **DevRev Personal Access Token (PAT)**: You'll need to generate a PAT with appropriate permissions
   - Navigate to your DevRev settings to create a new Personal Access Token
   - Ensure the token has permissions to create work items and access parts
3. **DevRev Organization URL**: Your organization's DevRev URL (e.g., `https://app.devrev.ai/your-org-slug`)

---

## Setting Up DevRev Integration

### Step 1: Navigate to Integrations Settings

1. Log in to your Akto dashboard
2. Click on **Settings** in the main navigation menu
3. Select **Integrations** from the settings sidebar

### Step 2: Select DevRev Integration

1. On the Integrations page, locate the **DevRev** card
2. Click on the DevRev card to open the configuration page

### Step 3: Enter DevRev Organization URL

1. In the **DevRev Organization URL** field, enter your complete DevRev organization URL
   - Example: `https://app.devrev.ai/your-org-slug`
2. Ensure the URL is correct and includes the protocol (https://)

### Step 4: Enter Personal Access Token

1. In the **Personal Access Token** field, paste the PAT you generated from DevRev
2. Keep this token secure and do not share it

### Step 5: Fetch DevRev Parts

1. Click the **Fetch Parts** button
2. Akto will connect to DevRev's API using your token and retrieve available parts/projects
3. Wait for the parts to load (you'll see a loading indicator)

### Step 6: Select DevRev Parts

1. Once parts are fetched, a dropdown menu will appear showing all available DevRev parts
2. Select one or more parts where you want to create security issues
3. You can search for specific parts using the dropdown's search functionality

![Placeholder: Screenshot showing Parts dropdown with multiple selections]

### Step 7: Save Configuration

1. Click the **Save** button to store your DevRev integration configuration
2. You'll see a success notification confirming the integration has been set up

### Step 8: Verify Integration

1. The page will now show your configured DevRev integration
2. You should see the organization URL and selected parts displayed

![Placeholder: Screenshot showing configured DevRev integration details]

---
## Updating DevRev Integration

You can update your DevRev integration settings at any time.

### Step 1: Return to DevRev Settings

1. Navigate to **Settings** > **Integrations** > **DevRev**
2. Your current configuration will be displayed

### Step 2: Modify Settings

1. Update the **Organization URL** if needed
2. To update the **Personal Access Token**:
   - Enter a new token in the field
   - Or leave it blank to keep the existing token
3. Click **Fetch Parts** if you need to refresh the available parts
4. Modify your selected parts as needed

### Step 3: Save Changes

1. Click the **Update** button
2. You'll see a confirmation that your integration has been updated

---

## Removing DevRev Integration

If you need to remove the DevRev integration:

### Step 1: Access DevRev Settings

1. Go to **Settings** > **Integrations** > **DevRev**

### Step 2: Remove Integration

1. Click the **Remove** button at the bottom of the page
2. Confirm the removal when prompted
3. The integration will be deleted from your Akto account

### Step 3: Verify Removal

1. You'll be redirected back to the Integrations page
2. The DevRev integration will no longer show as configured
3. The "Create DevRev ticket" option will no longer appear in the Issues page

---

## Troubleshooting

### Issue: "Failed to fetch parts"

**Possible causes:**
- Invalid Personal Access Token
- Token doesn't have required permissions
- Network connectivity issues
- Incorrect Organization URL

**Solutions:**
1. Verify your Personal Access Token is valid in DevRev settings
2. Generate a new token with proper permissions
3. Check your network connection
4. Ensure the Organization URL is correct

### Issue: "Ticket creation failed"

**Possible causes:**
- No parts selected in configuration
- Token expired or revoked
- Selected part no longer exists in DevRev

**Solutions:**
1. Return to DevRev integration settings
2. Verify parts are selected
3. Update your Personal Access Token
4. Re-fetch parts to ensure they're current

### Issue: "Cannot see DevRev option in Issues page"

**Possible causes:**
- DevRev integration not configured
- Integration removed or failed

**Solutions:**
1. Verify DevRev integration is properly configured in Settings
2. Check that parts are selected
3. Try removing and re-adding the integration

---

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
