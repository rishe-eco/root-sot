# Decision log — the lifecycle method

*Decisions about the method itself, and only those. Written in `decision-record`'s format. A module's product decisions live in its change notes, indexed in `<module>/decisions.md`. L-2, L-3, L-5 and L-6 moved to `imnstr/modules/01-website/decisions.md` on 2026-10-19 (L-9), keeping their ids.*

**Version 0.32 · 2026-10-20**

---

## L-1 · 2026-10-10 · Three IMNSTR personas proposed; A and B not selected

**Decision.** Add hypothesis personas C (Writer), D (Follower) and E (Listener) to `lifecycle/personas.md`, one per audience in `imnstr/modules/01-website/00-intake.md` §4. Do not select A or B for IMNSTR; they stay registered and unchanged.

**Why.** A and B are defined by what they know entering Tracker's Tools page, so using them for IMNSTR would mean redefining them, which the method forbids. No existing persona fits a one-user admin or a podcast listener.

**Decided by.** Founder, accepting the proposal at step 3a of the trial run.

**Revisit.** After IMNSTR's step 5 review, if C, D or E did not surface distinct findings.

## L-4 · 2026-10-10 · IMNSTR persona F (Persian follower) proposed and selected

**Decision.** Add hypothesis persona F (Persian follower) to `lifecycle/personas.md` and select it for IMNSTR beside C, D and E in `03-journeys.md`. No existing persona is changed. A is not used: it is defined by entering Tracker's Tools page.

**Why.** UX review F11: the spec has had two languages since 0.2, and none of C, D, E reads Persian, so M6 (language parity) cannot be scored and the Persian stream has no journey. F reads only Persian, which is what the Persian pages must serve.

**Decided by.** Founder, accepting the proposal at trial step 05c.

**Revisit.** After step 9, if F surfaced nothing C, D or E would not have, or if the Persian writing path in the admin needs its own persona.

## L-7 · 2026-10-19 · Method README 0.5: the trial's findings on tracks, phases, files and status

**Decision.** Apply findings M-1 to M-8 of `lifecycle/trial-run/findings.md` 0.2 to `lifecycle/README.md`, now 0.5:
- an outside project's modules live in `<project>/modules/NN-slug/`;
- two kinds of Change: one that arrives during a build, and a small Change built, verified and deployed in one session when the founder chooses it;
- phases 4b (design) and 7b (project config), and launch as an event that later checks count from;
- the gates of phases 5, 7, 9 and 10 as the trial ran them;
- §4 has one file pattern per row, and names the writers of the build plan, project configs and the open-work file;
- `status.md`'s values, the founder's supplies, and the names `MS<n>`, `AC-n` and `P<pass>-F<n>`.

**Why.** The IMNSTR trial had to improvise each of these. The logs cited in each finding record where.

**Decided by.** Founder, reading the diff in the apply session. Accepted unread at 10c on Claude's judgement first.

**Revisit.** When the next module runs, if a small Change runs over one session or a gate blocks work it shouldn't.

## L-8 · 2026-10-19 · Skills plan 0.5: the trial's findings on shared mechanics

**Decision.** Apply findings S0-1 to S0-10 of `lifecycle/trial-run/findings.md` 0.2 to `lifecycle/skills-plan.md` §0, now 0.5:
- the gate fetches first, takes a recorded override, and checks HTML headings, the personas table and criterion coverage;
- each skill works out its step from the files and stops on a mismatch;
- model stated in the first message, effort as the prompt says; a wrong model stops the session;
- code repo paths injected; forked skills end before anything that waits on the founder;
- new paragraphs: parallel sessions, redoing a phase, references, grades, asking the founder, and outward-facing and destructive actions.

**Why.** Each was improvised or learned at a cost in the IMNSTR trial: 32 logs gated by hand, two manual merges between parallel sessions, three research passes with no redo rule, and scope that grew through answers the method didn't treat as new items.

**Decided by.** Founder, reading the diff in the apply session. Accepted unread at 10c on Claude's judgement first.

**Revisit.** When `bin/gate` is built (stage 1), against what it can actually check; and after the next module, if the four-question batch proves too small.

## L-9 · 2026-10-19 · Skills plan 0.5: the every-session skills; module decisions leave this log; an engineering checklist

**Decision.** Apply findings ST-1, HO-1 to HO-4, DR-1, DR-2 and LE-1 to LE-9 of `lifecycle/trial-run/findings.md` 0.2:
- `lifecycle-status` shows the inbox's size and age and the founder's rows due next;
- `handoff`'s block names both repos, says how it relates to earlier blocks, carries pointers and ready questions, and writes each next step as the line to paste;
- `decision-record` has a fixed entry format and id rule. A module's product decisions go in its change notes, with a one-line index in `<module>/decisions.md`. This log keeps method decisions only, so L-2, L-3, L-5 and L-6 move to IMNSTR's index;
- `learned` notes have fixed fields. Consolidation also runs at each milestone during a build, counts recurrence by session, reads what is already integrated and the founder's notes, presents in groups of four, and turns a module's last holds into seeds;
- `lifecycle/engineering-checklist.md`, seeded with the trial's thirteen product lessons.

