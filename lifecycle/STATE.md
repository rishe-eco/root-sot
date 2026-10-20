# STATE — lifecycle

*Newest block first. Written by `handoff`.*

## 2026-10-20 · Rollout stage 2, session C: B-15 on the Fix track · lifecycle/stage-2b-skills @ 92a46bb · rishe-eco/tracker fix/b-15-goal-group-status @ 2143e39

*Partly completes session B's next step 1 (B-15): fixed, not verified. Carries forward its next step 2 (session D), its carry-overs and its questions.*

**What was done**
- `/debug` on B-15 in the Tracker checkout, on the new branch `fix/b-15-goal-group-status` from `main` @ `e90ceda`. The cause: a goal group's manage page always showed a status badge, and its status (`"GoalGroup"`) fell through to the "Ignored" label. The goals list was already right before the method started. The fix is `2143e39` (`client/app/components/goals/GoalPreview.tsx`, `ManageGoal.tsx`), with a test that failed first (`client/app/test/ManageGoalStatus.test.tsx`). 3 files and 21 tests pass, `tsc` is clean, and both i18n checks pass. The branch is not pushed and has no upstream.
- The founder chose a fix mode for `verify`, recorded as L-34 in `lifecycle/decision-log.md` (`92a46bb`).
- `decision-record` and `handoff` ran on Opus, at the founder's word, though their frontmatter sets Sonnet.

**Next steps, in order**
1. Read the top block of `lifecycle/STATE.md`, then L-34 and L-33 in `lifecycle/decision-log.md`. This is rollout stage 2, session E: build `verify`'s fix mode, then use it on B-15. Model: Opus, high effort. Work in root-sot on `lifecycle/stage-2b-skills`, or on a branch stacked on it. Add `verify --fix <id> <branch>` to `lifecycle/skills/verify/` (`SKILL.md`, `context.sh`) and its gate check to `lifecycle/bin/gate`, as L-34 says. The fix mode reads the known-issues entry as the card and the fix commit's message as the report. Its gate checks that the branch has a reproducing test. It writes `docs/development/fix-<id>.md`, and no column 8. Add cases to `lifecycle/bin/gate-test` and run it, then shellcheck and `bin/install-skills --check`. Then the founder runs `/verify --fix B-15 fix/b-15-goal-group-status` on the Tracker checkout (`~/Desktop/Root/tracker`, per `lifecycle/projects/tracker/config.md`). End with `/decision-record`, `/handoff` and `/learned`.
2. Rollout stage 2, session D: the journeys build's owed items, on the Change track, in root-app (`lifecycle/projects/root-app/config.md`). `spec change` isn't built yet (stage 3), so the session writes the change note and its Stages section by hand from `lifecycle/templates/change-note.md`. Then `/build-phase <stage>`, `/build-phase <stage> --land`, and `/verify <stage>`. Opus: medium for the card, high for verify.

**Carry-overs**
- B-15's entry in `tracker/canon/04-roadmap/01-known-issues-and-debt.md` is stale: it describes "Backlog" on the list, and the defect was "Ignored" on the manage page. The commit message of `2143e39` holds the cause. Who corrects the entry is open (L-34 *Revisit*).
- `/debug`'s injected context reads the folder the session started in. Started from root-sot, it reported "root-sot, no suites". Start a code session from the code checkout.
- `decision-record`, `handoff`, `learned`, `verify`, `build-phase` and `lifecycle-status` have `disable-model-invocation`: only the founder can run them.
- `skills-plan.md` §0 still says skills live in `root-sot/.claude/skills/`, which L-31 replaced. That file is the founder's to change.
- `verify` asks for this machine's code checkout through `config.md`. IMNSTR's checkout (`rishe-eco/i-monster`) isn't on the Linux machine.

**Questions for the founder**
- `lifecycle/projects/tracker/config.md` §3 lists `cd client && npm run typecheck`, but it fails on Tracker's `main`: `react-router typegen` wants `app/routes.ts`, which doesn't exist. `npx tsc --noEmit` works. Should §3 name `npx tsc --noEmit` until the route config exists? Owed by: session E's verify of B-15.
- Should `lifecycle/stage-2a-skills` and `lifecycle/stage-2b-skills` be merged into `main` and pushed? Until they are, root-sot's checkout has to stay on `lifecycle/stage-2b-skills`, because the installed skills read their files from it. Owed by: session E.
- Do the five calls listed in L-33 stand: the build-phase block replacing the handoff, `git worktree add` instead of the Agent tool's isolation, devices passed in the milestone argument, Change stages counted in column 8, and `background: false`? Owed by: session D's first `build-phase`.

