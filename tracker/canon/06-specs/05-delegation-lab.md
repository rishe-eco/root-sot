# Tracker — Delegation Lab (skill tool #5)

*Spec, not as-built. The tool that trains calibrated delegation — knowing when the AI's judgement should lead and when yours should — by eliciting your answer first, showing you advice, and measuring how much you move. Runs on `00-skills-engine.md`. Wireframes: `05a-delegation-lab-wireframes.html`. Phase order, arithmetic and gates: `05b-delegation-lab-build-plan.md`. Update the changelog; don't fork.*

**Version 0.3 · Status: spec · 2026-08-11 · Owner: _root**

---

## 1. The skill, and the honest problem with building a tool for it

Calibrated delegation is skill #5 (`../../../ecosystem/canon/04-research/02-durable-ai-skills.md` §3): metacognitive tier, and **the highest-value skill in the stack** — over-trust was the single biggest predictor of a bad outcome across the studies the parent brief surveys. It is also the one skill where the tool might not work, and this section says so before anything else.

The construct has a settled name and a settled definition in the human–AI decision-making literature: **appropriate reliance**, *"humans' ability to discriminate correct and incorrect AI advice and to act upon that discrimination."* It fails in two symmetric directions — **over-reliance** (accepting incorrect advice) and **under-reliance** (rejecting correct advice) — and the motivating finding is that **complementary team performance, where the human–AI team beats both the human alone and the AI alone, is rarely observed.** Two capable parties, worse than the better of them.

**The problem: published interventions mostly do not work.** This is not a gap in the literature, it is a finding in it.

- A CHI 2025 evaluation of three interventions for appropriate reliance on LLMs found that all three **reduced over-reliance in at least some configurations and generally failed to improve appropriate reliance.**
- Reviews conclude that such approaches are *rarely panaceas* — **some reduce over-reliance at the price of increasing under-reliance**, and others work only for people with particular characteristics.
- AI explanations, the most-studied intervention, are inconclusive.
- The one reliable effect is narrower and worth all the more for it: a tutorial with performance feedback was **highly effective at calibrating self-assessment**, and had only a small, non-significant effect on reliance itself.

**So the design position, stated up front.** The component this tool can expect to move is **knowing your own error rate**. Whether that converts into better delegation is *not established*, and every intervention that has tried has mostly traded one failure direction for the other. Two consequences run through the whole spec: the tool reports **over-reliance and under-reliance separately and never as one number**, because a single "reliance" figure would let a trade look like progress; and the outcome targets (§12) include an explicit **pre-registered null** — if self-assessment calibration improves while reliance discrimination does not, that replicates the literature, and it is a result rather than a failed build.

**Grade: strong for the construct and the instrument, thin-to-negative for trainability.** That last is unusual in this canon and it earns the same treatment as the delayed-probe gap: nobody has shown appropriate reliance is trainable, almost nobody has measured it at a delayed timepoint, and a tool that measures it properly generates exactly the evidence that is missing. **This is the tool most likely to produce a genuine research contribution, precisely because it is the one most likely to fail.**

**The perishable costume is the most widely taught artifact in all of AI literacy: the capability list.** "Here is what AI is good at and what it is bad at." Every such list is a snapshot of one model generation, wrong within months, and wrong *asymmetrically* — the entries that decay fastest are the confident "AI can't do X" ones. The durable skill underneath is not a map of the tool: it is **comparing expected error for this instance — its likely error against your own.** That requires knowing your own reliability, reading instance-level cues, and holding both loosely. The costume is a category claim; the skill is an instance judgement.

Two lesser costumes, both already dispatched elsewhere: deciding by the model's **stated confidence** (`04-verification-lab.md` §1 — poorly calibrated, worst when wrong), and treating **"keep a human in the loop"** as a checkbox rather than a question about which human, doing what, with what information.

## 2. The instrument, which is older than the problem

The measurement is a **judge–advisor system (JAS)**, the standard advice-taking paradigm: the learner gives an estimate, is shown advice, and gives a revised estimate. The derived measure is the **weight of advice**:

