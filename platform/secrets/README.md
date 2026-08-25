# External Secrets pattern

The manifests in this folder are examples only. They intentionally contain no provider credentials.

1. Install External Secrets Operator once in the cluster.
2. Configure provider identity using workload identity, IAM, Vault auth, Kubernetes auth or another supported mechanism.
3. Create a `SecretStore`/`ClusterSecretStore` appropriate for that provider.
4. Commit only the `ExternalSecret` reference to Git.

`external-secret-example.yaml` expects a SecretStore named `platform-secret-store` and a remote key named `gitops-demo/python-api`.
