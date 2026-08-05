# Learn Module 1 — Demo Development Plan

*The plan to build a **fully-working, not-yet-user-tested** version of the Feelings & Needs module: what's in scope, where it's built, the screen/flow spec, the content to author, the data model, and the build order. "Demo" here = every surface the user touches actually works; it simply hasn't been validated with real users or data yet. Living layer. Update the changelog; don't fork.*

**Version 0.6 · Status: working (living) · 2026-08-05 · Owner: _root**

**Anchors:** `../../canon/02-pillars/learn.md` (the pillar), `../learn-mechanisms/00-module1-process-anatomy.md` (the mechanisms — this plan is its build-side counterpart), `../Learn feels and needs discovery.md` (outcomes & graduation), `../../canon/04-research/00-evidence-summary.md` §5 (evidence), `../../decisions/decision-log.md` (the three settled decisions below), `../../../tracker/canon/06-specs/00-skills-engine.md` (the sibling-tool build pattern to reuse).

---

## 1. The three decisions this plan is built on (settled 2026-08-01)

| Decision | Ruling | Consequence for the build |
|---|---|---|
| **Where** | Build as a **tool inside Tracker** now; migrate to Learn's **standalone app** later. | Reuse Tracker's stack, auth, data layer, i18n scaffolding. No new app. Namespaced as a tool, like the skills tools. |
| **LLM** | **Not a core function.** The distinction-catch runs on an **authored lexicon**, not a model. | Demo ships **LLM-free**. No inference dependency, no model latency/cost. LLM is a *later* helper (robustness, richer storytelling). |
| **Scope** | **Tiers 1–3 fully live; tier 4 (storytelling) not built and hidden from users** until Reflect is near. | The whole storytelling build (the hardest part) is out of this pass. Every surface shipped actually works. |

---

## 2. Scope

