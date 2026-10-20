<!-- Template for `<module>/07-build-plan.md`, written by `build-plan` (Opus, high). Afterwards only `verify` writes it, correction-only, with the founder's yes; scope goes through `revise`. Template 0.1 · 2026-10-20. Sources: `skills-plan.md` §2 `build-plan`; `skills/build-plan/reference.md`; trial log `07-build-plan`; `imnstr/modules/01-website/07-build-plan.md`; `ecosystem/working/root-studio-journeys-build-plan.md`. The gate checks the headings listed for this file in `required-headings.txt`: keep their words; each stage section must carry **Goal**, **Acceptance**, **Size** and **Traps**. *Held:* 400–600 words per stage, until a second plan exists to compare with. Last step before commit: each §6 row agrees with its §5 section; planning decisions don't contradict each other or the house rules; every open call is in §10 as left to the card. Delete every comment in the output. -->
# <Module name> — build plan

*Module `<area>/modules/NN-slug/` · Track: Module · Phase 7 · `build-plan`. The order the code lands in and the shape it takes, to the level of tables, routes, refusal codes, screens and tests, so each stage's phase card is a transcription and not a design exercise. Inputs: `02-spec.md` <version>, `03-journeys.md` <version>, `04-wireframes.html`, `04b-design/` <version>, `05-ux-review.md`, `06-eval-plan.md` <version>, `lifecycle/projects/<project>/`. Update the changelog; don't fork.*

**Version 0.1 · Status: plan · <YYYY-MM-DD> · Owner: <owner>**

**Where this file yields.** On *what* the module does, the spec wins. On what a person experiences, the journeys win. On how it looks, the design. On what the code is, the repository.

**Grading.** Everything here is **proposal**. Facts about the code and infrastructure are **as-built**, read at `<repo> main @ <hash>`. Items marked **[F]** were decided by the founder (§4 for facts, §2 for vetoes).

---

## 0. What this plan is written against

### 0.1 · What was read

### 0.2 · What this plan must not break

### 0.3 · House rules this build is held to

<!-- For a new project, the source `project-config` transcribes. -->

### 0.4 · Found while reading *(defects in the documents and code, each assigned)*

<!-- The defect pass: each "never shows X" in the spec, and which mechanism could leak X (ids, URLs, timing, logs, cookies); for every count or row created from request data, what bounds its growth. -->

| # | Defect | Where | Assigned to |
|---|---|---|---|
| D-1 | <…> | <…> | <stage> |

## 1. The shape at the end

## 2. Planning decisions *(each the founder's to veto)*

**PD-1 · <title>.** <…>

## 3. Stage order

<!-- Stage, size, depends on, parallel pairs (at most two lanes; never two touching shared schema; when the spec fixes every table, the whole schema lands in the first stage), milestones (MS1 …), cost estimate. -->

| Stage | Name | Size | After | Parallel with | Milestone |
|---|---|---|---|---|---|
| B1 | <…> | <S · M · L> | — | — | MS1 |

**Sizes** *(lane hours, and lines of new app code, with tests and moved code counted apart)*: **S** <…> · **M** <…> · **L** <…>.

## 4. P0 — pre-flight

<!-- The foundation batch's answers, marked answered; then the founder's lead times; then the unknowns per stage. Each instrument's preconditions from the eval plan are placed in the stage order here. -->

**P0-1 · <fact>.** <answered [F] · open, needed by <stage>>

## 5. The stages

### B1 · <Name>

**Goal.** <What exists after this stage.>

**Schema** <migration and tables, or "none">

**Logic** <files and rules>

**API or routes** <from the screens' save boundaries, not one route per verb; refusal codes>

**Screens.** <the plate each draws from, and which stage owns each control on it; for a server-filled field, what the screen shows for each verb>

**Tests** <targeted tests, and what the e2e drives>

**Image and deploy.** <new environment variables with production defaults; toolchain changes; "none">

**Constraints from earlier stages.** <triggers, unique keys its writes must work through>

**Acceptance.** <AC-n, …>

**Size: <S · M · L>.**

**Traps.**
- <A guard for every destructive CLI; deploy-sequencing traps become stages (B6a, B6b), never an instruction one lane can't carry out.>

**Not here:** <…>

---

## 6. Cross-cutting catalogues

### 6.1 · Routes
### 6.2 · Refusal codes
### 6.3 · Tables
### 6.4 · Limits
### 6.5 · <Module-specific catalogue>
### 6.6 · Runtime dependencies
### 6.7 · Every acceptance criterion, by stage

<!-- Lets `verify` and `close-out` trace a criterion to a stage. Every criterion in the spec and the journeys' Coverage appears once. -->

| Criterion | Stage |
|---|---|
| AC-1 | B1 |

## 7. What this plan changes in code that is already built

## 8. Verification, and its ceiling

<!-- Done means; what the suites prove; what only a person on a device can check (the by-hand list, each with *needed by*); the ceiling. -->

## 9. Where this is most likely to go wrong

## 10. For the founder

<!-- Facts owed, decisions to veto, and every open call left to the card. -->

## Changelog

- **0.1 · <YYYY-MM-DD>** — Plan, from <inputs and versions>.
