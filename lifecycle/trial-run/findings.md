# Trial findings: what the IMNSTR run says about the method

*Step 10c of the trial, acting as `revise` on the method. It covers every* Spec gaps *and* Missing foundation *item from the run's 69 session logs and 3 archived logs, plus 10a's accepted lessons and `founder-notes.md`. Items are grouped by the skill or file they change, each with a drafted edit. Nothing here is applied. The founder decides each item, and accepted edits are applied in a later session.*

**Version 0.2 · Status: accepted by the founder, on Claude's judgement; to be applied · 2026-10-19 · Owner: _root**

---

## Summary

- **Input.** 72 logs (69 in `log/`, 3 archived): 396 *Spec gaps* items, 5 of them pass 3 repeating `01-research`, and 143 *Missing foundation* lines. Also 10a's 36 accepted items, its 18 holds and 8 product notes, and the two founder notes. §13 maps every logged item to a finding.
- **Output.** 169 findings in 26 groups, one group per skill or method file, plus an 18-row foundation list (§10). The trial brief's own 5 findings are kept apart in §9, since they don't change the method.
- **The largest gap is foundation that was never built.** 32 logs gated by hand because `bin/gate` doesn't exist, and 22 had no template. Many findings below are really the contents of a template or a reference file, so stage 1 of the rollout should be built from §10 and the template lines here.
- **Four skill specs are one-liners or close to it,** and their logs had to invent the steps: `wireframes`, `eval-plan`, `personas`, and `journeys` in `new` mode. `revise` has no step for asking. Those invented steps worked, and they are the drafts below.
- **Five phases the run needed aren't in the method:** the design step (4b, 05e), project config (7b), a Change during a build (08e, 09b, 08f), touch-up or update modes of done phases (06b, 05d, 10b3, 10b4), and launch with evaluation after close-out.
- **Scope grew through founder answers.** The spec went from 19 acceptance criteria at 0.1 to 48 at 0.4, all on one day. 10a accepted three mechanisms, now RV-3 and SP-10. §12 answers the founder notes.

## How to read it

- **IDs** use a group prefix and a number (`RV-2`). Prefixes: `M` method README, `S0` shared mechanics, `ST`/`HO`/`DR`/`LE` the every-session skills, `ID`/`RE`/`PE`/`SP`/`JO`/`WF`/`DS`/`EV`/`BP`/`PC` the design side, `BF`/`BL`/`DB`/`VE`/`VM` the build, `UX`/`RI`/`DE` reviews, `RV`/`CO` closing the loop, `TR` the trial brief, and `F` foundation.
- **Seen** cites log items as `log:n`: the log's file name without `.md`, and the item's position in its *Spec gaps* list. `log:MF` is its *Missing foundation* section. `L1`–`L33`, `Z-a`–`Z-c` and `H:<note>` are 10a's integrate, scope and hold items (`log/10a-consolidate-proposal.md`).
- **Grades.** What the logs report is *evidence*: an event in a logged session. Every **Edit** is a *proposal*. Where a finding is already applied somewhere, it says where (*as-built*).
- **Destinations** are method files (`README.md`, `skills-plan.md`), skill reference files and templates that don't exist yet, project config, or the trial brief. A reference file that doesn't exist yet is named as `<skill>` reference.

---

## 1. What the run shows

1. **The method's mechanics held where they were specified.** Ten planned stages and two unplanned ones were built by Sonnet lanes, reviewed by Opus in fresh sessions and deployed in 8 days. No review sent a stage back to its lane (`09-close-out.md` §4). The gaps are at the edges: before the build (design phases with no steps) and after it (deploy, launch, evaluation, catching up the canon).
2. **The founder conversation is where scope, rework and round trips came from.** Answers that added requirements (bilingual, analytics), answers that were questions, explanations above a question box, and facts asked late each cost a session or a round. S0-5 gathers the rules.
3. **Cards ran over their limit at 10 of 12 launches,** because plans left decisions open and carry-overs weren't moved into `brief-common.md` (BF-7, BF-11, LE-2).
4. **Checks against the code beat checks against documents.** The costliest misses were claims carried from an earlier phase: plan paths, "B6 reuses this", a placeholder's semantics, tests that pinned a later stage's absence. These were among 10a's strongest clusters (L16, L17), here BF-6, BF-8 and VE-12.
5. **`status.md` can't show the states the run reached:** a closed module with its evaluation owed, a milestone with green suites and by-hand checks owed, a Change's stages, a design pass that's owed, a scoped `done` (M-6).
6. **One session per phase held,** except where the founder chose otherwise: 8a with 8b, PL1 with CS1, and 08f's same-session round. Those exceptions point at two missing shapes: launch and land in one session (BF-2), and a small Change (M-2).

---

## 2. Method: `README.md`

**M-1 · Where a new project's module folder goes.** *Seen:* `00-intake:2`. **Edit** (§3): "A project outside Root's areas keeps its modules in `<project>/modules/NN-slug/` in `root-sot`, and `status.md` links to it."

**M-2 · Changes that arrive during a build, and small Changes.** *Seen:* `08e-ci-deploy-change:1`, `09b-polish-change:1`, `08f-CS1-change:1`. **Edit** (§1): add two rows to the tracks table:
- "*Change during a build:* from the founder or from accepted review findings. `spec change` writes a note against the spec and the build's state (SP-6), then 8a–8c run against it. It doesn't stop the build."
- "*Small Change* (size S, one stage, no schema change): note, build, verify and deploy in one session, with the same note and stage record. The founder chooses it, and the log says so."

**M-3 · Phases the run needed that the table lacks.** *Seen:* `04b-design:1`, `04b-design-import:1`, `05e-design-import:5`, `07b-project-config:6`, `10b-close-out:4`, `06-eval-plan:2`. **Edit** (§2): add
- **4b Design** (UI modules): the founder in a design tool, then an import session. Its gate is wireframes. Output `04b-design/`. It has no status column and shares column 4 (DS-1).
- **7b Project config**, run once per project, before the first build plan for a project with none (PC-5).
- **Launch** as an event, not a phase: the first real use in production. `close-out` records its date, or "not yet", and the eval plan's later checks count from it (CO-2).

**M-4 · Gates the run had to improvise.** *Seen:* `05-ux-review:2`, `03b-journeys:3`, `04-wireframes:6`, `07-build-plan:2`, `09-live-review:6`, `08d-MS4-milestone:3`, `10b2-revise-spec:3`, `10b-close-out:1`. **Edit** (§2, gate column):
- Phase 5: "the latest design (4b where it exists, else wireframes), journeys".
- Phase 7: "UX findings, journeys' *Suggested*, the design's *Beyond the spec* and wireframes' *Calls made here*: each accepted, refused or carried (L9)".
- Phase 9: "UI stages verified. Open by-hand device checks don't block it, and are listed under *Not checked*."
- Phase 10: "…and no change note defers a spec `revise`. The founder may override with a reason, recorded in the close-out's header."

