---
name: plan-change
description: Create an ordered, implementation-ready plan from clear requirements. Use when a change spans multiple steps or files, dependencies are unclear, risk is non-trivial, or acceptance and verification need to be defined before coding.
---

# Plan Change

Create a plan that a fresh agent can execute one task at a time. Plan in read-only mode and use the repository as the source of truth.

Read [the shared engineering contract](../_shared/engineering-contract.md) and [the risk tiers](../_shared/risk-tiers.md) before designing tasks.

## Preconditions

Confirm the goal, non-goals, acceptance criteria, authorized scope, risk tier, and unresolved decisions. Route to `frame-problem` when the required outcome is unclear, `solve-problem` when the solution is unresolved, or `design-architecture` when a system-level boundary or quality tradeoff remains open.

## Process

1. Trace the current implementation from public entry point to side effects and outputs.
2. Inspect neighboring patterns, public contracts, tests, fixtures, manifests, CI, pre-commit configuration, and recent related history.
3. Map dependencies, ownership boundaries, migrations, compatibility surfaces, and rollout constraints.
4. Identify assumptions. Resolve repository facts and mark the remaining assumptions with a validation task.
5. Select test seams and mock boundaries before implementation tasks.
6. Threat-model touched trust boundaries before investing in downstream work.
7. Choose a slicing strategy and order tasks by dependency and learning value.
8. End every task at a working, reviewable checkpoint with explicit evidence.

## Slicing strategy

Prefer thin vertical slices that deliver one observable path across the necessary layers. Use another strategy only when the shape of the work requires it:

- **Risk-first spike** - prove an uncertain integration or technical constraint with disposable or clearly bounded work.
- **Contract-first** - define a stable interface, then use mocks or fixtures so consumers and providers can progress independently.
- **Prefactor** - first make the behavior easy to change without changing it, then perform the small behavior change.
- **Expand-contract** - add the new path, migrate callers, verify adoption, then remove the old path in a later safe step.

Each task should fit one focused session. Split tasks with several independent outcomes, unrelated subsystems, or verification that cannot be run together.

## Task contract

For each task, provide:

- **Outcome** - one observable result.
- **Traceability** - linked `AC-n`, `RISK-n`, `TEST-n`, and expected evidence when identifiers are required.
- **Why now** - dependency, risk, or learning unlocked by this task.
- **Scope** - likely files, modules, interfaces, and explicit exclusions.
- **Implementation shape** - enough direction to preserve architecture without dictating incidental syntax.
- **Acceptance** - success, boundary, denial, and failure behavior.
- **Tests first** - exact test seam and the failure that proves the test is meaningful.
- **Mocks and data** - deterministic fakes, fixtures, clock/random controls, or contract samples.
- **Security** - trust boundary, abuse case, safe default, and required early gate.
- **Compatibility** - affected callers, data, schemas, events, versions, and deprecation window.
- **Operations** - logs, metrics, traces, rollout signals, abort threshold, and owner when production-facing.
- **Documentation** - required user documentation, runbook, ADR, or explicit `None`.
- **Quality gates** - focused commands plus final format, lint, type, test, build, security, and pre-commit commands discovered from the repo.
- **Rollback** - flag, additive migration, compatibility step, or reversal notes when relevant.

## Design checkpoint

For every new abstraction, dependency, option, or layer, state the current problem it solves. Prefer a deep module with a small interface over a chain of pass-through wrappers. Preserve likely extension seams only when current architecture, roadmap, or repeated changes provide evidence.

## Plan quality test

Before returning the plan, verify:

- every acceptance criterion maps to at least one task and one check;
- every material risk maps to containment and evidence;
- every task has a precondition and observable completion signal;
- tasks leave the repository working between slices;
- high-risk unknowns are tested before dependent implementation;
- external APIs have deterministic mock data and a contract-verification story;
- security blockers can stop the workflow early;
- the final task includes repository-native pre-commit and full relevant verification;
- `R2` and `R3` plans include compatibility, observability, rollout, and rollback evidence;
- the plan contains no drive-by cleanup or speculative architecture.

## Red flags

- A task is named "implement backend" or "add tests" without an observable outcome.
- Tests are deferred to the end.
- A migration removes the old path before callers move.
- The plan assumes a command, convention, or interface that was not inspected.
- The same change is repeated manually across a broad surface without automation or an expand-contract strategy.
- "Refactor as needed" hides unbounded scope.

Finish when a fresh agent can execute the tasks in order without rediscovering the architecture or inventing verification. Wait for approval only when the plan contains a material user choice or the user requested approval before implementation.
