# Tracker — Clarity Lab (skill tool #1)

*The tool that trains clarity of expression — saying precisely what you want, with enough context — and measures it with an observable-feature rubric. Runs on `00-skills-engine.md`. Content, scoring and the session service are **as-built**; the interface (§8) is still spec. Phasing and the credential Phase 4 needs are in `01a-clarity-lab-build-plan.md`. Update the changelog; don't fork.*

**Version 0.3 · Status: spec, except §4–§7 as-built · 2026-08-01 · Owner: _root**

---

## 1. The skill, and what the tool is actually training

Clarity of expression is skill #1 in the durable stack: foundational, never expires, and the thing most "prompt engineering" advice is a temporary costume for. Its research lineage is not prompt guidance at all:

- **Grice (1975)** — the cooperative principle and four maxims: *quantity* (say enough, no more), *quality* (don't assert what you can't back), *relation* (be relevant), *manner* (be orderly, avoid ambiguity). Crucially, Grice framed these as a description of how understanding works, **not a rulebook** — so in this tool the maxims never appear as commandments. They appear as a **diagnostic vocabulary for why an attempt failed**: too little context is a *quantity* failure; a buried ask is a *manner* failure.
- **Pinker's** point that human indirectness exists to preserve deniability and social face — none of which applies to a machine. With an AI there is no face to save, so the Gricean ideal applies more literally than it ever does between people. This is the tool's licence to demand bluntness that would be rude between humans.
- **Williams (*Style*) and Turabian** — readers perceive a sentence as clear when its grammatical **subjects are the story's characters** and its **verbs are the actions**. This is the one place the tool teaches sentence craft, and it's the highest-yield one.

**Pedagogy: clarity is trained slowly, by revision.** Skilled writers spend roughly half their time planning and revising; novices spend almost none. The evidence ranks the ingredients clearly — explicit strategy instruction is the strongest single intervention (*d* ≈ 0.82), studying models alone is weak (*d* ≈ 0.25). So: teach a strategy explicitly, use models only as contrast, and make **revision the centre of gravity**. The tool's core loop is not "write a good prompt." It is:

> **write it → see what the reader actually received → diagnose the gap with the maxims → revise → see the difference.**

**The central mechanic: the gap reveal.** Before seeing anything, the learner predicts what the reader will produce from their text. Then the reader's actual output is shown. The distance between prediction and reality is the lesson, and it is the tool's cognitive forcing function — commit first, then be shown. This is the curse of knowledge made visible: the learner's text was perfectly clear *to the learner*, and no amount of rubric text teaches that as fast as one honest misread does.

## 2. Session economy

Few, long sessions. A module is one sitting of **8–15 minutes** producing one artifact and at least one revision of it. Weekly rhythm expected, not daily. If Clarity Lab starts feeling like a daily drill, it has drifted into Evidence Lab's shape and stopped training the thing.

## 3. Modules

Six, ordered by the engine's recommendation from the baseline. Each maps to the rubric criterion it trains (§4) — a deliberate 1:1 so feedback, module, and score share one vocabulary.

| Key | Module | Trains | Gricean diagnosis | Rubric criterion |
|---|---|---|---|---|
| `c1-ask` | **Lead with the ask** | One primary request, stated first, as a request | Manner (order) | R1 |
| `c2-deliverable` | **Name the deliverable** | What form the output takes: kind, format, length, scope, and what's out of scope | Manner / Quantity | R2 |
| `c3-context` | **Enough context, no more** | A context inventory — inputs, constraints, audience, prior attempts, what's already been ruled out — and the discipline of omitting the rest | Quantity | R3 |
| `c4-referents` | **Nothing dangling** | Unbound *it / this / that / the file*, vague quantifiers ("a few", "better", "soon"), undefined domain terms | Manner (ambiguity) | R4 |
| `c5-done` | **Say what done looks like** | Explicit, checkable success criteria; how the result will be judged; what would make it wrong | Quality / Relation | R5 |
| `c6-economy` | **Characters, actions, and cutting** | Williams's subjects-as-characters and verbs-as-actions; nominalization repair; front-load the load-bearing constraint; delete any sentence that adds no constraint | Manner + the durable kernel of "token economy" | R6 |

