# Lifecycle — the skills, specified

*Each of the twenty lifecycle skills, and the design step: what it does, how it is invoked, which model runs it, exactly what it reads and writes, its gate, and where its shape comes from. The method these skills implement is `README.md`.*

**Version 0.5 · Status: plan — nothing here is built yet · 2026-10-19 · Owner: _root**

---

## Summary

Twenty skills in four groups — every session, design, build, closing the loop — sharing one gate script, one set of templates and one configuration folder per project. Most are invoked by name only, so they cost nothing per turn until used. Reviews run forked, in a fresh context. Lanes are launched by `build-phase` with the project's common brief plus a committed phase card, and return a seven-part report that `verify` reads before the diff. What sessions learn about working is captured as notes and integrated in batches, never edited in place. Each spec below names its source in this repo, so the skill is a transcription of what already worked, not an invention.

**Grading.** Mechanics claimed for Claude Code skills (frontmatter fields, forking, injection, skill discovery) are **documented** — read from the Claude Code skills documentation on 2026-10-05. Anything marked **verify in stage N** is a reading of that documentation not yet tried here.

## 0. Shared mechanics

**Invocation.** Every skill is `disable-model-invocation: true` — invoked by name, invisible in context until then — except `debug`, which Claude may pick up on its own when a test fails. This keeps twenty skills from adding twenty descriptions to every turn.

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

**Per-project configuration** — `lifecycle/projects/<project>/`, created by `project-config` (§2):

| File | Holds | Source for root-app |
|---|---|---|
| `brief-common.md` | What every lane gets: role, read order, environment, git rules, style, budget and stop rules, the lane report (the full list is under `build-phase`). It names checkouts by the names `config.md` gives them, never by one machine's absolute path | the recovered journeys brief, committed as `templates/brief-common.example.md` |
| `review-checklist.md` | What every review checks: what must not break, house rules, done means, the verification ceiling, the probe list (`verify`), the reflow rule (`review-instrument.md` §3), the flake rule (`verify`) | the journeys plan §0.2, §0.3, §8; the development README's done means |
| `config.md` | See below | the development README; the build-machine memory |

**`config.md` holds:**
- **Paths, per machine:** the code repo; the root-sot checkout lanes read, and the step that moves it to the card's commit; the checkout each kind of session writes in, and how it commits (`HEAD:<branch>` from a detached worktree).
- **Files:** the open-work file and the state-of-the-build file (`none` is valid for the second); the design system, which `design-review` reads; the project's canon, which `close-out` keeps in sync.
- **Suites and the milestone script.** The script writes the whole output to a file, then greps it; a background suite script judges each suite's exit code, never a last line that can't fail.
- **Lanes:** a lane-slot table (branch, test database, ports), whatever the stack; a branch rule for Change stages, `<two letters><n>-<slug>`, taking the free slot; a review port and seed route.
- **Environment:** Docker policy ("only when your card says so"); a free-disk check before image builds; the founder's devices and accounts; a heavy-runner lock file that the milestone script and heavy lanes take; a server runbook (sudo user, versions, other tenants); where CI status and logs are read.
- **Review and check scripts,** kept in the code repo in a git-ignored or dedicated folder (`tests/review/`): capture every state at 360 and 1100 px, at 180 px, in both colour schemes and with forced colours; drive passkey screens with a virtual authenticator; an image smoke test; validator posts with seed content; a full-run summary of what failed and why; for design-side reviews, serve and capture a bundled design.

**A project with no code yet** has its config written as planned. The first stage's `verify` reconciles it, with the founder's yes, and any verify that receives founder facts folds them into `config.md` the same way.
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
**Template:** Summary, What it is, Decisions taken at spec, Metrics, Interface requirements, Risks, Acceptance criteria, Out of scope, Changelog, References; the scope ledger in the header.
**Reference holds:**
- Cite every as-built fact a step depends on, with its file. Read the code an option's consequence depends on before asking (change mode).
- Where a gesture sits on a link or control, say which one wins.
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
**Reference holds:** failure journeys walk every security requirement; each walk's additions are Suggested, so they land on the spec's scope ledger where the founder sees them.
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
**The README** (template):
- the design system it settles (type, colour, spacing, components);
- *Beyond the spec*, with *scope* and *ends when* columns;
- a plate index: plate, caption anchor, journey steps, criteria, states and copy;
- every plate carries its `Wireframe plate N.` marker;
- *Disagreements*: where phone and desktop frames differ;
- contrast figures measured by a script, never by eye;
- *What didn't survive* the move from the tool.

