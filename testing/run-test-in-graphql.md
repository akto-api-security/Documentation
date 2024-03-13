# Using Akto for GraphQL APIs

## Introduction

You can use Akto to help you secure your GraphQL APIs in CI/CD pipeline

 - Automate GraphQL [API Inventory](#api-inventory)
 - [Sensitive data exposure](#sensitive-data-exposure)
 - [Run test](#run-owasp-top-10-tests) for OWASP API top 10 vulnerabilities
 - Write your own [custom tests for GraphQL APIs](#custom-graphql-security-tests)
 - [Run tests in CI/CD](#run-tests-in-cicd)

## API Inventory

Akto can automatically prepare an API Inventory for GraphQL APIs. Use one of our [traffic connectors](../traffic-connections/traffic-data-sources/README.md). 
Akto will right away start populating APIs in the dashboard. You will see a separate entry for each `Query`, `Mutation` etc. You can see an example here.

Click on the API to see the schema for the query. 


## Sensitive data exposure
Go to [Sensitive Data](../api-inventory/concepts/sensitive-data.md) to check if your APIs are sending sensitive or PII data in the API response. You can also [configure Slack/Webhook alerts](../api-inventory/concepts/alerts.md) for the same.

## Run OWASP Top 10 tests
Click on the **Run Test** button to start testing your APIs for all OWASP Top 10 and Hackerone Top 10 vulnerabilities. 

## Custom GraphQL security tests
Using Akto's unique test editor, you can also write your own security tests for GraphQL APIs. See instructions for custom tests [here](../test-editor/overview.md).
There are a few GraphQL-specific instructions that you can use - 
 
- add-
- delete-
- modify-

## Run tests in CI/CD
You can also automate GraphQL Security Testing by using our [GitHub action](run-tests-in-cicd.md) or [pre-deployment hook](run-tests-in-cli-using-akto.md) to trigger tests in your CI/CD pipeline. 

Feel free to write us at support@akto.io for any help.