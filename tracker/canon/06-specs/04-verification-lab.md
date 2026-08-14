# Tracker — Verification Lab (skill tool #4)

*Spec, not as-built. The tool that trains verification — establishing whether an answer is actually right — by making the learner name an oracle, design a check that could fail, and run it. Runs on `00-skills-engine.md`. Wireframes: `04a-verification-lab-wireframes.html`. Phase order, algorithms and gates: `04b-verification-lab-build-plan.md`. Update the changelog; don't fork.*

**Version 0.4 · Status: spec · 2026-08-11 · Owner: _root**

---

## 1. The skill, and the boundary with Evidence Lab

Verification is skill #4 (`../../../ecosystem/canon/04-research/02-durable-ai-skills.md` §3): intermediate tier, and the one most easily mistaken for skill #2. The distinction is not a matter of degree, and getting it wrong would produce a second Evidence Lab wearing a different name:

> **Evidence-seeking decides *whether* a claim is worth checking and goes sideways to a source. Verification decides *how* you would know, constructs a test that could fail, and runs it.**

Evidence Lab deliberately refuses the deep check — a full audit is slow and keeps the learner inside the source's own framing, so it trains a fast triage reflex and stops (`02-evidence-lab.md` §1). Verification is precisely the skill that refusal leaves on the table. Evidence Lab's `e3-sideways` ends where this tool begins.

**The transferable content has a name, and it comes from software testing rather than from AI.** The **test oracle problem** is the difficulty of determining whether an output is correct at all: an oracle may not exist, or may exist and be too expensive to apply. That literature also supplies the two cheap workarounds that make this a teachable skill rather than an exhortation to be careful:

- A **partial oracle** checks a property the answer must satisfy without knowing the answer — `sin 38°` cannot exceed 1. Cheap, limited, and it catches a startling share of real errors.
- A **metamorphic relation** checks how the answer must *change* when the input changes — filter a search more narrowly and the results must be a subset of the previous results. You never need to know the correct output.

Both generalise far outside code, which is what makes them durable: order of magnitude, units and sign are partial oracles for a number; back-translation is a metamorphic check on a translation; "does the journal exist, in that year, with an author who works in that field" is a partial oracle on a citation; "do the parts sum to the stated total" is a partial oracle on a plan. Oracle-thinking predates LLMs by four decades and survives every model change.

**Two perishable costumes, and both are widely taught as verification.**

1. **"Ask the model to check its own work."** Intrinsic self-correction — self-critique with no external feedback — **fails, and sometimes makes performance worse** (Huang et al., ICLR 2024). The follow-up work that does help succeeds by adding external structure, such as masking a key condition and predicting it back, not by introspection. The durable kernel: **a checker that shares the generator's blind spots is not a check.** Independence is the whole of it — structurally the same insight as Evidence Lab's independence criterion (§6 there), transposed from sourcing to correctness.
2. **"Ask it how confident it is."** Verbalised confidence is poorly calibrated, models are overconfident **especially when they are wrong**, and RLHF plausibly amplifies it because users prefer confident-sounding answers. So stated confidence is not merely uninformative, it is worst exactly where it matters. This is the anti-cue for this tool, and the direct parallel to Evidence Lab's *fluency is not evidence*: **stated confidence is not evidence.**

**Grade: strong for the mechanisms, moderate for the instrument, thin for the AI-specific synthesis** — the same honest posture as the parent brief. Confirmation bias in hypothesis testing is one of the most replicated findings in cognitive psychology, and the oracle literature is mature. What is thin is evidence that *training* verification transfers to working with AI, because nobody has run that study.

**The motivating dissociation, in numbers.** A January 2026 industry survey found **96% of developers do not fully trust AI-generated code and only 48% always verify it**, while AI accounts for ~42% of committed code. Treat the figures as practitioner survey data rather than peer-reviewed measurement, but the *shape* is the same one Evidence Lab is built on: what people say about their checking is not what they do. And the peer-reviewed version is worse — participants with an AI assistant wrote **less secure code and were simultaneously more likely to believe it was secure** (Perry et al., CCS 2023). That study also contains the single most useful result for the whole Skills Engine: participants who **trusted the assistant less and engaged more with their own prompts produced fewer vulnerabilities.**

## 2. Pedagogy, and the session economy

**Falsification is drillable, and there is training evidence for the exact move.** Wason's rule-discovery task established that people test hypotheses to confirm rather than to refute; Klayman and Ha named the **positive test strategy** as the default heuristic behind it. Critically, PTS is *not* a fallacy — it is a reasonable default that fails in identifiable circumstances, so this tool must never teach "always try to falsify" as a rule. What it teaches is narrower and correct: **recognise when a check would pass either way, because such a check tells you nothing.** And a *simple* training session in "thinking in opposites" measurably improved both the proportion of people who found the rule and how fast they found it (J. Intelligence 2023; replicated Memory & Cognition 2025). Short, targeted, drillable.

