# SR4 · Session API: shell, look-back, gap — phase card

*For the Sonnet lane building SR4. Read `lifecycle/projects/tracker/brief-common.md` first; this card adds to it. Drafted by `build-phase SR4`, 2026-11-19, from `07-build-plan.md` §5 SR4, §2 PD-7, PD-8, PD-12, PD-13, §6.1–6.5, journeys J1.6, J3.9, J4.3–J4.6, J4.11, J5.7, J5.8, stage record `docs/development/SR3.md` (*Decided* row 4), and the code as it is: `rishe-eco/tracker` main @ 7d031e8. Root-sot at `docs/root-os @ 43d1c64`.*

## Your lane

| | |
|---|---|
| Working directory | the tracker checkout's `.claude/worktrees/sr4-session-api` |
| Branch | `sr4-session-api`, from local `main @ 7d031e8`, no upstream |
| Test database | `<worktree>/api/prisma/test.db` |
| Ports | none used (API tests only); slot A is held: `E2E_API_PORT=4010 E2E_WEB_PORT=5183` |
| Size | L: ~5–7 h, ~450–650 lines of app code, API only |

## Read, in this order

1. `lifecycle/projects/tracker/brief-common.md`
2. `07-build-plan.md` §5 **SR4**, all of it; §2 PD-7, PD-8, PD-12, PD-13; §6.2 (refusals, exact words), §6.3, §6.4, §6.5.
3. `02-spec.md` AC-28, AC-29, AC-31 to AC-39, AC-49, AC-50, AC-57, AC-63, AC-65, AC-66; §2.3 #19–#24, #31, #32.
4. `03-journeys.md` J1.6, J3.9, J4.3–J4.6, J4.11, J5.7, J5.8.
5. Code: `api/src/services/rhythm/crossing.ts` (the transaction, `withUserLock` and P2002 pattern to copy), `days.ts`, `rhythmState.ts`; `docs/development/SR0.md`, `SR1.md`, `SR3.md`.

## What to build

`api/src/services/rhythm/session.ts`, its SDL in `api/src/graphql/schema/typeDefs.ts`, thin resolvers in `query.ts` and `mutations.ts` (as `setCrossed` and `rhythmStatus` are wired), and `api/src/__tests__/session.integration.test.ts`. No schema change, no client change.

What the code check found, and how to read the plan:

- **`RhythmSession.dateKey` keeps the start date.** The schema comment says "started, or last continued"; AC-28 and J4.11 say a continued session keeps its date. Follow the spec; correct the comment (no migration). "Today" for a continued session is the request's `todayKey`.
- **Ranges.** From = the last completed session's `dateKey` (inclusive), else `RhythmState.switchDateKey`; to = `todayKey − 1`. An empty range (from > to) is stored as is and has no days. Gap block = from to `min(to, todayKey − spacingDays − 1)`, only when non-empty (J4.3: today 16 Dec, spacing 3 → 1–12 Dec).
- **Items (PD-13), per day in range:** "ask me", fateless actions whose `plannedDayKey` is that day, minus legacy done (PD-7b) and minus actions with a record that day answered in another session; plus every action with a record that day answered in **this** session, whatever its fate or day now. A record with `crossedAt` set and no answer → pre-filled "happened". Gap days are left out unless `gapChoice` is `fillIn`.
- **SR3 deletes an earlier day's open crossing on a later uncross** (`SR3.md` row 4). There is no record to read: such an action gets no pre-fill. If it is still "ask me", fateless and planned on that day, PD-13 asks it as an ordinary item. Don't expect or recreate the record.
- **`answerItem` and `setDontAsk` also take `todayKey`** (the move bound and "after today" need it; §5's signature omits it). Flagged for verify.
- **Moves** go through `plannedDayData`, freeze `firstDueKey` with `freezeFirstDue`, and freeze a legacy gathered row's `gatherKey` before moving, exactly as `crossOut` does. Allowed: `todayKey` to `todayKey + spacingDays − 1` (the pre-filled next date is `todayKey + spacingDays`), else `That day isn't one of the days being planned.`
- **Writes:** each mutation is one interactive transaction under `withUserLock`, with the unique-key retry outside it (the trap). `answerItem` on a `dateKey` outside the session's shown days answers `Not found`.
- **`rhythmSession(todayKey)`** returns the open session or null; it never creates one. `step` is an enum `lookBack | lookAhead | finish` from the stored times.

## Decided here

| # | Decision | Why |
|---|---|---|
| 1 | A day's items are not capped in the view; only the gap's stored list is capped at 200, in day order | Plan §10 left it to this card; a day of 200+ "ask me" items isn't a real case; easiest to add later |
| 2 | `startSession` upserts `RhythmState` first, as `ensureRhythm` does | A crafted call before Today's first load still gets a switch date (AC-1 unchanged) |
| 3 | `confirmCrossed` and `completeLookBack` record "happened" only on pre-filled items still unanswered; answers the person changed stay | AC-32's "didn't change"; never overwrites a choice |
| 4 | A follow-up that doesn't fit its answer is refused: `That follow-up doesn't fit that answer.` (`moved` with didn't happen or partly; `setAside`, `letGo` with didn't happen only; none with no longer matters) | The client prevents it (§6.2's rule); one new message, flagged for verify |
| 5 | With no gap choice yet, gap days are neither shown nor recorded by `completeLookBack` | AC-50: Fill in is what opens them |
| 6 | `setDontAsk(…, false)` sets `ask` on the action, its source and the same occurrences | Smallest undo; nothing records an earlier `justToKnow` there |
| 7 | An item set "don't ask" leaves the view at once; the screen's undo keeps the id | No per-session marker exists to keep it shown |
| 8 | A unit test in `rhythmSchema.unit.test.ts` asserts the session view types hold no `Int` field | §6.5's "views carry no totals", as a test |

## Tests that change on purpose

None. Grepped `rhythmSession`, `startSession`, `answerItem`, `confirmCrossed`, `completeLookBack`, `setDontAsk`, `setGapChoice`, `RhythmGap`, `answerSessionId`, `priorFate` in `api/src/__tests__`, `client/app/test`, `client/e2e`: only `rhythm.integration.test.ts` creates sessions directly, and `actions.integration.test.ts` asserts `updateAction` ignores `done`; both stay true.

## Done for SR4

- AC-28, AC-29, AC-31 to AC-39, AC-49, AC-50, AC-57, AC-63, AC-65, AC-66 met, each test named in the report; every test in §5's list, keyed from T0 = `2026-12-01`
- J5.7: a second account refused, and nothing written, on the query and all six mutations
- targeted tests green: `session.integration`, `crossing.integration`, `rhythm.integration`, `actions.integration`, `rhythmSchema.unit`; `tsc` in api; no full suites
- the report written to `.tmp/SR4.report.md` in the seven parts and returned

## Not here

The look-ahead, `markShown`, next date and Finish (SR5); `/session` and every screen (SR6); the record query (SR8).
