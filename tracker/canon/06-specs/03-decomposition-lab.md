# Tracker — Decomposition Lab (skill tool #3)

*Spec, not as-built. The tool that trains decomposition — breaking a messy problem into smaller checkable pieces — and measures it against a keyed structure plus the order the learner built it in. Runs on `00-skills-engine.md`. Wireframes: `03a-decomposition-lab-wireframes.html`. Phase order, exact paths and algorithms: `03b-decomposition-lab-build-plan.md`. Update the changelog; don't fork.*

**Version 0.3 · Status: spec · 2026-08-11 · Owner: _root**

---

## 1. The skill, and the costume it wears

Decomposition is skill #3 in the durable stack (`../../../ecosystem/canon/04-research/02-durable-ai-skills.md` §3): intermediate tier, the first skill that is about a *structure* rather than an utterance. Clarity Lab trains one well-formed ask. Decomposition is what you need when the thing you want cannot **be** one ask.

**The perishable costume here is unusually well documented, which makes this the cleanest worked example of the compound-versus-perish frame the canon has.** "Least-to-most prompting" (Zhou et al. 2022) and "decomposed prompting" (Khot et al. 2022) tell you to break a problem into ordered subproblems *and hand them to the model that way*. The measured gains are real and large — decomposed approaches beat monolithic chain-of-thought by roughly 4–13 percentage points on hard reasoning benchmarks. They are also **gains in the model's output, not in the human's capacity**, and they are already eroding: reasoning models decompose internally, and prescribing a reasoning path to a model that has its own is increasingly neutral-to-harmful. The costume is *decomposing for the model*. It perishes on the next release.

**The durable skill underneath is decomposing for yourself** — so that you know what you are actually asking for, so that each piece has a checkable done condition, and so that a wrong answer to one piece is detectable instead of dissolved into a plausible whole. That instinct predates LLMs by decades and survives every model change. This is the distinction the tool is built on, and §3 `d0` names the costume out loud rather than pretending it doesn't exist (engine §2, non-goals).

**Grade: moderate for the skill, thin for the instrument.** The pedagogy is well evidenced (§2). The *assessment* of decomposition is not: the three most relevant instruments are a 75-student tool for grades 4–9, a practitioner account with no rubric and no reliability statistics, and a qualitative coding study of 55 diagrams. **Nobody has published a validated decomposition rubric.** That is a risk (§11) and, exactly as with the delayed-probe gap the parent brief identified, an opportunity to contribute back (§12).

## 2. Pedagogy — and the reason this tool needs *both* existing session shapes

**Teach an explicit strategy; do not teach "plan first."** The writing meta-analysis separates these cleanly: explicit strategy instruction scores *d* ≈ 0.82 and setting product goals *d* ≈ 0.70, while generic **prewriting activities score only *d* ≈ 0.32** and studying models alone *d* ≈ 0.25 (Graham & Perin 2007). Telling someone to break the problem down first is a prewriting activity. Giving them a named, ordered strategy with observable success features is strategy instruction. The gap between those two numbers is this tool's entire design licence.

**Use subgoal-labelled contrast, not free-form examples.** Subgoal-labelled worked examples — where the steps are grouped into named, meaningful chunks — improve problem solving and produce gains on both **near and far transfer** tests relative to the same examples unlabelled (Catrambone & Holyoak; Margulieux, Guzdial & Catrambone; Morrison et al. 2015; replicated in primary mathematics, 2022). This is the strongest single result under the tool, and it is also a constraint: the *labels* are what work. An unlabelled good example is the weak *d* ≈ 0.25 intervention.

**The expert/novice signature is a behaviour, and that is the discovery that makes this tool measurable.** Experts decompose **breadth-first** — enumerate every major piece at a high level of abstraction before developing any one of them. Novices decompose **depth-first** — latch onto one aspect and solve it completely before considering the rest. Experts also spend disproportionate effort on problem formulation before producing anything. This is a documented difference in *sequence*, which means it is instrumentable in-app for free, the same way Evidence Lab's check-before-verdict ordering is (§6.2). Decomposition Lab does not need an LLM to measure its headline behaviour.