**Why.** In the trial the inbox went over cap mid-build with nothing to enforce it, handoff blocks were read as findings rather than pointers, four of six entries here were IMNSTR's product decisions, and thirteen engineering lessons had no home.

**Decided by.** Founder, reading the diff in the apply session. Accepted unread at 10c on Claude's judgement first.

**Revisit.** After the next build's first milestone, if consolidating there costs more than it saves.

## L-10 · 2026-10-19 · Skills plan 0.5: `ideate`, `research` and `personas`

**Decision.** Apply findings ID-1 to ID-3, RE-1 to RE-5 and PE-1 to PE-6 of `lifecycle/trial-run/findings.md` 0.2 to `lifecycle/skills-plan.md` §2:
- `ideate` answers Root-only questions "n/a" outside Root, records the drop rule verbatim, and ends the intake with its decisions;
- `research` reviews itself against its inputs, reaches sources in a set order, stops searching on a budget, and ends with *For the next phases*;
- `personas` may select none and propose by behaviour, asks before writing the registry, gains an `add` mode, owns `## Personas` in the journeys file, and has a record template.

**Why.** IMNSTR was the first project outside Root: intake's pillar question had no answer, research ran three passes before it checked itself against the intake, and no registered persona fitted, so 3a and 05c invented the proposing and adding steps.

**Decided by.** Founder, reading the diff in the apply session. Accepted unread at 10c on Claude's judgement first.

**Revisit.** At the next module's research, if the source order or the search budget proves wrong.

## L-11 · 2026-10-19 · Skills plan 0.5: `spec`, both modes

**Decision.** Apply findings SP-1 to SP-11 of `lifecycle/trial-run/findings.md` 0.2 to `lifecycle/skills-plan.md` §2 and `README.md` §3:
- the spec's template, with a scope ledger in its header counting criteria by area against intake;
- journey-level criteria left to journeys; measures in the spec, instruments in the eval plan; the platform decided by the build plan;
- in `change` mode: a gate against lanes in flight, `main @` in the header, a criterion prefix with an *Item* column, a fuller Stages shape, and *What this makes stale*;
- one numbering in `changes/`, with the kind in the file name.

**Why.** Three Changes were written during and after IMNSTR's build with a mode specified in one paragraph, and the spec grew from 19 to 48 criteria with nothing counting it (founder note 1).

**Decided by.** Founder, accepted at 10c on Claude's judgement. Applied without a diff review: partway through the apply session the founder asked for the remaining groups to be committed straight on, stopping only for what needs their attention.

**Revisit.** IMNSTR's seven existing change files keep their names; if the next module's mixed `changes/` folder is still hard to read, rename on the next `revise --catch-up`.

## L-12 · 2026-10-19 · Skills plan 0.5: `journeys` and `wireframes`

**Decision.** Apply findings JO-1 to JO-9 (JO-9 lands with `close-out`) and WF-1 to WF-6 of `lifecycle/trial-run/findings.md` 0.2 to `lifecycle/skills-plan.md` §2:
- `journeys` asks one batch in every mode, keeps Suggested items apart until `revise` accepts them, ends each step with a check citing criteria, and requires a Coverage table and a states table;
- an `update` mode, and scoped runs of `gap` and `update`;
- amended journeys keep their step ids;
- `wireframes` has seven steps, coverage by step, Suggested items drawn as marked options, a required *Calls made here*, and a definition of low fidelity.

**Why.** Both skills were one or two lines. The trial's 3b, 04, 05d and 10b4 sessions invented these steps, and the Suggested items they found had no route to the spec until step 4c was added.

**Decided by.** Founder, accepted at 10c on Claude's judgement. Applied without a diff review, by the founder's instruction in the apply session.

**Revisit.** At the next module's journeys, if the Coverage table and the step checks together cost more than they catch.

## L-13 · 2026-10-19 · Skills plan 0.5: the design step and its import

**Decision.** Apply findings DS-1 to DS-8 of `lifecycle/trial-run/findings.md` 0.2: a new section in `lifecycle/skills-plan.md` §2 for phase 4b, run by the founder in a design tool, with an import session. It sets the opening form, the inputs for a first and second pass, how much to draw, the README template (with a plate index, plate markers, *Disagreements* and measured contrast), the handoff folder, the import checklist, and an optional accessibility pass that only proposes.

**Why.** The method had no design phase. In the trial, six directions were rejected before references were asked for, and five build launches had to slice a 1.5 MB export because the README had no plate index.

**Decided by.** Founder, accepted at 10c on Claude's judgement. Applied without a diff review, by the founder's instruction in the apply session.

**Revisit.** When a second project uses a design tool, or if a design skill replaces the founder's tool session.

## L-14 · 2026-10-19 · Skills plan 0.5: `eval-plan` and `build-plan`

