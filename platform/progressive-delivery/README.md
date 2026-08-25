# Progressive delivery

This directory demonstrates Argo Rollouts separately from the default Deployment-based Helm chart.

The example canary moves through 20%, 50% and 100% rollout stages with a timed pause followed by a manual promotion point. In a real environment, the pause should be combined with AnalysisTemplates using Prometheus metrics such as error rate or latency.

Argo Rollouts v1.9.1 was the latest stable upstream release observed in July 2026; review upstream compatibility before installation or upgrade.
