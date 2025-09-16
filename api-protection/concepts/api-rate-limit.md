
# API Abuse 

### Akto's Next Gen API Rate Limits Discovery:

Traditional rate limits require predefined RPM per API. At scale (hundreds of APIs), this is impractical. As organizations evolve, API traffic patterns change, making static limits brittle.

Traffic varies by endpoint (e.g., `/cancel-booking` vs `/book`) and over time (e.g., marketing spikes). Akto learns per-endpoint baselines and adapts as patterns shift.


#### Key Innovations
**Adaptive Learning:** Learns real usage over time.

**Endpoint-Specific Baselines:** Builds per-endpoint limits.

**Dynamic Adaptation:** Adjusts to spikes and longer-term shifts.

<figure><img src="../../.gitbook/assets/api-usage-distribution.png" alt=""><figcaption></figcaption></figure>


## How to configure 

By default, Akto Threat Protection applies a global rate limit rule.

To change settings, go to **Settings → Threat Configuration**.

### Default Configuration
Global dynamic rule that auto-learns per-endpoint baselines over 2 days.
Uses p75 with 20% overflow and 0.5 confidence to throttle anomalies.

- **Rule Name**: `Global Rate Limit Rule`
- **Period**: `5 minutes`
    - Window duration
- **Behaviour**: `Dynamic`
    - Uses auto‑learned limits
- **Baseline Period**: `2 days`
    - Days used to learn usage patterns
- **Percentile**: `p75`
    - Requests made by 75% of users
- **Overflow Percentage**: `20`
    - Allowed burst above baseline
- **Rate Limit Confidence**: `0.5`
    - Minimum confidence in learned patterns 



<figure><img src="../../.gitbook/assets/rate-limit-config.png" alt=""><figcaption></figcaption></figure>