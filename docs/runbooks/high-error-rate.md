# Runbook: high HTTP error rate

## Signal
Alert indicates elevated 5xx responses or failed readiness checks.

## Triage

1. Check Argo CD application health and recent sync history.
2. Compare current image tag and Helm values with the last known healthy revision.
3. Inspect pod readiness/liveness events and restart counts.
4. Check Prometheus service metrics and resource saturation.
5. Check logs in Loki if enabled.

## Mitigation

- abort/pause a canary rollout when the new revision correlates with the failure
- rollback the Git change rather than manually patching live state
- scale temporarily only when saturation is confirmed

## Follow-up

Record root cause, missing alert coverage and whether the rollout policy should be tightened.