**Decision.** Apply findings EV-1 to EV-4 and BP-1 to BP-7 of `lifecycle/trial-run/findings.md` 0.2 to `lifecycle/skills-plan.md` §2 and `README.md` §6 rule 5:
- `eval-plan` has steps and asks about consequences; it separates what close-out can judge from later checks counted from launch; instruments name their preconditions; a `--touch-up` mode;
- `build-plan` asks the founder's facts in one batch first, widens its defect pass, defines a size, says more per stage, checks itself before commit, gains a template, and gates on every upstream suggestion.

**Why.** In the trial the eval plan had no steps and would have left close-out nothing to judge; the build plan's open decisions pushed ten of twelve cards over their length, and stages ran far over their line estimates while finishing far under in time.

**Decided by.** Founder, accepted at 10c on Claude's judgement. Applied without a diff review, by the founder's instruction in the apply session.

**Revisit.** Recalibrate sizes once a second module's stage records exist; review the 400–600-word stage bound then too.

## L-15 · 2026-10-19 · Skills plan 0.5: project configuration and a `project-config` skill

**Decision.** Apply findings PC-1 to PC-9 of `lifecycle/trial-run/findings.md` 0.2 to `lifecycle/skills-plan.md`:
- §0 lists what each project config file holds, and `config.md` in full: paths per machine, files, suites, lanes and branches, environment, review scripts;
- a project with no code has a planned config that the first verify reconciles;
- a new skill, `project-config` (Opus, medium), creates the folder once per project; the plan now specifies twenty skills;
- the recovered journeys `brief-common.md` is committed as `lifecycle/templates/brief-common.example.md`.

**Why.** Step 7b wrote IMNSTR's config with no spec for it and found the source brief only by searching `~/.claude`. Sixteen logs then met a config piece that wasn't there, and eight verify logs and both UX reviews wrote throwaway review scripts.

**Decided by.** Founder, accepted at 10c on Claude's judgement. Applied without a diff review, by the founder's instruction in the apply session.

**Revisit.** When a second project is configured. IMNSTR's own config isn't changed here; it already holds what its build needed.

## L-16 · 2026-10-19 · Skills plan 0.5: `build-phase` (launch and land) and `debug`

**Decision.** Apply findings BF-1 to BF-11, BL-1 to BL-3 and DB-1 of `lifecycle/trial-run/findings.md` 0.2 to `lifecycle/skills-plan.md` §3 and `README.md` §6 rule 3:
- launch asks the founder's facts and preconditions first, checks the plan and the tests against the code, makes the worktree by hand and launches by path;
- card length is counted by body, and an overlong card is a sign the plan is underspecified;
- the card template gains *Decided here*, *Tests that change on purpose* and *What the verify deploys*;
- land reads the report file, checks commit authors, measures from the lane's base, records real time and tokens, and lists what verify must decide; it doesn't push;
- `brief-common.md` gains the identity check, the 180 px rule and the build machine's environment pitfalls;
- `debug` doesn't edit a test a running suite has loaded.

**Why.** Twelve launches and twelve lands in the trial improvised these steps. Cards ran over their limit ten times, one lane changed a house rule alone because a test pinned the stage's absence, and one report nearly lost with its session.

**Decided by.** Founder, accepted at 10c on Claude's judgement. Applied without a diff review, by the founder's instruction in the apply session.

**Revisit.** After the next build: whether the test grep and the 1,000-word signal hold, and whether launch and land in one session should become a named shape.

## L-17 · 2026-10-19 · Skills plan 0.5: `verify` and its milestone mode

**Decision.** Apply findings VE-1 to VE-14 and VM-1 to VM-5 of `lifecycle/trial-run/findings.md` 0.2 to `lifecycle/skills-plan.md` §3:
- verify fetches first, exercises the artifact before reading the diff, and defines what counts as driving a browser;
- the reviewer's fixes are bounded; tests it adds fail first; flakes are repeated and recorded;
- rerun scope widens for shared helpers, and a Change's verify runs the full suites when its note asks;
- it may make correction-only edits to the plan and config with the founder's yes;
- a deploy order for projects whose `main` deploys, ending at 'push pending' if blocked;
- milestones have a by-hand list from open-work, two states (*suites green*, *closed*), a rule for red suites, a push limit and a route walk on production.

**Why.** Fourteen verify sessions and three milestones in the trial worked these out; the costliest misses (a 61 px overflow, a test that passed on unfixed code, a record shipped with its code spans stripped) came from steps the spec didn't have.

**Decided by.** Founder, accepted at 10c on Claude's judgement. Applied without a diff review, by the founder's instruction in the apply session.

**Revisit.** After the next build's first two verifies, against how long the exercise-first step takes.

## L-18 · 2026-10-19 · Review instrument 0.2 and the review skills

