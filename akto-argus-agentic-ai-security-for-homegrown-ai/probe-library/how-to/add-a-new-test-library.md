# Add a New Test Library

Probe libraries in Akto allow you to expand and customize your agentic security testing capabilities. This guide will walk you through the process of adding a new probe library to your Akto instance.

### Configuring the New Probe Library

1. Repository URL:
   * Enter the URL of the zip file containing your probe library YAML files
   * Example: \`[`https://github.com/akto-api-security/tests-library/archive/refs/heads/feature/input_validation_test_1.zip`](https://github.com/akto-api-security/tests-library/archive/refs/heads/feature/input_validation_test_1.zip)
2. File Size Limit:
   * Ensure your zip file is less than 10 MB in size

### Post-Addition Steps

1. Once added, your new probe library will appear in the list of available probe libraries on the Probe Library page
2. You can now use the probes from this library in your agentic security testing workflows

### Troubleshooting

* If the "Add" button doesn't respond, double-check the URL format and accessibility
* If you encounter errors after adding the library, verify the content and format of your YAML files

By following these steps, you can easily expand Akto's agentic security testing capabilities with your own custom probe libraries or third-party probe collections.
