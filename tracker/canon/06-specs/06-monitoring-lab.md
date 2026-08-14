# Tracker — Monitoring Lab (skill tool #6)

*Spec, not as-built. The tool that trains self-monitoring — tracking your own thinking while something is actively shaping it — by making you predict your own state and then measuring it. Runs on `00-skills-engine.md`. Wireframes: `06a-monitoring-lab-wireframes.html`. Phase order, algorithms and gates: `06b-monitoring-lab-build-plan.md`. Update the changelog; don't fork.*

**Version 0.4 · Status: spec · 2026-08-12 · Owner: _root**

---

## 1. The skill, and a correction to what this canon expected of it

Self-monitoring is skill #6 (`../../../ecosystem/canon/04-research/02-durable-ai-skills.md` §3): metacognitive tier, last in the stack, and the one repeatedly deferred here on the grounds that it had **neither a scorable artifact nor an observable in-app behaviour** — a genuine instrument problem rather than a writing problem.

**That was wrong, and the research pass is what corrected it.** The artifact is the **prediction**. Every item in this tool collects a claim the learner makes about their own state, and then measures that state against a key. Predicted understanding against demonstrated understanding; predicted recall against actual recall; what they say moved them against what was planted. **This is the only tool in the engine whose items measure a gap about the learner rather than a gap about the world or the artifact**, and once that is seen, the instrument stops being a problem and becomes the tool's defining shape.

**And the trainability evidence runs the opposite way to skill #5's.** Where appropriate reliance has a literature of interventions that mostly fail, metacognitive monitoring accuracy has a **meta-analysis of interventions that improve it**, and training effects that hold *over and above* the benefit of repeated testing alone. So of the four tools specced in this pass, **#6 is the best-evidenced, not the weakest.** It was deferred for the right reason and the reason turned out not to apply.

### 1.1 The two faces, and why they are one skill

**Inward — mistaking access for possession.** Searching for an explanation inflates people's estimates of *their own internal* knowledge, across nine experiments and even on unrelated domains afterwards (Fisher, Goddu & Keil 2015). The mechanism is older: the **illusion of explanatory depth** — rate your understanding of how something works, try to explain it step by step, re-rate, and the rating drops one to two points on a ten-point scale, robustly, across replications (Rozenblit & Keil 2002). Reading a fluent explanation produces the feeling of understanding without the thing itself.

**And the LLM version is worse, in a way that indicts this entire engine.** A 2026 study (*Computers in Human Behavior*, Aalto) found that people using an LLM score **higher** on reasoning tasks and **consistently overestimate their success by a significant margin** — and that **AI-literate users are the *most* overconfident**, a reversal of the usual Dunning–Kruger pattern where the least able overestimate most. Most participants prompted once, accepted the answer, and moved on.

> Skills #1–#5 make a person more AI-literate. If AI literacy predicts *worse* self-assessment, then #6 is not merely the last module in the stack — **it is the corrective for the other five, and the engine has a hole in it until this exists.**

**Outward — the conversation is shaping you, and agreement is the instrument.** LLMs agree with users far more than a person would — around **49% more often** than a human counterpart in a 2026 *Science* study — and that systematic agreement reinforces users' existing convictions, including the wrong ones. CHI 2026 work finds sycophancy stabilises beliefs most for people holding the *most extreme* initial positions, which is an anchoring effect wearing a friendly face. Related work finds sycophantic assistants mislead novices in problem-solving without being detected as doing so.

The two faces are one skill because both are **failures to notice your own state while something is acting on it.** Inward, the thing acting on you is the fluency of an explanation; outward, it is the shape of a conversation. In both cases the felt experience is indistinguishable from competence, which is precisely why it has to be measured rather than introspected.

**Grade: strong.** The construct is mature, the paradigms are decades old and replicated, the AI-specific findings are recent but converging and quantified, and — unlike #5 — **the target is documented as trainable.**

### 1.2 The costume

