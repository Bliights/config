# Improvement scoring

Score each dimension from 1 to 5 only after writing the evidence and causal impact.

- **Impact** - improvement to correctness, security, delivery speed, maintainability, or user outcomes.
- **Confidence** - strength of code, test, history, runtime, or tooling evidence.
- **Effort** - implementation, migration, test, and coordination cost; 5 means largest.
- **Risk** - probability and consequence of regressions, compatibility breaks, data changes, or operational failure; 5 means highest.
- **Leverage** - number and importance of future changes, incidents, or teams improved by the work.

Use this priority heuristic only after qualitative judgment:

`priority = (impact * confidence * leverage) / (effort + risk)`

Do not hide security severity behind the formula. A confirmed critical security issue is the first recommendation regardless of numeric score.

Assign one recommendation strength:

- **Strong** - high-confidence evidence and a favorable change boundary;
- **Worth exploring** - real friction with an unresolved design or migration decision;
- **Speculative** - plausible benefit but insufficient evidence. Keep out of the main backlog until investigated.

Prefer a smaller high-confidence candidate over a broad modernization program. Record dependencies and prerequisite characterization tests.

## Score anchors

Use consistent anchors:

- **1** - isolated, low consequence, weak evidence, or trivial cost depending on the dimension.
- **3** - recurring or subsystem-level effect with code and test/history support.
- **5** - critical journey, organization-wide leverage, direct runtime evidence, or major migration cost depending on the dimension.

Do not average away hard constraints. Confirmed security blockers, data corruption, and unsafe migrations remain first even when remediation effort is high.

## Confidence limits

Cap confidence at:

- **2** when based only on static appearance or naming;
- **3** when code paths and tests support the inference but no runtime or history evidence exists;
- **4** when repeated history, incidents, measurements, or reproducible behavior support it;
- **5** only when the causal mechanism and expected improvement are directly demonstrated.

## Roadmap bands

- **Now** - blocker or high-confidence improvement required before dependent work.
- **Next** - strong leverage with prerequisites understood and a safe first slice.
- **Later** - valuable after named dependencies or measurements exist.
- **Investigate** - plausible concern needing a specific measurement, trace, or characterization test.
- **Do not pursue** - speculative benefit, unfavorable boundary, or lower cost than the complexity it would add.
