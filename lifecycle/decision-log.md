# Decision log — the lifecycle method

*Decisions about the method itself, and only those. Written in `decision-record`'s format. A module's product decisions live in its change notes, indexed in `<module>/decisions.md`. L-2, L-3, L-5 and L-6 moved to `imnstr/modules/01-website/decisions.md` on 2026-10-19 (L-9), keeping their ids.*

**Version 0.17 · 2026-10-19**

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
