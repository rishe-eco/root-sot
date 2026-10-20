# STATE — Root Studio · customer journeys

*Newest block first. Written by `handoff`, and by `build-phase` when it launches or lands a lane.*

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

## 2026-10-20 · 8a launch TK1 · lifecycle/stage-2d-journeys-change @ dadb045 · rishe-eco/root-app main @ 66c5698

*The first block in this file. It adds to the top block of `lifecycle/STATE.md` (rollout stage 2, session E), whose next step 1 this session is carrying out.*

**What was done**
- Change note 01, written by hand (`spec change` is stage 3): `changes/01-change-ticket-refresh.md`, one stage, TK1, which is wp-dashboards #9 (`e01f875`). The founder chose #9 alone, and this new module folder. `lifecycle/status.md`'s journeys row now links here.
- Before it: root-app's `config.md` went to 0.3, at the founder's word (`73a859f`). `bin/gate` now reads `ecosystem/modules/` as root-app's, and `gate-test` passes 76 of 76 (`f16784f`).
- The card is `briefs/TK1.md`, 613 words (`dadb045`). Its code check agreed with the note.
- The founder, asked about L-33's five calls: kept `background: false` after it was explained (Claude Code reads it from v2.1.218), and didn't object to the other four.

**Lanes in flight**

| Stage | Branch | Slot | Worktree | Card | Status |
|---|---|---|---|---|---|
| TK1 (S) | `tk1-ticket-refresh` from `main @ 66c5698` | A: `root_wt_a_test`, API 4201, web 4273 | `<checkout>/.claude/worktrees/tk1-ticket-refresh` | `briefs/TK1.md` | running |

**Next steps, in order**
1. Read the top block of `ecosystem/modules/01-root-studio-journeys/STATE.md`. Then, from the root-app checkout (`lifecycle/projects/root-app/config.md` §1), run `/build-phase TK1 --land` (Opus, medium). It reads the lane's report from `.tmp/TK1.report.md` in the TK1 worktree, measures the branch against `main @ 66c5698`, saves the report as `briefs/TK1.report.md`, and writes the hand-off block for verify. root-sot stays on `lifecycle/stage-2d-journeys-change`.
2. `/verify TK1` (Opus, high, forked). It ends at "ready to fast-forward". A push to root-app's `main` deploys (`config.md` §7), so the push waits for the founder's yes.
3. End rollout stage 2, session D with `/decision-record` (L-33's five calls, the module folder, the gate fix, `config.md` 0.3), then `/handoff` to `lifecycle/STATE.md`, then `/learned`.

**Questions for the founder**
- Should `lifecycle/stage-2a-skills`, `stage-2b-skills`, `stage-2e-verify-fix` and `stage-2d-journeys-change` be merged into root-sot's `main` and pushed? Owed by: the end of session D.
