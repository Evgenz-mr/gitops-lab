# Production-like GitOps Kubernetes Lab

A hands-on platform engineering lab demonstrating GitOps delivery of a small microservice suite with Argo CD, Helm and Kubernetes.

## Architecture

```text
Developer -> GitHub -> CI validation -> Git repository
                                      |
                                      v
                                   Argo CD
                                      |
                                      v
                                  Kubernetes
                         +------------+------------+
                         |            |            |
                       nginx        python        java
```

## What this repository demonstrates

- GitOps reconciliation with Argo CD
- Reusable Helm chart for multiple services
- NGINX, Python and Java test microservices
- Kubernetes probes, resources and security contexts
- HorizontalPodAutoscaler and PodDisruptionBudget support
- CI validation for Helm and Kubernetes manifests
- Secret scanning and configuration checks
- Architecture Decision Records (ADR)
- Separation between application, platform and GitOps configuration

## Repository structure

```text
app/                         application examples
argocd/                      Argo CD configuration
charts/microservice/         reusable Helm chart
services/nginx/              NGINX test service
services/python/             Python HTTP service
services/java/               Java Spring Boot service
infra/                       local Kubernetes bootstrap
.github/workflows/           CI validation
docs/adr/                    architecture decisions
```

## Test microservices

| Service | Runtime | Port | Purpose |
|---|---|---:|---|
| nginx | NGINX | 80 | Static frontend / ingress test |
| python | Python + Flask | 8080 | Lightweight API and health test |
| java | Java + Spring Boot | 8080 | JVM workload and readiness test |

All three services are deployed from the same reusable Helm chart with separate values files. This makes the repository useful for testing Argo CD synchronization, self-healing, image changes and multi-service rollouts.

## Quick start

Prerequisites: Ubuntu 22.04/24.04, 4+ GB RAM, Docker and MicroK8s.

```bash
./infra/microk8s-setup.sh
microk8s kubectl create namespace argocd
microk8s kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
microk8s kubectl apply -f argocd/microservices.yaml
```

Check applications:

```bash
microk8s kubectl get applications -n argocd
microk8s kubectl get pods -n gitops-demo
```

## GitOps workflow

1. Developer changes application or Helm values.
2. Pull request CI validates YAML, Helm templates and security-sensitive configuration.
3. Change is merged to `main`.
4. Argo CD detects Git drift.
5. Argo CD synchronizes the desired state into Kubernetes.
6. Automated self-healing restores resources when live state differs from Git.

## Production-oriented practices

The lab intentionally keeps infrastructure small, but demonstrates patterns expected in larger environments: declarative desired state, reusable charts, least-privilege container settings, health probes, resource requests/limits, autoscaling hooks, disruption budgets and automated validation.

## Security

The default chart supports non-root workloads where the container image permits it, drops Linux capabilities, disables privilege escalation, and uses read-only root filesystems selectively through values. CI includes secret scanning and Helm/YAML validation. Production environments should additionally use an external secrets solution, signed images, admission policies and network policies appropriate to the CNI.

## Design decisions

See [`docs/adr`](docs/adr/) for short Architecture Decision Records explaining why Argo CD and a reusable Helm chart are used.

## Known limitations

This repository is a portfolio/lab environment rather than a production distribution. Image registry credentials, TLS, external secrets, persistent observability backends and cloud infrastructure are intentionally environment-specific and are not hard-coded into the repository.