```
WOA = (final − initial) / (advice − initial)          bounded to [0, 1]
```

0 means they ignored the advice entirely; 1 means they adopted it wholesale. This matters because it comes with **published baselines**: typical WOA runs **0.2–0.3**, and a meta-analysis puts the mean at **0.39, 95% CI [0.37, 0.42]** — people systematically underweight advice, an effect called **egocentric discounting**. The normative benchmark is not 1 and not 0: when two judges are of unknown but comparable accuracy, **averaging beats both**, so **WOA ≈ 0.5 is the default that a rational judge with no information about relative competence should land on.**

That gives the tool something none of the other three has: a continuous, well-validated dependent variable with known population values, computable entirely offline from authored advice.

**And it makes the actual skill precise.** You cannot know, item by item, whether the advice is better than your answer. What you can have is a **cue** — this is a domain I know cold; this is a task type where I am guessing; this is arithmetic I can check in one line; this is about my own team's history and the model has never seen it. So:

> **Move to 0.5 when you have no cue. Deviate from 0.5 only as far as a cue justifies.** Confident deviation with no cue is the failure that most resembles skill.

Items are therefore authored with a `cueDirection` of `trust`, `keep`, or `none`, and the headline metric (§6) is how far the learner's weighting tracks it.

## 3. Modules

Six, 1:1 with the rubric criteria (§4). Each is anchored to a specific finding, because for this skill an unanchored module is a guess.

| Key | Module | Trains | Anchored in | Criterion |
|---|---|---|---|---|
| `g1-own` | **Know your own error rate** | Estimating, committing a confidence, then meeting your actual accuracy. The prerequisite for everything else | *Illusion of competence* hinders appropriate reliance (CHI 2023); calibrating self-assessment is the one reliably trainable component | G1 |
| `g2-instance` | **The instance, not the category** | Reading a cue about *this* task instead of applying a capability map. Where there is no cue, saying so | The capability-list costume (§1) | G2 |
| `g3-weigh` | **Move the right amount** | Weighting advice proportionally. Both under- and over-adjustment are errors, and underweighting is the population default | Egocentric discounting; averaging as the no-information benchmark | G3 |
| `g4-split` | **Delegate the part, not the whole** | Handing over the sub-task rather than the task; keeping the piece you can judge | People will use imperfect algorithms **if they can even slightly modify them** (Dietvorst et al.) — partial delegation restores use where all-or-nothing kills it | G4 |
| `g5-stakes` | **What does being wrong cost?** | Reliance as a function of error *cost*, not only error *probability*. Identical task, different stakes, different correct answer | Advice-taking under high stakes | G5 |
| `g6-drift` | **Update without overreacting** | After the advisor errs once, does your reliance collapse? Both directions: abandoning after one visible error, and adopting after one success | **Algorithm aversion** — people abandon algorithms faster than humans after the same error, even having seen the algorithm outperform the human (Dietvorst, Simmons & Massey 2015) — against **algorithm appreciation** in other contexts (Logg et al.) | G6 |

- **`g1-own` is deliberately the thin version of skill #6.** Knowing your own reliability is self-monitoring, which is a whole tool of its own; here it is scoped to *one number per item* — your confidence, checked against your accuracy. The full treatment stays unbuilt and unclaimed.
- **`g4-split` cannot be taught to someone who cannot decompose.** Delegating a part presupposes parts. Cross-link `03-decomposition-lab.md`; a learner who has not done `d3-seams` will find this module measuring the wrong thing.
- **`g6-drift` is the only multi-item unit in the engine.** A single item cannot show a trajectory, so this module's unit is a **sequence of 3 rounds** (settled 2026-08-11): round 1 establishes the learner's weighting, the advisor is **visibly wrong on round 2**, and round 3 measures what their weighting does next. It is one attempt with three rounds inside it, not three attempts (§9).

  **Three rounds measures the documented effect and defers the undocumented one.** Algorithm aversion *is* the drop — people abandon an algorithm faster than a person after the same error — and one post-error observation measures a drop. What three rounds cannot see is **recovery**: whether a learner who overshoots climbs back over the rounds that would follow. That is a plausible and interesting pattern, and it is not in the literature; buying it would double every `g6` sitting to measure a hypothesis nobody has tested. Logged as a deferred research question (**D-24**), to be answered with data from the three-round version rather than by guessing now.

