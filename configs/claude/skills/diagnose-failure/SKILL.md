---
name: diagnose-failure
description: Diagnose failures from a reproducible signal and identify the root cause. Use when tests fail, builds break, behavior is wrong or slow, logs show errors, a regression is reported, or verification stops on an unexpected or security-relevant result.
---

# Diagnose Failure

Find the causal mechanism before proposing a fix. Diagnosis is read-only except for temporary instrumentation or tests that the user has authorized.

Read [the shared engineering contract](../_shared/engineering-contract.md) before changing diagnostic tests or instrumentation.

## Triage

Capture the exact symptom, expected behavior, observed behavior, first known occurrence, affected environment, frequency, and impact. Classify the signal:

- deterministic or intermittent;
- local, CI, staging, or production-only;
- correctness, performance, availability, data, dependency, configuration, or security;
- regression or previously unverified behavior.

Treat security signals, exposed secrets, authorization bypasses, unsafe data access, and destructive effects as stop-the-line blockers. Redact sensitive evidence.

## Establish a red loop

Use the narrowest reliable reproducer:

1. existing focused test or repository command;
2. new regression test through a public interface;
3. minimal request, fixture, script, or isolated configuration;
4. sanitized trace or log query when the original environment cannot be reproduced.

Run the reproducer unchanged and observe the failure. Record the exact command, inputs, environment differences, and output. A changing or unobserved signal is not a stable red loop.

For intermittent failures, control time, randomness, concurrency, network behavior, and test order one variable at a time. Measure failure rate before and after each experiment.

## Narrow the fault

Trace backward from the first incorrect observable state:

1. Find the earliest layer where actual data diverges from expected data.
2. Reduce the input and execution path while preserving the symptom.
3. Compare working and failing cases across code, config, dependency, schema, platform, and data.
4. Use history, bisect, or recent diffs when the regression window is meaningful.
5. Inspect boundary contracts before internal implementation: request shape, validation, authorization, serialization, persistence, retries, and error mapping.
6. Separate the **trigger** from the **root cause** and from downstream symptoms.

## Hypothesis ledger

Keep a small ranked ledger:

| Hypothesis | Supporting evidence | Contradicting evidence | Cheapest discriminating test | Result |
| --- | --- | --- | --- | --- |

Test one hypothesis at a time. Prefer an experiment that can falsify the leading hypothesis. Delete or revert temporary instrumentation after it provides evidence.

After two failed hypotheses, re-check the reproducer, assumptions, environment, and layer boundary before adding more changes.

## Root-cause standard

A root cause is ready only when it explains:

- why the exact symptom occurs;
- why it occurs in the affected cases and not the controls;
- when or how the faulty condition entered;
- what evidence would cease to fail after the correct fix;
- whether the same mechanism affects other paths.

Do not label a stack frame, error message, null value, timeout, or recently changed file as the root cause without the causal link.

## Fix handoff

If the user asked only for diagnosis, stop after the evidence-backed explanation. If a fix is authorized:

1. preserve the failing regression test;
2. propose the smallest fix at the source of the bad state;
3. identify compatibility, security, and rollback effects;
4. route implementation to `execute-change`;
5. route proof to `verify-change`, including pre-commit after code changes.

## Red flags

- Editing several components before reproducing the failure.
- Changing tests to accept the observed bug.
- Treating correlation with a recent diff as causation.
- Adding retries, delays, null guards, or broad catches without explaining the faulty state.
- Debugging with production secrets or unsanitized personal data.
- Re-running the same experiment without changing the hypothesis or evidence.
- Claiming an intermittent problem is fixed after one passing run.

## Output

Lead with the diagnosed cause or `Not yet isolated`. Then provide the reproducer, decisive evidence, causal chain, affected scope, confidence, and next action. Keep raw logs to the minimum needed for verification.

Finish when the causal mechanism is demonstrated or the remaining blocker and the exact evidence needed to resolve it are explicit.
