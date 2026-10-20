# 02 — The Overview's "Waiting on Root" tile follows attention

*Module `ecosystem/modules/01-root-studio-journeys/` · Change note written by hand in place of `spec` in `change` mode (stage 3 isn't built), rollout stage 2, session F · 2026-10-20. Kind: change · written against `rishe-eco/root-app main @ 1ddf5d0` · prefix `NR`. A Change to the desk's Overview and one staff query. The **Stages** section below stands in for the build plan. Grading: claims about the code are **as-built** at that commit; everything else is **proposal** until verified.*

*The module's earlier documents predate the method and stay in `ecosystem/working/`. This note takes item #2 of the founder's dashboards review, `docs/development/wp-dashboards.md` in root-app, under its decision D2.*

## What changes and why

**Today.** The desk's Overview (`apps/web/src/desk/Overview.tsx`, route `/<lang>/desk/overview`, `contracts.readAll` only) shows two numbers about the same thing that can disagree. The tile row counts contracts by their stored `Contract.status`, through `allContractStatusCounts` (`resolvers/query.ts`, a `groupBy` on `status`). The Needs Root box beside it lists contracts Root owes something on, through `needsRootQueue` (`resolvers/home.ts`), which J12 re-pointed at the attention module: `needsRoot()` in `apps/api/src/lib/home.ts` keeps a contract that is not discarded, not delivered, and has at least one attention item with `waitingOn === 'ROOT'`. A contract sales marked "Waiting on Root" with nothing owed counts in the tile and is missing from the box, so the founder saw "Waiting on Root: 1" next to "Nothing is waiting on Root". The reverse also happens: a contract marked "Waiting on the customer" that owes an answer is in the box and not in that tile. `j12.test.ts`'s queue test pins both cases on the box's side. The box is also capped: `needsRootQueue(limit: Int = 20)`, at most 100.

**After.**
- The "Waiting on Root" tile shows the number of contracts the attention module says Root owes something on: the same rule as the Needs Root box, and not capped by the box's limit.
- The number comes from a new staff query, `needsRootCount: Int!` (`contracts.readAll`), which runs the same load and the same `needsRoot()` as `needsRootQueue`, through one shared function so the two can't drift.
- The other tiles still count stored status. The tile keeps its label, "Waiting on Root", in both locales.

### Decided by the founder at this step

| # | Question | Answer [F] |
|---|---|---|
| 1 | Which item does Change note 02 stage? | wp-dashboards #2 alone (session F, 2026-10-20). #1 and #3 wait for later notes |
| 2 | What does the tile count? | What Root owes, by the attention module, as the Needs Root box does (D2 of `wp-dashboards.md`, 2026-10-08) |

**Decided here, by Claude** (not put to the founder; refuse it on the diff if it's wrong):
- **A new count query, not the queue's length or a changed `allContractStatusCounts`.** The queue's length is capped at its `limit`, so above 20 the tile would be wrong. Rewriting the `WAITING_ON_ROOT` row of `allContractStatusCounts` would make a field named "status counts" count something else, and its counts would no longer add up to the number of contracts (`v4.test.ts` pins that sum).
- **The label stays "Waiting on Root".** D2's own words name that tile; a rename is a copy change nobody asked for.

### What stays

- `allContractStatusCounts`, `contractStatusCounts`, `needsRootQueue` and their tests: same arguments, same results.
- The attention module (`lib/attention.ts`) and `needsRoot()`'s rule.
- The other tiles, the Needs Root box, the review queue and the overdue-dependencies panel.
- `Contract.status` and every place that sets or shows it, including the contracts list and its filters.
- No migration, no schema change in `schema.prisma`, no new environment variable, and no new string in either locale.

## Acceptance criteria

| # | Item | Criterion |
|---|---|---|
| NR-1 | wp-dashboards #2 | A contract marked `WAITING_ON_ROOT` that owes nothing doesn't count in the Overview's "Waiting on Root" tile |
| NR-2 | wp-dashboards #2 | A contract marked anything else (e.g. `WAITING_ON_CUSTOMER`) that Root owes something on counts in that tile |
| NR-3 | wp-dashboards #2 | On the Overview, the tile's number equals the number of rows in the Needs Root box whenever the box holds fewer than its limit, and the empty box goes with a tile of 0 |
| NR-4 | — | `needsRootCount` isn't capped: with more contracts owed than `needsRootQueue`'s limit, the count is the full number |
| NR-5 | — | `needsRootCount` is `contracts.readAll` only: a designer and a customer get `FORBIDDEN`, as for `needsRootQueue` |
| NR-6 | — | The tile shows its number in the locale's digits on `/fa/desk/overview`, as the other tiles do (`formatCount`) |

## What must not break

- J12's queue: `j12.test.ts`'s "the Needs-Root queue is read from attention" test, and `home.test.ts`'s `needsRoot` tests, unchanged.
- V4: `v4.test.ts` (the counts' sum, the capability guards on the three queries), and `s1.test.ts`'s capability matrix, which calls `allContractStatusCounts`.
- e2e: `25-home.spec.ts`'s "sales' Overview keeps its tiles and a Needs-Root queue…", and `02-contract-flow.spec.ts`'s "an admin sees a non-zero count on the Overview (V4)", which sums every tile.
- A designer who types `/desk/overview` is still sent to My work.

## Stages

### NR1 · The tile counts what Root owes

**Goal.** The Overview's "Waiting on Root" tile reads `needsRootCount`, which counts by the attention module, as **After** says.

**Branch and slot.** `nr1-needs-root-tile`, the free lane slot in `config.md` §4.

**Files.**
- `apps/api/src/graphql/resolvers/home.ts`: `needsRootCount`, and the load-and-filter step shared with `needsRootQueue`.
- `apps/api/src/graphql/typeDefs.ts`: `needsRootCount: Int!` on `Query`, documented next to `needsRootQueue`.
- `apps/web/src/lib/queries.ts`: a `NEEDS_ROOT_COUNT` document.
- `apps/web/src/desk/Overview.tsx`: the `WAITING_ON_ROOT` tile reads it. Update the component's doc comment, which says the tiles "still count `Contract.status`". A `data-status` attribute on each tile, for the e2e.
- Tests: `apps/api/src/test/j12.test.ts` (next to the queue's test), `apps/web/e2e/25-home.spec.ts`.
- **Not changed:** `lib/home.ts`, `lib/attention.ts`, `resolvers/query.ts`, `schema.prisma`, the locale files, `desk/Contracts.tsx`.

**Tests.**
- **Integration, in `j12.test.ts`, written first, failing against `main @ 1ddf5d0`** (the field doesn't exist):
  - with the queue test's two contracts (A marked `WAITING_ON_ROOT`, owed nothing; B marked `WAITING_ON_CUSTOMER`, owed two notes), `needsRootCount` is 1, and equals `needsRootQueue`'s length (NR-1, NR-2);
  - with more contracts owed than a `needsRootQueue(limit: 2)` returns, the count is the full number (NR-4). Make the extra contracts with the fixture's helpers, not literal future dates;
  - a designer and a customer get `FORBIDDEN` (NR-5).
- **e2e, in `25-home.spec.ts`'s sales Overview test:** the `WAITING_ON_ROOT` tile's number equals the count of `needs-root-row` rows (NR-3). Seen failing first only if the seed has a contract marked `WAITING_ON_ROOT` that owes nothing, or the reverse; if it doesn't, say so in the report and rely on the integration test. One check on `/fa/desk/overview` reads the tile in Persian digits (NR-6).
- Run targeted: `npm run test:integration -- src/test/j12.test.ts src/test/v4.test.ts src/test/s1.test.ts`, `npm test --workspace=apps/api -- src/lib/home.test.ts`, then `npm run e2e -- -- 25-home.spec.ts --workers=1` and `02-contract-flow.spec.ts -g "non-zero count"`. Run `npm run typecheck`.
- **Tests that change on purpose:** `25-home.spec.ts`'s sales Overview test gains its assertions. Nothing else.

**Image and deploy.** No new environment variable, no migration. The API changes, so the box builds a new API image on deploy, as it does on every push to `main` (`config.md` §7). A push to `main` deploys.

**Acceptance.** NR-1, NR-2, NR-3, NR-4, NR-5, NR-6.

**Size: S.**

**Traps.**
- **One rule, written once.** `needsRootCount` must call the same load (`loadHomeContracts({ status: { not: 'DISCARDED' }, deliveredAt: null }, now)`) and `needsRoot(user, …)` as the queue, through a shared function. A second hand-written filter is the drift this change exists to remove.
- **Don't slice the count.** The queue's `clampLimit` belongs to the queue only.
- **Not a `groupBy`.** Attention is computed per contract in TypeScript, not in SQL. Don't try to push it into Prisma.
- **The tile is one of `ALL_STATUSES`.** Swap the source for that one status inside the existing map; don't add a seventh tile or reorder the row. Keep `formatCount` and the comment about `num-latin`.
- **Loading:** the tiles render 0 until their data arrives (`02-contract-flow.spec.ts` polls for that). The new query should behave the same: `skip: !allowed`, and 0 until it lands.
- **`02-contract-flow.spec.ts` sums every tile.** It must still see a non-zero sum; if the seed's only counted contracts were `WAITING_ON_ROOT` by status alone, that test changes meaning. Check, and report.
- **The fixture clock:** no literal future dates (root-app `CLAUDE.md`, *Tests*).
- **On the Linux machine, e2e runs on Chrome:** don't export `E2E_BROWSER_CHANNEL=msedge` (`config.md` §2). Check the slot's ports are free first (`config.md` §3).

**Not here:** wp-dashboards #3 (the tiles linking to the contracts list: once this lands, the "Waiting on Root" tile counts something the list's status filter doesn't, which #3's note must settle); the other tiles' meaning; `ContractStatus` itself, or retiring `WAITING_ON_ROOT`; wp-dashboards #1 and #4–#8.

## What this makes stale

| File | Owner | Caught up by |
|---|---|---|
| root-app `docs/development/wp-dashboards.md` #2 | `verify` (development records) | NR1's stage record names it as built |
| `ecosystem/working/root-studio-user-journeys.md` J3's banked trap on `ContractStatus` (line 290: "until the admin journey decides its fate") | the founder (a working file, before the method) | note there that the Overview tile follows attention, once NR1 is verified and deployed |
| `ecosystem/working/root-studio-v1-readiness.md` §3.2 | the founder (a working file, before the method) | strike #2 once NR1 is verified and deployed |

## Changelog

- **0.1 · 2026-10-20** — Note, against `main @ 1ddf5d0`, written by hand from `lifecycle/templates/change-note.md` in rollout stage 2, session F.