**The seam with #4, and it is the most useful cross-link in the engine.** Verification does not just follow delegation — **it changes what the correct delegation is.** Where a cheap discriminating check exists, over-reliance is recoverable and delegating is nearly free; where nothing can check the output, the same delegation is a bet. So a learner's verification skill *lowers the cost of delegating*, and `g5-stakes` says so explicitly. The seam with #6 is stated above. The seam with #2 is narrower: evidence-seeking is one way to generate a cue, not a substitute for the weighting decision.

## 4. The instrument: reliance rubric v1

Six criteria, **0 = absent · 1 = partial · 2 = present**, total **0–12** — the engine's shape. Unusually for this engine, most levels are **thresholds on a continuous measure** rather than observable features, because the underlying quantity genuinely is continuous. The thresholds are stated as constants so they can be tuned without re-reading the prose.

| # | Criterion | 0 | 1 | 2 |
|---|---|---|---|---|
| **G1** | **Self-knowledge** | Stated confidence is anti-correlated with own accuracy across the window | Weakly related | Confidence tracks own accuracy — item-level Brier below the module threshold |
| **G2** | **Cue quality** | The cue cited is a category claim about AI in general, or no cue where one exists | An instance-level cue that does not bear on relative competence | An instance-level cue that bears on *relative* competence — or, on an uncued item, correctly reporting that there is none |
| **G3** | **Proportionate weight** | \|WOA − benchmark\| > 0.4 | 0.2–0.4 | ≤ 0.2, where benchmark is 0.5 on uncued items and the cue-adjusted value otherwise |
| **G4** | **Partial delegation** | Delegates or keeps the whole task where the key marks it separable | Splits, but hands over the piece they could have judged and keeps the one they could not | Hands over the piece the key marks delegable and keeps the piece whose correctness only they can assess |
| **G5** | **Stakes read** | The two framings treated identically — no change across the pair | Changed, but in a direction the key marks indefensible (relying *more* under high stakes with nothing to make it recoverable), or below the pair's magnitude threshold | **Either defensible response**: reliance reduced by at least the pair's threshold, **or** reliance maintained with a recoverability move recorded |
| **G6** | **Stable updating** | Round-3 weighting collapses to ~0 after the single advisor error, or rises to ~1 after a single success | Overshoots — adjusts further than one data point against several warrants | Round-3 weighting adjusts in the right direction by no more than the evidence warrants, and remains non-zero |

**G5 has two correct answers, and that is the point** (settled 2026-08-11). The naive model of stakes — *higher stakes, trust it less* — is a category rule of exactly the kind `g2-instance` exists to dismantle. The correct model is decision-theoretic: the expected cost of delegating is `P(error) × cost(error)`, and **a cheap check collapses the second term**. So where the output can be checked, high stakes do not argue for relying less; they argue for making being wrong *recoverable*. Reliance and recoverability are two levers on the same quantity, and a learner who keeps their weighting and insures it has read the stakes correctly.

This is why the criterion accepts either lever, and why **the recoverability move is recorded but its quality is never scored here.** Whether the check the learner would run is any good is Verification Lab's measurement (`04-verification-lab.md` §4); importing it would make G5 partly a verification score, so a learner weak at #4 would lose points on a delegation criterion. The line is: *this tool asks whether you reached for a lever; the other tool asks whether the lever works.* The reveal teaches the full picture — naming both paths and showing which the learner took — because teaching and scoring are separable, exactly as they are for self-report (§6) and the delegate/keep mark (§3).

**Void flag** (separate, never averaged as zero): no initial estimate given, or an estimate outside the item's plausible range, which indicates the learner did not engage with the task rather than that they judged it badly.

**Scoring split — entirely keyed and computed, and again with no model in the loop:**