**Decision.** Apply findings UX-1 to UX-11, RI-1 to RI-5 and DE-1 of `lifecycle/trial-run/findings.md` 0.2 to `lifecycle/skills-plan.md` §3, `README.md` §2 and `lifecycle/review-instrument.md`, now 0.2:
- `ux-review`'s first mode is renamed `design` and reads the latest design; it scores per persona per journey, gets owed items injected, asks nothing, and writes a *Status* column and *For `revise`*; live mode reads production as a bot and walks states locally;
- `design-review` takes its rubric from the project's design system, not Root's brand by default;
- the instrument adds reflow at 200% and tap targets to coverage, pass-scoped ids, one severity scale, two grades, a status field and rules for observing.

**Why.** The step 5 and step 9 reviews read a design the skill didn't know about, nearly reported two states as missing that the captions drew, and found a 61 px overflow only by screenshot. IMNSTR's design review had to swap Root's brand for its own design system by hand.

**Decided by.** Founder, accepted at 10c on Claude's judgement. Applied without a diff review, by the founder's instruction in the apply session.

**Revisit.** At the next module's live pass, whether `design`-mode and live scores compare on 0.2.

## L-19 · 2026-10-19 · Skills plan 0.5: `revise` and `close-out`

**Decision.** Apply findings RV-1 to RV-11, CO-1 to CO-5 and JO-9 of `lifecycle/trial-run/findings.md` 0.2 to `lifecycle/skills-plan.md` §4 and `README.md` §1–§2:
- `revise` reads every block since the last revise, asks per item first, and keeps the spec's scope ledger: it asks "still the smallest version?" when an area doubles or passes a quarter of the criteria, and sends a new capability to `spec change`;
- six outcomes per item; `STALE` only for contradiction, quoting the sentence; a change-request template; named touch-ups; a rule for a new language; a `--catch-up` mode after a build; settled open-work rows struck;
- `close-out` records an override, separates closed, launch-ready and evaluated, schedules later checks from launch, gains `--eval`, measures cost in dollars, updates design documents' grading, and finds an outside project's canon in its config.

**Why.** `revise` had no step for asking, and was the only gate every scope addition passed through without a running total (founder notes 1 and 2). Close-out reached a module with its evaluation still months away and no state for it.

**Decided by.** Founder, accepted at 10c on Claude's judgement. Applied without a diff review, by the founder's instruction in the apply session.

**Revisit.** At the next module's first `revise`: whether the ledger's thresholds (double, a quarter) trip at the right time.

## L-20 · 2026-10-19 · Trial brief 0.6

**Decision.** Apply findings TR-1 to TR-5 of `lifecycle/trial-run/findings.md` 0.2 to `lifecycle/trial-run/README.md`, now 0.6: the opening prompt names the skill; one style of step name; rows for the design imports, a Change during the build (8x) and this apply session (10d); every step without a column listed; 10a and 10c say the edits are applied at 10d; rule 4 covers the code repo's files; a log's *Output* may say "this commit". TR-5 needed no edit.

**Why.** Three places disagreed on who applies the findings, and steps the trial added (imports, Changes, 10a) had no row. These change the next trial's brief, not the method.

**Decided by.** Founder, accepted at 10c on Claude's judgement. Applied without a diff review, by the founder's instruction in the apply session.

**Revisit.** At the next trial, if one runs.

## L-21 · 2026-10-19 · Skills plan 0.5: stage 1's foundation list

**Decision.** Apply findings F-1 to F-18 of `lifecycle/trial-run/findings.md` 0.2 to `lifecycle/skills-plan.md` §5 and `README.md` §8. Most rows point at findings already applied in L-7 to L-20; this makes stage 1's list concrete: every template by name, `bin/gate`'s checks, the learnings inbox with its note fields, and the founder's machine setup. Not done here: building the templates and `bin/gate` (stage 1's own work); the memory edits for the build machine (L30, L31, L33); and F-17's shared test helpers, which are IMNSTR product work for its open-work file.

**Why.** The trial's largest gap was foundation never built: 32 logs gated by hand and 22 had no template.

**Decided by.** Founder, accepted at 10c on Claude's judgement. Applied without a diff review, by the founder's instruction in the apply session.

**Revisit.** When stage 1 starts.

## L-22 · 2026-10-20 · Skills plan 0.6: cut back, step 1, reference material moved out

**Decision.** Move every *Reference holds* block, every template's contents, and the contents lists of `config.md` and `brief-common.md` out of `lifecycle/skills-plan.md` into `lifecycle/skills/<skill>/reference.md`, one file per skill, unchanged. Each skill's section points at its file. The 0.5 changelog entry is cut to a pointer at L-8 to L-21. The plan goes from about 10,200 words to about 8,300.

**Why.** Applying the trial's findings doubled the plan, from about 5,000 words, and much of the growth was material for reference files and templates that don't exist yet. Moving it is lossless, so the founder reviews the list of files, not the text. Steps 2 and 3 trim what is left, section by section, with the founder reviewing each diff.

**Decided by.** Founder, 2026-10-20, approving the plan to cut back in three steps.

**Revisit.** In stage 2, when each skill's author places its seeds: whether `skills/` folds into `.claude/skills/<skill>/`.

