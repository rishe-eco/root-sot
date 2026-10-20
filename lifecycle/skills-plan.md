# Lifecycle — the skills, specified

*Each of the twenty lifecycle skills, and the design step: what it does, how it is invoked, which model runs it, exactly what it reads and writes, its gate, and where its shape comes from. The method these skills implement is `README.md`.*

**Version 0.7 · Status: plan — nothing here is built yet · 2026-10-20 · Owner: _root**

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
**Output:** in chat, under 15 lines: the track; the module's phase, read with the status values in `README.md` §3; what is missing or stale; the next skill to run and the model it will use; the founder's rows due within the next step; "inbox over cap: N notes, oldest <date> — run `learned --consolidate`" when it is, which is also checked at each milestone.
**From:** the table in this conversation's first review of the repos; Spec Kit's phase order.

### `handoff`
**Does:** ends a session by writing state a fresh session can start from.
**Invocation:** by name, at the end of a session · **Model:** Sonnet, low.
**Reads:** the session's own work; `git log` since the last state block.
**Writes:** a new block at the top of the module's `STATE.md` (or `lifecycle/STATE.md`), committed. Blocks older than the last five are deleted — stage records hold the history.
**Block format** (≤40 lines):
- **header:** date · `<root-sot branch> @ <hash>` · `<code repo> main @ <hash>`, where there is a code repo;
- **first line:** which earlier blocks this one *replaces*, *adds to* or *partly completes*, naming their steps. A block that touches a stage named in another live block cross-references it;
- **lanes in flight:** stage, branch, database, ports, card, status;
- **next steps, in order:** each written as the line the founder pastes, with skill, model, effort, branch and the checkout it writes in (with skills, that line is the invocation). Live next steps are copied forward in full, never "as in the earlier block";
- **carry-overs:** decisions and pointers to sections, not findings. A session acting on an item reads the cited section, not this summary of it;
- **questions for the founder:** phrased ready to ask, each with *owed by*, the step that needs the answer. Options are named by noun; letters, at most, are aliases;
- **owed.**
**Ends with:** "Run `/learned`, then `/clear`."
**From:** the journeys orchestrator's state log (`root-app-lifecycle-build` memory), which carried the build across three compactions — moved from private memory into git.

### `decision-record`
**Does:** adds a decision to the right decision log in house format.
**Invocation:** by name, any phase · **Model:** Sonnet, low.
**Reads (injected):** the last three entry headers of the target log (`grep`), for the next ID and the format. Never the whole log.
**Writes:** one entry; the log's version line.
**Which log:** `lifecycle/decision-log.md` holds decisions about the method only. A module's product decisions live in its change notes, with one line each in `<module>/decisions.md`.
**Reference:** `skills/decision-record/reference.md`.
**From:** `tracker/decisions/decision-log.md`, `ecosystem/decisions/`.

### `learned`
**Does:** captures what a session learned about *working* — the environment, the method, a skill, a model's habits; not the product, which belongs in stage records and specs. Two modes; only the second changes anything.

**`learned` (capture)**
**Invocation:** by name, at the end of a session, after `handoff` · **Model:** the session's own, low effort. **Never forked** — the session it reviews exists only in this context.
**Reads:** nothing beyond the session itself. Capture does not deduplicate; a lesson recurring across notes is the evidence consolidation needs.
**Writes:** one file, `lifecycle/learnings/inbox/<date>-<slug>.md`, holding **zero to three** notes. Zero is a valid result; filler is not.
**Each note** (≤6 lines) has fixed bold fields, so consolidation extracts them with one `awk`: **Rule** (the lesson); **Event** (the specific event in this session); **Cost** (if known); **Scope** (repo, project, method, a named skill, model behaviour); **Destination** (suggested); **Urgent** (`yes` if waiting for consolidation would repeat a costly mistake).
**Urgent notes** are also copied into `STATE.md` as a carry-over, so the next session reads them without any instruction file being touched.
**Rejects** notes that cite no specific event, that would not change a future action, or that could not be checked later.

**`learned --consolidate`**
**Invocation:** by name, when `lifecycle-status` reports the inbox over cap — **15 notes or 14 days**, whichever first — at each milestone during a build, and before any `close-out` · **Model:** Opus, high, in a session of its own.
**Reads:** every note in the inbox; `lifecycle/learnings/index.md`; the line count and headings of each candidate destination. Injected: each candidate destination's `## Changelog` lines and the memory index, to find what is already integrated. `founder-notes.md`, where the module has one: each note is a cluster of its own, with mechanisms offered as options.
**Does:**
1. Cluster the notes by lesson; count recurrences by session.
2. Decide each cluster: **integrate** (seen in two or more sessions, or once at high cost) · **hold** (seen once, cheap — stays in the inbox for the next batch) · **discard** (already integrated, obsolete, or not specific).
3. For each integration, draft the exact edit at its destination. If the destination doesn't exist, draft the rule and name the destination; the file's first author places it:

