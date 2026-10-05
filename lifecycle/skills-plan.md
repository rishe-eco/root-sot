# Lifecycle — the skills, specified

*Each of the eighteen lifecycle skills: what it does, how it is invoked, which model runs it, exactly what it reads and writes, its gate, and where its shape comes from. The method these skills implement is `README.md`.*

**Version 0.1 · Status: plan — nothing here is built yet · 2026-10-05 · Owner: _root**

---

## Summary

Eighteen skills in four groups — every session, design, build, closing the loop — sharing one gate script, one set of templates and one configuration folder per project. Most are invoked by name only, so they cost nothing per turn until used. Reviews run forked, in a fresh context. Lanes are launched by `build-phase` with the project's common brief plus a committed phase card, and return a six-part report that `verify` reads before the diff. Each spec below names its source in this repo, so the skill is a transcription of what already worked, not an invention.

**Grading.** Mechanics claimed for Claude Code skills (frontmatter fields, forking, injection, skill discovery) are **documented** — read from the Claude Code skills documentation on 2026-10-05. Anything marked **verify in stage N** is a reading of that documentation not yet tried here.

## 0. Shared mechanics

**Invocation.** Every skill is `disable-model-invocation: true` — invoked by name, invisible in context until then — except `debug`, which Claude may pick up on its own when a test fails. This keeps eighteen skills from adding eighteen descriptions to every turn.

**Model and effort** are set in each skill's frontmatter (`model`, `effort`) and apply to the turn that invokes it.

**Forking.** `verify`, `ux-review` and `design-review` use `context: fork` with `background: false`: they run in an isolated subagent that sees only the skill's content and its injected inputs, with the full tool set, and return a short summary. This is retrospective finding 1 built into the mechanism. *Verify in stage 2* that a forked skill with `background: false` can edit, commit and run suites as the journeys reviews did.

**Injection.** Skills pull their inputs with `!` commands at invocation — the gate result, the status row, the top of `STATE.md`, a diff stat — so the model does not spend turns fetching them.

**The gate.** `lifecycle/bin/gate <module> <phase>` checks that the phase's inputs exist, contain the headings listed in `templates/required-headings.txt`, and are not marked `STALE` in `status.md`. Exit 0 prints `GATE OK`; otherwise it prints what is missing and the skill stops and says so. A script runs without entering context; only its output does.

**Where the skills live until the plugin (stage 6).** All in `root-sot/.claude/skills/`. A session in a code repo loads them by adding `root-sot` as an additional directory (`--add-dir ../root-sot`, or `/add-dir`). *Verify in stage 1* how cloud sessions with several repositories expose additional-directory skills; if they do not, copy the build-side skills into each code repo until stage 6.

**Skills do not call skills.** Skill-to-skill invocation is not documented. Where one skill needs another's checklist, both load the same reference file; where a sequence is needed, the skill ends by naming the next one.

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
**Reads (injected):** `status.md`; `git status -sb`; the top block of the module's `STATE.md` if a module is named.
**Writes:** nothing.
**Output:** in chat, under 15 lines: the track; the module's phase; what is missing or stale; the next skill to run and the model it will use.
**From:** the table in this conversation's first review of the repos; Spec Kit's phase order.

### `handoff`
**Does:** ends a session by writing state a fresh session can start from.
**Invocation:** by name, at the end of a session · **Model:** Sonnet, low.
**Reads:** the session's own work; `git log` since the last state block.
**Writes:** a new block at the top of the module's `STATE.md` (or `lifecycle/STATE.md`), committed. Blocks older than the last five are deleted — stage records hold the history.
**Block format** (≤40 lines): date and `main @ <hash>`; lanes in flight (stage, branch, database, ports, card, status); next steps in order; carry-overs; questions for the founder; owed.
**Ends with:** "Run `/clear`."
**From:** the journeys orchestrator's state log (`root-app-lifecycle-build` memory), which carried the build across three compactions — moved from private memory into git.

### `decision-record`
**Does:** adds a decision to the right decision log in house format.
**Invocation:** by name, any phase · **Model:** Sonnet, low.
**Reads (injected):** the last three entry headers of the target log (`grep`), for the next ID and the format. Never the whole log.
**Writes:** one entry; the log's version line.
**From:** `tracker/decisions/decision-log.md`, `ecosystem/decisions/`.

## 2. Design

### `ideate`
**Does:** turns an idea into a one-page intake and opens the module.
**Model:** Sonnet, medium.
**Asks:** problem; pillar; place on the opportunity tree (`ecosystem/ost.md`); who it is for; smallest version worth trying; what would make us drop it.
**Writes:** the module folder, `00-intake.md` (one page, no sources), `STATE.md`, the `status.md` row.
**Gate:** none.
**From:** Spec Kit's idea-assessment intake.

