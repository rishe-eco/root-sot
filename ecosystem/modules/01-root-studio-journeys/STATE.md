# STATE — Root Studio · customer journeys

*Newest block first. Written by `handoff`, and by `build-phase` when it launches or lands a lane.*

## 2026-10-21 · NR1 verified and deployed · lifecycle/stage-2f-needs-root-tile @ b90e64e · rishe-eco/root-app main @ 02e7f6e

*Completes the blocks below (8a launch NR1, 8b land NR1): NR1 is verified, merged and live. Its next step 1 (`/verify NR1`) is done. Change note 02 has no other stage.*

**What was done**
- `verify NR1` ran earlier in this root-sot branch. Its root-app commits: the runners now run only the files named (`a38c8c9`), the V4 Overview test resets (`085aa1a`), `expireMockupGrants` writes UTC (`d425139`, the one full-e2e failure, 136 of 137), and the stage record `docs/development/NR1.md` plus TK1's deploy run (`a94c339`).
- `main @ a94c339` was pushed on 2026-10-21 and deployed: `check` and `deploy` green. `02e7f6e` records the run's URL in `docs/development/NR1.md`.
- Its root-sot commits: the journeys column at 20/20 (`81b3b56`), the capture note (`49adbbe`), and open-work 0.10 (`b90e64e`, with the new owed rows below).
- This session wrote only this block; it did no other work.

**Next steps, in order**
1. Read the top block of `ecosystem/modules/01-root-studio-journeys/STATE.md` in root-sot (`lifecycle/stage-2f-needs-root-tile`). Root-app `main` is one commit ahead of origin (`02e7f6e`, docs only). A push to `main` deploys (`config.md` §7), so ask the founder before pushing it. Then do the live check in `team/open-work.md`: sign in on the live desk as sales, open Overview, and confirm the "Waiting on Root" tile equals the number of rows in the Needs Root box. Then merge `lifecycle/stage-2f-needs-root-tile` into root-sot's `main` if the founder says yes, and pick the next stage from `team/open-work.md`.

**Carry-overs**
- Owed rows in `team/open-work.md`: the desk scrolls sideways at 360 px (`desk.css`, below 720 px, not assigned), and `j9a`'s heap-bound flake under the full integration suite. Both point to `docs/development/NR1.md` in root-app.
- The runners' file filter is in the capture note `lifecycle/learnings/inbox/2026-10-20-verify-NR1.md`; `/learned` takes it.

**Questions for the founder**
- Push `02e7f6e` (root-app, docs only) to `main`, which deploys? Owed by: the next step.
- Merge `lifecycle/stage-2f-needs-root-tile` into root-sot's `main` and push? Owed by: the next step.

**Owed**
- The NR1 live check on the deployed desk (founder).

## 2026-10-20 · 8b land NR1 · lifecycle/stage-2f-needs-root-tile @ ade6e8d · rishe-eco/root-app main @ 1ddf5d0

*Replaces the lane row of the 8a launch NR1 block below. That block's next step is done.*

**What was done**
- The lane returned two commits on `nr1-needs-root-tile`: `8182e38` (the tests, seen failing first) and `5dac6fc` (the code). Both are authored by `markRice <mark2daynew@gmail.com>`, with a Sonnet co-author line. Its report is `briefs/NR1.report.md` (`b962a95`), with the measured size: +52 app lines, +62 test lines, 30.9 min, about 103k tokens. That is within size S.
- `main` hasn't moved since `1ddf5d0`, so nothing overlaps.

**For verify to decide**
- The lane's own calls (report part 4): the shared `loadNeedsRoot(user)` returns `{ contracts, owed }`; the e2e reads the row count first and then expects the tile to match; the NR-5 test also asserts that sales gets a number.
- The card's *Decided here* (`briefs/NR1.md`): NR-5's test lives in `j12.test.ts`, and `v4.test.ts` is unchanged; the e2e uses the existing reset with no new seed rows; NR-6 compares the Persian digits with the English number.
- A card check the lane didn't do: which tiles keep `02-contract-flow.spec.ts`'s "non-zero count" sum above zero. The test passed, but the tiles weren't printed.
- What the deploy runs: unchanged (no migration, no new variable; the API image rebuilds as on every push).
- Departure (report part 5.1): passing a file to `npm run test:integration` or to the API's `npm test` doesn't filter. Both run every file. root-app `CLAUDE.md`, `config.md` §3 and the note all assume they filter. The lane ran single files through an untracked copy of the runner, which it deleted. A fix belongs to the test tooling, or to `brief-common.md` for the next card.

**Lanes in flight**
| Stage | Branch | Slot | Worktree | Card | Status |
|---|---|---|---|---|---|
| NR1 (S) | `nr1-needs-root-tile` from `main @ 1ddf5d0` | A: `root_wt_a_test`, API 4201, web 4273 | `<checkout>/.claude/worktrees/nr1-needs-root-tile` | `briefs/NR1.md` | landed |

