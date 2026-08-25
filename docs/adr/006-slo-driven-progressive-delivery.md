# ADR 006: Use SLO-driven analysis during progressive delivery

## Context
A canary rollout should not advance only because a timer expired. Platform automation should use measurable service health.

## Decision
Expose application metrics to Prometheus through ServiceMonitor resources and use an Argo Rollouts AnalysisTemplate to validate success rate during canary promotion.

## Consequences
Rollouts can automatically stop when observed health violates the chosen threshold. Metric naming and labels become part of the deployment contract and require ownership just like API schemas.
