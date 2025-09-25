---
description: Overall strategy of test execution
---

# Strategy

### run\_once

By default, the test will be executed for each API. You might have scenarios where you want to run the test once per API collection. (Eg you want to check if `/docker-config.yml` is accessible or not)&#x20;

You can set this flag to `true` if you want to run the test once per API collection.&#x20;

```yaml
execute:
  requests:
    req: 
      - modify_url: /docker-config.yml
strategy:
  run_once: /
```

Irrespective of number of APIs, this test will run once per API collection
