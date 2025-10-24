# Analysis

The **Analysis tab** in Akto's Agentic Security Posture provides a prioritized list of security issues across your AI agent ecosystem. It converts raw scan data from agent components, MCP endpoints, and LLM integrations into actionable insights by highlighting agentic risks, affected components, and recommended remediation steps.

Instead of overwhelming teams with hundreds of alerts, **Analysis organizes issues into prioritized action items (P0, P1, P2)**, helping security teams focus on the most critical agentic vulnerabilities first.

***

### 🔎 Key Concepts

1. **Action Items**
   * Each issue is grouped into an **action item** (e.g., "Agent components exposing sensitive data" or "MCP endpoints missing authentication").
   * Action items are designed to be **team-focused** so Dev, AI/ML, and Security teams know exactly what to fix in their autonomous systems.
2. **Priority Levels (P0, P1, P2)**
   * **P0:** Immediate attention required - critical agentic vulnerabilities posing high business risk (e.g., prompt injection, unrestricted tool access)
   * **P1:** High-severity issues with significant impact on agent security
   * **P2:** Medium or low severity issues in agent components, often handled in bulk remediation
3. **Details per Action Item**
   * **Description** – Explains the agentic security issue and how many components are impacted
   * **Team** – Suggests which team should handle remediation (AI/ML, Security, or Platform)
   * **Efforts** – Estimated effort (Low/Medium/High) to secure agent components
   * **Why It Matters** – Explains the risk (e.g., "Enables prompt injection attacks" or "Violates GDPR for LLM data processing")
4. **Drill-Down View**
   * Clicking an action item reveals **specific agent components** affected, with details such as:
     * Agent component endpoint & method
     * MCP server and tool details
     * Sensitive data in agent interactions
     * Risk score for autonomous systems
     * Type of issue (Prompt Injection, Tool Abuse, Auth, Data Leakage, etc.)
     * Hostname and deployment environment

***

### ✅ Benefits

* **Prioritization:** Focus on the highest-risk agentic vulnerabilities first
* **Collaboration:** Clearly assign issues to AI/ML, Dev, or Security teams responsible for agent components
* **Compliance Alignment:** Map agentic risks to regulatory concerns like GDPR for LLM data processing, PCI-DSS for payment agents, and HIPAA for healthcare AI
* **Efficiency:** Reduce noise by grouping related agent component issues instead of surfacing duplicates
* **Agentic Context:** Understand how vulnerabilities impact autonomous systems and tool chains