## L-23 · 2026-10-20 · Skills plan 0.7: cut back, step 2, shared mechanics

**Decision.** Rewrite `lifecycle/skills-plan.md` §0 in tighter wording, from about 1,490 words to about 1,030, keeping every rule that prevents an ordinary mistake. Four rarely needed rules (redoing a phase, grades in reviews and personas, a design item routed to `revise`, a step run outside Claude Code) move to `lifecycle/skills/shared/reference.md`. The configuration table's root-app sources move to `skills/project-config/reference.md`. Cut outright: two sentences of provenance, "a script runs without entering context", and a parallel-sessions bullet already in `verify`'s seeds.

**Why.** The test for each rule: does it prevent a mistake the skill would make in an ordinary session? Rules from one incident go to a reference file; provenance lives in this log.

**Decided by.** Founder, 2026-10-20, after reviewing the diff ("keep it"). Committed just before that review, so the work wasn't lost with the session's container.

**Revisit.** In stage 2, when the first skills are written from §0.

## L-24 · 2026-10-20 · Skills plan 0.8: cut back, step 3, every-session skills

**Decision.** Rewrite `lifecycle/skills-plan.md` §1 in tighter wording, from about 1,080 words to about 700. `handoff`'s block format moves to `lifecycle/skills/handoff/reference.md`; `learned`'s note fields and its destination table move to `lifecycle/skills/learned/reference.md`. Cut outright: lines that repeat §0 (explanations go in the closing message) or `verify` (it drops a capture note per review); "also checked at each milestone", which consolidation's own trigger covers; "reads nothing beyond the session itself"; and "this conversation's first review" in `lifecycle-status`'s source.

**Why.** As L-23: templates go to reference files, and a rule stays only if it prevents a mistake in an ordinary session.

**Decided by.** Founder, 2026-10-20, after reviewing the diff ("keep it"). Committed just before that review, so the work wasn't lost with the session's container.

**Revisit.** In stage 2, when the every-session skills are written.

## L-25 · 2026-10-20 · Skills plan 0.9: cut back, step 3, design skills

**Decision.** Rewrite `lifecycle/skills-plan.md` §2 in tighter wording, from about 2,300 words to about 1,430. Each skill keeps what it does, reads, writes and gates on, and the parts of its output other skills read. Moved, word for word, to `lifecycle/skills/<skill>/reference.md`: the change note's shape (`spec`); the journeys file's shape, its *Must be true* cells and amending rules (`journeys`); the build plan's §0–§10 and stage-section lists, the size evidence and the gate's detail (`build-plan`); the design step's opening form, handoff, import and optional review (`design-step`); the eval plan's touch-up detail (`eval-plan`); and the details of `research`, `personas` and `wireframes` (a new seed file). Two source lines no longer say "not yet on `main`": both journeys files are on `main`.

**Why.** As L-23: templates and shapes go to reference files, and a rule stays only if it prevents a mistake in an ordinary session.

**Decided by.** Founder, 2026-10-20, after reviewing the diff ("keep it"). Committed just before that review, so the work wasn't lost with the session's container.

**Revisit.** When the design skills are written (rollout stage 3).

## L-26 · 2026-10-20 · Skills plan 0.10: cut back, step 3, build skills

**Decision.** Rewrite `lifecycle/skills-plan.md` §3 in tighter wording, from about 1,990 words to about 1,530. Every step of `build-phase`'s launch and land, `debug`'s rules, `verify`'s twelve steps and milestone mode, and both reviews' reads, checks and writes stay. Moved, word for word, to `lifecycle/skills/<skill>/reference.md`: the full test-grep list, the card's length and Change-track details, and why the worktree is made by hand (`build-phase`); the exercise probes, what "driven in a browser" means, the flake and rerun details and the "every feature present" walk (`verify`); Root's design-system paths (`design-review`, a new seed file); `debug`'s mid-run note; and `ux-review`'s live-mode and status-column details.

**Why.** As L-23. §3 cut less than §2 because most of it is steps a session follows in order, which stay.

**Decided by.** Founder, 2026-10-20, after reviewing the diff ("keep it"), accepting about 5,800 words as the finish line rather than 5,000. Committed just before that review, so the work wasn't lost with the session's container.

**Revisit.** When the build skills are written (rollout stage 2).

## L-27 · 2026-10-20 · Skills plan 0.11: cut back, step 3, closing the loop; the cut finished

**Decision.** Rewrite `lifecycle/skills-plan.md` §4 in tighter wording, from about 800 words to about 540. `revise` keeps its scope ledger, outcomes and `STALE` rule in full; its change-request contents and `--catch-up` detail move to `lifecycle/skills/revise/reference.md`. `close-out`'s cost and canon-sync detail move to `lifecycle/skills/close-out/reference.md`. Both are new seed files. The changelog entries for 0.6 to 0.11 fold into one line. §5 points at the seed files for templates and note fields, and `README.md` 0.6 lists `skills/` in §3 and §4. The plan ends at about 5,900 words, from about 10,200.

