# Trial run — the lifecycle by hand, before the skills exist

*One real piece of work taken through every phase of the lifecycle, each phase run by a fresh agent acting as that phase's skill would. The point is to find what the method and the skill specs are missing, and to leave behind real outputs the skills and templates are written from. If you are an agent starting a phase, this file is your brief: read it all.*

**Version 0.3 · Status: active · 2026-10-09 · Owner: _root**

---

## The run

*Filled in by the founder before phase 0.*

| | |
|---|---|
| Piece | IMNSTR.com, a personal website: a landing page (with projects on it), a learnings log of short daily entries, a Monster Podcast page of links, and a single admin page |
| Track | Module |
| Project | `imnstr`. New; its code repo doesn't exist yet and is needed by step 7 |
| Module folder | `imnstr/modules/01-website/` |
| Branch | `lifecycle-trial/imnstr` |

## 1. What you are doing

You are running **one phase** of the lifecycle by hand. Act as the skill for that phase would, as specified in `lifecycle/skills-plan.md`. Produce the phase's output in the module folder, then **log** how it went in `log/`. The output is the work. The log is the evidence for designing the skill.

Read, in this order, and nothing more until your work needs it:
1. this file;
2. `lifecycle/README.md` §0–§4 (words, tracks, phases, where things live, who writes what);
3. `lifecycle/skills-plan.md` §0 (shared mechanics) and **your skill's section only**;
4. the module folder's `STATE.md`, top block;
5. your phase's inputs (table below), **by section where you can**.

Log every file you read beyond these, and why you needed it.

## 2. Rules for every session

1. **One phase per session.** When your output is committed, stop. Don't start the next phase, even if it looks small.
2. **Check the gate by hand first.** Do the inputs exist, are they complete, and are none marked `STALE` in `lifecycle/status.md`? If the gate fails, stop and log it. Don't backfill an earlier phase.
3. **Never edit the method**: `lifecycle/README.md`, `skills-plan.md`, `retros/`, or this file. Where the method is wrong or silent, do what makes sense, then record it in the log under *Spec gaps*. Changes are applied once, at the end.
4. **Write only:**
   - your phase's output;
   - your log file;
   - a new top block in the module's `STATE.md`, written in `handoff`'s format (see its skill section);
   - your phase's cell in `lifecycle/status.md`;
   - a foundation stub, if your phase's row below allows one.
5. **Don't build skills**, templates or `bin/gate`. Note in the log what yours should contain.
6. **Grade claims** the house way, *evidence / as-built / proposal*, and don't invent sources.
7. **Ask the founder** when the skill would ask: clarifying questions, acceptance, decisions. Log each question and its answer.
8. **Commit and push** to the run's branch, then end the session. Nothing load-bearing stays in chat.

## 3. The phases

Model and effort follow `lifecycle/README.md` §7. The founder starts each session on that model. Log files are numbered by session order.

