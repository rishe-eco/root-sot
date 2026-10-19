# Lifecycle — the skills, specified

*Each of the nineteen lifecycle skills: what it does, how it is invoked, which model runs it, exactly what it reads and writes, its gate, and where its shape comes from. The method these skills implement is `README.md`.*

**Version 0.5 · Status: plan — nothing here is built yet · 2026-10-19 · Owner: _root**

---

## Summary

Nineteen skills in four groups — every session, design, build, closing the loop — sharing one gate script, one set of templates and one configuration folder per project. Most are invoked by name only, so they cost nothing per turn until used. Reviews run forked, in a fresh context. Lanes are launched by `build-phase` with the project's common brief plus a committed phase card, and return a seven-part report that `verify` reads before the diff. What sessions learn about working is captured as notes and integrated in batches, never edited in place. Each spec below names its source in this repo, so the skill is a transcription of what already worked, not an invention.

**Grading.** Mechanics claimed for Claude Code skills (frontmatter fields, forking, injection, skill discovery) are **documented** — read from the Claude Code skills documentation on 2026-10-05. Anything marked **verify in stage N** is a reading of that documentation not yet tried here.

## 0. Shared mechanics

**Invocation.** Every skill is `disable-model-invocation: true` — invoked by name, invisible in context until then — except `debug`, which Claude may pick up on its own when a test fails. This keeps nineteen skills from adding nineteen descriptions to every turn.

**Model and effort** are set in each skill's frontmatter (`model`, `effort`) and apply to the turn that invokes it. The session can see its model but not its effort. Every skill's first message states the model from its frontmatter. Where the prompt states a different effort, the skill says so and continues. A session on the wrong model stops before any work. A step run outside Claude Code (a design tool) has no model row: its log names the tool, and its cost is estimated (see `close-out`).

**Forking.** `verify`, `ux-review` and `design-review` use `context: fork` with `background: false`: they run in an isolated subagent that sees only the skill's content and its injected inputs, with the full tool set, and return a short summary. This is retrospective finding 1 built into the mechanism. *Verify in stage 2* that a forked skill with `background: false` can edit, commit and run suites as the journeys reviews did. A forked skill can't wait on the founder: `verify` forks for review and fixes and ends at "ready to deploy", and the deploy runs in the main session. A forked review gets the change notes' *carried* lists and the open-work file's rows injected, so owed items aren't counted as defects.

