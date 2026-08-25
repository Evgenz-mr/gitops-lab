# Service Level Objectives

This lab demonstrates how operational targets can drive both alerting and deployment decisions.

## Example objectives

- Availability: 99.9% successful HTTP requests over a rolling 30-day period.
- Latency: 95% of Python API requests complete below 500 ms.
- Deployment safety: canary promotion requires at least 95% successful requests during the analysis window.

These are demonstration targets rather than promises about a production service. In a real platform, SLOs should be derived from user impact, historical reliability, dependency budgets and business requirements.