### `research`
**Does:** a research brief, checked against what Root already knows.
**Model:** Opus, high.
**Reads:** the intake; `ecosystem/canon/04-research/00-evidence-summary.md` first, so known evidence is not re-researched; the code it concerns, by section.
**Writes:** `01-research.md` — five-line summary on top; claims graded evidence / as-built / proposal; sources; capped at ~2,500 words.
**Gate:** intake.
**From:** the grading blocks in the journeys documents and the lifecycle spec.

### `personas`
**Does:** selects which registered personas a module serves; rarely, proposes a new one.
**Model:** Sonnet, medium.
**Reads:** `personas.md`; the intake.
**Writes:** the selection into the module's `03-journeys.md` header; a proposed persona into `personas.md` marked *hypothesis*, with a `decision-record` entry.
**Rule:** never redefines an existing persona — the persona review's score history depends on them being fixed.
**From:** `tracker/canon/05-reviews/00-persona-review-method.md` §2.

### `spec`
**Does:** the spec, or a change note against an existing one.
**Modes:** `full` (Module) · `change` (Change track: a note in the module's `changes/`, or a new folder for a module that predates this system).
**Model:** Opus, high.
**Asks first:** up to eight clarifying questions in one batch.
**Writes:** `02-spec.md` in the house template — what it is, metrics, interface requirements, risks, acceptance criteria, changelog; references the journeys file rather than restating it.
**Gate:** research, or a waiver line in the intake.
**From:** `tracker/canon/06-specs/04-verification-lab.md`; Superpowers' brainstorming questions.

### `journeys`
**Does:** the paths people take.
**Modes:** `new` — 3–5 journeys (first day, normal loop, return after a gap, not enough data, error) of ~10 steps each · `gap` — each scenario checked against the code as *have / partly / missing*, suggestions kept apart and marked **Suggested**, decisions asked and answered in their own section.
**Model:** Opus, high.
**Writes:** `03-journeys.md`.
**Gate:** spec; personas selected.
**From:** `ecosystem/working/root-studio-user-journeys.md` (the `gap` mode); the Impact spec's flows (the `new` mode); bug B-14 as the case it exists to catch.

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
**Gate:** phases 2–6.
**Rule:** this session ends once the plan is committed and pushed. The build starts fresh.
**From:** `ecosystem/working/root-studio-journeys-build-plan.md`.

## 3. Build

### `build-phase`
**Does:** launches a stage as a lane, or lands one.
**Invocation:** `build-phase <stage>` to launch · `build-phase <stage> --land` after the lane reports.
**Model:** Opus, medium (it drafts the card; the lane is Sonnet).
**Launch:**
1. Run the gate. Check `STATE.md`: at most two lanes in flight, no other lane touching shared schema.
2. Draft the phase card from the plan's §5 section and the code as it is now: 500–700 words, naming exactly which plan sections, journeys sections and earlier stage records to read. Commit it as `briefs/<stage>.md`.
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
  6. what could not be verified.

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
- the phase card and the plan's §5 section for the stage;
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
8. Flag canon files the stage made stale.
9. Update the stage list and `00-state-of-the-build.md` where they apply.
10. Report "ready to fast-forward" or what blocks it.

**Milestone mode:** run the project's milestone script, one heavy runner at a time; record the counts in the development README.
**Returns:** at most 15 lines.
**From:** the journeys reviews (retrospective §2); `J12.md`; the development README's done means.

### `design-review`
**Does:** checks built UI against the brand, the tokens and accessibility.
**Invocation:** by name, on a stage or a screen · **Model:** Opus, high · **Forked.**
**Reads:**
- the summary sections of `ecosystem/canon/01-philosophy/01-brand-definition.md`;
- `apps/web/src/styles/tokens.css`;
- the type and spacing rules from `root-website-requirements_2.md`;
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
**Input:** a change request — from a lane report's item 5, a review, or a live UX finding.
**Writes:**
- `changes/NN-slug.md`;
- the spec's version bump and changelog line;
- `STALE` in `status.md` on every downstream phase the change invalidates;
- a `decision-record` entry.

**From:** the journeys build's mid-plan changes (J9 split, J13's "signed" rule).

### `close-out`
**Does:** finishes a module.
**Model:** Opus, high.
**Reads:** the eval plan and its results; every stage record's *decided* and *owed* sections; `STATE.md`; the canon-sync flags.
**Writes:**
- `09-close-out.md`: the evaluation result against the rule written beforehand; what the plan did not know, aggregated; the module's cost (sessions, share of weekly limits, lanes); a short retrospective.
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

Stage 2 builds `lifecycle-status`, `handoff`, `decision-record`, `build-phase`, `verify` and `debug`, each written with `skill-creator` and tried on real work before stage 3. The rest follow the rollout in `README.md` §8.

## Changelog

- **0.1 · 2026-10-05** — Plan. Eighteen skills specified from the design conversation, the journeys build's documents, brief and state log, and the Claude Code skills documentation.
