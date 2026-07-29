# Root · ریشه — Evidence Summary
*Source of truth. Short on purpose. What we build on, graded honestly. Update the changelog; don't fork.*

**Version 0.2 (draft) · 2026-07-22 · Owner: _root**

---

## 1. Why grade

Reality over fiction applies to our own foundations. Nearly every framework we use has a validated core *and* a documented failure mode — and in almost every case Root's design already hedges the failure mode. Grading lets the team defend choices to outsiders and stay alert to the soft spots. Grades below: **strong** (robust, replicated) / **moderate** (real but limited or correlational) / **thin** (influential but weakly evidenced).

## 2. The core motivation science — **strong**

- **Self-Determination Theory** (Deci & Ryan). Autonomy, competence, relatedness as basic needs for intrinsic motivation. Maps onto the pillars (autonomy↔Organize, competence↔Learn, relatedness↔Others). Decades deep.
- **Overjustification effect.** Extrinsic rewards corrode *existing* intrinsic motivation — worst for the already-motivated. This is the empirical basis of the no-streaks refusal, not a preference. (Broader gamification meta-analyses are more nuanced — game elements can raise perceived autonomy/relatedness but do little for competence — but the corrosion of the intrinsically-motivated is the finding that governs our audience.)

## 3. Goals — **strong**, with a documented dark side

- **Goal-setting theory** (Locke & Latham): specific, challenging, self-set goals raise performance. Robust.
- **The dark side** ("Goals Gone Wild," Ordóñez et al., 2009): specific hard goals can drive tunnel vision, unethical shortcuts, and corroded intrinsic motivation (the canonical example: sales-target-driven fake accounts). Our Clarity Check (multi-dimensional, non-gating) hedges this.
- **Authored goals** (recent work, 2026): goal-setting's benefits presuppose *self-endorsement*; when an external system authors the goal, the advantages don't survive into behavior. Direct constraint on the agent — **help the user author, never author for them.** *(Specific citation unverified; describe the finding, don't over-cite.)*

## 4. Self-tracking / personal informatics — **strong** (as a cautionary base)

- Mature HCI literature (Epstein, Munson, Fogarty and others) on why people abandon self-tracking: the top cause of *permanent* abandonment is **loss of motivation**, not broken mechanics.
- **The cost of quantification** (Etkin): measuring an enjoyed activity can reduce the intrinsic enjoyment of it. This is Reflect's central design risk and the reason for articulation-not-quantification and the gating of pattern recognition.

## 5. The emotion/need module spine — **strong to moderate**

- **Affect labeling** (Lieberman and colleagues): naming a feeling down-regulates amygdala activity — implicit emotion regulation, mildly calming, without feeling effortful. Dissolves the "recognition backfires" worry — **strong.**
- **Non-native-language caveat** (moderate–strong, and load-bearing): affect labeling in a non-dominant language does *not* down-regulate. → feelings/needs work is Persian-first for Persian users (`learn.md` §4).
- **Emotional granularity** (Barrett): finer distinctions correlate with less maladaptive coping and better outcomes, and granularity is **trainable via repeated in-context labeling** (not flashcards) — **strong** on the correlation, **moderate** on trainability. Caveat: granularity ≠ vocabulary size (distinct constructs); don't oversell word-count.
- **Implicit theories of emotion / malleability mindset** (Tamir; adjacent to Dweck): believing emotions are workable predicts better regulation — **moderate–strong.** The single best-evidenced lever for the module; hence frame-first.
- **Interoception / focusing** (Gendlin, alexithymia literature): body-awareness is upstream of naming; attending to sensation then testing words gives a non-analytic on-ramp and sidesteps rumination — **moderate.**
- **Self-distancing / reconstrual** (Kross & Ayduk) — **moderate–strong, and load-bearing (added 2026-07-22).** Re-seeing an emotional situation from a stepped-back, third-person stance lowers reactivity and supports adaptive analysis rather than rumination. This is the finding that qualifies the writing story: expressive writing's *average* effect is **small**, reliable mainly when the writing drives labeling, meaning-making, and reappraisal — not repetitive recounting. So the active ingredient in reflective work is **reconstrual, not writing per se.** This grounds Reflect's sharpened bet and the Learn→Reflect bridge (tracked as **H6b**; see `02-pillars/reflect.md` §6 and `02-pillars/learn.md` §3). Primary source in the repo: `Research/reflection.txt` (cited).
- **Variation theory / contrasting cases** (pedagogy): concepts' boundaries are learned via minimal pairs — the basis for teaching feeling-vs-thought and need-vs-strategy through NVC's faux-feelings as a contrast set — **moderate**, well-established in instruction research.

## 6. NVC — **thin**

Nonviolent Communication is influential but weakly evidenced: small samples, few controlled trials, mostly healthcare/education/organizational settings, roughly one real RCT. It is our **design language** (feelings↔needs, observation vs. judgment), *not* a validated intervention. The empirical weight under the emotion module comes from affect labeling, granularity, interoception, and malleability mindset — not from NVC itself. Present it accordingly.

## 7. Service / contribution — **moderate**, motive-dependent, skewed

Prosocial behavior and generativity (Erikson) correlate with wellbeing, but much of the literature is correlational and concentrated in older adults — treat "service improves wellbeing" as suggestive. The clean, load-bearing finding: the benefit is **motive-dependent** — other-oriented motives predict higher wellbeing than self-oriented ones, and helping lifts wellbeing specifically when **autonomous**. This grounds "service from compassion, not obligation" and the Reflect motive check.

## 8. Growth mindset — **moderate**

Effort/strategy vs. fixed ability; learning from failure. Real but with contested effect sizes in some domains. We use it narrowly and defensibly: **separate effort from outcome** in failure handling.

## 9. Method: Continuous Discovery — **practitioner craft, not RCT**

Teresa Torres's Continuous Discovery Habits and the Opportunity Solution Tree: well-tested in practice, not experimentally validated. Weigh as craft wisdom. Note the one adaptation: we root the tree in a *user/product* outcome, not a business outcome.

## 10. The deeper register — **out of scope for grading**

The twofold moral purpose and the deeper register of Beauty (Core Philosophy §7, Brand §1) are philosophical/spiritual commitments, not empirical claims, and are not graded here.

## 11. Open questions

- Verify the 2026 authored-goals citation before quoting it externally.
- Verify the pairidaēza→paradise etymology (Brand salvage drawer) before publishing.

---

## Changelog

- **0.1 · 2026-07-14** — Initial draft. Graded summary across motivation, goals, self-tracking, the emotion-module spine, NVC, service, growth mindset, and method.
- **0.2 · 2026-07-22** — §5: added **self-distancing / reconstrual** (Kross & Ayduk) as a moderate–strong, load-bearing finding, and the expressive-writing "small average effect" caveat — establishing reconstrual (not writing) as the active lever behind Reflect (H6b). Sourced from `Research/reflection.txt` and the 22 Jul session.
