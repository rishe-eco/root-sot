*Session: 2026-11-20 · tracker/modules/05-session-rhythm · verify --milestone MS2, main-session items · Opus 5.5*

## A milestone after the last stage has no stage to carry its lane work, so an unattended run stops there
**Rule:** When the last milestone of a build plan finds defects only a lane can fix, there is no later stage card to put them on, and adding one needs `revise` or `build-plan`, which `bin/drive` may not run; the plan could name a standing fix slot after its last stage so the run can go on to it.
**Event:** MS1's red e2e rode on SR6's card (calls row 64) and the run went on. MS2's three controls under 44 px came after SR8, the last stage, so the Drive line had to be `stop` (calls rows 95, 98).
**Cost:** the overnight run ended at MS2 instead of fixing three small CSS defects; the founder's morning now starts with a `revise`.
**Scope:** skill `build-plan` (the stage list) · `lifecycle/unattended.md` rule 8
**Destination:** `lifecycle/skills-plan.md` §3 `build-plan` (an optional fix slot after the last stage, drawn only if a milestone needs it; founder's yes)
**Urgent:** no
