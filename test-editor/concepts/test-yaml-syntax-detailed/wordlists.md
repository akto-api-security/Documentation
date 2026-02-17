---
description: You can use wordlists in Akto's YAML tests
---

# Wordlists

Wordlists have multiple use cases in API Security testing -

1. Test API by fuzzing a parameter with different malicious values eg. SQL Injection.
2. Test API by replacing a specific parameter (eg `user_id`) by values from other users.

You can add a `wordlists` section in your YAML file.

#### Example of a static wordlist:

Say, you have an API which takes `file` as a query paramter. You can use the following YAML to hit the same API with multiple malicious file paths.

```yaml
wordLists:
  filePaths: 
    - /etc/passwd
    - /etc/lsb-release
    - /etc/shadow
    - /etc/hosts
    - /proc/self/environ
    - /proc/self/cmdline
    - /proc/self/cwd/index.php
    - /proc/self/cwd/application.py
    - /proc/self/cwd/main.py"
    - /proc/self/exe

execute:
  type: single
  requests:
    - req:
      - modify_query_param:
          file: ${filePaths}  # this is how you refer to a wordlist ${wordlist_name}

```

#### Example of a dynamic wordlist

You can also create a wordlist of your own from the traffic data.

For example, you have a profile data API `/api/v1/user-info?user_id=834cc2de-050b-4a2f-8b54-67b1847d3591`. You want to carry a BOLA attack where you want to replace user\_id `834cc2de-050b-4a2f-8b54-67b1847d3591` by other value user ids. These valid user ids are present in other APIs in your Akto dashboard.

You can create a wordlist of all values from all your APIs in the following manner -

```yaml
wordLists:
  user_ids:
    source: sample_data
    key: 
      regex: "^UserId$|^UserID$|^User-ID$|^user_id$|^user-id$|^userid$"
    all_apis: true
    
execute:
  type: single
  requests:
    - req:
        - modify_query_param:
            user_id: ${user_ids}
    

```

This will create a wordlist dynamically from your traffic data. It will resolve to create a wordlist similar to -

* 185ad0f5-f4da-4ca6-bf25-2f337ce5c928
* 3e00c415-1a0c-4026-9863-43627416e5d1
* 3700ad8c-a517-4c14-8c7b-489214ee8b50
* 22d0d22f-17f5-440f-a2fe-03a919e348c4

### Using Multiple Wordlists Together

You can **combine multiple wordlists** in the same test to build richer, more exhaustive scenarios. This is useful when your API parameters depend on combinations of values—for instance, names with roles, paths with tokens, or header values with payloads.

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
