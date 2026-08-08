# Review baseline

## Severity

- **P0 Critical** - exploitable security issue, data loss, broken core behavior, or unsafe migration requiring an immediate stop.
- **P1 High** - likely correctness, security, compatibility, availability, or data-integrity failure on a supported path.
- **P2 Medium** - reachable defect or demonstrated maintainability cost under limited conditions.
- **P3 Low** - bounded quality problem with concrete impact; never a personal style preference.

Do not inflate severity. A finding needs a concrete reachable scenario, not a theoretical preference.

## Axes

### Intent and correctness

- Match the originating requirement and non-goals.
- Handle empty, boundary, malformed, concurrent, and error states relevant to the change.
- Preserve public behavior unless the change explicitly migrates it.
- Avoid partial updates, inconsistent state, off-by-one errors, and swallowed failures.

### Design and clarity

- Use honest names and straightforward control flow.
- Keep related behavior local and interfaces smaller than implementations.
- Flag duplication, shotgun surgery, speculative generality, feature envy, primitive obsession, and repeated conditionals only when demonstrated in the diff.
- Prefer existing repository patterns and dependencies.
- Require each new abstraction, flag, dependency, or layer to solve a current demonstrated problem.
- Preserve evidenced extension seams while rejecting speculative generality.

### Tests and verification

- Require a behavior test for each behavior change and a regression test for each bug fix.
- Test public seams rather than private implementation details.
- Mock external APIs and nondeterminism with synthetic, deterministic data.
- Cover relevant failure paths, not only successful responses.
- Confirm claimed commands were actually executed.
- Confirm repository-native pre-commit ran without bypass flags, or that an explicit equivalent gate was reported when no hook exists.

### Security and operations

- Trace untrusted input to privileged sinks.
- Check authentication, authorization, ownership, and tenant boundaries.
- Check secrets, logging, personal data, transport, dependency changes, and insecure defaults.
- Check timeouts, retries, idempotency, rollback, migrations, and destructive actions.

### Performance

- Look for unbounded work, repeated queries, excessive allocations, blocking operations, contention, and missing pagination.
- Require evidence before claiming an optimization or regression.

## Finding validity test

A candidate is actionable only when all answers are `yes`:

1. Is it introduced or materially worsened by the reviewed change?
2. Is there a reachable trigger rather than a theoretical possibility?
3. Is the wrong outcome concrete and meaningful?
4. Does the cited line contain the cause or the smallest useful part of it?
5. Have nearby tests, guards, callers, and configuration been checked for mitigation?
6. Would fixing it improve correctness, safety, compatibility, operability, or demonstrated maintenance cost?

Discard findings that merely request a different naming taste, framework, abstraction style, or unrelated cleanup.
