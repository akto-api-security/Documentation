# Analysis

The **Analysis tab** in Akto’s API Security Posture provides a prioritized list of security issues across your API ecosystem. It converts raw scan data into actionable insights by highlighting risks, affected endpoints, and recommended remediation steps.

Instead of overwhelming teams with hundreds of alerts, **Analysis organizes issues into prioritized action items (P0, P1, P2)**, helping security and development teams focus on what matters most.

<figure><img src="../../.gitbook/assets/image (134).png" alt=""><figcaption></figcaption></figure>

***

### 🔎 Key Concepts

1. **Action Items**
   * Each issue is grouped into an **action item** (e.g., “APIs returning sensitive data” or “Missing authentication methods”).
   * Action items are designed to be **team-focused** so Dev, QA, and Security teams know exactly what to fix.
2. **Priority Levels (P0, P1, P2)**
   * **P0:** Immediate attention required, high business risk.
   * **P1:** High-severity issues with significant impact.
   * **P2:** Medium or low severity issues, often best handled in bulk remediation.
3. **Details per Action Item**
   * **Description** – Explains the issue and how many APIs are impacted.
   * **Team** – Suggests which team should handle remediation.
   * **Efforts** – Estimated effort (Low/Medium/High).
   * **Why It Matters** – Explains the risk (e.g., “Violates GDPR compliance” or “Exposes sensitive data”).
4. **Drill-Down View**
   * Clicking an action item reveals **specific endpoints** affected, with details such as:
     * Endpoint & method (GET, POST, etc.)
     * Sensitive parameters detected
     * Risk score
     * Type of issue (Sensitive Data, Auth, etc.)
     * Hostname

***

### ✅ Benefits

* **Prioritization:** Focus on the highest-risk issues first.
* **Collaboration:** Clearly assign issues to Dev, QA, or Security teams.
* **Compliance Alignment:** Map risks to regulatory concerns like GDPR, PCI-DSS, HIPAA.
* **Efficiency:** Reduce noise by grouping related issues instead of surfacing duplicates.
