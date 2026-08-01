# Root · ریشه — Durable Skills for Working With AI

*Source of truth. The evidence base under the Skills Engine (Learn). What compounds, what perishes, and how each side is taught and measured. Update the changelog; don't fork.*

**Version 0.1 · Status: canonical · 2026-08-01 · Owner: _root**

---

## 1. The question, and why it belongs to Learn

The starting premise was that the things widely assumed to matter when working with AI — clever prompts, magic words, memorised techniques, memory and personalisation settings — are **not** what actually drives outcomes, and that ordinary cognitive skills matter more and matter longer.

The inquiry reframed it more usefully partway through. The real distinction is not *soft versus hard*. It is between skills that **compound and transfer across every model** and techniques that **perish** as models change. That reframing is what makes this a Learn concern rather than a documentation concern: you cannot teach a perishable trick as capacity, and Learn exists to build capacity a person carries into their own life (`02-pillars/learn.md` §8).

**Grade: moderate.** The individual mechanisms below are well evidenced; the synthesis — that the durable stack is what determines outcomes with AI specifically — rests on a small and very recent literature. We build on it, and we are running the delayed probe partly because the field has not (§5).

## 2. What the research says — **moderate**

- One camp treats prompt engineering as a distinct teachable skill, and finds better prompts do produce measurably better output. Even its proponents concede the specific tricks are **perishable**: they decay as models improve.
- The deeper literature keeps returning to the human's cognitive habits — critical thinking, evaluating whether an answer is actually correct, confidence in one's own domain knowledge.
- The most consistent finding, and the one that governs the design: **the more a person simply trusts the AI, the less they think critically, and the worse their outcomes.** Over-trust was the single biggest predictor of a bad outcome across multiple studies.

**Synthesis.** Prompt tricks give a short-term bump and expire. Clarity, judgement and verification compound and transfer. Most "technical tricks" turn out to be **a durable skill wearing a temporary costume** — the costume perishes, the skill doesn't.

That sentence is the design rule. Where a technique is genuinely useful, we teach the skill underneath it and name the costume as perishable rather than pretending it doesn't exist. Two worked examples:

- **"Tell the model to ignore its memory."** The surface mechanic is technical and mildly perishable. The instinct underneath — noticing that stored context could bias a result and deliberately neutralising it — is bias control. It is **self-monitoring pointed outward at the tool**. The reflex transfers; only the button drifts.
- **"Token economy."** Context-window sizes, pricing and accounting all shift model to model. The transferable kernel is **economy of expression**: say the necessary thing and nothing more, front-load what matters. That is clarity with a cost function attached, and it was good writing advice long before there were tokens to count.

## 3. The six transferable skills

Ordered least to most complex, in three tiers.

| # | Skill | Tier | What it is |
|---|---|---|---|
| 1 | **Clarity of expression** | Foundational | Saying precisely what you want, with enough context |
| 2 | **Evidence-seeking** | Foundational | Asking for sources instead of accepting a confident answer |
| 3 | **Decomposition** | Intermediate | Breaking a messy problem into smaller checkable pieces |
| 4 | **Verification** | Intermediate | Checking whether an answer is right instead of trusting it |
| 5 | **Calibrated delegation** | Metacognitive | Knowing when the AI helps and when your own judgement should lead |
| 6 | **Self-monitoring** | Metacognitive | Tracking your own thinking and biases mid-conversation |

**Plan of action:** *teach* the durable stack; *build systematic structures* for the perishable technical material rather than teaching it as skill.

## 4. The two foundational skills, and why they need opposite pedagogies

Skills #1 and #2 were taken first. The asymmetry between them is the single most useful finding in the whole inquiry, and it is why the Skills Engine hosts two tools with genuinely different shapes rather than one tool with two topics:

> **Clarity is trained slowly, by revision. Evidence-seeking is trained fast, as a drilled reflex.**

### 4.1 Clarity of expression — **moderate to strong**

**Lineage.** Grice's cooperative principle and four maxims — quantity, quality, relation, manner (*Logic and Conversation*, 1975) — read almost as a specification for talking to a machine. Crucially Grice framed them as a *description* of how understanding works, **not a code of conduct**; so they are a set of listener expectations you learn to satisfy, never a rulebook to obey. Pinker's critique adds the decisive twist: human indirectness exists partly to preserve deniability and social face. **With an AI there is no face to save**, so the Gricean ideal applies more literally than it ever does between people — which is our licence to demand a bluntness that would be rude in conversation. Williams (*Style*) and Turabian supply the applied craft: readers perceive a sentence as clear when its grammatical subjects are the story's characters and its verbs are its actions.

**How it is taught.** By revision, not by first-draft rules. Skilled writers spend roughly half their time planning and revising; novices spend almost none. Explicit strategy instruction is the strongest single intervention (*d* ≈ 0.82); studying models alone is weak (*d* ≈ 0.25).

**Design implication.** Not "ten prompt tips". Give a real task, let the person write the unclear version, **let them see the gap between what they meant and what the reader received**, then revise. The maxims become a diagnostic for *why* an attempt failed — too little context is a quantity failure, a buried ask is a manner failure — applied after the fact, never as commandments.

### 4.2 Evidence-seeking — **strong**

**Lineage.** Wineburg and McGrew (2017) coined **lateral reading** by comparing professional fact-checkers, academic historians and college students on unfamiliar sources. The fact-checkers were both **faster and more accurate**, because they left the page almost immediately to see what other sources said instead of reading down it and judging it on its own terms. Caulfield turned this into the teachable **SIFT** method — Stop, Investigate the source, Find better coverage, Trace claims to the original. Recent (2026) work on **epistemic vigilance** argues this is precisely the skill governing AI collaboration: chasing a citation, carrying a claim to a textbook, and lateral reading are framed as the same act.

