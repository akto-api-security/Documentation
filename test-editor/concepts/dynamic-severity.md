# Dynamic Severity

Akto provides a method to assign severity to a test template dynamically. This means that you can change the severity of a test based on various filter on the API. This helps in providing contextual severity to the test based on the API.

Let's check an example, which is used for severity in Excessive data exposure tests to better understand this.

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

Here, we have three objects in the `dynamic_severity` list. The `check` attribute evaluates some condition on the API, in this case we are checking the access type of an API, and returns the severity based on it. So, in case the API is vulnerable to this test, the issue severity would be low if it's a private API, high if it's a public API and medium would be the default (In case access type is neither of these or not defined).

This helps you to prioritize vulnerabilities in more important APIs and the best part is that you can modify the conditions in `dynamic_severity` according to your needs.

NOTE: It is required to provide a default severity when using `dynamic_severity`. In case it is not defined, default is taken to be `HIGH`.