| Kind of lesson | Destination |
|---|---|
| Repo or environment gotcha | that repo's CLAUDE.md (kept under 200 lines — over it, propose what moves out) |
| How lanes should work | `projects/<project>/brief-common.md` |
| How a phase should be done | that skill's reference file |
| What reviews should check | `projects/<project>/review-checklist.md` |
| A change to the method | this plan or `README.md`, through `revise` |
| A fact about building software, true beyond this project | `lifecycle/engineering-checklist.md` |

4. Present the batch as one proposal, then ask in groups of at most four: one plain sentence per item, with its event, inside the question; longer explanations in the closing message. The founder accepts, edits or rejects each item.
5. Apply the accepted edits; write one entry per integration in `lifecycle/decision-log.md`, in `decision-record`'s format; add each to `index.md`; delete the processed notes (git keeps them); commit.
6. At a module's last consolidation, holds become seeds for their destination's reference file, listed by destination.

**Owns:** the inbox and `index.md` (`verify` also drops one capture note per review into the inbox). Edits to founder-owned files (templates, project configs, this plan) happen only through step 4's acceptance.
**From:** the journeys build's state log, whose lessons ("rerun every test asserting a changed shared rule", "background Bash ignores a leading `cd`") were its most valuable lines and lived only on one machine.

## 2. Design

### `ideate`
**Does:** turns an idea into a one-page intake and opens the module.
**Model:** Sonnet, medium.
**Asks:** problem; pillar and place on the opportunity tree (`ecosystem/ost.md`), for Root work, or "n/a, outside Root" with a reason; who it is for; smallest version worth trying; what would make us drop it. The drop rule is recorded verbatim. If it isn't testable, the intake says so and passes it to `spec` and `eval-plan`.
**Writes:** the module folder, `00-intake.md` (one page, no sources), `STATE.md`, the `status.md` row. The intake ends with *Decisions at intake*: the track, research or a waiver line, the code repo, which phases apply (UI or not), and the project.
**Gate:** none.
**From:** Spec Kit's idea-assessment intake.

### `research`
**Does:** a research brief, checked against what Root already knows.
**Model:** Opus, high.
**Reads:** the intake; `ecosystem/canon/04-research/00-evidence-summary.md` first, so known evidence is not re-researched; the code it concerns, if any, by section.
**Writes:** `01-research.md` — five-line summary on top; claims graded as §0's *Grades*; sources; capped at ~2,500 words, sources excluded. A required section, *For the next phases*, holds the options named by noun (letters, if any, only as aliases) and the questions for `spec`.
**Reference:** `skills/research/reference.md`.
**Gate:** intake.
**From:** the grading blocks in the journeys documents and the lifecycle spec.

### `personas`
**Does:** selects which registered personas a module serves; rarely, proposes a new one.
**Model:** Sonnet, medium.
**Modes:** select (before journeys) · `add` (adds a row after journeys exist, when a language or audience is added).
**Reads:** `personas.md`; the intake; the spec's interface section, when proposing.
**Does:** selects from the registry. The selection may be empty. When no persona fits, it proposes one per intake audience, defined by behaviour. Whenever it proposes a persona, it asks the founder to accept before writing the registry.
**Writes:** the selection into the module's `03-journeys.md` header (creating the file; `journeys` fills it): a title block plus `## Personas`, a table of persona, serves, why and anchors. `personas` owns `## Personas`, and `journeys` never edits it; the journeys version is bumped by the next `journeys` run. A proposed persona goes into `personas.md` marked *hypothesis*, with a decision-log entry in `decision-record`'s format.
**Rules:** never redefines an existing persona — the persona review's score history depends on them being fixed. A module's owner may be a persona; their real judgement stays the founder's, not the persona's score.
**Reference:** `skills/personas/reference.md`.
**From:** `tracker/canon/05-reviews/00-persona-review-method.md` §2.