**Next steps, in order**
1. Read the top block of `ecosystem/modules/01-root-studio-journeys/STATE.md` in root-sot (`lifecycle/stage-2f-needs-root-tile`), then `changes/02-change-needs-root-tile.md`, `briefs/NR1.md` and `briefs/NR1.report.md` in the same folder. Run `/verify NR1` from the root-app checkout (Opus, high effort; it runs forked). It reviews `nr1-needs-root-tile` against `main @ 1ddf5d0`, decides the items under *For verify to decide*, and writes root-app `docs/development/NR1.md`. In the same root-app commit it adds the TK1 deploy run's URL (`https://github.com/rishe-eco/root-app/actions/runs/39472536519`) to `docs/development/TK1.md`. Before the founder is asked to push, run the full e2e suite (owed since `apps/web/e2e/helpers.ts` changed, L-36 *Revisit*).

**Carry-overs**
- A push to root-app's `main` deploys (`config.md` §7), so the push is the founder's yes to a deploy.
## 2026-10-20 · 8a launch NR1 · lifecycle/stage-2f-needs-root-tile @ ace74ff · rishe-eco/root-app main @ 1ddf5d0

*Adds to session D's block below (TK1). That block's next step, `/decision-record` for session D, already ran: L-36 records it.*

**What was done**
- Change note 02 (`changes/02-change-needs-root-tile.md`, `ace74ff`) is staged as one stage, NR1. Its card is `briefs/NR1.md` (`ed7dca5`). The code check at `main @ 1ddf5d0` agreed with the note. The card adds `queriesSchema.test.ts` to the targeted runs, and asks the lane to report whether the seed's `RC-2026-021` (status `WAITING_ON_ROOT`) owes Root anything after a reset.
- The fetch failed (no network), so the base is local `main @ 1ddf5d0`, which matched `origin/main` when last fetched.
- The lane runs on Sonnet in the background, in slot A.

**Lanes in flight**
| Stage | Branch | Slot | Worktree | Card | Status |
|---|---|---|---|---|---|
| NR1 (S) | `nr1-needs-root-tile` from `main @ 1ddf5d0` | A: `root_wt_a_test`, API 4201, web 4273 | `<checkout>/.claude/worktrees/nr1-needs-root-tile` | `briefs/NR1.md` | running |

**Next steps, in order**
1. Read the top block of `ecosystem/modules/01-root-studio-journeys/STATE.md` in root-sot (`lifecycle/stage-2f-needs-root-tile`), then run `/build-phase NR1 --land` from the root-app checkout (Opus, medium effort). It reads the lane's report from `<checkout>/.claude/worktrees/nr1-needs-root-tile/.tmp/NR1.report.md`, saves it as `briefs/NR1.report.md` and hands NR1 to `/verify NR1`.

**Carry-overs**
- A push to root-app's `main` deploys (`config.md` §7). The full e2e suite is owed before the next deploy (L-36 *Revisit*), and must run before the founder is asked to push.
- The TK1 deploy run (`https://github.com/rishe-eco/root-app/actions/runs/39472536519`, `DEPLOYED 1ddf5d0`) goes into root-app `docs/development/TK1.md` with the next root-app commit: `verify NR1`'s.

## 2026-10-20 · Rollout stage 2, session D: TK1 built, verified and deployed · lifecycle/stage-2d-journeys-change @ 46791ac · rishe-eco/root-app main @ 1ddf5d0

*Completes the blocks below (8a launch TK1, 8b land TK1): TK1 is verified, merged and live. Change note 01 has no other stage.*

**What was done**
- `verify TK1` found and fixed two defects on the lane's branch: a failed refetch wiped the ticket list, and one after a create invited a duplicate. It added a test for the close alone, and fixed the e2e helper's missed retry (`UND_ERR_SOCKET`), which was the cause of `25-home`'s red test. The record is `docs/development/TK1.md` in `rishe-eco/root-app`. Column 8 is 19/19 (`6ac395e`), with open-work rows (`da872cf`) and a capture note (`ccdb03d`).
- At the founder's word, Claude fast-forwarded root-app's `main` to `1ddf5d0` and pushed it. The `deploy` run succeeded and ended `DEPLOYED 1ddf5d0` (run 39472536519). The worktree and branch are removed, and the scratch logs and screenshots are in root-app's ignored `.tmp/TK1/`.
- `lifecycle/projects/root-app/config.md` is 0.4 and `brief-common.md` 0.2, as the founder accepted (`46791ac`). Before them: config 0.3 (`73a859f`) and the gate's `ecosystem/modules/` fix, 76 of 76 cases (`f16784f`).