**The handoff.** A design tool that can't push leaves files at their repo paths in `../repo-handoff-<step>/`, beside the repo.
**The import** (Opus, medium) has its own log and `STATE.md` block, and may edit `04b-design/README.md`. It diffs `STATE.md` and merges by block, never by overwriting. Its checklist (`templates/design-import-checklist.md`):
- serve locally and confirm zero external requests;
- reduced motion may be checked in the source;
- every revealed or animated state is drawn at the narrowest width;
- check against the README's list while the founder compares with the tool's preview;
- name at least one frame per new plate to look at by eye;
- keep what was lost in the move apart from what is missing in the design.

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
**Template:** `templates/07-build-plan.md`, the §0–§10 skeleton and one sample stage. *Held:* a 400–600-word bound per stage, until a second plan exists to compare with.
**Gate:** as `README.md` §2, phase 7: phases 2–6; UX findings, journeys' *Suggested*, the design's *Beyond the spec* and wireframes' *Calls made here* each accepted, refused or carried; `revise`'s *Open* items.
**Reference holds:**
- In the defect pass, take each "never shows X" in the spec and ask which mechanism could leak X: ids, URLs, timing, logs, cookies the browser sends. For every count or row created from request data, name what bounds its growth.
- When the spec fixes every table, the whole schema lands in the first stage, so lanes can run in pairs.
**Rule:** this session ends once the plan is committed and pushed. The build starts fresh.
**From:** `ecosystem/working/root-studio-journeys-build-plan.md` on branch `journeys-build`, not yet on `main`.