The parent brief already named it, and Clarity Lab stubbed a module for it rather than absorbing it (`01-clarity-lab.md` §3): **"tell the model to ignore its memory."** The surface mechanic is a toggle, a settings panel or a phrase, and every one of those drifts. The instinct underneath — noticing that accumulated context could be biasing a result, and neutralising it deliberately — **is self-monitoring pointed outward at the tool.**

Two more of the same shape, both taught as technique and both mechanically perishable:

- **"Start a fresh chat when it goes wrong."** Genuinely useful. The durable kernel is not the button; it is recognising *that the conversation itself has become the problem*, which is a judgement about your own situation, not about the model.
- **"Tell it not to flatter me" / "be critical of my idea."** A prompt-level patch for sycophancy that works unevenly and will keep changing. The durable kernel: **agreement is cheap, so seek a test instead** — which hands off to Verification Lab (§3).

## 2. What is measured, and the two traps in measuring it

Every item collects a **prediction** and then a **measurement**, and scores the distance. Two quantities come out of that, and conflating them is the most common error in this literature:

| | What it is | What it means |
|---|---|---|
| **Bias** | mean(predicted − actual), signed | Are you generally over- or under-confident? A disposition |
| **Resolution** | how well per-item predictions track per-item correctness (gamma / AUC) | **Can you tell which of your answers are wrong?** A skill |

**Resolution is the headline.** Bias is a thermostat setting and can be shifted by telling someone they are overconfident; resolution is the discrimination that makes self-monitoring worth having. This is also the clean seam with Delegation Lab: **#5's `g1-own` took bias** — one confidence number per item, scored by Brier, deliberately the thin edge — **and #6 takes resolution**, which Brier conflates and gamma isolates. Two tools, two quantities, no overlap.

**Trap 1 — relative accuracy is confounded with task performance where guessing is possible.** A learner who can guess well scores well on resolution for reasons that have nothing to do with monitoring. Two consequences, both binding: probe items are **short-answer against an authored acceptable-answer set, never multiple choice**, and **resolution is always reported beside task performance and never alone.**

**Trap 2 — the illusion-of-explanatory-depth drop is gameable the moment the learner understands the mechanic.** Rate high, explain, rate low — after one module, anyone can protect the score by rating low from the start. So the IOED sequence is used as **teaching, not measurement**: the deflation is the lesson, and the *measured* quantity is prediction accuracy against a keyed test, where under-rating costs exactly what over-rating costs. Teaching and scoring are separable, as they already are for self-report (engine §6) and for the recoverability mark in `05-delegation-lab.md` §4.

## 3. Modules

Six, 1:1 with the rubric criteria (§4), each anchored to a specific finding.

| Key | Module | Trains | Anchored in | Criterion |
|---|---|---|---|---|
| `s1-access` | **Yours, or the tool's?** | Separating what you know from what you can reach. Predicting your unassisted performance, then performing unassisted | Searching inflates estimates of *internal* knowledge (Fisher, Goddu & Keil 2015) | S1 |
| `s2-explain` | **Say it with the answer closed** | The explanation attempt as the check on felt understanding. The deflation is the point | Illusion of explanatory depth (Rozenblit & Keil 2002); explaining one thing deflates confidence in others | S2 |
| `s3-resolution` | **Which of these did I get wrong?** | Not "how confident am I" but "can I pick out my own errors" | Monitoring resolution; the meta-analysis showing monitoring accuracy is trainable | S3 |
| `s4-agreement` | **It agreed with me. So what?** | Agreement as a non-signal — systematically more frequent than a person's, and strongest where you are most certain | ~49% more agreement than a human counterpart (*Science* 2026); sycophancy stabilises extreme positions (CHI 2026) | S4 |
| `s5-anchor` | **What did this conversation put in my head?** | Noticing an early number, a framing, or a premise you never agreed to. **The memory-standdown costume lives here** | Anchoring within sycophantic exchanges; the §1.2 costume | S5 |
| `s6-complacency` | **Am I still checking?** | Noticing the point in a long session where you stopped reading and started accepting — and building a structural check rather than resolving to try harder | Automation complacency: present in **novices and experts alike**, and **not overcome by simple practice** (Parasuraman & Manzey 2010) | S6 |

