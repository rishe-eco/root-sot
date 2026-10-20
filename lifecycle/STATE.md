# STATE — lifecycle

*Newest block first. Written by `handoff`.*

## 2026-10-21 · Rollout stage 2, session F: the second Change (NR1) · lifecycle/stage-2f-needs-root-tile @ ae8448b · rishe-eco/root-app main @ 02e7f6e

*Completes session D's next step 1 (a second Change note). Carries forward session D's carry-overs and questions, apart from the one on merging the lifecycle branches, which is answered below. The module's own state is in `ecosystem/modules/01-root-studio-journeys/STATE.md`.*

**What was done**
- At the founder's word, `lifecycle/stage-2a-skills`, `2b`, `2e` and `2d` were fast-forwarded into root-sot's `main` and pushed (`4637354`).
- Change note 02 (`ecosystem/modules/01-root-studio-journeys/changes/02-change-needs-root-tile.md`, wp-dashboards #2) was written by hand and staged as NR1. A Sonnet lane built it, `verify` reviewed it, and it is deployed: root-app `main @ a94c339`, `check` and `deploy` green. The journeys column is 20/20.
- L-37 records it (`2ebd3be`). `/learned` wrote two notes (`ae8448b`).
- Root-app `02e7f6e` (the deploy run's URL, docs only) is held back, local and unpushed, at the founder's word, so it rides with the next real root-app push.
- At the founder's word ("Merge after decision-record"), this branch is merged into root-sot's `main` and pushed after this block is committed.

**Next steps, in order**
1. Run `/learned --consolidate` in a session of its own (Opus, high effort). The inbox has 21 notes in 8 files, past the cap of 15 (`lifecycle/learnings/index.md`). Start from root-sot (`~/Desktop/Root/Root`, `main`). Present the batch to the founder item by item.
2. Rollout stage 3, the design side (`lifecycle/README.md` §8), starting with `spec`, whose `change` mode both Change notes so far had to do by hand. Read the top block of `lifecycle/STATE.md`, then `lifecycle/skills-plan.md` §2 `spec` and §0, `lifecycle/skills/spec/reference.md`, `lifecycle/templates/change-note.md` and `lifecycle/templates/required-headings.txt`, and the two hand-written notes in `ecosystem/modules/01-root-studio-journeys/changes/` as the worked examples. Build `spec` with `skill-creator` as `lifecycle/skills/spec/SKILL.md` (Opus, high effort; work in root-sot on a new branch from `main`), then `lifecycle/bin/install-skills`. Try `spec change` on real work: the journeys module's next owed item, wp-dashboards #1 (one login factor; decided) in `docs/development/wp-dashboards.md` in `rishe-eco/root-app`, then `/build-phase` and `/verify` from the root-app checkout. The other design-side skills (`ideate`, `research`, `personas`, `journeys`, `wireframes`, `eval-plan`, `build-plan`) follow in `skills-plan.md` order and are proved on the next new module.
3. At the end of stage 3, check usage against the baseline (`lifecycle/README.md` §8).

**Carry-overs**
- A push to root-app's `main` deploys (`config.md` §7). The full e2e suite ran at `verify NR1` (136 of 137, then fixed by `d425139`).
- The NR1 live check (sign in on the live desk as sales, open Overview, check the tile equals the Needs Root rows) and TK1's live check are rows in `team/open-work.md`, and wait on the founder.
- Owed rows in `team/open-work.md`: the desk's 360 px scroll, and `j9a`'s heap-bound flake under the full integration suite.
- Only the founder can run `decision-record`, `handoff`, `learned`, `verify`, `build-phase` and `lifecycle-status`. The first three set Sonnet.
- `skills-plan.md` §0 still says skills live in `root-sot/.claude/skills/`, which L-31 replaced. That file is the founder's to change.
- Session D's Tracker questions stay open: who corrects B-15's stale entry in `tracker/canon/04-roadmap/01-known-issues-and-debt.md` (line 27) and the grounding note in §5 of `tracker/canon/01-product/00-concepts-and-hierarchy.md`; whether Tracker's `config.md` §3 names `cd client && npx tsc --noEmit` in place of `npm run typecheck`; whether Tracker's review checklist drops "both colour schemes"; whether Tracker's `config.md` records Chrome with a scratch database as the Linux fallback for e2e.

**Questions for the founder**
- Push root-app's `02e7f6e` (docs only) now, which deploys, or let it ride with the next change? Owed by: the next root-app push.
- Is wp-dashboards #1 the right first real use of `spec change`, or should it be #3 or one of the scroll bugs? Owed by: step 2.

**Owed**
- Wp-dashboards #1, #3 and #4 to #8, and the desk and portal scroll bugs, have no change note. They wait for `spec change`.

## 2026-10-20 · Rollout stage 2, session D: the Change track's first run (TK1) · lifecycle/stage-2d-journeys-change @ 6646ac7 · rishe-eco/root-app main @ 1ddf5d0

*Completes session E's next step 1 (session D). Carries forward session E's carry-overs and questions, apart from the one on L-33's five calls, which L-36 closes. The module's own state is in `ecosystem/modules/01-root-studio-journeys/STATE.md`.*

**What was done**
- Change note 01 (TK1: the portal's Support page refreshes tickets) was written by hand, built by a Sonnet lane, reviewed by `verify` and deployed: root-app's `main` is `1ddf5d0`, and the `deploy` run ended `DEPLOYED 1ddf5d0`. The module folder `ecosystem/modules/01-root-studio-journeys/` is new, and `lifecycle/status.md` links to it (column 8 is 19/19).
- Method changes: the gate reads `ecosystem/modules/` as root-app's (`f16784f`, `gate-test` 76 of 76); `lifecycle/projects/root-app/config.md` 0.4 and `brief-common.md` 0.2 (`73a859f`, `46791ac`).
- L-36 records it, with L-33's five calls confirmed (`6646ac7`). `decision-record` and both handoffs ran on Opus or Sonnet as the founder directed.
- **Branches:** `lifecycle/stage-2d-journeys-change` is stacked on `lifecycle/stage-2e-verify-fix`, then `2b`, then `2a`. None is merged into `main` or pushed.

**Next steps, in order**
1. Read the top block of `lifecycle/STATE.md`, then L-36 in `lifecycle/decision-log.md` and `ecosystem/modules/01-root-studio-journeys/STATE.md`. Ask the founder the first question below. Then pick the next owed item with them: a second Change note for the journeys module (wp-dashboards #1, #2 or #3, in `docs/development/wp-dashboards.md` in `rishe-eco/root-app`), written by hand from `lifecycle/templates/change-note.md` until `spec change` exists (stage 3), then `/build-phase <stage>`, `--land` and `/verify <stage>`. Start the session from the root-app checkout. Model: Opus, medium effort for the card, high for verify. root-sot stays on `lifecycle/stage-2d-journeys-change` unless it has been merged, because the installed skills read their files from that checkout.

**Carry-overs**
- A push to root-app's `main` deploys (`config.md` §7). Run the full e2e suite first; it is owed since `apps/web/e2e/helpers.ts` changed (L-36 *Revisit*).
- Only the founder can run `decision-record`, `handoff`, `learned`, `verify`, `build-phase` and `lifecycle-status`. `/debug` reads the folder the session started in.
- `skills-plan.md` §0 still says skills live in `root-sot/.claude/skills/`, which L-31 replaced. That file is the founder's to change.
- IMNSTR's checkout isn't on the Linux machine. `skill-creator`'s eval loop wasn't run for session B's skills or the fix mode.

**Questions for the founder**
- Should `lifecycle/stage-2a-skills`, `stage-2b-skills`, `stage-2e-verify-fix` and `stage-2d-journeys-change` be merged into root-sot's `main` and pushed? Owed by: the next session's start.
- Who corrects B-15's stale entry at line 27 of `tracker/canon/04-roadmap/01-known-issues-and-debt.md`, and the grounding note in §5 of `tracker/canon/01-product/00-concepts-and-hierarchy.md`? Owed by: the next Tracker Fix.
- Should `lifecycle/projects/tracker/config.md` §3 name `cd client && npx tsc --noEmit` in place of `npm run typecheck`? Owed by: the next Tracker session.
- Tracker has no dark scheme: drop the "both colour schemes" item in `lifecycle/projects/tracker/review-checklist.md` §4 for Tracker, or make the missing scheme a known issue? Owed by: the next Tracker review.
- Should Tracker's `config.md` record Chrome with a scratch database as the Linux fallback for targeted e2e? Owed by: the next Tracker review that needs e2e.

**Owed**
- The live-site checks of B-15 (Tracker) and TK1 (root-app) are rows in `team/open-work.md`, and wait on the founder.
- The deploy run's URL goes into `docs/development/TK1.md` with the next root-app commit.

## 2026-10-20 · Rollout stage 2, session E: verify's fix mode, and B-15 verified · lifecycle/stage-2e-verify-fix @ 5068f79 · rishe-eco/tracker main @ 94d2e63

*Completes session C's next step 1 (B-15) and session B's. Carries forward session D, the carry-overs and the questions still open.*

**What was done**
- `verify --fix <id> <branch>` and its gate check, `gate <project> fix <id> <branch>`, as L-34 decided (`438ce2b`): `lifecycle/skills/verify/`, `lifecycle/bin/gate`, `lifecycle/skills/shared/build.sh`. `bin/gate-test` passes 75 of 75 cases, shellcheck is clean, and `bin/install-skills --check` is clean. Claude's calls inside the mode are in `lifecycle/skills/verify/reference.md` 0.3.
- The founder ran `/verify --fix B-15 fix/b-15-goal-group-status`. It returned "ready to fast-forward", with 0 fixes. The record is `docs/development/fix-B-15.md` in `rishe-eco/tracker`, with an open-work row (`4a05a0d`) and a capture note (`f48c6f4`). Tracker's `main` was fast-forwarded to `94d2e63` and pushed, and the fix branch was deleted, at the founder's word.
- L-35 records it all (`5068f79`). `decision-record` and `handoff` ran on Opus, at the founder's word.
- **Branches:** `lifecycle/stage-2e-verify-fix` is stacked on `lifecycle/stage-2b-skills`, which is stacked on `lifecycle/stage-2a-skills`. None of them is merged into `main` or pushed.

**Next steps, in order**
1. Read the top block of `lifecycle/STATE.md`, then L-33 and L-35 in `lifecycle/decision-log.md`. This is rollout stage 2, session D: the journeys build's owed items, on the Change track, in root-app (`lifecycle/projects/root-app/config.md` names its checkout and suites). Start the session from the root-app checkout. root-sot stays on `lifecycle/stage-2e-verify-fix` unless the founder has merged it, because the installed skills read their files from that checkout. `spec change` isn't built yet (stage 3), so write the change note and its Stages section by hand from `lifecycle/templates/change-note.md`, in the module folder that holds the journeys build. Then `/build-phase <stage>`, `/build-phase <stage> --land`, and `/verify <stage>`. Model: Opus, medium effort for the card, high for verify. Before the first `build-phase`, ask the founder whether L-33's five calls stand. End with `/decision-record`, `/handoff` and `/learned`.

**Carry-overs**
- `verify`'s injected context finds the code checkout through `config.md`, so it runs from any folder. `/debug`'s context reads the folder the session started in, so start a debugging session from the code checkout.
- `decision-record`, `handoff`, `learned`, `verify`, `build-phase` and `lifecycle-status` have `disable-model-invocation`: only the founder can run them.
- `skills-plan.md` §0 still says skills live in `root-sot/.claude/skills/`, which L-31 replaced. That file is the founder's to change.
- IMNSTR's checkout (`rishe-eco/i-monster`) isn't on the Linux machine.

**Questions for the founder**
- Should `lifecycle/stage-2a-skills`, `lifecycle/stage-2b-skills` and `lifecycle/stage-2e-verify-fix` be merged into `main` and pushed? Until they are, root-sot's checkout has to stay on `lifecycle/stage-2e-verify-fix`. Owed by: session D.
- Do the five calls listed in L-33 stand: the build-phase block replacing the handoff, `git worktree add` instead of the Agent tool's isolation, devices passed in the milestone argument, Change stages counted in column 8, and `background: false`? Owed by: session D's first `build-phase`.
- Who corrects B-15's stale entry, at line 27 of `tracker/canon/04-roadmap/01-known-issues-and-debt.md`, and the grounding note in §5 of `tracker/canon/01-product/00-concepts-and-hierarchy.md`? `verify` only flags it; `close-out` owns canon, but a Fix has no close-out. The fix record's *Flagged for close-out* has the wording. Owed by: the next Tracker Fix.
- Should `lifecycle/projects/tracker/config.md` §3 name `cd client && npx tsc --noEmit` in place of `npm run typecheck`, which fails until `app/routes.ts` exists? Owed by: the next Tracker session.
- Tracker has no dark scheme. Should the "both colour schemes" item in `lifecycle/projects/tracker/review-checklist.md` §4 be dropped for Tracker, or should the missing dark scheme become a known issue? Owed by: the next Tracker review.
- Should `config.md` record Chrome with a scratch database as the Linux fallback for targeted e2e (the capture note in `f48c6f4`)? Owed by: the next Tracker review that needs e2e.

**Owed**
- B-15 isn't live until the founder deploys Tracker. The live-site check is a row in `team/open-work.md`.
- `skill-creator`'s eval loop and description tuning weren't run for session B's skills or the fix mode (L-33).

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