**The scenario finding, which forbids the obvious design.** In the classic inspection experiments, **scenario-based detection outperformed both ad-hoc and checklist reading, and reviewers were most effective at exactly the faults their scenario was designed to uncover** (Porter, Votta & Basili 1995). Checklist versus ad-hoc showed no significant difference there; a later student study found checklists mainly reduced false positives. So:

> **Do not build a generic verification checklist.** Build targeted oracles matched to fault classes, and teach the learner to select the oracle the suspected fault would reveal.

This is the same architecture as Evidence Lab's per-profile items, and it is the difference between a tool that trains discrimination and one that trains a ritual.

**Session economy — a third distinct shape, and it is the reason the step-library conclusion holds.** Skill #3 needed both existing shapes at once (`learn.md` §9). This one needs something neither has: **the check has to be executed, and executing it costs time.** So the unit of work is not an artifact the learner writes (Clarity) or a claim they judge (Evidence) — it is a *decision to spend effort*, followed by a result.

| | Verification Lab |
|---|---|
| Session shape | mixed: ~2 min falsification drills (`v3`), ~6–10 min oracle-bench items (`v1`, `v2`, `v4`, `v5`, `v6`) |
| Unit of work | an artifact, plus the check the learner chooses and runs against it |
| What's scored | the **oracle chosen**, whether it could have failed, the verdict, and what it cost |
| Failure mode to design against | **ritual verification** — checking diligently with oracles that cannot discriminate |

## 3. Modules

Six, 1:1 with the rubric criteria (§4), ordered least to most complex.

| Key | Module | Trains | Criterion |
|---|---|---|---|
| `v1-oracle` | **What would tell you?** | Naming an oracle *before* looking: the three kinds — partial, metamorphic, full — and the habit of asking what evidence would settle it | V1 |
| `v2-independent` | **Not the same source twice** | Independence. Self-critique, stated confidence, and a second answer from the same model are not oracles. Where independence is unobtainable, say so | V2 |
| `v3-falsify` | **The check that would fail** | Think-in-opposites, and spotting the pass-either-way test. The drilled module | V3 |
| `v4-cheapest` | **Cheapest sufficient check** | Order of magnitude, units, sign, boundary, spot-check. The asymmetry judgement: when is checking cheaper than doing, and when is it not — including when *not* to verify | V4 |
| `v5-locate` | **Where exactly is it wrong?** | Fault localisation. "Something's off" is not a finding; naming the element that fails is | V5 |
| `v6-unverifiable` | **When you can't check** | Recognising no-oracle situations and recording *unverified* honestly rather than manufacturing a confidence level | V6 |

- **`v2-independent` is where both costumes die.** The module presents a model's self-critique and a stated confidence score as candidate oracles, and the learner discovers they are non-independent by construction. One optional aside names the techniques and why they aren't taught as capacity (engine §2).
- **`v6-unverifiable` is the module that prevents the tool from producing a fabulist.** A learner who always finds a check has learned to invent oracles, which is a worse failure than credulity because it is invisible. "Cannot verify with what's available" is a scored-correct answer whenever the key says so — the same design as Evidence Lab's *can't tell in the time available*.
- **`v4-cheapest` is the bridge to skill #3.** A piece with a stated done condition *is* a partial oracle; `d4-size`'s yes/no condition and this module's cheapest-sufficient-check are the same move at different scales (`03-decomposition-lab.md` §3). Cross-link both ways.

**Two seams, stated so they aren't crossed.** *Whether to check at all* is Evidence Lab's `e1-stop` and stays there — this tool's items arrive with the triage already done. *Whether to hand the task over in the first place* is **calibrated delegation** (#5); this tool may record a delegate/keep mark and must **never score it**, the same discipline #3 applies to the same question.

## 4. The instrument: oracle-and-verdict probe v1

Six criteria, **0 = absent · 1 = partial · 2 = present**, total **0–12** — the shape the engine already carries.