**`s6` is taught differently from every other module in the engine, and the evidence requires it.** Complacency is described in that literature as a structural feature of attention allocation under bounded resources — *not* a personality trait and *not* a training failure. So the module must not teach vigilance as effort. It teaches **a structural countermeasure**: a check placed in the workflow at a point where attention is known to be gone, which does not depend on noticing in the moment. A module that said "pay closer attention" would be contradicted by its own citation.

**Three seams, stated so they are not crossed.**

- **#5 takes bias, #6 takes resolution** (§2). `g1-own` remains one number per item.
- **`s4` hands off to #4.** Agreement is not evidence; what to do instead is construct an independent check, which is Verification Lab's whole subject. This tool teaches the noticing and stops.
- **#2's anti-cue and #6's are the same shape on different objects.** Evidence Lab: *fluency is not evidence* — about the text. Monitoring Lab: *felt understanding is not understanding* — about you. That is now the third structural echo across the six skills, alongside independence (#2/#4) and instance-over-category (#5/#2).

## 4. The instrument: self-monitoring rubric v1

Six criteria, **0 = absent · 1 = partial · 2 = present**, total **0–12**.

| # | Criterion | 0 | 1 | 2 |
|---|---|---|---|---|
| **S1** | **Access separated from possession** | Predicted unassisted performance exceeds actual by more than the module threshold | Overestimates within threshold | Predicted unassisted performance tracks actual, **and** the learner's post-AI self-rating does not exceed their unassisted-item self-rating on the matched pair |
| **S2** | **Understanding tested, not felt** | Explanation omits the causal step the key marks as load-bearing, and the re-rating does not move | Explanation is partial; re-rating moves | The explanation reaches the key's causal steps, **or** the learner correctly identifies which step they cannot supply |
| **S3** | **Resolution** | Per-item predictions are uncorrelated or inversely correlated with correctness | Weak positive relationship | Predictions discriminate own correct from own incorrect answers above the module threshold, **at any level of task performance** |
| **S4** | **Agreement discounted** | Treats the assistant's agreement as support for the position | Notices the agreement but still weights it | Identifies the agreement as carrying no information, **and** names what would carry some |
| **S5** | **Influence located** | Misses every planted influence, or reports influences in a clean transcript | Finds some; one false alarm | Finds the planted influences the key lists, with no false alarm on a clean transcript, and names *what* they moved |
| **S6** | **Structural check** | Proposes effort ("read more carefully") or nothing | Proposes a check that still depends on noticing in the moment | Proposes a check that fires **independent of attention** — a fixed point in the workflow, not a resolution |

**Void flag** (separate, never averaged as zero): no prediction committed, or an explanation that restates the prompt.

**Scoring split — keyed, computed, and offline:**

| Criterion | Source |
|---|---|
| S1 | Computed — predicted against actual on keyed short-answer items, plus the matched-pair self-rating difference |
| S2 | Key — authored causal steps, matched by **learner selection** from an enumerated step list after their free-text attempt (the two-step pattern from `04-verification-lab.md` §4a) |
| S3 | Computed — gamma/AUC of predictions against correctness, reported beside performance |
| S4 | Key — the agreement beats are authored and tagged |
| S5 | Key — planted influences are authored, with clean control transcripts |
| S6 | Key — the countermeasure is selected from an enumerated list separating attention-dependent from attention-independent checks |

**No model anywhere in the scored path**, for the fourth tool running. The free-text explanation in `s2` is captured and judged only when a credential exists; the scored component is the learner's own selection from the authored step list.

