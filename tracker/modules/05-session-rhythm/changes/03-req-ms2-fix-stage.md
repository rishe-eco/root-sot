# 03 — MS2's fix stage: hit areas and the rows due

*Module `tracker/modules/05-session-rhythm/` · Change request written by `revise` · 2026-11-20. Kind: req · `rishe-eco/tracker main @ 7f86a93` · spec 0.3 → 0.3 (unchanged); build plan 0.3 → 0.4. Sources: the `STATE.md` blocks "verify --milestone MS2, main-session items" and "MS2 questions answered by call"; `team/open-work.md` 0.31, the SR6 hit-area row and the ten rows marked *Not done at MS2*; tracker `docs/development/README.md` (MS2) @ `7f86a93`; `calls.md` rows 94 to 100. Grading: every outcome was settled by Claude during the founder's unattended run (`lifecycle/unattended.md`), logged in `calls.md` rows 99 to 105, and is **proposal**, refusable on the diff.*

## What changes and why

`verify --milestone MS2` found the suites green but MS2 not closed. Made strict (an ancestor hit counts as a miss), the e2e hit-area helper finds three controls under 44 px: the cross-out control at 42 px (Focus, the actions list, Today), Today's Reorder handle, and the look-back row's sixth button in `fa`. The strict helper sits unmerged on the tracker's local branch `ms2/strict-hit-areas`, because merging it alone turns `main`'s e2e red. Ten open-work rows due at MS2 were taken by no stage.

SR8 was the plan's last stage, so a fix needs a new one. This adds **SR9** after SR8: the three controls, the helper's merge once its four specs pass, and the six of the ten rows that are a lane's work. The other four are design calls and move past MS2, to the founder. MS2 runs again after SR9. Nothing the spec asks changes: the spec is silent on hit areas, the date field's commit and the drag instructions, and the 44 px and reflow rules are the review checklist's. So the spec stays 0.3, and the change lands in the build plan, whose scope changes go through `revise` (`lifecycle/README.md` §4).

## Items and outcomes

| # | Item | Source | Outcome [F] | Where it lands |
|---|---|---|---|---|
| 1 | Fix the three controls under 44 px before MS2's push, not after | MS2 main session, question 1; `calls.md` rows 95, 99 | **Accepted** (call 99) | `07-build-plan.md` §5 SR9 items 1–3 |
| 2 | Merge `ms2/strict-hit-areas` (`92cd028`) once its four specs (capture, crossing, session, today) pass | open-work SR6 hit-area row; `calls.md` row 94 | **Accepted**: merged into SR9's lane branch first, so its 5 failures are the stage's failing tests (call 103) | SR9 *Base* |
| 3 | SR0: bound the `gatherKey` dedup read | open-work SR0 row | **Accepted**, on SR9 (call 100) | SR9 item 4 |
| 4 | SR1: the cross-out control at 180 px on the actions list, Focus and the project page | open-work SR1 row | **Accepted**, on SR9 (call 100) | SR9 item 5 |
| 5 | SR2: the drag handle's `en`/`fa` screen-reader instructions | open-work SR2 row | **Accepted**, on SR9 (call 100) | SR9 item 6 |
| 6 | SR3: the calendar scrolls the page 20 px at 360 × 800 under the top bar | open-work SR3 row | **Accepted**, on SR9 (call 100) | SR9 item 7 |
| 7 | SR3: `IntervalForm`'s review setting has no test | open-work SR3 row | **Accepted**, on SR9 (call 100) | SR9 item 8 |
| 8 | SR7: "Later…" saves on every change of the date field | open-work SR7 row; SR7 block question 1 | **Accepted** as commit on Enter or leaving the field, no Move button (calls 100, 102) | SR9 item 9 |
| 9 | SR3: error text at 3.19:1 | open-work SR3 row | **Carried to the founder, after MS2** (call 100) | open-work *needed by*, by `verify SR9` (call 104) |
| 10 | SR3: Focus's toasts share one slot | open-work SR3 row | **Carried to the founder, after MS2** (call 100) | as #9 |
| 11 | SR7: `todayKey` fixed at mount on `/session` | open-work SR7 row; SR7 block question 4 | **Carried to the founder, after MS2** (call 100) | as #9 |
| 12 | SR2: Today's and the look-ahead's row cramped at 180 px | open-work SR2 row | **Carried to the founder, after MS2** (call 100) | as #9 |

**Scope.** No criterion added; the spec's ledger stays at 0.3's 75, no area grown. One stage (M) added to the plan; still the smallest version worth trying.

## Changes to the spec

None. `02-spec.md` stays 0.3: no item changes what the module does, and none of the facts above is stated in it (call 101). The build plan goes 0.3 → 0.4: §3's table and order (SR9, MS2 after it, the cost), a new §5 SR9, and a changelog line naming this note.

## Carried to design

- None: the module has no design step. The four design calls (#9 to #12) go to the founder.

## `STALE`

None. No downstream file says the opposite. The build plan said MS2 follows SR8; this note changes that in the plan itself (0.4). The spec, journeys, wireframes and eval plan say nothing about the stage order or the four items.

## Carried, not `STALE`

| Item | Owner | Step |
|---|---|---|
| Rows #9 to #12: *needed by* set to "the founder, after MS2" in `team/open-work.md`, citing this note | `verify SR9` (open-work's writer), main session | after SR9's lane |
| Rows #3 to #8 and the SR6 hit-area row struck once done | `verify SR9` | after SR9's lane |
| `status.md` column 8 reads `9/9`; with SR9 it is `9/10` until SR9 is verified | `build-phase SR9` / `verify SR9` (column 8's writers) | SR9 |
| Delete `ms2/strict-hit-areas` once `main` holds it | `verify SR9`, main session | after the fast-forward |

## What must not break

- AC-17's cross-out control and AC-74's Move up and Move down: same layout and behaviour, larger hit areas only.
- Gathering's identity (D-2, PD-3): a moved row still dedupes after the `gatherKey` read is bounded; legacy rows without `forDate` still read.
- No count, no red, no new string beyond the drag instructions; PD-2 (no schema change); PD-10 (nothing pushed).
- The Jalali date field still saves on its one click.

## Open

None left to the build plan: SR9 is written into it here.

## Owed by other skills

1. `build-phase SR9 tracker/modules/05-session-rhythm` (Opus, medium), then `verify SR9` (Opus, high).
2. `verify --milestone MS2 tracker/modules/05-session-rhythm` (Opus, high), devices none in an unattended run.
3. Still owed from change 02 and unchanged here: `journeys update --from-note 02` and `eval-plan --touch-up`, before `close-out`.

## Changelog

- **2026-11-20** — Written by `revise` in the founder's unattended run (`calls.md` rows 99 to 105).
