---
name: review-change
description: Review a worktree, diff, branch, commit range, or pull request against repository standards and the originating requirement. Use before merge or when the user asks for code review, quality review, security review, or review since a fixed point.
---

# Review Change

Find defects that should block or alter the change. Review in read-only mode unless the user separately asks for fixes.

Read [the shared engineering contract](../_shared/engineering-contract.md), [the risk tiers](../_shared/risk-tiers.md), and [the review baseline](references/review-baseline.md). For a pull request, also read [the PR review procedure](references/pr-review.md).

## Fix the review scope

Identify the exact worktree, fixed point, commit range, branch, or pull request. Read the originating requirement, plan, acceptance criteria, and all applicable repository instructions. Inspect the full changed files when surrounding context affects the diff.

Exclude pre-existing issues unless the change makes them newly reachable, more severe, or directly relevant to an introduced design.

## Pull-request context

For a PR, acquire the title, description, linked requirement, base and head revisions, complete diff, changed-file list, commit history, existing review discussion, and current CI/check status before reviewing. Pin the reviewed head revision so later pushes do not silently invalidate findings.

`review-change` supports both a branch review and a merge-readiness assessment:

1. refresh remote-tracking refs with `git fetch --prune` and resolve the PR branch from `<remote>/<headRefName>`;
2. create a new detached temporary worktree from that remote PR branch;
3. inspect changed executable scripts, hooks, manifests, and CI before running PR-controlled code;
4. run security checks, repository-native focused tests, and broader relevant quality gates inside the branch worktree;
5. for merge readiness, create a second disposable worktree and test the uncommitted integration of the pinned head into the refreshed pinned base;
6. when a check fails and attribution matters, run the same command on the pinned base in isolation;
7. capture the reviewed revisions and evidence;
8. remove every temporary worktree on success, failure, or early stop.

Never commit, push, approve, comment, request changes, merge, or publish a message. Return findings only in the local final response. Never test the PR by checking it out into the user's current worktree.

## Independent review passes

Perform the first two passes independently before combining findings:

### Pass A: repository and engineering standards

Check architecture, local conventions, public contracts, error handling, data flow, performance, compatibility, generated artifacts, migrations, dependencies, simplicity, and maintainability.

Ask:

- Is this the smallest clear solution that meets the requirement?
- Does every new abstraction or dependency solve a current problem?
- Are responsibilities local and interfaces smaller than their implementations?
- Does the design preserve evidenced future change seams without speculative machinery?
- Is unrelated cleanup mixed into the diff?

### Pass B: requirement and behavior

Trace every acceptance criterion through the actual changed path. Check success, boundary, denial, and failure behavior. Look for missing branches, incorrect defaults, compatibility regressions, stale callers, and partial migrations.

### Pass C: security and abuse cases

Review trust boundaries, input validation, output encoding, injection, command and path construction, authentication, authorization, ownership, tenant isolation, secrets, logging, SSRF, unsafe deserialization, destructive operations, and dependency changes. A credible blocker takes priority over style or maintainability findings.

### Pass D: tests and verification

Check that tests prove behavior instead of implementation detail, reproduce bug symptoms, cover failure and denial paths, use contract-faithful mock data, and cannot pass trivially. Inspect the reported formatter, lint, type, build, security, and pre-commit evidence. Missing evidence is a finding only when it creates material merge risk.

## Validate candidate findings

For each candidate:

1. Identify the smallest exact line range that introduces the issue.
2. Trace the reachable input and execution path.
3. State the concrete wrong outcome and affected users or systems.
4. Check nearby code, tests, configuration, and call sites for a mitigating fact.
5. Reproduce or run a focused check when practical and non-mutating.
6. Discard preferences, hypotheticals without a trigger, and issues not introduced by the scope.

## Severity

- **P0 Critical** - immediate security, data-loss, or systemic production risk; do not merge.
- **P1 High** - likely correctness, security, compatibility, or availability failure in a supported path.
- **P2 Medium** - real defect or maintainability cost with limited conditions or impact.
- **P3 Low** - bounded quality issue worth fixing, not a personal style preference.

Severity reflects impact and likelihood, not how easy the fix is.

## Finding format

Each finding contains:

- `[P0-P3] Imperative title`;
- exact file and tight line range;
- triggering condition;
- concrete impact;
- decisive evidence;
- smallest useful correction direction, without writing the patch.

Do not hide actionable findings inside a summary. Do not inflate confidence: label an unresolved concern as a question or residual risk.

## Completion

Return the reviewed head and base revisions, whether branch or integrated state was tested, cleanup status for every worktree, findings ordered by severity, then a short verification summary. If there are no actionable findings, say so and name only material unverified risks. Keep the report concise enough that every sentence changes a decision.
