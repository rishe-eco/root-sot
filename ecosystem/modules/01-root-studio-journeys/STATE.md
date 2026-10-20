# STATE — Root Studio · customer journeys

*Newest block first. Written by `handoff`, and by `build-phase` when it launches or lands a lane.*

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
