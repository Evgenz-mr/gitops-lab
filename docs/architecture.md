# Platform architecture

## Control plane

Git is the desired-state source. CI performs validation and build/security checks, while Argo CD owns reconciliation into Kubernetes. This avoids giving ordinary CI jobs broad cluster deployment credentials.

## Application plane

Three small services exercise different runtime characteristics:

- NGINX: simple network/ingress target
- Python: small API workload
- Java: JVM workload with Spring Boot Actuator probes

All services share one reusable Helm chart where the Kubernetes primitives are identical.

## Platform plane

- cert-manager owns certificate lifecycle
- External Secrets Operator materializes application secrets from an external provider
- NetworkPolicy limits east/west and ingress traffic
- Prometheus/Grafana expose service and cluster health
- Loki/Tempo represent logs/traces extensions
- Argo Rollouts demonstrates canary rollout control

## Reliability model

Deployments use probes, requests/limits and PodDisruptionBudgets. HPA can be enabled per workload. Alerts and runbooks are treated as part of the service lifecycle rather than as a separate monitoring afterthought.
