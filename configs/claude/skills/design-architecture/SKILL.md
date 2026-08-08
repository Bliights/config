---
name: design-architecture
description: Design or evolve software architecture using explicit quality attributes, boundaries, options, tradeoffs, and migration paths. Use when creating a subsystem, changing ownership or data flow, defining public interfaces, addressing cross-cutting architectural pressure, evaluating build-versus-buy, or making a consequential system-level decision; do not use for a local implementation detail.
---

# Design Architecture

Produce the smallest architecture that satisfies the important forces and can evolve safely. Stay read-only unless the user authorizes prototypes or documentation changes.

Read [the shared engineering contract](../_shared/engineering-contract.md). Read [the architecture decision template](references/decision-record.md) when recording a decision or proposing an ADR.

## Establish decision scope

Define the decision, owner, deadline, affected capabilities, non-goals, and whether it is reversible. If the required behavior is unclear, route to `frame-problem`. If the challenge is solution selection below the system-boundary level, use `solve-problem`.

## Map the current system

Inspect rather than infer:

1. entry points, critical user journeys, and public contracts;
2. domain responsibilities, module boundaries, and dependency direction;
3. data ownership, schemas, consistency rules, queues, caches, and side effects;
4. deployment units, runtime topology, scaling boundaries, and failure domains;
5. identity, trust boundaries, secrets, and privileged actions;
6. observability, recovery, migrations, tests, CI, and operational ownership;
7. prior ADRs, compatibility commitments, incidents, and recurring change patterns.

Draw a diagram only when it makes ownership, flow, or failure propagation clearer than prose. Mark facts, assumptions, and unknowns distinctly.

## Rank architectural forces

Translate vague qualities into scenarios:

- **Performance** - workload, percentile, latency or throughput target, and resource bound.
- **Reliability** - failure, expected behavior, recovery objective, and data-loss tolerance.
- **Security** - actor, protected asset, trust boundary, abuse case, and required control.
- **Scalability** - current load, credible horizon, growth shape, and independent scaling need.
- **Modifiability** - likely change, affected modules, acceptable change surface, and rollout constraint.
- **Operability** - detection, diagnosis, rollback, support ownership, and cost boundary.
- **Compatibility** - consumers, observable contracts, migration window, and deprecation rules.

Rank the top three forces. Architecture cannot maximize every quality simultaneously.

## Design boundaries and contracts

Place responsibilities where they maximize:

- **cohesion** - related rules and data change together;
- **locality** - a behavior can be understood without following many pass-through layers;
- **leverage** - one focused change improves several real callers;
- **testability** - public seams expose behavior and isolate nondeterministic boundaries;
- **ownership** - one component owns each invariant and source of truth;
- **containment** - failures and privileges stop at explicit boundaries.

Prefer deep modules with small interfaces. Define contracts before internals: inputs, outputs, errors, idempotency, versioning, authorization, consistency, and observability.

## Generate options

Create two or three materially different architectures, including minimal evolution of the current system when viable. For each option provide:

- responsibility and data-flow sketch;
- public contracts and ownership;
- behavior under the ranked quality scenarios;
- failure propagation and recovery;
- security and privacy effects;
- operational and team cost;
- migration, compatibility, and rollback shape;
- new dependencies and irreversible commitments;
- complexity removed as well as complexity introduced.

Avoid option theater: several deployment technologies with the same boundaries count as one architecture unless their tradeoffs change the decision.

## Stress-test

Walk each option through:

1. normal critical path;
2. malformed or unauthorized input;
3. partial dependency failure and timeout;
4. duplicate, reordered, or concurrent work;
5. scale or load boundary;
6. schema, interface, or dependency evolution;
7. deploy, rollback, and recovery;
8. observability during an incident.

Use a spike or measurement only for a decision-critical uncertainty. Define its success and discard criteria before building it.

## Decide and migrate

Recommend the simplest option that meets the ranked scenarios with acceptable risk. State the strongest rejected alternative, decisive tradeoff, assumptions, and evidence that would reopen the decision.

Use additive or expand-contract migration:

1. characterize current behavior and establish safety tests;
2. introduce the new contract or path alongside the old one;
3. migrate callers or data in observable increments;
4. verify adoption, compatibility, security, and operations;
5. remove the old path only after evidence shows it is unused and rollback is no longer required.

Route an accepted architecture to `plan-change`. Do not hide the migration inside a single implementation task.

## Rationalizations to reject

| Rationalization | Correction |
| --- | --- |
| "This is the industry standard" | Show how it satisfies this system's ranked scenarios. |
| "We may need it at scale" | Define credible scale and the signal for introducing complexity. |
| "Microservices improve separation" | Boundaries and ownership create separation; deployment units add costs. |
| "The diagram looks clean" | Trace runtime data, failure, migration, and operational paths. |
| "We can migrate in one release" | Use expand-contract unless atomic replacement is proven safe. |

## Completion

Lead with the decision and its decisive tradeoff. Include current-system evidence, ranked quality scenarios, options, stress-test results, selected boundaries and contracts, migration, rollback, unresolved risks, and an ADR-ready summary. Finish when a plan can be written without reopening the architectural decision.