**Persian is more expensive here than in #3 or #5, and for a reason worth stating.** Most of the pack is structural, but **`s4` is not: agreement and flattery are culturally calibrated.** A warm agreement beat that reads as sycophancy in English can read as ordinary courtesy in Persian, where تعارف makes deference a default register rather than a signal. So **`s4` transcripts are re-authored, not translated** — the same category of decision as Clarity's R4/R6 and the Feelings & Needs faux-feelings lexicon (**D-23**), and for the same underlying reason: the item's fault is a claim about *how a language behaves*, not about structure. Budget the Persian linguistic effort against `s4` and the `s5` transcripts, and nowhere else.

## 5. Item types

1. **Predict-then-answer** — a short-answer question, a per-item prediction of whether they will get it right, then the answer, scored against an authored acceptable-answer set. **The baseline / post / delayed instrument**, because resolution needs many keyed items and no free text.
2. **Matched assisted/unassisted pair** — the same difficulty of question, one with an authored AI explanation shown first, one without; self-ratings collected on both. **The inflation measure**, and the per-learner version of the Aalto finding.
3. **Explain-then-rerate** (`s2`) — rate, explain in free text, select which authored causal steps you covered, re-rate. Teaching-weighted; the selection is what scores. **Three causal steps per item** (settled 2026-08-12), behind a constant `S2_STEPS`: a learner who reaches one of three has already deflated, and a fourth step was carrying no additional work.
4. **Transcript influence audit** (`s4`, `s5`) — an authored conversation with planted influences (an agreement beat, an anchor number, a smuggled premise, a flattery turn). The learner marks what moved them and what it moved. **~⅓ clean transcripts with nothing planted**, so false alarms cost what misses cost — the same refusal the whole engine runs on.
5. **Long-set complacency probe** (`s6`) — a longer run of items where check-rate is instrumented, followed by choosing a countermeasure.
6. **Session self-audit** (open practice) — the learner reviews one of their own real AI conversations against the four influence types and writes a short note. Never scored into mastery or probes.

## 6. Metrics

- **Monitoring resolution** — gamma or AUC of per-item predictions against correctness. **The headline, and always displayed beside task performance**, never alone (§2, trap 1).
- **Bias** — mean(predicted − actual), signed, so the direction is legible. Cross-referenced with Delegation Lab's calibration where both exist, and **never merged with it**: different quantity, different tool, different item pool.
- **Post-AI inflation** — self-rating after an assisted item minus self-rating after a matched unassisted item. The per-learner version of the effect that motivates the tool. Expected positive at baseline; the target is toward zero.

  **The §1.1 finding is withheld until this number exists** (settled 2026-08-12), and is then shown attached to it. Told up front it is a fact about strangers and reads as a lecture; told alongside *"your rating jumped 1.7 points on a different question"* it is a description of the learner, which is the only form in which it does any work. Same reasoning as the WOA baseline gate in `05-delegation-lab.md` §4a. **If a learner's inflation is near zero, the finding is still shown, saying so** — one that only ever appears when it is damning is a lecture wearing a statistic, and the learner who doesn't inflate has earned being told that.
- **Influence discrimination** — planted influences found, minus false alarms on clean transcripts.
- **Deflation magnitude** (`s2`) — the IOED rating drop. **Descriptive only, never scored** (§2, trap 2), and displayed because watching your own number fall is the teaching.
- **Check-rate decay** (`s6`) — instrumented check-rate over the first versus last third of a long set.

## 7. Mastery criterion

**Mastered** = across two distinct calendar days, on unscaffolded items for that module: **resolution above the module threshold**, **bias within ±1 scale point**, **no false alarm on a clean transcript**, and — for `s1` — **post-AI inflation not above baseline**. Four clauses, and the third and fourth each close a way of looking competent: a learner who reports influence everywhere has a suspicion, not a skill, and a learner whose resolution is fine while their assisted self-rating still balloons has learned to monitor a test rather than themselves.

