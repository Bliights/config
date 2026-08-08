---
name: solve-problem
description: Resolve complex technical or product-engineering problems through evidence, decomposition, option generation, and explicit tradeoffs. Use when the desired outcome is clear but the solution is not, constraints interact, previous attempts stalled, or several plausible approaches must be compared; use diagnose-failure instead for a reproducible bug or failing system.
---

# Solve Problem

Turn a clear problem into a justified solution. Work read-only until the user authorizes experiments or implementation.

Read [the shared engineering contract](../_shared/engineering-contract.md) for simplicity, evidence, safety, and communication rules.

## Establish the problem model

Write one sentence for each:

- **Current state** - the observable situation now.
- **Target state** - the measurable outcome required.
- **Gap** - what prevents the target today.
- **Constraints** - limits that a valid solution must respect.
- **Invariants** - behavior or properties that must remain true.
- **Non-goals** - attractive adjacent work excluded from the decision.

If the goal or acceptance remains ambiguous, use `frame-problem`. If an observed system failure needs reproduction and localization, use `diagnose-failure`.

## Build evidence

1. Inspect relevant code, data flows, tests, configuration, documentation, metrics, history, incidents, and authoritative sources.
2. Separate observed facts from inference and user preference.
3. Identify the decision's reversibility, blast radius, cost of delay, and cost of being wrong.
4. Build a dependency or causal map: inputs, transformations, constraints, feedback loops, and outcomes.
5. Find the critical uncertainty whose answer would eliminate the most solution paths.

Do not collect context without a decision purpose. Every inspection should confirm a constraint, falsify an assumption, or discriminate between options.

## Decompose

Split the problem along stable boundaries:

- behavior versus mechanism;
- essential constraint versus inherited convention;
- local issue versus system interaction;
- reversible choice versus one-way door;
- known work versus uncertainty that needs an experiment.

Solve bottlenecks and high-information questions first. Avoid decompositions that merely mirror directories, teams, or an assumed solution.

## Generate solution shapes

Create two or three materially different candidates, including the smallest viable change or deliberate no-change baseline when credible. For each candidate state:

- mechanism and affected boundaries;
- constraints satisfied and violated;
- expected benefits;
- failure modes and abuse cases;
- complexity introduced and removed;
- reversibility and migration cost;
- evidence needed before commitment.

Do not create cosmetic variants of the same idea. Do not add a fashionable architecture merely to fill the option list.

## Discriminate with evidence

Choose the cheapest reliable method for the critical uncertainty:

- inspect an existing analogous path;
- calculate with real bounds;
- build a disposable spike;
- run a benchmark or focused experiment;
- create a contract example or test;
- obtain an authoritative constraint from documentation or the user.

Define the expected observation before running an experiment. Record results that contradict the preferred option.

## Decide

Compare candidates against ranked criteria: correctness, security, user impact, simplicity, compatibility, operability, delivery cost, reversibility, and evidenced future change. Avoid fake precision; use numeric scoring only when the criteria and weights are meaningful.

Recommend one option and state:

- why it wins now;
- the strongest rejected alternative and why it loses;
- assumptions and confidence;
- the evidence that would reverse the decision;
- the smallest safe next step.

Prefer the solution that makes the current problem easy to verify and the likely next change easy to perform, without building an imagined roadmap.

## Pre-mortem

Before handoff, assume the recommendation failed. Identify the three most plausible causes, their earliest observable signal, and one prevention or containment measure each. Reconsider the decision if a high-impact failure lacks containment.

## Handoff

- Route a system-boundary decision to `design-architecture` when deeper architectural work is required.
- Route an accepted multi-step solution to `plan-change`.
- Route an authorized focused change to `execute-change`.
- Route newly discovered broken behavior to `diagnose-failure`.

## Rationalizations to reject

| Rationalization | Correction |
| --- | --- |
| "The first workable idea is enough" | Compare it with the smallest credible alternative and the status quo. |
| "We need more research" | Name the decision and the observation the research will change. |
| "This is future-proof" | Name the evidenced future pressure and the present cost. |
| "A weighted score makes it objective" | Scores encode assumptions; keep causal evidence visible. |
| "We can solve the edge cases later" | Evaluate high-impact failure and denial paths before commitment. |

## Completion

Lead with the recommendation. Then provide the problem model, decisive evidence, compared options, tradeoffs, falsifiers, pre-mortem, and next step. Finish when the recommendation is testable, bounded, and supported more strongly than its alternatives.