### In (fully working)
- **Tier 1 — Day-1 frame** (P1): the "felt not told" onboarding moment. Once.
- **Tier 2 — the bare loop** (P2→P3→P4): the ~3-min daily practice — body texture → feeling word → need → optional small action. The spine.
- **Tier 3 — in-context distinctions** (P5): the gentle catch of faux-feelings on the person's own material, surfaced after some usage.
- **Light self-initiation / graduation detection** — per the recorded decision (detect-don't-count), the *subset* that doesn't depend on tier 4.
- **Both languages** — English `reviewed`, Persian `draft` pending a native pass (§7). Originally planned English-only on the `learn.md` §4 build-order nuance that the demo cohort is English-speaking; the spec/surface split made adding Persian cheap enough to do now, and doing it surfaced three bugs English had hidden.
- **Hardcoded dials** (`learn.md` §3 — thresholds are hardcoded for the prototype; values drawn from the mechanism doc's Dials rows).

### Out (this pass)
- **Tier 4 — storytelling** (P6): **not built, not shown to users.** Held as design in the mechanism doc; built when Reflect is on the horizon (its payoff is the Reflect bridge, a deferred integration concern — decision log 2026-07-23).
- **Native review of the Persian.** The words are authored and shipping; the review pass is not done, and the app says so in a banner rather than hiding it (§7).
- **The LLM helper**, the full evaluation-and-settings UI, and any pattern-recognition across entries.

### What "graduation" means in the demo
With tier 4 absent, the demo's graduation signals are the tier-1–3 subset (foundation §4, minus the storytelling-tractability clause): the loop **self-initiates**, the person **reaches for words without leaning on the palette**, and they **catch some of their own faux-feelings**. Detected per the recorded stance — never counted (`decision-log` 2026-08-01).

### The honesty line
This demo is built to the **provisional** definition-of-done (the hypothesized outcomes), not a validated one — RQ-V's answer is still an *output* of the discovery (Doc 1 §10). That's exactly what "fully working, not yet data-backed" means. **This build becomes the artifact the Phase-3 test is later run on.** Building it now converges the build and the discovery rather than gating one on the other — consistent with the standalone-build model.

---

## 3. Build placement — a Tracker tool

Follow the **skills-engine pattern** (`../../../tracker/canon/06-specs/`), which already solved this in the same repo:

- **Route:** a tool namespace, e.g. `/tools/learn/feelings-needs` (mirroring `/tools/skills/:skillKey`).
- **Content lives in the API, not the client** — authored, versioned, locale-scoped, with a **spec/surface split** (locale-invariant spec + per-locale surface). This is the skills engine's §5/§5.1 cost model, adopted here so Persian is cheap to add later (§7).
- **Reuse:** Tracker auth (`requireAuth`/`ensureOwned`), Prisma/SQLite, the i18n scaffolding, the wizard-step-commits-as-it-goes convention.
- **Isolation:** it's a self-contained tool — no coupling into Goals/Actions. (Later, the standalone-app migration lifts this tool out; keeping it decoupled now makes that cheap.)

---

## 4. Screen / flow spec (derived from the mechanism doc)

Each surface is built to its process's **mechanism**, and its **failure modes are the acceptance criteria** (what the UI must *not* do). References are to `../learn-mechanisms/00-module1-process-anatomy.md`.

### 4.1 Day-1 frame — onboarding, once  *(P1)*
- **Flow:** recall a recent "off" moment → locate it in the body → try a few words on it → *notice that naming gave a handle though nothing else changed.*
- **Mechanism constraint:** the malleability belief must be **felt, not asserted** — no screen that *tells* the user "emotions are workable." The realization is the payoff of doing it.
- **Must not:** state the lesson as a slogan; let the first attempt fail to land a word (start with an easy/pleasant referent). *(P1 failure modes.)*
- **Persisted:** `FrameCompletion` (once per user).

### 4.2 The bare loop — the daily spine  *(breath → P2 → P3 → P4)*
A short wizard, ~3 min, resumable, commits per step. Five beats, opening with a settling breath:

0. **Breathe** *(a short settling beat, not P-numbered)* — one slow breath, self-paced, **skippable**. This is **P2's precondition made explicit** — the interoceptive on-ramp needs enough calm to attend inward — and the ritual threshold into the practice. **Not a meditation or a timer** (that would slow the loop and drift the module toward a mindfulness app it isn't); one breath, then move. No streak.
1. **Notice — body** (P2): "where / what texture?" — pick from a small **texture palette** (tight, heavy, jittery, warm…) *before* any word.
2. **Name — the feeling** (P3): reach for a specific word from a **small palette weighted pleasant/met-need early**, plus the "other → type it" escape; **"try it on" against the texture just named**, carried forward on screen.
3. **Need — underneath** (P4): "if this points at something you care about — what?" **offered, never forced**, from a small set, with a plainly visible skip.
4. **Small step** — the seam toward Reflect (kept, nothing to hand to yet); optional, skippable.

**Optional loop repeat — for plural feelings.** At the close, **finishing is the primary action**; **"add another"** is a quiet secondary. A repeat runs the same loop again for **another distinct feeling**, and **skips the breath** (already settled). Bounded by a **soft cap (~2–3, a dial)** so it can never become an open-ended emotional inventory — the rumination the "keep moving" guard exists to prevent. The passes stay **parallel**: the loop never asks the person to relate, rank, or connect the feelings — **that is storytelling's job (P6, tier 4, deferred)**, and letting it in here would smuggle tier 4 into the demo.

**"This sitting" recap** — after a repeat, a light recap lays the sitting's feeling→need pairs **side by side, explicitly not related** ("seeing how they connect comes later"). It gives a sense of completion and honors plurality without doing reconstrual. No streak, no count.

- **Mechanism constraint:** the loop **keeps moving** (notice → name → need → small thing); it must never invite "why am I like this" parking. Palette **small** (granularity-in-context, not a word dump). The breath **settles, it doesn't lengthen** — if it reads as friction in the build, it's too heavy.
- **Must not:** force a need; offer a palette so large it becomes a menu; let the repeat run unbounded; ask how the feelings relate; let the user stall into rumination. *(P2/P3/P4/P6 failure modes; `learn.md` §5 guardrails.)*
- **Persisted:** loop passes grouped into a **sitting** — see §8.
- **Wireframes:** `01-module1-wireframes.html` (Day-1 frame · the full loop with breath · the optional repeat + sitting recap · the distinction catch · the graduation door).

### 4.3 In-context distinction catch  *(P5)*
- **Trigger:** the person's entry contains a **faux-feeling** (lexicon match — see §6) — either chosen or free-typed. Surfaced after some usage (~week 2, a hardcoded dial), distributed, not all at once.
- **Flow:** gentle catch — "that's more a read on what someone *did* — underneath, the feeling (hurt? lonely?) and the need (to matter? to be included?)." On the person's **own** material.
- **Mechanism constraint:** a **catch, not a quiz** (variation theory on live material); gentle, not corrective; never before the loop (A) is established.
- **Must not:** drill; use canned examples; fire on every instance (distributed touches). *(P5 failure modes.)*

### 4.4 Self-initiation / graduation  *(P7 — light)*
- **Mechanism:** the app **fades its own prompts**; graduation is inferred from continued engagement with fewer prompts, surfaced **once** as a capability ("this runs on its own now"), never a streak or count.
- **Demo scope:** a light version — prompt-fade + a one-time capability moment. No metric shown back. *(Per `decision-log` 2026-08-01 — detect-don't-count; every part passes the function test.)*

---

## 5. Content to author (English, demo)

All authored, versioned, spec/surface-split. The heavy design thinking is already done in the mechanism doc; this is realization.

| Content | Notes | Source of constraints |
|---|---|---|
| **Body-texture palette** | small, concrete (tight/heavy/jittery/warm/…) | P2 |
| **Feeling-word palette** | **small**, weighted pleasant/met-need early, broadening later | P3 (granularity ≠ word-count) |
| **Need palette** | small, offered-not-forced | P4 |
| **Day-1 frame script** | the felt-not-told sequence copy | P1 |
| **Distinction-catch copy** | the gentle catch, generic + per-category | P5 |
| **Faux-feelings lexicon** | the canonical NVC set (ignored, let down, abandoned, dismissed, manipulated, unappreciated, …) — the *detection list* | P5 / §6 |
| **Microcopy** | everything obeys "keep moving," "don't oversell vocabulary," "offer don't force" | `learn.md` §5 |

---

## 6. The distinction-catch — authored, not ML

The catch runs on a **finite, canonical lexicon** (NVC's evaluative-words-masquerading-as-feelings). Detection = match the entry's feeling field (and/or free text, if free-typing is enabled — §8) against that list; on a hit, offer the catch. **No LLM, no classifier, no training data.** This is what makes the "one technical unknown" from earlier a non-issue: it's authored content over a closed set. The LLM enters *later* (standalone-app phase) only to (a) catch faux-feelings phrased outside the lexicon and (b) enrich storytelling — both robustness helpers, never core.

---

## 7. Persian — authored, pending native review

**Persian-first is the product constraint** (`learn.md` §4; affect labeling only regulates in the dominant language). The plan's original cost model — split every content item into a locale-invariant **spec** and a per-locale **surface** (`../../../tracker/canon/06-specs/00-skills-engine.md` §5.1) — was adopted at scaffold time precisely so Persian would not be expensive later. **As built 2026-08-04:** `surface.fa.ts` exists against the same spec, and the split paid for itself. Adding the locale changed no structure and no logic; it was authoring words and fixing three things that were only *visible* in Persian.

**Status is `reviewStatus: "draft"`, and the app says so.** Drafted against the spec and the register rules (`04-conventions.md` §7), not post-edited by a native speaker. That distinction matters more here than in a form label: for this module the words *are* the intervention, since P3 trains granularity by giving someone better words for their own states. A word that is merely correct, rather than the one they would reach for, teaches nothing. What a review pass specifically owes — the texture palette staying bodily, the feeling palette being reachable rather than accepted, and which trigger forms people really type — is enumerated in the surface file's header.

**The locale is not stored.** It comes off `Accept-Language` per request (D-22). The authority on what language someone wants is the app in front of them; a column beside that setting is a second copy free to disagree with it, and the disagreement shows up as a person who switched to Persian and kept being handed English words. Same rule as `LoopState`: derive from the event rather than store a summary of it.

**What Persian surfaced that English had hidden.** Worth recording, because all three were live bugs and none was a translation problem:

1. **The matcher could not have worked.** `detectFauxFeeling` bounded triggers with `\b`, which is defined against ASCII `\w` — so in Persian every character is a non-word character and no trigger could ever match. The catch would simply never have fired, silently, in the language the product is for. Now Unicode letter-property lookarounds, plus a normalisation pass (ZWNJ, diacritics, Arabic look-alikes) so someone on an Arabic keyboard still gets a catch.
2. **The carried prompt was ungrammatical, in both languages.** The template read `"in your {{place}} —"`, which made `hard_to_place` into "in your hard to place —". Persian forced the fix because its possessive suffix varies by how the word ends (سینه‌ات, گلویت, فکت) and no rule derives all three: the preposition and suffix moved into a per-word `carryLabel`, and the template went bare.
3. **A catch hint left its question mark on the word.** Hints are authored as questions ("hurt?", «رنجیده؟») because an assertion would substitute the app's taxonomy for the person's reading. The strip matched only ASCII `?`, so picking a Persian hint recorded «رنجیده؟» — into the need prompt, and into the stored entry and history. A record of what someone called their own state should not contain a question mark.

**The lexicon is locale-scoped — settled 2026-08-05 (D-23).** This was flagged as the one place the spec's locale-invariance was under strain, and researching it settled the question rather than confirming the worry.

*The research finding first, because it determined the approach.* **There is no published Persian faux-feelings list.** The Persian NVC centre (زبان زندگی, the canonical Persian NVC body) publishes the real-feelings vocabulary — met-need and unmet-need — and no counterpart to Rosenberg's chapter-4 table of "words that describe what we think others are doing to us". The Persian translation of the book carries the distinction as prose, not as a list. So the Persian lexicon could not be a translation of an authority, because the authority does not exist in Persian; it had to be authored from usage, and it is marked as the part of the surface most in need of a native challenge.

*The mismatch runs both ways.* The NVC list is a claim about **English adjectives** — "ignored", "dismissed", "let down" look like feeling words and are not. Persian mostly lacks those adjectives and says the same things as passive verb phrases (handled inside the `fa` surface). But Persian also **makes judgments English has no word for**, and those cannot live in a surface, because there is no spec concept to hang them on. Six are now in the spec, scoped with `locales: ["fa"]`:

| Concept | Persian | Why it is not the English concept next to it |
|---|---|---|
| `fa_no_loyalty` | بی‌معرفتی | معرفت is a virtue — knowing what a relationship asks. A verdict on character, not a broken promise (`let_down`). |
| `fa_not_received` | تحویل نگرفتن | تحویل گرفتن is something you actively *do*. Warmth withheld, not inattention (`ignored`). |
| `fa_treated_as_stranger` | غریبی کردن | Dehkhoda: بیگانگی کردن. Coldness from an intimate, not distance (`isolated`). |
| `fa_not_counted` | آدم حساب نکردن | Standing as a person, not one remark brushed off (`dismissed`). |
| `fa_face_lost` | ضایع شدن / آبرو رفتن | آبرو is the Iranian face concept, kept or spilled publicly. تحقیر (`put_down`) is what someone did *to* you; this is having been exposed. |
| `fa_favour_held_over` | منت گذاشتن | Moein: a kindness reminded and rubbed in — the root is مَن, a unit of weight. A gift with a debt attached, so the family is `pressured`. |

*Why scoping and not pairing.* The alternative was to give every concept an entry in both locales, which would have meant inventing English triggers for judgments English does not make — a detector firing on words nobody types. Scoping keeps the spec honest about what it is: locale-invariant for **structure** (palette ids, weighting, hint-slot counts — the things comparability actually rests on) and explicitly not for **which judgments a language makes**. Comparability of the palettes, which is what P1's early-win weighting and P3's granularity depend on, is untouched. The detector *should* differ; one that cannot fire on «بی‌معرفتی» is not more comparable, just worse.

*One existing entry was wrong and this found it.* «سرکوفت» was a `put_down` trigger. A سرکوفت is specifically a past kindness or fault thrown back at you — the منت move — so it now belongs to `fa_favour_held_over`, where the need underneath is freely-given generosity rather than dignity. Same for «نامردی کرد», moved from `let_down` to `fa_no_loyalty`.

*Still open.* Whether the six are the right six, and whether each is really a *reading of what someone did* rather than a felt state — the line the admission test draws, and the one a native reviewer is best placed to redraw. Deliberately excluded as genuine feelings: «دلتنگ», «دلگیر», «دلم گرفته». A reviewer moving one of those across, or rejecting one of the six, is the most useful outcome of the review pass.

---

## 8. Data model (Prisma/SQLite, illustrative)

- **`FrameCompletion`** — `userId`, `completedAt`. Day-1 done once.
- **`LoopSitting`** — `userId`, `createdAt`, `breathTaken` (bool), `wasPrompted` (for prompt-fade inference). One per sitting; groups its passes.
- **`LoopEntry`** — `sittingId`, `passIndex` (0-based), `createdAt`, `bodyTexture`, `feelingWord`, `feelingSource` (palette|own), `need?`, `needSource`, `smallAction?`, `distinctionCaught?`. One per loop pass; a plural sitting holds several. **Passes are never cross-referenced to each other** — parallel, not related (§4.2).
- **`LoopState`** — `userId`, prompt-fade level, frame-done, graduation-surfaced-once. Drives §4.4 without a streak.
- **Dials** — a hardcoded config object (not a table): palette contents, **breath length + skippability**, **repeat soft-cap (~2–3)**, "loops before distinctions surface," prompt-fade pace. Sourced from the mechanism doc's Dials rows.

---

## 9. Build order (milestones)

| # | Milestone | Delivers | Notes |
|---|---|---|---|
| **M0** | Scaffold | tool route in Tracker, data model, i18n spec/surface split | reuse skills-engine patterns |
| **M1** | Content | palettes, frame script, catch copy, faux-feelings lexicon (English) | §5 |
| **M2** | **The spine** | the loop (breath → P2→P3→P4) + optional repeat + sitting recap, persisted | the heart of the standalone value; do first |
| **M3** | Day-1 frame | the felt-not-told onboarding (P1) | gates the loop |
| **M4** | Distinction catch | lexicon-based in-context catch (P5) | after the loop exists to catch on |
| **M5** | Self-initiation | prompt-fade + one-time capability moment (P7 light); guardrail pass | per `decision-log` 2026-08-01 |
| **M6** | Polish + team feel-test | internal "feel the pillar" pass (not a user test) | `learn.md` §6's intent, now fully live for 1–3 |

**Tier 4 (storytelling)** is a **separate future milestone**, tied to Reflect's existence — explicitly not sequenced here.

**Sequencing note:** M2 (the spine) before M3 (frame) is deliberate — build the thing that carries the value first, then the on-ramp to it — **confirmed 2026-08-01.** M4 needs M2 to exist. M1 (content) can run in parallel with M0/M2 once the palettes' shape is fixed.

---

## 10. Guardrails baked into the build (acceptance-level)

From `learn.md` §5 and the mechanism doc — these are pass/fail for the demo, not nice-to-haves:

- **The loop keeps moving** — no surface invites rumination ("why am I like this").
- **Don't oversell vocabulary** — palette stays small; granularity is built in context, never a word-count.
- **Catch, don't quiz** — the distinction surfaces gently, on the person's own material.
- **Offer, never force** — the need is a candidate, not a demand.
- **No streaks** — self-initiation is detected as a capability, never counted (`decision-log` 2026-08-01).
- **Felt, not told** — Day-1 installs the mindset by experience, not assertion.
- **Repeat stays parallel** — plural feelings run as independent passes; the loop never relates, ranks, or connects them (that's storytelling, deferred), and the repeat is soft-capped so it can't become a rumination inventory.
- **The breath settles, doesn't lengthen** — one short skippable breath, never a timer or meditation.

---

## 11. Open decisions / to confirm before/within build

1. **Free-typed feelings vs. palette-only** in the bare loop. Palette-only is simpler and keeps the catch trivial; free-typing is truer to "your own words" but widens the lexicon's job (still no LLM — just more list). *Deferred (2026-08-01 — no firm call yet; revisit during the build, "see what happens"). Provisional default to build against: palette with an "other → type it" escape — the escape is where free text (and later the LLM) lives.*
2. **How much graduation detection** to build for the demo vs. stub to prompt-fade only.
3. **Exact hardcoded dial values** — palette contents/size, breath length + whether it's skippable, repeat soft-cap, loops-before-distinctions, prompt-fade pace.
4. **Day-1 frame: required-once or skippable?** (`learn.md` §6 says once; confirm it can't be skipped in the demo.)
5. **Naming** — what the tool is called in Tracker's UI (the skills ones are "Clarity Lab" / "Evidence Lab"; this isn't a "lab").
6. **Tracker R&D log** — add this to `../../../tracker/notes.md` once build actually starts (it tracks in-R&D-now; this is still plan-stage).

---

## 12. Deferred expansions (post-demo)

*Not scope for the demo, and not the same thing as §11's open decisions — those had to be settled to build at all. These are directions the built module opens up, recorded while the reasons are fresh. Each is a **candidate**, and each is written with the guardrail it would have to survive.*

### 12.1 Breathing — alternative patterns  *(P2)*

The demo ships **one** beat: a single slow breath, self-paced, skippable, with no duration promised. That is deliberate — the breath is a threshold into the practice, and `learn.md` §5's "the breath settles, it doesn't lengthen" exists because the obvious next step (a timer, a count, a pattern to follow) is what turns this module into the mindfulness app it isn't.

The expansion worth considering is **offering a small choice of patterns** — physiological sigh, longer exhale, box breathing — for people who already know one works for them. The argument for it is that P2's precondition is *enough calm to attend inward*, and one breath does not reliably get everyone there; someone highly activated may need a different on-ramp before interoception is available at all (which is also where P8's noticing-under-load lives).

**What it must survive.** Any pattern with a count or a cadence is a timer wearing a costume, and a *chosen* pattern is one more decision in front of a practice whose whole value is that it starts immediately. Likeliest safe shape: a default that stays exactly as it is now, with alternatives tucked behind a quiet "another way to settle" — never a picker the person meets on the way in. If the breath ever reads as the point of the sitting rather than the doorway to it, this has failed.

### 12.2 Feeling palette — a valence/arousal axis  *(P3)*

The demo shows a small selection from a flat authored pool (20 words, 6 on screen, weighted pleasant/met-need early). The known tension is that "keep the palette small" and "let a person name anger, shame or overwhelm" pull against each other, and the current answer is a rotation dial.

A **two-dimensional axis** — valence × arousal, the Mood Meter shape that *How We Feel* popularised from Brackett's RULER work — is the obvious richer answer, and it resolves the tension differently and possibly better: the person navigates to a **quadrant** (unpleasant/high-energy, pleasant/low-energy, …) and only then chooses among a handful of words inside it. That is **progressive disclosure rather than a word wall**, so a much larger vocabulary becomes reachable without ever putting a menu on screen. It also gives the two axes as a fallback when no word fits, which is a real answer to "I can't name it" that the flat palette lacks.

**What it must survive.** Three things. **Granularity is not vocabulary size** (P3's load-bearing caveat) — a bigger reachable vocabulary is only worth having if words still get tested against a felt referent, so the axis must not become a taxonomy to browse. The **body comes first** (P2 leads P3): an axis is abstract and inviting to reason about, and reasoning is what the interoceptive on-ramp exists to prevent — it has to sit *after* the body step and be tested against it, not replace it. And the **early-win weighting** must survive: the first loops need a word to land easily, so a grid that opens on all four quadrants at once may be wrong for week one even if it is right for month three.

*Also worth noting: the axis is a natural home for the Persian surface. Valence and arousal are locale-invariant structure — exactly the kind of thing the spec/surface split (§7) is for — so the quadrants are authored once and only the words inside them are realized per locale.*

---

## Changelog

- **0.6 · 2026-08-05** — §7: the lexicon strain is **settled** (D-23). Researched it and found there is no published Persian faux-feelings list at all, so the Persian lexicon is authored rather than translated; six Persian-only concepts added under `locales: ["fa"]`, with the table of why each is not the English concept beside it. Two existing entries corrected (سرکوفت, نامردی کرد).
- **0.5 · 2026-08-04** — §7 rewritten: Persian is **authored, not deferred** (`surface.fa.ts`, `reviewStatus: "draft"`). Records what a native review pass still owes, the locale-from-`Accept-Language` decision (D-22), the three bugs Persian surfaced that English had hidden, and the one place the spec's locale-invariance is under strain — the faux-feelings lexicon, whose concepts are English adjectives and Persian passive phrases.
- **0.4 · 2026-08-03** — Added §12, deferred post-demo expansions, recorded during the build: **alternative breathing patterns** (12.1) and a **valence/arousal feeling axis** (12.2, the Mood Meter shape), each with the guardrail it would have to survive. Also recorded the where/what split now built into the body step — the frame asked "where in your body" and offered texture words; place and state are now two beats, closer to P2's actual move.
- **0.3 · 2026-08-01** — Expanded the daily loop (§4.2): added a short skippable **breath beat** at the front (P2's precondition made explicit), an **optional bounded loop repeat** for plural feelings (parallel passes, soft-capped, breath skipped on repeats), and a light **"this sitting" recap** (side by side, never related — relating is deferred tier-4 work). Threaded through the data model (`LoopSitting` + `passIndex`, §8), dials (breath, repeat cap, §8/§11), guardrails (§10), and milestone M2 (§9). Added the wireframes reference. Companion visual: `01-module1-wireframes.html`.
- **0.2 · 2026-08-01** — Recorded first review calls: **spine-before-frame sequencing (§9) and the spec/surface split from day one (§7) confirmed**; the **palette-vs-free-text choice (§11.1) explicitly deferred** to the build, with palette-plus-escape as the provisional default to build against.
- **0.1 · 2026-08-01** — Initial plan. Built on the three settled decisions (Tracker-tool placement, LLM-free/lexicon catch, tiers-1–3-live/tier-4-hidden). Scope, build placement, screen/flow spec derived from the mechanism doc, content inventory, Persian-deferral mitigation, data model, milestones, baked-in guardrails, and open decisions. Origin: founder direction across the 2026-08-01 Learn planning session.
