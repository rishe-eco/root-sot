# Root · ریشه — Pillar: Learn
*Source of truth. Short on purpose. Concept + first module. Update the changelog; don't fork.*

**Version 0.4 (draft) · 2026-08-11 · Owner: _root**

---

## 1. Purpose

Learn is where a person builds capacity on purpose. The general shape: choose a skill, evaluate where you are, set an endpoint and an intensity for a period, follow a pathway, track progress, and evaluate at points along the way. Learn is fed by every other pillar (a gap surfaces in Reflect, Maintain, Organize, or Others) and returns capacity to Organize, where the new ability makes new action possible.

## 2. First module — Emotion & Need Language Building

The founding module, and the on-ramp to Reflect. Design principles, all grounded (see `04-research/`):

- **One coupled module, not two tracks.** Feelings and needs are two ends of one mechanism — a feeling is the signal, the need is what it signals about. Teaching feelings alone trains reading a gauge without knowing what it measures.
- **Mindset before vocabulary; A before B.** First the frame (emotions are workable signals about needs, not verdicts). Then competence A (vocabulary), then competence B (distinctions: feeling-vs-thought, need-vs-strategy) — B is a refinement layer on top of A, never the opening move.
- **A spiral, not a ladder.** The bare loop never retires. Distinctions and storytelling grow *on top of it, inside the same practice.* "How long do I repeat this" dissolves: repetition *is* the training, not a toll paid to advance.

## 3. The three tiers

1. **Day one — the frame, felt not told (~6 min, once).** Recall a moment you felt "off"; find it in the body; try a few words on; notice that naming gave you a handle though nothing else changed. The malleability belief is *experienced*, not asserted.
2. **The bare loop (~3 min, daily-ish, the permanent spine).** Breath → *where/what texture in the body?* (interoception on-ramp, keeps attention off the "why am I like this" spiral) → reach for a word, try it on (small palette, weighted to pleasant/met-need early) → *if this points at something you care about, what?* (need offered, never forced) → *anything small this makes you want to do or ask for?* (optional — the seam into Reflect).
3. **Distinctions, surfaced in-context (~week 2, many distributed touches).** When the person types a faux-feeling ("ignored"), the app gently catches it: that's more a read on what someone did — underneath, the feeling (hurt? lonely?) and the need (to matter? to be included?). Taught by contrast on the person's own live material (variation theory), never as a standalone drill.
4. **Storytelling (~week 3–4, 10–15 min, weekly-ish).** Take a whole moment apart: observation → first/loudest feeling → what's underneath → the needs in play (often plural, sometimes in conflict) → what it clarifies. This *is* a guided journal entry — so it's not "graduating to Reflect," it's walking through a door you're already standing in.

All numeric thresholds ("7–10 loops," "week 3") are **dials for the evaluation-and-settings layer** to tune per user. For the prototype, hardcode them.

**Why storytelling is the load-bearing bridge to Reflect (refined 2026-07-22).** The bet under the Learn→Reflect ordering is *not* "writing things down helps" — expressive writing's average effect is small. The active lever is **reconstrual / self-distancing**: taking the moment apart and re-seeing it (Kross & Ayduk). Storytelling is designed to *do* that reconstrual, which is why it graduates cleanly into Reflect. This is tracked in discovery as **H6b** (writing alone isn't enough; reconstrual is the lever), split out from the softer **H6a** (in-head reflection tends to spiral). If H6b fails to confirm, it implicates the eventual Learn→Reflect **ordering** — but that is an **integration-phase decision (deferred), not a gate on building Learn standalone now** (decision log, 2026-07-23). This module is built and shipped on its own regardless; H6b informs how its storytelling tier is designed to fit Reflect *later*. See `reflect.md` §6 and `04-research/00-evidence-summary.md` §5.

## 4. The bilingual constraint (non-negotiable)

Affect labeling in a **non-native** language does not down-regulate emotion — the regulation effect requires the dominant emotional language. Therefore the feelings/needs work is **Persian-first for Persian users**; the English layer is translation/bridge, never the primary medium. This is a design constraint, not a preference, and it is one of the deepest reasons Root is Persian-first (Brand §2).

*Build-order nuance (2026-07-22):* Persian-first is the **product** constraint, for the shipped experience with Persian users. The **current discovery and team prototype are English-only** on purpose — the three known test users are English-speaking, so the first interviews and the first build run in English. This is the same team-vs-product language split noted in `03-engine/03-onboarding.md` §3; it is not a contradiction of the Persian-first rule, which governs the product, not the discovery scaffolding.

## 5. Guardrails

- **Naming is not analyzing.** The loop must keep moving (notice → name → need → small thing); parking in "why do I always feel this" is rumination, the opposite of the regulating move.
- **Don't oversell vocabulary size.** The payoff is *granularity built in context* + a malleability mindset, not word-count (the two are distinct constructs).

## 6. Prototype scope (for the team to feel the pillar)

Three screens convey the whole thing: the Day-1 frame moment, one bare loop, one loop where a distinction surfaces. Storytelling can be a described mockup for v0. This transmits the feel — short, body-first, in-your-own-words, always moving toward a need, teaching by gentle catch rather than quiz.

## 7. The natural sequel

**Reality-check-and-biases** is the literal next module: it operates on the exact object this module teaches people to notice — "interpretations about what others did" (the faux-feelings). Once you can see an interpretation *as* an interpretation, examining it is the next discipline. It also feeds back into Reflect's reality-check move.

## 7a. Second module built — the Skills Engine (working with AI)

*Added 2026-08-01. Concept and evidence base: `../04-research/02-durable-ai-skills.md`. Specs and as-built state: `tracker/canon/06-specs/`.*

