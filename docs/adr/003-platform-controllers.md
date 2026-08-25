# ADR 003: Keep cluster controllers outside application charts

## Context
cert-manager, External Secrets Operator and Argo Rollouts own CRDs or cluster-level controllers and have lifecycles different from application releases.

## Decision
Install and manage platform controllers separately from workload charts.

## Consequences
Application charts remain small and portable, controller upgrades can be governed independently, and cluster-scoped resources are not accidentally installed repeatedly by each service.
