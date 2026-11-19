# SR8 · The record query, `rhythmGate` — phase card

*For the Sonnet lane building SR8. Read `lifecycle/projects/tracker/brief-common.md` first; this card adds to it. Drafted by `build-phase SR8`, 2026-11-19 (unattended), from `07-build-plan.md` 0.3 §5 SR8, `06-eval-plan.md` §1 (F7, F8, W1) and §3.A, `02-spec.md` §2.3 #36, §2.4 #39–#42 and AC-58, no design plates, no open-work rows, and the code as it is: `rishe-eco/tracker` main @ da6b5e0. Root-sot at `docs/root-os @ c137d18`.*

## Your lane

| | |
|---|---|
| Working directory | the tracker checkout's `.claude/worktrees/sr8-rhythm-gate` |
| Branch | `sr8-rhythm-gate`, from local `main @ da6b5e0`, no upstream |
| Test database | `<worktree>/api/prisma/test.db` |
| Ports | slot A, unused: no e2e in this stage |
| Size | S: about two hours, ~300 lines of app code |

## Read, in this order

1. `lifecycle/projects/tracker/brief-common.md`
2. `07-build-plan.md` §5 SR8, and §10's *Left to the card* (the report's line format is yours)
3. `06-eval-plan.md` §1 (rows F7, F8 and the W1 paragraph) and §3.A: what each measure is
4. `02-spec.md` §2.3 #36, §2.4 #39–#42, §3 (M1, M2, M3, M6), AC-58
5. In the code: `api/prisma/schema.prisma` (`RhythmState`, `RhythmSession`, `DayRecord`, `RhythmGap`, `Action`); `api/src/services/rhythm/days.ts` (`addDays`, `plannedDayKey`); `session.ts` lines 60–75 (`keysBetween`, `shownDayKeys`) and where `lookBackStartedAt`, `lookBackFinishedAt`, `gapChoice` and `answerSessionId` are written; `lookAhead.ts` `finishSession`; `api/src/__tests__/session.integration.test.ts` lines 1–40 for the fixture pattern (fixed `T0`, never today's date).

## What to build

- **`api/src/services/rhythm/gateReport.ts`**, two parts. `loadGateData(prisma, userId, fromKey)` reads with `findUnique`/`findMany` only, every query filtered by `userId`. `gateReport(data, fromKey)` is pure: rows in, a typed report out. `formatGateReport(report)` turns it into text. The window is the 28 keys `fromKey` … `addDays(fromKey, 27)`, inclusive.
- **`api/src/scripts/rhythmGate.ts`**: parses `--email` and `--from` (refuse a bad key with `assertDateKey`'s text, an unknown email with `No user with that email.`, exit 1), looks the user up, prints the report, disconnects. Nothing else. The `main()` call sits at the foot, guarded by `require.main === module`.
- **`api/package.json`**: `"rhythm:gate": "node dist/scripts/rhythmGate.js"`. Confirm `npm run build` emits `dist/scripts/rhythmGate.js` (the Dockerfile copies the whole build, so nothing else changes there).
- The measures, as *Decided here* settles them. Times print as `m:ss`; every list line names its session by date key, never by id.

## Decided here

| # | Decision | Why |
|---|---|---|
| 1 | A session is "in the window" by its `dateKey`. M1 counts those with `completedAt` set; the ones without are listed as started and not completed | Eval plan §3.A M1; `dateKey` is kept across a continue (§2.3 #20) |
| 2 | M2 runs over completed sessions only. Each stretch is prior session's date (or `switchDateKey` before the first) to this one. A stretch over 7 days reads `gap stored` (a `RhythmGap` row for the session ending it), `filled in` (`gapChoice = fillIn`), or `neither`. The trailing stretch from the last session to the window's last day is printed too, as `no session after it` | Eval plan §4's Fail row reads that trailing stretch; spec §2.4 #39 |
| 3 | M3 is for completed sessions with both look-back times. *Paused*: the finish's UTC date is later than the start's, or the span is over 30:00. Median of the unpaused; an even count averages the middle two, rounded down to the second. A completed session missing either time is listed as `no look-back times` | Eval plan F7 (that is the Invalid reading), F8; the box runs in UTC and stores no time zone |
| 4 | Items per look-back: the day records answered in that session (`answerSessionId`), with its range's day count less a stored gap. What the look-back *showed* can't be rebuilt after the fact; the line says "answered" | Smallest honest count |
| 5 | Begun after its due date: a session whose `dateKey` is later than the previous completed session's `nextDateKey`. The first session has no due date | `RhythmState.nextDueKey` holds only the latest |
| 6 | M6: distinct `DayRecord.dateKey` in the window with `crossedAt` set, printed `n of 28` | Eval plan §3.A M6 |
| 7 | W1: over the days covered by the look-backs of the window's sessions with `lookBackFinishedAt` set, less any stored gap's days: actions with `reviewSetting = ask`, still planned that day (`plannedDayKey`), no fate, not done, and either no record or a record with no answer and not crossed, or `didntHappen` with no follow-up. Count, then title, day, session date | Spec §2.3 #36; a crossed, unanswered record reads as "happened" (`session.ts` `computeDays`) |
| 8 | Line format: one heading line per measure (`M1 sessions held: 8`), indented list lines under it, plain ASCII, no colour | Plan §10 leaves it to the card |

## Tests that change on purpose

None. No test reads `src/scripts/`, `package.json`'s scripts, or a gate report.

## Proving it here

`npx vitest run src/__tests__/rhythmGate.integration.test.ts` and `npm run build`, then `node dist/scripts/rhythmGate.js --email <fixture user> --from <key>` once against a scratch copy of the test database (`DATABASE_URL=file:./prisma/sr8-scratch.db`, pushed with `npx prisma db push`), so the compiled command is seen to print. Paste its output in the report. Never point it at `dev.db` or production.

## Done for SR8

- AC-58: `rhythmGate.integration.test.ts` builds the plan's fixture (a paused look-back, a stored gap, a filled-in return, W1 items of both kinds, a crossed unanswered record that is *not* W1, another user's rows that change nothing, a session begun after its due date, an even-count median) and asserts every measure in the report object and one line of the text.
- The text fence, in the same file or a `*.unit.test.ts`: a regex for `\.(create|createMany|update|updateMany|upsert|delete|deleteMany|executeRaw)\w*\(` and `$executeRaw`; it matches a planted `prisma.action.update(` once, and matches nothing in `gateReport.ts` or `rhythmGate.ts`.
- `tsc` clean; the targeted tests green, counts in the report; no full suites.
- The report written to `.tmp/SR8.report.md` and returned.

## Not here

Running it against production (founder only, eval plan §2, `unattended.md` rule 3). Reading the results (E2, E3). Any resolver, screen or schema change. A "fix-up" write, even for a missing `RhythmState`: print `no rhythm state` and stop.
