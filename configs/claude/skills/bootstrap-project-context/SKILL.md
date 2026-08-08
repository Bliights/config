---
name: bootstrap-project-context
description: Discover a repository and prepare compact project-specific CLAUDE.md or AGENTS.md instructions.
disable-model-invocation: true
---

# Bootstrap Project Context

Build a compact source of truth for future agents. Inspect in read-only mode. Edit instruction or documentation files only when the user asks for the update.

Read [the shared engineering contract](../_shared/engineering-contract.md).

## Discover

1. Read existing `CLAUDE.md`, `AGENTS.md`, contribution guides, architecture docs, and ADRs.
2. Inspect manifests, lockfiles, task runners, CI, containers, hooks, formatter, lint, type, test, build, and security configuration.
3. Trace the main entry points, module boundaries, data stores, external systems, deployment shape, and ownership clues.
4. Identify public contracts, trust boundaries, sensitive data, migrations, generated artifacts, and operational risks.
5. Run safe read-only discovery commands. Do not install dependencies or execute unknown project-controlled scripts merely to learn the repository.

## Prepare project instructions

Include only repository-specific facts that future agents cannot cheaply infer:

- purpose and major architecture boundaries;
- authoritative setup and repository-native commands;
- focused and full verification commands;
- pre-commit and CI expectations;
- test seams, fixture conventions, and external-service mocking rules;
- security, data, compatibility, and migration constraints;
- documentation and ADR locations;
- Definition of Done;
- known baseline failures or environmental requirements.

Do not copy generic global rules into the project file. Point to existing documentation instead of caching long content. Mark every unverified claim.

## Completion

Return the proposed context, evidence sources, unresolved project decisions, and suggested destination files. If edits were authorized, validate links and commands that can be run safely, inspect the final diff, and leave it uncommitted for the user.
