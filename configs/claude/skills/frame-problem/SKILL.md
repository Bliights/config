---
name: frame-problem
description: Frame vague or consequential problems before planning. Use when goals, constraints, success criteria, scope, or important decisions are unclear, or when several materially different solutions remain possible.
---

# Frame Problem

Convert ambiguity into a decision-ready problem statement. Stay read-only unless the user separately authorizes changes.

Read [the shared engineering contract](../_shared/engineering-contract.md) for the design and communication defaults.

## Establish the boundary

Start with the current behavior, the desired observable outcome, who or what is affected, and why the difference matters. Record explicit non-goals early so nearby ideas do not silently enter scope.

## Process

1. Read applicable instructions and inspect relevant code, configuration, documentation, logs, interfaces, and tests.
2. Build four ledgers: **facts**, **assumptions**, **unknowns**, and **user decisions**.
3. Resolve factual unknowns from the environment or authoritative sources.
4. Trace the affected journey or data flow from entry point to observable result.
5. Identify invariants, compatibility obligations, trust boundaries, and failure consequences.
6. Map decisions by dependency. Ask only decisions whose prerequisites are settled.
7. For each decision, give a recommendation, its reason, its cost, and the condition that would change it.
8. Compare only materially different solution shapes. Prefer the simplest shape that meets current needs and preserves evidenced extension seams.
9. Convert the result into acceptance criteria that can be verified without interpreting intent.

## Decision tree rules

- Ask one compact question when an answer determines later questions.
- Group independent decisions only when the user can answer them without extra context.
- Do not ask the user for repository facts that inspection can reveal.
- State a safe default when an unknown is low-impact and reversible.
- Stop and request direction when a choice changes public behavior, destructive effects, data ownership, security posture, cost, or external coordination.

## Framed problem contract

Produce:

- **Problem** - current state, desired state, and impact.
- **Goal / non-goals** - one outcome and clear exclusions.
- **Affected paths** - users, systems, interfaces, and data flows.
- **Constraints** - technical, product, security, compatibility, and operational rules.
- **Invariants** - behavior that must remain true.
- **Decisions** - chosen options with concise rationale.
- **Risks and unknowns** - owner, impact, and resolution path.
- **Acceptance** - observable success, boundary, denial, and failure behavior.
- **Assumptions** - only those still carried into planning.

## Red flags

- Implementation details are being selected before the behavior is clear.
- "Scalable" or "future-proof" appears without a measured or evidenced pressure.
- A requirement cannot be mapped to an affected user or system.
- Acceptance criteria describe internal implementation instead of observable behavior.
- A security, privacy, or destructive-operation decision is treated as a minor default.
- The solution includes adjacent cleanup that is not required for the outcome.

Finish when every decision that can materially change the problem is settled or explicitly blocked. Route next to `solve-problem` when the solution remains unclear, `design-architecture` for a system-level decision, or `plan-change` when the implementation shape is already settled.
