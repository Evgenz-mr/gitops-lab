# ADR 002: Use one reusable Helm chart for demo microservices

## Context
The NGINX, Python and Java services share the same Kubernetes deployment primitives but differ in images, ports, probes and runtime security settings.

## Decision
Maintain a generic `microservice` chart and provide per-service values files.

## Alternatives
A separate chart per service or raw Kubernetes YAML per service.

## Consequences
Common platform behavior stays consistent and changes can be tested across several workloads. Service-specific features that diverge significantly may eventually justify dedicated charts.
