# Impact Act 1 — the spine feel-test

*An evaluation design for the one risk that no later milestone rescues: whether the noticing loop feels like **noticing** or like **filling in a form about a coworker** (`01-noticing-spec.md` §10, milestone 3). Instruments, protocol, and the decision rule — written before the data, so an ambiguous result can't be read as a pass. Living layer. Update the changelog; don't fork.*

**Version 0.1 · Status: evaluation design · 2026-09-20 · Owner: _root**

---

## 1. The risk, stated precisely enough to measure

The spine can fail in two ways that **produce identical usage logs**, which is why usage data cannot be the evaluation.

**Failure A — the form.** The loop completes fine and feels like admin. The person fills the fields because the fields are there, the practice never becomes a way of looking, and use decays. This is the well-documented self-tracking abandonment path: the personal-informatics literature finds people stop for reasons that have little to do with whether the tool worked, and food-journaling work names the specific mechanism — barriers to reliable entry, and *negative nudges caused by the entry technique itself.* A tool whose entry technique makes you feel bad about the gaps is the shape we must not build.

**Failure B — instrumentalization.** The loop engages fine, and the person begins treating the people around them as **material for their practice**. This one is worse, because in every usage metric it **looks like success**: more entries, richer text, more offers. It is also the failure the pillar canon names first (`impact.md` §8 — instrumentalizing service is off-pillar) and the one the guardrails alone cannot prove absent.

Both are *felt* failures. Both produce a log of completed entries. So the evaluation has to reach the feel, at a sample size of a handful, without a control group, and without the counting the module structurally refuses.

**This is a feel-test, not a trial.** It cannot establish efficacy and does not try to. It is designed to answer one question — *is the spine the thing we think it is* — early enough that the answer can still change the build.

## 2. The four instruments

Two weeks, the founder plus 2–4 testers, daily-ish use.

### A. In-session — **retrospective** think-aloud *(carries the most load)*

After a sitting, replay the screens and have the person narrate what they were doing at each step. **Retrospective, not concurrent, and the reason is the construct:** the meta-analytic review of concurrent vs. retrospective think-aloud (29 studies, 42 comparisons) finds comparable problem detection but by different routes — concurrent detects more by observation, retrospective more by verbalization — and concurrent verbalizing **degrades task performance, especially at high task complexity.** The spine is a three-minute introspective act; thinking aloud *while* recalling a person would destroy exactly the thing under test. Retrospective costs some reactivity (participants report the retrospective setup as somewhat more disturbing) and buys more explanations, problem formulations and design suggestions — the right trade here.

**Run at day 1, day 4, day 10.** The coding target is one distinction:

> Is the person **recalling a person**, or **composing an entry**?

Composing sounds like: asking what the field wants, editing for the tool, picking the person who'll make the best entry, scanning the palette before having a thought. Recalling sounds like: pausing, correcting themselves, saying something they didn't expect to say.

### B. Post-sitting self-report — the form/chore axis

Two short instruments, on three sittings (day 2, day 7, day 13). Neither is decisive; they are the cheap read that says where to look.

