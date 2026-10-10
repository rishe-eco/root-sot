# 07b project config — 2026-10-10

## Session
Opus 5.5 (`claude-opus-5-5`); the founder gave effort medium. Opening prompt: "in root-sot on branch lifecycle-trial/imnstr, pull first, then read lifecycle/trial-run/README.md. You are on step 7b. opus, medium". The checkout was already on the branch at `015e2b9`, and the pull found nothing new.

## Read
In the brief's order:
- `lifecycle/trial-run/README.md`, whole.
- `lifecycle/README.md` §0–§4.
- `lifecycle/skills-plan.md` §0 (shared mechanics, including the per-project config table) and `handoff` (for the block format).
- `STATE.md`, top block (step 7).

Then the inputs:
- `07-build-plan.md`: the header, §0 (all four parts), §1, §3, §4, §5 B1, B2 and B4a, §6–§10. Not B3 or B5–B9: their traps are stage-specific and belong in their cards, not the project config.
- `lifecycle/retros/2026-10-journeys-build.md`, whole (~2.1k words). Its §4 "what worked" and §5 changes set what `brief-common.md` must add to the journeys one.

**Outside the read order:**
- `skills-plan.md` `build-phase` and `verify`, and §5 (what gets built first). 7b has no skill section of its own. Its row says "contents as `skills-plan.md` §0 and `build-phase` list them", but `verify`'s injected inputs and steps decide what `review-checklist.md` and `config.md` must hold.
- `lifecycle/README.md` §5–§7: the lane budget (rule 5), no debugging through e2e (rule 6) and the fixed clock (rule 8). `brief-common.md` carries all three.
- **`~/.claude/projects/E---root/briefs/brief-common.md`**, the recovered journeys brief that `skills-plan.md` §0 names as the source for root-app. It isn't in git (retro §6), so I found it by searching `~/.claude`. Without it, the brief would have been written from the retro's one-paragraph description.
- My memory files `root-app-dev-machine` and `imnstr-build`: the build machine's environment (cmd.exe, Edge, background `cd`, `git add -A`).
- `02-spec.md` §4.3 (authentication). Plan §9.1 says "the review checklist carries §4.3 line by line".
- `04b-design/README.md`, headings only, to cite the design system correctly in the checklist's UI section.
- `team/open-work.md`, the top only, to check whose queue it is: Root's.
- `lifecycle/status.md`, as the gate.
- `log/07-build-plan.md`, the first 30 lines and the Cost section, for the log's register.

## Gate
- The build plan exists, at 0.1, with §0–§10 and a changelog. `status.md` marks column 7 `done`, and nothing is `STALE`.
- The retro exists at 0.4.
- "Anything the founder supplies": the org spelling, asked (below).
- The code repo doesn't exist (P0-1). That doesn't block 7b, whose outputs live in `root-sot`, but it means every claim about scripts, variable names and paths in the code repo is planned, not as-built.

**Result:** pass.

## Did
There's no skill for 7b; it is stage-1 foundation (`skills-plan.md` §5). The steps were:
1. Read the build plan for everything the three files need: §0.2 and §0.3 (must not break, house rules), §3 (sizes, parallel lanes, milestones), §8 (done means, the ceiling), §7 and B2 (deploy), and B1 (the harness, which fixes the suite commands).
2. Found and read the recovered journeys `brief-common.md`, and generalised it. I kept its structure: role, read order with "the code wins on what the code is", environment, git, style, the report. I swapped root-app's facts for IMNSTR's, and added the parts `build-phase` lists as new: the budget and stop rules, the debug rules, "targeted only", and item 7 of the report.
3. Asked the founder the one question that changes a file: the org.
4. Wrote `review-checklist.md` as tick-boxes in eight sections: §0.2; §0.3; every stage (scope, defects, dependencies, routes, schema, the fixed clock); auth (spec §4.3 line by line, plus B4a's traps); UI (the 4b design system, not Root's brand); deploy and co-tenancy; done means; the ceiling, as a table.
5. Wrote `config.md`: paths, environment, suites, lane slots, stages, the milestone script, deploy, models.
6. `STATE.md` block, this log, commit and push.

Not done: the status cell, since 7b has no column (brief §3).

## Output
- `lifecycle/projects/imnstr/brief-common.md` 0.1 (~1,350 words).
- `lifecycle/projects/imnstr/review-checklist.md` 0.1.
- `lifecycle/projects/imnstr/config.md` 0.1.
- `imnstr/modules/01-website/STATE.md`: the 7b block.
- This log.
- Commit: see `git log` for "IMNSTR trial step 07b".

