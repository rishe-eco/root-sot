# Lifecycle — how work moves from idea to closed

*The method behind the lifecycle skills: the three tracks of work, the phases and their gates, where every file lives and who writes it, the session and build rules that keep usage down, and how lessons are kept. The skills themselves are specified in `skills-plan.md`.*

**Version 0.5 · Status: plan — nothing here is built yet · 2026-10-19 · Owner: _root**

---

## Summary

Work arrives as one of three **tracks** — a Module (new capability), a Change (to something that exists) or a Fix. A Module moves through **phases**, each producing one committed document; each phase's skill refuses to start until the documents before it exist, are complete, and are not marked stale. Building happens in **stages** run as Sonnet **lanes**, each reviewed by Opus in a fresh context. All state lives in git: a status table, a rolling `STATE.md` per module, stage records next to the code. Sessions are short and start from those files, never from a long conversation.

The design is drawn from what already worked in this repo — the journeys build's briefs, lane reports, stage records and Sonnet-builds/Opus-reviews split — and corrects what cost the most there. Evidence: `retros/2026-10-journeys-build.md`.

## 0. Words used here

| Word | Means | Not to be confused with |
|---|---|---|
| **Track** | The kind of work: Module, Change, Fix | — |
| **Phase** | A step of the Module track: intake … close-out | a build stage |
| **Stage** | One unit of the build plan (J1, S2, …), sized to fit one lane | a phase |
| **Milestone** | A group of stages after which the full suites run (MS1 …) | — |
| **Lane** | A Sonnet subagent building one stage in its own worktree, test database and ports | a track |
| **Phase card** | The 500–700-word brief a lane gets for its stage, naming exactly what to read | the plan |
| **Lane report** | The seven-part final message a lane returns; the reviewer reads it before the diff | the stage record |
| **Stage record** | The reviewed, committed account of a stage, next to the code (`docs/development/<stage>.md`) | the lane report |
| **Acceptance criterion** | A testable line in the spec or a change note. Each document that numbers criteria owns a prefix: the spec `AC-n`, each change note its own two letters (`CI-n`, `PL-n`) | a journey step's check |
| **Finding** | One observation from a review, numbered within its pass (`P<pass>-F<n>`) | — |
| **Gate** | A mechanical check a skill runs before starting: files exist, required sections present, nothing stale | a sign-off (there is none) |

## 1. The tracks

| Track | Example | Path |
|---|---|---|
| **Module** | Loophole Lens; a new lab; the journeys build | every phase below |
| **Change** | Inline tag creation (D-58) | change note (with its stages) → `build-phase` → verify → decision record |
| ↳ *during a build* | IMNSTR's CI and deploy (CD1); its polish after the live review (PL1) | from the founder, or from review findings the founder accepted. `spec change` writes a note against the spec and the build's state, then `build-phase` → `verify` run against it. It doesn't stop the build |
| ↳ *small* | IMNSTR's session lengths (CS1) | size S, one stage, no schema change: note, build, verify and deploy in one session, with the same note and stage record. The founder chooses it, and the log says so |
| **Fix** | B-15, status always "Backlog" | debug → verify → decision record |

`lifecycle-status` sorts incoming work into a track. When in doubt between Change and Module: if it needs new journeys or new screens, it is a Module.

## 2. The Module phases

