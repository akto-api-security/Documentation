## Imperva Schema Import

### Overview
- Import API definitions discovered by Imperva into Akto.
- Creates or reuses an Akto API collection based on the hostname present in the Imperva export.
- Runs asynchronously; once accepted, imported endpoints appear under API Collections.

### Key Features
- Import from Imperva export JSON (single file).
- Automatically creates a new collection named after the hostname if it doesn’t exist; otherwise reuses it.
- Ingests endpoints with associated request data (method, path, headers, cookies, query params) from the file.

### Steps (in the Dashboard)
1. Go to Quick Start in the Akto Dashboard.
2. Open the Imperva import card under Manual Section OR Search for Imperva import.
3. Click File and choose your Imperva export json file.
4. Confirm the selected filename appears.
5. Click Upload.

### After Import
- Navigate to Custom tab under API Discovery page.
- Look for a collection named after the hostname present in the Imperva file.
- Open the collection to see discovered endpoints.

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
