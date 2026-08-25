# Observability flow

```text
Python / Java
  | metrics
  v
ServiceMonitor -> Prometheus -> PrometheusRule -> Alertmanager
                         |
                         +-> Grafana

Applications -- OTLP --> OpenTelemetry Collector --> Tempo

Container logs -------------------------------> Loki
```

The intended investigation path is metrics -> traces -> logs. Alerts link to runbooks so an engineer can move from symptom to evidence and remediation without relying on tribal knowledge.
