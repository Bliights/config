---
name: improve-prompt
description: Turn a rough software-engineering request into a concise, execution-ready prompt.
disable-model-invocation: true
---

# Improve Prompt

Preserve the user's language, intent, constraints, and deliberate optionality. Resolve repository facts from the environment when available; do not invent context.

## Build the prompt

Include only applicable fields:

1. **Goal** - one observable outcome.
2. **Verified context** - facts that change execution.
3. **Scope** - included surfaces and explicit non-goals.
4. **Authority** - permit local inspection, file edits, tests, and read-only external lookup as requested.
5. **Side-effect boundary** - leave changes uncommitted; do not push, merge, deploy, publish, approve, or send comments or messages.
6. **Constraints** - compatibility, security, architecture, style, performance, and repository rules.
7. **Acceptance** - success, boundary, denial, and failure behavior.
8. **Evidence** - tests, deterministic mock data, security checks, format, lint, types, build, runtime, and pre-commit.
9. **Output** - the concise handoff expected.

Replace words such as "clean", "robust", "optimized", or "future-proof" with observable criteria. Ask a question only when a missing user decision would materially change the prompt.

## Output

Return the improved prompt first. Add assumptions or unresolved decisions only when they materially affect execution. Do not explain the rewriting process.
