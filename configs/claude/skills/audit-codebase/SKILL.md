---
name: audit-codebase
description: Audit a codebase or selected subsystem and prioritize evidence-backed improvements without changing files. Use when the user requests a broad health assessment, architecture analysis, technical-debt review, or improvement roadmap rather than a single diff review.
disable-model-invocation: true
---

# Audit Codebase

Assess code health and produce a prioritized improvement roadmap. Audit in read-only mode; do not turn observations into broad refactors.

Read [the shared engineering contract](../_shared/engineering-contract.md) and [the scoring model](references/scoring-model.md).

## Set the audit contract

Define:

- scope and explicit exclusions;
- business-critical journeys and failure consequences;
- architecture or quality questions the audit must answer;
- available evidence: code, tests, CI, incidents, metrics, history, and documentation;
- depth limit and time budget when provided.

If the user names no scope, start with repository boundaries and use risk signals to select representative paths. Do not imply exhaustive coverage.

## Map before judging

Build a compact system map:

1. entry points and public interfaces;
2. domain modules and ownership boundaries;
3. data stores, schemas, migrations, queues, and caches;
4. external services and trust boundaries;
5. deployment, configuration, observability, and failure recovery;
6. test layers, fixtures, CI, pre-commit, and release gates;
7. recent churn, repeated bugs, fragile hotspots, and dependency concentration.

Trace at least one critical path end to end. Architecture diagrams and directory names are hypotheses until runtime flow and call sites support them.

## Audit lenses

Evaluate each sampled path through these lenses:

- **Correctness** - invariants, state transitions, error handling, concurrency, idempotency, and data integrity.
- **Security** - trust boundaries, validation, authorization, secrets, isolation, dangerous operations, dependency exposure, and safe defaults.
- **Design** - cohesive responsibilities, small interfaces, dependency direction, coupling, locality, and change amplification.
- **Simplicity** - unnecessary layers, pass-through wrappers, premature abstractions, clever control flow, duplication, and dead paths.
- **Testability** - public seams, deterministic boundaries, failure coverage, fixture quality, and tests that can detect regressions.
- **Future change** - repeated change patterns, compatibility pressure, migration safety, and whether current seams support evidenced next needs.
- **Operations** - configuration safety, observability, bounded resources, degradation, rollback, and recovery.
- **Delivery** - format, lint, types, builds, security tools, pre-commit, CI consistency, and reproducibility.

## Evidence standard

Create a candidate only when it has:

- a concrete location and affected path;
- the current behavior or design mechanism;
- an observable cost, risk, or change-amplification example;
- evidence from code plus at least one supporting source when practical: tests, history, metrics, incidents, configuration, or repeated pattern;
- a bounded improvement direction;
- a verification and rollback story.

Use the deletion test for abstractions: if removing a layer leaves behavior and clarity unchanged, the layer may not be earning its cost. Treat this as a question to verify, not an automatic deletion rule.

## Prioritize

Score findings with the reference model. Prioritize security and data-integrity blockers first, then high-leverage improvements that reduce repeated change cost or enable tests. Prefer sequencing that makes a change easy before making the easy change.

Recommendations should be:

- **keep** - the current design is justified;
- **repair** - a focused defect or weak boundary;
- **simplify** - preserve behavior while reducing cognitive load;
- **reshape** - change a module boundary or dependency direction;
- **retire** - remove only after callers, compatibility, and evidence permit it;
- **investigate** - evidence is insufficient and a specific measurement is needed.

## Roadmap contract

For each recommended initiative, provide outcome, affected scope, evidence, prerequisites, smallest safe first slice, tests or characterization needed, security considerations, migration or rollback shape, verification gates, and stop conditions.

Use expand-contract for wide changes. Separate characterization, prefactoring, migration, and removal when combining them would make the change unsafe or hard to review.

## Red flags

- Recommending a rewrite because the code looks old or unfamiliar.
- Scoring style preferences as architecture defects.
- Claiming future-readiness without evidence of likely change.
- Suggesting new dependencies or platforms without a measured current cost.
- Treating test coverage percentage as proof of behavior quality.
- Listing dozens of low-value smells without ranking or a causal impact.
- Proposing removal before tracing callers, runtime use, and compatibility.

## Handoff

Route a selected system-level initiative to `design-architecture` before `plan-change`; route a localized but solution-unclear initiative to `solve-problem`.

## Output

Lead with the overall health conclusion and the top three decisions. Then provide the system map, prioritized findings, roadmap, retained strengths, coverage limits, and unanswered measurements. Keep evidence close to each recommendation.

Finish when every recommendation is evidence-backed, prioritized, safely sequenced, and testable, and the report distinguishes observed facts from inference.
