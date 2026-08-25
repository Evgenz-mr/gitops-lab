# ADR 001: Use Argo CD for continuous delivery

## Context
The lab needs a declarative deployment model that demonstrates reconciliation and drift correction rather than imperative deployment from CI.

## Decision
Use Argo CD. CI validates changes; Argo CD owns deployment and continuously reconciles Kubernetes state with Git.

## Alternatives
Jenkins deployment stages and direct `helm upgrade` from CI were considered.

## Consequences
Git becomes the deployment source of truth and credentials for cluster deployment do not need to live in the application CI pipeline. Argo CD becomes a critical platform component that must itself be operated securely.
