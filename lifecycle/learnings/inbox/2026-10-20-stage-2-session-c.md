*Session: 2026-10-20 · lifecycle · rollout stage 2, session C (B-15 on the Fix track) · Opus 5.5*

## A session prompt can't hand Claude the founder-only skills

**Rule:** When a session prompt ends with `/decision-record`, `/handoff`, `/learned`, `/verify` or `/build-phase`, write them as steps the founder runs, and start the session on the model their frontmatter names, or say in the prompt that running them on the session's model is accepted.
**Event:** Session C's prompt said "Record the answer with `/decision-record`. End with `/handoff`, then `/learned`". The Skill tool refused `decision-record` (`disable-model-invocation`), and once the founder ran it and `handoff`, both stopped because the session was Opus and their frontmatter sets Sonnet.
**Cost:** three extra round trips with the founder ("proceed" twice); no rework.
**Scope:** method · skills `decision-record`, `handoff`, `learned`
**Destination:** `skills-plan.md` §0 (how session prompts name skills), through `revise`
**Urgent:** no

## `/debug` reads the session's starting folder, not the code checkout

**Rule:** Start a Fix or build session from the code checkout, or make `debug`'s `context.sh` resolve the project from `config.md` when the session starts in root-sot.
**Event:** `/debug Goal Group status always "Backlog" (B-15)` ran from `~/Desktop/Root/Root` and injected "Project: root-sot (the method itself; no suites)" while the work was in `~/Desktop/Root/tracker`; the suites were taken from `lifecycle/projects/tracker/config.md` §3 by hand.
**Cost:** small: the injected suites and runners were useless for the run
**Scope:** skill `debug`
**Destination:** `lifecycle/skills/debug/SKILL.md` and `context.sh`
**Urgent:** no

## Check every caller before trusting a known-issues entry

**Rule:** Before writing the reproduction for a Fix, grep every caller of the function the entry names; the entry may describe a path that was already fixed.
**Event:** B-15 said `getGoalStatus` made groups "Backlog" on the list; the code already returned "GoalGroup" there, and the live defect was `ManageGoal.tsx`'s status ternary showing "Ignored". Found by grepping `getGoalStatus`'s three callers.
**Cost:** none here; a test of the list alone would have passed and closed the issue wrongly
**Scope:** skill `debug` · project tracker
**Destination:** `lifecycle/skills/debug/SKILL.md` (rule 1)
**Urgent:** no
