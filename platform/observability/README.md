# Observability stack

Baseline:

- kube-prometheus-stack: Prometheus Operator, Prometheus, Alertmanager, Grafana
- Loki: logs example
- Tempo: traces example

For the lab, storage is intentionally ephemeral and retention is short. Production-like environments should use durable object/block storage, SLO-driven retention and authenticated ingress.

The kube-prometheus-stack chart version should be pinned in Git. At the time this portfolio layer was added in August 2026, upstream releases were in the 88.x line; review the latest compatible release before upgrades.
