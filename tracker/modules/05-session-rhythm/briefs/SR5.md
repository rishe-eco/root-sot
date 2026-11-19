# SR5 · Session API: look-ahead, next session, Finish — phase card

*For the Sonnet lane building SR5. Read `lifecycle/projects/tracker/brief-common.md` first; this card adds to it. Drafted by `build-phase SR5`, 2026-11-19, from `07-build-plan.md` §5 SR5, §2 PD-7c, PD-8, PD-12, PD-14, §6.2, §6.4, §6.5, journeys J4.11, J5.4, J5.5, stage records `docs/development/SR0.md` and `SR4.md`, open-work row "SR0: no test walks a full gather → `orderDay` → re-gather", and the code as it is: `rishe-eco/tracker` main @ c7d3db8. Root-sot at `docs/root-os @ 37f3030`.*

## Your lane

| | |
|---|---|
| Working directory | the tracker checkout's `.claude/worktrees/sr5-look-ahead` |
| Branch | `sr5-look-ahead`, from local `main @ c7d3db8`, no upstream |
| Test database | `<worktree>/api/prisma/test.db` |
| Ports | none used (API tests only); slot A is held: `E2E_API_PORT=4010 E2E_WEB_PORT=5183` |
| Size | M: ~2–4 h, ~300–450 lines of app code, API only |

## Read, in this order

1. `lifecycle/projects/tracker/brief-common.md`
2. `07-build-plan.md` §5 **SR5**, all of it; §2 PD-7, PD-8, PD-12, PD-14; §6.2 (refusals, exact words), §6.4, §6.5.
3. `02-spec.md` §2.2 #1, #2, #7; §2.3 #20, #21, #25, #37; AC-40, AC-41, AC-43, AC-44, AC-46, AC-51, AC-52, AC-56, AC-67.
4. `03-journeys.md` J4.11, J5.4, J5.5.
5. Code: `api/src/services/rhythm/session.ts` (its `writeSession`, `refuseBeforeSessionDay` and move code are the pattern), `days.ts`, `dayList.ts`, `rhythmState.ts`, `getGatheringDateKeys` and `runActionGathering` in `api/src/services/actionGathering.ts`; `docs/development/SR4.md`.

## What to build

`api/src/services/rhythm/lookAhead.ts`, its SDL in `typeDefs.ts`, thin resolvers in `query.ts` and `mutations.ts` (as SR4's are wired), and `api/src/__tests__/lookAhead.integration.test.ts`. No schema change, no client change.

What the code check found, and how to read the plan:

- **Reuse `writeSession`** from `session.ts` (export it): it already gives ownership, `This session is finished.` and the retry. Every look-ahead write, and the query, refuses with `That step isn't open yet.` while `lookBackFinishedAt` is null.
- **`todayKey` is added** to `planItem` and `completeLookAhead` (the shown days and the pre-fill need it; §5's signatures omit it), and both refuse a key before the session's date as SR4's writes do. Flagged for verify.
- **Next date.** Shown/pre-filled = stored `nextDateKey`, else `todayKey + spacingDays`. `setNextDate` accepts `todayKey + 2` to `+ 7` only, else `The next session must be 2 to 7 days from today.` Days shown = `todayKey` to next − 1, each `dayList(prisma, userId, key)`.
- **Gathering on a new next date (§2.2 #7, AC-41):** after `setNextDate`'s transaction commits, call `runActionGathering(prisma, userId, { todayDateKey: todayKey, endDateKey: next − 1 })`. **Never inside the session transaction or lock**: it takes its own `gather:` lock and writes through `prisma`, which would wait on SQLite's write lock held by the transaction.
- **"From before"** (AC-51): shown while `RhythmState.fromBeforeShownSessionId` is null or this session's id; items = fate null, `done` false, `plannedDayKey(a) < switchDateKey`. **"From the gap"**: this session's `RhythmGap` (one per session), its `plannedItems` ids whose action is still fate null and not done. **"No date yet"**: undated by `plannedDayKey`, fate null, not done (PD-7c). Each block is a list of actions and nothing else (§6.5: no counts).
- **`markShown(sessionId, block)`**: `fromBefore` sets the state's id only while it is null; `fromGap` sets `shownAt` only while null. Idempotent.
- **`letAllGo(sessionId, block, actionIds, undo)`**: each id owned (`Not found` otherwise). Not undo: sets `PassedArchived` on ids that are in the block now. Undo: sets fate null on ids whose fate is `PassedArchived`.
- **`planItem`**: `dateKey` ≥ `todayKey` (a shown day, or "Later…" at or past the next date), or null; else `That day isn't one of the days being planned.` Moves through `plannedDayData`, `freezeFirstDue`, and the legacy `gatherKey` freeze, exactly as `answerItem`'s move. `startTimeOfDay`: `HH:mm` (`Time must be HH:mm`) or null to clear; omitted leaves it.
- **`removeItem(actionId, sessionId, removed)`**: `PassedArchived`, or back to null only from `PassedArchived` (AC-43).
- **`setWhenWhere`**: needs `lookAheadDoneAt`; `whenTime` `HH:mm` or null; place trimmed, empty → null, over 80 characters → `A place can be at most 80 characters.`
- **`finishSession`**: needs `lookBackFinishedAt` and `lookAheadDoneAt`; one transaction sets `completedAt`, clears `openForUserId`, writes `nextDueKey = nextDateKey`, and `spacingDays` = days from the session's `dateKey` to `nextDateKey` only when that is 2 to 7 (trap 2).

## Decided here

| # | Decision | Why |
|---|---|---|
| 1 | `rhythmLookAhead` only reads; the client (SR7) calls the existing `runActionGathering(todayKey, pre-fill − 1)` when the look-ahead opens, as Today does on mount | A query that writes breaks GraphQL's contract; §2.2 #7 names only the next date's change as new |
| 2 | `setWhenWhere` is refused before `lookAheadDoneAt` | Step order (§2.1); the least to undo |
| 3 | "Later…" has no upper bound | The plan bounds it only below |
| 4 | An item moved to "No date yet" keeps its time | Nothing in the spec clears it; the smallest write |
| 5 | The new view types join `VIEW_TYPES` in `rhythmSchema.unit.test.ts` | §6.5's "views carry no totals", as SR4 did |
| 6 | The "new days gathered" test also orders a routine's occurrence with `orderDay` and asserts the next-gathered occurrence carries that `sortOrder` | Closes the open-work row SR0 left for SR5's verify |

## Tests that change on purpose

None. Grepped every SR5 operation name, `nextDateKey`, `fromBeforeShownSessionId` and `shownAt` in `api/src/__tests__`, `client/app` and `client/e2e`: only `rhythmSchema.unit.test.ts` names the fields, asserting they exist, which stays true. Adding types to its `VIEW_TYPES` list extends it.

## Done for SR5

- AC-40, AC-41, AC-43, AC-44, AC-46, AC-51, AC-52, AC-56, AC-67 met, each test named in the report; every test in §5's list, keyed from T0 = `2026-12-01`
- J5.7's rule: a second account refused, and nothing written, on the query and all eight mutations
- targeted tests green: `lookAhead.integration`, `session.integration`, `gathering.integration`, `rhythm.integration`, `rhythmSchema.unit`; `tsc` in api; no full suites
- the report written to `.tmp/SR5.report.md` in the seven parts and returned

## Not here

The look-ahead's screens, the `.ics` and capture onto a shown day (SR7); the record query (SR8).
