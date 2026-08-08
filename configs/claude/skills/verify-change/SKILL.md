---
name: verify-change
description: Prove that a code or configuration change is safe and works. Use after implementation, before review or completion, when the user asks to test or validate, or whenever tests, formatting, lint, types, builds, API behavior, and cybersecurity risks need evidence.
---

# Verify Change

Verification is an evidence pipeline, not a final test command. Start with checks that can stop unsafe work early, then expand from the changed behavior to the relevant system.

Read [the shared engineering contract](../_shared/engineering-contract.md) and [the risk tiers](../_shared/risk-tiers.md). Read [the security gate](references/security-gate.md) whenever the change crosses a trust boundary. Read [the API testing guide](references/api-testing.md) when APIs, webhooks, queues, external services, or nondeterministic dependencies are involved.

## Build the verification matrix

Inspect the request, plan, final diff, repository instructions, CI, test configuration, and pre-commit setup. Map each acceptance criterion and changed risk to evidence:

| ID | Claim or risk | Best evidence | Command or observation | Status |
| --- | --- | --- | --- | --- |

Inventory changed behavior, contracts, dependencies, schemas, configuration, generated files, privileges, data flows, and operational effects. A file list alone is not a verification scope.

## Gate 1: cybersecurity stop line

Run the relevant security checks before expensive broad verification:

1. Inspect the diff for secrets, credentials, private data, debug endpoints, unsafe defaults, and security controls weakened or removed.
2. Trace untrusted input through validation, authorization, storage, commands, queries, templates, logs, and outputs.
3. Verify authentication, ownership, tenant isolation, and server-side authorization at every changed sensitive action.
4. Check destructive operations, migrations, uploads, paths, redirects, URLs, deserialization, and outbound requests for abuse cases.
5. Review dependency and lockfile changes with repository-native audit tools when available.
6. Inspect new packages, install scripts, artifact provenance, and dependency ownership for supply-chain risk.
7. Run focused security tests for denial paths and unsafe inputs.

Stop immediately on a credible blocker. Preserve sanitized evidence, identify affected scope, and route to `diagnose-failure`. Do not continue broad workflow merely to collect green checks around an unsafe change.

## Gate 2: repository conformance

Discover commands from checked-in sources. Prefer the same wrappers and scripts used by CI.

Run, in the narrowest useful scope:

- generated-file or schema consistency checks;
- formatter check or repository-prescribed formatting command;
- lint and static analysis;
- type checking;
- focused tests for the changed behavior.

When a formatter or hook edits files, inspect the diff and restart affected verification. Record baseline failures separately only after observing them on an appropriate baseline.

## Gate 3: test quality

Do not count a passing test unless it could detect the wrong behavior.

- Confirm a new regression test failed for the intended reason before the fix when evidence exists.
- Assert observable outputs, side effects, calls across real boundaries, and denial behavior.
- Cover relevant success, boundary, error, retry, timeout, and idempotency paths.
- Keep mocks aligned with real contracts and verify request shape as well as response handling.
- Avoid snapshots or broad truthy assertions that can pass while behavior is wrong.
- Check that tests are deterministic, isolated, and free of production data or credentials.

## Gate 4: integration and runtime

Expand only as the changed surface requires:

1. related module or package tests;
2. integration or contract tests;
3. database migration forward/rollback or compatibility checks;
4. build and packaging;
5. runtime smoke test or end-to-end path;
6. performance, concurrency, accessibility, or browser checks when acceptance or risk demands them.

For `R2` and `R3`, also verify compatibility, observability signals, rollout containment, and rollback or roll-forward evidence. Route production-facing candidates to `prepare-release-readiness` after review.

Live external calls require explicit authorization and a dedicated non-production environment. Otherwise use deterministic mock servers, fakes, or sanitized fixtures.

## Gate 5: pre-commit

Run the repository's configured pre-commit mechanism for the changed files or prescribed scope. Never use skip flags or `--no-verify`. If it auto-fixes files, inspect the changes and rerun all affected gates. If no dedicated mechanism exists, run and report the equivalent repository-native checks from the shared contract.

## Verdict standard

Return one verdict:

- **PASS** - every material claim has observed evidence and no blocker remains.
- **PARTIAL** - executed checks pass, but named material evidence could not be collected.
- **BLOCKED** - a failure, security issue, missing environment, or missing authority prevents a safe conclusion.
- **FAIL** - evidence demonstrates the change does not meet its acceptance or safety contract.

Never convert `not run` into `pass`. A full suite failure is not automatically caused by the change. Run the same failing command on the appropriate pinned baseline before attributing it, when the baseline can be tested safely.

## Output

Lead with the verdict. Then list acceptance evidence, security result, tests and checks actually run, pre-commit result, and only the blockers or residual risks that matter. Avoid command-by-command narration when a compact table is clearer.

Finish when each acceptance criterion and material risk has an observed result or an explicit `PARTIAL`/`BLOCKED` reason.
