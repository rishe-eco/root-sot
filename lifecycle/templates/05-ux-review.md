<!-- Template for `<module>/05-ux-review.md`, written by `ux-review` (Opus, high, forked) in `design` mode before the build and `live` mode after UI stages. Passes are appended; the same instrument at both points, so scores compare. Template 0.1 · 2026-10-20. Sources: `skills-plan.md` §3 `ux-review`; `skills/ux-review/reference.md`; `skills/shared/reference.md` *Grades*; finding UX-6; trial logs `05-ux-review`, `09-live-review`; `imnstr/modules/01-website/05-ux-review.md`; `lifecycle/review-instrument.md`. The gate checks the headings listed for this file in `required-headings.txt`: keep their words. The review asks nothing: decisions found are routed `question`. A pass with an earlier pass in the file reads it only after its own findings are written. Delete every comment in the output. -->
# <Module name> — UX review

*Module `<area>/modules/NN-slug/` · Phase 5 (and 9, live) · UX review (`ux-review`). Each journey walked as each selected persona and scored against `lifecycle/review-instrument.md`. Passes are appended, newest last; the summary at the top is newest first.*

**Version 0.1 · Status: review · <YYYY-MM-DD> · Owner: <owner>**

**Grading.** Observations are **simulated** on a static design and **as-built** on the running app. Every score is **simulated**: one reviewer's judgement. Personas marked *hypothesis* in `lifecycle/personas.md` stay so until a pass or real-user data grounds them.

---

## Summary

<!-- One short summary per pass, newest first. -->

**Pass 1 — <YYYY-MM-DD> · <mode>:** <five points>

## Pass 1 — <YYYY-MM-DD> · <design · live> mode, against <the 4b design · the wireframes · the app at `main @ <hash>`>

### What was reviewed

<!-- The files or the commit; widths, schemes and languages; for live mode, how production was read (as a bot, requests it won't count) and the local server built from the deployed commit. -->

### Coverage

<!-- Every criterion has a screen; every screen its empty, error and loading states. A live pass also lists the earlier pass's findings, as they now stand. Before calling a state missing, check the design's captions and README. -->

| Criterion | Screen | States | Status |
|---|---|---|---|
| AC-1 | <…> | empty · error · loading | <…> |

### Scores

<!-- The six metrics in `review-instrument.md`, per persona per journey. A live pass puts the earlier pass's score in brackets. -->

| Journey · persona | <metric 1> | <metric 2> | <metric 3> | <metric 4> | <metric 5> | <metric 6> |
|---|---|---|---|---|---|---|
| J1 · <ID> | <n> | <n> | <n> | <n> | <n> | <n> |

### Findings

<!-- Numbered P<pass>-F<n>. Severity from `review-instrument.md` §4. Route: `revise`, `question`, `build`, `design`. Status: `open`, `closed in <file>`, `carried to <step>`; `build-plan`'s gate greps for `open`. Owed items injected at the start are not counted as defects. -->

| # | Finding | Where | Severity | Route | Status |
|---|---|---|---|---|---|
| P1-F1 | <…> | J2.4 | <…> | <…> | open |

### Heuristics, in brief

<!-- Nielsen's ten, one line each, citing findings. -->

### For `revise`

<!-- The findings that change the spec. After the build, UI fixes go to `spec change` as one proposed Change. -->

- <P1-F…>

### Carried

<!-- Findings carried to the design pass or the build, each with its step. -->

### Worth keeping

### Not checked

<!-- Including open by-hand device checks, which don't block a live pass. -->

## Changelog

- **0.1 · <YYYY-MM-DD>** — Pass 1, <mode>.

## References

- `03-journeys.md` <version>; `02-spec.md` <version> (interface and acceptance sections); `lifecycle/review-instrument.md`; `lifecycle/personas.md`
