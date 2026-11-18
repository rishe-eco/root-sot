# SR0 · Schema and the shared day rules — phase card

*For the Sonnet lane building SR0. Read `lifecycle/projects/tracker/brief-common.md` first; this card adds to it. Drafted by `build-phase SR0`, 2026-11-19, from `07-build-plan.md` §5 SR0 (with §6.2 refusals, §6.3 tables, §6.4 limits, §2.2 #8 ordering, §2 PD-3/PD-6/PD-7a/PD-11, §6.5), design plate for W28, and the code as it is: `rishe-eco/tracker` main @ eea1c59.*

## Your lane

| | |
|---|---|
| Working directory | the tracker checkout's `.claude/worktrees/sr0-schema-day-rules` |
| Branch | `sr0-schema-day-rules`, from local `main @ eea1c59`, no upstream |
| Test database | `<worktree>/api/prisma/test.db` (pushed fresh by Vitest) |
| Ports | slot A, e2e API 4010 / web 5183 — not needed; SR0 runs no e2e |
| Size | L: 4–6 h, ~400–600 lines of app code |

## Read, in this order

1. `lifecycle/projects/tracker/brief-common.md`
2. `07-build-plan.md` §5 SR0 **in full**; then §6.2 (refusals), §6.3 (tables, authoritative field lists), §6.4 (gathering horizon limit), §2.2 #8 (day ordering), and PD-3, PD-6, PD-7a, PD-11 in §2.
3. No earlier stage record exists (SR0 is the first stage); `docs/development/` is created by SR0's verify, not you.
4. Canon by section: `tracker/canon/02-architecture/01-data-model.md` (schema), `02-graphql-api.md` (API), and convention 12 in `04-conventions.md` (migrations).

## What to build

Everything in §5 SR0's *Schema*, *Logic*, *API or routes* and *Screens*, in a new `api/src/services/rhythm/` (`days.ts`, `dayList.ts`), one migration `add_session_rhythm` (columns and tables only, no `UPDATE`), and the client reload line. Field lists are §6.3; take them from there exactly. Beyond the plan, the code check found these you must also do:

- **`updateAction` must stop writing `done`.** It honors it today (`mutations.ts:164`, `...(done !== undefined && { done })`). Remove that write (PD-6); `toggleAction` stays the only path that flips `done`. Keep the `done` arg in the SDL so callers don't break; the resolver ignores it.
- **No resolver requires an estimate.** Remove the `estimatedTimeMinutes is required` enforcement from the action-creating/updating resolvers (`mutations.ts:103` and its callers); a dated action with no estimate now saves (AC-26 server half, AC-5).
- **`getGatheringDateKeys(today, endKey?)`** replaces the fixed three-day window (`actionGathering.ts:268`): today through max(today+2, endKey), capped at today+7 (§6.4, AC-48). `runActionGathering` gains `endDate` and threads it through; dedup keys on `gatherKey ?? gatheredActionKey(row)` (PD-3), and `gatherKey` is set on every gathered row at create.
- **`clearDb` in `api/src/test/helpers.ts`** must delete the four new tables (children before `user.deleteMany()`), or every rhythm integration test FK-fails. The plan omits this; flag it in report item 5.

Match conventions: resolvers use `requireAuth` + `ensureOwned` → `Not found`; `schema.prisma` is CRLF; use the Windows migration recipe in brief-common.

## Decided here

| # | Decision | Why |
|---|---|---|
| 1 | `rhythmStatus(todayKey)` returns a `RhythmStatus` object: `state` (one of `first`/`next`/`dueToday`/`wasDue`/`inProgress`) plus the dates each line needs (`switchDateKey`, `spacingDays`, `nextDueKey?`, `inProgressSessionId?`). Finalize the exact fields against your line tests. | §10 left the shape to the card; no screen consumes it until SR2, so it only has to be testable. |
| 2 | `todayActions`/`getTodayActions` stays beside the new `dayList`; SR2 retires it. | §10 call; the SR0 trap says the gate, wizards and `preDayStatus` keep working. |
| 3 | `runActionGathering`'s `endDate` arg is `String` (nullable), matching the other `endDate: String` SDL args. | Consistency with the existing schema. |
| 4 | The schema assertions (`schema.unit`) are a text fence over `schema.prisma`, like `noticingFences.unit.test.ts`; put them in `schema.unit.test.ts` if it reads the file, else a new `rhythmSchema.unit.test.ts`. | The existing `schema.unit.test.ts` tests only the GraphQL SDL; verify should confirm the home. |

## Tests that change on purpose

The lane changes these and no others; probe each new rule with inputs the tests don't hold.

| Test file | Asserts today | New rule |
|---|---|---|
| `api/src/__tests__/recurrence.unit.test.ts` | `getGatheringDateKeys` returns exactly today..+2 (lines ~31–47, `:32`/`:33`) | horizon is max(today+2, endKey), ≤ today+7 |
| `api/src/__tests__/gathering.integration.test.ts` | counts/date keys tied to the 3-day window; dedup by `gatheredActionKey` only | window driven by `endDate`; dedup by `gatherKey ?? gatheredActionKey`; edit-after-move/retime doesn't recreate |
| `api/src/__tests__/actions.integration.test.ts` | `requires estimatedTimeMinutes when tbd is set` throws (lines ~31–37) | dated-without-estimate saves; `updateAction` ignores `done` (new); `firstDueKey` set on create and frozen before a date change |

New test files to add: `dayList.integration` (order per §2.2 #8, overlap with/without estimate per D-4, fates excluded), `orderDay` refusals (§6.2 `Order applies within one start time.`, date format), `rhythm.integration` (`ensureRhythm` idempotent, each `rhythmStatus` line form), and a client test that a `GRAPHQL_VALIDATION_FAILED` error raises the reload line.

## Proving it here

No e2e and no live site: SR0 is schema, server logic and one client line. The reload line (PD-11, W28 neutral style) is proven by a thin client component test on `useApi`/`root.tsx` mocking the error; the daily rules by API integration tests against your test database.

## What the verify deploys

Nothing. The first deploy is at MS2 (push order PD-10); SR0 is not pushed. The migration runs at boot when that deploy happens, after a backup.

## Done for SR0

- AC-5, AC-6, AC-48, AC-54, AC-72 met, each with its test named in the report.
- Targeted tests green with counts in the report; `npx tsc --noEmit` in `api/` and `client/`, and both `client` `i18n:check-*`, green. No full suites.
- The report written to `.tmp/SR0.report.md` and returned as your last message.

## Not here

Crossing out (SR1), Today's screen and the switch/`ensureRhythm`-from-client (SR2), sessions (SR4). Don't call `ensureRhythm` from the client here. Don't write a stage record or touch `main`.
