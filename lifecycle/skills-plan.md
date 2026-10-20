# Lifecycle — the skills, specified

*Each of the twenty lifecycle skills, and the design step: what it does, how it is invoked, which model runs it, exactly what it reads and writes, its gate, and where its shape comes from. The method these skills implement is `README.md`.*

**Version 0.12 · Status: plan — nothing here is built yet · 2026-10-20 · Owner: _root**

---

## Summary

Twenty skills in four groups — every session, design, build, closing the loop — sharing one gate script, one set of templates and one configuration folder per project. Most are invoked by name only, so they cost nothing per turn until used. Reviews run forked, in a fresh context. Lanes are launched by `build-phase` with the project's common brief plus a committed phase card, and return a seven-part report that `verify` reads before the diff. What sessions learn about working is captured as notes and integrated in batches, never edited in place. Each spec below names its source in this repo, so the skill is a transcription of what already worked, not an invention.

**Grading.** Mechanics claimed for Claude Code skills (frontmatter fields, forking, injection, skill discovery) are **documented** — read from the Claude Code skills documentation on 2026-10-05. Anything marked **verify in stage N** is a reading of that documentation not yet tried here.

## 0. Shared mechanics

**Invocation.** Every skill is `disable-model-invocation: true`, invoked by name and invisible in context until then, except `debug`, which Claude may pick up when a test fails.

**Model and effort** are set in each skill's frontmatter (`model`, `effort`). A session sees its model but not its effort, so every skill's first message states the model from its frontmatter. On the wrong model, the skill stops before any work. If the prompt states a different effort, the skill says so and continues.

**Forking.** `verify`, `ux-review` and `design-review` use `context: fork` with `background: false`: an isolated subagent that sees only the skill and its injected inputs, with the full tool set, and returns a short summary. *Verify in stage 2* that such a fork can edit, commit and run suites. A fork can't wait on the founder, so `verify` ends at "ready to deploy" and the deploy runs in the main session. A forked review gets the change notes' *carried* lists and the open-work file's rows injected, so owed items aren't counted as defects.