| # | Phase | Skill | Output (in the module folder) | Gate — must exist, complete, not stale |
|---|---|---|---|---|
| 0 | Intake | `ideate` | `00-intake.md` | — |
| 1 | Research | `research` | `01-research.md` | intake |
| 2 | Spec | `spec` | `02-spec.md` | research, or a waiver line in the intake |
| 3 | Journeys | `journeys` (+ `personas`) | `03-journeys.md` | spec; personas selected |
| 4 | Wireframes | `wireframes` | `04-wireframes.html` | journeys |
| 4b | Design | the founder, in a design tool; then an import session | `04b-design/`: self-contained HTML exports, `source/`, a README | wireframes |
| 5 | UX review | `ux-review` (`design` mode) | `05-ux-review.md` | the latest design (4b where it exists, else wireframes), journeys |
| 6 | Eval plan | `eval-plan` | `06-eval-plan.md` | spec |
| 7 | Build plan | `build-plan` | `07-build-plan.md` | 2–6; UX findings, journeys' *Suggested*, the design's *Beyond the spec* and wireframes' *Calls made here*: each accepted, refused or carried |
| 7b | Project config | `project-config` | `lifecycle/projects/<project>/` | build plan; runs once per project, before the first build for a project with no config |
| 8 | Build | `build-phase` → `verify` per stage | phase cards in `briefs/`; stage records in the code repo | build plan (Change track: a change note with a Stages section) |
| 9 | Live review | `ux-review` (live), `design-review` | appended to `05-…`; `08-design-review.md` | UI stages verified. Open by-hand device checks don't block it, and are listed under *Not checked* |
| 10 | Close-out | `close-out` | `09-close-out.md` | every stage verified, milestones green, learnings inbox consolidated, and no change note defers a spec `revise`. The founder may override with a reason, recorded in the close-out's header |

Phases 3, 4, 4b, 5 and 9 apply only to modules with UI. Back-end-only modules mark them `n/a`, and the gate passes an `n/a` phase. 4b and 7b have no status column: 4b shares column 4, and 7b belongs to the project, not the module.

**Launch** is an event, not a phase: the first real use in production. `close-out` records its date, or "not yet", and the eval plan's later checks count from it.

## 3. Where things live

**A module folder** in `root-sot`, under the area that owns the product (`tracker/modules/`, and `ecosystem/modules/` for root-app work until a studio area exists). A project outside Root's areas keeps its modules in `<project>/modules/NN-slug/`, and `status.md` links to it:

```
NN-slug/
  STATE.md               rolling state, newest first — what a fresh session reads first
  00-intake.md … 07-build-plan.md, 08-design-review.md, 09-close-out.md
  briefs/                phase cards (<stage>.md) and lane reports (<stage>.report.md) — committed
  changes/               one numbering: change notes from `spec change` (NN-change-<slug>.md), change requests from `revise` (NN-req-<slug>.md)
  decisions.md           one line per product decision, pointing at its change note
```

**Next to the code**, in the code repo: stage records (`docs/development/<stage>.md`) and the development README's stage list — as the journeys build did. The code repo keeps a one-line pointer to the module folder.

**Shared, in `lifecycle/`:**

| File | Holds |
|---|---|
| `status.md` | Module × phase table — the one place to see everything |
| `STATE.md` | Rolling state for work that has no module (Fixes, small Changes) |
| `personas.md` | Persona registry, each with its grounding |
| `review-instrument.md` | The six metrics, from `tracker/canon/05-reviews/00-persona-review-method.md`, plus the heuristic and coverage checklists |
| `templates/` | One per output, plus `required-headings.txt` that the gate reads |
| `projects/<project>/` | Per-project configuration: `brief-common.md`, `review-checklist.md`, `config.md` (paths, suites, milestone script, lane resources) |
| `bin/gate` | The mechanical gate check every phase skill runs |
| `retros/` | Build retrospectives |
| `learnings/inbox/` | Capture notes from `learned`, one file per session — nothing in them is acted on until consolidated |
| `learnings/index.md` | Every integrated lesson, where it now lives, and how often it recurred |
| `decision-log.md` | Decisions about the method itself, including each integrated lesson. Only those: a module's decisions go in its `decisions.md` |
| `engineering-checklist.md` | Facts about building software that hold beyond one project |

Modules that predate this system stay where they are; `status.md` points at their current paths.

**`status.md`** has one row per module and one column per phase, 0 to 10. Links are relative to `lifecycle/`. A cell is blank (not started), `done`, `n/a` or `STALE`, and also:
- **column 8** reads `done/total` during a build. Total is the plan's stages plus any Change stages, and a split stage counts once per part (B4a, B4b). Milestones don't write column 8;
- **column 10** may read `closed · eval <date>` or `closed · eval due` until the eval plan's last check;
- **a pass owed on a phase without a column** (4b, 7b) is written in its parent column as `done · owed <step>`. `STALE` is reserved for contradiction;
- **after close-out,** `STALE` means "read with the change note beside it". It is cleared only if the phase is rerun or the module reopens;
- **a scoped run** writes `done`, and its changelog line says what it didn't check.