**Why.** As L-23. The founder set about 5,800 words as the finish line: below that, the cut would remove steps that prevent real mistakes.

**Decided by.** Founder, 2026-10-20, after reviewing the diff ("keep it"). Committed just before that review, so the work wasn't lost with the session's container.

**Revisit.** In stage 2, when the first skills are written from the plan and their seed files: whether `skills/` folds into `.claude/skills/<skill>/`.

## L-28 · 2026-10-20 · Rollout stage 1, session A: templates, required headings, learnings inbox, status backfill

**Decision.** Add the 19 templates listed in `skills-plan.md` §5 to `lifecycle/templates/`, each built from its skill's section, its `skills/<skill>/reference.md` and the trial logs' *Template sample*, beside the existing `brief-common.example.md`. Add `templates/required-headings.txt`, with the grammar `bin/gate` will read. Two calls in it: lane reports are checked by section number (1–7), not wording, because the 13 IMNSTR reports phrase the seven parts about 30 ways; and outputs already `done` in `status.md` aren't re-gated. Create `lifecycle/learnings/inbox/` and `learnings/index.md`, which holds `learned`'s capture-note fields. Backfill `status.md` with 14 modules that predate the method, read from their own documents, with sources and open questions below the table. "Review" in §5 is read as both reviews, `05-ux-review.md` and `08-design-review.md`.

**Why.** Stage 1 of the rollout (`README.md` §8). The IMNSTR trial's logs named a missing template in 22 of 72 (`trial-run/findings.md` §10, F-2), and an inbox was F-3. Backfilling the status table is the first audit.

**Decided by.** Founder, 2026-10-20: approved the template list before it was written, then asked for this entry and the merge into `main`.

**Revisit.** When `bin/gate` is built (stage 1, session B): whether the grammar in `required-headings.txt` holds as written. Also Learn Module 1's column 8, which the founder must supply, and the two status lines the audit found out of date (the Time Themes spec, the project-lifecycle spec).

## L-29 · 2026-10-20 · Rollout stage 1, session B: `bin/gate`, and the grammar it reads

**Decision.** Build `lifecycle/bin/gate` in Bash and POSIX awk, so it runs in Git Bash on Windows and on Linux. Shellcheck is clean, and `lifecycle/bin/gate-test` (46 cases, on a sandbox copy of `imnstr/modules/01-website`) proves it. Change `templates/required-headings.txt` to 0.2:
- **Strict or warned.** A missing heading, a gap in a *Coverage* table or an empty Personas table fails a phase being opened (its cell blank, `STALE` or in progress), and is a warning on a phase already done. This replaces the 0.1 note that outputs already `done` are "not re-gated", which contradicted `skills-plan.md` §0, since every input of a phase is done.
- **Conditional lines** are written `when <condition>: <line>`. The gate checks the line, and reports it as "not checked" rather than missing, because it can't judge the condition.
- **The Personas table** needs at least one row. An empty selection is written `none — <why>` (journeys template 0.2).
- **A change note's coverage:** every criterion id in it appears in some stage's **Acceptance** line, with ranges counted in full.
- **A fetch that fails** is reported as "not checked", not as a failure.
- **Lookups:** `in` and `each` lines don't take a heading; lists split on ", h3 " and ", bold "; headings in code fences don't count.

**Why.** L-28's *Revisit*. As written, the 0.1 grammar would have failed IMNSTR's done phases on real gaps, and it couldn't evaluate its own conditional lines.

**Decided by.** Founder, 2026-10-20: accepted each of the six design points before the build, then asked for this entry and the merge into `main`.

**Revisit.** The gaps the gate reports as warnings on IMNSTR: AC-48 and AC-49 missing from the journeys' *Coverage*; the design README's *Plate index* and *Verdict*; the phase cards' *Decided here* and *Not here*. Also whether the one-session small Change (CS1: no card, no report, no **Acceptance** line) needs its own step-check rule, and a first run of `gate-test` in Git Bash on Windows.

## L-30 · 2026-10-20 · Rollout stage 1, session C: project settings for root-app and Tracker; CLAUDE.md in all three repos

**Decision.** Finish stage 1's file work (`README.md` §8):
- `lifecycle/projects/root-app/` and `lifecycle/projects/tracker/`, each with `config.md`, `brief-common.md` and `review-checklist.md`, **planned**, not written by `project-config`, which doesn't exist yet. Its first run on each project's first module reviews them. root-app's are from its development README, the deploy runbook, the journeys plan 1.0 §0.2, §0.3 and §8, the recovered brief and the retrospective. Tracker's are from the code repo and its conventions 0.6, testing 0.3 and setup 0.1 canon.
- `CLAUDE.md` at the root of root-sot: house rules, the lifecycle method, sessions, commits, and working with the founder.
- `CLAUDE.md` in `rishe-eco/root-app`, on `wp-dashboards`, and in `rishe-eco/tracker`, on `main`. Both carry the commands, the environment's pitfalls and the git rules, and both repos now ignore `.tmp/`, where lane reports and suite logs go.

