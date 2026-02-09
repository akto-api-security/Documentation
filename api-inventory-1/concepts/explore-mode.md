# Explore mode

Explore Mode allows users to efficiently browse and filter APIs from their existing inventory, and create collections based on the filtered results.

{% @arcade/embed url="https://app.arcade.software/share/CmTQE2SZ1L6XkaPNV5Dc" flowId="CmTQE2SZ1L6XkaPNV5Dc" %}

### Key Features

#### Filtering APIs

Explore Mode provides several filtering options to help users narrow down their API search:

* API list: Select from available API lists
* API collection: Choose specific API collections
* API endpoint: Search for particular endpoints
* Method: Filter by HTTP method (GET, POST, etc.)
* Path matches regex: Use regular expressions to filter API paths
* Host name matches regex: Filter by host names using regex

#### Viewing Results

After applying filters, the interface displays:

1. A summary of filtered results, e.g., "Listing 200 endpoints out of total 2776 endpoints"
2. A table of matching API endpoints with the following information:
   * HTTP method
   * API path
   * Risk score
   * Hostname
   * Access Type (e.g., No access type, Private, Public)
   * Auth type (e.g., JWT, unauthenticated, custom\_authorization\_header)
   * Sensitive params
   * Source location
   * Last seen date

You can further categorize results using tabs:

1. All
2. New
3. Sensitive
4. High risk
5. No auth
6. Shadow

### Usage Tips

* Use the "Add condition" button to apply multiple filters for more precise results
* The "Clear all" option allows you to reset all applied filters
* Adjust filters incrementally to refine your search
* Save frequently used filter combinations as collections for quick access in future sessions

Explore Mode streamlines the process of discovering and organizing APIs within your inventory, enabling more efficient API management and integration workflows. Learn [How to create collections using Explore mode](../how-to/add-collection-using-explore-mode.md).
