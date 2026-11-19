**SR8** · branch `sr8-rhythm-gate` · base `main @ da6b5e0` · card `briefs/SR8.md` · landed 2026-11-19 · next: `/verify SR8 tracker/modules/05-session-rhythm`
**Measured at land:** +344 app · +217 tests · 0 moved · 6 min 22 s · 99.6k tokens, against size S

---

# SR8 · The record query, `rhythmGate`: lane report

## 1. Branch and commit hashes

Branch `sr8-rhythm-gate` from `main @ da6b5e0`. One commit: `258fec7` SR8: the record query, rhythmGate (all four files). Identity checked before the commit: `git config user.email` = salmanian.foad2@gmail.com.

## 2. Each file changed, and why

- `api/src/services/rhythm/gateReport.ts` (new): `loadGateData` (reads only, every query filtered by `userId`), pure `gateReport`, `formatGateReport`, plus small exported helpers (`medianSeconds`, `mss`, `daysBetween`).
- `api/src/scripts/rhythmGate.ts` (new): `--email`, `--from`, prints the report, disconnects; `main()` guarded by `require.main === module`.
- `api/package.json`: `"rhythm:gate": "node dist/scripts/rhythmGate.js"`.
- `api/src/__tests__/rhythmGate.integration.test.ts` (new): AC-58 fixture, a >30-minute paused case, the no-state case, and the write fence.

## 3. Every suite or test file run

- `npx vitest run src/__tests__/rhythmGate.integration.test.ts`: Test Files 1 passed (1), Tests 5 passed (5).
- `npx tsc --noEmit` in `api/`: clean. `npm run build`: clean, emits `dist/scripts/rhythmGate.js`.
- Compiled command, against `prisma/sr8-scratch.db` (pushed, one seeded user; deleted afterwards), output:
```
Window: 2026-12-01 to 2026-12-28 (28 days)
M1 sessions held: 1
  2026-12-03
Started and not completed: 0
M2 longest stretch: 25 days
  2026-12-01 to 2026-12-03: 2 days
  2026-12-03 to 2026-12-28: 25 days, no session after it
M3 look-back time, median of unpaused: 4:31
  2026-12-03: 4:31, 3 days, 0 answered
Paused look-backs: 0
No look-back times: 0
Begun after its due date: 0
M6 days with a crossing: 0 of 28
W1 left behind: 0
```
  Unknown email printed `No user with that email.` (exit 1); `--from 2026-02-30` printed `Date must be YYYY-MM-DD` (exit 1).
- Not run: client (untouched, so no tsc or i18n checks), full suites (brief), e2e (no slot needed).

## 4. Decisions the card didn't make

1. A missing `RhythmState` prints the window line then `no rhythm state` and stops (card's "Not here"); the report type has a `noState` variant.
2. Stretch "prior session" is the previous completed session overall (it may lie before the window), ordered by `dateKey` then `startedAt`; the trailing stretch runs from the last completed session on or before the window's last day (else `switchDateKey`).
3. Only a stretch over 7 days gets a gap label; the trailing stretch gets none.
4. "Items per look-back" prints as `N days, M answered` on each M3 line, for no-times sessions too (`no look-back times`). Days = range less the session's `RhythmGap` days.
5. W1: loader pre-filters actions to `reviewSetting = ask`, no fate, not done, planned in the covered span; the pure function then checks the exact covered days (a session's range less its stored gap, only sessions with `lookBackFinishedAt`). A day covered by two sessions is credited to the earlier one. List sorted by day, then title.
6. Begun-after-due: previous completed session is found by (`dateKey`, `startedAt`) order, and also applies to started-not-completed sessions in the window.
7. Wrote `api/.env` with dummy values (not copied from main, which may hold a real Anthropic key); it is git-ignored.
8. A look-back with a negative span (finish before start) is not special-cased.
Canon made stale: none (no schema change). `config.md` could note the new command if it lists scripts.

## 5. Where the plan, card or brief was wrong, vague or incomplete

1. Card says M2's `gap stored` is "a RhythmGap row for the session ending it"; the code matches, but a stored gap and `gapChoice = fillIn` are exclusive in practice, so `neither` means a long stretch with no look-back gap block at all (e.g. a session begun with no range gap). Fine, but worth saying in the eval plan's reading.
2. Brief says copy `api/.env` from main; the task said create a dummy one. Followed the task.
3. The seed for the scratch DB needs `password` and `name` on `User`; nothing in the card names a fixture-user helper for scripts, so I used a throwaway node file (not committed).

## 6. What I couldn't verify

- Behaviour against real production data (founder only). W1 and the median are verified on the fixture only.
- The Docker image copy of `dist/scripts/rhythmGate.js` (the Dockerfile was not read or run); a `docker exec` of it is MS2's check.
- Line endings: git warned LF-to-CRLF on the new files (repo autocrlf); not an issue seen elsewhere.

## 7. One thing that would have made this stage faster

A card line saying whether the lane copies or creates `api/.env`, and a shared `createTestUser`-style seed helper usable from a script for the "see it print" step.
