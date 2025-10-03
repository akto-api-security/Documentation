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