**Injection.** Skills pull their inputs with `!` commands at invocation (the gate result, the status row, the top of `STATE.md`, a diff stat), so the model doesn't spend turns fetching them. A skill that touches a code repo injects its path from `config.md` and a `git -C <path> rev-parse HEAD` line. If the repo isn't reachable, the skill names its fallback (the plan's changelog and the open-work file) or asks.

**The gate.** `lifecycle/bin/gate <module> <phase>` fetches first, then checks that the phase's inputs exist, hold the headings in `templates/required-headings.txt` (`<h2>` text for HTML), and aren't marked `STALE` in `status.md`. It prints `GATE OK` or `GATE FAIL` with what is missing, and the skill stops and says so. A branch behind its upstream fails; `n/a` and a config value of `none` pass. For column 3 it reads the `## Personas` table in `03-journeys.md`; for journeys and change notes it diffs the spec's criterion ids against the *Coverage* table. It **always exits 0**, because a failing injected command aborts the skill before Claude sees it (documented). Skills call it through `${CLAUDE_SKILL_DIR}`, since injected commands run in the current directory, which may be a code repo. `--override "<reason>"` prints `GATE OVERRIDDEN`, and the skill writes the reason into its output's header.

**The step comes from the files** (`briefs/<stage>.md`, `<stage>.report.md`, the status row, `STATE.md`'s next step), not from the prompt. If the prompt names another or an unknown step, the skill says so, lists near matches and stops.

**Where the skills live until the plugin (stage 6):** `root-sot/.claude/skills/`. A session in a code repo adds `root-sot` with `--add-dir` or `/add-dir`, which loads its skills (documented). *Verify in stage 1* how cloud sessions with several repositories expose them; if they don't, copy the build-side skills into each code repo until stage 6.

**Skills don't call skills** (not documented). Two skills that need one checklist load the same reference file; a skill that needs a sequence ends by naming the next one.

**Reference seeds.** Where a skill's section names `skills/<skill>/reference.md`, that file holds seeds for the skill's reference file and template. They bind as this plan does. The skill's first author places them. Rules every skill shares but rarely needs, such as redoing a phase, are in `skills/shared/reference.md`.

**Parallel sessions** on one branch or one machine commit by path (`git commit --only <paths>`) or from their own checkout; fetch and rebase right before pushing; merge `STATE.md` by block, newest first, never by copying over it; and take the heavy-runner lock named in `config.md` before running a suite.

**References.** Anything named for another session is named by its committed path relative to the repo: never by number alone, never by a machine path. Journey steps, criteria and findings are cited by the id copied from the file (`J3.4`, not "J2 step 4"). An open-work number is cited with its file.

**Grades.** Every claim in an output is graded:
- *evidence*: from a source or an observed event, with a strength: *strong*, *moderate*, *thin*, or *summary only* (from a search summary, never quoted);
- *as-built*: true of what exists now, citing the file;
- *proposal*: Claude's suggestion;
- **decision**: the founder's, dated, written [F].

**Asking the founder.** Every skill that asks:
1. Asks in one batch, at most four questions per call; two calls in one turn are one batch. Facts the founder must look up go in a pre-flight list, not the batch.
2. Reads enough of the code and files to word each option truthfully first.
3. Puts what the founder needs to answer inside the question or the closing message, never in text just above the question box. Commands for the founder go in the closing message.
4. Treats an answer that adds a requirement, contradicts the spec or is itself a question as a new item: sizes it, proposes a bounded definition graded *proposal* with what it excludes, and asks again. It is never written downstream as accepted.
5. When the founder defers to a skill or rubric, applies it and names it in the output. *Explain more* leaves the item pending for a second round.
6. Ends by asking acceptance of its open assumptions, if it asked at the start.

**Outward-facing and destructive actions.** Pushing to a repo whose `main` deploys, pushing a branch to a public remote, posting to an outside service, and any destructive step on production need the founder's yes in this session. A skill never runs a destructive production step: it lists it for the founder. If the permission layer blocks an approved push, the skill ends with "push pending: founder" and doesn't look for another route.

**Per-project configuration** lives in `lifecycle/projects/<project>/`, written by `project-config` (§2); `skills/project-config/reference.md` lists each file's contents:
- `brief-common.md`: what every lane gets, naming checkouts by `config.md`'s names, never one machine's path;
- `review-checklist.md`: what every review checks;
- `config.md`: paths, files, suites, lanes, environment and review scripts.

A project with no code yet has its config written as planned. The first stage's `verify` reconciles it with the founder's yes, and any verify that receives founder facts folds them into `config.md`.

---

## 1. Every session

### `lifecycle-status`
**Does:** shows where things stand and what comes next; sorts new work into a track.
**Invocation:** by name, optional module or a one-line description of new work · **Model:** Sonnet, low.
**Reads (injected):** `status.md`; `git status -sb`; the top block of the module's `STATE.md` if a module is named; the count and age of notes in `lifecycle/learnings/inbox/`; the *From the founder* rows of the project's open-work file.
**Writes:** nothing.
**Output:** in chat, under 15 lines: the track; the module's phase, read with the status values in `README.md` §3; what is missing or stale; the next skill and its model; the founder's rows due within the next step; "inbox over cap: N notes, oldest <date> — run `learned --consolidate`" when it is.
**From:** Spec Kit's phase order.

### `handoff`
**Does:** ends a session by writing state a fresh session can start from.
**Invocation:** by name, at the end of a session · **Model:** Sonnet, low.
**Reads:** the session's own work; `git log` since the last state block.
**Writes:** a new block, at most 40 lines, at the top of the module's `STATE.md` (or `lifecycle/STATE.md`), committed, in the format in `skills/handoff/reference.md`. Live next steps are copied forward in full, each as the line the founder pastes. Blocks older than the last five are deleted; stage records hold the history.
**Ends with:** "Run `/learned`, then `/clear`, then paste:" and the block's first next step in a fenced block (`README.md` §5 rule 8).
**From:** the journeys orchestrator's state log, which carried the build across three compactions.

### `decision-record`
**Does:** adds a decision to the right decision log in house format.
**Invocation:** by name, any phase · **Model:** Sonnet, low.
**Reads (injected):** the last three entry headers of the target log (`grep`), for the next ID and the format. Never the whole log.
**Writes:** one entry; the log's version line.
**Which log:** `lifecycle/decision-log.md` holds decisions about the method only. A module's product decisions live in its change notes, with one line each in `<module>/decisions.md`.
**Reference:** `skills/decision-record/reference.md`.
**From:** `tracker/decisions/decision-log.md`, `ecosystem/decisions/`.

### `learned`
**Does:** captures what a session learned about *working* (the environment, the method, a skill, a model's habits), not the product, which belongs in stage records and specs. Only `--consolidate` changes anything.

**Capture.** By name, at the end of a session, after `handoff` · **Model:** the session's own, low effort · **never forked**, since the session it reviews exists only in this context.
- **Writes** one file, `lifecycle/learnings/inbox/<date>-<slug>.md`, holding **zero to three** notes in the fixed fields of `skills/learned/reference.md`. Zero is a valid result; filler is not. It doesn't deduplicate: a lesson recurring across notes is the evidence consolidation needs.
- **Rejects** notes that cite no specific event, wouldn't change a future action, or couldn't be checked later.
- **Urgent notes** are also copied into `STATE.md` as a carry-over, so the next session reads them.
- **Ends with** "`/clear`, then paste:" and the first next step of the top `STATE.md` block again, so it is the last thing on screen.

**`--consolidate`.** When the inbox passes **15 notes or 14 days**, at each milestone during a build, and before any `close-out` · **Model:** Opus, high, in a session of its own.
**Reads:** every inbox note; `lifecycle/learnings/index.md`; each candidate destination's line count and headings. Injected: each destination's `## Changelog` lines and the memory index, to find what is already integrated. A module's `founder-notes.md`: each note is a cluster of its own, with mechanisms offered as options.
**Does:**
1. Cluster the notes by lesson; count recurrences by session.
2. Decide each cluster: **integrate** (two or more sessions, or once at high cost) · **hold** (once, cheap; stays in the inbox) · **discard** (already integrated, obsolete, or not specific).
3. Draft each integration's exact edit at its destination, from the table in `skills/learned/reference.md`. A destination that doesn't exist yet gets the rule and its name.
4. Present the batch as one proposal, then ask in groups of at most four: one plain sentence per item, with its event, inside the question. The founder accepts, edits or rejects each.
5. Apply the accepted edits; one `decision-log.md` entry per integration; add each to `index.md`; delete the processed notes; commit.
6. At a module's last consolidation, holds become seeds for their destination's reference file.

**Owns:** the inbox and `index.md`. Founder-owned files (templates, project configs, this plan) change only through step 4's acceptance.
**From:** the journeys build's state log, whose lessons were its most valuable lines and lived on one machine.

## 2. Design

### `ideate`
**Does:** turns an idea into a one-page intake and opens the module.
**Model:** Sonnet, medium.
**Asks:** problem; pillar and place on the opportunity tree (`ecosystem/ost.md`), or "n/a, outside Root" with a reason; who it is for; smallest version worth trying; what would make us drop it. The drop rule is recorded verbatim; if it isn't testable, the intake says so for `spec` and `eval-plan`.
**Writes:** the module folder, `00-intake.md` (one page, no sources), `STATE.md`, the `status.md` row. The intake ends with *Decisions at intake*: the track, research or a waiver line, the code repo, which phases apply (UI or not), and the project.
**Gate:** none.
**From:** Spec Kit's idea-assessment intake.

### `research`
**Does:** a research brief, checked against what Root already knows.
**Model:** Opus, high.
**Reads:** the intake; `ecosystem/canon/04-research/00-evidence-summary.md` first, so known evidence isn't re-researched; the code it concerns, by section.
**Writes:** `01-research.md`: a five-line summary on top; graded claims; sources; at most ~2,500 words before sources. A required *For the next phases* names the options by noun and lists the questions for `spec`.
**Reference:** `skills/research/reference.md`.
**Gate:** intake.
**From:** the grading blocks in the journeys documents and the lifecycle spec.

### `personas`
**Does:** selects which registered personas a module serves; rarely, proposes a new one.
**Model:** Sonnet, medium.
**Modes:** select (before journeys) · `add` (after journeys exist, when a language or audience is added).
**Reads:** `personas.md`; the intake; the spec's interface section, when proposing.
**Does:** selects from the registry; the selection may be empty. When none fits, it proposes one per intake audience, defined by behaviour, and asks the founder to accept before writing the registry. A proposed persona goes into `personas.md` marked *hypothesis*, with a decision-log entry.
**Writes:** the selection as `## Personas` (persona, serves, why, anchors) in the module's `03-journeys.md`, creating the file. `personas` owns that section; `journeys` never edits it.
**Rules:** never redefines an existing persona, since review scores depend on them being fixed. A module's owner may be a persona; their real judgement stays the founder's.
**Reference:** `skills/personas/reference.md`.
**From:** `tracker/canon/05-reviews/00-persona-review-method.md` §2.

### `spec`
**Does:** the spec, or a change note against an existing one.
**Modes:** `full` (Module) · `change` (Change track: a note in the module's `changes/`, or a new folder for a module that predates this system).
**Model:** Opus, high.
**Asks first:** up to eight clarifying questions in one batch (§0).
**Writes:** `02-spec.md` in the house template. Journey-level criteria belong to `03-journeys.md`.
- **Metrics:** the spec defines measures; the eval plan owns instruments and rules. A refinement there goes to `revise` as an item.
- **The platform:** a stack implication is named as a risk; `build-plan`'s foundation batch decides it.
- **Scope ledger:** the header counts acceptance criteria by area at each version, against the intake, so growth is visible (`revise` reads it).

**In `change` mode:** `changes/NN-change-<slug>.md`, in the shape in `skills/spec/reference.md`: what changes and why, criteria, what must not break, and a **Stages** section that `build-phase` and `verify` read in place of a build plan. A change too large to stage there is a Module. It ends with *What this makes stale*. `changes/` has one numbering for both kinds: `NN-change-` from `spec change`, `NN-req-` from `revise`.
**Gate:** research, or a waiver line in the intake (`full`). In `change` mode, the lanes in flight are injected, and the skill refuses while a lane touches the same files.
**Reference:** `skills/spec/reference.md`.
**From:** `tracker/canon/06-specs/04-verification-lab.md`; Superpowers' brainstorming questions.

### `journeys`
**Does:** the paths people take.
**Modes:**
- `new`: 3–5 journeys (first day, normal loop, return after a gap, not enough data, error) of ~10 steps each, about 3,000–4,000 words as a guide;
- `gap`: each scenario checked against the code as *have / partly / missing*;
- `update`: brought up to a newer spec and new personas, from the change notes since its version.

`gap` and `update` may be scoped (`--steps J2.9,J3.4` or `--from-note 07`); the changelog says what wasn't checked.
**Model:** Opus, high.
**Asks:** in every mode, one batch, recorded in *Decisions taken at journeys*.
**Writes:** `03-journeys.md`, below `## Personas`, in the shape in `skills/journeys/reference.md`. Three parts other skills read:
- **`## Coverage`** (required): each acceptance criterion to its step, `no screen` or `all steps`;
- **Suggested:** requirements the spec lacks, including founder decisions made here, for `revise`;
- **a states table** (empty, error, loading, not enough data, notices), for `wireframes`.

Amending keeps step numbers, so citations downstream still hold.
**Gate:** spec; the `## Personas` table.
**Reference:** `skills/journeys/reference.md`.
**From:** `ecosystem/working/root-studio-user-journeys.md` (the `gap` mode); `ecosystem/working/impact-build/01-noticing-spec.md` (the `new` mode); bug B-14 as the case it exists to catch.

### `wireframes`
**Does:** low-fidelity HTML for every journey step and state.
**Model:** Opus, medium.
**Steps:** gate; list the steps and states from the journeys; group them by screen; draw by screen; write *Calls made here*; write the coverage plate (every journey step to its frame, or "no screen" with a note); render at 1200 and 375 px, and look.
**Low fidelity:** neutral tokens, real copy only where the words are the requirement, no brand; the frame kit is `templates/wireframes.html`. Suggested items are drawn as visibly marked options, never as plain UI.
**Writes:** `04-wireframes.html`, with a required *Calls made here*: behaviour the wireframes decided, graded *proposal*, which `ux-review` and `build-plan`'s gate read.
**Gate:** journeys.
**From:** the `*-wireframes.html` files in `tracker/canon/06-specs/`.

### The design step (4b), and its import
**Does:** turns the wireframes into a designed, self-contained site the build draws from. The founder runs it in a design tool; an import session brings it into the repo.
**Inputs:** spec §4 and §6; the journeys' states table; the wireframes' coverage plate. A second pass also reads the change notes' *Carried to design* lists and any earlier design review.
**How much to draw:** phone for every screen and state; desktop for public pages and the main editor. Gaps are listed in the README.
**Output:** `04b-design/`: self-contained HTML exports plus `source/`, edited in place, and a README in the template in `skills/design-step/reference.md`.
**The import** (Opus, medium) copies the files from `../repo-handoff-<step>/`, where a design tool that can't push leaves them, at their repo paths. It has its own log and `STATE.md` block, merges `STATE.md` by block, and works through the checklist in the reference file.
**Status:** shares column 4. An owed pass is written `done · owed 4b`.
**Reference:** `skills/design-step/reference.md`.
**From:** the IMNSTR trial's steps 4b, 05e and their imports.

### `eval-plan`
**Does:** how we will know the module works for people, with the decision rule written before any data and the ambiguous outcome named.
**Modes:** full · `--touch-up <change note>` (Opus, medium).
**Model:** Opus, high.
**Steps:** the failures that look alike; the instruments; the rule, before any data; cost; limits.
**Asks:** the founder about consequences: what "drop" means, and what happens after the last check.
**Writes:** `06-eval-plan.md`. It separates what `close-out` can judge from what matures after it, counted from launch, and names who runs the later checks. Each instrument names its preconditions (a device, the domain, real data), which `build-plan` places in the stage order.
**Gate:** spec; for a touch-up, a spec newer than the plan's input version.
**Touch-up:** fixes what the change note makes contradict the spec or makes wrong in an instrument. Decision rules change only on the founder's word.
**From:** `ecosystem/working/impact-build/03-spine-evaluation.md`.

### `build-plan`
**Does:** the plan a build is run from.
**Model:** Opus, high.
**Reads:** spec, journeys, wireframes, UX review, eval plan; `projects/<project>/`; injected: `README.md` §6–§7. Then **the defect pass**: the code and infrastructure the build will touch or share, read before planning; for a project with no code, the inputs, for contradictions and leaks.
**Step 1, the foundation batch:** when `projects/<project>/` doesn't exist, ask the founder's facts in one batch before drafting (repo, host, stack, domain, server, devices). Answers go in the plan's §4.
**Writes:** `07-build-plan.md`, §0–§10 as in the template in `skills/build-plan/reference.md`. Each stage in §5 has a **size (S/M/L)** and its **traps**. Never two parallel lanes on shared schema.
**Last step, before commit:** each §6 catalogue row agrees with its §5 section; planning decisions don't contradict each other or the house rules; every open call is listed in §10 as left to the card.
**Gate:** as `README.md` §2, phase 7.
**Rule:** the session ends once the plan is pushed. The build starts fresh.
**Reference:** `skills/build-plan/reference.md`.
**From:** `ecosystem/working/root-studio-journeys-build-plan.md`.

### `project-config`
**Does:** creates a project's configuration folder.
**Invocation:** by name, once per project, after its first build plan · **Model:** Opus, medium.
**Reads:** the build plan (§0.3 for house rules, §4 for the founder's facts); the latest retrospective; `templates/brief-common.example.md`; anything the founder supplies.
**Writes:** `brief-common.md`, `review-checklist.md` and `config.md`, as `skills/project-config/reference.md` lists. The founder accepts before commit.
**Gate:** build plan.
**From:** the IMNSTR trial's step 7b.

## 3. Build

### `build-phase`
**Does:** launches a stage as a lane, or lands one.
**Invocation:** `build-phase <stage>` to launch · `build-phase <stage> --land` after the lane reports. On the Change track, `<stage>` names a change note's stage (`changes/NN-change-<slug>.md#<stage>`).
**Gate:** the build plan, or a change note with a Stages section.
**Model:** Opus, medium (it drafts the card; the lane is Sonnet).
**Launch:**
1. Run the gate. Check `STATE.md`: at most two lanes in flight, none other on shared schema. Check the code checkout exists; clone it if not.
2. **Facts first:** the plan's §4 items the stage needs, done or open. Ask the open ones in one question, with the environment preconditions (Docker, the founder's devices today), and list every by-hand check that names the stage. An infrastructure stage's card waits for the answers.
3. **Check the plan against the code:** the stage's files against the tree, its screens against the plate, the migration for each table it writes, a change note against `main` since its `main @`. **Grep the tests** for everything the stage changes or adds (the list is in `skills/build-phase/reference.md`). Each mismatch goes in the card, flagged for verify.
4. Draft the phase card from the plan's §5 section or the note's stage and the code as it is now: **500–700 words of body**, naming exactly which sections and stage records to read, with the plan's open decisions in *Decided here*. Over 1,000 words means the plan section is underspecified: say so in the log. Commit it as `briefs/<stage>.md`, in its template in the reference file.
5. Assign the lane's branch, test database and ports from `config.md`. Make the worktree with `git worktree add` from a freshly pulled local `main`, with no upstream, and tell the lane its working directory.
6. Launch a background Sonnet subagent with the paths of `brief-common.md` and the card. Record the lane in `STATE.md`.

**Carry-overs:** one a review marks "for every card", or an environment problem that cost a lane time, is proposed for `brief-common.md` at that verify, not repeated in each card.

**Land:** reads `.tmp/<stage>.report.md`, so it can run in a later session.
1. Check the lane's commit exists and its authors are right.
2. Measure the diff from the lane's recorded base, not `main`; list the files a newer `main` also touches.
3. Record lines (app, tests, moved) and the harness's time and tokens against the size, ignoring the lane's own estimate.
4. Save the report as `briefs/<stage>.report.md` with a one-line header (stage, branch, base); commit.
5. Update `STATE.md` with what verify must decide: the lane's calls, the card's *Decided here*, card checks not done, changes to what the deploy runs, departures from the note or plan. Name `verify <stage>` as next.

Land doesn't push the branch. If verify must run on another machine, the founder pushes it (§0).
**Reference:** `skills/build-phase/reference.md`.
**From:** the journeys orchestration: `brief-common.md`, `brief-j*.md`, the lane registry in the state log.

### `debug`
**Does:** bounded debugging.
**Invocation:** by name, or by Claude when a test fails unexpectedly · **Model:** the session's, high effort.
**Rules:**
- Reproduce with the smallest test; one hypothesis at a time, each tested by one targeted run with quiet output.
- After three failed hypotheses, stop and write up what is known in `STATE.md`.
- Never debug through the full e2e suite.
- An environmental cause (rate limit, clock, database, ports) is fixed in the test setup, not rerun.
- After fixing a shared rule, rerun every test file that asserts it.
- Don't edit a test file a running full suite has loaded; fix it and rerun it after.

**From:** the J1 lane (retrospective finding 2); Superpowers' systematic-debugging; the state log's lesson after J13.

### `verify`
**Does:** reviews a landed stage, fixes it, records it. Or, with `--milestone`, runs the full suites.
**Invocation:** `verify <stage>` · `verify --milestone <M>` · **Model:** Opus, high · **Forked**, `background: false`.
**Reads (injected):** the lane report; `git diff --stat main...<branch>`; the card and the plan's §5 section or the note's stage; `review-checklist.md`; for UI stages, `design-review`'s checklist; `config.md` §1 and §3; the decisions and defect rows the card names; the open-work file's rows for the stage. Nothing else until the diff points somewhere.
**Does, in order:**
0. Fetch. If `main` moved since the lane's base, rebase or merge first, so the review reads what will ship.
1. **Exercise first:** run what can be run before reading further: build and run the image, probe new code with inputs its tests don't hold, and check each deploy check fails when what it guards is broken. The lane report's item 6 is the first work list.
2. Check against the review checklist.
3. Fix on the branch. A fix that changes no rendered pixel at the designed sizes, or only corrects a defect, is the reviewer's; anything else goes back to a lane or to the founder. A test the review adds is first seen to fail on the unfixed code. A failure with no cause found is repeated five times alone and recorded as a flake.
4. Merge `main` in.
5. Rerun the affected test files, and every file asserting a changed shared rule or importing a changed helper. Run the full suites when a change note asks for them, and budget for them in the first message.
6. Fetch again, then write the stage record in the code repo (shape of `J12.md`: built · decided · owed · verification).
7. Move owed items, and anything past the verification ceiling, to the project's open-work file.
8. Flag canon the stage made stale, in the stage record, for `close-out`.
9. Update the stage list and the state-of-the-build file (from `config.md`) where they apply.
10. Send the lane report's item 7, and any lesson from the review, to the learnings inbox as a capture note.
11. Report "ready to fast-forward" or what blocks it.

**May write,** with the founder's yes in this session: correction-only edits to the build plan and the project config, logged in the stage record. Scope goes to `revise`.
**Where `main` deploys:** review and fix, rebase on `origin/<base>`, check before the push (stop files, `.env` lines), push on the founder's word, read the run, record its URL. The forked part ends at "ready to deploy"; if blocked, "push pending: founder".
**Founder-only checks:** a signed-in check on production, a server CLI's output, and any destructive production step go to the open-work file as founder items. Cards don't promise them of the reviewer.
**Milestone mode:** run the project's milestone script, one heavy runner at a time, and record the counts in the development README.
- **Before the run,** list the by-hand items whose *needed by* names this milestone, ask which devices the founder has today, and check production holds the content each needs.
- **Two states:** *suites green*, and *closed* once its blocking by-hand items are done.
- **A red suite:** test infrastructure may be fixed on `main`; a failing app test makes the milestone red and goes to `debug`.
- **It pushes** only docs and test infrastructure, after reading the stop-file list.

**Returns:** at most 15 lines.
**Reference:** `skills/verify/reference.md`.
**From:** the journeys reviews (retrospective §2); `J12.md`; the development README's done means.

### `design-review`
**Does:** checks built UI against the project's design system and accessibility.
**Invocation:** by name, on a stage or a screen · **Model:** Opus, high · **Forked.**
**Reads:** the design system named in `config.md` §1 (Root's brand and tokens only where that row points at them); its own checklist: accessibility gates (contrast, touch targets, text scaling, keyboard, screen reader), hierarchy, feedback, consistency, right-to-left rules.
**Writes:** findings to `08-design-review.md`, each What / Why (citing a source) / Fix, on the module's severity scale (`review-instrument.md` §4).
**Rule:** the project's design system is the rubric; general principles fill gaps; Apple's visual language doesn't apply.
**Reference:** `skills/design-review/reference.md`.
**From:** the review format and accessibility gates of `dickwu/apple-design-skill`, borrowed, not installed.

### `ux-review`
**Does:** walks each journey as each selected persona and scores it.
**Modes:** `design` (before the build, on 4b where it exists, else the wireframes) · `live` (after UI stages, against the running app).
**Model:** Opus, high · **Forked.**
**Reads:** `03-journeys.md`; the latest design or the running app; the spec's interface and acceptance sections only; the selected personas; `review-instrument.md`. §0's injected owed items, so they aren't counted as defects.
**Checks:** the six metrics per persona, per journey; coverage (every criterion has a screen, every screen its empty, error and loading states); Nielsen's ten heuristics.
**Live mode** reads production read-only, with requests it won't count as readers, and walks signed-in states on a local server built from the deployed commit.
**Asks nothing.** Decisions found are routed `question`, for `revise` or the next change note.
**Writes:** a dated pass appended to `05-ux-review.md`, a short summary per pass at the top. A required *For `revise`* lists the findings that change the spec. Each finding has a *Status* (`open`, `closed in <file>`, `carried to <step>`); `build-plan`'s gate greps for `open`. After the build, UI fixes go to `spec change` as one Change.
**Gate:** the latest design and journeys · `live`: UI stages verified; open device checks don't block it and are listed under *Not checked*.
**Reference:** `skills/ux-review/reference.md`.
**From:** `tracker/canon/05-reviews/00-persona-review-method.md`, the same instrument at both points so scores compare.

## 4. Closing the loop

### `revise`
**Does:** carries a change back upstream.
**Model:** Opus, medium.
**Modes:** for a module · `--catch-up <notes>` · for the method.
**Input:** a change request: a lane report's item 5, a review, a live UX finding, or a change to the method.
**Reads:** every `STATE.md` block since the last `revise`, and the sections their items cite (items come from those sections, not from the summary); the spec header's scope ledger.
**Asks:** the founder per item, in one batch, before writing (§0). An earlier [F] decision is accepted by default, but scanned for an open sub-question.
**Scope.** Each version updates the ledger. When an area has doubled since intake, or passes about a quarter of all criteria, `revise` asks "still the smallest version worth trying?" before accepting more. An item that adds a capability (new stored data, a new screen family, anything intake put out of scope) leaves `revise` for `spec change`, with research or a waiver line.
**Outcomes:** each item is *accepted*, *refused*, *carried to <step>*, *left to the build plan* (under *Open*, which `build-plan`'s gate reads), *deferred to <rubric>*, or *pending explanation*.
**`STALE`:** only where a downstream output contradicts the change, quoting the sentence it marks; `revise` greps the output for every line relying on the changed fact. Where the output is silent, or already provided for the outcome, the item is carried with an owner, not marked stale.
**Writes,** for a module: `changes/NN-req-<slug>.md` in the template in `skills/revise/reference.md`, naming the touch-ups owed (`eval-plan --touch-up`, `journeys update`, the design step) and their order in `STATE.md`'s next steps; the spec's version, changelog line and ledger; `STALE` cells; a line in `<module>/decisions.md`; the open-work rows it settled, struck.
**A new language or audience:** `personas add`, then `journeys update`, before any design pass or review.
**`--catch-up <notes>`,** after a build, writes the files the notes' *What this makes stale* names, each with the founder's acceptance.
**For the method** (`lifecycle/` files): the edit, the file's version and changelog line, and a `decision-log.md` entry. No status cells.
**From:** the journeys build's mid-plan changes (J9 split, J13's "signed" rule).

### `close-out`
**Does:** finishes a module.
**Model:** Opus, high.
**Modes:** full · `--eval`, when a later evaluation matures: it appends the result and clears the cell.
**Gate:** as `README.md` §2, phase 10. An override is recorded with its reason in `09-close-out.md`'s header.
**Reads:** the eval plan and its results; every stage record's *decided* and *owed* sections, injected; `STATE.md`; the canon-sync flags. If the code repo isn't reachable, the plan's changelog and the open-work file, saying so.
**Writes:**
- `09-close-out.md`: the evaluation against the rule written beforehand; what the plan didn't know; the module's cost in dollars from `/usage`; a short retrospective.
- **Closed, launch-ready and evaluated are separate:** launch's date or "not yet", the later checks' dates counted from launch, and their reminders, with the founder's yes. The row reads `closed · eval <date>` until the last check.
- the canon-sync flags applied to the canon `config.md` names, through `revise --catch-up` for design-side files; documents moved from `working/` into canon; design documents' *Grading* lines updated; the roadmap;
- the `status.md` row closed as done, parked or killed.

**Reference:** `skills/close-out/reference.md`.
**From:** the canon/working convention in `ecosystem/README.md`; the journeys build's retrospective.

---

## 5. What gets built first

Stage 1 (foundation) is files, not skills. The IMNSTR trial counted what its 72 logs missed (`trial-run/findings.md` §10): `bin/gate` in 32, a template in 22.
- `status.md` backfilled for existing modules, with the values in `README.md` §3;
- `templates/` and `required-headings.txt`, one per output: intake, research, spec, persona record, journeys, wireframe frame kit (`wireframes.html`), change request, change note, eval plan, build plan, phase card, lane report, design README, design-import checklist, review, close-out, and the project config's three files. Their headings are in each skill's section and its `skills/<skill>/reference.md`, and in each trial log's *Template sample*. `brief-common.example.md` is already there;
- `bin/gate`, as §0 specifies: fetch, step check, override, HTML headings, the personas table, criterion coverage;
- `learnings/inbox/` and `index.md`, with `learned`'s note fields (`skills/learned/reference.md`);
- `projects/root-app/` from the recovered brief and the plan's §0.2–0.3 and §8;
- `projects/tracker/` from `tracker/canon/02-architecture/04-conventions.md` and `03-engineering/01-testing.md`;
- CLAUDE.md in all three repos, `root-app`'s carrying the environment knowledge from the build machine's memory.
- **The founder's machine setup:** reduced-motion emulation, an image zoom tool, shellcheck, Docker running, `gh` signed in, and a network allowlist for reference hosts (w3.org, owasp.org, PubMed, university repositories).

Already in place from the trial: `engineering-checklist.md`, `projects/imnstr/`, and IMNSTR's `decisions.md`.

Stage 2 builds `lifecycle-status`, `handoff`, `learned`, `decision-record`, `build-phase`, `verify` and `debug`, each written with `skill-creator` as `skills/<skill>/SKILL.md` and tried on real work before stage 3. Its first step is `bin/install-skills`, which copies them into `~/.claude/skills/`. The rest follow the rollout in `README.md` §8.

## Changelog

- **0.12 · 2026-10-20** — `handoff` and `learned` end with the next session's prompt (`README.md` §5 rule 8). Stage 2 writes each skill as `skills/<skill>/SKILL.md` and starts with `bin/install-skills`.
- **0.6–0.11 · 2026-10-20** — Cut back from about 10,200 words to about 5,800, one section per commit, each reviewed by the founder (L-22 to L-27). Every skill keeps what it does, reads, writes and gates on. Templates, output shapes, *Reference holds* and one-incident rules moved word for word to `skills/<skill>/reference.md`, and rarely needed shared rules to `skills/shared/reference.md`; provenance and lines repeated elsewhere were cut.
- **0.5 · 2026-10-19** — From the IMNSTR trial (`trial-run/findings.md` 0.2), applied in fourteen groups. What each group changed is its entry in `decision-log.md`, L-8 to L-21 (L-20 is the trial brief's).
- **0.4 · 2026-10-06** — Change track: `spec change` writes a Stages section into the change note; `build-phase` gates on and drafts cards from it; `verify` reads it in place of the plan's §5.
- **0.3 · 2026-10-06** — Consistency pass against `README.md`: gate always exits 0 (a failing injected command aborts the skill) and passes `n/a`; decision-log entries from `personas`, `revise` and `learned` use `decision-record`'s format; `revise` gains a method mode; `close-out` gains a gate line; `build-plan`'s gate matches the README; canon flags go in the stage record; state-of-the-build file is per project; source paths completed.
- **0.2 · 2026-10-05** — `learned` added: capture to an inbox, consolidate in batches; lane report gains item 7; `verify`, `handoff`, `lifecycle-status` and `close-out` wired to it.
- **0.1 · 2026-10-05** — Plan. Eighteen skills specified from the design conversation, the journeys build's documents, brief and state log, and the Claude Code skills documentation.