The second Learn module to reach code, and it arrived out of the planned order — it is not the Reality-check sequel (§7) but a separate skill family that became urgent. **It is hosted in Tracker as a prototype while remaining conceptually Learn's**, the same arrangement as the Organize prototype (`tracker/canon/04-roadmap/00-state-of-the-build.md`).

**What it teaches.** The skills that decide whether working with an AI helps a person or harms them. The founding distinction is not soft-versus-hard but **compounds-versus-perishes**: prompt tricks give a short-term bump and expire as models change, while clarity, judgement and verification transfer across every model. Most "technical tricks" turn out to be a durable skill wearing a temporary costume. Two tools exist, one per foundational skill — **Clarity Lab** (saying precisely what you want) and **Evidence Lab** (checking a confident answer against something independent).

**A third tool is specced and unbuilt** (2026-08-11): **Decomposition Lab** (#3 — breaking a messy problem into checkable pieces), with wireframes and a build plan alongside it. Two things about it matter to the pillar beyond the skill. It answers §9's module-runner question. And it is the first module whose dominant risk is not over-trust but **offloading** — a model produces a plausible breakdown instantly, so the tool has to refuse to offer one, which makes its central guard an *absence*. Absences are harder to keep than features: nobody notices when one is removed.

**Why it belongs to Learn rather than to documentation.** A perishable trick cannot be taught as capacity. This module builds something a person carries into their own life and keeps when the tools change — the pillar's decision test (§8) rather than an incidental fit.

**The design fact worth carrying to every future module.** The two skills need **opposite pedagogies**, and discovering that shaped the build:

- **Clarity is trained slowly, by revision** — a weekly sitting of 8–15 minutes producing one artifact and a rewrite of it. Explicit strategy instruction is the strong intervention; studying models alone is weak.
- **Evidence-seeking is trained fast, as a drilled reflex** — about a minute per item, many repetitions. Here a deep audit is actively the wrong shape: slow, and it keeps the learner inside the source's own framing.

A single "lesson" container would therefore have been wrong for one of them whichever shape it took. **Pedagogy is a property of the skill, not of the platform** — the strongest argument yet against a generic module runner, and the first thing to check for any module after this one.

**Two inherited constraints bite hard here.** *Persian-first* is not translation: Clarity's referent and economy drills turn on English-specific faults (bare demonstratives, Latinate nominalisation) that are simply not the Persian failure modes, so the Persian drills are **authored, not translated** — pro-drop, *ezāfe* chains and اسم‌مصدر are different problems (§4 applies to more than affect vocabulary). And *no streaks*: an expanding review queue is the only recurring pressure, and Clarity deliberately refuses a daily rhythm because that shape would train the wrong thing.

**One refusal specific to this module.** A tool where the AI is always wrong would teach uniform suspicion and call it vigilance. Flagging a correct answer must cost exactly what missing a false one costs, so roughly a third of all items are deliberately accurate and the headline measure is **discrimination** — faults caught minus true claims wrongly flagged — never catch-rate alone.

## 8. Decision test

Does the module build *real capacity the person can carry into their own life*, in their own emotional language, by doing — or does it teach a taxonomy to recite? The second is off-pillar.

## 9. Open questions

- Pathway recommendation logic (how a learning path is proposed) — undetermined.
- Integration vs. separation of module delivery (learned-through-Reflect-interaction vs. structured module) — a discovery question.
- Module set beyond the first two; per-module evaluation design.
- ~~**Does a generic module runner survive contact with a third module?**~~ **Answered 2026-08-11 by speccing skill #3** (`tracker/canon/06-specs/03-decomposition-lab.md` §2). It does not survive as a *generic* runner — and per-tool duplication isn't the alternative either. The third module needs **both existing shapes at once**: four of its six modules are Clarity-shaped (a 10–15 minute sitting authoring and revising one artifact), two are Evidence-shaped (a ~2 minute drill on one seeded fault). So the sharper form of the §7a finding is that **pedagogy belongs to the *step*, not to the tool** — which argues for a composable step library, where the seven-step template selects a per-step implementation, and against both a single lesson container and three parallel bespoke builds. Three data points now, and the third is the one that discriminates between the two answers the first two couldn't separate.

---

## Changelog

- **0.4 · 2026-08-11** — §7a notes the third Skills Engine tool, **Decomposition Lab** (#3), specced and unbuilt, and names offloading rather than over-trust as its dominant risk. §9's module-runner question is **answered**: the third module needs both existing session shapes at once, so pedagogy belongs to the *step* rather than the tool — a composable step library, not a generic runner and not per-tool duplication.
- **0.3 · 2026-08-01** — Added §7a: the Skills Engine, Learn's second built module, hosted in Tracker. Records the compounds-vs-perishes framing, the opposite-pedagogies finding and what it implies for a module runner, the authored-not-translated consequence of Persian-first, and the discrimination-not-catch-rate refusal.

- **0.1 · 2026-07-14** — Initial draft, from the emotion/need module design. Spiral (not ladder) model, three tiers, Persian-first affect-labeling constraint, guardrails, prototype scope, reality-check sequel.
- **0.2 · 2026-07-22** — Added the build-order nuance (§4: discovery/prototype English-only for now; Persian-first stays the product constraint). Added the refined Learn→Reflect bridge rationale: reconstrual/self-distancing (Kross & Ayduk) is the load-bearing lever, tracked as H6b vs. H6a — from the 22 Jul feelings-&-needs session. Concept, tiers, and scope otherwise unchanged.
- **0.2 (rev) · 2026-07-23** — Clarified §3: H6b is a **deferred integration/ordering input, not a build gate** — Learn is built and shipped standalone regardless (per the development model recorded in the decision log). No change to the module concept.