**Next steps, in order**
1. Read the top block of `lifecycle/STATE.md`. Then run `/decision-record` for rollout stage 2, session D (Opus, at the founder's word): L-33's five calls stand (`background: false` kept after the founder asked what it does); the new module folder `ecosystem/modules/01-root-studio-journeys/`; the gate's fix for `ecosystem/`; config 0.3 and 0.4, brief-common 0.2; the full e2e suite skipped at the founder's word; and `verify` run as a fork, with its first real use. Then `/handoff` to `lifecycle/STATE.md`, then `/learned`.

**Carry-overs**
- Everything after the deploy waits on the founder: `team/open-work.md` has the live-site check of TK1 (*Past the verification ceiling*) and two owed rows. Wp-dashboards #1, #2, #3 and #4–#8 have no change note yet.
- `docs/development/TK1.md` doesn't hold the deploy run's URL, since adding it deploys again. Add it with the next root-app commit.
- The 180 px topbar scrolls sideways (not TK1's) and is unassigned.

**Questions for the founder**
- Should `lifecycle/stage-2a-skills`, `stage-2b-skills`, `stage-2e-verify-fix` and `stage-2d-journeys-change` be merged into root-sot's `main` and pushed? Owed by: the end of session D.

**Owed**
- The full e2e suite hasn't run since the shared helper changed. Owed by: the next root-app deploy.

## 2026-10-20 · 8b land TK1 · lifecycle/stage-2d-journeys-change @ 0f5fd57 · rishe-eco/root-app tk1-ticket-refresh @ 99738c2

*Replaces the lane row of the block below (8a launch TK1). Its next steps 2 and 3 are carried forward here.*

**What was done**
- The lane's report is saved as `briefs/TK1.report.md` (`0f5fd57`). One commit, `99738c2`, by markRice with the Sonnet 5.5 co-author line.
- Measured from `main @ 66c5698`: +27 −5 app (`apps/web/src/portal/Support.tsx`), +156 tests (`apps/web/e2e/27-support.spec.ts`, new), nothing moved. 26.8 min and 97,374 tokens, within size S. `main` hasn't moved since `66c5698`, so nothing overlaps.

**For verify to decide**
- **The lane's calls** (report part 4): `createTicket` waits for its refetch before the form closes, which `NewRequestModal.tsx` doesn't do. Every header click refetches, open or close. There's no shared hook, and `RequestDrawer.tsx` is untouched.
- **The card's Decided here:** e2e data comes from `resetTestDatabase()` plus staff calls through `apiSignIn(ADMIN)` and `gql`. The spec's number is 27. No dependency was added, and the API wasn't touched.
- **Card checks not done:**
  - only TK-1 and TK-2 were seen failing on the old code. TK-3, TK-4, TK-5 and the close-card test weren't;
  - Persian was checked by text only, with no screenshot and no width checks;
  - focus was dispatched as an event, not real browser focus.
- **`25-home.spec.ts` test 5** fails with "other side closed", on `main` code as well as the branch. The lane read it as this machine's API process. Not yet proved.
- **Departures and fixes to the files** (report part 5): `npm run e2e -- <file> -g` fails from the repo root (`cd apps/web && npx playwright test` works). `brief-common.md` assumes the Windows machine. `psql` needs `PGPASSWORD=root` here. Each is a proposal for `config.md` or `brief-common.md`, with the founder's yes.
- **The deploy:** web only. A push to `main` deploys through CI, which doesn't run e2e (`config.md` §7).

**Lanes in flight**

| Stage | Branch | Slot | Worktree | Card | Status |
|---|---|---|---|---|---|
| TK1 (S) | `tk1-ticket-refresh` from `main @ 66c5698` | A: `root_wt_a_test`, API 4201, web 4273 | `<checkout>/.claude/worktrees/tk1-ticket-refresh` | `briefs/TK1.md` | landed |

**Next steps, in order**
1. Read the top block of `ecosystem/modules/01-root-studio-journeys/STATE.md`, then `changes/01-change-ticket-refresh.md` and `briefs/TK1.report.md` in that folder. From the root-app checkout (`lifecycle/projects/root-app/config.md` §1), run `/verify TK1` (Opus, high, forked). It reviews `tk1-ticket-refresh` @ `99738c2` against the note, decides the items under *For verify to decide*, writes `docs/development/TK1.md` and column 8, and ends at "ready to fast-forward". A push to root-app's `main` deploys (`config.md` §7), so the push waits for the founder's yes. root-sot stays on `lifecycle/stage-2d-journeys-change`.
2. End rollout stage 2, session D with `/decision-record` (L-33's five calls, the module folder, the gate fix, `config.md` 0.3), then `/handoff` to `lifecycle/STATE.md`, then `/learned`.

**Questions for the founder**
- Should `lifecycle/stage-2a-skills`, `stage-2b-skills`, `stage-2e-verify-fix` and `stage-2d-journeys-change` be merged into root-sot's `main` and pushed? Owed by: the end of session D.
