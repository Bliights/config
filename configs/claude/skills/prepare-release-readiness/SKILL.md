---
name: prepare-release-readiness
description: Assess whether a verified change is operationally ready for release without deploying it. Use for production-facing changes, migrations, public contracts, feature flags, high-risk releases, or when the user asks for rollout, rollback, launch, or release-readiness guidance.
---

# Prepare Release Readiness

Produce a local release decision packet. Inspect and verify; do not deploy, publish, merge, push, approve, comment, or mutate an external system.

Read [the shared engineering contract](../_shared/engineering-contract.md) and [the risk tiers](../_shared/risk-tiers.md).

## Establish the release candidate

Pin the exact diff or revision, target environment, risk tier, acceptance criteria, compatibility window, and intended rollout. Do not combine evidence from different revisions.

## Assess readiness

1. Confirm `verify-change` evidence and unresolved findings from `review-change`.
2. Check backward and forward compatibility across clients, schemas, events, configuration, and rolling deployments.
3. For data changes, verify expand-contract order, backfill idempotency, reconciliation, rate limits, recovery, and removal criteria.
4. Define feature-flag ownership, safe defaults, activation stages, expiry, and cleanup.
5. Define rollout stages, health signals, observation windows, abort thresholds, and responsible owner.
6. Define rollback steps and the point after which rollback becomes unsafe; use roll-forward containment when reversal cannot be proven.
7. Confirm logs, metrics, traces, dashboards, and symptom-based alerts expose success and failure without leaking sensitive data.
8. Check runbooks, operator actions, support impact, user-facing documentation, ADRs, and known limitations.

## Verdict

Return one verdict:

- **READY** - release evidence, containment, observation, and recovery are complete.
- **CONDITIONAL** - release is safe only after named conditions are satisfied.
- **BLOCKED** - a material safety, compatibility, operational, or authority gap remains.

## Output

Lead with the verdict. Provide the pinned candidate, rollout stages, signals and thresholds, rollback or containment, required manual actions, blockers, and residual risks. Draft commands or external messages locally when useful, but do not execute release or communication actions.

Finish when a human release owner can make the decision without rediscovering the change or its operational risks.
