---
description: Overall strategy of probe execution
---

# Strategy

### run\_once

By default, the probe will be executed for each API. You might have scenarios where you want to run the probe once per API collection. (Eg you want to check if `/docker-config.yml` is accessible or not)

You can set this flag to `true` if you want to run the probe once per API collection.

```yaml
execute:
  requests:
    req: 
      - modify_url: /docker-config.yml
strategy:
  run_once: /
```

Irrespective of number of APIs, this probe will run once per API collection