**Injection.** Skills pull their inputs with `!` commands at invocation — the gate result, the status row, the top of `STATE.md`, a diff stat — so the model does not spend turns fetching them. A skill that touches a code repo also injects that repo's path on this machine, from `config.md`, and a `git -C <path> rev-parse HEAD` line, so it knows at once whether the repo is reachable. If it isn't, the skill names its fallback (the plan's changelog and the open-work file) or asks.

**The gate.** `lifecycle/bin/gate <module> <phase>` checks that the phase's inputs exist, contain the headings listed in `templates/required-headings.txt`, and are not marked `STALE` in `status.md`; a phase marked `n/a` passes. It prints `GATE OK`, or `GATE FAIL` and what is missing, and the skill stops and says so. It **always exits 0**: an injected `!` command that exits non-zero aborts the whole skill invocation before Claude sees it (documented), so a failing gate could not be reported. Skills call it by a path relative to their own directory (`${CLAUDE_SKILL_DIR}`), since injected commands run in the session's current directory, which may be a code repo. A script runs without entering context; only its output does. The gate also:
- runs `git fetch` first, and reports a branch behind its upstream as `GATE FAIL`;
- passes a config value of `none`;
- checks `<h2>` text for HTML outputs;
- for column 3, reads the `## Personas` table in `03-journeys.md`, not the file's existence;
- for journeys and change notes, diffs the spec's criterion ids against the *Coverage* table.

`bin/gate --override "<reason>"` prints `GATE OVERRIDDEN`, and the skill writes the reason into its output's header.

**The step comes from the files.** Each phase skill works out its step from the files (`briefs/<stage>.md`, `<stage>.report.md`, the status row, `STATE.md`'s next step), not from the verb or step number in the prompt. If the prompt names another step, or an unknown one, the skill says so, lists near matches and stops.

**Where the skills live until the plugin (stage 6).** All in `root-sot/.claude/skills/`. A session in a code repo loads them by adding `root-sot` as an additional directory (`--add-dir ../root-sot`, or `/add-dir`) — documented: added directories' `.claude/skills/` are loaded and watched. *Verify in stage 1* how cloud sessions with several repositories expose additional-directory skills; if they do not, copy the build-side skills into each code repo until stage 6.

**Skills do not call skills.** Skill-to-skill invocation is not documented. Where one skill needs another's checklist, both load the same reference file; where a sequence is needed, the skill ends by naming the next one.

**Reference holds.** Where a skill's section ends with *Reference holds*, those lines are seeds for its reference file, which doesn't exist yet. The file's first author places them.

**Parallel sessions.** Two sessions running at once on one branch or one machine:
- commit by path (`git commit --only <paths>`), or from their own checkout;
- fetch and rebase right before pushing;
- merge `STATE.md` by block, newest first, never by copying a file over it;
- on one machine, read the heavy-runner lock named in `config.md` before running a suite;
- a session whose code repo's local `main` is held by another session pushes `HEAD:main` from its stage worktree, and tells that session to rebase.

**Redoing a phase,** only when the founder asks:
- the earlier output and log move, unread, to `<module>/archive/<phase>/passN-<model>/` with `git mv`;
- the new output's header carries a *Supersedes* line;
- the status cell is unchanged;
- a pass is independent only if it couldn't see the earlier one's findings. An independent redo doesn't read `STATE.md` blocks written after the earlier pass's gate. A cumulative redo reads them and says so;
- merging passes is its own session, `<phase>-integration`.

**References.** Anything named for another session (an owed item, a review that changes a design, a handoff folder, a method file's source) is named by its committed path relative to the repo. Never by number alone, and never by a machine path. Journey steps, criteria and findings are cited by the id copied from the file (`J3.4`, not "J2 step 4"). An open-work number is cited with its file. A design item routed to `revise` carries its scope and its end condition.

**Grades.** Every claim in an output is graded:
- *evidence*: from a source or an observed event, with a strength: *strong*, *moderate*, *thin*, or *summary only* (came through a search summary, and is never quoted);
- *as-built*: true of what exists now, citing the file;
- *proposal*: Claude's suggestion;
- **decision**: the founder's, with a date, written [F].

Personas are *hypothesis* until a review pass or real-user data grounds them. A review grades the observation (*as-built* on the running app, *simulated* on a static design) apart from the score, which is *simulated*: one reviewer's judgement.

**Asking the founder.** Every skill that asks:
1. Asks in one batch, at most four questions per call. Two calls in one turn still count as one batch. Facts the founder must look up go in a pre-flight list, not the batch.
2. Reads enough of the code and files to word each option truthfully before asking.
3. Puts whatever the founder needs to answer inside the question, or in the closing message, never in text just before the question box. Commands for the founder go in the closing message.
4. Treats an answer that adds a requirement, contradicts the spec or answers with a question as a new item. It sizes it, proposes a bounded definition graded *proposal* with what it excludes, and asks again. Such an answer is never written downstream as accepted.
5. When the founder defers to a skill or rubric, applies that rule and names it in the output.
6. Treats *explain more* as an outcome: the item stays pending for a second round.
7. Ends by asking acceptance of its open assumptions, listed, if it asked at the start.

**Outward-facing and destructive actions.** Pushing to a repo whose `main` deploys, pushing a branch to a public remote, posting content to an outside service, and any destructive step on production need the founder's yes in this session. A skill never runs a destructive production step: it lists it for the founder. If the permission layer blocks an approved push, the skill ends with "push pending: founder" and doesn't look for another route.

**Per-project configuration** — `lifecycle/projects/<project>/`:

| File | Holds | Source for root-app |
|---|---|---|
| `brief-common.md` | What every lane gets: role, read order, environment, git rules, style, budget and stop rules, the lane report | the recovered journeys `brief-common.md`, generalised |
| `review-checklist.md` | What every review checks: what must not break, house rules, done means, the verification ceiling | the journeys plan §0.2, §0.3, §8; the development README's done means |
| `config.md` | Paths, suite commands, milestone script, lane resource pattern (branch, test database, ports), where stage records go | the development README; the build-machine memory |

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
**Reference holds:** the entry format, `## <letter>-<n> · <date> · <title>`, then *Decision*, *Why*, *Decided by*, *Revisit*; the id rule, one letter per log (`L-` for the method), numbered in sequence.
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
**Reference holds:**
- **Review against the inputs** before committing: every evidence-summary section accounted for; every proposal checked against each intake line; the outcome the drop rule names researched, not only the technology.
- **Reaching sources.** A 403 from a script isn't "unreachable". Try, in order: fetch; the browser; the source's own repository or another copy (an abstract, Crossref); a search summary, graded *summary only* and never quoted. Unreachable sources go under *Not researched*. Headline numbers keep their caveats. Security claims need a primary or standards source, or are graded *thin*.
- **How much searching.** At least two independent sources per load-bearing claim. Stop after three searches that add nothing. Mark what wasn't reached.
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
**Template** (the registry record): ID, name, serves, grounding, grade (*hypothesis* or *grounded*), arrives how, device, knows entering (including the languages read), probes. Demographics are optional and never invented.
**From:** `tracker/canon/05-reviews/00-persona-review-method.md` §2.

### `spec`
**Does:** the spec, or a change note against an existing one.
**Modes:** `full` (Module) · `change` (Change track: a note in the module's `changes/`, or a new folder for a module that predates this system).
**Model:** Opus, high.
**Asks first:** up to eight clarifying questions in one batch.
**Writes:** `02-spec.md` in the house template — what it is, metrics, interface requirements, risks, acceptance criteria, changelog; references the journeys file rather than restating it.
**Writes, in `change` mode:** `changes/NN-slug.md` — what changes and why, acceptance criteria, what must not break, and a **Stages** section: one or more stages in the build plan's §5 shape, each with a size (S/M/L) and its traps. This section is what `build-phase` and `verify` read in place of a build plan; a change too large to stage here is a Module.
**Gate:** research, or a waiver line in the intake (`full`); none (`change`).
**From:** `tracker/canon/06-specs/04-verification-lab.md`; Superpowers' brainstorming questions.

### `journeys`
**Does:** the paths people take.
**Modes:** `new` — 3–5 journeys (first day, normal loop, return after a gap, not enough data, error) of ~10 steps each · `gap` — each scenario checked against the code as *have / partly / missing*, suggestions kept apart and marked **Suggested**, decisions asked and answered in their own section.
**Model:** Opus, high.
**Writes:** `03-journeys.md`.
**Gate:** spec; personas selected.
**From:** `ecosystem/working/root-studio-user-journeys.md` on branch `journeys-build`, not yet on `main` (the `gap` mode); the Impact spec's flows, `ecosystem/working/impact-build/01-noticing-spec.md` (the `new` mode); bug B-14 as the case it exists to catch.

### `wireframes`
**Does:** low-fidelity HTML for every journey step, including empty, error, loading and not-enough-data states.
**Model:** Opus, medium.
**Writes:** `04-wireframes.html`.
**Gate:** journeys.
**From:** the existing `*-wireframes.html` files in `tracker/canon/06-specs/`.

### `eval-plan`
**Does:** how we will know the module works for people, with the decision rule written before any data and the ambiguous outcome named.
**Model:** Opus, high.
**Writes:** `06-eval-plan.md`.
**Gate:** spec.
**From:** `ecosystem/working/impact-build/03-spine-evaluation.md`.

### `build-plan`
**Does:** the plan a build is run from.
**Model:** Opus, high.
**Reads:** spec, journeys, wireframes, UX review, eval plan; `projects/<project>/`; the existing code — a defect pass, read before planning.
**Writes:** `07-build-plan.md` in the journeys plan's shape — §0 what was read, what must not break, house rules, defects found and assigned · §1 the shape at the end · §2 planning decisions (PD-n), each vetoable · §3 stage order, milestones, parallel lanes allowed (never two touching shared schema) · §4 pre-flight unknowns · §5 one section per stage, to the level of models, mutations, refusal codes, screens and tests, with a **size (S/M/L)** and its **traps** · §6 cross-cutting catalogues · §7 what changes in built code · §8 verification and its ceiling · §9 where this goes wrong · §10 for the founder.
**Gate:** phases 2–6; UX findings closed or carried.
**Rule:** this session ends once the plan is committed and pushed. The build starts fresh.
**From:** `ecosystem/working/root-studio-journeys-build-plan.md` on branch `journeys-build`, not yet on `main`.

## 3. Build

### `build-phase`
**Does:** launches a stage as a lane, or lands one.
**Invocation:** `build-phase <stage>` to launch · `build-phase <stage> --land` after the lane reports. On the Change track, `<stage>` names a stage in a change note (`changes/NN-slug.md#<stage>`).
**Gate:** the build plan, or a change note with a Stages section.
**Model:** Opus, medium (it drafts the card; the lane is Sonnet).
**Launch:**
1. Run the gate. Check `STATE.md`: at most two lanes in flight, no other lane touching shared schema.
2. Draft the phase card from the plan's §5 section — or the change note's stage — and the code as it is now: 500–700 words, naming exactly which plan sections, journeys sections and earlier stage records to read. Commit it as `briefs/<stage>.md`.
3. Assign lane resources from `config.md`: branch, test database, ports.
4. Launch a background Sonnet subagent in its own worktree with `brief-common.md` + the card.
5. Record the lane in `STATE.md`.

**Land:** save the lane's report as `briefs/<stage>.report.md`, commit it, update `STATE.md`, name the next step (`verify <stage>`).
**From:** the journeys orchestration: `brief-common.md`, `brief-j*.md`, the lane registry in the state log.

**What `brief-common.md` must contain**, from the recovered one:
- role and reviewer;
- read order, with "the plan wins on *what*, the repository on *what the code is*; if they disagree, follow the code and say so";
- the environment block;
- git rules: own branch; no merge, push, rebase or stage record;
- style;
- **new:** the lane budget and stop rules, the debug rules, and "no full suites — targeted only";
- **the lane report:**
  1. branch and commit hashes;
  2. each file changed, one line on why;
  3. every suite run, with exact counts, or why not;
  4. decisions the brief did not make;
  5. where the plan or brief was wrong, vague or incomplete against the code;
  6. what could not be verified;
  7. one thing that would have made this stage faster, or "nothing".

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

**From:** the J1 lane (retrospective finding 2); Superpowers' systematic-debugging; the state log's lesson after J13.

### `verify`
**Does:** reviews a landed stage, fixes it, records it. Or, with `--milestone`, runs the full suites.
**Invocation:** `verify <stage>` · `verify --milestone <M>` · **Model:** Opus, high · **Forked**, `background: false`.
**Reads (injected):**
- the lane report;
- `git diff --stat main...<branch>`;
- the phase card and the plan's §5 section for the stage, or the change note's stage;
- `review-checklist.md`;
- for UI stages, `design-review`'s reference checklist.

Nothing else until the diff points somewhere.
**Does, in order:**
1. Read the stat, then the core files.
2. Check against the review checklist.
3. Fix on the branch.
4. Merge `main` in.
5. Rerun the affected test files, and every file asserting a changed shared rule.
6. Write the stage record in the code repo (shape of `J12.md`: built · decided · owed · verification).
7. Move owed items and anything past the verification ceiling to `team/open-work.md`.
8. Flag canon files the stage made stale, in the stage record, where `close-out` collects them.
9. Update the stage list and the project's state-of-the-build file (from `config.md`) where they apply.
10. Submit the lane report's item 7, and any lesson from the review itself, to the learnings inbox as a capture note.
11. Report "ready to fast-forward" or what blocks it.

**Milestone mode:** run the project's milestone script, one heavy runner at a time; record the counts in the development README.
**Returns:** at most 15 lines.
**From:** the journeys reviews (retrospective §2); `J12.md`; the development README's done means.

### `design-review`
**Does:** checks built UI against the brand, the tokens and accessibility.
**Invocation:** by name, on a stage or a screen · **Model:** Opus, high · **Forked.**
**Reads:**
- the summary sections of `ecosystem/canon/01-philosophy/01-brand-definition.md`;
- the code repo's `apps/web/src/styles/tokens.css`;
- the type and spacing rules from `ecosystem/working/root-website-requirements_2.md`;
- its own reference checklist: accessibility gates (contrast, touch targets, text scaling, keyboard, screen reader); hierarchy, feedback and consistency; right-to-left rules.

**Writes:** findings to `08-design-review.md`, each as What / Why (citing a source) / Fix, ranked blocker / defect / polish.
**Rule:** the brand and the tokens are the rubric. General principles fill gaps; Apple's visual language does not apply.
**From:** the review format and accessibility gates of `dickwu/apple-design-skill`, borrowed, not installed; its lookup-table loading, kept small.

### `ux-review`
**Does:** walks each journey as each selected persona and scores it.
**Modes:** `wireframes` (before build; findings graded *simulated*) · `live` (the running app, after UI stages).
**Model:** Opus, high · **Forked.**
**Reads:**
- `03-journeys.md`;
- `04-wireframes.html`, or the running app;
- the spec's interface and acceptance sections only;
- the selected personas;
- `review-instrument.md`.

**Checks:**
- the six metrics, per persona;
- coverage: every acceptance criterion has a screen, and every screen has its empty, error and loading states;
- Nielsen's ten heuristics.

**Writes:** a dated pass appended to `05-ux-review.md`. Findings that change the spec go to `revise`.
**Gate:** wireframes and journeys (wireframes mode) · UI stages verified (live mode).
**From:** `tracker/canon/05-reviews/00-persona-review-method.md`, the same instrument at both points so scores compare.

## 4. Closing the loop

### `revise`
**Does:** carries a change back upstream.
**Model:** Opus, medium.
**Input:** a change request — from a lane report's item 5, a review, or a live UX finding; or a change to the method itself.
**Writes,** for a module:
- `changes/NN-slug.md`;
- the spec's version bump and changelog line;
- `STALE` in `status.md` on every downstream phase the change invalidates;
- a line in the module's `decisions.md`, pointing at the change note.

**For the method** (`lifecycle/` files): the edit, the file's version and changelog line, and an entry in `lifecycle/decision-log.md`. No status cells.

**From:** the journeys build's mid-plan changes (J9 split, J13's "signed" rule).

### `close-out`
**Does:** finishes a module.
**Model:** Opus, high.
**Gate:** every stage verified, milestones green, the learnings inbox consolidated.
**Reads:** the eval plan and its results; every stage record's *decided* and *owed* sections; `STATE.md`; the canon-sync flags.
**Writes:**
- `09-close-out.md`: the evaluation result against the rule written beforehand; what the plan did not know, aggregated; the module's cost (sessions, share of weekly limits, lanes); a short retrospective, including the lessons consolidated during the module.
- Moves documents from `working/` or `drafts/` into canon, per the area's conventions.
- Applies the canon-sync flags to the as-built canon.
- Updates the roadmap.
- Closes the `status.md` row as done, parked or killed.

**From:** the canon/working convention in `ecosystem/README.md`; this retrospective, which `close-out` completes for the journeys build.

---

## 5. What gets built first

Stage 1 (foundation) is files, not skills:
- `status.md` backfilled for existing modules;
- `templates/` and `required-headings.txt`;
- `bin/gate`;
- `projects/root-app/` from the recovered brief and the plan's §0.2–0.3 and §8;
- `projects/tracker/` from `tracker/canon/02-architecture/04-conventions.md` and `03-engineering/01-testing.md`;
- CLAUDE.md in all three repos — `root-app`'s carrying the environment knowledge from the build machine's memory.

Stage 2 builds `lifecycle-status`, `handoff`, `learned`, `decision-record`, `build-phase`, `verify` and `debug`, each written with `skill-creator` and tried on real work before stage 3. The rest follow the rollout in `README.md` §8.

## Changelog

- **0.5 · 2026-10-19** — From the IMNSTR trial (`trial-run/findings.md` 0.2), applied group by group. *Shared mechanics:* the gate fetches, takes an override and reads HTML, the personas table and criterion coverage; the step comes from the files; model and effort stated, not assumed; injected repo paths; what forking can't do; parallel sessions; redoing a phase; references by committed path and copied id; grades; asking the founder; outward-facing and destructive actions. *Design, first phases:* `ideate` answers "n/a" outside Root, keeps the drop rule verbatim and ends with its decisions; `research` reviews itself against its inputs, reaches sources in order, has a search budget and a *For the next phases* section; `personas` may select none, proposes by behaviour with acceptance, gains an `add` mode, owns the journeys' `## Personas`, and has a record template. *Every-session skills:* *Reference holds*; `lifecycle-status` shows the inbox's age and the founder's rows; `handoff`'s block format; `decision-record`'s format, and module decisions in `<module>/decisions.md`; `learned`'s note fields, consolidation at milestones, recurrence by session, reading what is integrated and the founder's notes, asking in fours, holds as seeds, and the engineering checklist.
- **0.4 · 2026-10-06** — Change track: `spec change` writes a Stages section into the change note; `build-phase` gates on and drafts cards from it; `verify` reads it in place of the plan's §5.
- **0.3 · 2026-10-06** — Consistency pass against `README.md`: gate always exits 0 (a failing injected command aborts the skill) and passes `n/a`; decision-log entries from `personas`, `revise` and `learned` use `decision-record`'s format; `revise` gains a method mode; `close-out` gains a gate line; `build-plan`'s gate matches the README; canon flags go in the stage record; state-of-the-build file is per project; source paths completed.
- **0.2 · 2026-10-05** — `learned` added: capture to an inbox, consolidate in batches; lane report gains item 7; `verify`, `handoff`, `lifecycle-status` and `close-out` wired to it.
- **0.1 · 2026-10-05** — Plan. Eighteen skills specified from the design conversation, the journeys build's documents, brief and state log, and the Claude Code skills documentation.
