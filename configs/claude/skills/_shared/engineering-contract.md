# Engineering Contract

Apply this contract whenever work can change code, configuration, schemas, dependencies, generated artifacts, or runtime behavior.

Read [the engineering risk tiers](risk-tiers.md) for every non-trivial or production-facing change. Use their traceability chain when multiple acceptance criteria or material risks exist.

## Sources of truth

Separate authority, implementation, and evidence:

1. Applicable `CLAUDE.md` files define authority, scope, constraints, and required working practices.
2. Executable source code, call sites, checked-in configuration, schemas, migrations, and generated artifacts define the current implemented behavior.
3. Commands actually executed and runtime or test results actually observed provide evidence about that behavior.
4. Markdown documentation, diagrams, tickets, comments, examples, and test names provide intent and historical context only until confirmed against the implementation.

Never use a documentation claim or an unexecuted test as proof that the system currently behaves that way. Trace important claims through the real execution path and run the narrow relevant check when practical. When documentation and implementation disagree, report the discrepancy and reason from the observed implementation; do not silently invent behavior to reconcile them.

Discover repository-native commands and pinned versions from CI workflows, tool configuration, package scripts, task runners, build files, and checked-in wrappers. Do not invent a parallel workflow when the repository already defines one.

## Simple and future-aware design

- Implement the smallest complete behavior that satisfies the current acceptance criteria.
- Prefer a direct solution, a small interface, local reasoning, and existing dependencies.
- Add an abstraction only when it removes current duplication, protects a real boundary, or creates a required test seam.
- Preserve compatibility and extension points already supported by the codebase.
- Design for evidenced next changes; do not build hypothetical features. Be future-aware, not future-built.
- Keep responsibilities cohesive. Make invalid states hard to represent when the local language and patterns support it.
- Separate behavior changes from broad cleanup. Record useful out-of-scope improvements instead of mixing them into the diff.
- Understand a construct before deleting or replacing it. Tests, history, call sites, and configuration may reveal its purpose.

Use this simplicity check before final verification:

1. Can a maintainer understand the change from the public interface and nearby code?
2. Is every new type, layer, flag, dependency, and configuration option necessary now?
3. Does the design make the likely next change easier without committing to an imagined roadmap?
4. Is the diff smaller and more local than the nearest correct alternative?

## Testing contract

- Add or update a behavior-focused test for every behavior change.
- For a bug, reproduce the reported symptom with a failing regression test before fixing it when a viable seam exists.
- Test public behavior and contracts. Mock unstable boundaries, not the implementation under test.
- Use deterministic synthetic data. Never depend on production credentials, endpoints, or personal data.
- Cover the relevant success, boundary, denial, and failure paths.
- If the code is untestable at the required boundary, expose the design gap instead of silently shipping untested behavior.

## Side-effect boundary

- Inspect, edit, and test the authorized local scope. Leave the resulting worktree changes ready for the user.
- Never create or amend Git commits, create tags, push, merge, or publish artifacts.
- Never send or publish external comments, reviews, approvals, change requests, issue messages, emails, chat messages, or status updates.
- Use external systems read-only. Prepare any proposed message as a local draft in the final response.
- Fetching refs and creating an isolated temporary worktree are permitted for inspection and testing. Before reviewing a remote branch or pull request, run `git fetch --prune <remote>`. Do not alter the user's current worktree or branch.

## Pre-commit contract

Discover the repository's existing pre-commit mechanism, including `.pre-commit-config.yaml`, Lefthook, Husky, lint-staged, custom Git hooks, task-runner commands, and CI checks documented as pre-commit gates.

- Run fast focused checks while iterating.
- Before declaring coding work complete, run the configured pre-commit command for the changed files or the repository-prescribed scope.
- Never bypass hooks with `--no-verify`, disabled hooks, skipped checks, or equivalent flags.
- If a hook modifies files, inspect the resulting diff and rerun the hook until it passes or a blocker is identified.
- Do not install, rewrite, or broaden hook configuration unless the user requested it.
- If no pre-commit mechanism exists, run the repository's equivalent formatter, lint, type, test, build, and security gates. Report that no dedicated hook was found.
- Distinguish failures introduced by the change from verified baseline failures. Do not hide either.

## Evidence and communication

Lead with the outcome. Keep explanations short, concrete, and free of process narration.

Report only:

- what changed or what was found;
- the decisive evidence;
- checks actually run and their results;
- blockers, unverified items, and residual risks;
- the next action only when one is useful.

Never claim a command, test, review, or security check passed unless it was executed and its result observed.