Notes on two of them:

- **`c5-done` is the bridge to Tracker's own Clarity Check.** *Observability* and *Binary Clarity* (`01-product/02-clarity-check.md`) are the same move at goal scale that R5 is at sentence scale. Cross-link both ways; a learner who has done `c5-done` should be offered a real Goal DoD as their next practice artifact.
- **`c6-economy` is where the "token economy" technique is deliberately dissolved into a durable skill.** The module never teaches context-window sizes, token counts, or pricing — those perish. It teaches: say the necessary thing and nothing more, and front-load what matters. One optional aside names the perishable version and explains why it isn't taught.

**Optional extension modules (P2, not in the core six):** *Standing down memory and personalization* — the surface mechanic is perishable, but the instinct underneath (noticing that stored context could bias a result, and neutralizing it deliberately) is self-monitoring pointed outward at the tool. It belongs in a later tool for skill #6, and is stubbed here only so the seam exists.

## 4. The instrument: observable-feature clarity rubric v1

Analytic, not holistic — analytic rubrics place performance on a more clearly defined scale and track achievement more reliably. Six criteria, which is the top of the 4–6 band where marking stays consistent. Every level descriptor is a **decision rule about an observable feature**, never an impression: "was this clear?" is unscoreable; "does the primary ask appear in the first two sentences?" is not.

Scale per criterion: **0 = absent · 1 = partial · 2 = present.** Total **0–12**.

| # | Criterion | 0 | 1 | 2 |
|---|---|---|---|---|
| **R1** | **Ask placement & singularity** | No identifiable request, or the reader must infer it | Request present but after sentence 2, or two or more co-equal asks with no priority | Exactly one primary request, identifiable in the first two sentences, phrased as a request |
| **R2** | **Deliverable specification** | Output form unstated | Kind named ("a summary") but no format, length, or scope bound | Kind + at least two of {format, length, scope, structure}, and states at least one thing that is out of scope |
| **R3** | **Necessary context supplied** | None of the applicable context slots filled | Some filled; at least one slot the task demonstrably needs is missing | Every context slot the item's key marks as *required* is filled, with no more than one slot of unrequired material |
| **R4** | **Referent resolution** | Two or more unbound referents or undefined terms | Exactly one unbound referent or vague quantifier | No unbound pronouns/deictics; all domain terms defined or unambiguous in context; quantifiers are numeric or bounded |
| **R5** | **Success criteria** | No statement of how the result will be judged | Criteria stated but not checkable ("make it good", "clear and useful") | At least one criterion a third party could apply to the output and get a yes/no; or an explicit statement of what would make the answer wrong |
| **R6** | **Economy & order** | Load-bearing constraint appears last or is buried in a subordinate clause; ≥2 sentences add no constraint | One of those faults | Load-bearing constraint in the first third; every sentence adds a constraint, an input, or a criterion; subjects are the actors and verbs are the actions |

**Void flag** (scored separately, not part of the total): off-task, empty, or a response that only restates the prompt. A void response is never averaged in as a zero.

**Scoring split by source** (engine §7):

| Criterion | Detector (deterministic) | Judge (LLM) |
|---|---|---|
| R1 | Sentence index of the imperative/interrogative; count of co-equal asks | Confirms which ask is primary when two compete |
| R2 | Presence of format/length/scope tokens | Whether the named deliverable actually matches the task |
| R3 | — | Full: which slots are required is item-key-driven, matched against the text |
| R4 | Unbound pronoun and vague-quantifier detection (high precision, `en`) | Undefined domain terms |
| R5 | — | Full: checkability is a judgement |
| R6 | Sentence-to-constraint ratio; position of the item's key constraint; nominalization density | Characters-and-actions alignment |

R1, R4, and R6 therefore survive intact in **no-AI mode**; R2, R3 and R5 are reported as **unscored** and removed from both numerator and denominator — averaging in a zero would tell a learner they failed at something nobody assessed. The UI shows `6/6 (3 of 6 criteria)`, never a silently weakened `6/12`.

**Mastery is deliberately unreachable in no-AI mode.** The three unscored criteria are context and success criteria — half the skill. Redefining mastery down to whatever happens to be measurable would hand out mastery of a skill nobody assessed, so the bar stays where it is and the tool says why.