### `spec`
**Does:** the spec, or a change note against an existing one.
**Modes:** `full` (Module) · `change` (Change track: a note in the module's `changes/`, or a new folder for a module that predates this system).
**Model:** Opus, high.
**Asks first:** up to eight clarifying questions in one batch (two calls of four, §0).
**Writes:** `02-spec.md` in the house template. Journey-level criteria belong to `03-journeys.md`, written after the spec; the spec doesn't anticipate them.
- **Metrics:** the spec defines measures. The eval plan owns instruments and rules, and may refine a measure. A refinement goes to `revise` as an item, and the plan proceeds on its refinement.
- **The platform:** the spec names a stack implication as a risk. `build-plan`'s foundation batch decides it.
- **Scope ledger:** the header carries the acceptance criteria counted by area at each version, against the intake, so growth since intake is visible (`revise` reads it).

**Writes, in `change` mode:** `changes/NN-change-<slug>.md` — what changes and why, acceptance criteria, what must not break, and a **Stages** section: one or more stages in the build plan's §5 shape, each with a size (S/M/L) and its traps. This section is what `build-phase` and `verify` read in place of a build plan; a change too large to stage here is a Module.
- **Header:** the kind (*change*), and `main @ <hash>` of the code it was written against.
- **Criteria:** the note owns a two-letter prefix (`README.md` §0). The criteria table has an *Item* column naming the review finding each criterion closes. A review's findings routed `question` join the note's first batch of questions.
- **Each stage** also has: an *Image and deploy* line; optional *At the verify* (a server runbook) and *Stop points* (commit boundaries). Lanes run targeted tests; the full suites are the verify's. It is sized with the test harness counted, as `build-plan` does. For any infrastructure change, it answers "what does this change about how later stages are built, verified or deployed?"
- **It ends with *What this makes stale*:** each file, its owner, and the step that catches it up. A note that defers the spec adds a `revise` line to its `STATE.md` block's next steps, and `close-out`'s gate fails while one is pending.

`changes/` has one numbering for both kinds: `NN-change-<slug>.md` from `spec change`, `NN-req-<slug>.md` from `revise`.
**Gate:** research, or a waiver line in the intake (`full`). In `change` mode: `STATE.md`'s top block and the lanes in flight are injected, and the skill refuses while a lane touches the same files. `build-phase` re-reads the note against `main`'s log since its `main @` before drafting a card.
**Reference:** `skills/spec/reference.md`.
**From:** `tracker/canon/06-specs/04-verification-lab.md`; Superpowers' brainstorming questions.

### `journeys`
**Does:** the paths people take.
**Modes:**
- `new` — 3–5 journeys (first day, normal loop, return after a gap, not enough data, error) of ~10 steps each. Scenarios may share a journey, error journeys may be branches, and a journey with two actors adds a *Who* column. About 3,000–4,000 words, a guide, not a limit.
- `gap` — each scenario checked against the code as *have / partly / missing*.
- `update` — brings journeys up to a newer spec and new personas, from the change notes since its version.

`gap` and `update` may be scoped (`--steps J2.9,J3.4` or `--from-note 07`): the changelog then says what wasn't checked, and the status cell stays `done`.
**Model:** Opus, high.
**Asks:** in every mode, one batch, recorded in *Decisions taken at journeys*. A founder decision the spec lacks is also listed as Suggested, for `revise`.
**Writes:** `03-journeys.md`, below the `## Personas` section that `personas` owns.
- **Each step's last cell, *Must be true*,** is a check citing criteria. Steps are cited `J<n>.<step>`.
- **`## Coverage`** (required): each acceptance criterion to its step, as `step`, `no screen` or `all steps`.
- **Suggested,** in every mode: requirements the spec lacks, kept apart in a section `revise` reads. Once accepted, the next `journeys` run marks each "accepted at spec x.y", pointing at its criterion.
- **A states table** at the end (empty, error, loading, not enough data, notices), which `wireframes` reads.
- **Amending:** keep step numbers, give inserted steps a letter suffix, and mark changed text **[x.y]**, so citations downstream still hold.

**Gate:** spec; personas selected (the `## Personas` table).
**Reference:** `skills/journeys/reference.md`.
**From:** `ecosystem/working/root-studio-user-journeys.md` on branch `journeys-build`, not yet on `main` (the `gap` mode); the Impact spec's flows, `ecosystem/working/impact-build/01-noticing-spec.md` (the `new` mode); bug B-14 as the case it exists to catch.

### `wireframes`
**Does:** low-fidelity HTML for every journey step, including empty, error, loading and not-enough-data states.
**Model:** Opus, medium.
**Steps:**
1. Run the gate.
2. List the steps and states from the journeys' steps and states table.
3. Group them by screen.
4. Draw, by screen.
5. Write *Calls made here*.
6. Write the coverage plate: a step-to-plate table, so every journey step is traceable to a frame. A step with no screen of ours is marked "not ours, drawn as context" or "no screen", with a note.
7. Render at 1200 and 375 px, and look.

**Low fidelity** means neutral tokens; real copy only where the words are the requirement; placeholder bars elsewhere; no brand. The frame kit is `templates/wireframes.html`.
**Suggested items** are drawn as visibly marked options, never as plain UI, and the ones drawn are listed.
**Writes:** `04-wireframes.html`, with a required section *Calls made here*: behaviour the wireframes decided, each graded *proposal*. `ux-review` and `build-plan`'s gate read it.
**Gate:** journeys.
**From:** the existing `*-wireframes.html` files in `tracker/canon/06-specs/`.

### The design step (4b), and its import
**Does:** turns the wireframes into a designed, self-contained site the build draws from. The founder runs it in a design tool; an import session brings it into the repo.
**Opening form,** before the first direction: references, the feel wanted, and whether an attached design system binds.
**Inputs:** spec §4 and §6; the journeys' steps and states table; the wireframes' coverage plate. A second pass also reads the change notes' *Carried to design* lists (each item linked to its source), any earlier design review folder, and the spec sections those notes cite. Before editing in the tool, re-read the repo's latest source.
**How much to draw:** phone for every screen and state. Desktop is required for public pages and the main editor. Gaps are listed in the README. Build plate by plate: large single writes time out.
**Output:** `04b-design/`: self-contained HTML exports plus `source/`, edited in place (git keeps the history), and a README.
**The README** follows its template in `skills/design-step/reference.md`.


**The handoff.** A design tool that can't push leaves files at their repo paths in `../repo-handoff-<step>/`, beside the repo.
**The import** (Opus, medium) has its own log and `STATE.md` block, and may edit `04b-design/README.md`. It diffs `STATE.md` and merges by block, never by overwriting. Its checklist is in `skills/design-step/reference.md`.

**Optional review at the end of 4b:** an accessibility and HIG pass that writes proposals only, for `revise`. Scores are left to the UX review.
**Status:** no column of its own; it shares column 4. An owed pass is written `done · owed 4b` there.
**From:** the IMNSTR trial's steps 4b, 05e and their imports.

### `eval-plan`
**Does:** how we will know the module works for people, with the decision rule written before any data and the ambiguous outcome named.
**Modes:** full · `--touch-up <change note>` (Opus, medium).
**Model:** Opus, high.
**Steps:** the failures that look alike; the instruments; the rule, before any data; cost; limits.
**Asks:** the founder about consequences: what "drop" means, and what happens after the last check.
**Writes:** `06-eval-plan.md`.
- It separates what `close-out` can judge from what matures after it, and names who runs the later checks and where they are reminded. Later checks count from launch (`README.md` §2). Results go in the plan's §5 *Results* table.
- Each instrument names its preconditions (a device, the domain, real data), which `build-plan` places in the stage order.

**Gate:** spec.
**Touch-up:** its gate is a spec newer than the plan's input version. It reads the note's items and the sections they cite. It fixes what contradicts the spec, and what the change makes wrong in an instrument, and logs both. Decision rules stay unchanged unless the founder decides otherwise. A rule whose *action* cites a question the spec has since settled goes to the founder.
**From:** `ecosystem/working/impact-build/03-spine-evaluation.md`.

### `build-plan`
**Does:** the plan a build is run from.
**Model:** Opus, high.
**Reads:** spec, journeys, wireframes, UX review, eval plan; `projects/<project>/`; the defect pass: the code and infrastructure the build will touch or share, read before planning. For a project with no code, the inputs, for contradictions and leaks. Injected: `README.md` §6–§7.
**Step 1, the foundation batch:** when `projects/<project>/` doesn't exist, ask the founder's facts in one batch before drafting: repo, host, stack, domain, server facts, the devices they have. Answers go in the plan's §4, marked as answered. For a new project, the plan's §0.3 is the source of the project's house rules, which `project-config` transcribes.
**Writes:** `07-build-plan.md` in the journeys plan's shape — §0 what was read, what must not break, house rules, defects found and assigned · §1 the shape at the end · §2 planning decisions (PD-n), each vetoable · §3 stage order, milestones, parallel lanes allowed (never two touching shared schema) · §4 pre-flight unknowns · §5 one section per stage, to the level of models, mutations, refusal codes, screens and tests, with a **size (S/M/L)** and its **traps** · §6 cross-cutting catalogues · §7 what changes in built code · §8 verification and its ceiling · §9 where this goes wrong · §10 for the founder.
**Each stage section** also says, beside size and traps:
- **Image and deploy:** new environment variables with production defaults, and toolchain changes;
- **constraints from earlier stages** its writes must work through (triggers, unique keys);
- **the plate it draws from,** and which stage owns each control on it. A frame-first split is planned explicitly;
- **the API from the screens' save boundaries,** not one route per verb;
- **a guard for every destructive CLI;**
- **deploy-sequencing traps as stages** (B6a, B6b), never as an instruction one lane can't carry out;
- **for a server-filled field,** what the screen shows for each verb.

**Sizes:** a size is lane hours and lines of new app code, with tests and moved code counted apart. *Evidence* (IMNSTR): stages overran their line estimates (B4a +3,875 against L's ~3,000; B5 +2,634 against M's ~1,500; B7 +5,291) while running far under in time (B4a about 23 min against 4–6 h). Recalibrate from the stage records once a second module exists.
**Last step, before commit:** each §6 catalogue row agrees with its §5 section; planning decisions don't contradict each other or the house rules; every "open" call is listed in §10 as left to the card.
**Reference:** `skills/build-plan/reference.md`.
**Gate:** as `README.md` §2, phase 7: phases 2–6; UX findings, journeys' *Suggested*, the design's *Beyond the spec* and wireframes' *Calls made here* each accepted, refused or carried; `revise`'s *Open* items.
**Rule:** this session ends once the plan is committed and pushed. The build starts fresh.
**From:** `ecosystem/working/root-studio-journeys-build-plan.md` on branch `journeys-build`, not yet on `main`.

### `project-config`
**Does:** creates a project's configuration folder.
**Invocation:** by name, once per project, after its first build plan, when `projects/<project>/` doesn't exist · **Model:** Opus, medium.
**Reads:** the build plan (§0.3 is the source of house rules, §4 the founder's facts); the latest retrospective; `templates/brief-common.example.md`; anything the founder supplies.
**Writes:** `brief-common.md`, `review-checklist.md` and `config.md`, with the contents `skills/project-config/reference.md` lists. The founder accepts before commit.
**Gate:** build plan.
**From:** the IMNSTR trial's step 7b.

## 3. Build

### `build-phase`
**Does:** launches a stage as a lane, or lands one.
**Invocation:** `build-phase <stage>` to launch · `build-phase <stage> --land` after the lane reports. On the Change track, `<stage>` names a stage in a change note (`changes/NN-change-<slug>.md#<stage>`).
**Gate:** the build plan, or a change note with a Stages section.
**Model:** Opus, medium (it drafts the card; the lane is Sonnet).
**Launch:**
1. Run the gate. Check `STATE.md`: at most two lanes in flight, no other lane touching shared schema. Check that the code repo checkout exists, and clone it if not.
   **Facts and preconditions first:** read the P0 items the stage needs from the plan's §4, marked done or open. Ask the open ones in one question generated from that list, together with environment preconditions (Docker running, the devices the founder has today). List every by-hand check that names the stage. For an infrastructure stage, draft the card only after the facts arrive.
2. **Check the plan against what it touches:** diff the stage's file list against the tree; compare its screens with the plate; read the migration for each table it writes; re-read a change note against `main` since its `main @`. **Grep the tests** for the stage's routes, tables and page names, every literal it changes, every request field a route starts reading, every value class a new refusal covers, and every helper that does the same job (found by behaviour, not one name: all clock setters). Each mismatch goes in the card, flagged for verify.
   Then draft the phase card from the plan's §5 section — or the change note's stage — and the code as it is now: **500–700 words of body** (the header, lane table and pasted facts don't count), naming exactly which plan sections, journeys sections and earlier stage records to read. Over that, the card cites the design's plate index rather than quoting copy, and records the plan's open decisions in *Decided here*. If the body still runs over 1,000 words, the plan section is underspecified: say so in the log. On the Change track, when the note's stage names files, tests and traps, the card defers to it and adds the code check and the lane rules. Commit it as `briefs/<stage>.md`.
3. Assign lane resources from `config.md`: branch, test database, ports. Make the worktree with `git worktree add` from local `main` after a pull, with no upstream (the Agent tool's isolation can't target another repo). The card tells the lane its working directory.
4. Launch a background Sonnet subagent with the paths of `brief-common.md` and the card; the lane reads them.
5. Record the lane in `STATE.md`.

**The card** follows its template in `skills/build-phase/reference.md`.


**Carry-overs:** a carry-over a review marks "for every card", or an environment problem that cost a lane time, is proposed for `brief-common.md` at that verify, not repeated in each card.

**Land:** reads `.tmp/<stage>.report.md`, so it can run in a later session than the launch.
1. Check that the lane's commit exists and that its authors are right.
2. Measure the diff from the lane's recorded base, not `main`, and list the files a newer `main` also touches.
3. Record lines (app, tests, moved) and the harness's time and tokens against the size. The lane's own estimate is ignored.
4. Save the report as `briefs/<stage>.report.md`, with a one-line header (stage, branch, base), and commit it.
5. Update `STATE.md`. The block lists, *for verify to decide*: the lane's calls; the card's *Decided here*; card checks not done, and why; changes to what the deploy runs; departures from the note or plan.
6. Name the next step (`verify <stage>`).

Land doesn't push the branch. `verify` runs on the machine that holds it; if it must move machines, the founder pushes it (§0, outward-facing actions).
**From:** the journeys orchestration: `brief-common.md`, `brief-j*.md`, the lane registry in the state log.

### `debug`
**Does:** bounded debugging.
**Invocation:** by name, or by Claude when a test fails unexpectedly · **Model:** inherits the session's, high effort.
**Rules:**
- Reproduce with the smallest test.
- One hypothesis at a time, each tested by one targeted run with quiet output.
- After three failed hypotheses, stop and write up what is known in `STATE.md`.
- Never debug through the full e2e suite.
- If the cause is environmental (rate limit, clock, database, ports), fix the test setup instead of rerunning.
- After fixing a shared rule, rerun every test file that asserts it.
- Don't edit a test file while a full run has it loaded. Fix it, then rerun that file after the run. App source may change mid-run if the server loads once at the start.

**From:** the J1 lane (retrospective finding 2); Superpowers' systematic-debugging; the state log's lesson after J13.

### `verify`
**Does:** reviews a landed stage, fixes it, records it. Or, with `--milestone`, runs the full suites.
**Invocation:** `verify <stage>` · `verify --milestone <M>` · **Model:** Opus, high · **Forked**, `background: false`.
**Reads (injected):**
- the lane report;
- `git diff --stat main...<branch>`;
- the phase card and the plan's §5 section for the stage, or the change note's stage;
- `review-checklist.md`;
- for UI stages, `design-review`'s reference checklist;
- `config.md` §1 and §3; the planning decisions and defect rows the card names; the open-work file's rows for the stage.

Nothing else until the diff points somewhere.
**Does, in order:**
0. Fetch. If `main` moved since the lane's base, rebase or merge first, so the review reads what will ship.
1. **Exercise first:** before reading further, run what can be run. Build and run the image; probe each new one-rule file with inputs its tests don't hold; send raw, un-normalised paths at a path guard on the running server; check that each deploy check fails when what it guards is broken. The lane report's item 6 is the first work list. Then read the stat and the core files.
2. Check against the review checklist. "Driven in a browser" means a scripted real browser plus screenshots that were looked at, graded "screenshots, not a window"; the preview pane counts for look, and DOM measurement for layout.
3. Fix on the branch. A fix that changes no rendered pixel at the designed sizes, or only corrects a defect, is the reviewer's; anything else goes back to a lane or to the founder. A test added by the review is run against the unfixed code and seen to fail first (stop or exhaust a page's timers before). A failure with a cause found is fixed in the test or the page; one without is repeated five times alone, recorded as a flake in the record, and named in the push question.
4. Merge `main` in.
5. Rerun the affected test files, and every file asserting a changed shared rule. A fix to a shared helper or a one-rule file reruns every spec that imports or renders through it. When a change note's criteria ask for the full suites, run them, and budget for them in the first message (about 30 min per e2e run on IMNSTR).
6. Write the stage record in the code repo (shape of `J12.md`: built · decided · owed · verification). Fetch again before writing it.
7. Move owed items and anything past the verification ceiling to the project's open-work file.
8. Flag canon files the stage made stale, in the stage record, where `close-out` collects them.
9. Update the stage list and the project's state-of-the-build file (from `config.md`) where they apply.
10. Submit the lane report's item 7, and any lesson from the review itself, to the learnings inbox as a capture note.
11. Report "ready to fast-forward" or what blocks it.

**May write,** with the founder's yes in this session: correction-only edits to the build plan and the project config, logged in the stage record. A change to scope goes to `revise`.
**For a project whose `main` deploys:** review, fixes, rebase on `origin/<base>`, *before the push* (stop files, `.env` lines), push on the founder's word, read the run, then record the run's URL. The forked part ends at "ready to deploy" (§0, forking). If blocked, end with "push pending: founder".
**Checks only the founder can make:** a signed-in check on production, a server CLI's output, and any destructive production step are founder items in the open-work file. Cards don't promise them of the reviewer.
**Reference:** `skills/verify/reference.md`.

**Milestone mode:** run the project's milestone script, one heavy runner at a time; record the counts in the development README.
- **Before the run,** list the by-hand items: the open-work file's verification rows whose *needed by* names this milestone (`config.md`'s milestone row points there). Ask which devices the founder has today, and check that production holds the content each item needs.
- **Two states:** *suites green*, and *closed* once the by-hand items it lists as blocking are done.
- **A red suite:** a milestone may fix test infrastructure on `main`. A failing app test makes the milestone red and goes to `debug`.
- **It pushes** only docs and test infrastructure, after reading the stop-file list.
- **"Every feature present":** walk the plan's route catalogue on production in each language, and confirm the signed-out API refuses, with requests the product won't count.
**Returns:** at most 15 lines.
**From:** the journeys reviews (retrospective §2); `J12.md`; the development README's done means.

### `design-review`
**Does:** checks built UI against the brand, the tokens and accessibility.
**Invocation:** by name, on a stage or a screen · **Model:** Opus, high · **Forked.**
**Reads:**
- the design system named in `config.md` §1. For Root's products that row points at: the summary sections of `ecosystem/canon/01-philosophy/01-brand-definition.md`; the code repo's `apps/web/src/styles/tokens.css`; the type and spacing rules from `ecosystem/working/root-website-requirements_2.md`. Root's brand and tokens apply only when the row points at them;
- its own reference checklist: accessibility gates (contrast, touch targets, text scaling, keyboard, screen reader); hierarchy, feedback and consistency; right-to-left rules.

**Writes:** findings to `08-design-review.md`, each as What / Why (citing a source) / Fix, on the module's one severity scale (`review-instrument.md` §4).
**Rule:** the project's design system is the rubric. General principles fill gaps; Apple's visual language does not apply.
**From:** the review format and accessibility gates of `dickwu/apple-design-skill`, borrowed, not installed; its lookup-table loading, kept small.

### `ux-review`
**Does:** walks each journey as each selected persona and scores it.
**Modes:** `design` (before build, on the latest design: 4b where it exists, else `04-wireframes.html`; observations graded *simulated*) · `live` (after UI stages).
**Model:** Opus, high · **Forked.**
**Reads:**
- `03-journeys.md`;
- the latest design, or the running app;
- the spec's interface and acceptance sections only;
- the selected personas;
- `review-instrument.md`;
- injected: the change notes' *carried* lists and the open-work file's verification and founder rows, so owed items aren't counted as defects; the serve-and-capture script (`config.md`), to render a bundled design.

**Checks:**
- the six metrics, scored per persona, per journey;
- coverage: every acceptance criterion has a screen, and every screen has its empty, error and loading states;
- Nielsen's ten heuristics.

**Live mode** reads production read-only, as a bot (`HEAD` or a bot agent) wherever the project counts readers. It walks every state, and anything behind sign-in, on a local server built from the deployed commit, with the review seed route and a virtual authenticator.
**Asks nothing.** Decisions found are routed `question`, for `revise` or the next change note's batch.
**Writes:** a dated pass appended to `05-ux-review.md`, with one short summary per pass at the top of the file, newest first. A required *For `revise`* heading lists the findings that change the spec. The findings table has a *Status* column (`open`, `closed in <file>`, `carried to <step>`), which `revise`, the design import and change notes update; `build-plan`'s gate greps it for `open`. After the build, UI fixes go to `spec change` as one proposed Change.
**Gate:** the latest design and journeys (`design` mode) · `live` mode: UI stages verified; open by-hand device checks don't block it, and are listed under *Not checked*.
**Reference:** `skills/ux-review/reference.md`.
**From:** `tracker/canon/05-reviews/00-persona-review-method.md`, the same instrument at both points so scores compare.

## 4. Closing the loop

### `revise`
**Does:** carries a change back upstream.
**Model:** Opus, medium.
**Modes:** for a module · `--catch-up <notes>` · for the method.
**Input:** a change request — from a lane report's item 5, a review, or a live UX finding; or a change to the method itself.
**Reads:** every `STATE.md` block since the last `revise`, and the sections their items cite. Items come from the cited sections, not from `STATE.md`'s summary of them. The spec header's scope ledger.
**Asks:** the founder per item, in one batch, before writing (§0, asking the founder).
- An [F] decision from an earlier phase is accepted by default, but still scanned for an open sub-question. A spec assumption confirmed downstream is written into the spec.
- **Scope.** An answer that adds a requirement, contradicts the spec or answers with a question is a new item (§0, rule 4). Each version updates the ledger; when an area has doubled since intake, or passes about a quarter of all criteria, `revise` asks "still the smallest version worth trying?" before accepting more. An item that adds a capability (new stored data, a new screen family, or anything intake put out of scope) leaves `revise` for `spec change`, with research or a waiver line.

**Outcomes:** each item is *accepted*, *refused*, *carried to <step or skill>*, *left to the build plan* (listed under *Open*, which `build-plan`'s gate reads), *deferred to <rubric>*, or *pending explanation*.
**`STALE`:** set only where a downstream output contradicts the change. Where it is silent, the item is carried with an owner; where it already provided for the outcome, it is carried, not stale. Each `STALE` item quotes the sentence it marks, and `revise` greps the output for every line relying on the changed fact, not only the cited step.
**Writes,** for a module:
- `changes/NN-req-<slug>.md` (template `templates/change-request.md`): header (kind, `main @`, spec version from and to); *Items*, each with its outcome; *Changes to the spec*; *Carried to design*, each item linked to its source; *STALE*, with quoted sentences; *Open*; *Owed by other skills*, naming each touch-up (`eval-plan --touch-up`, `journeys update`, the design step) and its order in `STATE.md`'s next steps. Accepted Suggested items are noted as owed to the next `journeys` run;
- the spec's version bump, changelog line and ledger;
- `STALE` in `status.md` where the rule above says so;
- a line in the module's `decisions.md`, pointing at the change note;
- struck open-work rows it settled, citing its change note.

**A new language or audience:** next steps are `personas add`, then `journeys update`, before any design pass or review.
**`--catch-up <notes>`,** after a build: its writes are the files the notes' *What this makes stale* names (spec, plan, config, design README, the code repo's `CLAUDE.md`), each with the founder's acceptance and listed in its note. Pushing a repo whose `main` deploys asks first (§0).

**For the method** (`lifecycle/` files): the edit, the file's version and changelog line, and an entry in `lifecycle/decision-log.md`. No status cells.

**From:** the journeys build's mid-plan changes (J9 split, J13's "signed" rule).

