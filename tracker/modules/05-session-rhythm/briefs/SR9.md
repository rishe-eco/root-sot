# SR9 · MS2's fixes: hit areas and the rows due — phase card

*For the Sonnet lane building SR9. Read `lifecycle/projects/tracker/brief-common.md` first; this card adds to it. Drafted by `build-phase SR9`, 2026-11-20 (unattended), from `07-build-plan.md` 0.4 §5 SR9 and `changes/03-req-ms2-fix-stage.md`, no design plates, open-work rows SR0 (`gatherKey`), SR1 (180 px), SR2 (drag instructions), SR3 (calendar scroll; `IntervalForm` test), SR6 (hit-area helper), SR7 ("Later…"), and the code as it is: `rishe-eco/tracker` main @ 7f86a93. Root-sot at `docs/root-os @ 961978b`.*

## Your lane

| | |
|---|---|
| Working directory | the tracker checkout's `.claude/worktrees/sr9-ms2-fixes` |
| Branch | `sr9-ms2-fixes`, from local `main @ 7f86a93`, no upstream |
| Test database | `<worktree>/api/prisma/test.db` |
| Ports | slot A: `E2E_API_PORT=4010 E2E_WEB_PORT=5183` (free on this machine at launch) |
| Size | M: 2–4 hours, ~250 lines of app code |

## Read, in this order

1. `lifecycle/projects/tracker/brief-common.md`
2. `07-build-plan.md` §5 SR9, all of it (items 1–9, *Tests*, *Traps*); `changes/03-req-ms2-fix-stage.md` *What must not break*
3. `team/open-work.md` rows 234, 237, 241, 244, 248, 255, 257 (the facts each item came from)
4. In the code: `client/e2e/helpers/hitArea.ts` on branch `ms2/strict-hit-areas`; `CrossOutControl.tsx`; `LookBackRow.tsx`; Today's row and its Reorder handle (`components/today/`); `api/src/services/actionGathering.ts` lines 395–500 and `gathering.integration.test.ts` lines 200–270 (D-2's moved row); `TodayPage.tsx` and `LookAheadStep.tsx` `DndContext`; `TrackerCalendar.tsx:209`; `IntervalForm.tsx`; `LookAheadRow.tsx` lines 140–165 and `components/ui/date-field.tsx`

## What to build

**First:** `git merge --no-ff ms2/strict-hit-areas` (one file), then run `capture`, `crossing`, `session` and `today` specs. Record the 5 failures in report item 2; they are your failing tests.

1. **Cross-out control.** `size-4` with a 1 px border leaves a 14 px padding box, so `-inset-[14px]` gives 42. Make it ≥ 44 (`-inset-[15px]` is 44 exactly; prefer a little margin if no neighbour is hit). The row's layout doesn't move.
2. **Today's Reorder handle** and 3. **the look-back row's sixth button in `fa`**: find why the left probe lands on the row (control narrower than 44, or clipped at the row's edge), and give each a 44 × 44 area without moving its visible box. Check `fa` (RTL) and `en` both.
4. **`gatherKey` read** (*Decided here* 1).
5. **180 px reflow** for the cross-out control on the actions list, Focus and the project page, `en` and `fa`, in `crossing.spec.ts`, reusing the reflow check `today.spec.ts` already has. Fix an overflow; anything else is a finding, not a fix.
6. **Drag instructions** (*Decided here* 2), on Today and the look-ahead.
7. **Calendar at 360 × 800**: no page scroll in `en` or `fa` with the top bar. Replace `min-h-[60vh]` with a layout that takes the remaining height. Then measure the routine form (48 px) and the time map (2 px): fix them if the cause is the same, otherwise report the cause found.
8. **`IntervalForm`'s review setting**: a client test, `useApi` mocked, routine and interval modes, the saved variables carrying the setting, and an edit form reading it back.
9. **"Later…"** (*Decided here* 3).

## Decided here

| # | Decision | Why |
|---|---|---|
| 1 | Before the loop, compute every key the run can generate (each `dateKey` × template × time block, by the same formula the create uses). Read gathered rows of the user's templates where `gatherKey in <those keys>` **or** `gatherKey` is null (legacy rows, pre-SR0, a set that no longer grows). The other filters stay. The plan's "legacy rows with no `forDate`" is read as "legacy rows, whatever their `forDate`" — flag it in report item 5 | Bounds the read; a moved row keeps its key so still dedupes (D-2); reading every legacy row is the superset, so no duplicate is possible |
| 2 | `DndContext` gets `accessibility={{ screenReaderInstructions, announcements }}` from new keys under `rhythm.dnd.*`: `instructions` (Enter opens Move up and Move down; dragging works by pointer), and `pickedUp`, `movedOver`, `dropped`, `cancelled`, each naming the item's title only. **No positions or counts** ("3 of 5"): `rhythmFences.unit.test.ts` and spec §4.9. Persian: informal register, the glossary's words | Plan item 6; the module's no-count rule |
| 3 | "Later…": the field keeps a draft. In Gregorian mode it commits on Enter (`onKeyDown`) or on blur, only if the draft is a full key ≥ `laterMinKey` and differs from what's saved. In Jalali mode (`date-field.tsx` renders `JalaliDateField`) the change from a click commits at once. Read the calendar setting the way `date-field.tsx` does; don't change `DateField` itself unless that's the only way, and say so | Plan item 9; `calls.md` row 102 |
| 4 | Branch `sr9-ms2-fixes`; e2e on slot A | `config.md` §4 |

## Tests that change on purpose

| Test file | Asserts today | New rule |
|---|---|---|
| `client/e2e/helpers/hitArea.ts` | an ancestor hit counts | strict, from `ms2/strict-hit-areas` (merged, not edited) |
| `client/e2e/session.spec.ts:601` | `.fill("2026-12-20")` alone moves "Read" off the shown days | fill, then `press("Enter")`; the row leaves only after it |

No other test asserts what this stage changes; if one fails, it is a finding.

## Proving it here

All targeted, on slot A: the four strict specs in full after every hit-area fix (a run stops at its first miss); `gathering.integration.test.ts` and the new bound test; the new client tests; `npx tsc --noEmit` in both projects; both `i18n:check-*`. Look at the 180 px and 360 × 800 screenshots you take (write them under `.tmp/`), and say in the report what you saw.

## Done for SR9

- The four strict specs pass in full (53+ tests), with counts.
- Item 4: an integration test that a long-lived daily interval's read is bounded (e.g. spy on the query or count rows read) and that a moved row still dedupes; existing gathering tests unchanged and green.
- Item 5: the 180 px cases, `en` and `fa`. Item 6: a client test that the instructions are the locale's. Item 7: an e2e asserting no page scroll at 360 × 800 in both locales. Item 8 as above. Item 9: an e2e that ArrowUp in the date field doesn't move the row until Enter or blur, and a client test for the Jalali click.
- AC-17's control and AC-74's Move up/Move down unchanged; no count, no red, no schema change.
- The report written to `.tmp/SR9.report.md` and returned.

## Not here

The four design calls: error text contrast, Focus's toast slot, `todayKey` at mount, the cramped 180 px row (founder, after MS2). Any layout change past fixing an overflow. Deleting `ms2/strict-hit-areas`, editing `team/open-work.md`, any stage record.
