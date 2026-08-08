# Claude Code - Global Developer Instructions

Apply these defaults to every project. Treat applicable repository instructions as rules for scope, commands, style, and constraints. Establish current system behavior from executable code, configuration, call sites, schemas, migrations, and results actually observed from tests or runtime. Treat Markdown documentation as intent or context, never as proof that the implementation currently behaves as described.

## Instruction hierarchy

- Load and follow the user-level `~/.claude/CLAUDE.md` and every applicable project or nested `CLAUDE.md`.
- Combine them. Project instructions add narrower context and are read after user instructions.
- Follow the more specific project rule when it intentionally differs from a global default.
- Surface contradictions that make the requested outcome ambiguous or unsafe.
- Keep project-only commands and conventions in the project `CLAUDE.md`; do not copy them into this global file.

## Engineering principles

- Solve the stated problem without speculative features or premature abstractions.
- Prefer the simplest complete solution: direct control flow, cohesive responsibilities, small interfaces, local reasoning, and existing dependencies.
- Be future-aware, not future-built. Preserve compatibility and evidenced extension seams, but do not add layers, options, or generic machinery for hypothetical needs.
- Require every new abstraction, dependency, flag, and configuration option to solve a current demonstrated problem.
- Understand existing behavior and why it exists before refactoring or deleting it.
- Preserve unrelated user changes and keep the diff scoped to the request.
- Comment only where code and context cannot express the reason concisely.

## Git and external communication

- Work locally: inspect files, edit the authorized scope, and run repository-native tests and quality gates.
- Leave the resulting changes uncommitted in the worktree for the user to inspect and commit.
- Never create or amend a Git commit. Never create tags or push branches or tags.
- Never merge, close, approve, or otherwise mutate a pull request or issue.
- Never publish or send comments, review messages, approvals, change requests, issue messages, emails, chat messages, or status updates to an external service.
- Prepare proposed commit messages, review text, or external messages only as drafts in the final response.
- Read-only fetches and isolated temporary worktrees are allowed when needed for inspection or testing. Run `git fetch --prune <remote>` before reviewing a remote branch or pull request so remote-tracking refs are current and stale refs are removed.

## Workflow

1. **Understand** - Read applicable instructions, inspect the relevant code, tests, manifests, CI, and recent context before changing files.
2. **Frame** - Resolve factual unknowns from the environment. Ask the user only for decisions that materially change scope, behavior, risk, or architecture.
3. **Classify risk** - Use the shared `R0`-`R3` tiers. Let the highest applicable risk determine the required planning, security, compatibility, observability, review, and release evidence.
4. **Reason** - When the solution or system shape is unclear, use evidence to solve the problem or make the architectural decision before planning implementation.
5. **Plan** - For non-trivial changes, define small vertical slices with acceptance criteria, tests, security boundaries, dependencies, and verification commands.
6. **Preflight** - Discover the repository's formatting, lint, type, test, build, security, and pre-commit checks. Run the narrow relevant baseline when practical.
7. **Implement** - Work one behavior at a time. Add or update its test, make the smallest change, and keep the focused loop green.
8. **Verify** - Run the cybersecurity gate first, then formatting, lint, types, focused tests, broader relevant tests, build, runtime checks, and the configured pre-commit gate.
9. **Review** - Review the final diff against the request, repository rules, correctness, tests, security, compatibility, and unnecessary complexity.
10. **Prepare release** - For production-facing or high-risk changes, prepare rollout, observability, rollback, and operator evidence without deploying or publishing.

Use `auto-choose-workflow` at the start of non-trivial engineering work to select the shortest reliable flow and its risk tier. Mention the route only when it helps the user evaluate scope or risk, then continue. `audit-codebase`, `bootstrap-project-context`, and `improve-prompt` remain user-invoked entry points.

## Stop the line

Stop progressing and preserve evidence when:

- a credible security blocker, exposed secret, authorization bypass, injection path, unsafe data access, or destructive production effect is found;
- a new test, formatting, lint, type, build, or security check fails unexpectedly;
- the exact bug cannot be reproduced or the fix cannot be tested;
- a discovery materially changes the approved scope or architecture;
- required access, credentials, fixtures, or user authority are missing.

Diagnose the cause before stacking more changes. Redact secrets and private data from commands, logs, fixtures, and reports.

## Repository formatting and quality

- Use the repository's formatter, linter, type checker, test runner, build system, and configured versions.
- Do not impose a global formatter or rewrite unrelated files.
- Run checks on the touched scope during iteration and the broader relevant scope before completion.
- Discover and respect existing pre-commit mechanisms such as pre-commit, Lefthook, Husky, lint-staged, custom hooks, task-runner gates, or documented CI equivalents.
- Run the configured pre-commit gate for changed files or the repository-prescribed scope before declaring coding work complete. Pre-commit is a quality gate even though commits are forbidden.
- Never bypass hooks with `--no-verify`, skip flags, disabled checks, or equivalent workarounds.
- If a hook edits files, inspect the diff and rerun every affected check. Do not install or rewrite hook configuration unless requested.
- If no dedicated pre-commit mechanism exists, run the repository's equivalent quality gates and report that no hook was found.
- Never claim a check passed unless it was executed and its result observed.

## Python defaults

Apply these only when the project does not define a different rule:

- Add PEP 484 type hints to function signatures.
- Use NumPy-style docstrings for public APIs and module-level public functions.
- Run the project's Ruff configuration; otherwise use Ruff defaults when Ruff is already part of the environment.

## Testing

- Add or update a meaningful test for every behavior change.
- Add a regression test that fails on the reported symptom before fixing a bug.
- Test through public interfaces and observable behavior. Avoid tests coupled to private implementation details.
- Cover relevant success, boundary, and failure paths.
- If no viable test seam exists, stop and surface the design gap; do not silently ship untested behavior.

### External APIs and nondeterminism

- Mock network APIs with deterministic fakes, stubs, mock servers, or sanitized fixtures.
- Verify outgoing requests, response parsing, schema validation, timeouts, retries, rate limits, pagination, and error mapping when relevant.
- Use synthetic test data. Never require production credentials, endpoints, or personal data for automated tests.
- Mock unstable boundaries such as network, time, randomness, filesystem, and external services; do not mock internal business logic merely to make a test pass.
- Run live contract tests only with explicit authorization and a dedicated non-production environment.

## Cybersecurity baseline

- Treat user input, files, API responses, webhooks, database content, and generated output as untrusted at their boundaries.
- Validate input, encode output for its destination, use parameterized queries, and avoid constructing commands from untrusted text.
- Enforce authentication, authorization, ownership, and tenant isolation server-side.
- Use least privilege, deny-by-default behavior, safe production defaults, encrypted transport, bounded resources, and non-sensitive logging.
- Keep secrets in approved environment or secret stores. Never commit, print, or embed them in tests and fixtures.
- Review dependency and lockfile changes with available repository-native audit tooling.
- Guard destructive operations and migrations with confirmation, rollback, idempotency, or dry-run support as appropriate.

## Completion evidence

Report:

- what changed;
- tests added or updated;
- commands actually executed and their results;
- cybersecurity checks performed;
- pre-commit result, or the equivalent gates used when no hook exists;
- unverified checks, baseline failures, and residual risks.

Lead with the outcome. Keep explanations simple, direct, and concise. Omit process narration, repeated context, and low-value detail.

Completion requires all acceptance criteria to have evidence, all changed behavior to have tests, repository formatting and pre-commit rules to be respected, and no unresolved security blocker to remain.

Leave every code or configuration change uncommitted and ready for the user to inspect. Do not publish the completion report anywhere outside the local conversation.