**Session economy — the answer to the canon's open question.** `learn.md` §9 asks whether a generic module runner survives contact with a third module. It does not survive as a *quiz component*, and it does not need six bespoke tools either. What this tool needs is **both existing shapes at once**:

| | Clarity-shaped | Evidence-shaped |
|---|---|---|
| Modules | `d1-frame`, `d2-breadth`, `d3-seams`, `d6-recompose` | `d4-size`, `d5-order` |
| Unit | a structure the learner authors and revises | a faulty breakdown with one seeded fault |
| Sitting | 10–15 min, one artifact + one revision | ~2 min, 3 items |
| Scored | the product, against a keyed structure | the diagnosis, against the seeded fault |

So the finding to carry forward is sharper than "pedagogy belongs to the skill": **pedagogy belongs to the *step*, not the tool.** The third module is evidence *for* a composable step library — the seven-step template with per-step implementations the tool selects — and against both a generic runner and per-tool duplication. Recommend recording this as a decision after review.

## 3. Modules

Six, 1:1 with the rubric criteria (§4), ordered as the engine's baseline recommends. Plus one unscored aside.

| Key | Module | Trains | Criterion |
|---|---|---|---|
| `d1-frame` | **State the whole before the parts** | The unbroken problem and its done condition, written first. You cannot check coverage against an unstated whole — and this is where premature decomposition is caught | D1 |
| `d2-breadth` | **All the pieces before any one piece** | Breadth-first enumeration; naming every top-level piece at one level of abstraction before developing any of them; resisting the depth-first dive | D2 |
| `d3-seams` | **Cut where the seams are** | Non-overlapping pieces, one responsibility each, repeated work factored out once rather than restated in three places | D3 |
| `d4-size` | **Right-sized pieces** | Granularity by checkability — a piece is the right size when you can state a yes/no condition for its being done. Includes the refusal: when *not* to decompose | D4 |
| `d5-order` | **Dependencies, not just order** | Containment vs. sequence vs. dependency; what blocks what; what can run in parallel. The three are routinely blended and the blend is a documented novice failure | D5 |
| `d6-recompose` | **Does it add back up?** | Reassembling the pieces and testing them against `d1`'s whole; finding the missing piece; the habit of checking coverage rather than assuming it | D6 |

- **`d0-costume` (unscored aside, one screen).** Names "least-to-most" and "decomposed prompting" as the perishable version, states that they were genuinely effective and are decaying, and states what survives: you decompose so *you* can check, not so the model can follow. Appears once, re-openable, never scored. Precedent: Clarity Lab `c6-economy`'s token-economy aside.
- **`d4-size` is the bridge to Tracker's own machinery.** "Can you say yes/no whether this piece is done?" is the Clarity Check's *Binary Clarity* and *Observability* dimensions (`../01-product/02-clarity-check.md`) applied to a node instead of a goal, and Clarity Lab's R5 applied to a structure instead of a sentence. Cross-link all three; do not re-teach it three times.
- **`d5-order` maps onto the hierarchy the app already has.** Containment is goal → milestone → project → action; sequence is milestone `order`; dependency is *not modelled in Tracker at all* (`../01-product/00-concepts-and-hierarchy.md` §1). Teaching the distinction while the app collapses two of the three is honest only if the module says so.

**The seam with skill #5, stated so it isn't crossed.** Decomposition Lab trains "every piece is independently checkable" and stops. *Which* pieces you hand to a model is **calibrated delegation** (#5) and belongs to that tool. This tool may ask a learner to mark a piece as delegable; it must never score the choice. Same discipline as Clarity Lab stubbing the memory module for #6 rather than absorbing it.