| Criterion | Source |
|---|---|
| G1 | Computed — stated confidence against own initial accuracy |
| G2 | Key — the cue is **selected from an enumerated list** containing category-level distractors and instance-level cues, so it is comparable and offline (the pattern established in `04-verification-lab.md` §4a) |
| G3 | Computed — WOA against the item's benchmark |
| G4 | Key — which piece was delegated |
| G5 | Computed across the authored item pair |
| G6 | Computed across the rounds of the sequence — round-3 weighting against round-1 |

**Item balance departs from the other tools, and the reason is the literature.** Evidence, Decomposition and Verification all use **~⅓ control items**, because in each the trained behaviour is unidirectional and controls exist to punish false alarms. Here the failure is **symmetric**, and the published warning is exact — interventions "reduce over-reliance at the price of increasing under-reliance". A pack weighted toward bad advice teaches distrust; one weighted toward good advice teaches deference; either would produce a tool that moves the headline number by installing a disposition. So: **advice quality is balanced at ~50/50**, and cue direction is balanced across `trust` / `keep` / `none` within every module pool and every probe form.

**Persian is the cheapest of the five tools.** The instrument is numeric — estimates, advice, truth — and the entire measurement is locale-invariant. Only scenario prose and cue labels are realised twice, and the digits are Western in both locales (`04-verification-lab.md` §10). There is no Persian-specific linguistic work at all.

## 5. Item types

1. **Estimation item (JAS)** — a quantity with a knowable truth, the learner's estimate, a confidence, an authored advice value, then a revised estimate. Six per sitting, ~1 minute each. **The baseline / post / delayed instrument**, because it is continuous, keyed, and has published baselines to compare against.
2. **Cue-selection item** — the same, plus: *which cue did you use?* from an enumerated list mixing category claims ("models are generally weak at arithmetic") with instance cues ("this is a single multiplication I can check in one line") and, on uncued items, the correct "nothing here tells me who is more likely to be right".
3. **Split item** — a task with an authored separable structure; the learner marks which piece to hand over and which to keep.
4. **Stakes pair** — two items identical but for the cost of being wrong; scored on the *difference* between them, never individually.
5. **Advisor sequence** (`g6` only) — three rounds, the advisor visibly wrong on round 2. Scored on the round-3 weighting against the learner's own round-1 weighting.
6. **Real-work delegation** (open practice) — the learner logs a real decision before making it: what they are about to hand over, what they expect to keep, what would tell them they were wrong. The tool prompts them to return and record the outcome, producing a **delegation record**. Never scored into mastery or probes.

**The truth values must be genuinely knowable and genuinely uncertain**, which is the hardest authoring constraint in this pack: quantities where a thoughtful person can produce an estimate, where the answer is checkable, and where the learner's competence varies across the set. Historical dates, populations, distances, durations, counts, prices, physical quantities. **General-audience, per D-17.** If every item lands in a domain the learner knows nothing about, "keep it yourself" is never correct and the instrument silently collapses into a measure of deference.

## 6. Metrics

- **Reliance discrimination = mean WOA on `trust`-cued items − mean WOA on `keep`-cued items.** The headline. A large positive value means the learner's weighting tracks whether the advice deserved it. **Zero means they have a disposition rather than a skill** — and that is true whether the disposition is trusting or distrusting, which is exactly what a single reliance figure would hide.
- **Over-reliance rate** (moved substantially toward advice that was worse than their own estimate) and **under-reliance rate** (barely moved toward advice that was much better), **always reported side by side and never summed.** The literature's clearest warning is that interventions trade these against each other; a tool that reports their sum would show that trade as improvement.
- **Net gain from advice** = mean(|initial − truth| − |final − truth|). Interpretable in the units of the task: did consulting actually help? It can be negative, and for many learners it will start there.
- **Anchoring on uncued items** = mean |WOA − 0.5| where `cueDirection` is `none`. Should be **small**. This is the measure of confident deviation without grounds.
- **Self-assessment calibration** — Brier over per-item confidence against own initial accuracy. **The component the literature says is trainable**, and therefore the one to watch for the "calibration improved, reliance didn't" outcome (§12).
- **Egocentric baseline comparison** — the learner's overall mean WOA against the published 0.39 [0.37, 0.42]. Not a score; context that tells a learner whether they are unusual, and in which direction. **Withheld until the baseline probe completes** (settled 2026-08-11), and after that shown permanently, **on the progress surface only — never during an item and never at an item reveal.** Two reasons, and the first is disqualifying on its own: the baseline is the one measurement that has to be uncontaminated by it, and a population figure handed to someone before they have a habit is a number to move toward — an anchor, on a tool about not anchoring. Shown at a reveal it would anchor the next item just as effectively. If the baseline was skipped, disclose after **12 scored items** instead, so the learner's own number exists before the comparison does.
- **Post-error drop** (`g6`) — round-3 WOA as a fraction of round-1 WOA. Below ~0.2 is a collapse; near 1.0 is a learner who did not update at all, which is the opposite failure and is scored as such.