**The crucial pitfall, and it is counterintuitive.** Conventional media literacy was making people **worse**. It trained them to judge sources by surface features — how professional does this look — and by whether an argument "makes sense", which absent domain knowledge is barely different from asking whether something feels plausible. The other failure mode is telling people to verify every footnote: slow, and it keeps them trapped inside the source's own framing.

What works is not deeply analytical. It is a quick check to map unfamiliar terrain — the parachutist who has just landed should ask *where am I, what do the maps say*, not study the ground under their feet. Short drilled SIFT interventions measurably increase lateral reading and transfer.

**Design implication.** Teach a **fast reflex, not a deep audit**. Applied to AI: treat a confident model answer exactly like an unfamiliar website. Don't judge it on how fluent it sounds — go sideways and check it against something independent.

## 5. Measurement: the two skills demand opposite logics

### 5.1 Evidence-seeking — measure the behaviour, not the belief

**Self-report is nearly useless here.** There is a documented dissociation: what people say about their fact-checking reflects self-efficacy and attitude, not behaviour. Performance measures are necessary despite costing more.

The standard instrument gives a real claim and asks the person to judge trustworthiness *and show their work*, scoring two things separately: **(a) did they read laterally — leave the page**, and **(b) did they reach the correct judgement**. The conservative measure requires both. Baselines before instruction: ~12% read laterally on even one problem, rising to ~52% after; on the stricter lateral-**and**-accurate measure, ~9.5% → ~46.6%.

Two design details worth stealing: **parallel forms** (identical structure, different sources, counterbalanced) so before/after isn't contaminated by memory; and **screen recording**, the gold standard academics wish they could afford at scale — with a handful of known users it is entirely viable, because you can literally watch whether they open a new tab.

### 5.2 Clarity — measure the product, and fight the rater

There is no behaviour to catch, only an artifact to judge, so the entire problem becomes **scoring reliability**: can two raters, or one rater twice, agree.

**Analytic beats holistic.** Rating separate dimensions and summing places performance on a more clearly defined scale and tracks achievement more reliably. Scoring gets measurably more consistent when criteria describe **observable features** — "does the main ask appear in the first two sentences?" — instead of **general impressions** — "was this clear?".

**And a rubric alone does not fix reliability.** Even with one, rater agreement can be poor. Scorers must be calibrated first by independently rating shared samples and reconciling before real scoring begins.

### 5.3 The gap nobody has filled — **thin**

The delayed timepoint is where the research is weakest. Lateral-reading studies almost all stop at post-test; one states outright that whether gains are maintained is unknown. Where delayed retention *is* tested in adjacent learning research it is a genuine third stage — a delayed post-test about a week later, same items rewritten and reordered.

**So the before/after machinery is well validated for both skills, and almost nobody has data on whether either skill sticks.** Running a delayed probe does not only evaluate learners; it generates the evidence the literature is missing. That is a real reason to build the measurement properly rather than approximately, and it is the one place this work could contribute back.

## 6. What this licenses, and what it forbids

**Licenses.** Teaching bluntness that would be rude between people (§4.1). Drilling a reflex rather than explaining a principle, for evidence-seeking only (§4.2). Scoring a person's writing against fixed observable features (§5.2).

**Forbids.**
- **Teaching prompt tricks as skill.** They perish; teaching them as capacity is teaching a taxonomy to recite, which fails the Learn decision test.
- **Treating fluency as a signal.** The tool must never let a learner score well by judging how good an answer sounds.
- **Building a tool where the AI is always wrong.** A learner who becomes uniformly suspicious has not acquired the skill, they have acquired a different failure. Suspicion must cost the same as credulity, or the measure rewards the wrong thing.
- **Self-report as an outcome measure** for evidence-seeking. Collected for the dissociation display; never scored.
- **Streaks or daily-drill pressure on clarity.** Clarity is trained by revision at a weekly rhythm. Reaching for engagement mechanics here would also break the standing no-streaks refusal (`01-philosophy/02-anti-patterns-and-constraints.md`).

## 7. Where it is being built

As the **Skills Engine**, a Grow/Learn prototype hosted in Tracker (`02-pillars/learn.md` §7a). Two tools, one per foundational skill: **Clarity Lab** (#1) and **Evidence Lab** (#2). Specs and as-built state in `tracker/canon/06-specs/`. Skills #3–#6 are not scoped.

---

## Changelog

- **0.1 · 2026-08-01** — Written from the durable-skills inquiry. Records the compound-vs-perish reframing, the six-skill stack, the opposite pedagogies of the two foundational skills, the two opposite measurement logics, and the delayed-retention gap in the literature.

## References

- Grice, H.P. (1975). *Logic and Conversation.* Cooperative principle; four maxims.
- Pinker, S. (2007). *The Stuff of Thought.* Implicature and indirect speech.
- Williams, J. *Style*; Turabian, K. *A Student's Guide to Writing College Papers.*
- Wineburg, S. & McGrew, S. (2017/2019). Lateral reading; fact-checkers vs. historians vs. students.
- Caulfield, M. The SIFT method.
- Brodsky, Brooks, et al. (2021). Lateral-reading instruction; pre/post studies; self-report vs. performance dissociation.
- HKS Misinformation Review (2023). Lateral reading in a nutrition course; parallel-form pre/post design.
- Graham & Perin (2007). Writing-instruction meta-analysis.
- 2026 work on epistemic vigilance as the binding constraint on productive AI augmentation.
- Comparative studies on analytic vs. holistic writing rubrics and rater reliability.