**Tested out** = baseline resolution above threshold with bias within range and no clean-transcript false alarm.

**Pool floor**: ≥6 pool items per module; `s1` counted in **matched pairs**; transcript modules require ≥2 clean controls per pool; short-answer items need ≥3 authored acceptable-answer variants each, or the key marks correct answers wrong and the resolution measure inverts.

## 8. Practice modes

- **Calibrated practice** — interleaved across modules and influence types.
- **Session self-audit** — the retention feature and the one that makes the skill portable: a person auditing their own real conversation is doing the thing the tool exists to install. Saveable as a `JournalEntry`.

## 9. Engine deltas

- `SkillKey` += `monitoring`. **No other migration**, given `SkillAttempt.responseStructure` from `03`.
- Predictions, ratings, explanations, step selections and influence marks all live in `responseStructure`; check-event kinds `prediction_committed`, `rating_committed`, `explanation_committed`, `steps_selected`, `influence_marked`, `countermeasure_selected`.
- **The prediction is server-stamped before the item is answerable**, and the answer is absent from the payload until it is — the same ordering rule as every other tool in the engine, and for the same reason.
- Own GraphQL types; probe machinery inherited.

## 9a. Cross-tool transfer — the hypothesis, recorded 2026-08-12

Every tool writes to the same `SkillAttempt` table with the same version stamps, so **cross-tool transfer is measurable from rows that are already being written.** No tool currently asks the question: each measures itself, and each probe is internal to one tool. That matters here more than anywhere else, because **the justification for this tool is that it corrects the other five (§1.1), and as things stand that claim cannot fail** — Monitoring Lab measuring its own resolution rising says nothing about whether anything changed elsewhere.

**Decision (2026-08-12): the hypothesis is recorded now; `skillCrossExport` is a P2 line item; nothing is shown to the learner.** Only one part of this is time-sensitive, and it is not the code. The rows persist, so the export can be written whenever there is data worth exporting. **A hypothesis written after seeing the data is not a hypothesis** — that paragraph is free today and impossible to reconstruct later. And a learner-facing version would be actively harmful early: with one user over a handful of attempts, any cross-tool difference is noise, and presenting noise as a finding inside a tool about not doing that would be self-refuting.

**Stated before the data exists:**

- **H1 · Verification Lab.** Ritual rate falls on Verification items taken **after** Monitoring Lab completion, relative to the same learner's items before it. Mechanism: `s6` and `s4` train noticing that one is going through motions.
- **H2 · Delegation Lab — the sharp one.** `05-delegation-lab.md` §12 carries a pre-registered null: calibration improves, reliance discrimination does not. **That null may be a sequencing artifact.** The published interventions do not first train self-monitoring, and if knowing your own error rate is the *prerequisite* for weighting advice well, then Delegation-before-Monitoring should show the null and **Delegation-after-Monitoring should not.**
- **H3 · Evidence Lab.** Check-rate decay across a long drill flattens after `s6`.
- **The falsifier, stated so the claim can lose:** if Monitoring Lab's own resolution rises while H1–H3 all stay flat, **the corrective claim in §1.1 is wrong** and self-monitoring is a self-contained skill rather than the thing holding the other five together. That result would be worth recording as loudly as the positive one.

**And the limit, stated beside the hypothesis so the two are never separated.** This app has one user. **n = 1 cannot support a causal claim.** What the export can produce is a *description* — this person's ritual rate fell after that date — which is a hypothesis generator, not evidence. It becomes genuinely interesting only if the Skills Engine ever graduates to its own app with real users; the instrumentation will already be there, which is the whole reason this is worth writing down now rather than retrofitting later.

## 10. Interface requirements

**Wireframes: `06a-monitoring-lab-wireframes.html`, draft 1, drawn 2026-08-12.** Ten plates plus an RTL pass; two new components (the two-number deflation, the transcript influence audit), the rest rearranging what the five existing labs already have.