### `project-config`
**Does:** creates a project's configuration folder.
**Invocation:** by name, once per project, after its first build plan, when `projects/<project>/` doesn't exist · **Model:** Opus, medium.
**Reads:** the build plan (§0.3 is the source of house rules, §4 the founder's facts); the latest retrospective; `templates/brief-common.example.md`; anything the founder supplies.
**Writes:** `brief-common.md`, `review-checklist.md` and `config.md`, as §0 lists their contents. The founder accepts before commit.
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

**The card** (template) has, beside the plan's content:
- *Decided here*: what the plan left open, including development dependencies added and how e2e gets its data;
- *Tests that change on purpose*: every test the grep found that asserts the stage's absence or forbids what it adds, with the new rule. The lane changes those and no others;
- from the first deploy on, *What the verify deploys*. Each deploy check is one that fails when what it guards is broken. The card doesn't assert a computed outcome it hasn't tried.

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

**What `brief-common.md` must contain**, from the recovered one:
- role and reviewer;
- read order, with "the plan wins on *what*, the repository on *what the code is*; if they disagree, follow the code and say so";
- the environment block;
- git rules: own branch; no merge, push, rebase or stage record; check `git config user.email` before the first commit;
- style;
- **new:** the lane budget and stop rules (stop at the last commit boundary, if the card defines them), the debug rules, and "no full suites — targeted only";
- tests: every UI stage's e2e runs at 180 px as well as 360 px, checks each control against the content column, and measures after `document.fonts.ready`;
- environment pitfalls the project has met, for IMNSTR's build machine: prose and quote-heavy text go through Write or a quoted heredoc, never a double-quoted shell string; Write and Edit turn `\uXXXX` into the character, and the Bash tool strips a doubled backslash, so regexes go in a file; Git Bash isn't Linux (resolve it explicitly from Node; stub `flock` and `runuser`, written executable); check free disk before an image build;
- **the lane report:**
  1. branch and commit hashes;
  2. each file changed, one line on why;
  3. every suite run, with exact counts, or why not;
  4. decisions the brief did not make;
  5. where the plan or brief was wrong, vague or incomplete against the code;
  6. what could not be verified;
  7. one thing that would have made this stage faster, or "nothing".

  The lane writes the report to `.tmp/<stage>.report.md` as well as returning it.

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
**Reference holds:**
- Check a lane's stated cause for an environment workaround before recording it as fact.
- A "later stage reuses this" claim is tested or not written. An owed reuse says "extract and generalise" when it is a refactor. A placeholder carries the later stage's accessibility semantics, or none, checked against the design. A test never uses a later stage's planned route as its example of an unknown one.
- Name the accepted fallbacks when the machine can't run a check, with their conditions (for example, "the deploy is the build check when the build runs before `up`, and a failed build leaves the old container serving").
- Each validator check names its endpoint and is posted with seed content only, never real entries.
- Commands for a human at a server: `sudo` explicit and `| sudo tee` for writes; one command per line, no chains whose failure is ambiguous; no Run-button shell tags, which would run locally; all of it in the closing message.
- Before any live check on production, read how the product counts visits, and use requests it won't count (`HEAD`, a bot agent).
- A verify whose code repo's local `main` is held by another session pushes `HEAD:main` from its stage worktree and tells that session to rebase (§0, parallel sessions).

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
**Reference holds:** a review with an earlier pass in the folder reads it only after its own findings are written. Before calling a state missing, check the design's captions and README.
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

Stage 1 (foundation) is files, not skills:
- `status.md` backfilled for existing modules;
- `templates/` and `required-headings.txt`;
- `bin/gate`;
- `projects/root-app/` from the recovered brief and the plan's §0.2–0.3 and §8;
- `projects/tracker/` from `tracker/canon/02-architecture/04-conventions.md` and `03-engineering/01-testing.md`;
- CLAUDE.md in all three repos — `root-app`'s carrying the environment knowledge from the build machine's memory.

Stage 2 builds `lifecycle-status`, `handoff`, `learned`, `decision-record`, `build-phase`, `verify` and `debug`, each written with `skill-creator` and tried on real work before stage 3. The rest follow the rollout in `README.md` §8.

## Changelog

- **0.5 · 2026-10-19** — From the IMNSTR trial (`trial-run/findings.md` 0.2), applied group by group. *Shared mechanics:* the gate fetches, takes an override and reads HTML, the personas table and criterion coverage; the step comes from the files; model and effort stated, not assumed; injected repo paths; what forking can't do; parallel sessions; redoing a phase; references by committed path and copied id; grades; asking the founder; outward-facing and destructive actions. *`spec`:* the template and scope ledger; metrics versus the eval plan; the platform left to the build plan; change notes carry `main @`, a criterion prefix with an *Item* column, the fuller Stages shape and *What this makes stale*; change mode's gate against lanes in flight; one numbering in `changes/` with the kind in the name. *Design, first phases:* `ideate` answers "n/a" outside Root, keeps the drop rule verbatim and ends with its decisions; `research` reviews itself against its inputs, reaches sources in order, has a search budget and a *For the next phases* section; `personas` may select none, proposes by behaviour with acceptance, gains an `add` mode, owns the journeys' `## Personas`, and has a record template. *Every-session skills:* *Reference holds*; `lifecycle-status` shows the inbox's age and the founder's rows; `handoff`'s block format; `decision-record`'s format, and module decisions in `<module>/decisions.md`; `learned`'s note fields, consolidation at milestones, recurrence by session, reading what is integrated and the founder's notes, asking in fours, holds as seeds, and the engineering checklist. *`journeys` and `wireframes`:* journeys asks in every mode, keeps Suggested through to acceptance, cites `J<n>.<step>` checks, a required Coverage and a states table, amends without breaking ids, and gains `update` and scoped runs; wireframes has steps, coverage by step, marked Suggested items, *Calls made here*, and a definition of low fidelity. *The design step:* a new section: opening form, inputs for first and second passes, how much to draw, the README template with a plate index, the handoff folder, the import and its checklist, an optional accessibility pass. *`eval-plan` and `build-plan`:* eval plan's steps and asks, close-out versus later checks, instrument preconditions, a touch-up mode; build plan's foundation batch, a wider defect pass, sizes, a fuller stage section, a self-check, a template and the phase-7 gate. *Project config:* what each file holds, `config.md` in full, a `project-config` skill (twenty skills), and the journeys brief committed as an example. *`build-phase` and `debug`:* launch asks facts first, checks the plan and greps the tests against the code, counts card length by body, makes the worktree by hand, launches by path; the card's *Decided here*, *Tests that change on purpose* and *What the verify deploys*; carry-overs move to `brief-common.md`; land reads the report file, checks authors, measures from the base and lists what verify decides; land doesn't push; `brief-common.md` gains identity, reflow and environment lines; `debug` leaves loaded tests alone. *`verify`:* fetch first and exercise before reading; what driving means; the reviewer's fix boundary, failing-first tests and flakes; rerun scope and full suites for a Change; what it may write; the deploy order; founder-only checks; reference holds; milestone mode's by-hand list, two states, red suites, what it pushes, and the route walk. *Reviews:* `ux-review`'s `design` mode reads the latest design, scores per persona per journey, gets owed items and a capture script injected, asks nothing, defines live mode, and writes a status column and *For `revise`*; `design-review` takes its rubric from the project's design system and the module's one severity scale. *`revise` and `close-out`:* revise reads every block since the last revise, asks per item, keeps a scope ledger with a size limit, has six outcomes, a `STALE` rule, a change-request template, touch-ups named, a language rule, a `--catch-up` mode, and strikes settled rows; close-out records its override, separates closed from evaluated with reminders from launch, gains `--eval`, measures cost in dollars, updates design documents' grading, and finds an outside project's canon in its config.
- **0.4 · 2026-10-06** — Change track: `spec change` writes a Stages section into the change note; `build-phase` gates on and drafts cards from it; `verify` reads it in place of the plan's §5.
- **0.3 · 2026-10-06** — Consistency pass against `README.md`: gate always exits 0 (a failing injected command aborts the skill) and passes `n/a`; decision-log entries from `personas`, `revise` and `learned` use `decision-record`'s format; `revise` gains a method mode; `close-out` gains a gate line; `build-plan`'s gate matches the README; canon flags go in the stage record; state-of-the-build file is per project; source paths completed.
- **0.2 · 2026-10-05** — `learned` added: capture to an inbox, consolidate in batches; lane report gains item 7; `verify`, `handoff`, `lifecycle-status` and `close-out` wired to it.
- **0.1 · 2026-10-05** — Plan. Eighteen skills specified from the design conversation, the journeys build's documents, brief and state log, and the Claude Code skills documentation.
