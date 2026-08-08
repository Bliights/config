# Architecture Decision Record

Use this compact structure for a durable decision. Record why the decision is correct under current forces, not a transcript of the discussion.

## Title

`ADR-NNN: Verb-led decision`

## Status

Proposed, accepted, superseded, or deprecated. Include the date, owners, and the ADR that supersedes this one when applicable.

## Context

- decision that must be made;
- current system and triggering pressure;
- ranked quality-attribute scenarios;
- constraints, invariants, and non-goals;
- evidence and material uncertainties.

## Options

For each materially different option:

- mechanism and boundaries;
- benefits under the ranked scenarios;
- costs and failure modes;
- security, compatibility, and operational effects;
- reversibility and migration cost.

Include minimal evolution or the status quo when it is credible.

## Decision

State the chosen option, decisive tradeoff, and why it wins now. Name assumptions and the evidence that would reopen the decision.

## Consequences

Separate:

- positive consequences;
- accepted costs and risks;
- new constraints or operational duties;
- follow-up measurements and review date.

## Migration and rollback

Define additive introduction, caller or data migration, compatibility window, adoption evidence, removal criteria, rollback path, and owner.

## Verification

List the tests, security checks, load or failure experiments, observability signals, and operational proof required before the decision is considered implemented.