| # | Criterion | 0 | 1 | 2 |
|---|---|---|---|---|
| **V1** | **Oracle named** | No oracle named, or the verdict is reached with no stated basis | An oracle named, but it does not bear on the claim actually made | An oracle named **before** the check is run, which bears on the specific claim, and whose kind (partial / metamorphic / full) is identifiable |
| **V2** | **Independence** | The only check used derives from the artifact's own source — the model's self-critique, its stated confidence, or a re-ask of the same model | One independent check, but weighted equally with a non-independent one | Every check used is independent of the artifact's source; where independence is unobtainable the learner says so rather than substituting a dependent check |
| **V3** | **Falsifiability** | The check would have returned the same result whether or not the artifact was correct | The check discriminates only for part of the claim | The check would have **failed** had the artifact been wrong — the item's key lists which candidate checks discriminate |
| **V4** | **Proportionate cost** | Cost exceeds the key's cheapest sufficient oracle by >3×, **or** the learner verifies a control item the key marks as not worth checking | Between 1× and 3× | At or near the cheapest sufficient oracle, with no unnecessary checks run |
| **V5** | **Localisation** | No location of the fault | Right general verdict, wrong element identified | The specific element that fails is named — figure, unit, step, assumption, or citation |
| **V6** | **Honest closure** | An unverifiable artifact is reported as verified, or a verifiable one is abandoned as unverifiable | Correct closure but with no statement of residual risk | Verdict matches the key, including *unverified* where that is the key's answer, **with** what remains unchecked stated |

**Void flag** (separate, never averaged as zero): no verdict submitted, or an artifact left untouched.

**Scoring split — keyed and instrumented, therefore offline:**

| Criterion | Source | How |
|---|---|---|
| V1 | Instrumentation + key | An `oracle_named` event must precede the first `check_selected`; the key marks which bench entries bear on the claim |
| V2 | Key | Each bench entry is tagged independent or source-derived in the item spec |
| V3 | Key | Each bench entry is tagged discriminating or pass-either-way **for that item** |
| V4 | Key + instrumentation | Summed authored cost of the checks run, against the key's `cheapestSufficientCost` |
| V5 | Key | The learner selects the failing element from the artifact's own enumerated elements |
| V6 | Key | Verdict comparison, plus presence of a residual-risk statement (detector: non-empty and not a restatement) |

**No LLM is required for any of it.** Every criterion resolves against an authored key or an instrumented event. As with Evidence Lab and Decomposition Lab, a judge is optional and confined to prose feedback on free-text oracle statements in practice. **The measurement path must never acquire a credential dependency.**

**Persian: mid-cost, and the constraint is inherited rather than new.** Fault classes are overwhelmingly structural — a wrong unit, an inverted condition, a stale assumption, an off-by-one boundary — so specs and keys are locale-invariant and only artifact prose is realised twice. The one genuine constraint comes from Evidence Lab: where a bench entry is an external source, **the artifact may be Persian while the corroborating source is English** (`02-evidence-lab.md` §9), for the same authenticity and availability reasons. No Persian-specific linguistic work is needed, unlike Clarity's R4/R6.

## 4a. Two rungs, and why the probes have only one (added 0.2)

**Settled 2026-08-11 (founder direction).** The budget and the localisation format are not two independent binary choices — they are **one progression**. A learner meeting this skill for the first time gets a hard budget and a list of candidate elements, so that cost is *felt* and the vocabulary of fault elements is *learned*; a learner who has that gets neither, because real verification has no list and no allowance.

| | **Assisted rung** | **Unassisted rung** |
|---|---|---|
| Cost | **Hard ceiling**, live and visible. Spend it and you commit | **No ceiling.** Running total visible; the sufficient cost is revealed *afterwards* |
| Localisation | **Pick from enumerated elements** | **Free text, committed — then** the enumerated list appears and they also pick |
| V4 (proportionate cost) | **Feedback-only** — a number they see, absent from every total | **Scored** |
| Mastery | Unreachable, and the tool says why | Reachable |

**This is not a new concept, which is why it is cheap.** It is the engine's own worked-example fading (§3 step 3: full example → completion problem → independent problem, and *skipping the middle rung is the standard novice-instruction error*) applied one level deeper — to the response format rather than to the task. And the engine already rules that **mastery may only be earned unscaffolded** (§3 step 6), so gating mastery to the unassisted rung requires no new rule and no redefinition. The assisted rung is scaffolding, in the sense the engine already uses the word.

Two things the assisted rung earns beyond being easier. A hard ceiling makes the existence of cost unmissable in a way a passive counter does not. And the enumerated list **teaches the categories** — you cannot localise a fault class you have no name for, so the list is the vocabulary lesson that free text later presupposes.

**Why V4 cannot be scored on the assisted rung.** A ceiling truncates the very thing V4 measures: with a 2× ceiling you *cannot* overspend by 3×, so the criterion can never score 0 and stops being the same criterion. It therefore runs **feedback-only** and is marked as such, using machinery that already exists for exactly this — the total reads `8 / 10` with "5 of 6 criteria scored" beneath it, never a silently weakened `8 / 12` (`01a-clarity-lab-build-plan.md` §3, Phase 3).

