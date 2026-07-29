# Tracker — Evidence Lab (skill tool #2)

*Spec, not as-built. The tool that trains evidence-seeking — the reflex of leaving a confident answer to check it against something independent — and measures the behavior, not the belief. Runs on `00-skills-engine.md`. Update the changelog; don't fork.*

**Version 0.1 · Status: spec · 2026-07-26 · Owner: _root**

---

## 1. The skill, and the one thing this tool must not become

Evidence-seeking is skill #2: asking for sources instead of accepting a confident answer. Its lineage:

- **Wineburg & McGrew (2017)** — *lateral reading*. Comparing professional fact-checkers, academic historians, and college students, the fact-checkers were both **faster and more accurate**, because they left the page almost immediately to see what other sources said instead of reading down the page judging it on its own terms.
- **Caulfield's SIFT** — the teachable form: **S**top, **I**nvestigate the source, **F**ind better coverage, **T**race claims to the original context.
- **Epistemic vigilance** — the 2026 framing that this is precisely the skill governing AI collaboration: across a scientist checking a co-scientist, a member of the public looking something up, and a student learning with AI, what decides whether the partnership helps or harms is whether the human evaluates what the AI returns or takes it on trust. Over-trust was the single biggest predictor of a bad outcome across studies.

**The pedagogy is counterintuitive and the tool lives or dies on getting it right.** Conventional media literacy made people *worse*: it trained them to judge sources by surface features (does this look professional?) and by whether an argument "makes sense" — which, absent domain knowledge, is barely different from asking whether something sounds plausible. The other failure mode is telling people to deeply audit every footnote: slow, and it keeps them trapped inside the source's own framing.

What works is **short, drilled, fast** — the parachutist who has just landed asks "where am I, what do the maps say?" before analyzing the terrain. Applied to AI: treat a confident model answer exactly like an unfamiliar website. Don't judge it on how fluent it sounds. **Go sideways.**

Two consequences for this spec, both non-negotiable:

1. **The tool trains a reflex, not an audit.** Items are timed. A 40-second correct check beats a 6-minute correct check, and the scoring says so.
2. **The goal is discrimination, not distrust.** Friction interventions are known to shift reliance broadly without improving the ability to tell good advice from bad. A learner who becomes uniformly suspicious has not learned this skill — they've acquired a different failure. Every form contains **true, well-sourced control claims**, and the headline metric is hit rate *minus* false-alarm rate (§6). A tool that never lets the AI be right teaches distrust and calls it vigilance.

## 2. Session economy

Many, short sessions. A module is ~5 minutes; the standing practice unit is a **3-item daily drill, ~90 seconds**. Evidence Lab is the tool that should be usable while waiting for a build.

## 3. Modules

Six, mapping SIFT onto AI answers rather than web pages.

| Key | Module | Trains |
|---|---|---|
| `e1-stop` | **Notice the moment** | Which claims are worth checking: load-bearing (the decision turns on it), surprising, specific-and-checkable, or costly-if-wrong. Plus the anti-cue: **fluency is not evidence** — confident phrasing, clean formatting, and hedge-free delivery carry no information about accuracy |
| `e2-source` | **Ask what the source even is** | Distinguishing cited / uncited / plausibly-cited. Asking for sources as a routine second turn, and reading what comes back as a claim rather than a receipt |
| `e3-sideways` | **Find better coverage** | The core move: leave the answer, ask an independent source, come back. Drilled for **speed** — the quick map, not the deep dig |
| `e4-trace` | **Trace to the original** | Following a citation to what it actually says. The failure taxonomy: fabricated citation, real source misquoted, real source that doesn't support the claim, quote stripped of context |
| `e5-independence` | **Two sources or one?** | Corroboration that isn't corroboration — syndicated copies, sources citing each other, a model and a search engine both drawing on the same page. Then the verdict, plus *what would change my mind* |
| `e6-reflex` | **Under time pressure** | Interleaved failure modes, timed, with confidence ratings. Where the skill becomes automatic |

