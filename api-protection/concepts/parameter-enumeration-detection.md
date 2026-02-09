# Parameter Enumeration Detection

## Overview

Parameter enumeration detection identifies API access patterns where a caller systematically varies parameter values to discover unauthorized resources. Such behavior commonly indicates **Insecure Direct Object Reference (IDOR)** attempts and broken object-level authorization.

The detection focuses on identifying abnormal growth in unique parameter values over a defined time interval for a specific API endpoint.

## How Akto Detects Parameter Enumeration

Akto evaluates API request traffic to track the number of distinct values observed for request parameters. Detection triggers when the observed number of unique values crosses a configured threshold within a rolling time window.

The detection logic evaluates:

* API endpoint identity
* Parameter name and value uniqueness
* Observation window duration

The evaluation operates independently of authentication outcomes, since IDOR attacks often use valid credentials.

## Configuration Location in Akto

Parameter enumeration detection configuration is available from the Akto dashboard.

{% stepper %}
{% step %}
### Navigate to Threat Configuration

Access the configuration using the following navigation path:

* Log in to the Akto dashboard
* Open **Settings**
* Navigate to **Threat Configuration**
{% endstep %}

{% step %}
### Configure Parameters

#### 1. Unique Parameter Threshold

Unique Parameter Threshold defines the minimum number of distinct parameter values required to flag enumeration activity for an API endpoint.

**Example:**\
A threshold value of `50` triggers detection when more than 50 unique values for the same parameter appear within the configured window.

#### 2. Window size (Minutes)

Window Size defines the time interval used to count unique parameter values.

**Example:**\
A window size of `5 minutes` evaluates parameter activity observed during the most recent five-minute interval.

<figure><img src="../../.gitbook/assets/image (186).png" alt=""><figcaption></figcaption></figure>
{% endstep %}
{% endstepper %}

## Detection Output

When parameter enumeration activity exceeds configured limits, Akto generates a security event under the **API Threat Protection** category.

The event includes:

* Impacted API endpoint
* Enumerated parameter name
* Count of unique values observed
* Detection time window

The event supports correlation with authorization behavior, traffic baselines, and actor context.