**The probes have one rung: unassisted, at every timepoint.** Engine §4.1 requires the same instrument at baseline, post and delayed — *"a different assessment for baseline and post would make the comparison meaningless."* Tiering the probe would break that in the most expensive way available: a learner promoted between baseline and post would appear to get **worse** at V5, because recognition is easier than recall, and one demoted would appear to improve while nothing happened. So the rungs live in **modules and practice only**. A cold beginner meets free text and no ceiling at baseline, which is correct — you scaffold the training and measure the target behaviour, never the reverse.

**The two-step localisation is what makes that affordable.** On the unassisted rung and in every probe: the learner writes the failing element in free text, **commits it (server-stamped, not editable)**, and only then does the enumerated list appear for them to also pick from.

- The **enumerated pick is the scored, comparable, offline component** at every rung and every timepoint. V5 never depends on a credential.
- The **free text is captured and judged only when a credential exists**, contributes to no total, and exists for feedback and for the record.
- Because the list appears only *after* the free-text commit, it cannot hint. On the assisted rung the list is likewise withheld until the verdict step — visible earlier, it would become a shopping guide for *which check to buy*, contaminating V1 and V3, which matter more than V5.
- It yields one metric neither format gives alone: **recall–recognition agreement**, whether the learner's own words matched what they then selected. A divergence is the signature of recognising an answer rather than knowing it.

**The ideal budget is a reveal element, not a live one.** On the unassisted rung, after commit: *"you spent 190s; a sufficient check was available for 10s — here it is."* Live, it would be the answer. This is the exact cost analogue of Evidence Lab's reveal showing what a fast correct check looked like, with the search that would have found it (`02-evidence-lab.md` §9).

**The cost prediction is in** (confirmed 2026-08-11). On the unassisted rung, before spending anything, the learner **predicts what a sufficient check should cost** — one number, committed and not editable. It is Clarity Lab's prediction lock applied to cost, it trains exactly the judgement V4 scores, and it pays off at the reveal: *you predicted 15s; a sufficient check cost 10s.* **Cost-prediction accuracy** is the resulting metric — descriptive, never scored, because a learner who could already predict it accurately would not need the module.

**Promotion is a door, not a gate.** The baseline recommends a starting rung per module. Promotion is *offered* when a learner reaches criterion on the assisted rung, never forced. **Demotion is never automatic** — a learner may step back voluntarily, but a tool that demotes you is a tool that punishes you, and that is the shape this canon refuses everywhere else (`../../decisions/decision-log.md` D-3). The rung is **per module**, not per learner: competence here is uneven by fault class, and `SkillModuleProgress` is already per-module, so this needs one column and no new model.

**No additional authoring cost.** Both rungs are presentations of the *same* item. The enumerated elements and `cheapestSufficientCost` are already required by §4's key. Nothing about the rungs adds a single authored string in either locale — which matters, because bilingual authoring is the binding constraint on every tool in this engine.

## 5. Item types

1. **Artifact + oracle bench** — an authored AI answer or work product, plus 4–7 available checks, each with an authored **outcome**, **cost in seconds**, and key tags (`independent`, `discriminating`, `bearsOnClaim`). The learner names an oracle, selects checks, sees each authored outcome, then commits a verdict, a failing element, and a residual-risk note. Fully keyed, reproducible, offline. **This is the baseline / post / delayed instrument.**
2. **Falsification drill** — a claim plus three candidate checks; pick the one that would fail if the claim were wrong. ~30 seconds, three per sitting. The `v3` drill, and the direct descendant of the think-in-opposites training.
3. **Localisation item** — the artifact is known to be wrong; name the element that fails, scored 0–2.
4. **Correct-artifact control** — nothing is wrong. The correct verdict is *verified*. ~⅓ of every form, drill and probe.
5. **No-oracle control** — nothing on the bench can settle it. The correct verdict is *unverified*, with residual risk stated.
6. **Real-work verification** (open practice only) — the learner brings an actual AI output. The tool walks the oracle ladder, they run checks **outside** the app and paste back what they found, and it produces a **verification record**: claim · oracle used · result · verdict · what remains unchecked. Saveable as a `JournalEntry` or attached as a `Note`. Never scored into mastery or probes.

**Fault profiles**, each paired with the oracle class that reveals it — which is what operationalises the scenario finding (§2):

