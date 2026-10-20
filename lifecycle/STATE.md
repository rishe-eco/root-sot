# STATE — lifecycle

*Newest block first. Written by `handoff`.*

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