### `close-out`
**Does:** finishes a module.
**Model:** Opus, high.
**Modes:** full · `--eval`, when an evaluation that matured later is read: it appends the result and clears the cell.
**Gate:** as `README.md` §2, phase 10. An override (`bin/gate --override`) is recorded with its reason in `09-close-out.md`'s header.
**Reads:** the eval plan and its results; every stage record's *decided* and *owed* sections, injected; `STATE.md`; the canon-sync flags. If the code repo isn't reachable, the plan's changelog and the open-work file, saying so.
**Writes:**
- `09-close-out.md`: the evaluation result against the rule written beforehand; what the plan did not know, aggregated; the module's cost; a short retrospective, including the lessons consolidated during the module.
- **Closed, launch-ready and evaluated are separate.** It records launch's date, or "not yet"; writes the later checks' dates, counted from launch; and creates their reminders (a `/schedule` task, with the founder's yes). The row reads `closed · eval <date>` until the last check.
- **Cost** in dollars from `/usage`, plus the session-limit share where it is shown. Each log's *Cost* says whether its figure is exact or estimated, and which log carries a shared session's figure. Steps run outside Claude Code read the limit percentage at start and end.
- Updates the *Grading* line of each design document to say what is now as-built, citing the stage records.
- Moves documents from `working/` or `drafts/` into canon, per the area's conventions.
- Applies the canon-sync flags to the as-built canon: the canon `config.md` names (for IMNSTR: the spec, plan, design README and `CLAUDE.md`), through `revise --catch-up` when the files are design-side.
- Updates the roadmap.
- Closes the `status.md` row as done, parked or killed.

**From:** the canon/working convention in `ecosystem/README.md`; this retrospective, which `close-out` completes for the journeys build.

---

## 5. What gets built first

Stage 1 (foundation) is files, not skills. The IMNSTR trial counted what its 72 logs missed (`trial-run/findings.md` §10): `bin/gate` in 32, a template in 22.
- `status.md` backfilled for existing modules, with the values in `README.md` §3;
- `templates/` and `required-headings.txt`, one per output: intake, research, spec, persona record, journeys, wireframe frame kit (`wireframes.html`), change request, change note, eval plan, build plan, phase card, lane report, design README, design-import checklist, review, close-out, and the project config's three files. Their headings are in each skill's section above, and in each trial log's *Template sample*. `brief-common.example.md` is already there;
- `bin/gate`, as §0 specifies: fetch, step check, override, HTML headings, the personas table, criterion coverage;
- `learnings/inbox/` and `index.md`, with `learned`'s note fields;
- `projects/root-app/` from the recovered brief and the plan's §0.2–0.3 and §8;
- `projects/tracker/` from `tracker/canon/02-architecture/04-conventions.md` and `03-engineering/01-testing.md`;
- CLAUDE.md in all three repos — `root-app`'s carrying the environment knowledge from the build machine's memory.
- **The founder's machine setup:** reduced-motion emulation, an image zoom tool, shellcheck, Docker running, `gh` signed in, and a network allowlist for reference hosts (w3.org, owasp.org, PubMed, university repositories).

Already in place from the trial: `engineering-checklist.md`, `projects/imnstr/`, and IMNSTR's `decisions.md`.

Stage 2 builds `lifecycle-status`, `handoff`, `learned`, `decision-record`, `build-phase`, `verify` and `debug`, each written with `skill-creator` and tried on real work before stage 3. The rest follow the rollout in `README.md` §8.

## Changelog

- **0.7 · 2026-10-20** — Cut back, step 2, §0 (L-23, awaiting the founder's review): the same rules in tighter wording; redoing a phase, grades in reviews, design items routed to `revise` and steps outside Claude Code move to `skills/shared/reference.md`; the config table's sources move to `skills/project-config/reference.md`; two provenance sentences, one obvious line and one bullet duplicated in `verify`'s seeds are cut.
- **0.6 · 2026-10-20** — Cut back, step 1 (L-22): each skill's *Reference holds* and template contents, and the contents of `config.md` and `brief-common.md`, move unchanged to `skills/<skill>/reference.md`; each section points there. The 0.5 entry points at the decision log.
- **0.5 · 2026-10-19** — From the IMNSTR trial (`trial-run/findings.md` 0.2), applied in fourteen groups. What each group changed is its entry in `decision-log.md`, L-8 to L-21 (L-20 is the trial brief's).
- **0.4 · 2026-10-06** — Change track: `spec change` writes a Stages section into the change note; `build-phase` gates on and drafts cards from it; `verify` reads it in place of the plan's §5.
- **0.3 · 2026-10-06** — Consistency pass against `README.md`: gate always exits 0 (a failing injected command aborts the skill) and passes `n/a`; decision-log entries from `personas`, `revise` and `learned` use `decision-record`'s format; `revise` gains a method mode; `close-out` gains a gate line; `build-plan`'s gate matches the README; canon flags go in the stage record; state-of-the-build file is per project; source paths completed.
- **0.2 · 2026-10-05** — `learned` added: capture to an inbox, consolidate in batches; lane report gains item 7; `verify`, `handoff`, `lifecycle-status` and `close-out` wired to it.
- **0.1 · 2026-10-05** — Plan. Eighteen skills specified from the design conversation, the journeys build's documents, brief and state log, and the Claude Code skills documentation.