| Profile | Revealed by |
|---|---|
| `CORRECT` · control | any discriminating check returning pass |
| `NO_ORACLE` · control | nothing available; recognised, not checked |
| `WRONG_UNITS` | partial oracle — dimensional check |
| `MAGNITUDE_ERROR` | partial oracle — order of magnitude |
| `BOUNDARY_OFF_BY_ONE` | metamorphic — vary the input across the boundary |
| `LOGIC_INVERSION` | metamorphic — negate a premise and see if the conclusion flips |
| `STALE_ASSUMPTION` | full oracle — an independent current source |
| `SUBTLE_SUBSTITUTION` | full oracle — right method, wrong input, so recompute |
| `PLAUSIBLE_FABRICATION` | partial oracle — does the referent exist at all |
| `SUM_MISMATCH` | partial oracle — do the parts sum to the stated total |

Every probe form must span at least four distinct oracle classes, or the form measures one habit rather than a skill.

## 6. Metrics

- **Strict composite = V1 × V3 × A** — an oracle that bears on the claim, a check that could have failed, and the right verdict. The headline number, and the direct analogue of Evidence Lab's L × I × A.
- **Discrimination** = hit rate on faulty artifacts − false-alarm rate on correct-artifact controls. Reported beside the composite, never alone.
- **Ritual rate** — the share of attempts where the learner ran ≥1 check and every check they ran was **pass-either-way**. **This is the metric unique to this tool and the one that should be watched hardest**: it rises when a learner has learned the *form* of verification without the substance, and nothing else in the scoring would catch it. A tool that reports only the composite would let ritual verification look like progress.
- **Cost ratio** = spend ÷ the key's cheapest sufficient cost. Win condition is falling **toward 1.0 at constant accuracy** — not falling without limit, which is just skipping the check.
- **Over-trust rate** = high confidence + wrong verdict + no discriminating check (engine §6).
- **Unverifiable recognition** = correct *unverified* rate on no-oracle items, reported next to false *unverified* on verifiable ones. Both, or the tool rewards giving up.
- **Recall–recognition agreement** (§4a) — did the learner's free-text localisation match the element they then picked from the list. Divergence is the signature of recognising an answer rather than knowing it, and it is the one thing a two-step response buys that neither format gives alone.
- **Cost-prediction accuracy** — predicted sufficient cost against the key's, on the unassisted rung (§4a). Descriptive, never scored.
- **Self-report vs. behaviour overlay** (engine §6), with the 96%-don't-trust / 48%-always-verify framing as the teaching display. This is the most directly persuasive thing the tool can show a learner about themselves.

**Every metric above is reported per rung and never pooled across rungs** — the assisted and unassisted rungs are different instruments, and a trend line that crosses a promotion without a visible marker would show a learner getting worse at the moment they advanced. Same rule, same reason, as the `contentVersion` / `rubricVersion` break markers in engine §6.

## 7. Mastery criterion

**Mastered** = across two distinct calendar days, on **unassisted-rung** items for that module (§4a): the strict composite on **≥ 5 of 6** items, **no false alarm on a correct-artifact control**, **cost ratio ≤ 2×** on those items, and **ritual rate 0** in the window. Four clauses, and each removes a distinct way of looking competent: accuracy without discrimination is suspicion, accuracy without cost control is an audit, and a clean composite with a non-zero ritual rate means the right verdicts were reached by luck rather than by checking.

**Assisted-rung attempts cannot earn mastery**, and the tool says so plainly rather than leaving it to be inferred: under a ceiling V4 is feedback-only, so a third of the cost judgement is unmeasured. This is the engine's existing rule (§3 step 6 — mastery only unscaffolded), not a new one, and the alternative — redefining mastery down to whatever the assisted rung can measure — would hand out mastery of a skill nobody assessed.

**Tested out** = baseline strict composite ≥ 80% on that module's oracle class, with no control false alarm and ritual rate 0.

**Pool floor** (inherited from D-17, and non-negotiable at authoring time): **≥ 6 pool items per module, of which ≥ 2 control** (at least one `CORRECT` and at least one `NO_ORACLE`), and **≥ 4 distinct oracle classes represented per module pool**.

## 8. Practice modes

- **Calibrated practice** — interleaved across modules and oracle classes. Interleaving, not blocking.
- **Real-work verification** — the retention feature, and the reason this tool survives past the modules. The verification record is a working artifact the rest of Tracker can hold, exactly as Evidence Lab's verdict card is.

**The tool never executes the learner's check for them.** No sandbox, no calculator, no search proxy. In measurement modes the bench outcomes are authored; in real-work mode the learner runs the check outside and pastes back. Building an execution environment would make Tracker a worse version of the tools the learner already has, and — more importantly — it would move the act of checking inside the app, where it stops being a habit they carry out of it.

## 9. Engine deltas

**The smallest of the three tools, because #3 will already have paid for the schema.**

