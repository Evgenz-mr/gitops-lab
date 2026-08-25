# Production-like GitOps Kubernetes Platform Lab

A hands-on Senior DevOps / Platform Engineering portfolio project demonstrating GitOps delivery, security controls, observability and progressive delivery on Kubernetes.

## Architecture

```text
Developer
   |
   v
GitHub -> CI validation / image build / security scan
   |
   v
Argo CD ------------------------------+
   |                                  |
   v                                  v
Kubernetes                         Platform services
   |                                  |
   +-- nginx                           +-- cert-manager
   +-- python                          +-- External Secrets Operator
   +-- java                            +-- kube-prometheus-stack
   |                                  +-- Loki / Tempo examples
   +-- Ingress + TLS                   +-- Argo Rollouts
   +-- NetworkPolicies                 +-- Grafana / Alerting
   +-- HPA / PDB
```

## What this repository demonstrates

- GitOps reconciliation with Argo CD
- reusable Helm chart for several runtimes
- NGINX, Python and Java test microservices
- readiness/liveness probes, resources, HPA and PDB
- ingress and TLS patterns with cert-manager
- default-deny and least-privilege NetworkPolicy examples
- External Secrets Operator integration pattern
- Prometheus/Grafana monitoring with Loki/Tempo extension examples
- progressive delivery with Argo Rollouts
- CI validation and secret/configuration checks
- Architecture Decision Records and operational documentation

## Repository structure

```text
argocd/                      Argo CD applications and ApplicationSets
charts/microservice/         reusable workload Helm chart
services/                    NGINX / Python / Java workloads
platform/
  networking/                NetworkPolicies
  ingress/                   cert-manager/TLS examples
  secrets/                   External Secrets integration
  observability/             Prometheus, Loki and Tempo values/examples
  progressive-delivery/      Argo Rollouts examples
docs/
  adr/                       architecture decisions
  architecture.md            platform architecture
  runbooks/                  operations guidance
infra/                       local Kubernetes bootstrap
.github/workflows/           CI validation
```

## GitOps flow

1. Developer changes source, Helm values or platform configuration.
2. CI validates charts/manifests and performs security-oriented checks.
3. The change is merged into `main`.
4. Argo CD detects desired-state drift and reconciles Kubernetes.
5. Health probes, metrics and alerts expose runtime state.
6. Progressive delivery canary steps provide a controlled rollout path.

## Test microservices

| Service | Runtime | Port | Purpose |
|---|---|---:|---|
| nginx | NGINX | 80 | ingress, TLS and static workload testing |
| python | Python + Flask | 8080 | lightweight API and health testing |
| java | Java + Spring Boot | 8080 | JVM workload, actuator and readiness testing |

## Platform components

The `platform/` directory contains production-oriented integration examples. Cluster-scoped controllers such as cert-manager and External Secrets Operator should be installed once per cluster and are deliberately separated from application charts. Review and pin component versions before using these examples outside a lab.

## Security model

The lab demonstrates non-root workloads where possible, dropped Linux capabilities, disabled privilege escalation, NetworkPolicies, secret-manager integration patterns and CI checks. No real credentials are stored in Git.

## Observability

`kube-prometheus-stack` provides Prometheus Operator, Prometheus, Alertmanager and Grafana. Loki/Tempo examples show how logs and traces can be layered on top. See `docs/runbooks/` for operational response examples.

## Progressive delivery

`platform/progressive-delivery/` contains an Argo Rollouts canary example with staged traffic percentages and manual pause points. This is intentionally separate from the default Deployment-based chart so both standard and progressive rollout patterns remain easy to compare.

## Quick start

```bash
./infra/microk8s-setup.sh
microk8s kubectl create namespace argocd
microk8s kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
microk8s kubectl apply -f argocd/microservices.yaml
```

Optional platform components are documented in `platform/README.md`.

## Design decisions

See `docs/adr/` for Architecture Decision Records covering GitOps, reusable Helm charts, platform controllers, secrets and observability.

## Scope

This is a portfolio/lab project, not a drop-in production distribution. Cloud-specific storage classes, DNS, ACME issuer configuration, external secret providers and long-term observability storage are intentionally environment-specific.
