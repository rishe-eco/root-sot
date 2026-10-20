# NR1 · The tile counts what Root owes — phase card

*For the Sonnet lane building NR1. Read `lifecycle/projects/root-app/brief-common.md` first; this card adds to it. Drafted by `build-phase NR1`, 2026-10-20, from `changes/02-change-needs-root-tile.md#NR1`, no design plates (no new screen), no open-work rows, and the code as it is: `rishe-eco/root-app main @ 1ddf5d0` (read locally: the fetch failed, no network). root-sot at `lifecycle/stage-2f-needs-root-tile @ ace74ff`.*

## Your lane

| | |
|---|---|
| Working directory | `<checkout>/.claude/worktrees/nr1-needs-root-tile` (the Linux machine's checkout, `config.md` §1) |
| Branch | `nr1-needs-root-tile`, from local `main @ 1ddf5d0`, no upstream |
| Test database | `root_wt_a_test` (slot A; it exists) |
| Ports | API `4201`, web `4273` (free at launch) |
| Variables | `ROOT_TEST_DB=root_wt_a_test E2E_API_PORT=4201 E2E_WEB_PORT=4273`. **Not** `E2E_BROWSER_CHANNEL`: this machine has Chrome, Playwright's default (`config.md` §2) |
| Size | S: 1–2 h, ~40–70 lines of app code, plus tests |

## Read, in this order

1. `lifecycle/projects/root-app/brief-common.md`
2. `ecosystem/modules/01-root-studio-journeys/changes/02-change-needs-root-tile.md`: all of it. Its NR1 stage names your files, tests and traps, and this card defers to it.
3. In root-app: `apps/api/src/graphql/resolvers/home.ts` (`loadHomeContracts`, `needsRootQueue`), `apps/api/src/lib/home.ts` (`needsRoot`, read only), `apps/api/src/graphql/typeDefs.ts` around line 2757, `apps/web/src/desk/Overview.tsx`, and `NEEDS_ROOT_QUEUE` in `apps/web/src/lib/queries.ts` (line 2510).
4. `apps/api/src/test/j12.test.ts`, the section headed "V4's queue, re-pointed" (from line 612): its fixtures `f`, `contractB`, `staff`, `openNote`, and the queue test you sit beside. `apps/api/src/test/calendar.ts` (`onDay`).
5. `apps/web/e2e/25-home.spec.ts` (the sales Overview test, line 217, and its `beforeEach` reset) and `apps/web/e2e/02-contract-flow.spec.ts` line 299 ("an admin sees a non-zero count").

## What this card settles

The code check at `1ddf5d0` agrees with the note:
- `needsRootQueue` loads with `loadHomeContracts({ status: { not: 'DISCARDED' }, deliveredAt: null }, new Date())` and filters with `needsRoot(user, contracts)`, then slices with `clampLimit(args.limit, 20, 100)`. Lift the load-and-filter into one unexported function in `home.ts` that both resolvers call; the slice stays in the queue.
- `homeQueries` is spread into `Query` in `resolvers/index.ts`, so a new key on `homeQueries` needs no wiring there. Update the comment at `index.ts:173` to name the count if it lists the fields.
- The tiles have no per-status attribute today: they are `.tile` divs keyed by status. Add `data-status={s}` to each `.tile`.
- The seed (`apps/api/prisma/seed.ts:258`) makes `RC-2026-021` with status `WAITING_ON_ROOT`. Whether it owes Root anything after `resetTestDatabase` is what decides if NR-3's e2e check can be seen failing on `main`. Find out, and report it.
- **Also run** `apps/web/src/lib/queriesSchema.test.ts` (`npm test --workspace=apps/web -- src/lib/queriesSchema.test.ts`): it validates every `gql` document in `queries.ts` against `typeDefs`, so it checks `NEEDS_ROOT_COUNT`. The note's run list leaves it out.

## Decided here

| # | Decision | Why |
|---|---|---|
| 1 | NR-5's test sits in `j12.test.ts` beside the count's other tests. `v4.test.ts`'s "a customer is refused all three staff queries" stays as it is | The note says only `j12.test.ts` and `25-home.spec.ts` change; v4's test names "three" queries |
| 2 | The e2e gets its data from the existing `beforeEach` reset and the test's own `submitFeedback`. No new seed rows | The note's "Not changed" list, and the reset already makes the queue non-empty |
| 3 | NR-6's Persian check reads the `WAITING_ON_ROOT` tile on `/fa/desk/overview` and expects the number in Persian digits (`۰`–`۹`), compared with the English page's number | `formatCount` is the source; the test pins that the new source still goes through it |

## Tests that change on purpose

| Test file | Asserts today | New rule |
|---|---|---|
| `apps/web/e2e/25-home.spec.ts`, "sales' Overview keeps its tiles…" | the tiles render and the wizard contract's row is in the queue | adds: the `[data-status="WAITING_ON_ROOT"] .tile-count` number equals the count of `needs-root-row` rows (NR-3), and the Persian page shows it in Persian digits (NR-6) |

The grep found no other test that reads the `WAITING_ON_ROOT` tile or asserts that `needsRootCount` is absent.

## What the verify deploys

A push to `main` deploys (`config.md` §7). CI runs `typecheck`, `npm test` and `test:integration`, so `j12.test.ts`'s new tests guard the API side. After the deploy, on the live desk as sales: the "Waiting on Root" tile equals the number of rows in the Needs Root box (both 0 when the box is empty). That is the founder's live check, past the verification ceiling.

## Done for NR1

- NR-1, NR-2, NR-4 and NR-5 by the new `j12.test.ts` tests, written first and seen failing on the branch's first commit; NR-3 and NR-6 by `25-home.spec.ts`
- the note's targeted runs, plus `queriesSchema.test.ts`, green, with counts in the report; `npm run typecheck` clean; no full suites
- `02-contract-flow.spec.ts -g "non-zero count"` green, and the report says which tiles still make its sum non-zero
- the report written to `.tmp/NR1.report.md` and returned

## Not here

Everything in the note's **Not here**. Also: the TK1 deploy run's URL in `docs/development/TK1.md` (`verify` adds it), and `docs/development/` records generally (`verify` writes NR1's).
