# Platform layer

This directory extends the GitOps lab with cluster and platform engineering concerns that normally sit around application delivery.

## Components

- `networking/` - default-deny and explicit allow policies
- `ingress/` - TLS certificate and issuer examples for cert-manager
- `secrets/` - External Secrets Operator usage pattern without committed credentials
- `observability/` - kube-prometheus-stack, Loki and Tempo values/examples
- `progressive-delivery/` - Argo Rollouts canary example

## Installation model

Cluster-scoped controllers must not be embedded inside the application Helm chart. Install them once per cluster and let Argo CD manage their configuration afterwards.

Current upstream guidance supports cert-manager deployment through Helm/Argo CD and treats it as a cluster-level component. External Secrets Operator similarly manages CRDs and converts external provider data into Kubernetes Secrets.

Always review and pin component versions before production use.
