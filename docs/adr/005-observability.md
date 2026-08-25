# ADR 005: Treat observability as platform capability

## Context
A deployment is not production-like if its health can only be checked with `kubectl get pods`.

## Decision
Use Prometheus Operator/Prometheus, Alertmanager and Grafana as the metrics/alerting baseline, with Loki and Tempo as log/trace extension examples.

## Consequences
Applications can be evaluated through metrics and alerts, while long-term storage sizing and retention remain environment-specific.