`e1-stop` deserves emphasis: it is the module that prevents the tool from producing someone who checks everything and therefore checks nothing. Triage is part of the skill.

## 4. Item taxonomy

Every item is an **AI answer** (authored, fixed, realistic — including formatting and confident tone) plus a stimulus context. The learner renders a verdict. Nine profiles, and every probe form must include the control types:

| Profile | What's wrong |
|---|---|
| `TRUE_CITED` | **Nothing — control.** Accurate, correctly sourced |
| `TRUE_UNCITED` | **Nothing — control.** Accurate but unsourced; the correct verdict is *supported on checking*, not *distrust* |
| `FABRICATED_CITATION` | Source doesn't exist |
| `REAL_SOURCE_MISQUOTED` | Source exists; quote altered |
| `REAL_SOURCE_WRONG_CLAIM` | Source exists and is quoted accurately, but doesn't support the claim made |
| `OUTDATED` | Was true; superseded |
| `CONTESTED_AS_SETTLED` | Genuinely disputed, presented as consensus |
| `PLAUSIBLE_NONEXISTENT` | Invented API, library, function, or standard — high-salience for this user's domain |
| `SUBTLE_NUMERIC` | Mostly correct with one wrong figure, date, or unit |

**Mix requirement: ~1/3 control items in every assessment form, drill, and probe.** Deviating from this ratio is the fastest way to teach the wrong lesson.

Verdict options (fixed, so accuracy is scorable): *supported · unsupported · misattributed · outdated · contested · can't tell in the time available.* The last option is a legitimate answer, not a cop-out, and is scored as correct when the item's key says the check is genuinely inconclusive.

## 5. The Sideways panel — behavior instrumentation

This is the tool's most important component, and the reason Evidence Lab can measure what the published research says it wishes it could measure at scale. Written self-descriptions under-capture real behavior; screen recording is the gold standard nobody can afford. In-app instrumentation gets most of the way there for free.

**Two mechanisms, split by mode** (settled 2026-07-26; engine §16.5):

| | Assessment & probes | Modules & practice |
|---|---|---|
| Surface | **In-app panel over a frozen result snapshot** | Plain new browser tab |
| Search calls | **Zero** — snapshots ship in the content pack | None (the learner searches themselves) |
| Observed | Query chosen, results rendered, which result opened, offsets, paste-back | Panel opened, query issued, offset, paste-back |
| Why | Reproducibility — every learner faces the same evidence surface | Realism — practice should look like the real thing |

**The in-app panel for measurement is not the expensive option — it's the cheap one, and it's better science.** For probe items the plausible searches are knowable in advance: the claim, the cited source, the key entity. Pre-fetch those result sets at content-authoring time, freeze them into the pack alongside the item, and the panel renders from the pack. Consequences:

- **No live search API at assessment time**, so no per-learner search cost, no rate limit, no provider terms question, and no network dependency during a scored probe.
- **A controlled instrument.** A probe where the result set differs per learner — because the live web moved between Tuesday and Friday — is a weaker measurement than one where it doesn't. Freezing turns a cost problem into a validity gain. This is the argument for the in-app panel, more than the logging is.
- **Snapshots are content, and therefore versioned.** They ship under `contentVersion`, go stale like any other content, and are refreshed on a version bump. **The item's answer key must be re-verified against the snapshot at authoring time and at every refresh** — a key that no longer matches its own frozen evidence is the one failure mode this design introduces, and it fails silently. Make it a validator check.
- **A learner may still open the real source in a new tab from the panel.** The click is logged; the paste-back is still required.

**Practice runs on live search in a new tab** — no API spend, no proxying, and it keeps the drill honest about what checking actually feels like. Paste-back of the URL and snippet is the artifact in both modes; it is what makes the check scorable and independence-checkable.