- `SkillKey` += `verification`. One enum value; **no other migration** if `03-decomposition-lab.md` §9's `SkillAttempt.responseStructure` has landed — a verification response (oracle statement, selected checks, verdict, failing element, residual risk) is a small structure and belongs in that same JSON column. If #4 is built *before* #3, that column comes with it.
- New content pack `verification/v1`, spec/surface split, validator mirroring the others plus two checks of its own: **every item must have ≥1 discriminating bench entry** (otherwise the item is unsolvable and V3 unscoreable), and **no item may have every bench entry discriminating** (otherwise V3 is free and the drill measures nothing).
- **Reuse `SkillCheckEvent`** — new kinds `oracle_named`, `check_selected`, `check_revealed`, `verdict_set`, `localization_set`, `residual_risk_set`. Reuse `logSkillCheckEvent` unchanged; it already stamps `offsetMs` server-side. This is the fourth tool on that table, which retires any remaining doubt that it is the engine's ordering primitive.
- **Own GraphQL types** (`VerificationModule`, `VerificationServedItem`, …) per the Clarity precedent.
- Probe forms A/B/C, matched on fault profile, oracle class and difficulty, ≥⅓ control. **If Decomposition Lab's Phase 5 has shipped, the probe machinery is already skill-agnostic and this tool inherits it** — which is why that phase was specified to live at `services/skills/probes.ts`.

## 10. Interface requirements

**Wireframes: `04a-verification-lab-wireframes.html`, draft 1, drawn 2026-08-11.** Ten plates plus an RTL pass; two new components (the oracle bench, the ritual-first reveal), the rest rearranging what the three existing labs already have.

- **The oracle is named before the bench is usable.** V1 is unscoreable otherwise, and the ordering is the measurement: `oracle_named` is server-stamped and the bench is disabled until it exists. The same forcing function as Clarity's prediction lock, Evidence's verdict lock and Decomposition's whole-statement lock.
- **The bench shows each check's cost before it is run and never its outcome.** Cost visible, result hidden — that is the decision the learner has to make. A bench that previews outcomes is a bench that scores nothing.
- **Running a check is irreversible and the spend is always visible.** On the **assisted** rung the total runs against a hard ceiling; on the **unassisted** rung it runs against nothing, and the sufficient cost is disclosed only at the reveal (§4a). An invisible total would make V4 a hidden rule, which this canon refuses — the rubric is the teaching object, not a grading scheme.
- **The enumerated element list is never on screen while checks are being chosen.** It appears at the verdict step on the assisted rung, and only after the free-text localisation is committed on the unassisted rung. Shown earlier it becomes a shopping guide for which check to buy, which would contaminate V1 and V3.
- **Stated confidence and self-critique appear on the bench as available checks**, tagged nothing, priced cheaply, and revealing an authored outcome that is *uninformative*. They must be selectable — a costume you are prevented from wearing is a costume you never learn to recognise.
- **Verdict, failing element, confidence and residual risk are committed together, before any reveal**, and are not editable afterwards.
- **Every reveal opens with a statement about whether the checks could have failed** — before it says whether the verdict was right. Four states, all of them stated, none of them praise:

  | State | The line |
  |---|---|
  | No check run | *You committed without running a check.* |
  | No check could have failed | *None of your checks could have failed. You reached this verdict without evidence for it.* |
  | Some could | *One of your three checks could have failed; two would have returned the same either way.* |
  | All could | *Every check you ran could have failed.* |

  **Settled 2026-08-11: the line is never suppressed after N sightings.** The negative form should disappear because the learner stopped triggering it, never because the interface stopped saying it. A designed fade would hide a regression, and would also make the feedback a punishment badge that arrives only on bad days; a symmetric statement on every reveal is a fact about the attempt, and facts do not need rationing. This is the same instinct as the pillar's *detect, don't count* stance on graduation (`../../../ecosystem/canon/02-pillars/learn.md` §7 and the decision log) — the signal fades out of the learner's life by being earned, not by being hidden.