## 7. Mastery criterion

**Mastered** = across two distinct calendar days, on unscaffolded items for that module: **reliance discrimination ≥ 0.25**, **anchoring on uncued items ≤ 0.15**, **net gain from advice positive**, and **neither over- nor under-reliance rate above the module threshold**. Four clauses, and the fourth is the one that does the work: a learner can reach a good discrimination score while still being systematically over-trusting, because discrimination is a *difference* and says nothing about the level.

**Tested out** = the baseline already showed discrimination ≥ 0.25 with both error rates below threshold.

**Pool floor**: ≥ 6 pool items per module; advice quality balanced 50/50 ± 1 item; all three `cueDirection` values present; `g5` pools counted in **pairs**, not items; `g6` pools counted in **sequences**.

## 8. Practice modes

- **Calibrated practice** — interleaved across modules and cue directions.
- **Real-work delegation** — the retention feature. Logged *before* the decision, revisited after, which makes it the only mode in the engine that spans two sittings by design. The delegation record is a working artifact: what I handed over, what I kept, what would have told me I was wrong, what actually happened.

## 9. Engine deltas

**The smallest of the five.** Assuming `03` and `04` have landed:

- `SkillKey` += `delegation`. **No other migration.**
- Estimates, advice, revisions, cue selections and sequence rounds all live in `SkillAttempt.responseStructure` as JSON (added by `03`), parsed in `typeResolvers.ts` per convention #2.
- **A `g6` sequence is one attempt containing three rounds**, not three attempts. The rounds are an array in `responseStructure` and each round's commitment is a `SkillCheckEvent` — `estimate_committed`, `advice_shown`, `revision_committed`, with the round index in the payload. Modelling it as linked attempts would make every per-attempt metric in the engine wrong for this module. **The round count is a content constant, not a hard-coded literal** (`G6_ROUNDS`), because D-24 defers the question of whether it should be five.
- New check-event kinds: `estimate_committed`, `confidence_committed`, `advice_shown`, `revision_committed`, `cue_selected`, `split_committed`.
- **The ordering rule that makes the whole instrument valid: the initial estimate is server-stamped and immutable before the advice is served.** WOA is meaningless if the initial estimate can be revised after seeing the advice, and it is the one number the entire tool rests on. Advice is a separate server round-trip, exactly like Verification Lab's per-check outcomes.
- Own GraphQL types per the Clarity precedent; probe machinery inherited if `03` Phase 5 or `04` Phase 5 has shipped.
- No rung mechanic. The two-rung progression in `04-verification-lab.md` §4a is specific to a tool with a cost bench; there is no analogous scaffold here.

## 10. Interface requirements

**Wireframes: `05a-delegation-lab-wireframes.html`, draft 1, drawn 2026-08-11.** Ten plates plus an RTL pass; one new component (the three-position reveal), the rest rearranging what the four existing labs already have.

