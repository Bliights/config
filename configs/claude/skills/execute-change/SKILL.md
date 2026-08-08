---
name: execute-change
description: Implement an approved change in small verified slices. Use when requirements or a plan are sufficiently clear and the user wants code or configuration changed, including feature work, refactors, migrations, and authorized bug fixes.
---

# Execute Change

Implement the smallest complete solution in verified vertical slices. Keep the repository runnable, reviewable, and easy to revert.

Read [the shared engineering contract](../_shared/engineering-contract.md) and [the risk tiers](../_shared/risk-tiers.md) before editing.

## Preflight

1. Confirm the authorized outcome, scope, non-goals, risk tier, acceptance criteria, and material risk identifiers.
2. Inspect the current implementation, call sites, neighboring patterns, tests, and repository state. Preserve unrelated changes.
3. Discover focused and full format, lint, type, test, build, security, and pre-commit commands from checked-in sources.
4. Run the narrow relevant baseline when practical. Record verified baseline failures separately.
5. Identify trust boundaries, external APIs, persistence, authentication, authorization, tenant ownership, secrets, and destructive operations.
6. Select the smallest vertical slice and the test that will prove it.

## RED-GREEN-REFACTOR slice loop

1. **RED** - add or update one behavior-focused test and observe the expected failure. For a bug, reproduce the reported symptom.
2. **BOUNDARY** - create deterministic fake data for network, time, randomness, filesystem, queue, or external-service behavior. Verify request shape and response/error mapping.
3. **GREEN** - implement only enough production code to pass the test with safe defaults.
4. **REFACTOR** - improve names, locality, duplication, and interfaces while keeping behavior fixed and tests green.
5. **CHECK** - run focused tests and the touched-scope format, lint, and type checks.
6. **REVIEW** - inspect the diff for scope drift, unsafe data flow, accidental secrets, debug code, dead code, and unnecessary abstraction.
7. **CONTINUE** - start the next slice only while the current slice is green.

Prefer public-interface tests. Mock unstable boundaries such as network, time, randomness, filesystem, and external services; avoid mocking internal implementation details.

## Implementation rules

- Follow existing architecture and naming before introducing a new pattern.
- Prefer direct code until a real repeated concept or boundary earns an abstraction.
- Keep interfaces small and responsibilities cohesive.
- Preserve current compatibility unless the accepted change explicitly breaks it.
- Add characterization tests before changing poorly understood legacy behavior when no reliable specification exists.
- Use additive or expand-contract changes for broad migrations.
- Keep incomplete behavior unreachable through a safe default or an existing feature-flag mechanism.
- Add the minimum logs, metrics, traces, or health signals required to operate production-facing behavior; never log secrets or sensitive payloads.
- Do not mix unrelated cleanup, dependency upgrades, formatting churn, or generated changes into the slice.
- Never commit, amend, tag, push, or publish. Leave the verified changes in the worktree for the user.

## Final gate

After the last code edit:

1. Run focused tests for each changed behavior.
2. Run broader relevant tests and the build or runtime check.
3. Run applicable security checks early enough to avoid wasting work, then repeat affected checks after security-relevant edits.
4. Run the repository's configured pre-commit gate. Never bypass it. Inspect and rerun after auto-fixes.
5. Perform the simplicity check from the shared contract.
6. Confirm documentation, compatibility, observability, migration, and rollback tasks required by the risk tier are complete.
7. Hand the stable diff to `verify-change`, then `review-change` when the change is consequential.

## Stop conditions

Stop the line on an unexpected failure, credible vulnerability, leaked secret, authorization gap, destructive production effect, missing test seam, or discovery that changes approved scope. Preserve the evidence and route to `diagnose-failure` or the user instead of stacking speculative edits.

## Completion

Finish only when every implemented behavior and material risk has meaningful test evidence, repository-native quality and pre-commit gates pass or are reported as blocked, no unresolved security blocker remains, and the final explanation is short and evidence-led. Leave the changes uncommitted for the user.
