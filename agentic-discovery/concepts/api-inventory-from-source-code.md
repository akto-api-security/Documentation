---
hidden: true
---

# Agent Component Discovery from Source Code

Akto supports creating agent component inventory from source code with the help of our code analysis tool. Simply run our code analysis tool on your source code repositories to discover agent components and MCP endpoints, including shadow agents. This source code-based inventory integrates seamlessly with the traffic-based discovery.

### Why create inventory from source code?

1. Discover agent components directly from source code.
2. Discover new components in PRs by integrating our code analysis tool in your CI/CD pipelines.
3. Discover shadow agents in your applications.
4. Review the component source code using the provided source code links (if available).

### How to use

To get started with creating component inventory from source code, choose between the following two methods depending on where your source code is hosted:

1. [Extract components from github hosted source code using our Github Action](../how-to/extract-apis-from-source-code-gha.md)
2. [Extract components from source code using our Docker based CLI](../how-to/extract-apis-from-source-code-docker-cli.md)

The following frameworks are currently supported:

1. Spring Boot
2. Django
3. ExpressJS
4. Mux
5. LangChain
6. LlamaIndex

If your application is using a framework not listed above, please reach out to `help@akto.io`.