Four facts found on the way are written into the files as they are, not as the method assumes:
- all three repos are public;
- root-app's `wp-dashboards` lacks `journeys-build`'s last commit (`267a71d`, the M4 fixture-date fix);
- root-app has no fixed test clock: fixture days move with today through `onDay`;
- Tracker's e2e isn't lane-safe. Its ports and API URL are fixed, it signs up users in the running API's dev database, and its config asks for Edge, which the Linux machine lacks.

**Why.** Stage 2's build skills are proven on root-app and Tracker work, and need these files to draft cards and run reviews. Session rule 6 puts durable environment knowledge in each repo's CLAUDE.md, not in one machine's memory.

**Decided by.** Founder, 2026-10-20: chose to finish these before stage 2, then put root-app's `CLAUDE.md` on `wp-dashboards`, asked for this merge into `main`, and asked for both code repos to be pushed. The files' contents were accepted without a line-by-line review.

**Revisit.**
- At the first stage on each project: the planned lane slots and milestone scripts.
- Tracker: whether to schedule an e2e prep stage (movable ports, API URL, browser channel and database) or waive it, and its checkout path on the Windows build machine, which the founder supplies.
- root-app: which branch is the base until `journeys-build` and `wp-dashboards` are merged, and whether a fixed test clock replaces `onDay`.
- Still open from stage 1: the founder's machine setup (Docker isn't on the Linux machine), Learn Module 1's column 8, and the baseline's `/usage` and `/insights`.

## L-31 · 2026-10-20 · Stage 2 prep: every session ends with the next prompt; skills in `lifecycle/skills/` until the plugin; the baseline

**Decision.**
- **Session rule 8** (`README.md` 0.7 §5): every session's last message is the next session's prompt, in a fenced block the founder pastes after `/clear`, copied from the first next step of the `STATE.md` block just written. `handoff` prints it and `learned` prints it again last (`skills-plan.md` 0.12); before the skills exist, the session writes it itself. The root `CLAUDE.md` carries the rule, so it applies from the next session. The handoff template's first next step is a whole prompt for a cold session (`skills/handoff/reference.md` 0.2).
- **Where skills live:** `lifecycle/skills/<skill>/SKILL.md`, beside their seeds, until the plugin (stage 6). Stage 2 starts with `bin/install-skills`, which copies them into `~/.claude/skills/` so sessions in all three repos find them. Copies, not symlinks, which are unreliable in Git Bash on Windows. This settles L-27's *Revisit*.
- **The baseline** (`README.md` §8 stage 0): the journeys build's total, about $521, read by the founder from the usage dashboard, plus the IMNSTR trial's cost per phase in each log's *Cost*. The $521 covers the one session that ran the base project, the journeys and their development, so it overstates the journeys build alone. The retrospective's `/usage` and `/insights` item is closed: its 7-day window had passed (retrospective 0.5).
- **A coordinator is deferred.** The founder proposed one or more coordinators to remove the cost of switching sessions between skills. Rule 8 takes its place for now.

**Why.** Switching sessions between skills is the founder's main friction, but the session breaks are the retrospective's fix: one orchestrating session at 500–760k tokens was most of the journeys build's cost. A coordinator that stays one long session would bring that back. A thin one that sends each phase to a fresh sub-agent could work, but sub-agents can't ask the founder anything, which most design phases need, and probably can't launch the lanes `build-phase` launches (not yet verified here). Rule 8 removes the cheap part of the friction, knowing what to paste next, at no cost. Skills stay beside their seeds so one folder holds each skill until the plugin. The dashboard's total replaces a breakdown that can no longer be read.

**Decided by.** Founder, 2026-10-20: proposed rule 8 in place of a coordinator, chose `lifecycle/skills/` and gave the $521 figure. `bin/install-skills` and the rule's exact wording are Claude's, accepted on the diff ("keep it").

**Revisit.** At the end of stage 2, after the build skills are tried on the journeys owed items and B-15: a build-side coordinator (build → verify → debug within one milestone), judged by how often those sessions stopped for the founder and against the IMNSTR per-phase costs. Also whether a sub-agent can launch sub-agents, and whether the $521 can be split between the base project and the journeys.

## L-32 · 2026-10-20 · Rollout stage 2, session A: `bin/install-skills` and the four every-session skills *(reconstructed)*

