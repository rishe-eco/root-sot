**SR5** · branch `sr5-look-ahead` · base `main @ c7d3db8` · card `briefs/SR5.md` · landed 2026-11-19 · next: `verify SR5`

**Measured at land:** +469 app · +582 tests · 0 moved · 9 min 11 s · 139,170 tokens, against size M

---

# SR5 · Session API: look-ahead, next session, Finish: lane report

## 1. Branch and commit hashes

Branch `sr5-look-ahead` from `main @ c7d3db8`. One commit: `ccc5bef` "SR5: session API, look-ahead, next date, Finish" (all code and tests). Commit identity checked: `salmanian.foad2@gmail.com`.

## 2. Each file changed, and why

- `api/src/services/rhythm/lookAhead.ts` (new): the view (`rhythmLookAhead`) and `setNextDate`, `markShown`, `letAllGo`, `planItem`, `removeItem`, `completeLookAhead`, `setWhenWhere`, `finishSession`.
- `api/src/services/rhythm/session.ts`: exports `writeSession`, `refuseBeforeSessionDay`, `DEFAULT_SPACING_DAYS`, `Db`, `Ctx` (export keywords only).
- `api/src/graphql/schema/typeDefs.ts`: `LookAheadBlock`, `RhythmLookAhead`, `RhythmLookAheadDay`, the query and eight mutations.
- `api/src/graphql/resolvers/query.ts`, `mutations.ts`: thin `requireAuth` wrappers.
- `api/src/__tests__/lookAhead.integration.test.ts` (new): 32 tests.
- `api/src/__tests__/rhythmSchema.unit.test.ts`: `RhythmLookAhead` and `RhythmLookAheadDay` added to `VIEW_TYPES` (card decision 5).

## 3. Every suite or test file run

- `lookAhead.integration.test.ts`: Test Files 1 passed (1), Tests 32 passed (32)
- `session.integration`, `gathering.integration`, `rhythm.integration`, `rhythmSchema.unit` together: Test Files 4 passed (4), Tests 95 passed (95)
- `npx tsc --noEmit` in `api/`: clean.
- Not run: full suites (card). Client i18n checks: not run, no client change.
- Not done: I did not plant a violation to see a fence fail; no new fence was added (the `VIEW_TYPES` extension is the existing one).

AC coverage in `lookAhead.integration`: AC-40 ("accepts today+2 to today+7 and refuses…", pre-fill tests, J4.11 tests); AC-41 ("gathers to the day before it…", "gathers again on a retry"); AC-43/44 ("move, time, remove and undo" block, "No date yet"); AC-46/56 ("when and where", "Finish"); AC-51/52 ("From before" block); AC-67 ("From the gap", let-go block); J5.4, J5.5, J5.7 and the step-order refusal each have a test. Decision 6: the gathering test orders a routine occurrence with `orderDay` and asserts the later gathered occurrence has `sortOrder` 2000.

## 4. Decisions the card didn't make

1. **Stale draft date.** A stored `nextDateKey` below `todayKey + 2` (session continued days later, J4.11) reads as the pre-fill, in the view and in `completeLookAhead`, which overwrites it. Otherwise the days shown would be empty or past, and Finish could write a due date in the past. The card said "stored, else pre-fill"; this is my reading of spec §2.3 #20.
2. **`todayKey` check on the query and `setNextDate` too**, not only `planItem` and `completeLookAhead`: a todayKey before the session's date is refused with SR4's words on all four. `markShown`, `letAllGo`, `removeItem`, `setWhenWhere` and `finishSession` take no todayKey.
3. **`setNextDate` gathers on every call**, not only when the date changed, with `skipCompletedDates: true` (as Today's resolver does): a retry after a failed gather would otherwise never gather. It runs after the write commits.
4. **View shape.** `fromBefore` is null when not on offer (shown in an earlier session) and `[]` when on offer but empty; `fromGap` is null when the session has no gap. The "From the gap" block always shows while the gap exists (the gap is per session, so `shownAt` "set in this session" always holds). Lists are `[Action!]` with project included; days are `DayListItem` per day (all days from today to next-1, empty ones too). The view adds `whenTime` and `place` for the last step.
5. **`letAllGo` not-undo skips ids not in the block now** (no error); undo works on any owned id that is `PassedArchived`. Every id is ownership-checked first.
6. **`planItem` checks only ownership and `dateKey >= todayKey`**, not that the action is in some list; "Later…" has no upper bound.
7. **`removeItem(removed: true)`** sets `PassedArchived` whatever the current fate.
8. **`finishSession` upserts the state** (create path only if no state exists) and is refused on a retry with "This session is finished.", as every SR4 write is.
9. **`completeLookAhead` keeps `lookAheadDoneAt`** if already set (idempotent).
10. **Time check** on `planItem` and `setWhenWhere`: `HH:mm` 00:00 to 23:59 (capture's regex); `setWhenWhere` null clears both fields independently, place trimmed.

Canon made stale: none from a schema change (none was made). The card/plan §5 signatures for `planItem` and `completeLookAhead` gain `todayKey`; §5 `markShown`/`letAllGo` need the `LookAheadBlock` enum named; `02-graphql-api.md` needs the nine new operations and three new types; the open-work row "no test walks gather → orderDay → re-gather" is now closed.

## 5. Where the plan, card or brief was wrong, vague or incomplete

1. Plan §5 "From the gap … while `shownAt` is null or set in this session" is vacuous: a gap belongs to one session.
2. The plan does not say what the view returns when a block is not on offer versus empty; I chose null versus `[]` (decision 4).
3. The plan and card are silent on a stale draft next date after a continue (decision 1).
4. The card's "J5.7: a second account refused on the query and all eight mutations": the query and mutations refuse via `ensureOwned` on the session, so the "Not found" message is the same for a missing and a foreign id, as intended.
5. Card line 33 says gathering uses `{ todayDateKey, endDateKey }`; I added `skipCompletedDates: true` (decision 3). `getGatheringDateKeys` caps at today+7, which `next - 1 <= today+6` never reaches.

## 6. What I couldn't verify

- No HTTP-level (Apollo) test of the new SDL: the new operations are exercised through the services and the resolvers' `requireAuth` only; `tsc` passes and the SDL is covered by the existing schema unit test loading, but no query string was executed against the schema. A one-query smoke through `makeServer`, if one exists, would verify it.
- The mutation wrappers' argument pass-through (`planItem` takes the whole `args`, which includes `sessionId`, `actionId`, `dateKey`, `startTimeOfDay`, `todayKey`) is not tested by name beyond the "need a login" test.
- No stop under Budget.

## 7. One thing that would have made this stage faster

Python isn't on this machine, so the card's habit of scripted multi-file edits needs Node; the brief could say so (and that `edit.js`-style scripts with CRLF files should normalize line endings).