- **AttrakDiff** — its whole point is separating **pragmatic quality** (efficient, effective, manipulable) from **hedonic quality** (stimulation, identity) and attractiveness. That split *is* our axis: **a form scores high pragmatic and low hedonic-stimulation.** The pattern to fear is "it works fine" with nothing else.
- **IMI**, two subscales only — **interest/enjoyment** (the literature's self-report measure of intrinsic motivation) and **pressure/tension** (theorized and used as a *negative* predictor of it). Pressure/tension is the most direct read available on "this feels like homework." Use the short-form items; skip perceived competence, which measures the wrong thing here.

### C. The instrumentalization check *(failure B, which has no usage signal)*

Two reads, deliberately unequal:

- **A tripwire, not an outcome: the Interpersonal Objectification Scale** (8 items; built on Nussbaum's features — instrumentality, fungibility, denial of subjectivity and agency; validated across six studies, N > 2,500, converging with narcissism/Machiavellianism/psychopathy and inversely with empathy). Pre and post. It is **dispositional**, so two weeks should move it not at all — **a null is the expected and desired result**, and a non-null is a loud alarm rather than a finding.
- **The read that will actually catch it: one interview question**, week 2 — *"Tell me about someone who's turned up in your entries."* Coded for whether they talk about **the person** or about **the entry**. If the answer is a description of a record rather than of a human being, the person step needs rebuilding regardless of what any questionnaire says.

### D. Transfer — did anything get seen outside the tool *(the real target)*

Use the **Day Reconstruction Method**, not experience sampling. DRM reconstructs the previous day as a sequence of episodes; it carries **lower respondent burden than ESM, gives more complete coverage of the day, is less prone to retrospective bias than global recall, and its reports correspond closely to established ESM results** (Kahneman et al., 2004). Two additional reasons it is right *here*: ESM pings would be intrusive at this sample size, and — decisively — **pinging someone to think about noticing is itself an intervention.** ESM would confound the thing it measures.

**One DRM day at baseline (before the frame), one in week 2.** Episodes are coded for a single thing: **does another person's state appear at all?** Not whether they helped — whether anyone else was *seen*.

*Optional descriptive anchor:* the **Interpersonal Mindfulness Scale** (27 items, or the 13-item short form), whose *presence* and *awareness of self and others* subscales are the closest published construct to what the spine trains. Caveat stated up front: its test–retest is reported as acceptable over **one month**, so a two-week window on a trait-ish measure is underpowered. Descriptive only. Never the verdict.

## 3. The decision rule (written before the data)

| Result | Reading | What we do |
|---|---|---|
| IMI pressure/tension high **and** AttrakDiff hedonic-stimulation low across testers, **and** think-aloud shows composing rather than recalling | **It's a form.** | Stop and rebuild the spine before milestones 4–8. This is the milestone-3 gate. |
| The week-2 interview answer describes entries rather than people | **Instrumentalization.** | Rebuild the person step (and re-examine whether the tool should hold a person at all, or only a moment). |
| IOS moves at all | Alarm | Stop, and treat it as a design defect, not a tester trait. |
| DRM shows any unprompted episode in week 2 where another person's state is recalled, even with flat questionnaires | **Transfer, which is the actual claim.** | Proceed. The pre-registered null (`01-noticing-spec.md` §12) already says downstream change isn't Act 1's job. |
| Questionnaires flat, think-aloud mixed, DRM unchanged | **Ambiguous — and this is the most likely outcome.** | Named here so it can't be read as a pass. The response is a second two-week round with one variable changed, not a decision to ship. |

## 4. Cost

| Instrument | Per tester | When |
|---|---|---|
| A · retrospective think-aloud | 3 × ~20 min | days 1, 4, 10 |
| B · AttrakDiff + IMI (2 subscales) | 3 × ~4 min | days 2, 7, 13 |
| C · IOS pre/post + one interview question | ~6 min + ~15 min | day 0, day 14 |
| D · DRM | 2 × ~25 min | day 0, day 12 |

~2.5 hours per tester over two weeks, most of it in A and D — which is where it should be.

## 5. What this can't do, said plainly

- **The founder is not a naive tester**, and self-report about a tool you want to work is the weakest data in the set. This is the reason A and D carry the load and B is advisory.
- **Social desirability is at its maximum here.** "Do you look after the people around you" is the most desirability-loaded question in the whole ecosystem; anything self-reported about caring is suspect by construction. B and C are weak for exactly this reason; the think-aloud and the DRM coding are behavioural-ish and are what the decision rule leans on.
- **N is a handful, there is no control group, and two weeks is short** for anything trait-shaped.
- **It does not measure whether anyone was helped.** Out of scope by design: Impact recognizes, Organize executes (`impact.md` §4).

---

## Sources

Concurrent vs. retrospective think-aloud, meta-analytic review (29 studies, 42 comparisons), *ACM TOCHI* · Van den Haak et al., retrospective vs. concurrent think-aloud reactivity · Hassenzahl, AttrakDiff (pragmatic / hedonic-identity / hedonic-stimulation / attractiveness) · Intrinsic Motivation Inventory, interest-enjoyment and pressure-tension subscales (selfdeterminationtheory.org) · The Interpersonal Objectification Scale (8 items, Nussbaum-derived; six studies, N > 2,500) · Kahneman et al. (2004), *A Survey Method for Characterizing Daily Life Experience: The Day Reconstruction Method*, *Science* · Pratscher et al., Interpersonal Mindfulness Scale (27-item; 13-item short form) · Epstein et al., *Beyond Abandonment to Next Steps*, CHI 2016, and the lived-informatics model of personal informatics.

---

## Changelog

- **0.1 · 2026-09-20** — Initial evaluation design for the milestone-3 risk: the two failure shapes that produce identical logs, four instruments (retrospective think-aloud, AttrakDiff + IMI, IOS tripwire + one interview question, DRM for transfer), a decision rule written before the data with the ambiguous outcome named, cost, and the limits — chiefly that social desirability is at its maximum on this topic, so the self-report instruments are advisory and the behavioural ones decide.