## 4. The instrument: keyed-structure decomposition rubric v1

Analytic, six criteria, **0 = absent · 1 = partial · 2 = present**, total **0–12** — deliberately the same shape as Clarity's rubric v1, because the engine already carries it and six is the top of the band where marking stays consistent (engine §7). Every descriptor is a decision rule about an observable feature of the structure or of the order it was built in.

| # | Criterion | 0 | 1 | 2 |
|---|---|---|---|---|
| **D1** | **Whole stated** | No statement of the undivided problem, or pieces appear before any whole | Whole stated but with no done condition, or the statement is a restatement of the prompt | The whole is stated in the learner's own words *with* a done condition, before the first piece is created |
| **D2** | **Breadth before depth** | The first branch is developed to its leaves before a second top-level piece exists | Some top-level enumeration, then a dive; ≥1 top-level piece added after a depth-2 piece | Every top-level piece exists before any second-level piece; siblings sit at one level of abstraction |
| **D3** | **Seams — exclusivity** | Two or more pieces overlap in responsibility, or the same work is restated in ≥2 pieces | Exactly one overlap or one duplication | No piece's work is contained in another's; shared work is factored into one named piece |
| **D4** | **Size — checkability** | ≥2 pieces have no statable yes/no done condition (monoliths), **or** the structure shatters a piece the key marks as atomic | One such fault | Every leaf has a yes/no done condition a third party could apply; nothing atomic has been split |
| **D5** | **Dependency** | Dependencies unmarked, or containment and sequence used interchangeably with no distinction | Dependencies marked but ≥1 of the key's blocking relations is missing or inverted | Every blocking relation in the key is present and correctly directed; independent pieces are not falsely ordered |
| **D6** | **Coverage** | ≥2 of the key's required elements are absent from the structure | Exactly one required element absent | Every required element the item's key marks *required* appears in exactly one piece, and no more than one piece is outside the item's scope |

**Void flag** (separate, never averaged as a zero): empty, off-task, or a structure that merely re-lists the prompt's sentences as pieces.

**Scoring split by source — and this is why the tool needs no credential:**

| Criterion | Source | How |
|---|---|---|
| D1 | Detector + instrumentation | Presence of a whole-statement event before the first `NODE_ADDED`; done-condition detector reuses Clarity's R5 surface checks |
| D2 | **Instrumentation only** | Computed from `SkillCheckEvent` order. Fully deterministic, zero model involvement |
| D3 | Key (arrangement items) / judge (free authoring) | Overlap pairs are enumerated in the item key |
| D4 | Key + detector | The key marks atomic elements; leaf-level done-condition detection is deterministic |
| D5 | Key | Blocking relations are enumerated in the item key; graph comparison |
| D6 | Key (arrangement) / judge (free authoring) | Required-element set matching |

**Probe-grade scoring is key-and-instrumentation only, therefore offline and reproducible.** The judge appears in exactly one place: matching free-authored prose to the key's required elements and overlap pairs in *practice* items (D3, D6). That is a fuzzy string-matching job, not a rubric judgement, and it degrades to learner self-diagnosis against a visible key when no credential is configured. **Consequence: Decomposition Lab is measurement-capable with no LLM at all** — the same property that made Evidence Lab the right P0 (engine §14), and a reason to prefer this tool over #4 and #5 as the next build.

**The detector-is-a-ceiling rule carries over unchanged** (`01-clarity-lab.md` §4): where both a key and a judge can see a criterion, the final level is `min(key, judge)`. A structure that ticks every keyed box has not thereby been shown to be a good decomposition.

**Persian is the cheapest of the three tools, and this is worth stating because it inverts the usual assumption.** Everything that makes a decomposition item an instrument — required-element sets, atomic markers, overlap pairs, blocking relations, control status — is structural and **locale-invariant**. Only scenario prose and piece labels are realized twice. Unlike Clarity's R4/R6 there is **no Persian-specific linguistic work at all**; unlike Evidence there is no source-availability constraint. RTL passes on the breakdown canvas and the recomposition panes ship with the `fa` surface (engine §5.1).