- **Estimate first, and it locks.** The advice does not exist on the client until `estimate_committed` is stamped. Not hidden, not disabled — **absent from the payload**, for the same reason Verification Lab serves one bench outcome at a time.
- **Confidence is committed with the estimate**, not after seeing the advice, or it measures hindsight.
- **The revision is a slider or a number, and the initial value remains visible** — the learner should see how far they moved, because the movement *is* the measurement and hiding it would teach nothing.
- **Never show WOA as a live number during the item.** It is the score; displaying it during the decision turns the item into an exercise in hitting a target.
- **The reveal shows all three positions at once** — your estimate, the advice, the truth — with your movement drawn between them. This is the tool's gap reveal, and the analogue of Clarity Lab's three panes.
- **Both error directions appear on the reveal**, named as such: *you moved a long way toward advice that was worse than your own answer* and *you barely moved toward advice that was much better* are different lessons and must not be collapsed into "your weighting was off".
- **The capability list appears once, in `g2`, as the thing being refuted** — an authored list of confident claims about what AI can and cannot do, dated eighteen months earlier, with several now plainly wrong. Naming the costume is more effective than warning against it.
- Progress: six criterion lines, reliance discrimination, over- and under-reliance side by side, net gain, anchoring, self-assessment calibration, the published-baseline comparison, review queue, baseline/post/delayed with version markers.
- i18n: `en` + `fa`, Western digits in both. RTL pass on the three-position reveal.

## 11. Risks

| Risk | Mitigation |
|---|---|
| **The tool installs a disposition and calls it a skill** — the failure the literature documents, where an intervention reduces one error direction by increasing the other | Discrimination is the headline; both error rates reported side by side, never summed; advice quality balanced 50/50 |
| **It simply does not work** — the most likely outcome for this tool, on the current evidence | Pre-registered null in §12; the delayed probe reports it either way; calibration and reliance reported separately so a partial result is legible |
| **Items land outside the learner's competence range**, making "keep it" never correct and turning the instrument into a deference meter | Truth values general-audience and estimable; competence is measured per item by the learner's own initial error, so the instrument is self-normalising |
| **Learners game WOA** once they infer that movement is scored | WOA never shown live; benchmark varies by cue direction; uncued items reward *not* moving, so a "always move halfway" policy scores badly on cued items |
| **Authored advice that is implausible** — advice too far from truth is ignored for the wrong reason (it looks broken, not wrong) | Advice distance bounded by the key; the validator rejects advice outside the item's plausible range |
| **`g5` scored per item instead of per pair** | Pairs are a single unit in the data model and the validator rejects an orphan |
| **Sequence modelled as separate attempts** | One attempt, three rounds behind `G6_ROUNDS` (§9); asserted by test |
| **Scope creep into #6** | `g1` is one number per item; anything richer belongs to self-monitoring and stays unbuilt |

## 12. Acceptance criteria

- Baseline → six modules → post → 7-day delayed probe completes, every attempt version-stamped, **the initial estimate immutable and stamped before advice is served** (asserted by test).
- **A full probe completes with no LLM configured and no outbound network access.** Every metric here is arithmetic on authored values.
- No advice value, truth value, cue key, or split key appears in any client payload before its commit gate (asserted by test).
- Advice quality balanced 50/50 ± 1 per form and per module pool; all three cue directions present; validator errors, not documentation.
- A `g5` pair scores as a difference and cannot be scored individually, and **either defensible response reaches level 2** (§4); a `g6` sequence persists as one attempt with `G6_ROUNDS` rounds.
- The population WOA baseline is **absent from every payload** until the baseline probe completes, or 12 scored items if it was skipped — asserted by test, because an anchor delivered early cannot be withdrawn.
- Discrimination, over-reliance and under-reliance are all displayed; **no view shows a single combined "reliance" figure anywhere**.
- WOA is never present in a client payload before the reveal.
- `en` + `fa` at parity; Western digits in both; RTL pass on the three-position reveal.

**Outcome targets, and the pre-registered null.** Reliance discrimination up ≥ 0.20 baseline→post; anchoring on uncued items down; net gain from advice positive at post; over- and under-reliance **both** below baseline, with neither traded for the other; ≥70% of the discrimination gain retained at the delayed probe.

> **The null, registered in advance:** self-assessment calibration improves while reliance discrimination does not move. That is the outcome the published literature predicts. If it happens, it is reported as the finding it is — and it would be, as far as this canon can establish, the first delayed-timepoint evidence on the question. **The tool is built to be able to say it didn't work.**