**What is observed reliably:** whether a check was opened, at what offset, which query, which result opened, what was brought back, whether it was brought back **before or after** the verdict was committed, total time on item.
**What is not observed and must not be claimed:** dwell time on an external page, whether the learner actually read what they pasted, or checks performed outside the app. Report `lateral` as "opened a sideways check and returned an independent source," which is what it is — not "read laterally."

**If snapshots are ever dropped in favour of live search at probe time**, the marginal cost is still small — a few searches per probe, at per-thousand-query rates in the cents — but the reproducibility and offline properties go with it. Cost is not the reason to prefer snapshots; comparability is.

**Ordering rule (cognitive forcing):** the verdict must be committed **before** the item's answer is revealed, and the log records whether the check preceded the verdict. A check performed after committing is not a check; it's rationalization, and it is scored as non-lateral.

## 6. The instrument: scored lateral-reading probe v1

Per item, scored independently — the standard instrument scores behavior and judgement **separately**, then combines conservatively:

| Code | Measure | Definition |
|---|---|---|
| **L** | Lateral (0/1) | Opened a sideways check and submitted at least one source **before** committing the verdict |
| **I** | Independence (0/1) | The submitted source is not the one the AI answer cited, and is not a mirror/syndication of it (item key lists known non-independent sources) |
| **A** | Accuracy (0/1) | Verdict matches the item key |
| **T** | Trace quality (0–2) | 0 = no location of the fault; 1 = right general verdict, wrong part of the claim; 2 = identified precisely which element failed |
| **C** | Confidence | 0–100, collected with the verdict → Brier score |
| **ms** | Time to first check | Offset of the first `OPENED_SIDEWAYS` from item start |

**Composites:**
- **Strict composite = L × I × A** — the conservative "lateral *and* accurate" measure the literature uses, and the headline number. Published instruction moves this from ~9.5% to ~46.6%; simple laterality moves ~12% → ~52%.
- **Discrimination = hit rate on faulty items − false-alarm rate on control items.** Reported next to the strict composite and never below the fold. This is the metric that distinguishes a skill from a mood.
- **Calibration = Brier score** over confidence ratings, plus an over-trust rate (high confidence + wrong + no check). Calibration feedback with a visible curve is the intervention that moves this — with the caveat from the literature that a drop in overconfidence can be genuine metacognitive gain *or* a mere bias shift, so it's reported alongside discrimination rather than alone.
- **Reflex speed = median time-to-first-check** on faulty items where the learner scored L. Falling median at constant accuracy is the reflex forming; that's the whole point of `e6-reflex`.

**No LLM is required for any of this.** Every measure above is either instrumented or keyed against an authored item. The judge is used only for optional prose feedback on the learner's written justification. Evidence Lab can ship complete without an AI dependency — the strongest argument for building it first (engine §14).

## 7. Mastery criterion

A module is **mastered** when, across two distinct calendar days, the learner reaches the strict composite on **at least 5 of 6** unscaffolded items for that module, **with no false alarm on a control item** and a median time-to-first-check under **60 seconds**. All three clauses are load-bearing: accuracy without speed is an audit, speed without accuracy is a habit, and either one with control-item false alarms is distrust.

**Tested out:** baseline strict composite ≥ 80% on that module's item type with no control false alarm.

## 8. Practice modes

- **Daily drill** — 3 items, ~90 seconds, interleaved across modules and failure profiles (interleaving, not blocking, is what builds the discriminating reflex). Counts for review credit.
- **Bring a claim** (real-work) — the learner pastes an AI answer they actually received. The tool walks the SIFT checklist, logs the checks, and produces a **verdict card**: claim, verdict, source(s) found, confidence, what would change my mind. Saveable as a `JournalEntry` or attached as a `Note` to the relevant Goal/Project/Action. Uncalibrated → feedback and history only, never mastery or probe credit (engine §4).

The verdict card is the feature most likely to make this tool durable: it turns a training exercise into a working artifact the rest of Tracker can hold.

## 9. Interface requirements

