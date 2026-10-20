<!-- Template for `<module>/changes/NN-change-<slug>.md`, written by `spec change` (Opus, high). Its Stages section stands in for the build plan: `build-phase` and `verify` read it in place of the plan's §5. A change too large to stage here is a Module. Template 0.1 · 2026-10-20. Sources: `skills-plan.md` §2 `spec`; `skills/spec/reference.md`; findings SP-8 to SP-10; trial logs `08e-ci-deploy-change`, `08f-CS1-change`, `09b-polish-change`; `imnstr/modules/01-website/changes/04-ci-deploy.md`, `05-live-review-polish.md`. The gate checks the headings listed for this file in `required-headings.txt`: keep their words; each stage section must carry **Size** and **Traps**. *Founder pre-flight* and *At the verify* only where the change touches a server; *Order and commits* for a stage near its size ceiling. Delete every comment in the output. -->
# NN — <title>

*Module `<area>/modules/NN-slug/` · Change note written by `spec` in `change` mode · <YYYY-MM-DD>. Kind: change · written against `<code repo> main @ <hash>` · prefix `<XY>`. A Change to <what>. The **Stages** section below stands in for the build plan. Grading: claims about the code are **as-built** at that commit; everything else is **proposal** until verified.*

## What changes and why

**Today.** <…>

**After.** <…>

### Decided by the founder at this step

| # | Question | Answer [F] |
|---|---|---|
| 1 | <…> | <…> |

### What stays

## Acceptance criteria

<!-- The note's own two-letter prefix (README §0). *Item* names the review finding each criterion closes, when the Change comes from a review. -->

| # | Item | Criterion |
|---|---|---|
| XY-1 | <P2-F4> | <a testable line> |

## What must not break

## Founder pre-flight

<!-- Server facts and steps the founder runs first. Omit if none. -->

## Stages

<!-- One or more stages in the build plan's §5 shape. Lanes run targeted tests; the full suites are the verify's. Sized with the test harness counted. -->

### <XY>1 · <Name>

**Goal.** <…>

**Branch and slot.** `<xy>1-<slug>`, the free lane slot in `config.md`.

**Files.** <…> · **Not changed:** <…>

**Tests.** <targeted tests; tests that change on purpose>

**Image and deploy.** <new environment variables with production defaults; toolchain changes; "none">

**For an infrastructure change:** <what this changes about how later stages are built, verified or deployed>

**At the verify.** <a server runbook; omit if none>

**Stop points.** <commit boundaries; omit if none>

**Acceptance.** <XY-n, …>

**Size: <S · M · L>.**

**Traps.**
- <…>

**Not here:** <…>

## What this makes stale

<!-- Each file, its owner, and the step that catches it up. A note that defers the spec adds a `revise` line to its `STATE.md` block's next steps; `close-out`'s gate fails while one is pending. -->

| File | Owner | Caught up by |
|---|---|---|
| `02-spec.md` §<n> | `revise` | `revise --catch-up NN` |

## Changelog

- **0.1 · <YYYY-MM-DD>** — Note, against `main @ <hash>`.
