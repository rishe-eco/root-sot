# Tracker — Skills Engine (shared spec)

*Spec, not as-built. The common machinery behind Tracker's skill tools: assessment, modules, practice, scoring, mastery, progress. The two skill tools (`01-clarity-lab.md`, `02-evidence-lab.md`) are content + scoring packs on top of this. Update the changelog; don't fork.*

**Version 0.1 · Status: spec · 2026-07-26 · Owner: _root**

---

## 1. What this is and why it's one engine

Two tools are specified: **Clarity Lab** (skill #1, clarity of expression) and **Evidence Lab** (skill #2, evidence-seeking). Both follow the same shape — initial assessment → sequenced modules → open practice → progress — so the shape is specified once here.

What is **not** shared is pedagogy. The source brief's central asymmetry: *clarity is trained slowly, through revision and reflection on models; evidence-seeking is trained fast, as a drilled reflex.* The engine must therefore support two different session economies out of the box:

| | Clarity Lab | Evidence Lab |
|---|---|---|
| Session shape | few, long (10–20 min), one artifact | many, short (2–4 min), 3 items |
| Unit of work | a written artifact the learner revises | a claim the learner checks |
| What's scored | the **product**, by analytic rubric | the **behavior**, by instrumentation |
| Scoring risk | rater/judge reliability | none — behavior is observed; risk is item validity |
| Progression | revision delta over drafts | reflex rate and latency |
| Failure mode to design against | "checkbox clarity" written to the rubric | blanket distrust instead of discrimination |

An engine that treats them as two skins on one quiz component will produce a working Clarity Lab and a useless Evidence Lab. The per-tool docs own their differences; this doc owns only what genuinely repeats.

## 2. Scope

**In scope (both tools):** initial assessment that doubles as the baseline measurement; a sequence of modules with a fixed step template; per-item feedback; an error-diagnosis step; an open/general practice mode for learners past the modules; a spaced review queue; progress tracking; a delayed retention probe; export of one's own data.

**Non-goals — stated because each is a live temptation:**

- **Not a prompt-tips library.** The brief's whole finding is that tricks perish and skills compound. No "10 magic phrases" surface, no model-specific technique content. Where a technique is genuinely useful (memory stand-down, token economy) it is taught as the durable skill underneath it — see `01-clarity-lab.md` §3 C6.
- **No streaks, badges, or leaderboards.** Streak-style habits were deliberately removed from Tracker (`../../decisions/decision-log.md`; `components/habits/` is an intentionally empty module). The review queue — "3 modules due" — is the only recurring pressure. Reintroducing streaks here would contradict a standing product decision.
- **Not a chat playground.** The learner never free-chats with a model inside the Lab. Every AI turn is a scored or scaffolded step, because the point is the learner's move, not the model's answer.
- **No proctoring or cheat resistance.** Single-user self-development. Item leakage is handled by parallel forms (§6), not by surveillance.
- **Not gated onto anything.** Consistent with the Clarity Check (`01-product/02-clarity-check.md`), these tools never block another Tracker flow.

## 3. The module step template

Every module in both tools runs the same seven steps. The learner's raw sketch (concept → example → practice → feedback/issue-solving → practice) is preserved and completed; the additions are the fading step and the spaced review, both of which the learning-science literature treats as load-bearing.

| # | Step | What it is | Rationale |
|---|------|-----------|-----------|
| 1 | **Concept** | One idea, ≤2 min, ≤250 words, one diagnostic question | Explicit systematic instruction is the strongest single ingredient in writing instruction (strategy instruction, *d* ≈ 0.82 in Graham & Perin). Length cap because this is not a course. |
| 2 | **Model** | An annotated good example *and* a matched weak one, with the difference marked | Study of models alone is weak (*d* ≈ 0.25); it earns its place only as *contrast* attached to instruction, not as the teaching itself. |
| 3 | **Guided attempt** | A partially completed item — the scaffold does part of the work | Worked-example fading: full example → completion problem → independent problem. Skipping the middle rung is the standard novice-instruction error. |
| 4 | **Feedback** | Criterion-referenced, per-dimension, quoting the learner's own words | Never a single overall grade; the per-tool rubric/checklist dimensions are the feedback vocabulary. |
| 5 | **Diagnose & fix** | The learner names *which* dimension failed and repairs it — for Clarity this is the revision; for Evidence it is the miss postmortem | The learner's own diagnosis before the answer is revealed. This is the step that converts a correction into a transferable rule; without it, feedback is consumed and forgotten. |
| 6 | **Independent practice** | A fresh item, no scaffold, scored → feeds mastery (§8) | Mastery may only be earned unscaffolded. |
| 7 | **Review (queued)** | The module returns on an expanding schedule | Spacing and retrieval are the two highest-leverage retention moves; without step 7 the tool teaches for the post-test only — precisely the gap the brief identifies in the literature. |

Rules: steps 1–2 are skippable by a returning learner and re-openable at any time from any later step (the concept card is always one tap away during practice — the drill is not a memory test of the concept). Steps 3–6 are not skippable within a module. A module is one sitting of ~8–15 min (Clarity) or ~5 min (Evidence) and must be resumable mid-step (persist step + partial response, per convention #8: wizard steps commit as they go).

## 4. The four surfaces

1. **Initial assessment** (`/tools/skills/:skillKey/assess`) — 6–12 min. Produces (a) a per-module profile that *orders and recommends* modules, and (b) the **baseline measurement**, form A. Skippable; if skipped, modules run in default order and the progress surface states plainly that no baseline exists and later scores are not comparable to anything. It is the same instrument as the post and delayed probes — a different assessment for baseline and post would make the comparison meaningless.
2. **Modules** (`/tools/skills/:skillKey/m/:moduleKey`) — the seven-step template. 6 modules per tool (§3 of each tool doc). Six is a deliberate cap: the rubric that mirrors them must stay in the 4–6 criterion range where inter-rater agreement holds up.
3. **General practice** (`/tools/skills/:skillKey/practice`) — for learners who finished the modules and want to keep going. Two modes in both tools:
   - **Calibrated practice** — authored items drawn from the retired/practice pool, interleaved across all six modules (interleaving beats blocking for durable transfer), difficulty-adaptive. Counts toward review credit.
   - **Real-work practice** — the learner brings their own material: a real prompt they are about to send (Clarity), or a real AI answer they just received (Evidence). Scored with the same rubric/checklist, but flagged `openPractice`: it produces feedback and history, **never** mastery credit or probe scores, because the item is uncalibrated. This mode is where the tool stops being schoolwork; "extended practice writing for a real purpose" is the second half of the recommended clarity pedagogy, and it is also the only mode that will still be used in month three.
4. **Progress** (`/tools/skills/:skillKey`) — the tool's home. Module states, the review queue, baseline/post/delayed scores with comparability caveats, per-dimension trends, and the per-tool behavioral metrics. §10.

## 5. Item and content model — authored, versioned, locale-scoped

**Content is authored and lives in the repo, not the database, and not generated at runtime.** A generated item cannot be a measurement instrument: pre/post comparison requires known, fixed, matched items. Generation is allowed in exactly one place — feedback prose (§7) — and optionally in real-work practice, where nothing is measured.

**Content lives in the API, not the client** (corrected 2026-07-26 during implementation — the original sketch put it under `client/`, which is wrong: answer keys, fault targets and independence rules must never reach a browser bundle, and the client would have shipped them).

```
api/src/content/skills/
  types.ts                 # shared types + toPublicItem() — the client-safe projection
  validate.ts              # locale parity, control ratio, key-vs-snapshot
  evidence/v1/
    spec.ts                # locale-invariant: ids, difficulty, keys, fault tags, snapshots
    surface.en.ts          # the words
    surface.fa.ts          # the words
    index.ts               # assembles spec + surface for a locale
  clarity/v1/ …            # P1
```

The client receives only `PublicEvidenceItem`: prompt, answer, difficulty, and — in assessment mode only — the frozen snapshot. There is deliberately no GraphQL field through which a key can be requested.

Requirements:

- **`contentVersion` is stamped on every stored attempt and probe.** Scores produced under different content or rubric versions are not comparable and the UI must not chart them on one line without a version marker. This is the single most common way a tool like this quietly invalidates its own history.
- **Item schema (shared fields):** `itemId`, `moduleKey`, `formId` (`A|B|C|pool`), `difficulty` (1–3), `locale`, `type`, `prompt/stimulus`, `answerKey`, `scoringHints`, `distractorProfile`, `retiredAt?`.
- **Answer keys, rubric decision rules, and scoring hints never reach the browser.** All scoring is server-side; the client receives only the stimulus and, after submission, the feedback payload. (Otherwise a devtools-open learner can read the key, and — more importantly — an item bank that leaks is a bank that can't be reused for the delayed probe.)
- **Locale:** content packs are per-locale. **`en` and `fa` both ship at launch** — Persian is a brand non-negotiable (convention #7, decision-log standing constraint), and a bilingual interface over English-only *content* would be a hollow version of it. §5.1 is how that is made affordable.

## 5.1 Bilingual content — the cost model

The instinct is that a second locale doubles the content bill. It doesn't, because the bill has two very different halves and only one of them is language-shaped.

**Split every item into a locale-invariant `spec` and a locale-specific `surface`.** The spec holds everything that makes the item an instrument: `itemId`, profile, difficulty, required-context slots, answer-key semantics, distractor type, scoring hints. The surface holds only the words. Author the spec **once**; realize the surface twice.

```
clarity/v1/
  spec/items.ts        # locale-invariant: ids, difficulty, keys, slots
  en/surface.ts        # the words
  fa/surface.ts        # the words
```

This is the measurement literature's *adaptation, not translation* principle turned into a file layout — a translated instrument is not automatically the same instrument, and item-level equivalence is a real risk (differential item functioning arises exactly from vocabulary familiarity and difficulty drift introduced in translation). Holding the spec identical across locales is what makes the two versions comparable at all, and it means a later fix to an item's difficulty or key is made **once**, not twice.

**A build-time validator enforces locale parity:** every `itemId` exists in both surfaces, with matching structural metadata and matching control-item ratios. Fail the build otherwise. Drift between locales is where the long-run money actually goes, and this catches it for free.

**Draft with an LLM, pay for review, not authoring.** LLM-drafted assessment items reach reliability and validity comparable to expert-developed ones when a human-in-the-loop review layer sits on top — at substantially lower time and resource cost. So: Claude drafts the `fa` surface from the shared spec; a native Persian reviewer post-edits. Run the drafting through the **Batch API (50% off)** — it is offline work with no latency requirement.

The arithmetic settles the question: ~130 items per locale per tool at a couple of thousand output tokens each is on the order of **a few dollars of API spend**, batched. **The entire Persian cost is human reviewer time.** Optimize that, not the API bill.

**Three scope cuts that reduce what needs Persian authoring at all:**

1. **Evidence Lab: the stimulus is Persian, the corroborating source may be English.** The expensive constraint in a Persian evidence item is not the claim — it is needing a verifiable *Persian-language* source to check it against, and Persian reference and fact-check infrastructure is thinner. Allowing English sources removes that constraint, and is also the more authentic task: a Persian-speaking developer checking an AI claim about a library reads the English docs. This is the single largest saving in the whole bilingual plan.
2. **Clarity Lab: only two of six rubric criteria need Persian linguistic work.** R1 (ask placement), R2 (deliverable), R3 (context), and R5 (success criteria) are structural and transfer nearly unchanged. R4 and R6 do not: Persian is pro-drop, so "unbound pronoun" means something different; *ezāfe* chains and اسم‌مصدر nominalization need their own treatment; and "front-load the constraint" interacts with word order and RTL. Scope the linguistic work to R4 and R6.
3. ~~Tier the review effort by measurement weight.~~ **Superseded 2026-07-26 — full native review on every item in both locales.** This cut existed to ration expensive reviewer time. A native Persian collaborator is available at roughly a dollar an hour, so the money constraint is gone and the compromise it justified should not be kept: a lightly-reviewed practice pool was always a quality concession, not a design choice.

**With cheap review time, the binding constraint is hours and ramp-up, not money.** Two things follow. First, sequence the reviewer's time by leverage, because availability is still finite: (a) the `fa` calibration anchor set (§7 — this is the highest-value use of a native rater and the thing that was previously at risk), (b) the R4/R6 Persian linguistic rewrite in `01-clarity-lab.md`, (c) probe-form surfaces, (d) the practice pool. Second, budget **training**, not just hours: rubric scoring is a learned skill, and the calibration literature is explicit that a rubric alone does not produce agreement — raters must independently score shared samples and reconcile before real scoring begins. A fluent speaker is not yet a calibrated rater.

**Two long-run traps, both avoidable:**

- **Freeze rubric v1 before `fa` authoring begins.** Authoring a second locale against a moving rubric is the most expensive avoidable mistake available here — every criterion edit re-opens every item in both locales.
- **Version locales together.** A `fa` pack is pinned to `clarity/v1`, never floating. Every content change is a two-locale change, planned and budgeted as one unit, and the parity validator makes a half-done change fail loudly instead of silently shipping an English-only regression.

RTL passes on the artifact editor, the sideways panel, and the rubric display are engineering work, tracked with the `fa` surface, not after it.

## 6. Measurement architecture

Three timepoints, per the brief: **baseline → post → delayed.**

- **Parallel forms A / B / C** — identical structure, item-for-item matched on type and difficulty, different content, order counterbalanced. Assignment is fixed at first use (`baseline=A`, `post=B`, `delayed=C`) with a per-user rotation offset so the same physical items don't always occupy the same timepoint across users.
- **Post probe** fires when all six modules reach mastered/tested-out, or on demand.
- **Delayed probe** is scheduled **7 days** after the post probe and surfaced as a due item on the tool home and (once) on Today. It is the piece the literature is missing — lateral-reading studies almost all stop at posttest — so the delayed probe is P0, not a nice-to-have. If it is dropped, the tool cannot answer whether it works.
- **Comparability rules, enforced in code, not just in docs:** a probe result is charted only against results with the same `contentVersion`, same `rubricVersion`, and — for LLM-scored dimensions — the same `judgeModelVersion`. Any mismatch renders the series broken at that point with a visible marker. (Note the irony worth naming in the copy: the judge model is itself a perishable technique inside a tool about durable skills. Pin it; re-calibrate when it changes.)
- **Self-report is collected but never scored.** A 4-item self-efficacy question at each timepoint ("how confident are you that you'd catch a wrong claim in an AI answer?"). It exists for one reason: there is a documented dissociation between what people say about their checking behavior and what they do, and showing a learner their own self-report line diverging from their behavior line is the most direct teaching intervention the tool can make about over-trust. It must never gate progression or contribute to a score.

## 7. Scoring architecture

Three scoring sources, in strict order of trust:

1. **Instrumented behavior** (highest trust) — did the learner open the sideways panel, when, what did they bring back, how long did they take. Directly observed, deterministic, cheap. This is the digital stand-in for the screen recording the academics call the gold standard and can't afford at scale. Evidence Lab leans on this almost entirely.
2. **Deterministic detectors** — rule-based checks on observable surface features (position of the main ask, unbound pronouns, presence of a named deliverable, sentence-to-constraint ratio). No model needed, instant, perfectly reproducible. Runs first and always.
3. **LLM judge** (lowest trust, used where 1 and 2 can't reach) — criterion-by-criterion rubric scoring of open text.

**LLM judge requirements** — a rubric does not automatically fix reliability, and autoraters are prompt-sensitive and carry a documented positivity bias:

- One call **per criterion**, not one call for a total. No holistic "how clear was this?" score anywhere in the system.
- Structured output only: `{criterion, level: 0|1|2, evidenceQuote, ruleApplied}`. A level without a quote from the learner's own text is rejected and retried. The quote is also what the feedback UI shows, so the judge's evidence is visible to the learner.
- ~~`temperature: 0`~~ — **corrected 2026-07-27 during implementation: not available.** `temperature`, `top_p` and `top_k` are rejected outright on Claude Opus 5 and Sonnet 5 and return a 400. Pinned model version recorded on the attempt, few-shot anchored with the calibration set below, and **blind** to the learner's history, prior scores, and self-report (no anchoring on their trajectory).
- **Reproducibility comes from per-attempt immutability, not from sampling config.** A scored artifact is written once and the submit mutation rejects a second submission, so a learner cannot see two different numbers for the same text. An in-process cache on `(itemId, responseText, rubricVersion, judgeModelVersion)` is then a cost optimisation for retries, not the correctness mechanism it was originally specced as.
- **Calibration gate before the judge is trusted for measurement:** 20 anchored samples per rubric criterion, human-scored twice with discrepancies reconciled first (this is the "calibrate scorers before real scoring" caution, applied to a machine rater), then the judge must reach the agreement target on the held-out half. Below target, that criterion runs in *feedback-only* mode: the learner sees prose, no number enters the probe total. Re-run the gate whenever `judgeModelVersion` or `rubricVersion` changes.
- **The gate runs per locale, and `fa` is now in scope.** A judge calibrated on English artifacts is not thereby calibrated on Persian ones — different criteria, different failure modes, and for R4/R6 a different scoring path entirely (`01-clarity-lab.md` §4). Without a native rater the honest outcome would have been `fa` running permanently feedback-only, with Persian learners getting prose and no comparable scores — a two-tier product. **With a native Persian rater available, `fa` scores can be measurement-grade from launch.** This is the single most valuable thing that reviewer's time buys, and it is worth spending before any bulk content review.
- Default model `claude-opus-5` for probe-grade judging; `claude-sonnet-5` permitted for high-volume practice feedback, recorded per attempt, and practice and probe scores from different models are never pooled.
- A judge failure degrades to detectors + self-diagnosis, never to a blocked session.

**Judge cost, and the caching structure that sets it.** Six criteria × one call each looks expensive until the prompt is laid out correctly. The rubric text, the scoring rules, and the anchor set are **identical across every criterion, every learner, and every attempt**; only the criterion instruction and the learner's submission vary. That is exactly the shared-prefix/varying-suffix shape prompt caching is built for:

```
[ rubric + scoring rules + anchors ]  ← cache_control breakpoint (stable, ~1.5k tokens)
[ criterion N instruction + learner submission ]  ← varies, after the breakpoint
```

Cache reads bill at ~0.1× input; writes at 1.25× (5-minute TTL) or 2× (1-hour). At Opus 5's $5/$25 per MTok this puts a fully-judged six-criterion clarity artifact in the **single-digit cents**, and a learner's entire Clarity Lab program — assessment, six modules, three probes — around **a dollar or two**. Evidence Lab adds nothing: it needs no judge at all (§7, item 1–2).

Two implementation details that decide whether that holds:

- **Use the 1-hour TTL and pre-warm.** This is low-traffic, bursty usage — a learner does one session, then nothing for days. A 5-minute cache is cold on essentially every session. The 1-hour TTL costs 2× on write but survives a whole session; a `max_tokens: 0` pre-warm at session start pays one write and makes every subsequent call in that sitting a read.
- **Don't fan out all six criteria at once on a cold cache.** A cache entry is readable only once the first response begins streaming, so six concurrent calls all pay the full write. Fire the first criterion, await first token, then fan out the remaining five.

Verify with `usage.cache_read_input_tokens`; a persistent zero means something volatile (a timestamp, a learner id, an unsorted serialization) has leaked into the prefix. The rubric prefix must be byte-stable — which it is, because `rubricVersion` is pinned (§6).

**Cognitive forcing, deliberately.** Active-verification forcing (making the human commit before seeing the AI's answer, or requiring an explicit check) measurably reduces over-reliance where passive explanations don't — and the designs that reduce over-reliance most are the ones users rate *least* pleasant. Inside a practice tool that trade is acceptable and in fact the product: Evidence Lab requires a verdict before revealing, Clarity Lab requires a prediction before the reader's misread. Two consequences to accept up front: (a) satisfaction telemetry will read lower than for a frictionless design and must not be optimized away, and (b) this friction stays **inside the Labs** — it is not exported as ambient friction across Tracker, where it would need an opt-out.

## 8. Mastery, spacing, and over-practice

**Rule-based, not model-based.** Bayesian knowledge tracing with a 0.95–0.98 mastery threshold is the standard answer and the wrong one here: BKT assumes item volumes this tool will never have (6 modules × ~8 items), and its output is uninterpretable to the learner. Explicit rules instead:

- **Mastered** = at criterion on **two consecutive unscaffolded (step 6) items, on two distinct calendar days.** The cross-day requirement is not bureaucracy — same-session repetition measures short-term retention only, which is exactly the illusion the tool exists to dispel. Per-tool criterion definitions live in the tool docs.
- **Tested out** = the baseline assessment already showed criterion performance on that module's dimension. The module is marked `testedOut` (visually distinct from `mastered`), collapsed to concept + one step-6 item, and still enters the review queue once. Skipping over-practice measurably beats grinding it; pretending it's mastery would inflate the baseline→post delta.
- **Review queue** — expanding intervals **1d → 3d → 7d → 21d → 60d**, per module, with a jitter cap of ±1 day so a returning learner never faces six due modules at once. FSRS-class scheduling (~20–30% fewer reviews at equal recall) is a P2 refinement, not P0; fixed intervals are honest at this scale.
- **A failed review** returns the module to **step 5 (diagnose & fix)**, not step 1. Re-reading the concept is not the remedy for a failed application.
- **No mastery decay display without a review attempt.** The engine never shows a score dropping because time passed; it shows a module as *due*.

## 9. Data model (Prisma) — additive, convention-compliant

New models. All list-valued and structured fields are **JSON strings** stringified in the mutation and parsed in `typeResolvers.ts` (convention #2). All resolvers use `requireAuth` **and** `ensureOwned` (convention #1). Schema change → update `02-architecture/01-data-model.md` + a `../../decisions/decision-log.md` entry in the same change (convention #11).

```prisma
enum SkillKey        { CLARITY EVIDENCE }
enum SkillModuleState{ NOT_STARTED IN_PROGRESS MASTERED TESTED_OUT DUE_REVIEW }
enum SkillMode       { ASSESSMENT MODULE REVIEW CALIBRATED_PRACTICE OPEN_PRACTICE }
enum SkillTimepoint  { BASELINE POST DELAYED }

model SkillProfile {           // one per user per skill
  id, userId, skillKey, contentVersion, locale,
  assessmentStartedAt?, assessmentCompletedAt?, assessmentSkipped Boolean,
  recommendedOrder String?,    // JSON array of moduleKey
  aiConsentAt?, createdAt, updatedAt
  @@unique([userId, skillKey])
}

model SkillModuleProgress {
  id, userId, skillKey, moduleKey, state SkillModuleState,
  currentStep Int, partialResponse String?,     // resumability (convention #8)
  consecutiveAtCriterion Int, lastCriterionDay String?,  // "YYYY-MM-DD"
  masteredAt?, reviewIntervalIndex Int, nextReviewAt?, updatedAt
  @@unique([userId, skillKey, moduleKey])
}

model SkillAttempt {
  id, userId, skillKey, moduleKey?, itemId, formId?, mode SkillMode,
  responseText String?, revisionOfAttemptId?,   // draft → revision chain
  scores String,           // JSON: per-criterion levels + total
  behaviors String?,       // JSON: derived behavioral metrics
  confidence Int?,         // 0–100, for calibration
  latencyMs Int?, contentVersion, rubricVersion?, judgeModelVersion?,
  scoredBy String,         // "detector" | "judge" | "behavior" | "mixed"
  createdAt
  @@index([userId, skillKey, moduleKey])
}

model SkillProbe {
  id, userId, skillKey, timepoint SkillTimepoint, formId,
  scheduledFor?, startedAt?, completedAt?,
  totals String,           // JSON: per-dimension + composite
  contentVersion, rubricVersion?, judgeModelVersion?, selfReport String?
  @@unique([userId, skillKey, timepoint])
}

model SkillCheckEvent {      // Evidence Lab behavior instrumentation — rows, not JSON
  id, attemptId, kind String,   // OPENED_SIDEWAYS | SEARCH_ISSUED | SOURCE_SUBMITTED | VERDICT_SET | REVEALED
  payload String?, offsetMs Int, createdAt
  @@index([attemptId])
}
```

Why `SkillCheckEvent` is rows and not a JSON blob on the attempt: time-to-first-check and check-before-verdict ordering are primary outcome measures, and they need to be queryable and aggregable, not parsed out of a blob per row.

## 10. GraphQL surface

Queries: `skillProfile(skillKey)`, `skillModules(skillKey)`, `skillSession(sessionId)`, `skillProgress(skillKey)`, `skillDueReviews`, `skillProbe(skillKey, timepoint)`, `skillExport(skillKey)`.

Mutations: `startSkillAssessment`, `startSkillModule`, `submitSkillAttempt`, `submitSkillRevision`, `logSkillCheckEvent`, `advanceSkillStep`, `startSkillPractice`, `startSkillProbe`, `completeSkillProbe`, `setSkillAiConsent`, `resetSkillProgress`.

Rules: **all scoring happens in a resolver/service, never on the client** (§5); `submitSkillAttempt` returns the feedback payload, never the answer key for un-submitted items; per-user rate limits on judge-backed mutations; all documents added to `app/api/queries.ts` and consumed via `useApi()` (convention #6).

## 11. AI service + privacy

Tracker currently makes **no external network calls** — `api` has no LLM dependency and runs on a single VPS with SQLite. These tools change that. **Approved 2026-07-26** (decision-log D-13): external LLM access is in scope. It remains a conscious architectural addition, not a dependency that arrives with a feature.

- New `src/services/ai/` with a provider-agnostic adapter (`judge(criterion, submission)`, `feedback(...)`, `generateOpenPracticeItem(...)`), pinned model versions, timeouts, retries, a per-user daily call cap, and structured logging of token spend per attempt.
- **Explicit per-tool consent** (`SkillProfile.aiConsentAt`) before any learner text leaves the server, stating what is sent, to whom, and what is retained. Real-work practice is the sensitive case: it will contain the learner's actual work.
- **A first-class no-AI mode.** Detectors + self-diagnosis against the visible rubric + model comparison. It is meaningfully weaker for Clarity and *nearly full-strength for Evidence*, because Evidence scoring is behavioral and its items are authored — worth saying out loud, because it means Evidence Lab can ship without an LLM at all.
- Secrets via env only; no keys in the client bundle; the browser never calls the provider directly.

## 12. Tracker integration

- **Tools hub** (`ToolsHomePage`) gains a "Skills" section with the two tool cards showing module state and due-review count. Routes under `/tools/skills/*` in `protectedRoutes.tsx`.
- **`ModuleIntroOverlay`** for first entry, `moduleKey` = `skills.clarity` / `skills.evidence`. Do **not** add slides to `OnboardingSlideshow` — that touches `TOTAL_SLIDES` and the `markSlideViewed` threshold, a known churn point.
- **Today** may show at most one line: due reviews or a due delayed probe. Not a card, not a nag, no streak.
- **Calendar planning (opt-in).** Module sittings and due reviews can be written into the calendar as ordinary scheduled `Action` rows (`sourceType: skill`, `sourceId: "<skillKey>:<moduleKey>"`, `isGathered: false`, priority `S`). Rules:
  - **Off by default** (`SkillProfile.calendarPlanningEnabled`). A tool that fills someone's calendar unasked is a tool they uninstall.
  - **Two sittings per module, on different days.** This is not padding — mastery requires at-criterion attempts on two distinct calendar days (§8), so a one-sitting-per-module plan would look complete and never produce mastery. The planner defaults to two and warns if asked for one.
  - **Module-major pass ordering** (every module once, then every module again), which separates a module's two sittings by a full cycle *and* interleaves the modules — interleaving beats blocking for durable transfer.
  - **Re-planning replaces the future, never the past.** Completed and past-dated sittings survive; a learner who did the work keeps the record.
  - **Reviews reach the calendar only once a module is mastered**, at which point its next review already has a date. Idempotent per module per day, because mastery is recomputed on every submission.
  - **Consistent with D-3, not an exception to it.** A scheduled sitting is a *future commitment*, which is what Tracker's recurrence model is for. Nothing breaks if one is missed and there is no counter to defend. Spaced review is deliberately **not** modelled as an `Interval`: intervals repeat on a fixed cadence, while review intervals expand and depend on outcome.
  - **Steps are not scheduled individually.** A module is designed as one sitting, and steps 3–6 (guided → feedback → diagnose → independent) are a single learning loop — sleeping between them breaks the loop, and six modules × seven steps would put 42 entries in a calendar for a tool whose sessions run five minutes. The one defensible exception is Clarity Lab's revision step, where a deliberate gap *improves* the revision; that is a P1 option for Clarity only.
- **Journals** — an Evidence Lab verdict card and a Clarity Lab before/after pair can be saved as a `JournalEntry` (one tap, existing quick-add path). This is what makes the practice cumulative rather than disposable.
- **Notes** — a clarity revision can be attached to any entity via the polymorphic `Note` model.
- **Goals / Projects as real material** — real-work practice can pull a real Goal DoD or Project description as its input artifact. This is the strongest integration in the spec: Clarity Lab module C5 (success criteria) is the same move as the Clarity Check's *Observability* and *Binary Clarity* dimensions, applied to a sentence instead of a goal. Cross-link both ways, and reuse the Clarity Check's non-gating, soft-indicator posture.
- **Concepts page** gains a short entry per skill pointing into the tool.

## 13. Progress tracking requirements

Per skill: the six module states with mastery/tested-out/due distinction; the review queue with next-due dates; the baseline/post/delayed composite with version markers and an explicit "no baseline" state; per-dimension (rubric criterion / SIFT step) trend lines; the per-tool behavioral metrics (`01`/`02` §6); **self-report vs. behavior overlay** (§6); and total practice count separated into calibrated vs. open.

Two things the progress surface must **not** do: chart across incompatible versions without a break marker, and imply mastery decay without a review attempt (§8).

**Export** — `skillExport` returns the learner's full attempt/probe history as JSON + a markdown summary. Two reasons: it's their data, and the delayed-retention question is one the published literature has not answered, so a clean export is the shortest path from "I built a practice tool" to "I have evidence about whether either skill sticks." Aggregate/anonymous sharing is opt-in and off by default.

## 14. Phasing and acceptance

**P0 — one tool end to end.** Ship **Evidence Lab first.** It is the lower-risk build (behavioral scoring, no judge-calibration dependency, works without an LLM), it trains fast so signal arrives in days not months, and its measurement instrument is the one with published baselines to compare against. Includes: engine data model + GraphQL, assessment (form A), 6 modules, drill practice, review queue, progress, post + delayed probes, export.

Acceptance (P0): a learner can complete baseline → all 6 modules → post probe → a 7-day-later delayed probe with every attempt persisted and every score version-stamped; resuming mid-module restores the exact step and partial response; no answer key is present in any client payload (asserted by test); scoring/mastery/scheduler services are unit-tested against fixtures — per `03-engineering/01-testing.md`, test the services and skip thin I/O glue; all UI strings present in `en` **and** `fa`.

**P1 — Clarity Lab**, including the judge, the calibration gate, the revision chain, and real-work practice against Goals/Projects.
**P2 —** FSRS-class scheduling; adaptive difficulty in calibrated practice; item retirement and bank rotation; the aggregate research export.

**Bilingual content is not a phase — it is a lane inside P0 and P1.** Each tool ships `en` + `fa` together or it does not ship. Sequence inside the lane: spec (once) → `en` surface → `fa` draft via Batch API → native review, probe items first at full review depth, practice pool after at lighter depth (§5.1). The parity validator runs in CI from the first item. Freezing the rubric before `fa` authoring starts is a hard gate, not a nicety.

**Outcome targets** (stated so the tool can fail honestly): Evidence Lab — strict lateral-and-accurate composite up ≥25 percentage points baseline→post (published instruction moves ~9.5% → ~46.6%), **and** ≥70% of that gain retained at the 7-day delayed probe, **and** no rise in false alarms on true-claim control items — a learner who has merely become distrustful has not learned the skill. Clarity Lab — mean rubric total up ≥3 of 12 baseline→post with no criterion regressing, and a positive draft→revision delta that *narrows* over time (the skill migrating into the first draft is the actual win).

## 15. Risks

| Risk | Mitigation |
|---|---|
| **Judge drift** — a model update silently shifts scores | Pin `judgeModelVersion`; re-run the calibration gate on change; break the chart series at the version boundary |
| **"Checkbox clarity"** — learners write to the detectors and score well while communicating worse | Detectors are necessary-not-sufficient; a criterion can't reach level 2 on surface features alone; real-work practice and the reader-misread mechanic are the counterweight |
| **Blanket distrust** instead of discrimination — friction is known to shift reliance without improving good/bad discrimination | True-claim control items in every form; report hit-rate *minus* false-alarm rate, never raw skepticism |
| **Item memorization** across three timepoints | Parallel forms A/B/C, matched and counterbalanced; retire items from the probe pool once seen in practice |
| **Practice effect** confounded with learning | Same instrument at all timepoints; different forms; delayed probe as the arbiter |
| **Delayed-probe no-show** — the whole retention question dies quietly | Scheduled `SkillProbe` row with a due surface on the tool home and one Today line; report completion rate as a first-class metric |
| **Friction rated unpleasant** — the most effective designs score worst on satisfaction | Expected; keep friction inside the Labs, don't export it to Tracker, and don't tune it away on satisfaction telemetry alone |
| **AI cost per attempt** | Detectors first; judge only where needed; per-user daily caps; Sonnet for practice, Opus for probes |
| **Privacy** — real work sent to a third party | Explicit per-tool consent; genuine no-AI mode; Evidence Lab fully functional without any LLM |
| **Abandonment after modules** | Real-work practice is the retention strategy, not streaks — the tool has to be useful on live work or it will be finished and closed |

## 16. Decisions — settled 2026-07-26

1. **External LLM access — approved.** §11 stands as written. Evidence Lab still ships without needing it, which is why it goes first.
2. **Judge model tier — as specced.** `claude-opus-5` for probe-grade judging, `claude-sonnet-5` for high-volume practice feedback, calibrated separately, never pooled (§7).
3. **Persian content — required at launch, both tools.** Not a phase-2 gap. §5.1 is the cost model that makes it affordable: spec/surface split, LLM drafting via Batch API with native review, English sources permitted for Persian evidence items, Persian linguistic work scoped to rubric criteria R4 and R6, review depth tiered by measurement weight.
4. **Names — "Clarity Lab" / "Evidence Lab" stand for now.** The collision with the existing Clarity Check is left in place deliberately; revisit as a Root-brand call, not an engineering one.
5. **Sideways panel — split by mode.** Assessment and probes use an in-app panel over **frozen, pre-fetched result snapshots shipped in the content pack** — no live search call, perfect reproducibility, and a *better* instrument than live search because every learner sees the same evidence surface. Practice uses a plain new tab with paste-back. See `02-evidence-lab.md` §5.

6. **Native Persian reviewer — secured** (2026-07-26), at a cost low enough that reviewer time is no longer a rationing constraint. Consequences: full review on every item in both locales (§5.1 cut 3 withdrawn), and the `fa` judge calibration gate becomes achievable, so Persian scores are measurement-grade rather than feedback-only (§7).

### Still open

- **Reviewer hours and ramp-up schedule.** Money is no longer the constraint; calendar time and rubric training are. Sequence by leverage: `fa` calibration anchors → R4/R6 linguistic rewrite → probe surfaces → practice pool.
- **Whether to author a minority of Persian-source evidence items.** English corroborating sources stay the default on authenticity grounds (§5.1 cut 1), but with review time cheap it is now affordable to add a handful of items with genuine Persian sources where good ones exist — worth it if Persian-language checking is a skill you want trained explicitly rather than assumed away.

---

## Changelog

- **0.3 · 2026-07-26** — Native Persian reviewer secured at negligible cost. Withdrew the tiered-review compromise (§5.1 cut 3) — full review on every item in both locales. Extended the judge calibration gate to `fa` (§7), which moves Persian from feedback-only to measurement-grade. Constraint restated as reviewer hours and rubric training rather than money.
- **0.2 · 2026-07-26** — Decisions settled (§16). External LLM approved; judge tiering confirmed. **Persian content moved from a P2 gap to a launch requirement**, with §5.1 added as the cost model (spec/surface split, parity validator, Batch-API drafting + native review, tiered review depth). §7 gained the judge caching structure and cost figures; §14 gained the bilingual lane.
- **0.1 · 2026-07-26** — Initial spec. Derived from the "Working With AI: The Durable Skills" brief plus supporting literature (Grice; Williams; Graham & Perin 2007; Wineburg & McGrew 2017/2019; Caulfield's SIFT; Brodsky et al. 2021/2023; Buçinca et al. 2021 on cognitive forcing; analytic-rubric reliability and LLM-as-judge calibration work; mastery-threshold and spacing research). Grounded against Tracker's conventions, data model, and module tree on this date.
