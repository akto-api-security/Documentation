# Modify Data

<table data-full-width="true"><thead><tr><th width="386.1845703125">API</th><th>Description</th></tr></thead><tbody><tr><td>[<strong>POST /api/createGuardrailPolicy</strong>](#createguardrailpolicy)</td><td>Create a new guardrail policy with specified rules and configuration.</td></tr><tr><td>[<strong>POST /api/deleteGuardrailPolicies</strong>](#deleteguardrailpolicies)</td><td>Delete one or more existing guardrail policies.</td></tr><tr><td>[<strong>POST /api/guardrailPlayground</strong>](#guardrailplayground)</td><td>Test and validate guardrail rules in a sandboxed playground environment before deployment.</td></tr><tr><td>[<strong>POST /api/saveBrowserExtensionConfig</strong>](#savebrowserextensionconfig)</td><td>Save or update configuration for browser extension-based guardrail detection.</td></tr><tr><td>[<strong>POST /api/updateMaliciousEventStatus</strong>](#updatemaliciouseventstatus)</td><td>Update the status of detected malicious events (e.g., mark as active, ignored, training, or under review).</td></tr><tr><td>[<strong>POST /api/deleteMaliciousEvents</strong>](#deletemaliciousevents)</td><td>Delete or purge recorded malicious events from the guardrail database.</td></tr><tr><td>[<strong>POST /api/modifyThreatActorStatus</strong>](#modifythreatatcorstatus)</td><td>Update the status of a guardrail actor (e.g., mark as active, inactive, or mitigated).</td></tr><tr><td>[<strong>POST /api/modifyThreatActorStatusCloudflare</strong>](#modifythreatatcorstatuscloudflare)</td><td>Update the status of guardrail actors detected via Cloudflare integration.</td></tr><tr><td>[<strong>POST /api/bulkModifyThreatActorStatusCloudflare</strong>](#bulkmodifythreatatcorstatuscloudflare)</td><td>Bulk update the status of multiple guardrail actors detected via Cloudflare integration.</td></tr><tr><td>[<strong>POST /api/apiInfo/bulkAgentProxyGuardrail</strong>](#apiinfobulkagentproxyguardrail)</td><td>Bulk retrieve or manage API information related to Agentic proxy guardrails.</td></tr><tr><td>[<strong>POST /api/saveFilterYamlTemplate</strong>](#savefilteryamltemplate)</td><td>Save a custom filter YAML template for reuse in guardrail or issue analysis.</td></tr></tbody></table>

## Guardrail Policy Management

### createGuardrailPolicy

### deleteGuardrailPolicies

### guardrailPlayground

## Event & Actor Management

### updateMaliciousEventStatus

### deleteMaliciousEvents

### modifyThreatActorStatus

### modifyThreatActorStatusCloudflare

### bulkModifyThreatActorStatusCloudflare

## Configuration & Integration

### saveBrowserExtensionConfig

### saveFilterYamlTemplate

### apiInfo/bulkAgentProxyGuardrail

