---
description: Learn how to remove bad components in Akto dashboard.
---

# Remove Bad Components

Akto gives users options to ignore static file components or components having default payloads. This documentation helps you maintain a clean and efficient component inventory in your Akto setup.

We have two methods for removing bad components from your inventory:

1. [Select file type](remove-bad-endpoints.md#selecting-static-endpoints-file-type)
2. [Add default payloads](remove-bad-endpoints.md#adding-default-payloads)

## Ways to remove bad components in Akto

### Selecting static component file types

1. Navigate to `Settings`. Then open `About` tab in the left nav.
2. Click on the `Select redundant url types` button in `More settings` section on the page.
3. Select the `File types` which you want to ignore and Akto will ignore those components from the future. You can also remove some default types we ignore.

### Adding default payloads

1. Navigate to `Settings`. Then open `Default payloads` tab in the left nav.
2. Click on `Add your own` and then enter the domain name of the URLs you want to ignore.
3. After adding domain name, enter the regex for response payload.
4. Akto will now ignore components where response payload matches the regex.
5. On re-uploading traffic, the matched components will be ignored and not stored in the inventory.

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