**The detector–judge relationship, settled during implementation: the detector is a ceiling and the judge may only lower it.** For the three criteria both can see, the final level is `min(detector, judge)`. This resolves the tension between "R1/R4/R6 survive in no-AI mode" (so a detector must be able to award a level) and "no criterion reaches level 2 on surface features alone" (so a detector must not be the last word). A detector can prove an observable feature is *absent*; it can never prove that a text ticking every box actually communicates. Hence: detector caps, judge deducts, never the reverse — which is also what makes writing-to-the-detector top out rather than pay off.

**Persian: route R4 and R6 to the judge rather than building Persian detectors.** The `en` detectors for those two criteria do not port — Persian is pro-drop, so "unbound pronoun" is a different question entirely; *ezāfe* chains and اسم‌مصدر nominalization need their own analysis; and R6's front-loading test interacts with word order. Building a Persian morphological analyser to serve two rubric criteria is not a good trade. The judge handles Persian well, and determinism is preserved by the score cache (identical submission → identical cached score), so the loss is reproducibility-of-method, not reproducibility-of-result. This raises the stakes on the `fa` calibration gate — with more criteria depending on the judge, Persian needs its native-rater anchor set *more* than English does, not less (engine §7). R1's ask-position check is largely language-neutral and stays a detector in both locales. Record `scoredBy` per criterion so the `fa` and `en` scoring paths are visible in the data rather than assumed equivalent.

**Rubric versioning:** `rubricVersion` is stamped on every attempt; totals from different rubric versions are never charted on one line (engine §6). Any change to a level descriptor is a version bump and triggers judge re-calibration.

## 5. Item types

1. **Elicitation task** — a realistic scenario with a hidden context sheet (facts only the learner "knows"). The learner writes the request. The rubric key marks which context slots were required. *This is the primary item type and the baseline/post/delayed instrument.*
2. **Revision task** — a supplied weak text plus the reader's misread. The learner diagnoses (tags the failing criteria) and rewrites. Scored on the revision total **and** on diagnosis accuracy against the key — naming *why* it failed is the transferable half.
3. **Contrast pair** (step 2 only, unscored) — a strong and weak text with the difference annotated.
4. **Repair drill** (`c4`, `c6`) — a single sentence with one seeded fault; fix it. Short, detector-scorable, the one place Clarity Lab allows a fast item.
5. **Real-work artifact** (open practice only) — the learner's own prompt, Goal DoD, or Project description. Never scored into mastery or probes.

## 6. Metrics

Beyond the rubric total:

- **Revision delta** — (revision total − draft total). The learning signal *is* the delta at first; the win condition is the delta **shrinking over time** because the draft has gotten better. A tool that only ever shows a rising total is measuring the wrong thing.
- **Per-criterion trend** — six lines. This is what makes the analytic rubric worth its cost: it says *which* thing improved.
- **Prediction accuracy** on the gap reveal — how well the learner anticipates the misread. This is the closest available proxy for audience awareness, and it should rise before the rubric total does.
- **Diagnosis accuracy** — on revision items, agreement between the learner's tagged failing criteria and the key.
- **Time-to-first-draft and revision count** — descriptive only, never scored. (Novices don't revise; if revision count rises, something real is happening.)

## 7. Mastery criterion

A module is **mastered** when, on two consecutive unscaffolded items across two distinct calendar days, the learner scores **≥ 10/12 total with no criterion at 0, and level 2 on that module's own criterion.** The module-specific clause matters — a globally strong writer could otherwise coast to mastery on `c4` while still leaving referents dangling.

**Tested out:** the baseline showed level 2 on that criterion across both elicitation items.

## 8. Interface requirements

- **Artifact editor** — plain textarea, no autocomplete, no AI assistance, no suggestions while writing. The tool trains the learner's composition, and a helper in the box would train nothing. (This is worth stating as a rule because it will feel like an obvious feature to add later.)
- **Gap reveal** — three panes: what the learner wrote, what they predicted the reader would produce, what the reader produced. Prediction is committed before reveal and is not editable afterward.
- **Feedback view** — per-criterion, each with the level and the **quote from the learner's own text** that justified it (engine §7 requires the judge to produce it). Aggregate number is shown last, not first.
- **Diagnose step** — the learner tags failing criteria *before* the scores are shown. Their tags versus the actual scores is itself a display.
- **The rubric is always visible.** It is the teaching object, not a hidden grading scheme. Learners writing toward six observable features is the intended behavior; the guard against gaming is that no criterion reaches level 2 on surface features alone (§4) and that real-work practice has a real reader.
- Progress: six criterion lines, revision-delta chart, baseline/post/delayed markers with version breaks, "no baseline" state if the assessment was skipped.
- i18n: interface strings **and content** in `en` + `fa` at launch (engine §5.1). Scope note for this tool: **R1, R2, R3, and R5 are structural and transfer nearly unchanged; R4 and R6 need genuine Persian-specific work**, not translation — R4 because pro-drop changes what a dangling referent is, R6 because characters-and-actions guidance has to be rewritten around Persian syntax and *ezāfe*. Budget the Persian linguistic effort against those two criteria and the module copy that teaches them. Item specs (required-context slots, seeded faults, difficulty) are locale-invariant; only the surface text is realized twice. RTL passes on the artifact editor, the gap-reveal panes, and the rubric display ship with the `fa` surface.

## 9. Assessment / probe form spec

**Baseline (form A), post (B), delayed (C)** — identical structure, matched item-for-item on domain and difficulty, order counterbalanced:

- 2 × elicitation task (one technical scenario, one interpersonal/organizational scenario) — the scored core, ~4 min each
- 1 × revision task — scored on revision total + diagnosis accuracy, ~3 min
- 1 × repair drill set (4 sentences, one fault each) — detector-scored, ~2 min
- 4 × self-efficacy items — collected, never scored (engine §6)

Total ~12 minutes. Composite = summed rubric totals (0–24 across the two elicitation tasks) reported alongside per-criterion profiles; the repair set and revision task report separately rather than being folded into one number.

## 10. Acceptance criteria

- Baseline → six modules → post → 7-day delayed probe completes with every attempt version-stamped and every draft→revision pair linked (`revisionOfAttemptId`).
- No rubric key, answer key, or scoring hint appears in any client payload (asserted by test).
- Judge calibration gate passed per criterion before any judge-scored criterion contributes to a probe total; criteria below target run feedback-only and are visibly marked.
- Identical submission re-scored returns the identical cached score.
- Detector unit tests: R1 ask-position, R4 unbound-referent, R6 constraint-ratio against fixture sets with known answers. Mastery and review-scheduling services unit-tested. Thin I/O glue components untested by design (`03-engineering/01-testing.md`).
- No-AI mode completes a full module with R1/R4/R6 scored and R2/R3/R5 in self-diagnosis, with the limitation stated in-UI.
- Judge prompts are structured with the rubric + anchors in the cached prefix and the criterion + submission after the breakpoint; `usage.cache_read_input_tokens` is non-zero on the second and later criteria of an attempt (engine §7). A persistent zero fails the check.
- Content-pack validator passes locale parity: every `itemId` present in both surfaces with identical specs.
- All interface strings **and both content surfaces** present in `en` and `fa`.

---

## Changelog

- **0.3 · 2026-08-01** — Phases 1–2 built (**D-18**, **D-19**). Content: 17 practice items added, three offline-capable per module, general-audience. Session service and GraphQL: the two locks are `SkillCheckEvent` rows, a revision is a linked attempt row, elicitation is withheld without a reader. §8 (interface) remains spec; wireframe set drawn 2026-08-01.
- **0.2 · 2026-07-26** — Persian content required at launch: linguistic scope narrowed to rubric criteria R4 and R6, with `fa` R4/R6 routed to the judge rather than building Persian detectors. Judge prompt-caching structure added to acceptance.
- **0.1 · 2026-07-26** — Initial spec. Rubric v1 drafted as the "observable-feature clarity rubric" named as a next step in the source brief. Lineage: Grice 1975; Pinker 2007; Williams *Style*; Graham & Perin 2007 meta-analysis; analytic-vs-holistic rubric reliability literature.
