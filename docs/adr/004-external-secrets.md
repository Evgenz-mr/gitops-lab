# ADR 004: Do not store application credentials in Git

## Context
GitOps requires declarative configuration but Git must not become a plaintext credential store.

## Decision
Use External Secrets Operator as the integration pattern. Git contains only ExternalSecret/SecretStore references; real values remain in an external provider.

## Consequences
Secret rotation can happen independently of application manifests. Provider identity and access control become critical dependencies and must be configured per environment.