- **Progress statistics appear only once there is progress** (Evidence Lab §9, learned from real use).
- Progress surface: six criterion lines, strict composite, discrimination, **ritual rate**, cost-ratio trend, unverifiable recognition against false-unverifiable, self-report overlay, review queue, baseline/post/delayed with version markers and an explicit no-baseline state.
- **Six bench entries per item.** Below four the choice is trivial and V3 comes free; above seven the item becomes a menu-scanning exercise rather than a judgement. A later variant may author more entries and display six — **if it ever does, the six must be a fixed deterministic subset per item, never a per-learner sample**, or two learners are no longer taking the same item and every cross-learner comparison quietly dies.
- i18n: strings **and** content in `en` + `fa` at launch. RTL pass on the bench and the reveal panes ships with the `fa` surface.
- **Western digits in both locales** (settled 2026-08-11), including inside Persian prose and RTL layout. This records what the app already does — there is not a single Persian digit in the client or the locale files as of this date — and it buys three things that matter here specifically: no digit-shape tell between an artifact and a bench outcome, arithmetic that is byte-identical across locales, and numeric detectors that run against one digit set rather than two. **Worth promoting into `../02-architecture/04-conventions.md` §7**, because a convention that currently holds only by accident is one a future contributor will helpfully "fix".

## 11. Risks

| Risk | Mitigation |
|---|---|
| **Ritual verification** — the failure mode specific to this skill. A learner checks diligently, with oracles that cannot discriminate, and both they and a naive scoreboard read it as competence | V3 scored separately from V1; **ritual rate** as a first-class metric; mastery requires it at zero; the reveal names it before the verdict |
| **Manufactured oracles** — a learner who always finds a check has learned to invent them, which is invisible and worse than credulity | `NO_ORACLE` controls in every form; false-*unverified* reported beside correct-*unverified* |
| **Blanket distrust** | ~⅓ `CORRECT` controls; headline is discrimination, never catch rate |
| **A generic checklist emerges** — the obvious design, and the one the inspection experiments argue against | Oracles are authored per fault class; the validator requires ≥4 oracle classes per module pool; no global checklist surface exists |
| **The bench teaches a closed world** — real verification requires *inventing* an oracle, not picking from six | Bench for measurement only; free-text oracle statement in practice; real-work mode where the learner invents and runs it outside the app |
| **A wrong key or a wrong authored outcome** fails silently, producing a confident wrong score | `keyVerifiedAt` per item; a second person re-derives every authored bench outcome; validator rejects items with no discriminating entry or with all entries discriminating |
| **Cost becomes rationing** | No hard budget; spend visible; V4 tolerant to 3× before it scores 0 |
| **Scope creep into #5** | The delegate/keep mark is recorded, never scored |
| **Boredom of the drill** | `v3` is 30-second items; the rest are 6–10 minutes; real-work practice is the retention strategy, not streaks |

## 12. Acceptance criteria

- Baseline → six modules → post → 7-day delayed probe completes, every attempt version-stamped, every `SkillCheckEvent` ordered and offset-stamped, and V1 scored strictly on `oracle_named` preceding the first `check_selected`.
- **A full probe completes with no LLM configured and no outbound network access** — authored bench outcomes only; asserted by a test with outbound requests blocked.
- No item key, bench tag, authored outcome, fault profile or expected verdict appears in any client payload **before the corresponding check is run or the verdict is committed** (asserted by test). Bench outcomes are served one at a time, on selection — shipping the whole bench with its outcomes would leak the item.
- Every form: ≥⅓ control items including ≥1 `CORRECT` and ≥1 `NO_ORACLE`; ≥4 distinct oracle classes. Validator errors, not documentation.
- Every item has ≥1 discriminating bench entry and ≥1 non-discriminating one. Validator error.
- Every item has **≥4 enumerated elements of which ≥2 are decoys**, or the localisation list narrows to its own answer. Validator error.
- **Probes run on the unassisted rung at every timepoint**, whatever the learner's practice rung — asserted by test, because this is the assertion that keeps baseline→post→delayed comparable (§4a).
- No trend line pools attempts across rungs; a promotion renders a visible series marker.
- V4 contributes to no total on assisted-rung attempts, and the total renders as `n / 10` with "5 of 6 criteria scored" beneath it — asserted by test, per the Clarity Phase-3 precedent.
- Strict composite, discrimination **and ritual rate** are all displayed; none shown alone.
- Scoring, mastery and interval-scheduling services unit-tested against fixtures, including a fixture where a correct verdict was reached with only pass-either-way checks (expected: composite 0 on V3, ritual rate 1).
- `en` + `fa` at string and content parity; RTL pass on bench and reveal.

**Outcome targets, stated so the tool can fail honestly.** Strict composite up ≥25 percentage points baseline→post; **ritual rate falling to near zero**; cost ratio falling toward 1.0 with no fall in accuracy; discrimination positive and rising; correct-*unverified* recognition rising **without** a rise in false-*unverified*; ≥70% of the composite gain retained at the 7-day delayed probe; and no rise in false alarms on `CORRECT` controls. The one figure with no published baseline to beat is the ritual rate — nobody measures it, which is part of why it is worth measuring.

---

## Changelog