- The AI answer renders **exactly as a real one would** — confident, well-formatted, no visual tell for faulty items. Any styling difference between control and faulty items destroys the instrument.
- Verdict, confidence, and the "which part failed" tag are committed together, before reveal, and are not editable after.
- Reveal shows: the key, which profile the item was, what a fast correct check looked like (~2 sentences, with the search that would have found it), and — on a miss — the diagnosis step first (engine §3 step 5): *what was the cue you had and didn't use?*
- **Timer visible but not punitive** — it informs the speed metric and the learner sees it; running over doesn't void the item.
- Progress: strict composite, discrimination, calibration curve, reflex-speed trend, self-report-vs-behavior overlay (engine §6), review queue.
- i18n: interface strings **and content** in `en` + `fa` at launch (engine §5.1). The key cost decision for this tool: **a Persian item's stimulus is Persian; its corroborating source may be English.** Persian reference and fact-check infrastructure is thin, and requiring Persian-language sources would be the most expensive constraint in the whole content plan — while also being *less* realistic, since a Persian-speaking developer checking a claim about a library reads the English docs. Item specs are locale-invariant (same profiles, same difficulty, same control ratio); only the stimulus text is realized twice. RTL passes on the sideways panel and verdict card ship with the `fa` surface.

## 10. Assessment / probe form spec

**Baseline (A), post (B), delayed (C)** — matched item-for-item on profile and difficulty, order counterbalanced, ~10 minutes:

- 6 scored items: 4 faulty (drawn across `FABRICATED_CITATION`, `REAL_SOURCE_WRONG_CLAIM`, `OUTDATED`/`SUBTLE_NUMERIC`, `CONTESTED_AS_SETTLED`) + **2 control** (`TRUE_CITED`, `TRUE_UNCITED`)
- Each: verdict + confidence + which-part-failed tag, with the Sideways panel available and fully logged
- 4 self-efficacy items — collected, never scored, used for the dissociation display

Reported: strict composite (0–6), discrimination, mean Brier, median time-to-first-check, and the per-module profile that seeds module ordering.

Item security: probe-pool items never appear in modules or drills; once an item is seen anywhere it is retired from the probe pool for that learner. Three forms exist precisely so memory can't carry across timepoints.

## 11. Acceptance criteria

- Baseline → six modules → post → 7-day delayed probe completes, with every `SkillCheckEvent` ordered and offset-stamped, and lateral scored strictly on check-before-verdict ordering.
- Every probe form contains ≥1/3 control items; a form failing this ratio fails a content-pack validation test at build time.
- Discrimination and strict composite are both displayed; neither is shown alone.
- No item key, profile label, or expected verdict appears in any client payload before submission (asserted by test).
- Scoring, mastery, and interval-scheduling services unit-tested against fixtures; thin I/O glue untested by design.
- Full tool functions with **no LLM configured** — verified by a test run with the AI service disabled.
- **A full probe completes with no network access beyond Tracker itself** — frozen snapshots only; asserted by a test with outbound requests blocked.
- Content-pack validator passes: locale parity (`en`/`fa` same `itemId` set, same specs), ≥1/3 control items per form, and **every probe item's answer key verified against its own frozen snapshot**.
- All interface strings **and both content surfaces** present in `en` and `fa`.

---

## Changelog

- **0.2 · 2026-07-26** — Sideways panel split by mode: frozen pre-fetched snapshots in-app for assessment/probes (zero search calls, reproducible evidence surface), live search in a new tab for practice. Persian content required at launch, with English corroborating sources permitted for Persian stimuli.
- **0.1 · 2026-07-26** — Initial spec. Probe v1 drafted as the "scored lateral-reading probe" named as a next step in the source brief. Lineage: Wineburg & McGrew 2017/2019; Caulfield's SIFT; Brodsky et al. 2021/2023 (pre/post lateral-reading instruction, self-report vs. behavior dissociation); Buçinca et al. 2021 (cognitive forcing, and the finding that friction can shift reliance without improving discrimination); 2026 epistemic-vigilance work; calibration-training literature.
