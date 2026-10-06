# Lifecycle — how work moves from idea to closed

*The method behind the lifecycle skills: the three tracks of work, the phases and their gates, where every file lives and who writes it, the session and build rules that keep usage down, and how lessons are kept. The skills themselves are specified in `skills-plan.md`.*

**Version 0.3 · Status: plan — nothing here is built yet · 2026-10-06 · Owner: _root**

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
| **Milestone** | A group of stages after which the full suites run (M1 …) | — |
| **Lane** | A Sonnet subagent building one stage in its own worktree, test database and ports | a track |
| **Phase card** | The 500–700-word brief a lane gets for its stage, naming exactly what to read | the plan |
| **Lane report** | The seven-part final message a lane returns; the reviewer reads it before the diff | the stage record |
| **Stage record** | The reviewed, committed account of a stage, next to the code (`docs/development/<stage>.md`) | the lane report |
| **Gate** | A mechanical check a skill runs before starting: files exist, required sections present, nothing stale | a sign-off (there is none) |

## 1. The tracks

| Track | Example | Path |
|---|---|---|
| **Module** | Loophole Lens; a new lab; the journeys build | every phase below |
| **Change** | Inline tag creation (D-58) | change note → stages → verify → decision record |
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
| 5 | UX review | `ux-review` (wireframes mode) | `05-ux-review.md` | wireframes, journeys |
| 6 | Eval plan | `eval-plan` | `06-eval-plan.md` | spec |
| 7 | Build plan | `build-plan` | `07-build-plan.md` | 2–6, UX findings closed or carried |
| 8 | Build | `build-phase` → `verify` per stage | phase cards in `briefs/`; stage records in the code repo | build plan |
| 9 | Live review | `ux-review` (live), `design-review` | appended to `05-…`; `08-design-review.md` | UI stages verified |
| 10 | Close-out | `close-out` | `09-close-out.md` | every stage verified, milestones green, learnings inbox consolidated |

Phases 3, 4, 5 and 9 apply only to modules with UI. Back-end-only modules mark them `n/a`, and the gate passes an `n/a` phase.

## 3. Where things live

**A module folder** in `root-sot`, under the area that owns the product (`tracker/modules/`, and `ecosystem/modules/` for root-app work until a studio area exists):

```
NN-slug/
  STATE.md               rolling state, newest first — what a fresh session reads first
  00-intake.md … 07-build-plan.md, 08-design-review.md, 09-close-out.md
  briefs/                phase cards (<stage>.md) and lane reports (<stage>.report.md) — committed
  changes/               numbered change notes from `spec change` and change requests from `revise`
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
| `decision-log.md` | Decisions about the method itself, including each integrated lesson |

Modules that predate this system stay where they are; `status.md` points at their current paths.

## 4. One writer per file

| File | Only writer |
|---|---|
| `status.md` | each phase skill, **its own cell only**; `ideate` adds the row; `revise` sets `STALE`; `close-out` closes the row |
| `STATE.md` (module or shared) | `handoff`; `ideate` creates it; `build-phase` when it launches or lands a lane; `debug` when it stops after three failed hypotheses; `learned` for urgent carry-overs |
| `learnings/inbox/`, `learnings/index.md` | `learned` (capture writes notes; consolidate writes the index and, once accepted, the destinations); `verify` adds one capture note per review |
| `lifecycle/decision-log.md`, decision logs | `decision-record`; also the entries `personas`, `revise` and `learned --consolidate` cause, written in `decision-record`'s format from its shared reference file |
| Stage records, development README stage list | `verify` |
| The project's state-of-the-build file (named in `config.md`; for Tracker, `tracker/canon/04-roadmap/00-state-of-the-build.md`) | `verify` |
| As-built canon (data model, API, glossary) | `close-out`, from `verify`'s flags |
| `team/open-work.md` | `verify`, `close-out` |
| `personas.md` | `personas` |
| Templates, project configs, `review-instrument.md`, this file, `skills-plan.md` | the founder, through `revise` on the method itself, or by accepting a `learned --consolidate` proposal |

## 5. Session rules

Rules 1–6 from the retrospective's findings 1, 3 and 6; rule 7 from `learned`:

1. **One session per milestone at most** for orchestration. Planning is its own session, which ends once the plan is committed and pushed.
2. **`/clear`, not `/compact`**, once `handoff` has written `STATE.md`. `/compact` reads the whole context it summarises; `/clear` is free.
3. **Never resume a large session after a limit reset.** Start a fresh one from `STATE.md`.
4. **Reviews and live UX reviews run forked** — a fresh context holding only their declared inputs.
5. **Everything a later session needs is committed**: state, phase cards, lane reports. Nothing load-bearing lives in session memory or a scratchpad.
6. **Durable environment knowledge goes in the repo's CLAUDE.md**, not in one machine's memory.
7. **Every session ends `handoff` → `learned` → `/clear`.** Lessons are captured as notes and never edited into instructions mid-flight; `learned --consolidate` integrates them in batches (15 notes or 14 days), with the founder accepting each change.

## 6. Build rules

From the journeys build, kept or corrected:

1. **Sonnet lanes build; Opus reviews, fixes, merges and records.** Kept.
2. **One stage per lane, one lane per worktree**, with its own test database and ports (from `projects/<project>/config.md`). Kept.
3. **Phase cards are drafted just in time** from the plan's stage section and the code as it is then, and committed before the lane launches. Kept, plus committing.
4. **At most two lanes at once, and never two that change shared schema.** Corrected (J8 and J9a).
5. **Lane budget:** each stage has a size (S/M/L). A lane past twice its size, after three failed hypotheses on one failure, or near a limit reset commits its work in progress, writes its report and stops; a fresh lane continues from the branch. New (J1, J8).
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

- **0.3 · 2026-10-06** — Consistency pass against `skills-plan.md`: lane report is seven-part; every `STATE.md`, inbox and decision-log writer listed; state-of-the-build file is per project; founder-owned files also change through accepted consolidations; close-out gate requires a consolidated inbox; `n/a` phases pass the gate; models for `learned` and `debug`; `projects/tracker/` in stage 1.
- **0.2 · 2026-10-05** — Learnings: captured per session as inbox notes, consolidated in batches; session rule 7; files and owners added.
- **0.1 · 2026-10-05** — Plan. From the conversation that designed the system and the journeys build's retrospective, brief and state log.