- **0.4 · 2026-08-11** — Four decisions settled after the wireframe review. The discrimination line appears on **every** reveal in all four states and is never suppressed after N sightings — *the negative form should disappear because the learner stopped triggering it, not because the interface stopped saying it*. **Six bench entries**, with the warning that a future display-six-of-N variant must use a fixed deterministic subset, never a per-learner sample. The **cost prediction is in**, promoted from optional. **Western digits in both locales** — which turned out to record existing app behaviour rather than change it, and is flagged for promotion into conventions §7 since it currently holds only by accident.
- **0.3 · 2026-08-11** — Wireframes drawn, draft 1 (`04a-...html`): ten plates plus an RTL pass. Three things the drawing settled rather than illustrated — the two rungs are best drawn as **the same item twice** (the ceiling is the only difference, and greyed-out unaffordable checks are what makes the assisted rung teach); the near-miss check (independent, true, and irrelevant) needs its **own frame beside the costumes**, because confirming a correct part of a wrong answer is the harder lesson and was invisible in prose; and the ritual reveal reads better with a **clean counterpart drawn next to it**, which raised whether the ritual line should appear on every reveal rather than only when triggered (open, in the page).
- **0.2 · 2026-08-11** — §4a added: the budget and the localisation format become **one progression** rather than two settings (founder direction). Assisted rung = hard ceiling + enumerated list, V4 feedback-only, mastery unreachable; unassisted rung = no ceiling + free-text-then-list, sufficient cost revealed after commit. Records that this is the engine's existing fading and unscaffolded-mastery rules rather than a new concept, that it adds **no authored content**, and the one collision it had to resolve: **probes run unassisted at every timepoint**, because tiering the instrument between baseline and post would make a promoted learner appear to get worse. The two-step localisation is what keeps V5 offline-scorable at every rung, and it yields recall–recognition agreement as a new metric.
- **0.1 · 2026-08-11** — Initial spec. Research pass established the boundary with Evidence Lab (triage and sourcing there; oracle construction here), imported the **test oracle problem** with partial and metamorphic oracles as the durable content, and identified two perishable costumes — model self-critique (which fails and can degrade performance) and stated confidence (poorly calibrated, worst when wrong). Pedagogy from Wason/Klayman-Ha plus the think-in-opposites training result; **the scenario-over-checklist inspection finding forbids a generic verification checklist**. Instrument adapted from the seeded-defect inspection paradigm, extended with an authored oracle bench so oracle choice and cost are instrumented rather than self-reported. **Ritual verification** named as the failure mode specific to this skill and given its own first-class metric.

## References

- **The oracle problem** — the test-oracle literature; partial oracles; metamorphic testing (Chen et al.; *Metamorphic Testing: A Simple Approach to Alleviate the Oracle Problem*). The durable content of this tool.
- Huang et al. (ICLR 2024). *Large Language Models Cannot Self-Correct Reasoning Yet* (arXiv 2310.01798) — intrinsic self-correction fails without external feedback and can degrade performance. Costume #1. Contrast: *Self-Correct with Key Condition Verification* (EMNLP 2024), which works by adding external structure.
- Work on **verbalised confidence** in LLMs — poor calibration, overconfidence concentrated on wrong answers, RLHF as a plausible amplifier (*Can LLMs Express Their Uncertainty?*, arXiv 2306.13063; *Wired for Overconfidence*, arXiv 2604.01457; *LLMs Are Overconfident in Their Own Responses*, arXiv 2606.03437). Costume #2.
- Wason (1960), rule discovery; Klayman & Ha (1987), the **positive test strategy** as a default heuristic rather than a fallacy; *Training People to Think in Opposites Facilitates the Falsification Process* (J. Intelligence 2023), replicated in *Memory & Cognition* (2025) — the trainable move.
- Porter, Votta & Basili (1995), *Comparing Detection Methods for Software Requirements Inspections* — **scenario-based detection beat ad-hoc and checklist**, and reviewers were most effective at the faults their scenario targeted. The finding that forbids a generic checklist.
- The **seeded-defect** inspection paradigm — true defects found, false positives reported, time taken — as the instrument lineage. Static-analysis false-positive rates of 76–90%+ as the cautionary case for recall-over-precision checking.
- Perry, Srivastava, Kumar & Boneh (CCS 2023). *Do Users Write More Insecure Code with AI Assistants?* (arXiv 2211.03622) — less secure code **plus** greater belief that it was secure; and lower trust in the assistant associated with fewer vulnerabilities.
- Sonar developer survey (January 2026) — 96% do not fully trust AI-generated code, 48% always verify it, AI ~42% of committed code. **Practitioner survey, not peer-reviewed**; used for the dissociation display, never as an effect size.
