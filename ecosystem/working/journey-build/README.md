# Journey build — the child version

*Living layer. Journey built thin and whole, first: the loop before any pillar is deep, in Tracker. Decision: `../../decisions/decision-log.md`, 2026-10-18. Canon: `../../canon/02-pillars/00-the-loop.md` §5 and §7, `../../canon/03-engine/00-five-phase-engine.md` §7. Update the changelog; don't fork.*

**Version 0.1 · Status: five minimum specs, nothing built · 2026-10-18 · Owner: _root**

---

## The files

| # | Spec | What it is | Pillar |
|---|---|---|---|
| 01 | `01-first-act.md` | the first thing anyone does: need → reflect → batteries → goal → capacity → the one thing; three endings that all land in a goal; the overview afterwards | all |
| 02 | `02-reflect-minimum.md` | one Reflect engine, three entries (need, failure, free); a structural mirror; one reconstrual move; the motive check; intent beside obstacle | Reflect |
| 03 | `03-batteries-check.md` | body, mind and spirit in four words; respond now; the read sits beside a goal and never gates it | Maintain |
| 04 | `04-capacity-check.md` | for one chosen goal: what it takes, do you have it; a capacity goal that serves the real one | Organize (Impact's emergent capacity at the close) |
| 05 | `05-failure-and-ignoring.md` | carried actions, goals gone quiet, goals closed as achieved / let go / didn't work; one short look; effort apart from outcome | Organize (+ Reflect) |

## Build order

**02 → 03 → 04 → 05 → 01.** Reflect first, because the first act's step 2 and every failure route through it. Batteries and capacity next, as the first act's middle. Failure-and-ignoring before the first act's wiring, so the overview's *Gone quiet* section has something to show. The first act last, because it is the wiring between the other four plus the overview.

**03, 04 and 05 do not depend on each other** and can be built in parallel once 02 has landed; 01 needs all four.

## What every spec shares

- **Built in Tracker**, under the conventions in `../../../tracker/canon/02-architecture/04-conventions.md`, with convention #13's permission to diverge where a pillar's shape differs, written down at the site. New routes: `/journey` (overview), `/journey/first-act`, `/tools/reflect`, `/tools/maintain/batteries`.
- **LLM-free.** Authored prompts, authored lexicons, reused palettes — like Feelings & Needs and Noticing.
- **English prototype**, every string keyed in `en` and `fa` (convention #7), with the spec/surface content split kept so the Persian is authored later rather than translated.
- **Every step commits as it goes** (convention #8); every flow is resumable.
- **No counts, no streaks, no scores, no patterns across entries.** Absences are enforced in the schema where they can be, and as fences-as-tests as Noticing did (`noticingFences.unit.test.ts`).
- **Skips and waves are written nowhere.**
- **Failure modes are acceptance criteria**, pass/fail.
- **Each spec owns one or more seams** and says what would count as that seam working (engine §7).

## Schema, all five together

| Change | From | Notes |
|---|---|---|
| `Reflection`, `ReflectState` | 02 | `ReflectState.lastCatchAt` stored, not derived — convention #13, same reason as Noticing |
| `BatteryRead`, `BatteryNote`, `enum BatteryLevel` | 03 | no series query; nothing scheduled may open a read |
| `CapacityCheck` | 04 | one per goal; no status or score field |
| `Goal.servesGoalId` (+ relation) | 04 | **not structural** — D-4 and the status cascade ignore it |
| `PursuitLook`, `enum GoalCloseKind` | 05 | no counter anywhere |
| `Goal.closedAt`, `closedAs`, `quietLookAfter` | 05 | first time a goal can end as anything but done |
| `Action.firstDueOn`, `lookedAt` | 05 | dates, never counts; `firstDueOn` backfilled from current dates |
| `JourneyState` | 01 | current step derived, never stored |
| `Goal.originReflectionId`, `oneThing`, `oneThingAnsweredAt` | 01 | |

## Open for the founder

Collected from the five specs; each is also listed where it arises.

1. ~~**Keeping a *should* goal**~~ — **decided 2026-10-18: yes**, motive stored on the reflection, asked about once if the goal goes quiet. (01 §4.3)
2. **Batteries beyond inform** — whether a low read should ever do more than sit beside the goal. Today: inform only. (03 §9)
3. **Holding new users in the first act** until it completes, and `/journey` as the landing page. Proposed: yes to both for the child version. (01 §10)
4. **Noticing's cue rule** — the noticing path's interval puts Noticing on Today, so its `wasPrompted` becomes real and its graduation detector needs revisiting. (01 §4.2)
5. **One capacity portrait or two** — whether an achieved goal's *what did you have* joins Noticing's portrait. (04 §10)
6. **The agent mirror** — when Reflect gets one. (02 §11)

---

## Changelog

- **0.1 · 2026-10-18** — Folder created with five minimum specs following the loop-first decision: the first act, minimum Reflect, the batteries check, the goal capacity check, failure-and-ignoring. Build order 02 → (03 ∥ 04 ∥ 05) → 01; the shared rules; the schema in one table; six questions for the founder.
- **0.1 (rev) · 2026-10-18** — Question 1 decided: a *should* goal may be kept.