**M-5 · Who writes what, after the trial.** *Seen:* `07b-project-config:3`, `07b-project-config:6`, `08c-B1-verify:1`, `08c-B1-verify:8`, `10b2-revise-spec:1`, `10b2-revise-spec:2`, `10b2-revise-spec:MF`. **Edit** (§4):
- `open-work` becomes "the project's open-work file, named in `config.md`" (for Root, `team/open-work.md`).
- Project configs: "`project-config` creates them (PC-5). Afterwards, the founder edits them, or `verify` does with the founder's yes, logged in the stage record".
- The build plan: "`build-plan` writes it. Afterwards, `verify` writes correction-only changelog lines with the founder's yes. A change to scope goes through `revise`."
- `revise` may strike open-work rows it settles, citing its change note (RV-11).
- Keep §4 as a table with one file pattern per row, so a skill can grep its own rights (10b2's *Missing foundation*).

**M-6 · `status.md` states.** *Seen:* `00-intake:7`, `04b-design:6`, `04c-revise-spec:3`, `08a-B1-launch:7`, `08a-CD1-launch:2`, `08e-ci-deploy-change:10`, `08c-CD1-verify:5`, `08d-MS3-milestone:4`, `10a-consolidate:11`, `06-eval-plan:2`, `10b-close-out:2`, `10b2-revise-spec:4`, `10b4-journeys-gap:2`. **Edit** (§3, and `lifecycle-status`):
- Links are relative to `lifecycle/`.
- **Column 8** reads `done/total`, where total is the plan's stages plus Change stages, and B4a and B4b count as two. Milestones don't write column 8.
- **Column 10** may read `closed · eval <date>` or `closed · eval due` until the eval plan's last check (L13).
- **After close-out,** `STALE` means "read with the change note beside it". It is cleared only if a phase is rerun or the module reopens.
- **An owed pass on a phase without a column** (4b, 7b) is written in the parent column as `done · owed <step>`. `STALE` stays reserved for contradiction (RV-2).
- **A scoped run** (JO-7) writes `done`, and its changelog line says what it didn't check.

**M-7 · Names that collided.** *Seen:* `07-build-plan:4`, `08e-ci-deploy-change:6`, `09b-polish-change:6`, `09-live-review:3`. **Edit** (§0, *Words*): milestones are `MS<n>`. Each document that numbers criteria owns a prefix: the spec `AC-`, and each change note its own two letters (`CI-`, `PL-`). Review findings are pass-scoped (RI-3).

**M-8 · Founder-supplied inputs have no owner.** *Seen:* `04b-design:MF`, `05e-design:6`, `05e-design:MF`, `08d-MS4-milestone:2`, `08a-B6-launch:MF`, `08d-MS2-milestone:MF`. **Edit** (§3, *Where things live*): the project's open-work file keeps a *From the founder* table for copy, marks, channel links, devices and production content a check needs. Each row has *needed by* (a step or milestone). `lifecycle-status` lists rows due within the next step.

---

## 3. Shared mechanics: `skills-plan.md` §0

**S0-1 · The gate.** *Seen:* `04-wireframes:10`, `archive pass1-sonnet:1` (L5); `05d-journeys-gap:6`, `08a-B4b-launch:4`, `08c-B4a-verify:1`, `08c-B4b-verify:1`, `08a-CD1-launch:5` (L4); `10b-close-out:1`; `04-wireframes:7`; `07b-project-config:4`; `03a-personas:6`; `05d-journeys-gap:MF`. **Edit** (*The gate*):
- `bin/gate` runs `git fetch`, and reports a branch behind its upstream as `GATE FAIL`.
- Each phase skill works out its step from the files (`briefs/<stage>.md`, `.report.md`, the status row, `STATE.md`'s next step). If the prompt names another step, or an unknown one, the skill says so, lists near matches and stops.
- `bin/gate --override "<reason>"` prints `GATE OVERRIDDEN`, and the skill writes the reason into its output's header.
- For HTML outputs, the gate checks `<h2>` text.
- A config value of `none` passes.
- The gate for column 3 reads the `## Personas` table, not the file's existence.
- For journeys and the change notes, it diffs the spec's AC ids against the Coverage table.

**S0-2 · Parallel sessions (L1).** *Seen:* `06-eval-plan:6`, `08a-B8-launch:6`, `08a-CD1-launch:1`, `08c-CD1-verify:3`, `08c-CD1-verify:4`, `05e-design-import:2`. **Edit** (new paragraph, *Parallel sessions*): L1's rule as drafted:
- commit by path (`git commit --only`), or from your own checkout;
- fetch and rebase right before pushing;
- merge `STATE.md` by block, never by copying a file over it;
- on one machine, read the heavy-runner lock (PC-8);
- push `HEAD:main` from the stage worktree when another session holds local `main`, and tell that session to rebase.

*As-built:* the block-merge part is in the trial README 0.5.

**S0-3 · A redo path (L6).** *Seen:* `01-research:1`, `01-research:2`, `archive pass2-opus:1`, `archive pass3-opus-fresh:1`, `archive pass3-opus-fresh:2`, `01-research-integration:2`, `01-research-integration:3`, `01-research-integration:4`, `01-research-integration:MF`, `01-research:MF`. **Edit** (new paragraph, *Redoing a phase*): the trial's rule 9 made general.
- The earlier output and log move unread to `<module>/archive/<phase>/passN-<model>/`.
- The new output's header carries a *Supersedes* line.
- The status cell is unchanged.
- An independent redo doesn't read `STATE.md` blocks after the earlier pass's gate. A cumulative redo reads them and says so.
- Merging passes is its own session (`<phase>-integration`).

*As-built:* the trial README 0.4, rule 9.

**S0-4 · References are committed paths and copied ids (L3).** *Seen:* `05e-design:1`, `05f-revise-spec:1`, `08b-B5-land:3`, `07b-project-config:2`, `10b2-revise-spec:6`. **Edit** (§0): L3 as drafted. Add: "Journey steps, ACs and findings are cited by id copied from the file (`J3.4`, not 'J2 step 4'). An open-work number is cited with its file."

**S0-5 · Asking the founder.** *Seen:* `02-spec:1`, `02-spec:2`, `04c-revise-spec:1`, `04c-revise-spec:6`, `05b-revise-spec:2`, `05b-revise-spec:3`, `06-eval-plan:4`, `08e-ci-deploy-change:4`, `09b-polish-change:4`, `10a-consolidate:9`, `08c-B4a-verify:5`; L14, L16, Z-a, `H:02-spec:2`, `H:04c-revise-spec:3`; 10a's *Lessons* 1. **Edit** (new paragraph, *Asking the founder*):
1. Ask in one batch, at most four questions per call. Two calls in one turn still count as one batch. Facts the founder must look up go in a pre-flight list, not the batch.
2. Read enough of the code and files to word each option truthfully before asking (L16).
3. Whatever the founder needs to answer goes inside the question, or in the closing message. Never put it in text just before the question box. Commands for the founder go in the closing message.
4. **Z-a:** an answer that adds a requirement, contradicts the spec or answers with a question becomes a new item. Size it, propose a bounded definition graded *proposal* with what it excludes, and ask again. It is never written downstream as accepted.
5. When the founder defers to a skill or rubric, apply its rule and name it in the output.
6. *Explain more* is an outcome. The item stays pending for a second round.
7. A skill that asks first also ends by asking acceptance of its open assumptions, listed.

**S0-6 · The grading key.** *Seen:* `02-spec:3`, `03a-personas:4`, `archive pass2-opus:4`, `archive pass1-sonnet:3`, `09-live-review:4`; L11. **Edit** (§0, a *Grades* paragraph, and the templates' key):
- The kinds are *evidence*, *as-built*, *proposal* and **decision** (the founder, with a date; written [F]).
- Evidence also carries a strength: *strong*, *moderate*, *thin*, or *summary only* (through a search summary, never quoted).
- Personas are *hypothesis* until a review pass or real-user data grounds them (PE-3).
- A review grades the observation (*as-built* live, *simulated* static) apart from the score (*simulated*: one reviewer's judgement).

**S0-7 · Model and effort.** *Seen:* `00-intake:8`, `01-research:5`, `archive pass3-opus-fresh:5`, `archive pass1-sonnet:5`, `archive pass2-opus:2`, `08a-CD1-launch:6`, `08c-B4b-verify:1`, `08c-B5-verify:3`, `05e-design:3`. **Edit** (*Model and effort*): "The session can see its model but not its effort. Every skill's first message states the model from frontmatter. Where the prompt states an effort that differs, the skill says so and continues. A session on the wrong model stops before work. A step run outside Claude Code (a design tool) has no model row. Its log says which tool, and its cost is estimated (CO-4)." *Data point, no edit:* a medium-effort verify (B5) still found four defects by driving the screens.

**S0-8 · Injected context includes where the repos are.** *Seen:* `10b2-revise-spec:5`, `10b-close-out:5`, `10b-close-out:MF`, `10b2-revise-spec:MF`. **Edit** (*Injection*): each skill that touches the code repo injects `config.md`'s path for the current machine and a `git -C <path> rev-parse` line, so it knows at once whether the repo is reachable. If it isn't, the skill names its fallback (the plan's changelog and open-work), or asks.

**S0-9 · What forking can't do.** *Seen:* `08c-B2-verify:3`, `05-ux-review:8`. **Edit** (*Forking*):
- "A forked skill can't wait on the founder. `verify` forks for review and fixes, and ends at 'ready to deploy'. The deploy runs in the main session (VE-5)."
- "A forked review gets the change note's *carried* list and open-work's rows injected, so owed items aren't counted as defects (UX-5)."

**S0-10 · Outward-facing and destructive actions.** *Seen:* `08b-B1-land:2`, `08c-B1-verify:6`, `08c-B3-verify:3`, `08c-B8-verify:2`, `08c-B6-verify:1`, `08d-MS2-milestone:5`, `10b2-revise-spec:5`. **Edit** (new paragraph):
- "Pushing to a repo whose `main` deploys, pushing a branch to a public remote, posting content to an outside service, and any destructive step on production need the founder's yes in this session.
- A skill never runs a destructive production step. It lists it for the founder.
- If the permission layer blocks an approved push, the skill ends with 'push pending: founder' and doesn't look for another route."

---

## 4. Every-session skills

### `lifecycle-status`

**ST-1 · Enforce the cap and show what's owed.** *Seen:* `10a-consolidate:2`; M-8. **Edit** (*Output*): add "inbox over cap: N notes, oldest D", which is also checked at each milestone (LE-2). Add the founder's rows due within the next step (M-8).

### `handoff`

**HO-1 · The block header names both repos.** *Seen:* `00-intake:3`. **Edit** (*Block format*): "date · `<root-sot branch> @ <hash>` · `<code repo> main @ <hash>` where there is one".

**HO-2 · Pointers, not findings (L2).** *Seen:* `01-research-integration:2`, `06b-eval-plan-touch-up:3`, `05b-revise-spec:4`. **Edit** (*Block format*): L2 as drafted:
- live next steps are copied forward in full;
- options are named by noun;
- questions are ready to ask, each with *owed by*;
- carry-overs are decisions and pointers to sections.

**HO-3 · Blocks that relate to each other.** *Seen:* `08b-B4b-land:3`, `10b3-eval-plan-touch-up:4`, `01-research-integration:2`. **Edit:** the block's first line says which earlier blocks it *replaces*, *adds to* or *partly completes*, naming the step. A block that touches a stage named in another live block cross-references it.

**HO-4 · *Next* is the prompt.** *Seen:* `08c-B4a-verify:1`, `08c-B4b-verify:1`, `08a-CD1-launch:5`. **Edit:** each next step is written as the line the founder pastes, with skill, model, effort, branch and the checkout it writes in. With skills, that line is the invocation.

### `decision-record`

**DR-1 · Format and ids.** *Seen:* `03a-personas:9`, `05c-personas:5`, `03a-personas:MF`. **Edit:** the shared reference file holds the entry format the trial settled on (`## L-n · date · title`, then *Decision*, *Why*, *Decided by*, *Revisit*). It also holds the id rule: one letter per log (`L-` for the method), numbered in sequence.

**DR-2 · A module's own decisions.** *Seen:* `04c-revise-spec:5`, `04c-revise-spec:MF`, `05b-revise-spec:MF`, `05f-revise-spec:MF`. **Edit:** product decisions go in the module's change note, and a one-line index goes in `<module>/decisions.md`. `lifecycle/decision-log.md` keeps only method decisions. L-2, L-3, L-5 and L-6 move to IMNSTR's index when this is applied.

### `learned`

**LE-1 · A capture template.** *Seen:* `10a-consolidate:1`, `10a-consolidate:MF`. **Edit:** each note has fixed bold fields: *Rule*, *Event*, *Cost*, *Scope*, *Destination*, *Urgent*. Consolidation extracts them with one `awk`.

**LE-2 · Consolidate at each milestone during a build.** *Seen:* `10a-consolidate:2`; 10a's *Lessons* 2. **Edit** (*Invocation*, and `README.md` §5 rule 7): "…when the inbox is over cap, at each milestone during a build, and before any `close-out`."

**LE-3 · Holds at the end of a module.** *Seen:* `10a-consolidate:3`. **Edit:** "At a module's last consolidation, holds become seeds for the destination's reference file, listed by destination."

**LE-4 · Count recurrence by session.** *Seen:* `10a-consolidate:4`. **Edit** (step 2): "seen in two or more sessions".

**LE-5 · Find what is already integrated.** *Seen:* `10a-consolidate:5`; 10a's *Lessons* 3. **Edit** (*Reads*): inject the `## Changelog` lines of each candidate destination, and the memory index.

**LE-6 · A destination that doesn't exist yet.** *Seen:* `10a-consolidate:6`. **Edit** (step 3): "If the destination doesn't exist, draft the rule and name the destination. The file's first author places it."

**LE-7 · A cross-project engineering checklist.** *Seen:* `10a-consolidate:7`, `10a-consolidate:MF`; 10a §4's 8 product notes; product items in §13. **Edit:** add `lifecycle/engineering-checklist.md`, for web engineering knowledge that outlives one project. Add it to the destination table: "a fact about building software, true beyond this project". Its seeds:
- 10a §4's eight notes: why a session ended, quotes by language, idempotency keys, server-filled defaults, link-preview fetchers, `pointerType` on `click`, synced passkeys;
- 304 versus 200 in counting, and every feed reader is a bot (`08a-B8-launch:1`, `:2`);
- IP literals in referrers (`08a-B8-launch:4`);
- `page.clock` doesn't move CSS transitions (`08c-PL1-verify:4`);
- an admin bundle with no wall clock needs the server's `now` (`08a-B5-launch:4`).

**LE-8 · The founder's observations.** *Seen:* `10a-consolidate:8`. **Edit** (*Reads*): "and `founder-notes.md` where the module has one. Each note is a cluster of its own, with mechanisms offered as options."

**LE-9 · Presenting the batch.** *Seen:* `10a-consolidate:9`. **Edit** (reference): "Groups of at most four. One plain sentence per item, with its event, inside the question. Longer explanations go in the closing message." Also S0-5 rule 3.

---

## 5. Design skills

### `ideate`

**ID-1 · Questions that presume Root.** *Seen:* `00-intake:1`; `H:00-intake:1`. **Edit** (*Asks*): "pillar and place on the opportunity tree, for Root work. Otherwise write 'n/a, outside Root', with a reason."

**ID-2 · A place for intake's decisions.** *Seen:* `00-intake:5`. **Edit** (*Writes*): `00-intake.md` ends with *Decisions at intake*: the track, research or a waiver line, the code repo, which phases apply (UI or not), and the project.

**ID-3 · A vague drop rule.** *Seen:* `00-intake:6`; `H:00-intake:2`. **Edit:** "Record the founder's drop rule verbatim. If it isn't testable, say so and pass it to `spec` and `eval-plan`."

### `research`

**RE-1 · Research reviews itself against its inputs (L10).** *Seen:* `01-research-integration:1`. **Edit** (reference): L10 as drafted: every evidence-summary section accounted for, every proposal checked against each intake line, and the drop rule's outcome researched.

**RE-2 · Reaching sources (L11).** *Seen:* `01-research:3`, `archive pass3-opus-fresh:3`, `archive pass2-opus:3`, `archive pass1-sonnet:6`, `archive pass1-sonnet:3`. **Edit** (reference): L11 as drafted. The fallback order is fetch, then the browser, then the source's own repository or another copy (an abstract, Crossref), then a search summary graded *summary only*. Unreachable sources go under *Not researched*. Security claims need a primary or standards source, or are graded *thin*.

**RE-3 · How much searching.** *Seen:* `archive pass1-sonnet:2`. **Edit** (reference): "At least two independent sources per load-bearing claim. Stop at three searches that add nothing. Mark what wasn't reached."

**RE-4 · A section for the next phases.** *Seen:* `archive pass1-sonnet:4`, `archive pass2-opus:5`, `01-research-integration:1`. **Edit** (template): required heading *For the next phases*. It holds options named by noun (with letters, if any, only as aliases), and the questions for `spec`.

**RE-5 · Reads and the cap.** *Seen:* `01-research:4`, `archive pass2-opus:6`, `01-research-integration:1`. **Edit** (*Reads*): "the code it concerns, if any". (*Writes*): "~2,500 words, sources excluded".

### `personas`

**PE-1 · When no registered persona fits.** *Seen:* `03a-personas:1`; `H:03a-personas:1`. **Edit** (*Does*): "The selection may be empty. When no persona fits, propose one per intake audience, defined by behaviour."

**PE-2 · Acceptance.** *Seen:* `03a-personas:2`. **Edit:** "Whenever it proposes a persona, it asks the founder to accept before writing the registry."

**PE-3 · The persona record.** *Seen:* `03a-personas:3`, `03a-personas:4`, `05c-personas:3`, `03a-personas:MF`, `05c-personas:MF`. **Edit** (registry template): the fields are ID, name, serves, grounding, grade (*hypothesis* or *grounded*), arrives how, device, knows entering (including languages read), and probes. Demographics are optional and never invented.

**PE-4 · The owner as a persona.** *Seen:* `03a-personas:5`. **Edit** (*Rule*): "A module's owner may be a persona. Their real judgement stays the founder's, not the persona's score."

**PE-5 · The journeys header, and adding to a selection.** *Seen:* `03a-personas:6`, `03a-personas:7`, `03b-journeys:9`, `05c-personas:1`, `05c-personas:2`. **Edit:** the header is a title block plus `## Personas` (persona, serves, why, anchors). Add a mode, `personas add`, that adds a row after journeys exist. `personas` owns `## Personas` and `journeys` never edits it. The journeys version is bumped by the next `journeys` run.

**PE-6 · Read the spec when proposing.** *Seen:* `03a-personas:8`. **Edit** (*Reads*): "the spec's interface section, when proposing".

*No edit:* `05c-personas:4` (whether a bilingual writer persona is needed) is a product question, left to step 9 by L-4.

### `spec`, full mode

**SP-1 · The template.** *Seen:* `02-spec:4`, `02-spec:MF`. **Edit** (`templates/02-spec.md`): Summary, What it is, Decisions taken at spec, Metrics, Interface requirements, Risks, Acceptance criteria, Out of scope, Changelog, References. The scope ledger goes in the header (SP-10).

**SP-2 · The journeys sentence.** *Seen:* `02-spec:5`. **Edit** (*Writes*): "journey-level criteria belong to `03-journeys.md`, written after the spec. The spec doesn't anticipate them."

**SP-3 · Metrics versus the eval plan.** *Seen:* `02-spec:6`, `06-eval-plan:5`. **Edit:** "The spec defines measures. The eval plan owns instruments and rules, and may refine a measure. A refinement goes to `revise` as an item, and the plan proceeds on its refinement."

**SP-4 · Who chooses the platform.** *Seen:* `02-spec:7`. **Edit:** "The spec names a stack implication as a risk. `build-plan`'s foundation batch decides it (BP-1)."

**SP-5 · An interaction placed on a link.** *Seen:* `08a-B9-launch:1`. **Edit** (reference): "Where a gesture sits on a link or control, say which one wins."

### `spec`, change mode

**SP-6 · A gate for a Change during a build.** *Seen:* `08e-ci-deploy-change:3`, `08e-ci-deploy-change:12`. **Edit** (*Gate*, `change`): inject `STATE.md`'s top block and the lanes in flight, and refuse while a lane touches the same files. The note's header carries `main @ <hash>`, and `build-phase` re-reads it against `main`'s log since then before drafting.

**SP-7 · Check as-built facts before writing (L16).** *Seen:* `08a-CD1-launch:4`, `09b-polish-change:4`, `08b-PL1-land:2`. **Edit** (reference): cite every as-built fact a step depends on, with its file. Read the code an option's consequence depends on before asking.

**SP-8 · The Stages shape.** *Seen:* `08a-PL1-launch:1`, `08a-PL1-launch:3`, `08e-ci-deploy-change:8`, `08e-ci-deploy-change:7`, `09b-polish-change:5`, `08b-CD1-land:2`; L18. **Edit:**
- the full suites are the verify's (lanes run targeted tests);
- optional fields *At the verify* (a server runbook) and *Stop points* (commit boundaries);
- an *Image and deploy* line per stage;
- for any infrastructure change, "what does this change about how later stages are built, verified or deployed?";
- size with the test harness counted, as `build-plan` does.

**SP-9 · Criteria and review findings.** *Seen:* `08e-ci-deploy-change:6`, `09b-polish-change:7`, `09b-polish-change:2`. **Edit:** the note owns a criterion prefix (M-7). Its criteria table has an *Item* column naming the finding each criterion closes. A review's `question`-routed findings join the note's first batch.

**SP-10 · What a Change leaves stale, and the scope ledger.** *Seen:* `08e-ci-deploy-change:9`, `09b-polish-change:3`, `10b2-revise-spec:3`; Z-b. **Edit:**
- the note ends with *What this makes stale*, naming each file, its owner and the step that catches it up;
- a note that defers the spec adds a `revise` line to its `STATE.md` block's next steps, and `close-out`'s gate fails while one is pending (M-4);
- **Z-b:** the spec header carries acceptance criteria counted by area at each version, against intake (see RV-3).

**SP-11 · Two kinds of file in `changes/`.** *Seen:* `08e-ci-deploy-change:11`. **Edit:** one numbering, and a kind in the name: `NN-req-<slug>.md` from `revise`, `NN-change-<slug>.md` from `spec change`. The header line repeats the kind.

### `journeys`

**JO-1 · Both modes ask.** *Seen:* `03b-journeys:1`, `05d-journeys-gap:4`. **Edit:** "Both modes ask one batch and record it in *Decisions taken at journeys*. A founder decision the spec lacks is also listed as Suggested, for `revise`."

**JO-2 · Suggested, in every mode, through to acceptance.** *Seen:* `03b-journeys:2`, `05d-journeys-gap:3`, `05f-revise-spec:3`; `H:03b-journeys:2`. **Edit:** every mode keeps requirements the spec lacks apart, marked **Suggested**, in a section `revise` reads. Once accepted, the next `journeys` run marks each one "accepted at spec x.y", pointing at its AC. `revise` notes in its change note that this is owed.

**JO-3 · Checks and Coverage.** *Seen:* `03b-journeys:4`, `03b-journeys:5`, `05d-journeys-gap:5`; `H:03b-journeys:1`. **Edit** (template): each step's last cell, *Must be true*, is a check citing ACs (`J<n>.<step>`). `## Coverage` is required: AC to step, with the values `step`, `no screen` or `all steps`.

**JO-4 · The states table.** *Seen:* `03b-journeys:6`, `05e-design:5`. **Edit:** `journeys` ends with a states table (empty, error, loading, not enough data, notices), which `wireframes` reads.

**JO-5 · Journeys versus scenarios.** *Seen:* `03b-journeys:7`, `03b-journeys:8`. **Edit:** scenarios may share a journey, error journeys may be branches, and a journey with two actors adds a *Who* column.

**JO-6 · Length.** *Seen:* `03b-journeys:11`. **Edit:** a guide of ~3,000–4,000 words, not a limit.

**JO-7 · The modes: `gap`, `update`, and scoped runs.** *Seen:* `05d-journeys-gap:1`, `10b4-journeys-gap:2`, `10b4-journeys-gap:3`. **Edit** (*Modes*):
- `gap` checks against the code;
- **`update`** brings journeys up to a newer spec and new personas, from the change notes since its version;
- either may be scoped (`--steps J2.9,J3.4` or `--from-note 07`). The changelog then says what wasn't checked, and the status cell stays `done` (M-6).

**JO-8 · Amending without breaking citations.** *Seen:* `05d-journeys-gap:2`; `H:05d-journeys-gap:1`. **Edit:** keep step numbers, give inserted steps a letter suffix, and mark changed text **[x.y]**.

**JO-9 · Grading after the build.** *Seen:* `10b4-journeys-gap:4`. **Edit** (`close-out`): close-out updates the *Grading* line of each design document to say what is now as-built, citing the stage records. No journeys mode is needed.

### `wireframes`

**WF-1 · Steps.** *Seen:* `04-wireframes:1`; `H:04-wireframes:1`. **Edit:** gate; list steps and states from journeys' steps and states table; group by screen; draw; write the *Calls made here* table; write the coverage plate.

**WF-2 · Coverage by step.** *Seen:* `04-wireframes:2`. **Edit:** "Every journey step is traceable to a frame. Draw by screen, and include a step-to-plate table."

**WF-3 · Steps with no screen of ours.** *Seen:* `04-wireframes:3`. **Edit:** each such step is marked either "not ours, drawn as context" or "no screen, note".

**WF-4 · Suggested items.** *Seen:* `04-wireframes:4`. **Edit:** draw them as visibly marked options, never as plain UI, and list which were drawn.

**WF-5 · *Calls made here*.** *Seen:* `04-wireframes:5`, `04-wireframes:6`. **Edit:** a required section, with behaviour calls graded *proposal*. `ux-review` reads it and `build-plan`'s gate reads it (M-4).

**WF-6 · Low fidelity, and looking at it.** *Seen:* `04-wireframes:8`, `04-wireframes:9`, `04-wireframes:MF`. **Edit:** define it as "neutral tokens; real copy only where the words are the requirement; placeholder bars elsewhere; no brand". The last step renders at 1200 and 375 px and looks. A shared frame kit goes in `templates/wireframes.html` (F-2).

### The design step (new section)

**DS-1 · A brief for 4b and its import.** *Seen:* `04b-design:1`, `04b-design:8`, `04b-design-import:1`, `05e-design-import:5`, `05e-design:3`, `05e-design:4`, `04b-design:MF`, `04b-design-import:MF`. **Edit** (new section, *The design step*, run by the founder in a design tool, with an import skill):
- Inputs: spec §4 and §6, the journeys' steps and states, the wireframes' coverage plate.
- The opening form (DS-5).
- Output: self-contained HTML plus `source/`, edited in place, since git keeps the history.
- Build plate by plate; large single writes timed out.
- **The import** (Opus, medium) has its own log and `STATE.md` block, and may edit `04b-design/README.md`. It runs the import checklist (DS-3).

*As-built:* the trial README 0.4's 4b row has the output shape and the import requirement.

**DS-2 · The handoff folder.** *Seen:* `04b-design-import:2`, `05e-design-import:1`, `05e-design-import:2`. **Edit:** the handoff is `../repo-handoff-<step>/`, beside the repo, mirroring repo paths. The import diffs `STATE.md` and merges by block, never by overwriting.

**DS-3 · The import checklist.** *Seen:* `04b-design-import:3`, `04b-design-import:4`, `04b-design-import:6`, `05e-design-import:3`, `05e-design-import:4`, `05e-design-import:MF`; `H:04b-design-import:1`. **Edit** (`templates/design-import-checklist.md`):
- serve locally and confirm zero external requests;
- reduced motion may be checked in the source;
- every revealed or animated state is drawn at the narrowest width;
- check against the README's list, while the founder compares with the tool's preview;
- name at least one frame per new plate to look at by eye;
- separate what was lost in the move from what is missing in the design.

**DS-4 · A review between design and the UX review.** *Seen:* `04b-design-import:5`. **Edit:** an optional accessibility and HIG pass at the end of 4b. It writes proposals only, which go to `revise`. Its scores are left to step 5.

**DS-5 · The opening form (L12).** *Seen:* `04b-design:4`. **Edit:** L12 as drafted: references, the feel wanted, and whether an attached design system binds.

**DS-6 · How much to draw.** *Seen:* `04b-design:7`. **Edit:** phone for every screen and state. Desktop is required for public pages and the main editor. Gaps are listed in the README.

**DS-7 · Inputs for a second pass.** *Seen:* `05e-design:1`, `05e-design:2`, `05e-design:MF`. **Edit:** a second pass reads the change notes' *Carried to design* lists, which link each item's source (RV-5), any earlier design review folder, and the spec sections the change notes cite.

**DS-8 · The design README.** *Seen:* `05f-revise-spec:1`, `08a-B4b-launch:MF`, `08a-B5-launch:6`, `08a-B5-launch:MF`, `08a-B6-launch:5`, `08a-B6-launch:MF`, `08a-B7-launch:5`, `08a-B7-launch:MF`, `08a-B9-launch:4`, `08a-B9-launch:MF`. **Edit** (template):
- *Beyond the spec* has *scope* and *ends when* columns (L3);
- a **plate index**: plate, caption anchor, journeys steps, ACs, states and copy (asked at five launches);
- every plate carries its `Wireframe plate N.` marker;
- a *Disagreements* list, where phone and desktop frames differ;
- contrast figures are measured, from a script, never by eye.

### `eval-plan`

**EV-1 · Steps and asks.** *Seen:* `06-eval-plan:1`, `06-eval-plan:MF`. **Edit:** steps are the failures that look alike, the instruments, the rule before the data, cost, and limits. It asks the founder about consequences: what "drop" means, and what happens after the last check.

**EV-2 · Close-out versus later checks (L13).** *Seen:* `06-eval-plan:2`, `06-eval-plan:3`, `06-eval-plan:MF`. **Edit:** L13 as drafted. Results go in the plan's §5 *Results* table. Later checks count from launch (M-3). `close-out` writes their dates and creates a scheduled reminder (a `/schedule` task, with the founder's yes).

**EV-3 · A touch-up mode.** *Seen:* `06b-eval-plan-touch-up:1`, `06b-eval-plan-touch-up:2`, `06b-eval-plan-touch-up:4`, `10b3-eval-plan-touch-up:2`, `10b3-eval-plan-touch-up:3`; `H:06b-eval-plan-touch-up:1`. **Edit:** `eval-plan --touch-up <change note>` (Opus, medium). Its gate is that the spec is newer than the plan's input version. It reads the note's items and the sections they cite. It fixes what contradicts the spec, and what the change makes wrong in an instrument, and logs both. A rule whose *action* cites a question the spec has since settled goes to the founder.

**EV-4 · Instruments that impose build order.** *Seen:* `07-build-plan:9`. **Edit:** each instrument names its preconditions (device, domain, real data). `build-plan` places them.

### `build-plan`

**BP-1 · The foundation batch (L14).** *Seen:* `07-build-plan:5`; `02-spec:7`. **Edit** (step 1): when `projects/<project>/` doesn't exist, ask the founder's facts in one batch before drafting: repo, host, stack, domain, server facts, the devices they have. Answers go in the plan's §4, marked as answered.

**BP-2 · The defect pass (L19, L20).** *Seen:* `07-build-plan:1`, `08a-B8-launch:3`. **Edit** (*Reads*): "code and infrastructure the build will touch or share. For a project with no code, the inputs, for contradictions and leaks." Add L19 and L20 to the reference.

**BP-3 · Sizes.** *Seen:* `07-build-plan:3`, `08b-B1-land:4`, `08b-B4a-land:1`, `08b-B5-land:1`, `08b-B6-land:2`, `08b-B7-land:3`. **Edit** (beside the lane budget): a size is lane hours and lines of new app code, with tests and moved code counted apart. *Evidence:* stages overran their line estimates (B4a +3,875 against L's ~3,000; B5 +2,634 against M's ~1,500; B7 +5,291) while running far under in time (B4a about 23 min against 4–6 h). Recalibrate from the stage records once a second module exists.

**BP-4 · A new project's order.** *Seen:* `07-build-plan:6`, `07-build-plan:7`. **Edit:** "For a new project, the plan's §0.3 is the source of the project's house rules, which 7b transcribes." Inject `README.md` §6–§7 into `build-plan`.

**BP-5 · A template, and the plan's size.** *Seen:* `07-build-plan:8`, `07-build-plan:10`, `07-build-plan:MF`. **Edit:** `templates/07-build-plan.md` holds the §0–§10 skeleton and one sample stage, so the 972-line source on an unmerged branch isn't read again. *Held:* a 400–600-word bound per stage, until a second plan exists to compare with.

**BP-6 · What each stage section must say.** *Seen:* `08a-B4a-launch:2`, `08a-B4b-launch:1`, `08a-B4b-launch:2`, `08a-B5-launch:1`, `08a-B5-launch:2`, `08a-B6-launch:2`, `08a-B7-launch:1`, `08a-B7-launch:2`, `08a-B8-launch:5`, `08c-B7-verify:2`, `08a-B9-launch:1`; L18. **Edit** (stage template, beside size and traps):
- **Image and deploy:** new environment variables with production defaults, and toolchain changes (L18).
- **Constraints from earlier stages** its writes must work through (triggers, unique keys).
- **The plate it draws from,** and which stage owns each control on it. A frame-first split is planned explicitly.
- **The API from the screens' save boundaries,** not one route per verb.
- **A guard for every destructive CLI.**
- **Deploy-sequencing traps as stages** (B6a, B6b), never as an instruction one lane can't carry out.
- **For a server-filled field,** what the screen shows for each verb.

**BP-7 · The plan checks itself.** *Seen:* `08a-B3-launch:5`, `08a-B4a-launch:1`, `08a-B5-launch:3`, `08a-B8-launch:2`, `08a-B1-launch:4`. **Edit** (last step, before commit):
- each §6 catalogue row agrees with its §5 section;
- PDs don't contradict each other or the house rules;
- every "open" call is listed in §10 as left to the card.

### Project config: `skills-plan.md` §0's table, and a `project-config` skill

**PC-1 · Contents.** *Seen:* `07b-project-config:1`, `07b-project-config:MF`. **Edit:** a *Project config* section listing each file's required contents, which become its template:
- **`brief-common.md`:** as `build-phase` lists.
- **`review-checklist.md`:** what must not break, house rules, done means, the verification ceiling, the probe list (L25), the reflow rule (L26), the flake rule (VE-10).
- **`config.md`:** paths per machine, suites, the milestone script, lane slots, branches, environment, scripts, the open-work and state-of-the-build files, the design system and the canon.

**PC-2 · The example brief in git.** *Seen:* `07b-project-config:2`. **Edit:** commit the journeys build's `brief-common.md` as `lifecycle/templates/brief-common.example.md` (L3).

**PC-3 · Per-project files.** *Seen:* `07b-project-config:3`, `07b-project-config:4`, `08c-B1-verify:8`. **Edit:** `config.md` names the open-work file and the state-of-the-build file. `none` is valid for the second.

**PC-4 · Config for a project with no code.** *Seen:* `07b-project-config:5`, `08a-B2-launch:MF`; `H:07b-project-config:2`. **Edit:** the config is written as planned, and the first stage's `verify` reconciles it with the founder's yes. Any verify that receives founder facts folds them into `config.md` the same way.

**PC-5 · Who creates a project's config.** *Seen:* `07b-project-config:6`. **Edit:** a small `project-config` skill (Opus, medium), run once per project after the build plan, with the founder accepting.

**PC-6 · Lane slots, branches and ports.** *Seen:* `07b-project-config:7`, `08e-ci-deploy-change:5`, `08a-CD1-launch:MF`, `08a-PL1-launch:MF`, `09b-polish-change:6`, `09-live-review:MF`, `08c-B3-verify:MF`. **Edit** (config template):
- a lane-slot table, whatever the stack;
- a branch rule for Change stages: `<two letters><n>-<slug>`, taking the free slot;
- a review port and seed route.

**PC-7 · Which checkout each session uses.** *Seen:* `08a-B1-launch:6`, `08a-B3-launch:2`, `08a-B4a-launch:6`, `08a-B4b-launch:5`, `08a-B5-launch:MF`, `08a-B6-launch:MF`, `08a-B7-launch:MF`, `08a-B8-launch:MF`, `10b2-revise-spec:MF`. **Edit:** `config.md` names, per machine:
- the root-sot checkout lanes read (and the step that moves it to the card's commit);
- the checkout each kind of session writes in, and how it commits (`HEAD:<branch>` from a detached worktree);
- the code repo's path.

`brief-common.md` uses those names, never one machine's absolute path.

**PC-8 · Environment.** *Seen:* `08a-B2-launch:5`, `08c-B4b-verify:MF`, `08a-B6-launch:MF`, `08d-MS2-milestone:MF`, `08a-CD1-launch:1`, `08c-B2-verify:MF`, `08c-CD1-verify:2`, `08c-CD1-verify:MF`, `08c-PL1-verify:2`, `07-build-plan:MF`; L15, L33. **Edit** (config template):
- Docker policy ("only when your card says so", L18);
- a free-disk check before image builds (L33);
- the founder's devices and accounts (L15);
- a heavy-runner lock file that the milestone script and heavy lanes take;
- a server runbook (sudo user, versions, other tenants);
- where CI status and logs are read;
- "the milestone script writes the whole output to a file, then greps it".

*As-built in IMNSTR's config:* the server facts, the push rule, and one e2e worker.

**PC-9 · Review and check scripts.** *Seen:* `05-ux-review:7`, `05-ux-review:MF`, `08c-B3-verify:MF`, `08c-B4a-verify:MF`, `08c-B4b-verify:3`, `08c-B4b-verify:MF`, `08c-B5-verify:MF`, `08c-B6-verify:4`, `08c-B7-verify:3`, `08c-B7-verify:4`, `08c-B9-verify:4`, `08c-PL1-verify:5`, `08c-PL1-verify:MF`, `09-live-review:MF`. **Edit:** `config.md` names the project's review scripts. The code repo keeps them in a git-ignored or dedicated folder (`tests/review/`):
- capture every state at 360 and 1100 px, at 180 px, in both schemes and with forced colours;
- drive passkey screens with a virtual authenticator;
- an image smoke test;
- validator posts with seed content;
- a full-run summary of what failed and why;
- for design-side reviews, serve and capture a bundled design.

Eight verify logs and both UX reviews wrote throwaway versions of these.

---

## 6. Build skills

### `build-phase`, launch

**BF-1 · The code repo checkout and the worktree.** *Seen:* `08a-B1-launch:1`, `08a-B1-launch:2`, `08a-B4b-launch:6`, `08c-B1-verify:MF`; `H:08a-B1-launch:1`. **Edit** (step 3): the gate checks that the code repo checkout exists and clones it if not. `build-phase` makes the worktree with `git worktree add` from local `main` after a pull, with no upstream, since the Agent tool's isolation can't target another repo. The card tells the lane its working directory.

**BF-2 · The report survives the session (L21).** *Seen:* `08a-B1-launch:3`, `08b-B1-land:1`, `08b-B3-land:1`. **Edit:** L21 as drafted. Land always reads `.tmp/<stage>.report.md`, so it can run in a later session.

**BF-3 · The card's own decisions.** *Seen:* `08a-B1-launch:4`, `08a-B3-launch:1`, `08a-B4a-launch:MF`, `08a-B4b-launch:MF`. **Edit** (card template): a *Decided here* section for what the plan left open, including development dependencies added and how e2e gets its data. Land copies it into *For verify to decide* (BL-2).

**BF-4 · Launch by path.** *Seen:* `08a-B1-launch:5`. **Edit** (step 4): "Launch with the paths of `brief-common.md` and the card; the lane reads them."

**BF-5 · Facts and preconditions before the card (L14, L15).** *Seen:* `08a-B2-launch:1`, `08a-B2-launch:3`, `08b-B2-land:1`, `08a-B6-launch:1`, `08a-B2-launch:MF`. **Edit** (step 1):
- read the P0 items the stage needs from the plan's §4, marked done or open;
- ask the open ones in one question generated from that list, together with environment preconditions (Docker running, devices today);
- for infrastructure stages, draft the card only after the facts arrive;
- list every by-hand check naming the stage.

**BF-6 · Check the plan against what it touches (L16).** *Seen:* `08a-B2-launch:2`, `08a-B4a-launch:5`, `08a-B5-launch:1`, `08a-B7-launch:2`. **Edit** (step 2):
- diff the stage's file list against the tree;
- compare its screens with the plate;
- read the migration for each table it writes;
- re-read a change note against `main` since its `main @`.

Each mismatch goes in the card, flagged for verify.

**BF-7 · Card length.** *Seen:* `08a-B2-launch:4`, `08a-B3-launch:4`, `08a-B4a-launch:4`, `08a-B4b-launch:3`, `08a-B5-launch:5`, `08a-B6-launch:3`, `08a-B7-launch:4`, `08a-B8-launch:7`, `08a-B9-launch:5`, `08a-CD1-launch:3`. *Evidence:* cards ran about 720–1,740 words at 10 of 12 launches. **Edit** (step 2, and `README.md` §6 rule 3): "500–700 words of body. The header, lane table and pasted facts don't count. Over that, a card cites the plate index rather than quoting copy (DS-8), and records the plan's open decisions in *Decided here*. If the body still runs over 1,000, the plan section is underspecified: say so in the log."

**BF-8 · Tests that change on purpose (L17).** *Seen:* `08a-B9-launch:3`, `08b-B6-land:1`, `08b-B7-land:1`, `08b-B9-land:1`, `08b-PL1-land:1`, `08c-B7-verify:1`, `08f-CS1-change:3`. **Edit** (card template, *Tests that change on purpose*; step 2): L17 as drafted, with the grep list written out. Grep for:
- the stage's routes, tables and page names;
- every literal it changes;
- every request field a route starts reading;
- every value class a new refusal covers;
- every helper that does the same job, found by behaviour, not one name (all clock setters).

**BF-9 · Card template sections.** *Seen:* `08a-B4a-launch:3`, `08c-B4a-verify:4`, `08b-B9-land:3`. **Edit:** from the first deploy on, every card has *What the verify deploys*. Each deploy check is one that fails when what it guards is broken. The card doesn't assert a computed outcome it hasn't tried.

**BF-10 · A card on the Change track.** *Seen:* `08a-PL1-launch:2`, `08a-PL1-launch:3`. **Edit:** when the note's stage names files, tests and traps, the card defers to it and adds the code check and the lane rules. `brief-common`'s stop rule reads "at the last commit boundary, if the card defines them".

**BF-11 · Carry-overs move to `brief-common.md` (L22).** *Seen:* `08a-B3-launch:3`. **Edit:** L22 as drafted (`verify` reference and `build-phase`).

### `build-phase --land`

**BL-1 · Land's steps.** *Seen:* `08b-B1-land:3`, `08b-B1-land:4`, `08b-B2-land:2`, `08b-B4a-land:1`, `08b-B4b-land:2`, `08b-B8-land:1`, `08b-CD1-land:3`, `08b-B1-land:MF`; L23; `H:08b-B4b-land:1`, `H:08b-B8-land:1`. **Edit** (*Land*):
1. Check that the lane's commit exists and that its authors are right (L23).
2. Measure the diff from the lane's recorded base, not `main`, and list the files a newer `main` also touches.
3. Record lines (app, tests, moved) and the harness's time and tokens against the size. The lane's own estimate is ignored.

The report file has a one-line header (stage, branch, base).

**BL-2 · *For verify to decide*.** *Seen:* `08b-B3-land:3`, `08b-B4a-land:2`, `08b-B4b-land:1`, `08b-B5-land:2`, `08b-CD1-land:1`, `08c-B4b-verify:4`; `H:08b-CD1-land:1`. **Edit:** the land's `STATE.md` block must list:
- the lane's calls;
- the card's *Decided here*;
- card checks not done, and why;
- changes to what the deploy runs;
- departures from the note or plan.

*Evidence:* B4b's verify worked through eleven such items in order.

**BL-3 · Does land push the branch?** *Seen:* `08b-B1-land:2`. **Edit:** "No. `verify` runs on the machine that holds the branch. If it must move machines, the founder pushes it (S0-10)."

*No edit:* `08b-B3-land:2` (extra report lines, harmless) and `08b-B7-land:2` (naming the refactor worked) confirm current practice.

### `debug`

**DB-1 · Tests loaded by a running suite.** *Seen:* `08f-CS1-change:2`. **Edit** (*Rules*): "Don't edit a test file while a full run has it loaded. Fix it, then rerun that file after the run. App source may change mid-run if the server loads once at the start."

### `verify`

**VE-1 · What verify may write.** *Seen:* `08c-B1-verify:1`. **Edit:** "With the founder's yes in this session, verify may make correction-only edits to the build plan and project config, logged in the stage record. A change to scope goes to `revise`." Also M-5.

**VE-2 · Injected inputs.** *Seen:* `08c-B1-verify:2`, `08c-B3-verify:1`. **Edit** (*Reads*): add `config.md` §1 and §3, the PD and D rows the card names, and open-work's rows for the stage.

**VE-3 · How far a fix on the branch may go.** *Seen:* `08c-B1-verify:3`. **Edit:** "A fix that changes no rendered pixel at the designed sizes, or that only corrects a defect, is the reviewer's. Anything else goes back to a lane or to the founder."

**VE-4 · Rerun scope.** *Seen:* `08c-B1-verify:4`, `08c-B3-verify:5`. **Edit** (step 5): "A fix to a shared helper or a one-rule file reruns every spec that imports or renders through it."

**VE-5 · The deploy and the push.** *Seen:* `08c-B1-verify:6`, `08c-B2-verify:1`, `08c-B6-verify:1`, `08c-CD1-verify:1`, `08c-CD1-verify:3`, `08c-B6-verify:MF`, `08c-B7-verify:MF`, `08c-B9-verify:MF`. **Edit:** for a project whose `main` deploys:
- the order is review, fixes, rebase on `origin/<base>`, *before the push* (stop files, `.env` lines), push on the founder's word, read the run, then record the run's URL;
- the forked part ends at "ready to deploy" (S0-9);
- if blocked, end with "push pending: founder".

*As-built in IMNSTR's config:* pushes on the founder's word.

**VE-6 · Exercise first (L25), and what counts as driving.** *Seen:* `08c-B2-verify:2`, `08c-B3-verify:2`, `08c-B4a-verify:2`, `08c-B4a-verify:3`, `08c-B4a-verify:4`, `08c-B1-verify:9`, `08c-B3-verify:4`. **Edit** (step 2): L25 as drafted. Report item 6 is the reviewer's first work list. The checklist says "driven in a browser" means a scripted real browser plus screenshots that were looked at, graded "screenshots, not a window". The preview pane counts for look, and DOM measurement counts for layout.

**VE-7 · Checks only the founder can make.** *Seen:* `08c-B5-verify:1`, `08c-B8-verify:1`, `08c-B8-verify:2`, `08c-B8-verify:MF`. **Edit** (reference): a signed-in check on production, a server CLI's output and any destructive production step are founder items in open-work. Cards don't promise them of the reviewer.

**VE-8 · When the machine can't run a check.** *Seen:* `08c-B4b-verify:2`. **Edit** (checklist): name the accepted fallbacks with their conditions. For example, "the deploy is the build check when the build runs before `up`, and a failed build leaves the old container serving."

**VE-9 · Order when `main` has moved.** *Seen:* `08c-B8-verify:3`, `08c-B2-verify:6`. **Edit** (*Does, in order*): "0. Fetch. If `main` moved since the lane's base, rebase or merge first, so the review reads what will ship." Fetch again before writing the record.

**VE-10 · Tests that prove something (L24), and flakes.** *Seen:* `08c-B9-verify:1`, `08c-B9-verify:3`, `08c-PL1-verify:3`, `08c-PL1-verify:4`. **Edit** (step 3, and checklist): L24 as drafted. A failure with a cause found is fixed in the test or the page. One without a cause is repeated five times alone, recorded as a flake in the record, and named in the push question.

**VE-11 · Outward-facing checks.** *Seen:* `08c-B3-verify:3`. **Edit** (checklist): each validator check names its endpoint and is posted with seed content only, never real entries (S0-10).

**VE-12 · Claims forward and back.** *Seen:* `08a-B6-launch:4`, `08a-B7-launch:3`, `08a-B9-launch:2`, `08b-B7-land:1`. **Edit** (reference):
- a "later stage reuses this" claim is tested or not written;
- an owed reuse says "extract and generalise" when it is a refactor;
- a placeholder carries the later stage's accessibility semantics, or none, and is checked against the design;
- a test never uses a later stage's planned route as its example of an unknown one.

**VE-13 · A Change's verify and the full suites.** *Seen:* `08c-PL1-verify:1`. **Edit:** "When the change note's criteria ask for the full suites, verify runs them, and budgets for them in its first message (about 30 min per e2e run here)."

**VE-14 · Commands for a human at a server.** *Seen:* `08c-B2-verify:4`. **Edit** (reference):
- `sudo` explicit, and `| sudo tee` for writes;
- one command per line, no chains whose failure is ambiguous;
- no Run-button shell tags, which would run locally;
- all of it in the closing message.

*As-built:* IMNSTR's checklist §6 and `config.md` §7.

*No edit:* `08c-B1-verify:5` (verify's inbox step) is trial rule 4 (TR-4). `08c-B1-verify:7`, `08c-B5-verify:2` and `08c-B6-verify:2` are L26 (RI-5). `08c-B3-verify:6` is L31. `08c-B8-verify:4` is *as-built* in `brief-common.md` and checklist rule 7. `08c-B6-verify:3`, `08c-B7-verify:2`'s display rule and `08c-B9-verify:2` are product (LE-7, BP-6). `08c-B5-verify:3` is S0-7's data point.

### `verify --milestone`

**VM-1 · A red suite.** *Seen:* `08d-MS2-milestone:1`. **Edit:** "A milestone may fix test infrastructure on `main`. A failing app test makes the milestone red and goes to `debug`."

**VM-2 · Two states.** *Seen:* `08d-MS2-milestone:3`, `08d-MS3-milestone:1`, `08d-MS4-milestone:3`, `08d-MS3-milestone:MF`. **Edit:** a milestone is *suites green* or *closed*. It is closed when the by-hand items it lists as blocking are done. Before the run, ask for the devices that day's by-hand items need (L15).

**VM-3 · What a milestone pushes.** *Seen:* `08d-MS2-milestone:4`. **Edit:** "Only docs and test infrastructure, after reading the stop-file list."

**VM-4 · "Every feature present", and production data.** *Seen:* `08d-MS3-milestone:2`, `08d-MS3-milestone:3`, `08d-MS3-milestone:MF`; L28. **Edit** (reference): walk the plan's route catalogue on production in each language, and confirm the signed-out API refuses. Do it with requests the product won't count (L28).

**VM-5 · One list of by-hand items.** *Seen:* `08d-MS4-milestone:1`, `08d-MS4-milestone:2`, `08d-MS4-milestone:MF`. **Edit:** the milestone's by-hand list is open-work's V-rows whose *needed by* names it, and `config.md`'s milestone row points there. The skill checks that production holds the content each item needs, and asks the founder early.

*As-built:* `08d-MS2-milestone:2` (one e2e worker) is fixed in the repo's Playwright config.

---

## 7. Reviews

### `ux-review`

**UX-1 · The design as input and gate.** *Seen:* `05-ux-review:1`, `05-ux-review:2`. **Edit** (*Reads*, *Gate*): "the latest design: 4b where it exists, else `04-wireframes.html`". Rename the mode `design` (or keep `wireframes` and say so).

**UX-2 · The unit of scoring.** *Seen:* `05-ux-review:4`. **Edit:** "scored per persona, per journey".

**UX-3 · The static procedure (L29).** *Seen:* `05-ux-review:6`. **Edit:** L29 as drafted. Check captions and the design README before calling a state missing.

**UX-4 · Rendering a bundled design.** *Seen:* `05-ux-review:7`. **Edit:** inject the serve-and-capture script (PC-9).

**UX-5 · What the fork is told is owed.** *Seen:* `05-ux-review:8`, `09-live-review:8`. **Edit** (*Reads*, injected): the change notes' *carried* lists, and open-work's V- and F-rows.

**UX-6 · Findings carry a route and a status.** *Seen:* `05-ux-review:9`, `07-build-plan:2`. **Edit** (template): a required *For `revise`* heading. The findings table has a *Status* column (`open`, `closed in <file>`, `carried to <step>`), which `revise`, the design import and change notes update. `build-plan`'s gate greps it for `open`.

**UX-7 · `ux-review` asks nothing.** *Seen:* `05-ux-review:10`. **Edit:** "Decisions found are routed `question`, for `revise` or the next change note's batch."

**UX-8 · Live mode's gate.** *Seen:* `09-live-review:6`, `08d-MS4-milestone:3`. **Edit:** as M-4, phase 9.

**UX-9 · What "the running app" means.** *Seen:* `09-live-review:1`, `09-live-review:2`; L28. **Edit:** "Live mode reads production read-only, as a bot (`HEAD` or a bot agent) wherever the project counts readers. It walks every state, and anything behind sign-in, on a local server built from the deployed commit, with the review seed route and a virtual authenticator (PC-6, PC-9)."

**UX-10 · Where live findings go.** *Seen:* `09-live-review:7`. **Edit:** "After the build, UI fixes are routed to `spec change`, as one proposed Change."

**UX-11 · A summary per pass.** *Seen:* `09-live-review:9`. **Edit** (template): one short summary per pass at the top, newest first.

### `lifecycle/review-instrument.md`

**RI-1 · Metric 6 for any second-language reader (L8).** *Seen:* `05-ux-review:3`. **Edit** (§3): M6 is scored for any selected persona who reads the second language. `revise` re-checks the selection when it adds a language (RV-9).

**RI-2 · One severity scale.** *Seen:* `05-ux-review:5`. **Edit** (§4): one scale for every review in a module, High / Medium / Low with definitions, and a finding format of what, where, why, fix and route. The 4b HIG review's Critical maps to High.

**RI-3 · Pass-scoped ids.** *Seen:* `09-live-review:3`. **Edit** (§4): findings are numbered `P<pass>-F<n>`.

**RI-4 · Two grades.** *Seen:* `09-live-review:4`. **Edit** (§4): as S0-6.

**RI-5 · Reflow and targets (L26, L29).** *Seen:* `08c-B1-verify:7`, `08c-B5-verify:2`, `08c-B6-verify:2`, `08b-B9-land:2`. **Edit** (§3 and §5): L26 and L29 as drafted. Tap targets are measured at 360 px in every UI stage. The 200% method is a 180 CSS px viewport, checked against the content column after `document.fonts.ready`.

### `design-review`

**DE-1 · The rubric comes from the project.** *Seen:* `09-live-review:5`. **Edit** (*Reads*): "the design system named in `config.md` §1. Root's brand and tokens apply only when that row points at them."

---

## 8. Closing the loop

### `revise`

**RV-1 · It asks.** *Seen:* `04c-revise-spec:1`. **Edit:** "Ask the founder per item, in one batch, before writing (S0-5)."

**RV-2 · When to set `STALE` (L7).** *Seen:* `04c-revise-spec:2`, `05b-revise-spec:1`, `10b3-eval-plan-touch-up:1`, `10b4-journeys-gap:1`. **Edit:** L7 as drafted:
- contradiction is `STALE`;
- silence is carried, with an owner;
- an output that already provided for the outcome is carried, not stale.

Each `STALE` item quotes the sentence it marks. `revise` greps the output for every line relying on the changed fact, not only the cited step.

**RV-3 · Scope (Z-a, Z-b, Z-c).** *Seen:* `04c-revise-spec:4`, `05b-revise-spec:2`; founder notes 1 and 2. **Edit:**
- **Z-a:** S0-5 rule 4.
- **Z-b:** each version updates the spec header's ledger. When an area doubles since intake, or passes about a quarter of all criteria, `revise` asks "still the smallest version worth trying?" before accepting more.
- **Z-c:** an item that adds a capability (new stored data, a new screen family, or anything intake put out of scope) leaves `revise` for `spec change`, with research or a waiver line (`README.md` §1).

**RV-4 · Outcomes.** *Seen:* `04c-revise-spec:6`, `04c-revise-spec:7`, `05b-revise-spec:3`, `05b-revise-spec:5`, `05f-revise-spec:5`. **Edit:** each item is one of: *accepted*, *refused*, *carried to <step or skill>*, *left to the build plan* (listed under *Open*, which `build-plan`'s gate reads), *deferred to <rubric>*, or *pending explanation*.

**RV-5 · The change-note template.** *Seen:* `04c-revise-spec:MF`, `05b-revise-spec:MF`, `05f-revise-spec:MF`, `05e-design:MF`. **Edit** (`templates/change-request.md`): header (kind, `main @`, spec version from and to), *Items* (with outcome), *Changes to the spec*, *Carried to design* (each item linked to its source, L3), *STALE* (quoted sentences), *Open*, *Owed by other skills*.

**RV-6 · Who touches up a carried output.** *Seen:* `05b-revise-spec:1`. **Edit:** the change note names the touch-up (`eval-plan --touch-up`, `journeys update`, the design step) and its order in `STATE.md`'s next steps.

**RV-7 · Its inputs.** *Seen:* `05b-revise-spec:4`, `05f-revise-spec:2`. **Edit** (*Reads*): every `STATE.md` block since the last `revise`, and the sections their items cite. Items come from the cited sections, not from `STATE.md`'s summary of them.

**RV-8 · Items an earlier phase decided.** *Seen:* `05f-revise-spec:4`, `03b-journeys:MF`. **Edit:** an [F] decision from an earlier phase is accepted by default. It is still scanned for an open sub-question. A spec assumption confirmed downstream is written into the spec at the next `revise`.

**RV-9 · A new language or audience (L8).** *Seen:* `05-ux-review:3`. **Edit** (*Writes*): L8 as drafted. Next steps are `personas add`, then `journeys update`, before any design pass or review.

**RV-10 · Catching up the canon after a build.** *Seen:* `10b2-revise-spec:1`, `08e-ci-deploy-change:9`. **Edit:** a `revise --catch-up <notes>` mode. Its writes are the files that change notes' *What this makes stale* names (spec, plan, config, design README, code repo `CLAUDE.md`), each with the founder's acceptance and listed in its note. Pushing a deploy-on-push repo asks first (S0-10).

**RV-11 · Closing what it settles.** *Seen:* `10b2-revise-spec:2`. **Edit:** `revise` strikes open-work rows it settled, citing its change note (M-5).

*No edit:* `05f-revise-spec:1` is DS-8. `05f-revise-spec:3` is JO-2.

### `close-out`

**CO-1 · The gate override.** *Seen:* `10b-close-out:1`, `10b-close-out:MF`. **Edit:** S0-1's override, recorded in `09-close-out.md`'s header.

**CO-2 · Closed, with evaluation owed.** *Seen:* `10b-close-out:2`, `10b-close-out:3`, `10b-close-out:4`. **Edit:** close-out separates *closed* from *launch-ready* and from *evaluated*. It writes `closed · eval <date>` (M-6), records launch's date or "not yet", and creates the later checks' reminders from launch (EV-2). When an evaluation that matures later is finally read, `close-out --eval` appends the result and clears the cell.

**CO-3 · Stage records it can't reach.** *Seen:* `10b-close-out:5`. **Edit** (*Reads*): inject each stage record's *decided* and *owed* sections. If the code repo isn't reachable (S0-8), use the plan's changelog and open-work, and say so.

**CO-4 · Cost.** *Seen:* `10b-close-out:6`, `10b-close-out:7`, `04b-design-import:7`. **Edit:** cost is measured in dollars from `/usage`, plus the session-limit share where it is shown. Each log's *Cost* says whether the figure is exact or estimated, and which log carries a shared session's figure. Steps run outside Claude Code read the limit percentage at start and end. Drop "share of weekly limits" unless the founder records it.

**CO-5 · Canon for a project outside Root.** *Seen:* `10b-close-out:8`. **Edit:** `config.md` names the project's canon (for IMNSTR: the spec, plan, design README and `CLAUDE.md`). Close-out applies the canon-sync flags there, through `revise --catch-up` (RV-10) when the files are design-side.

---

## 9. The trial brief

These change the next trial's brief, not the method.

**TR-1 · Hashes in a log's *Output*.** *Seen:* `00-intake:4`. **Edit:** "the commit's hash, or 'this commit' for the commit that holds the log".

**TR-2 · Rows the table lacks.** *Seen:* `04b-design-import:1`, `05e-design-import:5`, `08e-ci-deploy-change:1`, `09b-polish-change:1`, `10a-consolidate:10`, `10a-consolidate:11`. **Edit:**
- a row for each design import, with its outputs;
- *8x Change during the build*, as 08e's log drafted it, naming both sources (the founder, or review findings the founder accepted);
- 10a and the integration runs listed among the steps without a column;
- the *Don't* cells of 10a and 10c say plainly that the founder's accepted edits are applied in a session after 10c.

**TR-3 · Step names.** *Seen:* `05d-journeys-gap:6`, `08e-ci-deploy-change:2`, `09b-polish-change:1`. **Edit:** one style (`05d`, never `4d`). Changes are `8x-<slug>`. The opening prompt names the skill as well as the step.

**TR-4 · Write rules.** *Seen:* `08c-B2-verify:5`, `08c-B1-verify:5`. **Edit** (rule 4): add the code repo's files that a step's row names, and say that verify's inbox note goes in the log's *Lessons*.

**TR-5 · Already applied.** *Seen:* `04-wireframes:10`, `04b-design:9`, `archive pass2-opus:2`, `03b-journeys:10`, `01-research:2`, `04b-design:2`, `04b-design:3`. *As-built:* the trial README 0.4 and 0.5 cover pulling first, the branch in the prompt, the model check, rule 9 (redo and log naming), rule 10 (no pruning) and the 4b output. No edit.

---

## 10. Missing foundation, consolidated

Every *Missing foundation* line falls into one of these rows. Counts are the number of logs that named the gap.

| ID | What's missing | Logs | What stood in | Proposed |
|---|---|---|---|---|
| F-1 | `bin/gate` (with fetch, step check, override, HTML headings, AC diff) | 32 | gating by hand | stage 1 of the rollout, specified by S0-1 |
| F-2 | `templates/` and `required-headings.txt`: intake, research, spec, persona record, journeys, wireframe frame kit, change request, change note, eval plan, build plan, card, lane report, design README, import checklist, review, close-out, project config | 22 | the house shape of earlier outputs | stage 1. Each template's headings are in this file's findings (SP-1, PE-3, JO-3, WF-6, RV-5, SP-8, BF-3, BL-1, DS-3, DS-8, UX-6, PC-1) and in each log's *Template sample* |
| F-3 | `learnings/inbox/` and `index.md` | 7 | each log's *Lessons* | stage 1, with LE-1's capture template |
| F-4 | A module decision log; the house decision-log format | 4 | `lifecycle/decision-log.md` | DR-1, DR-2 |
| F-5 | An archive convention for redone phases | 3 | `trial-run/archive/<step>/passN-<model>/` | S0-3; *as-built* in trial rule 9 |
| F-6 | Project config pieces: checkouts per machine, founder devices, heavy-runner lock, Change branches and slots, review port, server runbook, CI access, disk check, P0 status, code repo path on Linux | 16 | cards, `STATE.md`, asking | PC-6, PC-7, PC-8, BF-5 |
| F-7 | Review and check scripts | 7 | throwaway scripts, deleted | PC-9 |
| F-8 | A design plate index; caption markers; measured contrast | 6 | slicing the export with Node; a one-line contrast script | DS-8 |
| F-9 | Founder-supplied content: copy, marks, channels, production content for checks | 3 | placeholders | M-8 |
| F-10 | Milestone states and one by-hand list | 2 | "suites green, not closed" in prose | VM-2, VM-5 |
| F-11 | Status values for closed-with-eval and overrides | 1 | `closed · eval due` | M-6, CO-2 |
| F-12 | Tools on the machine: reduced-motion emulation, an image zoom tool, shellcheck, a running Docker, `gh` or a signed-in API, a network allowlist for reference hosts, safe Markdown writing | 6 | source reading, `deviceScaleFactor: 4`, CI, anonymous API, mirrors, Write tool | the founder's machine setup; L30, L31 and L33 to the memory and `brief-common` template; the allowlist (w3.org, owasp.org, PubMed, university repositories) to the founder |
| F-13 | A cross-project engineering checklist | 1 | 10a §4 | LE-7 |
| F-14 | A reminder for evaluation checks after close-out | 1 | the founder's calendar | EV-2, CO-2 |
| F-15 | A readable list of file owners | 1 | `README.md` §4 prose | M-5 |
| F-16 | The code repo itself, or access to it, at the step that needed it | 5 | founder P0 items; plan changelog and open-work | BF-1, S0-8 |
| F-17 | Shared test helpers in IMNSTR's repo (`expectWithinColumn`, a route-list helper, a refusal-code list) | 4 | local copies | product: IMNSTR open-work, not the method |
| F-18 | Records the plan named as founder facts (the VPS's state, root-app's check URL, aggregator user agents) | 3 | P0-3 commands, change note CD-0, marked guesses | PC-8; the user agents to LE-7 |

---

## 11. 10a's accepted items, placed

| Item | Placed in |
|---|---|
| L1 | S0-2; PC-8 (lock); VE-5 |
| L2 | HO-2 |
| L3 | S0-4; RV-5; DS-8; PC-2 |
| L4 | S0-1; HO-4 |
| L5 | S0-1 |
| L6 | S0-3; `ux-review` reference (a review reads an earlier pass only after writing its own findings) |
| L7 | RV-2 |
| L8 | RV-9; RI-1; `README.md` §2 ordering via RV-9 |
| L9 | M-4 (phase 7); WF-5; UX-6 |
| L10 | RE-1 |
| L11 | RE-2; S0-6 |
| L12 | DS-5 |
| L13 | EV-2; CO-2; M-6 |
| L14 | BP-1; BF-5; S0-5 rule 1 |
| L15 | BF-5; VM-2; PC-8 |
| L16 | BF-6; SP-7; S0-5 rule 2 |
| L17 | BF-8 |
| L18 | BP-6; SP-8; BF-9; PC-8 |
| L19, L20 | BP-2 |
| L21 | BF-2 |
| L22 | BF-11 |
| L23 | BL-1; `brief-common` template, *Git* |
| L24 | VE-10 |
| L25 | VE-6; PC-1 |
| L26 | RI-5; IMNSTR `review-checklist.md` §5; `brief-common` template, *Tests* |
| L27 | `verify` reference: "check a workaround's stated cause before recording it" |
| L28 | UX-9; VM-4 |
| L29 | UX-3; RI-5 |
| L30, L31 | memory `root-app-dev-machine`; `brief-common` template, *Environment* (F-12) |
| L32 | `brief-common` template, *Environment* |
| L33 | PC-8; memory |
| Z-a | S0-5 rule 4; RV-3 |
| Z-b | SP-10; RV-3 |
| Z-c | RV-3; M-2 |
| **Holds (18)** | `00-intake:1` ID-1 · `00-intake:2` ID-3 · `02-spec:2` S0-5 rule 7 · `03a-personas:1` PE-1 · `03b-journeys:1` JO-3 · `03b-journeys:2` JO-2 · `04-wireframes:1` WF-1 · `04b-design-import:1` DS-3 · `04c-revise-spec:3` S0-5 rule 5 · `05d-journeys-gap:1` JO-8 · `05e-design:3` DS-1 (re-read the repo's latest source before editing in the design tool) · `06b-eval-plan-touch-up:1` EV-3 · `07b-project-config:2` PC-4 · `08a-B1-launch:1` BF-1 · `08b-B4b-land:1` BL-1 · `08b-B8-land:1` BL-1 · `08b-CD1-land:1` BL-2 · `08d-MS3-milestone:2` PC-8 (a background suite script judges each suite's exit code) |
| **Product notes (8)** | LE-7, the engineering checklist's seeds |

*Not chosen at 10a:* Z-d, reopening research's cheaper options when the ledger trips. It stays out; see §12.

---

## 12. The founder notes

**Note 1, auth growing like its own project.**
- **Should the lifecycle have flagged it, and who?** Yes, and `revise` is the only gate every addition passed through (*evidence*: spec 0.2–0.4, three `revise` sessions on 2026-10-10, each seeing only its own batch). Nothing held the running total. RV-3's ledger (Z-b) would have tripped at 0.2. Auth went from 4 of 19 criteria at 0.1 (AC-8 to AC-11) to 9 of 42 at 0.2 (adding AC-20 to AC-24), more than doubling. By 0.3 it was about a third (founder note 1), past the quarter threshold. A "still the smallest version?" question at 0.2 is the mechanism.
- **What found the auth gaps** was `journeys new` walking every security requirement (`H:03b-journeys:2`). The finding isn't to walk fewer. It is that each walk's additions land on a counter the founder sees.
- **Would shape D (the editor behind Cloudflare Access) or shape B (files in git) have been enough?** The run can't say. Only shape A was built. What it does show (*evidence*): auth took two of ten planned stages, B4a (the largest diff, +3,875 lines) and B4b (+2,617). The passkey screens couldn't be driven in the app's browser, and needed a virtual-authenticator script at each review (PC-9). Every signed-in live check became a founder item (VE-7). Z-d, which would have put those options back in front of the founder, wasn't chosen. That stands.

**Note 2, the reader record.**
- **How big can an item get before it leaves `revise`?** RV-3's Z-c answers it: new stored data is a capability, so R1–R3 would have gone to `spec change`, with research or a waiver line, instead of being designed inside a revise session.
- **A question answered with a question** is now an outcome (S0-5 rule 4): `revise` proposes a bounded definition, graded *proposal* with what it excludes, and asks again.
- **The pattern across both notes:** the module grew at each phase through the founder's answers, and every item was valid on its own. The method's catch is the ledger, read by `revise`, with Z-a and Z-c as its rules. No skill outside `revise` needs to change for it.

---

## 13. Accounting: every log's items

Each log's *Spec gaps* items are listed by position, then its *Missing foundation* (MF). "none" means the section said none or named nothing new. Items marked *product* are about IMNSTR's code: they live in its stage records or plan, and in LE-7's seeds.

| Log | Spec gaps → finding | MF → finding |
|---|---|---|
| 00-intake | 1 ID-1 · 2 M-1 · 3 HO-1 · 4 TR-1 · 5 ID-2 · 6 ID-3 · 7 M-6 · 8 S0-7 | stub (allowed) · F-2 · PC-5 (config, expected at 7b) |
| 01-research | 1 S0-3 · 2 S0-3, TR-5 · 3 RE-2 · 4 RE-5 · 5 S0-7 | F-2 · F-5 |
| 01-research-integration | 1 RE-1, RE-4, RE-5 · 2 HO-2, HO-3, S0-3 · 3 S0-3 · 4 S0-3 | F-5 · F-2 |
| 02-spec | 1 S0-5 · 2 S0-5 · 3 S0-6 · 4 SP-1 · 5 SP-2 · 6 SP-3 · 7 SP-4, BP-1 | F-2 · F-1 |
| 03a-personas | 1 PE-1 · 2 PE-2 · 3 PE-3 · 4 PE-3, S0-6 · 5 PE-4 · 6 PE-5, S0-1 · 7 PE-5 · 8 PE-6 · 9 DR-1 | stubs (allowed) · F-2 · F-4 |
| 03b-journeys | 1 JO-1 · 2 JO-2 · 3 M-4 · 4 JO-3 · 5 JO-3 · 6 JO-4 · 7 JO-5 · 8 JO-5 · 9 PE-5 · 10 TR-5 · 11 JO-6 | F-2 · F-2 · RV-8 |
| 04-wireframes | 1 WF-1 · 2 WF-2 · 3 WF-3 · 4 WF-4 · 5 WF-5 · 6 WF-5, M-4 · 7 S0-1 · 8 WF-6 · 9 WF-6 · 10 S0-1, TR-5 | F-2 (frame kit) · F-2 |
| 04b-design | 1 DS-1 · 2 TR-5 · 3 TR-5, DS-1 · 4 DS-5 · 5 M-4, RV-8 · 6 M-6 · 7 DS-6 · 8 DS-1 · 9 TR-5 | DS-1 · DS-1 · F-9 · F-9 |
| 04b-design-import | 1 DS-1, TR-2 · 2 DS-2 · 3 DS-3 · 4 DS-3 · 5 DS-4 · 6 DS-3 · 7 CO-4 | DS-3 · DS-2 |
| 04c-revise-spec | 1 RV-1 · 2 RV-2 · 3 M-6 · 4 RV-3 · 5 DR-2 · 6 S0-5, RV-4 · 7 RV-4 | F-4 · RV-5, SP-11 · F-1 |
| 05-ux-review | 1 UX-1 · 2 UX-1, M-4 · 3 RI-1, RV-9 · 4 UX-2 · 5 RI-2 · 6 UX-3 · 7 UX-4 · 8 UX-5, S0-9 · 9 UX-6 · 10 UX-7 | stub (allowed) · F-2 · PE-1 (persona F, chosen at 05c) · F-7 |
| 05b-revise-spec | 1 RV-2, RV-6 · 2 RV-3, S0-5 · 3 RV-4, S0-5 · 4 RV-7 · 5 RV-4 | F-1 · RV-5 · F-4 |
| 05c-personas | 1 PE-5 · 2 PE-5 · 3 PE-3 · 4 no edit (product, L-4) · 5 DR-1 | F-2 (persona template) |
| 05d-journeys-gap | 1 JO-7 · 2 JO-8 · 3 JO-2 · 4 JO-1 · 5 JO-3 · 6 S0-1, TR-3 | F-2 · F-1 (AC diff) |
| 05e-design | 1 DS-7 · 2 DS-7 · 3 S0-7, DS-1 · 4 DS-1 · 5 JO-4 · 6 M-8 | DS-7, RV-5 · F-9 |
| 05e-design-import | 1 DS-2 · 2 DS-2, S0-2 · 3 DS-3 · 4 DS-3 · 5 DS-1, TR-2 | F-12 · F-8 |
| 05f-revise-spec | 1 DS-8 · 2 RV-7 · 3 JO-2 · 4 RV-8 · 5 RV-4 | F-1 · RV-5 · F-4 |
| 06-eval-plan | 1 EV-1 · 2 EV-2, M-6 · 3 EV-2 · 4 S0-5 · 5 SP-3 · 6 S0-2 | F-1 · F-2 · F-14 |
| 06b-eval-plan-touch-up | 1 EV-3 · 2 EV-3 · 3 HO-2 · 4 EV-3 | none |
| 07-build-plan | 1 BP-2 · 2 UX-6, M-4 · 3 BP-3 · 4 M-7 · 5 BP-1 · 6 BP-4 · 7 BP-4 · 8 BP-5 · 9 EV-4 · 10 BP-5 (held) | F-16 · PC-5 · F-1, F-2 · F-18 |
| 07b-project-config | 1 PC-1 · 2 PC-2 · 3 PC-3, M-5 · 4 PC-3 · 5 PC-4 · 6 PC-5, M-5 · 7 PC-6 | created (allowed) · PC-1 · PC-2 · F-16 |
| 08a-B1-launch | 1 BF-1 · 2 BF-1 · 3 BF-2 · 4 BF-3, BP-7 · 5 BF-4 · 6 PC-7 · 7 M-6 | F-16 · F-1 · F-2 |
| 08a-B2-launch | 1 BF-5 · 2 BF-6 · 3 BF-5 · 4 BF-7 · 5 PC-8 | F-1 · BF-5 · PC-4 |
| 08a-B3-launch | 1 BF-3 · 2 PC-7 · 3 BF-11, BF-2 · 4 BF-7 · 5 BP-7 | F-1 · F-2 · PC-7 |
| 08a-B4a-launch | 1 BP-7 · 2 BP-6 · 3 BF-9 · 4 BF-7 · 5 BF-6 · 6 PC-7 | F-1 · BF-3 |
| 08a-B4b-launch | 1 BP-6 · 2 BP-6, PC-8 · 3 BF-7 · 4 S0-1 · 5 PC-7 · 6 BF-1 | F-1 · BF-3 · DS-8 |
| 08a-B5-launch | 1 BP-6, BF-6 · 2 BP-6 · 3 BP-7 · 4 product (LE-7) · 5 BF-7 · 6 DS-8 | F-1 · DS-8 · PC-7 |
| 08a-B6-launch | 1 BF-5, VM-2 · 2 BP-6 · 3 BF-7 · 4 VE-12 · 5 DS-8 | F-1 · DS-8 · PC-7 · PC-8, M-8 |
| 08a-B7-launch | 1 BP-6 · 2 BP-6, BF-6 · 3 VE-12 · 4 BF-7 · 5 DS-8 | F-1 · DS-8 · PC-7 |
| 08a-B8-launch | 1 product (LE-7) · 2 BP-7, product · 3 BP-2 · 4 product (LE-7) · 5 BP-6 · 6 S0-2 · 7 BF-7 | F-1 · PC-7 · F-18 |
| 08a-B9-launch | 1 SP-5, BP-6 · 2 VE-12 · 3 BF-8 · 4 DS-8 · 5 BF-7 | F-1 · DS-8 · DS-8 |
| 08a-CD1-launch | 1 S0-2, PC-8 · 2 M-6 · 3 BF-7 · 4 SP-7 · 5 HO-4, S0-1 · 6 S0-7 | F-1 · PC-8 · PC-6 |
| 08a-PL1-launch | 1 SP-8 · 2 BF-10 · 3 BF-10, SP-8 | F-1 · PC-6 |
| 08b-B1-land | 1 BF-2 · 2 BL-3, S0-10 · 3 BL-1 · 4 BL-1, BP-3 | BL-1 |
| 08b-B2-land | 1 BF-5 · 2 BL-1 | none |
| 08b-B3-land | 1 BF-2 · 2 no edit · 3 BL-2 | none |
| 08b-B4a-land | 1 BL-1, BP-3 · 2 BL-2 | F-1 |
| 08b-B4b-land | 1 BL-2 · 2 BL-1 · 3 HO-3 | F-1 |
| 08b-B5-land | 1 BP-3 · 2 BL-2 · 3 S0-4 | F-1 |
| 08b-B6-land | 1 BF-8 · 2 BP-3 | F-1 |
| 08b-B7-land | 1 BF-8, VE-12 · 2 no edit · 3 BP-3 | F-1 |
| 08b-B8-land | 1 BL-1 | F-1 |
| 08b-B9-land | 1 BF-8 · 2 RI-5 · 3 BF-9 | F-1 |
| 08b-CD1-land | 1 BL-2 · 2 SP-8 · 3 BL-1 | none |
| 08b-PL1-land | 1 BF-8 · 2 SP-7 · 3 product (verify decided) | none |
| 08c-B1-verify | 1 VE-1, M-5 · 2 VE-2 · 3 VE-3 · 4 VE-4 · 5 TR-4 · 6 VE-5, S0-10 · 7 RI-5 · 8 PC-3, M-5 · 9 VE-6 | F-3 · F-1 · BF-1 |
| 08c-B2-verify | 1 VE-5 · 2 VE-6 · 3 S0-9 · 4 VE-14 · 5 TR-4 · 6 VE-9 | F-3 · PC-8 · PC-3 |
| 08c-B3-verify | 1 VE-2 · 2 VE-6 · 3 VE-11, S0-10 · 4 VE-6 · 5 VE-4 · 6 L31 (F-12) | F-3 · F-1 · PC-9 · PC-6 |
| 08c-B4a-verify | 1 HO-4, S0-1 · 2 VE-6 · 3 VE-6 · 4 VE-6, BF-9 · 5 S0-5 | F-3 · PC-9 · PC-3 |
| 08c-B4b-verify | 1 S0-7, S0-1 · 2 VE-8 · 3 PC-9 · 4 BL-2 | PC-8 (disk) · PC-9 |
| 08c-B5-verify | 1 VE-7 · 2 RI-5 · 3 S0-7 (data point) | F-12 · PC-9 |
| 08c-B6-verify | 1 VE-5, S0-10 · 2 RI-5 · 3 product (LE-7) · 4 PC-9 | VE-5 · F-17 |
| 08c-B7-verify | 1 BF-8 · 2 BP-6, product · 3 PC-9 · 4 PC-9 | VE-5 · F-17 |
| 08c-B8-verify | 1 VE-7 · 2 VE-7, S0-10 · 3 VE-9 · 4 *as-built* (`brief-common`, checklist rule 7) | VE-7 · F-17 |
| 08c-B9-verify | 1 VE-10 · 2 product (LE-7) · 3 VE-10 · 4 PC-9 | F-12 (L30) · VE-5 |
| 08c-CD1-verify | 1 VE-5 · 2 PC-8 · 3 VE-5, S0-2 · 4 S0-2 · 5 M-6 | F-12 (`gh`) · F-12 (Docker) |
| 08c-PL1-verify | 1 VE-13 · 2 PC-8 · 3 VE-10 · 4 VE-10, product (LE-7) · 5 PC-9 | PC-9 · F-3 |
| 08d-MS2-milestone | 1 VM-1 · 2 *as-built* (repo) · 3 VM-2 · 4 VM-3 · 5 S0-10, VE-5 | *as-built* · PC-8, M-8 |
| 08d-MS3-milestone | 1 VM-2 · 2 VM-4 · 3 VM-4 · 4 M-6 | F-10 · VM-4 |
| 08d-MS4-milestone | 1 VM-5 · 2 VM-5, M-8 · 3 VM-2, UX-8 | F-10 · F-9 |
| 08e-ci-deploy-change | 1 TR-2, M-2 · 2 TR-3 · 3 SP-6 · 4 S0-5 · 5 PC-6 · 6 M-7, SP-9 · 7 SP-8 · 8 SP-8 · 9 SP-10, RV-10 · 10 M-6 · 11 SP-11 · 12 SP-6 | F-2 · F-1 · F-18 |
| 08f-CS1-change | 1 M-2 · 2 DB-1 · 3 BF-8 | none |
| 09b-polish-change | 1 TR-2, TR-3 · 2 SP-9 · 3 SP-10 · 4 SP-7, S0-5 · 5 SP-8 · 6 M-7, PC-6 · 7 SP-9, UX-6 | F-2 · F-1 · F-17 |
| 09-live-review | 1 UX-9 · 2 UX-9 · 3 RI-3, M-7 · 4 RI-4, S0-6 · 5 DE-1 · 6 UX-8, M-4 · 7 UX-10 · 8 UX-5 · 9 UX-11 | PC-9 · PC-6 · F-12 |
| 10a-consolidate | 1 LE-1 · 2 LE-2, ST-1 · 3 LE-3 · 4 LE-4 · 5 LE-5 · 6 LE-6 · 7 LE-7 · 8 LE-8 · 9 LE-9, S0-5 · 10 TR-2 · 11 TR-2, M-6 | F-3 · F-2 · F-13 |
| 10a-consolidate-proposal | not a session log: no *Spec gaps* or *Missing foundation* sections; its items are placed in §11 | — |
| 10b2-revise-spec | 1 RV-10, M-5 · 2 RV-11, M-5 · 3 SP-10, M-4 · 4 M-6 · 5 S0-8, S0-10 · 6 S0-4 | F-1 · F-15 · F-16, PC-7 |
| 10b3-eval-plan-touch-up | 1 RV-2 · 2 EV-3 · 3 EV-3 · 4 HO-3 | none |
| 10b4-journeys-gap | 1 RV-2 · 2 JO-7, M-6 · 3 JO-7 · 4 JO-9 | none |
| 10b-close-out | 1 CO-1, S0-1 · 2 CO-2, M-6 · 3 CO-2 · 4 M-3, CO-2 · 5 CO-3, S0-8 · 6 CO-4 · 7 CO-4 · 8 CO-5 | F-16 · F-1, F-11 · F-3 |
| archive pass1-sonnet | 1 S0-1 · 2 RE-3 · 3 RE-2 · 4 RE-4 · 5 S0-7 · 6 RE-2 | none |
| archive pass2-opus | 1 S0-3 · 2 S0-7, TR-5 · 3 RE-2 · 4 S0-6 · 5 RE-4 · 6 RE-5 | F-12 (allowlist) |
| archive pass3-opus-fresh | 1–5 as `01-research` 1–5 | as `01-research` |

---

## Decisions

*The founder's answers, 2026-10-19. Groups 1–4 were accepted through the question tool. The founder then said they had been accepting without reading, because the summaries were hard to follow without context, and accepted all 15 groups on Claude's judgement. **So every group is accepted, but none has been reviewed by the founder.** The apply session shows each group's actual edit (the diff), so the founder can read the change itself rather than a summary, and refuse any of it then.*

*Three accepted items have lasting effects beyond wording. The apply session raises them on their own:*
- *DR-2 moves L-2, L-3, L-5 and L-6 out of `lifecycle/decision-log.md` into an IMNSTR decisions file.*
- *M-2 makes the 'small Change', with build, verify and deploy in one session, an allowed exception to one phase per session.*
- *LE-2 adds a consolidation session at each milestone of a build.*

| Group | Findings | Decision |
|---|---|---|
| Method `README.md` | M-1 to M-8 | **Accepted**, on Claude's judgement (not read) |
| Shared mechanics | S0-1 to S0-10 | **Accepted**, on Claude's judgement (not read) |
| Every-session skills | ST-1, HO-1 to HO-4, DR-1, DR-2, LE-1 to LE-9 | **Accepted**, on Claude's judgement (not read) |
| `ideate`, `research`, `personas` | ID-1 to ID-3, RE-1 to RE-5, PE-1 to PE-6 | **Accepted**, on Claude's judgement (not read) |
| `spec` | SP-1 to SP-11 | **Accepted**, on Claude's judgement (not read) |
| `journeys`, `wireframes` | JO-1 to JO-9, WF-1 to WF-6 | **Accepted**, on Claude's judgement (not read) |
| The design step | DS-1 to DS-8 | **Accepted**, on Claude's judgement (not read) |
| `eval-plan`, `build-plan` | EV-1 to EV-4, BP-1 to BP-7 | **Accepted**, on Claude's judgement (not read) |
| Project config | PC-1 to PC-9 | **Accepted**, on Claude's judgement (not read) |
| `build-phase`, `debug` | BF-1 to BF-11, BL-1 to BL-3, DB-1 | **Accepted**, on Claude's judgement (not read) |
| `verify` | VE-1 to VE-14, VM-1 to VM-5 | **Accepted**, on Claude's judgement (not read) |
| Reviews | UX-1 to UX-11, RI-1 to RI-5, DE-1 | **Accepted**, on Claude's judgement (not read) |
| `revise`, `close-out` | RV-1 to RV-11, CO-1 to CO-5 | **Accepted**, on Claude's judgement (not read) |
| Trial brief | TR-1 to TR-5 | **Accepted**, on Claude's judgement (not read) |
| Foundation list | F-1 to F-18 | **Accepted**, on Claude's judgement (not read) |

## Changelog

- **0.2 · 2026-10-19** — The founder's decisions: all groups accepted. All 15 were accepted on Claude's judgement, without the founder reading them. Three items are flagged for the apply session.
- **0.1 · 2026-10-19** — First version, from 76 logs, 10a's decisions and `founder-notes.md`.
