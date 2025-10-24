# Dynamic Severity

Akto provides a method to assign severity to a probe template dynamically. This means that you can change the severity of a probe based on various filters on the agent component or MCP endpoint. This helps in providing contextual severity to the probe based on the component's characteristics.

Let's check an example, which is used for severity in Excessive data exposure probes to better understand this.

```yaml
dynamic_severity:
- check:
    api_access_type:
      eq: private
  return: LOW
- check:
    api_access_type:
      eq: public
  return: HIGH
- return: MEDIUM
```

Here, we have three objects in the `dynamic_severity` list. The `check` attribute evaluates some condition on the agent component, in this case we are checking the access type of a component, and returns the severity based on it. So, in case the component is vulnerable to this probe, the issue severity would be low if it's a private component, high if it's a public component and medium would be the default (In case access type is neither of these or not defined).

This helps you to prioritize vulnerabilities in more important agent components and the best part is that you can modify the conditions in `dynamic_severity` according to your needs.

NOTE: It is required to provide a default severity when using `dynamic_severity`. In case it is not defined, default is taken to be `HIGH`.