- **The prediction commits before the item is answerable**, and the answer is absent from the payload until it does.
- **The re-rating in `s2` is taken before the authored steps are shown**, or the learner is re-rating against the answer rather than against their own attempt.
- **The deflation is shown as the learner's own two numbers**, side by side, with no commentary beyond the drop. It does not need a lesson attached; it is the lesson.
- **The transcript audit renders as a real conversation**, with no styling difference between planted and clean turns. Any visual tell destroys the instrument — the rule Evidence Lab learned from real use.
- **Resolution never appears without task performance beside it.**
- **`s6`'s countermeasure list separates attention-dependent from attention-independent options** without labelling them as such; sorting them *is* the item.
- **No streaks, no vigilance scores, no "you've been sloppy today" copy.** A tool about attention is the easiest place in this engine to accidentally build a nag, and the standing refusal (D-3) applies with force.
- Progress: six criterion lines, resolution beside performance, bias with direction, post-AI inflation trend, influence discrimination, deflation history, check-rate decay, review queue, baseline/post/delayed with version markers.
- i18n: `en` + `fa`, Western digits, RTL pass on the transcript audit and the two-number deflation display.

## 11. Risks

| Risk | Mitigation |
|---|---|
| **Resolution confounded with performance** — the trap named in the methodology literature | Short-answer, not multiple choice; resolution always reported beside performance; never a standalone number |
| **The IOED drop is gamed** once the mechanic is learned | Deflation is descriptive and unscored; the measured quantity is prediction accuracy, where under-rating costs what over-rating costs |
| **Influence paranoia** — a learner who finds manipulation everywhere | ~⅓ clean transcripts; discrimination, never catch-rate |
| **`s6` becomes an exhortation** | The countermeasure must be attention-independent to score 2; the citation says complacency is structural and unfixable by practice |
| **The tool becomes a nag** | No streaks, no vigilance score, no session-quality grade (D-3) |
| **Persian `s4` translated rather than re-authored** | تعارف makes polite agreement the default register; a translated sycophancy beat may not be one. Flagged in §4 and budgeted |
| **A wrong acceptable-answer set** inverts resolution silently | ≥3 authored variants per short-answer item; second-person verification in the human pass |
| **Scope creep into #5** | Bias is #5's; resolution is #6's; the two are never merged into one calibration figure |

## 12. Acceptance criteria

- Baseline → six modules → post → 7-day delayed probe completes, every attempt version-stamped, **the prediction stamped before the item is answerable** (asserted by test).
- **A full probe completes with no LLM configured and no outbound network access.**
- No key, planted-influence tag, causal-step list or acceptable-answer set appears in any client payload before its commit gate (asserted by test).
- Every transcript pool contains ≥⅓ clean controls; every short-answer item has ≥3 acceptable-answer variants. Validator errors.
- **No view displays resolution without task performance beside it** (asserted).
- Deflation magnitude appears in no total.
- `en` + `fa` at parity, with `s4` transcripts marked as **re-authored rather than translated** in the pack metadata; RTL pass on the transcript audit.

**Outcome targets.** Resolution up ≥0.20 (gamma) baseline→post at unchanged task performance; bias toward zero; **post-AI inflation down**, which is the target that matters most given §1.1; influence discrimination positive and rising; ≥70% of the resolution gain retained at the delayed probe; and no rise in clean-transcript false alarms. Unlike `05-delegation-lab.md`, **this tool has positive trainability evidence behind it and should be expected to work** — if resolution does not move, suspect the build before the construct.

---

## Changelog