## Spec gaps
1. **7b has no skill section, and its row points at two places that list only some of what it needs.** `skills-plan.md` §0's table gives one line per file. `build-phase` lists what `brief-common.md` must contain. Nothing says what `review-checklist.md` or `config.md` must contain beyond that line: I derived both from what `verify` injects and does (steps 5–9), and the table's "Source for root-app" column. *Proposal:* a short "Project config" section in `skills-plan.md` listing each file's required contents, which also becomes its template.
2. **The source `skills-plan.md` names for `brief-common.md` isn't in git.** "The recovered journeys `brief-common.md`" lives only in `~/.claude/projects/E---root/briefs/` on this machine, which is retro finding 6 repeating itself. A session on another machine couldn't do this step as specified. *Proposal:* commit a cleaned copy under `lifecycle/retros/` or as the template for `brief-common.md`.
3. **`team/open-work.md` assumes every project is Root's.** The method sends owed items there (`README.md` §4, `verify` step 7), but it is Root's queue, and IMNSTR is outside Root. I sent IMNSTR's owed items to `root-sot/imnstr/open-work.md` and named it in `config.md`. *Proposal:* `config.md` names the open-work file per project, and `verify` reads it from there, as it already does for the state-of-the-build file.
4. **"The project's state-of-the-build file" has no IMNSTR equivalent.** IMNSTR has only the development README's stage list. `config.md` says "none separate". *Proposal:* the skill accepts "none" in config.
5. **Project config written before the code exists.** `config.md` is meant to come from "the development README; the build-machine memory", which assumes a repo. For a new project, suite commands and variable names are B1's to decide, so 7b writes them as planned, and B1's stage record can overrule them. That creates a loop: B1's card is drafted from `config.md`, and `config.md` is corrected after B1. *Proposal:* for a project without code, `verify` of the first stage updates `config.md` as one of its steps (it would need writer rights on it, which `README.md` §4 gives only to the founder).
6. **Who writes project configs.** `README.md` §4 says the founder, "through `revise` on the method itself". The trial lets 7b write them as a foundation stub, which works, but after the trial nothing does: no skill creates a project's config. *Proposal:* a `project-config` mode of `build-plan`, or its own small skill, run once per project, with founder acceptance.
7. **No lane-slot convention.** The method speaks of "ports" and "test database" per lane, shaped by root-app (Postgres databases, an API port and a web port). IMNSTR has one port and a file. I wrote slots A and B as a table. *Proposal:* the config template has a lane-slot table whatever the stack.

## Template sample
`brief-common.md`: Your role · Read first, in this order · Environment · Git · Style · Budget and stopping · Debugging · Tests · Your report · Changelog. **Required:** Read first, Environment, Git, Budget and stopping, Debugging, Your report (with the seven numbered parts).

`review-checklist.md`: How to use it · 1 What must not break · 2 House rules · 3 Every stage · 4 Auth and sessions · 5 UI stages · 6 Deploy and the shared VPS · 7 Done means · 8 The verification ceiling · Changelog. **Required:** What must not break, House rules, Done means, The verification ceiling. The rest are project-specific.

`config.md`: 1 Paths · 2 Environment · 3 Suites · 4 Lane resources · 5 Stages · 6 Milestones · 7 Deploy · 8 Models · Changelog. **Required:** Paths (with the stage-record, development-README, state-of-the-build and open-work rows), Suites, Lane resources, Milestones (with the script).

## Missing foundation
- `lifecycle/projects/` didn't exist. Created by this step, as the row allows.
- No template for any of the three files; I used the journeys `brief-common.md` and the `verify` steps.
- The recovered `brief-common.md` isn't committed (gap 2).
- The code repo, so no as-built facts (gap 5).

## Founder Q&A
- **Q:** The plan reads your "risheh-eco" as the existing `rishe-eco`. Which org is right? **A:** `rishe-eco`.

## Skill shape
- **Opus · medium was right.** The work is transcription and selection from the plan, with one judgement call per file. Nothing needed high.
- **Not forked**, and asks the founder.
- **Injected at invocation:** the plan's §0.2, §0.3, §3, §7 and §8 by heading; the retro's §4 "what worked" paragraph and §5; the machine's environment notes; `git ls-remote` for the code repo, if it exists.
- **Reference file:** the three templates, with the journeys `brief-common.md` as the worked example for the brief, and a list of which plan sections feed which file.
- **Most of `review-checklist.md` is a copy of plan §0.2, §0.3 and §8.** Copies drift. A skill could inject those sections instead and keep only the project-specific parts (auth, deploy, the ceiling) in the checklist. Against that, `verify` reads the checklist and not the plan's §0, so the copy saves a review a read.

## Lessons
1. **Rule:** a method file that names a source must name it by a committed path. **Event:** `skills-plan.md` §0 names "the recovered journeys `brief-common.md`" as a source; it existed only in `~/.claude` on this machine, and finding it cost a search. On another machine, this step would have run without it. **Scope:** `skills-plan.md`, templates. **Destination:** commit the file, with machine paths removed, as `lifecycle/templates/brief-common.example.md`. urgent: no.
2. **Rule:** project config for a project with no code is planned, and the first stage's verify confirms it. **Event:** every suite command and variable in `config.md` is a name B1 hasn't chosen yet; B1's card will have to copy them, and the lane may pick others. **Scope:** `build-phase` (B1's card), `verify` (first stage). **Destination:** `skills-plan.md` `verify`, a step "first stage: reconcile `config.md`". urgent: yes, for 8a B1's card: tell the lane to use `PORT` and `DB_PATH`.

## Cost
*Founder fills in after the session.*

## Next
- **Founder:** P0-1, create `rishe-eco/imnstr` (public, empty, with `main`). P0-2 to P0-5 can run alongside.
- **8a B1** (Opus · medium) once the repo exists. Slot A (port `4110`), branch `b1-foundation`. The card must:
  - name `PORT` and `DB_PATH`;
  - tell the lane to gitignore `.claude/worktrees/` and `.tmp/`;
  - give it `CLAUDE.md`'s contents: house rules 1–10 from plan §0.3, the commands from config §3, and the environment from config §2. B1 is the only lane that can't read `CLAUDE.md` first, because it writes it.
- The lane is launched with `isolation: "worktree"` from `E:\_root\imnstr`. That needs the repo cloned there first, which the 8a session does after P0-1.
