---
name: auto-choose-workflow
description: Select and compose the shortest reliable skill flow for a non-trivial software-engineering request. Use at the start of work that may require framing, problem solving, architecture, planning, implementation, diagnosis, verification, review, audit, or release-readiness assessment, and when the user asks which skills apply.
---

# Auto Choose Workflow

Route before deep execution. Select only stages that create a decision or evidence, then continue unless the user requested routing only.

Read [the shared engineering contract](../_shared/engineering-contract.md) and [the risk tiers](../_shared/risk-tiers.md) when work may change code, configuration, data, dependencies, or runtime behavior.

## Inspect and classify

Inspect applicable instructions, repository state, manifests, CI, tests, and nearby documentation when a working directory exists. Resolve facts from the environment before asking the user.

Classify:

1. **Intent** - explain, frame, solve, design, plan, change, diagnose, verify, review, audit, or prepare release.
2. **Clarity** - executable, missing a user decision, unclear solution, or unresolved architecture.
3. **Size** - focused, multi-step, cross-cutting, or broad assessment.
4. **Risk** - `R0`, `R1`, `R2`, or `R3` from the shared risk tiers.

## Route

- Unclear goal, scope, user decision, or acceptance: `frame-problem`.
- Clear problem with an unclear solution or competing constraints: `solve-problem`.
- System boundary, public interface, quality-attribute tradeoff, or consequential evolution: `design-architecture`.
- Clear `R0` edit: `execute-change` -> focused `verify-change`.
- Clear `R1` change: `plan-change` when multi-step -> `execute-change` -> `verify-change` -> `review-change`.
- `R2` or `R3` change: resolve design or solution -> `plan-change` -> `execute-change` -> `verify-change` -> `review-change` -> `prepare-release-readiness` when production-facing.
- Reproducible failure or regression: `diagnose-failure` -> `execute-change` when a fix is authorized -> `verify-change` -> `review-change`.
- Evidence-only validation: `verify-change`.
- Diff, commit, branch, or pull-request review: `review-change`; for merge readiness, also test the integrated base-plus-head result inside disposable worktrees.
- Broad codebase or subsystem assessment: `audit-codebase`.
- Project onboarding or project instruction refresh: `bootstrap-project-context` when explicitly requested.
- Prompt rewriting: `improve-prompt` when explicitly requested.
- Read-only factual explanation: answer directly.

Re-route only when evidence changes the problem class, risk tier, or authorized scope. A credible security blocker stops the route and preserves sanitized evidence.

## Output

For execution, mention the route only when it helps the user evaluate risk or scope, then continue. For routing-only requests, return the classification, risk tier, selected flow, one-sentence rationale, and unresolved user decisions or `None`.

Finish when the route is unambiguous, every mandatory risk gate is present, and execution can continue without a material silent assumption. No route may end in commit, push, merge, deploy, approval, comment, or external publication.