| Step | Act as | Model | Inputs | Output | Foundation stub allowed | Done looks like | Don't |
|---|---|---|---|---|---|---|---|
| 0 Intake | `ideate` | Sonnet · medium | the founder's description | module folder, `00-intake.md`, `STATE.md`; the module's row in `lifecycle/status.md` | `lifecycle/status.md` holding only the header and this row (format below) | one page, the six questions answered, no sources | research; propose solutions beyond the smallest version |
| 1 Research | `research` | Opus · high | intake; `ecosystem/canon/04-research/00-evidence-summary.md` first | `01-research.md` | — | five-line summary on top, claims graded, ≤ ~2,500 words | re-research what the evidence summary already holds |
| 2 Spec | `spec` (`full`) | Opus · high | intake, research | `02-spec.md` | — | clarifying questions asked in one batch and answered; acceptance criteria testable | restate journeys; design screens |
| 3a Personas | `personas` | Sonnet · medium | intake; `lifecycle/personas.md` | the selection in the header of `03-journeys.md` | `lifecycle/personas.md`, seeded from `tracker/canon/05-reviews/00-persona-review-method.md` §2; `lifecycle/decision-log.md`, if a new persona is proposed, holding only that entry | named personas, each with why | redefine an existing persona |
| 3b Journeys | `journeys` (`new`) | Opus · high | spec; `03-journeys.md` header | `03-journeys.md` | — | 3–5 journeys of ~10 steps, including first day, return after a gap, not enough data, error | wireframe |
| 4 Wireframes | `wireframes` | Opus · medium | journeys | `04-wireframes.html` | — | every journey step, plus empty, error, loading and not-enough-data states | style beyond low fidelity |
| 4b Design | *(the founder, in Claude Design; then a session to bring it in)* | Opus · medium for the import session | spec, journeys, wireframes | `04b-design/` holding what Claude Design exports, plus a short `README.md` listing what's there and the design system it settles (type, colour, spacing, components) | — | every wireframed screen has a designed counterpart, or the gap is listed; what did not survive the move from Claude Design is logged | redesign anything in the import session |
| 5 UX review | `ux-review` (`wireframes`) | Opus · high | journeys, the 4b design where it exists (wireframes as fallback), the spec's interface and acceptance sections, the selected personas, the review instrument | first pass in `05-ux-review.md` | `lifecycle/review-instrument.md`: the six metrics from the persona method §3, plus Nielsen's ten heuristics and the coverage checklist | each finding scored and graded *simulated*; spec-changing findings listed for `revise` | fix the wireframes or design yourself |
| 6 Eval plan | `eval-plan` | Opus · high | spec | `06-eval-plan.md` | — | decision rule written before any data; ambiguous outcome named | — *(can run beside 3–5)* |
| 7 Build plan | `build-plan` | Opus · high | 2–6; the code, through a defect pass | `07-build-plan.md` | — | §0–§10 as in the skill spec; every stage sized with its traps | build anything; carry on into the build in the same session |
| 7b Project config | *(stage-1 foundation)* | Opus · medium | the build plan; `lifecycle/retros/2026-10-journeys-build.md`; anything the founder supplies | `lifecycle/projects/<project>/brief-common.md`, `review-checklist.md`, `config.md` | these three files | contents as `skills-plan.md` §0 and `build-phase` list them | write phase cards |
| 8a Launch | `build-phase <stage>` | Opus · medium | plan §5 for the stage; project config | `briefs/<stage>.md`; a background Sonnet lane; a lane entry in `STATE.md` | — | card of 500–700 words naming exact sections to read | build the stage yourself |
| 8b Land | `build-phase <stage> --land` | Opus · medium | the lane's report | `briefs/<stage>.report.md` | — | seven-part report saved and committed | review the diff |
| 8c Verify | `verify <stage>` | Opus · high | lane report, diff stat, card, plan §5 for the stage, review checklist | fixes on the branch; stage record in the code repo; owed items in `team/open-work.md` | — | the eleven steps in the skill spec, ending "ready to fast-forward" or what blocks it | read beyond what the diff points to |
| 8d Milestone | `verify --milestone <M>` | Opus · high | config's milestone script | counts in the development README | — | full suites run, one heavy runner at a time | — |
| 9 Live review | `ux-review` (`live`), then `design-review` | Opus · high | as in 5, against the running app; for design review, the brand and tokens (for IMNSTR, the design system from 4b, not Root's brand) | new pass in `05-ux-review.md`; `08-design-review.md` | — | scores comparable with the step-5 pass | fix the UI yourself |
| 10a Consolidate | `learned --consolidate` | Opus · high | every log's *Lessons* section | a proposal for the founder; accepted items listed in `log/` | — | lessons clustered and counted; founder decides each | apply edits to the method; that happens in 10c |
| 10b Close-out | `close-out` | Opus · high | eval plan and results, stage records, `STATE.md` | `09-close-out.md`; the status row closed | — | evaluation against the rule written beforehand; the module's cost | — |
| 10c Trial wrap-up | *(`revise` on the method)* | Opus · high | every log | `findings.md` in this folder: each spec gap, grouped by skill, with a proposed edit | — | every *Spec gaps* and *Missing foundation* item accounted for | apply the edits; the founder decides |

**`lifecycle/status.md`** has one row per module and one column per phase:

```
| Module | Track | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| [NN-slug](path/to/module/) | Module | done | | | | | | | | | | |
```

Each cell is blank (not started), `done`, `n/a` or `STALE`. Write only your own phase's cell. Steps 3a and 3b share column 3, which 3b marks done. Step 7b has no column. During the build, column 8 holds stages done out of the total (e.g. `3/9`) until every stage is verified.

If intake finds the piece is a **Change**, not a Module, the run follows the Change track instead: `spec change` writes a change note with stages, then 8a–8c run against it. Log that decision.

## 4. The log

One file per session: `log/NN-<step>.md` (e.g. `00-intake.md`, `07b-project-config.md`, `08c-J1-verify.md`). Use these headings. Write "none" rather than dropping a section: an empty section tells the skill something too.

```
# <step> — <date>

## Session
Model and effort; what the founder gave you to start.

## Read
Every file read, whole or by section, and why. Mark anything outside §1's read order.

## Gate
What you checked by hand, the headings you looked for, the result.

## Did
The steps, in order, mapped to the skill spec's steps. Note any you skipped or reordered.

## Output
Files written and commit hashes.

## Spec gaps
Where the skill spec was silent, wrong, ambiguous or impossible, and what you did instead. The most important section.

## Template sample
The headings your output used, and which should be required (the future `required-headings.txt`).

## Missing foundation
Files or config you needed that don't exist, and what you used instead.

## Founder Q&A
Each question asked, and the answer.

## Skill shape
What the skill should be, from doing it: model and effort; forked or not; what you fetched that could be injected at invocation instead (`!` commands); what its reference file should hold.

## Lessons
Zero to three notes in `learned` capture format: the rule; the event that taught it and its cost; the scope; a suggested destination; `urgent: yes` if the next session must know.

## Cost
*Founder fills in after the session:* tokens or share of the limit from `/usage`, and wall time.

## Next
The next step, and anything its agent must know that `STATE.md` doesn't say.
```

## Changelog

- **0.3 · 2026-10-09** — Run filled in: IMNSTR.com. Step 4b added for Claude Design; steps 5 and 9 review against its output.
- **0.2 · 2026-10-07** — `status.md` format defined; step 3a may create `lifecycle/decision-log.md` for a new persona's entry.
- **0.1 · 2026-10-06** — Trial brief: rules, the phase table with outputs and boundaries, and the log format.