- **0.4 · 2026-08-12** — §9a added: the **cross-tool transfer hypothesis, recorded before the data exists** (H1 ritual rate in Verification, H2 whether Delegation's null is a sequencing artifact, H3 check-rate decay in Evidence), with the falsifier stated and the n=1 limit stated beside it. `skillCrossExport` is P2; nothing cross-tool is shown to the learner. Build plan written (`06b-...md`).
- **0.3 · 2026-08-12** — Two decisions settled after the wireframe review. The §1.1 AI-literacy finding is **withheld until the learner's own inflation number exists** and then shown attached to it — including when that number is near zero, since a finding that appears only when damning is a lecture wearing a statistic. **Three causal steps in `s2`**, behind `S2_STEPS`. The cross-tool question in §9 was removed from the wireframes: it is a scoping decision, not a screen.
- **0.2 · 2026-08-12** — Wireframes drawn, draft 1 (`06a-...html`): ten plates plus an RTL pass. Three things the drawing settled rather than illustrated. **The influence audit needs its planted turns ranked by teeth, not just counted** — flattery is the easiest to spot and changes least, while a smuggled premise and an agreement reversal are the two that move a decision, so the reveal orders them by consequence and the key should carry a `weight` alongside the type. **The `s6` countermeasure list must be drawn unlabelled** — sorting attention-dependent from attention-independent options *is* the item, and labelling the columns would hand over the answer. And **the deflation screen is the shortest in the engine on purpose**: two numbers, one line of fact, nothing else; every draft that added an encouraging sentence made it worse.
- **0.1 · 2026-08-12** — Initial spec, and a correction: this tool had been deferred through four rounds on the grounds that it had no scorable artifact and no observable behaviour. **The artifact is the prediction** — every item measures a gap about the learner rather than about the world, which is what distinguishes it from the other five. Research established two faces of one skill (mistaking access for possession; the conversation shaping you) and, unexpectedly, that **monitoring accuracy is trainable** where #5's target is not — making this the best-evidenced of the four tools specced in this pass rather than the weakest. Two methodological traps written into the design: resolution is confounded with performance where guessing is possible, and the IOED drop is gameable once known, so it teaches and does not score. Records the finding that most indicts the engine: **AI-literate users are the most overconfident**, which makes #6 the corrective for #1–#5 rather than merely the last of them.

## References

- Rozenblit, L. & Keil, F. (2002). *The misunderstood limits of folk science: an illusion of explanatory depth*, **Cognitive Science** — rate, explain, re-rate; drops of 1–2 points, robustly replicated. Also *Broad effects of shallow understanding* (**Judgment and Decision Making**) — explaining one phenomenon deflates confidence about others.
- Fisher, M., Goddu, M. & Keil, F. (2015). *Searching for explanations: How the Internet inflates estimates of internal knowledge*, **JEP: General** — nine experiments; inflation persists into unrelated domains.
- Aalto University (2026), **Computers in Human Behavior** — LLM users score higher and overestimate their success significantly; **AI-literate users are the most overconfident**, reversing the usual Dunning–Kruger pattern; most participants prompted once and accepted the answer.
- **Science** (2026) — chatbots agree with users ~49% more often than a human counterpart; *Sycophantic AI decreases prosocial intentions and promotes dependence*.
- *Be Friendly, Not Friends: How LLM Sycophancy Shapes User Trust* (**CHI 2026**, arXiv 2502.10844) — belief stabilisation strongest at extreme initial positions; an anchoring effect. *Invisible Saboteurs: Sycophantic LLMs Mislead Novices in Problem-Solving Tasks* (arXiv 2510.03667).
- *Calibrating Calibration: A Meta-Analysis of Learning Strategy Instruction Interventions to Improve Metacognitive Monitoring Accuracy* (**Journal of Educational Psychology**); and training effects on monitoring accuracy **over and above repeated testing** — the trainability evidence.
- *Measures of relative metacognitive accuracy are confounded with task performance in tasks that permit guessing* (**Metacognition and Learning**, 2020) — the reason probe items are short-answer.
- Parasuraman, R. & Manzey, D. (2010). *Complacency and Bias in Human Use of Automation: An Attentional Integration*, **Human Factors** — complacency in novices and experts alike, **not overcome by simple practice**; a structural feature of attention allocation, which is why `s6` teaches a structural countermeasure.