**Decision.**
- **`bin/install-skills`** copies each `lifecycle/skills/<skill>/` that holds a `SKILL.md` into `~/.claude/skills/`, as copies, not symlinks (L-31). Each copy carries a `.root-sot` file naming the checkout, which lets a skill's scripts find root-sot from any repo and marks the copy as installed from here. A folder of the same name without one is someone else's skill, and is never overwritten. `--check` lists out-of-date copies and exits 1. A copy whose skill no longer exists is removed, but only if it was installed from this checkout.
- **Four skills,** each a `SKILL.md` with a `context.sh` injected at invocation. The argument reaches the script through a quoted heredoc, so quotes in it can't break the injected command:
  - `lifecycle-status`: Sonnet, low. It writes nothing, and lists near matches when the argument names no row;
  - `handoff`: Sonnet, low. Its block format is placed in `SKILL.md` (reference 0.3). It commits `STATE.md` by path, never pushes without the founder's yes, and ends with the next session's prompt;
  - `learned`: no model in its frontmatter. Capture runs on the session's model, and `--consolidate` checks that it is in a fresh Opus session. Capture writes no file for zero notes;
  - `decision-record`: Sonnet, low. Its `reference.md` 0.2 is the shared entry format, and its *Which log* covers this log, module `decisions.md` files, and the older Tracker and ecosystem logs, which keep their own form.
- **Fixes from rendering each skill** through a throwaway copy: `handoff` shows the newest seven block headers, not all of them; `learned` skips headings inside code fences and takes founder notes from module folders only; `decision-record` doesn't let moved ids set a module log's letter.

**Why.** L-31: stage 2 starts with `bin/install-skills`, and the every-session skills come first because every later session ends with them (`README.md` §5 rules 7 and 8).

**Decided by.** Reconstructed by Claude in session B, 2026-10-20, from session A's six commit messages (`601bf20` to `8cb190d`), at the founder's request. Session A left no `STATE.md` block and no entry here. Whether the founder reviewed its diffs isn't recorded, so read this as a record of what was built, not as a reviewed decision.

**Revisit.** Session A's branch, `lifecycle/stage-2a-skills`, isn't merged into `main` or pushed; session B is stacked on it (L-33). None of the four skills has run on real work yet.

## L-33 · 2026-10-20 · Rollout stage 2, session B: `build-phase`, `verify` and `debug`; the gate's call path for installed skills

**Decision.**
- **Three skills,** in the pattern of L-32's four: a `SKILL.md`, and a `context.sh` that takes the argument through a quoted heredoc and always exits 0. Each placed its seeds and keeps them in `reference.md` 0.2 with a record of what placing added.
  - `build-phase`: Opus, medium. Launch drafts and commits the card, makes the worktree with `git worktree add` from the local base, and starts a background Sonnet lane. Land saves the report with a *Measured at land* line.
  - `verify`: Opus, high, forked. It ends at "ready to fast-forward", and hands everything that needs the founder's yes back to the main session with its command.
  - `debug`: the session's model, high effort, and the one build skill Claude may invoke on its own. It stops after three refuted hypotheses, with a `STATE.md` block.
- **`lifecycle/skills/shared/build.sh`** holds the lookups the three share: root-sot, the gate, a stage's module, its project, config and code checkout. Installed skills reach it through `.root-sot`.
- **The gate's call path.** `bin/gate`'s header told skills to call it as `${CLAUDE_SKILL_DIR}/../../../lifecycle/bin/gate`. From an installed copy that path is the home folder, so the command would fail and abort the skill unseen. Skills now call the gate from `context.sh`, by the path in `.root-sot`. `gate-test` has 53 cases, seven of them for installed skills, and all pass. Shellcheck is clean.
- **Claude's calls, not yet reviewed by the founder:**
  - a `build-phase` launch or land writes a `STATE.md` block in `handoff`'s format, and that block is the session's handoff, so `/handoff` isn't run as well;
  - the lane's worktree is made with `git worktree add`, as the plan says, not the Agent tool's isolation that the three `config.md` files name;
  - `verify --milestone` takes the founder's devices in its argument, because a fork can't ask for them;
  - `verify` writes column 8 and counts Change stages in it, as `README.md` §3 says. The IMNSTR trial left them out;
  - `verify`'s frontmatter carries `background: false` as the plan specifies. Whether Claude Code reads that field isn't verified.

**Why.** `README.md` §8 stage 2 and `skills-plan.md` §3. These are the last three stage 2 skills, and the gate fix makes the installed copies usable from root-app and Tracker.

**Decided by.** Founder, 2026-10-20: asked for the three skills, written with `skill-creator`, and for the gate fix. Chose to stack this session's branch, `lifecycle/stage-2b-skills`, on session A's, because `main` lacked it, and asked for L-32 to be reconstructed. The skills' contents and the calls above are Claude's, not reviewed line by line. `skill-creator`'s eval loop wasn't run: each skill's injected context was rendered on IMNSTR's PL1, B3 and B9 and on the root-app and Tracker checkouts instead, as session A did.

**Revisit.** At the first real use, on the journeys build's owed items (Change track) and B-15 (Fix track):
- whether a fork can edit, commit and run suites (the second line of `verify`'s return);
- the Fix track: `README.md` §1 runs a Fix as debug → verify → decision record, but a Fix has no stage, card or report, so `verify`'s gate can't pass one. The trial on B-15 decides what `verify` reads for a Fix;
- whether `build-phase`'s block standing in for the handoff holds up;
- `skills-plan.md` §0 still says skills live in `root-sot/.claude/skills/`, which L-31 replaced. That file is the founder's to change.