---

## Changelog

- **0.3 · 2026-08-11** — Three decisions settled after the wireframe review. **G5 accepts either lever** — reducing reliance *or* keeping it and making it recoverable — because the expected cost of delegating is `P(error) × cost(error)` and a cheap check collapses the second term; the recoverability move is recorded and its quality is never scored here, which keeps the #4 concept without importing #4's measurement. **The population WOA baseline is withheld until the baseline probe completes** (or 12 scored items if skipped) and then shown on the progress surface only — an anchor delivered early cannot be withdrawn. **The `g6` sequence is three rounds behind a `G6_ROUNDS` constant** (**D-24**), measuring the documented drop and deferring the undocumented recovery pattern to a question the three-round data can answer.
- **0.2 · 2026-08-11** — Wireframes drawn, draft 1 (`05a-...html`): ten plates plus an RTL pass. Three things the drawing settled rather than illustrated. **The pre-registered null belongs on the learner's own progress screen**, not only in this document — calibration and discrimination render as two separate lines with no causal arrow, so a learner sees the part that moved and the part that didn't. **The number line does not mirror in RTL** — smaller values stay left in both locales, because a quantity axis is not text and flipping it would make "moved toward the advice" mean the opposite thing on the same screen for two learners; same category of decision as Western digits. And **high stakes must not be drawn as "trust less"** — plate 5 rewards making the reliance recoverable rather than retreating to your own guess, which is the #4 cross-link made visible and is flagged as open because it makes G5 partly a verification measure.
- **0.1 · 2026-08-11** — Initial spec. Research established that the construct (*appropriate reliance*) and the instrument (**judge–advisor system**, weight of advice, meta-analytic baseline WOA 0.39) are both mature and fully offline, while **trainability is not established and published interventions largely fail** — which is written into §1 as a design position and into §12 as a pre-registered null rather than buried. The perishable costume is **the capability list**, the most widely taught artifact in AI literacy and the fastest-decaying. Item balance departs from the other tools at 50/50 rather than ⅓, because the failure here is symmetric and the literature's specific warning is that interventions trade over-reliance for under-reliance. Modules anchored one-to-one to findings: illusion of competence, instance-over-category, egocentric discounting, partial delegation restoring use, stakes, and algorithm aversion.

## References

- **Judge–advisor system and weight of advice** — the advice-taking paradigm; egocentric discounting; typical WOA 0.2–0.3 with a meta-analytic mean of **0.39, 95% CI [0.37, 0.42]**; averaging as the normative benchmark when relative accuracy is unknown.
- **Appropriate reliance** — *"the ability to discriminate correct and incorrect AI advice and to act upon that discrimination"*; over- vs. under-reliance; the rarity of complementary team performance. See *From Trust to Appropriate Reliance: Measurement Constructs in Human-AI Decision-Making* (arXiv 2604.23896) and *A Decision Theoretic Framework for Measuring AI Reliance* (arXiv 2401.15356).
- *To Rely or Not to Rely? Evaluating Interventions for Appropriate Reliance on Large Language Models* (CHI 2025) — three interventions; over-reliance reduced in some configurations; appropriate reliance generally **not** improved.
- *Knowing About Knowing: An Illusion of Human Competence Can Hinder Appropriate Reliance on AI Systems* (CHI 2023, arXiv 2301.11333) — the `g1-own` anchor.
- *The Impact and Feasibility of Self-Confidence Shaping for AI-Assisted Decision-Making* (arXiv 2502.14311) — self-assessment as the tractable lever.
- Dietvorst, Simmons & Massey (2015). *Algorithm Aversion: People Erroneously Avoid Algorithms After Seeing Them Err* — and the follow-up finding that people will use imperfect algorithms **if they can even slightly modify them**, which anchors `g4-split`.
- Logg et al. *Algorithm Appreciation: People Prefer Algorithmic to Human Judgment* — the opposing effect, and the reason neither aversion nor appreciation is a safe default.
- Advice-taking under high stakes — the `g5` anchor.
