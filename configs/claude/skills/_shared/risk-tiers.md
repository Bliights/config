# Engineering Risk Tiers

Use the highest applicable tier. Reclassify when scope, data flow, authority, compatibility, or deployment assumptions change.

## R0 - Local and reversible

Examples: documentation, comments, tests only, or a behavior-preserving edit with no public contract change.

Required flow:

- inspect the touched surface;
- run focused repository-native checks;
- review the final diff.

## R1 - Standard behavior change

Examples: a bounded feature, bug fix, refactor, or configuration change with an established implementation pattern.

Required flow:

- define acceptance evidence;
- implement in tested vertical slices;
- run focused and broader relevant checks;
- run pre-commit or its repository equivalent;
- review the final diff.

## R2 - Sensitive or cross-cutting

Examples: authentication, authorization, personal or durable data, public APIs, dependencies, concurrency, external services, migrations, or changes spanning ownership boundaries.

Required flow:

- resolve architecture or solution choices before implementation;
- identify assets, trust boundaries, abuse cases, and failure modes;
- define compatibility, migration, rollback, and observability evidence;
- run security, integration, contract, failure-path, and repository quality gates;
- perform a full change review.

## R3 - Critical or hard to reverse

Examples: destructive data operations, production cutovers, tenant isolation, privileged infrastructure, security controls, or changes whose failure has broad or irreversible impact.

Required flow:

- obtain the material user decisions before implementation;
- use an explicit decision record and staged rollout plan;
- prove rollback or document why rollback is impossible and how impact is contained;
- require independent review evidence and release-readiness assessment;
- stop on missing authority, environment, recovery evidence, or unresolved security risk.

The agent may prepare and verify local changes at every tier. It leaves the result uncommitted for the user and does not push, merge, deploy, publish, or send external messages.

## Traceability

For R1-R3, assign stable identifiers when more than one criterion or risk exists:

- `AC-n` for acceptance criteria;
- `RISK-n` for material risks;
- `TASK-n` for implementation slices;
- `TEST-n` for proof;
- `EVIDENCE-n` for observed command or runtime results.

Maintain the chain `AC/RISK -> TASK -> TEST -> EVIDENCE`. Finish only when each material criterion and risk has evidence or an explicit blocked reason.