**Owed**
- B-15 is unverified and unpushed until the fix mode exists.
- `skill-creator`'s eval loop and description tuning weren't run for session B's skills (L-33).

## 2026-10-20 · Rollout stage 2, session B: build-phase, verify, debug · lifecycle/stage-2b-skills @ 155a80a

*The first block in this file. Session A (`lifecycle/stage-2a-skills`, `601bf20`–`8cb190d`) left none; L-32 reconstructs it. This block was written by the session in `handoff`'s format, not by `/handoff`.*

**What was done**
- Stage 2's last three skills: `lifecycle/skills/build-phase/`, `verify/` and `debug/`, each a `SKILL.md` and a `context.sh`, plus `lifecycle/skills/shared/build.sh`, which they all source (`6b4c839`–`9ba7f50`). Seeds placed: each `reference.md` is 0.2.
- `bin/gate`'s call path for installed skills is fixed (`3e9ecf4`). `bin/gate-test` passes 53 of 53 cases, and shellcheck is clean.
- `bin/install-skills` was rerun: all seven skills are installed, and `--check` is clean.
- Decision log L-32 (session A, reconstructed) and L-33 (this session), which lists the calls the founder hasn't reviewed.
- **Branches:** this branch is stacked on `lifecycle/stage-2a-skills`. Neither is merged into `main` or pushed.

**Next steps, in order**
1. Read the top block of `lifecycle/STATE.md`, then L-33 in `lifecycle/decision-log.md`, and B-15 in `tracker/canon/04-roadmap/01-known-issues-and-debt.md`. This is rollout stage 2, session C: the first real use of the build skills, on the Fix track (`lifecycle/README.md` §1: debug → verify → decision record). Model: Opus, high effort. Work in the Tracker checkout that `lifecycle/projects/tracker/config.md` names for this machine, on a new branch `fix/b-15-goal-group-status` from a freshly fetched `main`. root-sot stays on `lifecycle/stage-2b-skills` unless the founder has merged it, because the installed skills read their files from that checkout. Run `/debug Goal Group status always "Backlog" (B-15)`, starting with the smallest test that reproduces it, and fix it. Before verifying, ask the founder what `verify` reads for a Fix: a Fix has no stage, card or lane report, so `verify`'s gate can't pass one (L-33 *Revisit*). Record the answer with `/decision-record`. End with `/handoff`, then `/learned`.
2. Rollout stage 2, session D: the journeys build's owed items, on the Change track, in root-app (`lifecycle/projects/root-app/config.md`). `spec change` isn't built yet (stage 3), so the session writes the change note and its Stages section by hand from `lifecycle/templates/change-note.md`. Then `/build-phase <stage>`, `/build-phase <stage> --land`, and `/verify <stage>`. Opus: medium for the card, high for verify.

**Carry-overs**
- `skills-plan.md` §0 still says skills live in `root-sot/.claude/skills/`, which L-31 replaced. That file is the founder's to change.
- `verify` asks for this machine's code checkout through `config.md`. IMNSTR's checkout (`rishe-eco/i-monster`) isn't on the Linux machine.

**Questions for the founder**
- Should `lifecycle/stage-2a-skills` and `lifecycle/stage-2b-skills` be merged into `main` and pushed? Until they are, root-sot's checkout has to stay on `lifecycle/stage-2b-skills`, because the installed skills read their files from it. On another branch, they report "ROOT-SOT NOT FOUND". Owed by: session C.
- Do the five calls listed in L-33 stand: the build-phase block replacing the handoff, `git worktree add` instead of the Agent tool's isolation, devices passed in the milestone argument, Change stages counted in column 8, and `background: false`? Owed by: session D's first `build-phase`.

**Owed**
- `skill-creator`'s eval loop and description tuning weren't run. Each skill's injected context was rendered on real modules instead (L-33).
