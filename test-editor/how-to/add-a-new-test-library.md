# Add a New Test Library

Test libraries in Akto allow you to expand and customize your API testing capabilities. This guide will walk you through the process of adding a new test library to your Akto instance.

### Adding a New Test Library

{% @arcade/embed flowId="D4qbOHpjoA9wnWlOnsUh" url="https://app.arcade.software/share/D4qbOHpjoA9wnWlOnsUh" %}

### Configuring the New Test Library

1. Repository URL:
   * Enter the URL of the zip file containing your test library YAML files.
   * Example: \`[`https://github.com/akto-api-security/tests-library/archive/refs/heads/feature/input_validation_test_1.zip`](https://github.com/akto-api-security/tests-library/archive/refs/heads/feature/input\_validation\_test\_1.zip)
2. File Size Limit:
   * Ensure your zip file is less than 10 MB in size.

### Post-Addition Steps

1. Once added, your new test library will appear in the list of available test libraries on the Test Library page.
2. You can now use the tests from this library in your API testing workflows.

### Troubleshooting

* If the "Add" button doesn't respond, double-check the URL format and accessibility.
* If you encounter errors after adding the library, verify the content and format of your YAML files.

By following these steps, you can easily expand Akto's testing capabilities with your own custom test libraries or third-party test collections.
