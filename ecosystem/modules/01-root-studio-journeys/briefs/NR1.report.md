**NR1** · branch `nr1-needs-root-tile` · base `main @ 1ddf5d0` · card `briefs/NR1.md` · landed 2026-10-20, next: `verify NR1`

**Measured at land:** +52 app (−9) · +62 tests · 0 moved · 30.9 min · 103,330 tokens (33 tool calls), against size S

---

# NR1 · The tile counts what Root owes: lane report

## 1. Branch and commit hashes
Branch `nr1-needs-root-tile` from `main @ 1ddf5d0`. Identity: `mark2daynew@gmail.com` (git user markRice).
- `8182e38`: the three new j12 tests only (NR-1, 2, 4, 5), seen failing first ("Cannot query field needsRootCount").
- `5dac6fc`: the implementation and the e2e assertions.

## 2. Each file changed, and why
- `apps/api/src/graphql/resolvers/home.ts`: unexported `loadNeedsRoot(user)` (load + `needsRoot`) shared by `needsRootQueue` (which still slices) and the new `needsRootCount` (`contracts.readAll`, unsliced).
- `apps/api/src/graphql/resolvers/index.ts`: comment names the count (no wiring needed).
- `apps/api/src/graphql/typeDefs.ts`: `needsRootCount: Int!`, documented beside the queue.
- `apps/web/src/lib/queries.ts`: `NEEDS_ROOT_COUNT`.
- `apps/web/src/desk/Overview.tsx`: the `WAITING_ON_ROOT` tile reads it (0 until it lands, `skip: !allowed`); `data-status` on each tile; doc comment updated.
- `apps/api/src/test/j12.test.ts`: three tests beside the queue's.
- `apps/web/e2e/25-home.spec.ts`: sales Overview test gains NR-3 and NR-6 assertions.

## 3. Every suite or test file run
- `j12.test.ts` before the code: 16 pass, 3 fail (the 3 new). After: `# pass 19 # fail 0`.
- `v4.test.ts` + `s1.test.ts` together: `# tests 439 # pass 439 # fail 0`.
- `apps/api` unit (`npm test --workspace=apps/api -- src/lib/home.test.ts` runs the whole unit suite, the file arg is ignored): `# pass 1064 # fail 0`.
- `apps/web` unit incl. `queriesSchema.test.ts` (`tsx --test src/lib/*.test.ts` plus it): `# pass 335 # fail 0`.
- `25-home.spec.ts` (all): 6 passed. Same sales test against the old Overview source (with only `data-status` added): fails, `Expected: "2" Received: "0"`.
- `02-contract-flow.spec.ts -g "non-zero count"`: 1 passed.
- `npm run typecheck`: clean.
- Not run: full integration and e2e suites (by the brief).

## 4. Decisions the card didn't make
1. Shared function returns `{ contracts, owed }` so the queue can still look contracts up by id.
2. e2e reads the row count first, then expects the tile to have exactly that text (auto-retrying), and the fa page to show the same count in Persian digits mapped from it.
3. NR-5 test also asserts sales gets a number.

## 5. Where the plan, card or brief was wrong, vague or incomplete
1. `npm run test:integration -- <file>` does not filter: `test-integration.ts` hard-codes the glob `src/test/*.test.ts` and ignores arguments (my first call began the full suite; I killed it). Likewise `npm test --workspace=apps/api -- <file>` runs the whole unit suite. I ran files through an untracked copy of the runner with the glob replaced by argv (deleted before commit).
2. NR-3 can be seen failing on main: after the e2e reset, the old tile shows 0 while the box has 2 rows. The seed's `RC-2026-021` therefore does not (after the reset) supply a status-only WAITING_ON_ROOT count that matches.
3. A first j12 run showed all 20 tests failing, while a killed duplicate run was still alive on the same database; rerun clean gave 16/3. Not a code issue.

## 6. What I couldn't verify
- Which tile(s) keep the `02-contract-flow` sum non-zero: the test passes, but I did not print the tiles. The "Waiting on Root" tile is not required for it (the test has no reset, so other statuses' counts from its flow carry it); verify can print `.tile-count` texts.
- The live-desk check after deploy (founder's).
- No stop under Budget.

## 7. One thing that would have made this stage faster
A working file filter on `npm run test:integration` (and the unit script), as the card and note assume.