## 5. Item types

1. **Arrangement task** — a palette of candidate pieces (correct ones, plus authored overlaps, monoliths, atomics-that-shouldn't-split, and out-of-scope decoys) which the learner selects and arranges into a tree with dependencies. Fully keyable, offline, reproducible, order-instrumented. **This is the baseline/post/delayed instrument**, for the same reason Evidence Lab freezes its snapshots: a probe whose scoring depends on free text is a weaker measurement than one whose scoring doesn't.
2. **Breakdown task** (free authoring) — a scenario plus a hidden required-element key; the learner authors the structure from nothing. The primary *practice* item and the one that feels like the real skill. D3/D6 route to the judge or to self-diagnosis.
3. **Repair task** — a supplied faulty breakdown with one seeded fault (monolith · overlap · missing element · inverted dependency · premature split). The learner names the fault, then fixes it. Scored on **diagnosis accuracy against the seeded fault** *and* the repaired structure — naming *why* it was wrong is the transferable half (`01-clarity-lab.md` §5.2 precedent).
4. **Contrast pair** (step 2 only, unscored) — the same problem decomposed two ways, monolithic and shattered, **with the subgoal labels shown**. Labels are load-bearing per §2; an unlabelled pair is the weak intervention.
5. **Don't-decompose item — the control.** A task that is already one checkable piece; the correct response is to leave it whole with a stated done condition. **~⅓ control ratio in every form, drill, and probe**, mirroring Evidence Lab §4.
6. **Real-work breakdown** (open practice only) — a real Goal, Project or DoD from the learner's own Tracker. Never scored into mastery or probes. §8.

## 6. Metrics

- **Rubric total** 0–12, plus six criterion lines. The analytic rubric's whole justification is saying *which* thing improved.
- **Coverage rate** — required elements present ÷ required elements in the key. The most interpretable single number, and the one with a literature baseline to be embarrassed by: in the closest published study **51 of 55 student diagrams were missing required functionality**, with two specific elements absent from ~70%.
- **Breadth-first index** — top-level pieces created before the first depth-2 piece ÷ total top-level pieces. Deterministic, instrumented, and the direct operationalisation of the expert/novice signature (§2). **This is the headline behavioural measure.**
- **Granularity discrimination** = right-sized rate on decomposable items **−** over-decomposition rate on control items. Reported next to the rubric total, never below the fold. This is the same refusal Evidence Lab generalised: *when training a critical faculty, the false positive must cost what the false negative costs.* A learner who shatters everything into twenty pieces has not learned decomposition; they have acquired a different failure.
- **Diagnosis accuracy** on repair items — agreement between the learner's named fault and the seeded one.
- **Revision delta** on breakdown → revised breakdown, with Clarity's win condition: the delta **narrowing** over time, because the structure got better on the first pass.
- **Formulation latency** — time from item start to first `NODE_ADDED`. **Descriptive only, never scored, and note the inversion:** in Evidence Lab a *falling* latency is the reflex forming; here a *rising* one is weak evidence of expert-like formulation effort. It is gameable and confounded by reading speed, so it is displayed and never counted.

## 7. Mastery criterion

**Mastered** = on two consecutive unscaffolded items across two distinct calendar days: **≥ 10/12 total, no criterion at 0, level 2 on that module's own criterion, and no over-decomposition on any control item in that window.** All four clauses are load-bearing — a globally strong decomposer could otherwise coast to mastery on `d5` while leaving dependencies unmarked, and coverage without granularity discrimination is a learner who breaks everything down and calls it rigour.

**Tested out** = the baseline showed level 2 on that criterion across both arrangement items, with no control-item over-decomposition.

**Pool floor** (learned the expensive way in Evidence Lab, D-17): **≥ 6 practice items per module, of which ≥ 3 offline-capable and ≥ 2 control**, enforced as a content-pack validation error before any frontend work. Mastery requires clean control items, so a pool with no controls leaves a mastery clause untestable as well as the training misleading.

## 8. Practice modes

- **Calibrated practice** — interleaved across all six modules and all five fault profiles. Interleaving, not blocking.
- **Real-work breakdown** — the learner picks one of their own Goals or Projects and decomposes it. The tool scores what it can (D1, D2, D4, D5 are all key-free), produces a **breakdown card**, and **offers an explicit, reviewed export into real milestones/projects — one screen, item by item, never automatic.** This is the strongest integration available to any skill tool and also the only one that can damage the user's actual data; an auto-write would be unforgivable. Uncalibrated → feedback and history only.

That export is the feature most likely to make this tool durable, the way the verdict card is for Evidence Lab. It is also the answer to the abandonment risk both existing tools carry: a tool used on live work survives the modules being finished.

## 9. Engine deltas

Small, and only one needs a migration.

- `SkillKey` += `DECOMPOSITION`. New content pack `decomposition/v1` under `api/src/content/skills/`, spec/surface split, validator mirroring the other two.
- **The artifact is a tree, not text.** Add `SkillAttempt.responseStructure String?` — a JSON string per convention #2, parsed in `typeResolvers.ts`. Reusing `responseText` for serialized JSON would work and would make "the prose" and "the structure" indistinguishable in every later query. Additive migration; needs a `../../decisions/decision-log.md` entry and a `../02-architecture/01-data-model.md` update in the same change (convention #11).
- **Authoring order reuses `SkillCheckEvent` — no migration.** New kinds, lowercase snake to match the existing rows (`opened_sideways`, `verdict_set`): `whole_stated`, `node_added`, `node_moved`, `dependency_set`, `breakdown_locked`, `diagnosis_locked`, `recompose_revealed`, each offset-stamped server-side. This is the third tool to record its forcing function this way (Evidence's check ordering, Clarity's two locks), which settles `SkillCheckEvent` as the engine's real ordering primitive rather than an Evidence-specific table.
- **Own GraphQL types** (`DecompositionModule`, `DecompositionServedItem`, …), per the Clarity precedent — widening Evidence's types would force every field on three tools to be nullable.
- Probe forms A/B/C of arrangement items, matched item-for-item on fault profile and difficulty, ≥⅓ control.
- Review queue, spacing and the delayed probe come from the engine unchanged — **but note that Clarity's review scheduling is currently unimplemented** (`nextReviewAt` is never written for clarity, and `skillDueReviews` reads evidence only). Do not inherit that gap; a third tool is the point at which it should be fixed in the shared scheduler rather than per tool.

## 10. Interface requirements

The breakdown canvas is genuinely novel — nothing in Tracker or the two existing labs is a node editor. **Wireframes: `03a-decomposition-lab-wireframes.html`, draft 1, drawn 2026-08-11.** Ten plates plus an RTL pass; two are new components (the canvas, the recomposition reveal) and the rest rearrange what Clarity and Evidence Lab already have.

- **Breakdown canvas** — a node editor with an explicit level structure. **No AI assistance, no suggested pieces, no autocomplete of any kind** while authoring. The same rule as Clarity's plain textarea and for a much stronger reason: decomposition is the most offloadable skill on the six-skill list (§11), and a suggest-a-breakdown affordance would train the offloading rather than the skill.
- **The whole is stated first and locked.** D1 is unscoreable if pieces can precede it, and the ordering *is* the measurement, so the whole-statement is server-stamped and not editable after the first piece.
- **Recomposition reveal** — three panes, the direct analogue of Clarity's gap reveal: the whole as the learner stated it · their pieces reassembled · what the key says is missing, overlapping or oversized. The learner **commits** the breakdown before this appears.
- **Diagnose step before scores.** On repair items the learner names the fault first; their tag versus the seeded fault is itself a display.
- **The rubric is always visible.** Teaching object, not hidden grading scheme; the guard against writing-to-the-rubric is the `min(key, judge)` ceiling and real-work practice.
- **Unscored criteria render as the words "not scored"**, never an empty pip row, and the total reads `n / 6` with "3 of 6 criteria scored" beneath — pinned by test, per the Clarity Phase-3 precedent.
- **Containment, sequence and dependency must be visually distinct** — not distinguished by arrow weight or spacing. In the closest published study, 9 of 55 diagrams mixed hierarchical and sequential notation incompatibly and 12 had ambiguous ordering; a canvas whose single arrow type means either thing will reproduce that confusion and then score the learner for it.
- **Progress statistics appear only once there is progress** (Evidence Lab §9, learned from real use).
- Progress surface: six criterion lines, coverage rate, breadth-first index trend, granularity discrimination, revision delta, baseline/post/delayed with version markers and an explicit no-baseline state.

## 11. Risks

| Risk | Mitigation |
|---|---|
| **Metacognitive offloading — the headline risk for this skill specifically.** Learners offload goal-setting and strategic planning to AI, and the measured consequence is reduced self-regulation and weaker critical thinking (BJET 2024, *n* = 117; *Societies* 2025; a Metacognitive Laziness Scale validated 2026). Decomposition is *the* offloadable skill: a model produces a plausible breakdown instantly | No suggestion affordance anywhere in the canvas; the learner's structure is locked before any alternative is shown; where a model breakdown is displayed it is a **comparison object after commitment**, never a starting point |
| **A wrong key fails silently** — the same trap that blocked Evidence Lab's baseline for two weeks | Key verification is a content-pack validation gate from item one (`keyVerifiedAt`), not a pre-launch task; required-element sets are reviewed by a second person before a form can serve a probe |
| **Over-decomposition read as skill** | ~⅓ control items; headline metric is granularity **discrimination**, never coverage alone |
| **Einstellung** — a familiar breakdown misapplied to an ill-suited problem, a documented novice failure | Every form carries ≥1 near-miss item where the familiar template is wrong and the key says so |
| **No validated rubric exists in the literature** (§1) | Treat rubric v1 as provisional: freeze it before `fa` authoring, run the same double-scored reconciliation pass Clarity needs, and publish the agreement figures rather than assuming them |
| **Scope creep into #5** | The delegation mark is recorded and never scored (§3) |
| **The app models two of the three relations `d5` teaches** | Say so in-module; do not teach a distinction the tool then flattens |
| **Real-work export pollutes real data** | Explicit item-by-item review screen; never automatic; reversible |

## 12. Acceptance criteria

- Baseline → six modules → post → 7-day delayed probe completes, every attempt version-stamped, every draft→revision pair linked, breadth-first index computed from ordered `SkillCheckEvent` rows.
- **A full probe completes with no LLM configured and no outbound network access** — asserted by test, as for Evidence Lab.
- No item key, required-element set, atomic marker, overlap pair or fault label appears in any client payload before submission (asserted by test).
- Every form ≥⅓ control items; ≥6 pool items per module with ≥3 offline-capable and ≥2 control; every probe item's key verified. Validator failures, not documentation.
- Granularity discrimination and rubric total are both displayed; neither alone.
- Containment / sequence / dependency render as three distinct notations — asserted by test, not left to styling.
- `en` + `fa` at content and string parity; RTL pass on canvas and recomposition panes.
- Detector and instrumentation unit tests: D1 ordering, D2 breadth-first index, D4 done-condition detection, D5 graph comparison, against fixtures with known answers. Thin I/O glue untested by design.

**Outcome targets, stated so the tool can fail honestly.** Coverage rate up ≥25 percentage points baseline→post; breadth-first index rising with no fall in coverage; granularity discrimination positive at post and rising; ≥70% of the coverage gain retained at the 7-day delayed probe; **no rise in over-decomposition on control items.** And one target the literature cannot supply a baseline for, which is the contribution: whether a decomposition rubric can reach acceptable inter-rater agreement at all. Publish the figure either way.

---

## Changelog

- **0.3 · 2026-08-11** — Build plan written (`03b-...md`). Three decisions settled after review: **enforced level structure** (not a free canvas — D2 needs "level" to be a real thing); the live D4 badge **reports absence only**, never a green affirmation, which is the detector-is-a-ceiling rule applied to a live indicator; and a **per-node `doneWhen` field**, which turns D4 from prose inference into field validation and is the plan's one addition to this spec. The plan also records that a third tool is where the shared review scheduler gets fixed, and that the probe machinery must be built skill-agnostic because the other two tools inherit it.
- **0.2 · 2026-08-11** — Wireframes drawn, draft 1 (`03a-...html`): ten plates plus an RTL pass. Three things the drawing settled rather than illustrated — the *absence* list on the canvas is a plate in its own right (§10, plate 5), the `d5` honesty note about Tracker modelling two of three relations needs to appear on the **export** screen and not only in-module (§11), and the control item needs its own plate because "leave it whole" has to be a visibly first-class response rather than a missing action.
- **0.1 · 2026-08-11** — Initial spec. Research pass established: the perishable costume is decomposing *for the model* (least-to-most / decomposed prompting, real gains, decaying); the durable skill is decomposing to make pieces checkable. Pedagogy from subgoal-labelled worked examples (near + far transfer) and the strategy-instruction/prewriting effect-size gap. The breadth-first/depth-first expert–novice signature is instrumentable from authoring order, which makes the tool measurement-capable with no LLM. Rubric v1 drafted as the "keyed-structure decomposition rubric". Recorded that this tool needs both existing session shapes at once, which answers `learn.md` §9 in favour of a composable step library.

## References

- Zhou et al. (2022). *Least-to-Most Prompting Enables Complex Reasoning in LLMs* (arXiv 2205.10625); Khot et al. (2022). *Decomposed Prompting* (arXiv 2210.02406) — the technique, and the measured model-side gains.
- Catrambone & Holyoak; Margulieux, Guzdial & Catrambone; Morrison, Margulieux & Guzdial (2015, ICER); *Frontiers in Education* (2022) — subgoal labelling, worked examples, near and far transfer.
- Graham, S. & Perin, D. (2007). Writing-instruction meta-analysis — strategy instruction *d* ≈ 0.82; product goals ≈ 0.70; prewriting ≈ 0.32; study of models ≈ 0.25.
- Jonassen, D. (1997). Well-structured vs. ill-structured problem solving — why multi-solution problems are assessed by solution rubrics and constructed arguments rather than keys alone.
- *Assessing Problem Decomposition in CS1 for the GenAI Era* (arXiv 2511.05764, *n* = 181) — question suites and decomposition diagrams; the breadth-vs-depth and Einstellung failure modes; no rubric or reliability data.
- *Planning on Paper: Problem Decomposition with Diagrams in Introductory Computing* (arXiv 2606.12427, *n* = 55) — 16 issue codes; 51/55 diagrams missing required functionality; notation clashes between hierarchy and sequence.
- *The CTSkills App* (arXiv 2411.14945, *n* = 75, grades 4–9) — decomposition as the under-assessed CT component.
- *Beware of Metacognitive Laziness* (BJET, *n* = 117); Gerlich (2025), *Societies* 15(1); Dizon et al. (2026), Metacognitive Laziness Scale — the offloading risk, and why the canvas offers no suggestions.
- MECE (mutually exclusive, collectively exhaustive) — **practitioner folklore, no research warrant.** Borrowed as vocabulary for D3 only; not cited as evidence.