**What the founder supplies.** The project's open-work file keeps a *From the founder* table for copy, marks, channel links, devices and production content that a check needs. Each row has *needed by*, a step or milestone. `lifecycle-status` lists the rows due within the next step.

## 4. One writer per file

| File | Only writer |
|---|---|
| `status.md` | each phase skill, **its own cell only**; `ideate` adds the row; `revise` sets `STALE`; `close-out` closes the row |
| `STATE.md` (module or shared) | `handoff`; `ideate` creates it; `build-phase` when it launches or lands a lane; `debug` when it stops after three failed hypotheses; `learned` for urgent carry-overs |
| `learnings/inbox/` | `learned` (capture writes notes); `verify` adds one capture note per review |
| `learnings/index.md` | `learned --consolidate`, which also writes the destinations once accepted |
| `lifecycle/decision-log.md` | `decision-record`; also the entries `personas`, `revise` on the method and `learned --consolidate` cause, written in `decision-record`'s format from its shared reference file |
| An area's decision log (`<area>/decisions/`) | `decision-record` |
| `<module>/decisions.md` | `revise` and `spec change`, one line per change note; `decision-record` for any other module decision |
| `engineering-checklist.md` | `learned --consolidate`, once accepted |
| `07-build-plan.md` | `build-plan`. Afterwards, `verify` writes correction-only changelog lines with the founder's yes. A change to scope goes through `revise` |
| Stage records | `verify` |
| Development README stage list | `verify` |
| The project's state-of-the-build file (named in `config.md`; for Tracker, `tracker/canon/04-roadmap/00-state-of-the-build.md`) | `verify` |
| As-built canon (data model, API, glossary) | `close-out`, from `verify`'s flags |
| The project's open-work file (named in `config.md`; for Root, `team/open-work.md`) | `verify`, `close-out`; `revise` strikes rows it settles, citing its change note |
| `personas.md` | `personas` |
| `projects/<project>/` | `project-config` creates it. Afterwards, the founder through `revise` or an accepted consolidation, or `verify` with the founder's yes, logged in the stage record |
| `templates/` | the founder, through `revise` on the method itself, or by accepting a `learned --consolidate` proposal |
| `review-instrument.md` | the founder, as for `templates/` |
| `README.md` (this file) | the founder, as for `templates/` |
| `skills-plan.md` | the founder, as for `templates/` |

One file pattern per row, so a skill can grep its own rights.

## 5. Session rules

Rules 1–6 from the retrospective's findings 1, 3 and 6; rule 7 from `learned`:

1. **One session per milestone at most** for orchestration. Planning is its own session, which ends once the plan is committed and pushed.
2. **`/clear`, not `/compact`**, once `handoff` has written `STATE.md`. `/compact` reads the whole context it summarises; `/clear` is free.
3. **Never resume a large session after a limit reset.** Start a fresh one from `STATE.md`.
4. **Reviews and live UX reviews run forked** — a fresh context holding only their declared inputs.
5. **Everything a later session needs is committed**: state, phase cards, lane reports. Nothing load-bearing lives in session memory or a scratchpad.
6. **Durable environment knowledge goes in the repo's CLAUDE.md**, not in one machine's memory.
7. **Every session ends `handoff` → `learned` → `/clear`.** Lessons are captured as notes and never edited into instructions mid-flight; `learned --consolidate` integrates them in batches (15 notes or 14 days, and at each milestone during a build), with the founder accepting each change.

## 6. Build rules

From the journeys build, kept or corrected:

1. **Sonnet lanes build; Opus reviews, fixes, merges and records.** Kept.
2. **One stage per lane, one lane per worktree**, with its own test database and ports (from `projects/<project>/config.md`). Kept.
3. **Phase cards are drafted just in time** from the plan's stage section — or, on the Change track, the change note's — and the code as it is then, and committed before the lane launches. Kept, plus committing. A card's body is 500–700 words; over 1,000 means the plan section is underspecified (IMNSTR: 10 of 12 cards ran over).
4. **At most two lanes at once, and never two that change shared schema.** Corrected (J8 and J9a).
5. **Lane budget:** each stage has a size (S/M/L): lane hours and lines of new app code, with tests and moved code counted apart. A lane past twice its size, after three failed hypotheses on one failure, or near a limit reset commits its work in progress, writes its report and stops; a fresh lane continues from the branch. New (J1, J8).
6. **No debugging through the e2e suite.** An environmental cause — rate limits, time, the database — means fixing the test setup, not rerunning. New (J1).
7. **Targeted tests per stage, full suites only at milestones**, run by the orchestrator, one heavy runner at a time. After a review fix to a shared rule, rerun every test file that asserts it. Kept, now enforced.
8. **Tests run against a fixed clock**; fixtures are relative to it. New (M4).
9. **Pre-build defect pass** for modules that touch existing code: read before building, assign each defect to a stage. Kept (`defects-found.md`).

## 7. Models

| Work | Model · effort |
|---|---|
| Research, spec, journeys, build plan, eval plan, reviews, close-out | Opus · high |
| Wireframes, revise, phase cards | Opus · medium |
| Lanes (stage builds) | Sonnet |
| Intake, personas, decision records, handoff, status | Sonnet · low to medium |
| Learnings capture | the session's own · low |
| Learnings consolidation | Opus · high |
| Debugging | the session's own · high |

Skills set these in their frontmatter, so the session's own model only matters between skills.

## 8. Rollout

| Stage | What | Proven on |
|---|---|---|
| **0. Baseline** | Retrospective of the journeys build (draft done); `/usage` and `/insights` from the build machine | — |
| **1. Foundation** | This file; `status.md` backfilled for existing modules; templates; `bin/gate`; `projects/root-app/` from the recovered brief and the plan's §0.2–0.3 and §8; `projects/tracker/`; CLAUDE.md in all three repos | Backfilling the status table is the first audit |
| **2. Build side** | `lifecycle-status`, `handoff`, `learned`, `decision-record`, `build-phase`, `verify`, `debug` | The journeys build's owed items (Change track); a Tracker Fix (B-15) |
| **3. Design side** | `ideate`, `research`, `personas`, `spec`, `journeys`, `wireframes`, `eval-plan`, `build-plan` | The next new module |
| **4. Reviews** | `ux-review` (both modes), `design-review` | That module's wireframes, then its built UI |
| **5. Loop closers** | `revise`, `close-out` | Closing out the journeys build — which completes its retrospective |
| **6. Plugin** | The skills become one plugin; project configs move to each repo | A second project |

Each stage ends by checking usage against the baseline.

## Changelog

- **0.5 · 2026-10-19** — From the IMNSTR trial (`trial-run/findings.md` 0.2), applied group by group. *Method:* where an outside project's modules live; Change during a build, and the small Change; phases 4b and 7b, and launch as an event; gates for phases 5, 7, 9 and 10; §4 one file pattern per row, with the build plan, project configs and open-work's writers; `status.md` values; the founder's supplies; `MS<n>`, criterion prefixes and pass-scoped findings. *Every-session skills:* a module's `decisions.md`; the kind in a change file's name; `engineering-checklist.md`; consolidation at each milestone. *Design and build plan:* a size's units. *Build:* card length counted by body. *Reviews:* `ux-review`'s first mode is `design`.
- **0.4 · 2026-10-06** — Change track builds from its change note: the note carries a Stages section and `build-phase` accepts it in place of a build plan.
- **0.3 · 2026-10-06** — Consistency pass against `skills-plan.md`: lane report is seven-part; every `STATE.md`, inbox and decision-log writer listed; state-of-the-build file is per project; founder-owned files also change through accepted consolidations; close-out gate requires a consolidated inbox; `n/a` phases pass the gate; models for `learned` and `debug`; `projects/tracker/` in stage 1.
- **0.2 · 2026-10-05** — Learnings: captured per session as inbox notes, consolidated in batches; session rule 7; files and owners added.
- **0.1 · 2026-10-05** — Plan. From the conversation that designed the system and the journeys build's retrospective, brief and state log.
