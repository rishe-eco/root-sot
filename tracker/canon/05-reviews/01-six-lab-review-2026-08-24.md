# Persona review pass 3 — all six skill labs

*Findings from walking Evidence, Clarity, Decomposition, Verification, Delegation and Monitoring as personas A and B. Grade: **as-built**, verified live against api :4000 and client :5173 on 2026-08-24, with every suspected bug confirmed in source or in the dev DB before being written down.*

**Version 1.3 · Status: living · 2026-08-25 · Owner: _root**

Method, personas and metric definitions: `00-persona-review-method.md`.

**Sections 1–7 are the report as delivered, when nothing had been fixed — the pass was report-only by instruction. §8 records the remediation that followed on the same day, once that instruction was lifted. The scores in §3 are pre-remediation and were deliberately not re-taken.**

---

## 1. Setup and coverage

Two fresh accounts, `persona-a3@example.test` (fa) and `persona-b3@example.test` (en), registered through the UI with `localStorage` cleared first. Both dev servers were already running; `client/.env.local` was already in place.

Committed attempts: Evidence 2 (A) + 1 (B), Clarity 1 draft + 1 revision (A) + 1 draft + 1 revision (B), Decomposition 1 control (A) + 1 control (B), Verification 1 (A), Delegation 1 estimate (A) + 1 split (B), Monitoring 1 recall (A) + 1 transcript (B). All four real-work entry screens read in English. Both personas walked all six landing pages.

**All six labs' probe items are still `key-unverified`** (`../../../team/open-work.md` items 1, 4, 7, 10, 12), so the scored assessment path refuses to open in every lab. That is correct behaviour and this pass could only review it as "does the refusal read honestly to a newcomer" — it does, see §3.

## 2. The five pass-2 remediation items are all landed

Verified in source and, where observable, live:

| Item | State |
|---|---|
| 1 · Drop `R1` from `DETECTOR_CRITERIA_BY_LOCALE.fa` | Landed — `fa: []`, with a comment recording that restoring it means authoring Persian detectors, not re-adding the entry |
| 2 · Derive the unscored count from the locale | Landed — en shows exactly three criteria needing the scorer, fa shows six, both matching `detectorCriteriaFor()` |
| 3 · Add `have` and a light-verb phrasal to R1 | Landed — "Please have a look at clause 14 … and tell me whether I am allowed to keep a cat" now scores R1 1/2 with a correct finding ("2 separate requests, with no stated priority between them"), not "No identifiable request" |
| 4 · Update `checkBody` to say "Check another source" | Landed |
| 5 · Echo the quote back after "Add source" | Landed — both the URL and the settling line are displayed |

Also confirmed fixed from pass 1: the language modal has `role="dialog"`, `aria-modal` and `aria-labelledby`; onboarding is scoped to `/today` and does not fire inside a lab; "Close for now" persists across navigation; slide 7 offers a finish CTA; the tour says "Welcome to Tracker", not "Root"; Clarity's module titles are translated; the reader/scorer collision is resolved in both locales; metric rows carry text state; mastery gates are translated structured codes.

## 3. Scores

Per lab, per persona, 1–5. Evidence and Clarity are the only two with a prior; the four newer labs have none.

**Persona A (Persian)**

| Lab | Purpose | Use | Distinction | Feedback | Recoverability | Parity |
|---|---|---|---|---|---|---|
| Evidence | 5 | 5 | 5 | 4 | 4 | 4 |
| Clarity | 4 | 4 | 3 | 2 | 3 | 3 |
| Decomposition | 3 | 4 | 4 | **1** | 4 | **1** |
| Verification | 3 | 3 | 4 | **1** | 4 | **1** |
| Delegation | 3 | **2** | 5 | 2 | 3 | 3 |
| Monitoring | 3 | **2** | **2** | **1** | 3 | **1** |

**Persona B (English)**

| Lab | Purpose | Use | Distinction | Feedback | Recoverability |
|---|---|---|---|---|---|
| Evidence | 5 | 5 | 5 | 4 | 4 |
| Clarity | 4 | 4 | 3 | 3 | 4 |
| Decomposition | 3 | 4 | 4 | 3 | 4 |
| Verification | **2** | 3 | 4 | 3 | 4 |
| Delegation | 3 | 4 | 5 | 2 | 4 |
| Monitoring | 3 | **2** | **2** | **1** | 3 |

**Evidence Lab is the healthiest tool in the engine by a wide margin, in both languages.** It is also the only one that has been through two prior review passes, which is most of the explanation.

Clarity's B-side feedback score reads 3 against pass 2's 4. That is a **stricter reading, not a regression** — pass 2 confirmed the inverted-incentive fix, which holds; this pass additionally counted the diagnosis-vs-unscored co-presence, the stale delta caption and the floating denominator, none of which pass 2 examined.

## 4. Verified blockers

### 4.1 Persian-Indic digits never match any answer key

The one that inverts a measurement silently, and the third instance of the recurring locale-layer pattern.

Answering `۱۰۰ درجه` to `نقطه جوش آب در سطح دریا، بر حسب سلسیوس چند درجه است؟` — correct — was scored wrong. The `SkillAttempt` row records `responseStructure {"rating":9,"prediction":"confident","correct":false}` and `predictionSample {"prediction":"confident","outcome":0}`.

`monitoring/v1/surface.fa.ts` authors that item's variants as `["100", "صد", "100 درجه"]` — **Latin digits only** — and `normalizeAnswer` (`api/src/services/skills/monitoring/answerMatch.ts:17`) is NFKC + lowercase + strip punctuation. NFKC does not fold U+06F0–06F9 (Persian-Indic) or U+0660–0669 (Arabic-Indic) to ASCII; confirmed directly.

**Scope: 16 of the 33 `fa` items carrying answer variants have Latin-digit-only keys** — `s1-p01u`, `s1-p02u`, `s1-p04u`, `s1-p05u`, `s1-a01u`, `s1-b01u`, `s3-p06`, `s3-a05`, `s3-a06`, `s3-b02`, `s3-b04`, `s3-b05`, `s3-b06`, `s3-c01`, `s3-c02`, `s3-c03`. **Ten are `s3-*`** — the resolution module, whose entire output is gamma, bias and performance. So Monitoring's headline measurement for a Persian learner is computed off systematically mis-scored answers, in the direction of understating their accuracy and therefore overstating their overconfidence.

Aggravating: the `fa` pack's own prose uses Persian digits throughout (`۲۵ سانتی‌متر`, `بند ۱۴`), so the content teaches Persian numerals and then accepts only Latin ones.

**Two candidate fixes.** Fold both Indic digit ranges in `normalizeAnswer` — one `replace`, and it covers every item and every future one. Or add Persian-digit variants to all 16 items — sixteen edits, and the next authored item reintroduces the bug. The normalizer is the real fix. Note that `../../../team/open-work.md` item 12 already scopes an answer-variant review; this finding is the specific thing that review should be briefed on.

### 4.2 The per-criterion "why you scored this" is hardcoded English in four labs

The scores are right; the reasons are unreadable to a Persian learner. Counted in source:

| Lab | English `evidence` strings | Reach |
|---|---|---|
| Decomposition | 28 (`detectors.ts`, `keyScoring.ts`) | every reveal |
| Verification | 15 (`detectors.ts`) | every reveal |
| Delegation | 2 (`scoring.ts`) | edge cases only |
| Monitoring | 2 (`scoring.ts`, `monitoringSession.ts`) | edge cases only |
| Clarity | 0 | — |
| Evidence | 0 | — |

Observed live on a Decomposition control item, inside an otherwise fully Persian screen: *"The done condition is present but not bounded — no date, count, or state-change verb."*, *"Nothing to overlap."*, *"Left whole, as the task already was."*, *"No dependency to mark."*, *"Nothing required beyond the whole itself."*

**Verification is worse than Decomposition**, because the string reaches the headline: `client/app/components/skills/VerificationSessionPage.tsx:545` passes `ritualLine={v3?.evidence ?? ""}`, so V3's raw English evidence becomes the top-level result line of the whole attempt.

This is the same class as the mastery-gate English-string defect that *was* fixed after pass 1 — the fix was applied to the gates and not to the criterion evidence.

### 4.3 Monitoring shows the learner nothing about a completed item

Locale-independent; it hits B as hard as A.

After predict → answer → rate, the reveal reads *"RESULT — not scored"* with all six criteria *"not scored"*. It does not show whether the answer was right, what the right answer was, what prediction was committed, or what rating was given. The lab page then shows only "in progress". `monitoringProgress` after one attempt: `totalAttempts 1, resolutionSampleCount 0, resolution/performance/bias/postAiInflation all null`.

**The design reason is sound and documented** — S1 and S3 are window-level patterns, not per-attempt criteria, so a single attempt genuinely has nothing to score. But the consequence is that the one tool whose entire premise is *predict, then measure against what happened* shows a learner a blank screen at exactly the moment the measurement was supposed to land. Two independent gaps compound it:

- The committed prediction disappears the moment it locks. The answer step shows only the question and an empty box. Evidence Lab echoes the committed verdict at reveal; Monitoring never does.
- The felt-understanding step renders *"How well do you understand this? (0 to 10)"* with a slider and nothing else on the page — question, answer and prediction all gone. **"this" has no referent on screen**, which is Clarity Lab's own R4 criterion violated by the app's own UI.

## 5. Verified bugs, not blockers

**One screen, three truth claims (Clarity, both locales).** *"YOUR DIAGNOSIS — Spotted R2 / Missed R3 / Flagged but fine R5"* sits directly above *"R2 not scored / R3 not scored / R5 not scored"*, and the reveal prose asserts *"R2 = 0"* flatly. So the screen says R2 was correctly spotted as failing, that R2 was never assessed, and that R2 scored zero. "Flagged but fine" is worst: a definitive wrong-answer verdict on a criterion the same screen says nothing evaluated. Structurally the same defect as pass 1's worst screen, now driven by authored-key-vs-unscored rather than by the inverted comparison.

**Two denominators on one screen (Decomposition, Clarity, both locales).** The reveal reads *"TOTAL 8 / 10 · 5 of 6 criteria scored"* while the mastery gate on the same screen reads *"0 of 2 attempts scoring 10+ out of 12"*. The total's denominator floats with how many criteria happened to score; the gate quotes a fixed /12. A learner cannot compare their 8/10 to a 10/12 bar.

**The draft→revision caption is static (Clarity, Decomposition).** In Clarity it reads *"Only set once you've rewritten"* both before the rewrite (correct) and after it (false — the value is there). In `fa`, where nothing is scorable, the value stays "—" so the stale caption reads as the explanation. In Decomposition the same slot is filled with D4's explanation — *"Split into more than one piece — this task was already checkable as one"* — which says nothing about a delta at all.

**The residual bucket's copy over-claims (Delegation, both locales).** Own 1100, advice 1150, final 1120, truth 1105 → WOA 0.40, net gain **−10**: the shift made the answer worse. `relianceDirection` (`api/src/services/skills/delegation/woa.ts:59`) needs WOA > 0.5 for "over", so 0.40 falls through to "ok" and the reveal prints *"Your movement roughly matched what the advice was worth here."* directly beside `net gain −10`. "ok" is the residual bucket, not a verdict of correctness; the copy asserts it is.

**A wrong attempt opens with a compliment (Verification, both locales).** The ritual-first reveal is the documented design, but promoting one criterion's evidence to the headline means a failed attempt (V6 0/2, verdict did not match the key) leads with the positive V3 finding.

**The scored criterion is the least legible row (Delegation, Monitoring).** Their criterion-by-criterion block reuses the rubric-rail component, so the one criterion that actually scored renders as two small filled squares with no number, while the five that did not get the explicit words "not scored". Verification and Decomposition print "2 / 2" as text in the same position. This is pass 1's "scored-metrics row is icon-only" finding — fixed in Evidence Lab by adding text state — shipping again in two new labs.

**Monitoring names a count but never the miss.** *"1 of 2 planted influence(s) found, 0 false alarm(s)"* — and nothing says which second influence was planted, or where. For a tool teaching you to spot influence, the one thing the learner needs is withheld. The same sentence is also printed twice, once as the headline and once under "WHY IT SCORED THIS WAY", with the count formatted differently ("1 of 2" vs "1/2").

**`(s)` pluralization artifacts, English only.** 14 in `en/common.json`, **seven of them in the skills labs**: `skills.probe.notReady`, `skills.mastery.falseAlarms`, `decomposition.realWork.doneBody`, `verification.mastery.falseAlarms`, `verification.mastery.ritual`, `monitoring.influenceSummary`, `monitoring.deflation.droppedFact`. `fa` has zero. This is pass 2's `"12 item(s)"` artifact, unfixed and now propagated to five new keys.

**Raw markdown reaches the learner, both locales.** Clarity's tenancy-agreement item body renders `**1. Parties and premises.**` and `*(continues for nine hundred words…)*` with literal asterisks. Content-pack-wide, not locale-specific.

**Untranslated pip label.** All five rubric rails hardcode the aria-label as `` `${level} of 2` ``.

**`fa` state-change lexicon misses negation.** `FA_STATE_CHANGE_VERBS` holds only positive past forms (`ثبت شد`, `ارسال شد`). A negated done-condition — a natural Persian way to state completion, e.g. *"توی سیستم به اسم من ثبت نباشه"* — can never match, so a legitimately bounded condition scores D1 1/2. The detector is conservative by design and its Unicode handling is correct (the file explicitly cites the pass-2 `\b` bug); this is a lexicon gap, not the same class of defect.

**Delegation's estimate field silently refuses Persian digits.** It is `<input type="number">`, so `۱۱۰۰` yields an empty value with no error message. A better failure mode than §4.1 — visible rather than silent — but it blocks entry.

## 6. Cross-cutting: what the four new labs inherited and what they didn't

**They did not inherit the landing page.** Evidence and Clarity — the two labs that went through passes 1 and 2 — each carry a numbered "how a sitting works" walkthrough and a "the only thing worth knowing before you start" block. **Decomposition, Verification, Delegation and Monitoring all go from a one-line pitch straight to a start button**, with only a dismissible inline tour carrying the explanation. This is the single largest reason their purpose scores sit at 3 where Evidence's sits at 5.

**Rubric-rail glosses are inconsistent.** Evidence, Clarity and Decomposition describe each criterion on the rail. Verification and Monitoring list bare names — *"V3 Falsifiability"*, *"S3 Resolution"* — and in Monitoring's case S3 is the tool's headline number.

**The Tools hub still describes two skills above six labs.** `toolsHome.skillsDescription` reads *"…saying precisely what you want, and checking what comes back"* — the two original labs — above six lab rows, in both locales. This is pass 1's Observation 1 surviving in a new form. Each lab now has its own one-line description, which is the part that was fixed.

**The 7-slide first-run tour never mentions Tools or the labs at all.** Its final slide offers "Create my first goal", "Open the Guide" and "Finish". A new user is told about goals, intervals, rituals and journals; the six labs are undiscoverable from onboarding.

**Six labs, no recommended order.** Every lab says "you don't have to do the modules in order" and nothing says where to start among the six. For B this is the first decision they cannot make.

**Persian register splits by lab and inside single screens.** Evidence and Clarity are formal (`می‌خواهی`, `بتواند`); Decomposition, Verification and Monitoring are colloquial (`می‌ده`, `می‌تونی`, `چکشون`) — which is the register `../../../team/open-work.md` §2 and D-20 actually intend. But the two *shared* banner strings on every lab page are formal, so Decomposition's own page mixes both registers, and Monitoring pairs formal body prose with colloquial module titles.

**Digit convention differs per content pack.** Verification's `fa` content uses Latin digits (`90 متری`, `0.28`) — canon-compliant per `04-conventions.md` §7d. Evidence, Clarity and Monitoring use Persian digits in prose. Mastery gates are Latin in Decomposition and Verification, Persian in Clarity. Thousands separators are Latin commas throughout.

**The `rung` badge means different things in the two locales.** `verification.rung` is `{assisted, unassisted}` in English; `fa` renders it as `با سقف` — "with a ceiling". Two different concepts for the same value, neither glossed on the page; the only place a ceiling is explained is `verification.promotion.offer`, which a new user never reaches.

**Jargon that stops B**, in severity order: **"oracle"** (Verification — "naming an oracle before you look", rubric "V1 Oracle named"; to a management student this reads as a fortune-teller), then *falsifiability*, *localisation*, *honest closure*, *"Access separated from possession"*, *"Agreement discounted"*, *"Cue quality"*, *"Stakes read"*, and *discrimination* still leading as Evidence's headline score name.

**One dead end.** Decomposition's real-work page on a fresh account correctly disables "Decompose this" and says *"No goals or projects yet — add one first"* — but offers no link to go create one. It is the second CTA on the Decomposition lab page, so every new user hits it.

## 7. Ranked, by score gained per unit of work

1. **Fold Indic digits in `normalizeAnswer`.** One `replace` in `answerMatch.ts`. Takes Monitoring's A-side feedback from 1 to ~3 and, more importantly, stops the tool reporting a Persian learner as overconfident when they were right. §4.1.
2. **Move the four labs' `evidence` strings behind translation keys.** 45 strings; Decomposition (28) and Verification (15) are the ones that matter. Takes A's Decomposition and Verification feedback and parity from 1 to ~4 each — the largest single block of score in the pass. §4.2.
3. **Give Monitoring's reveal something to say.** Show the outcome, the key, the committed prediction and the rating on the item's own reveal, and keep the question on screen through the rating step. Window-level criteria can stay window-level; the attempt still has facts. §4.3.
4. **Stop the criterion rail from being the score display in Delegation and Monitoring** — print "2 / 2" as text the way Verification and Decomposition already do.
5. **Fix the four copy-vs-state contradictions:** the diagnosis/unscored co-presence, the floating denominator, the static delta caption, and Delegation's `okNote` printed beside a negative net gain. Each is a small copy or condition change and each removes a screen that says two things.
6. **Give the four new labs Evidence's landing page.** The largest purpose-score gain available, and it is writing, not engineering.
7. **Say six skills on the Tools hub, add a starting point, and put the labs in the first-run tour.**
8. **Gloss the terms that gate B** — "oracle" first — and reconcile the `rung` badge across locales.
9. **Sweep the seven `(s)` artifacts** and render the content packs' markdown.

Items 1–3 are what stand between Persona A and a usable Persian product. Items 4–6 are what stand between Persona B and the four new labs reading as finished.

## 8. Remediation — 2026-08-24, same day

*Every item below was applied after the report, verified against the running dev servers, and covered by the test suites (API 798 → 812, client 182, all passing) unless noted. Ranked-list numbering follows §7.*

### What landed

**1 · Persian-Indic digits (§4.1, S-1).** `normalizeAnswer` now folds U+06F0–06F9 and U+0660–0669 to ASCII before matching. Two folds were added alongside, because they are the same defect and the same one-line fix: Arabic↔Persian *yeh* and *kaf* (keyboard variants of one letter), and harakat/tatweel. Neither can collapse two *different* answers into one string, so neither can produce the false accept the file's own header warns against — that reasoning is now written into the header. **Verified live:** a `fa` request answering `۳۰۰۰۰۰` against the shipped key `"300000"` returns `correct: true`; before the fix the same request recorded `correct: false`. Seven unit tests added.

**2 · Criterion evidence, localised (§4.2, S-2).** Every hardcoded English `evidence` string in Decomposition, Verification, Delegation and Monitoring now resolves per locale. The mechanism deliberately keeps the wire format a plain `String!` — the server already knows the request locale (D-22) and the content packs are already per-locale, so the string resolves server-side next to the surface it explains. No schema change, no client change, no locale-JSON churn. Tables live at `content/skills/<lab>/v1/evidence.ts` behind a shared `makeEvidence` helper whose `Record<Locale, Record<Key, string>>` type makes a missing translation a compile error. **Verified live:** a `fa` Decomposition attempt returns all six criterion lines in Persian; a `fa` Monitoring attempt likewise. Register was corrected to second person while translating — several English lines were written *about* the learner ("the learner correctly closed…") on screens addressed *to* them.

**3 · Monitoring's reveal (§4.3, S-3).** `MonitoringScore` gained `answerOutcome { yourAnswer, correct, acceptedAnswer }`, populated on recall and on the answered half of a pair. The reveal now headlines *Correct / Not correct* instead of "not scored", shows the answer beside the key, states the prediction-versus-outcome pair, and says in one sentence why the criteria are blank — which is true and was never on the page. The committed prediction now persists through the answer step, and both rating steps echo what is being rated. Window-level scoring of S1/S3 is unchanged; this is the outcome, not a score.

**4 · The rail is no longer the score display (S-4).** Five near-identical `Pips` copies collapsed into one `RubricPips`, which prints the numeral (`2 / 2`) beside the pips and takes a localised aria-label. That is also where the three parallel bugs came from, so the component carries the note.

**5 · The four copy-vs-state contradictions (S-5).**
- (b) The reveal's total now names its own denominator — "4 of 6 criteria scored, so this total is out of 8" — and the mastery gate says the 12 needs all six criteria scored.
- (c) The draft→revision caption switches once a delta exists.
- (d) **`relianceDirection` gained a fourth bucket, `costly`** — see D-50. `ok` now means the move did not cost accuracy.
- Verification's reveal keeps its ritual-first headline but carries the verdict with it, and a wrong verdict holds the banner amber on its own. **Verified live:** a deliberately wrong verdict now renders `border-amber-500/40` and "Your verdict did not match the key," where it previously opened green.
- (a) **The two texts are now named.** The diagnosis panel says *"Marked against the draft you were given — the faults that were in it, not the ones in your rewrite"*, the criterion block says *"These score your rewrite, which is a different text from the one you diagnosed above"*, and the authored commentary already said *"What was going on in the text above"*. Three claims, three named objects. The flag driving those labels (`diagnosisIsAboutItemText`) is derived from the **same predicate that picks the diagnosis key**, so a label cannot drift away from the grading behind it — which is the failure mode that produced the finding. The `unverifiable` bucket that handles the judge-off case already existed and was working. **Verified live** on `cl-p6`, the tenancy-agreement item the finding was written from.

**6 · The four new labs got a landing page (S-11).** One shared `HowASittingWorks` component — numbered walkthrough, plus the "one thing worth knowing before you start" block — with authored `how` copy for Decomposition, Verification, Delegation and Monitoring in both locales. Clarity's own copy now points at the same component. Evidence keeps its bespoke version (it carries per-step icons).

**7 · Tools hub and first-run tour (S-11).** The hub says six labs, and Evidence Lab carries a **Start here** badge — it is the only lab needing no vocabulary from the others. The closing tour slide now names the labs and links to one.

**8 · Glosses and the `rung` badge (S-11).** Verification, Delegation and Monitoring rubric rails gained one-line `test` glosses for all eighteen criteria, matching Clarity's and Decomposition's, and the standing rail shows them until a criterion actually scores. "Oracle" is now glossed in three places a first-time reader passes through: the walkthrough step, the V1 gloss, and the reveal. `verification.rung` reads "with a cost ceiling" / "no cost ceiling" in English, matching what `fa` already said — the Persian was the better copy and the English was brought to it.

**9 · `(s)` artifacts and markdown (S-8, S-9).** All seven skills-lab artifacts are now real i18next `_one`/`_other` pairs; `decomposition.realWork.doneBody`, which had two independent counts in one sentence, was split into composable counted phrases. `authoredMisread` renders through `RichText`. `weakText` deliberately does not — it is a verbatim prompt the learner is asked to critique and has to be the exact characters that were sent.

**S-6 · Monitoring now names the influence it says you missed.** The count was legible after item 9, but *"Planted influences found: 1 of 2"* still refused to say which. `MonitoringInfluenceResult` gained `plantedTurns { turnId, type, found }` and the reveal lists each planted turn with its kind and its text.

Three constraints shaped it, and each is worth keeping:

- **It is a separate read-only block, not a mode on `TranscriptAudit`.** That component's contract is that a planted turn and a clean turn are *visually identical* — asserted in its own test, because any difference destroys the instrument. Marking it up "only after commit" would put that styling one state bug away from the live transcript.
- **`type` is a closed enum, so the reveal is localised for free.** `flattery | anchor | smuggled_premise | agreement_reversal` → four translation keys. The item's `keyNote` — authored prose that describes exactly what each planted turn did — is deliberately *not* used: it is English-only spec text, and putting it on the reveal would recreate blocker 2 on a Persian screen.
- **A clean control reveals nothing at all**, rather than an empty block. An always-present "what was planted" heading is itself a tell about item type.

Safe because **items are never re-served**: `startMonitoringItem` filters out every `itemId` the learner has already attempted, so the measurement of an item is complete before its key is shown. That fact is what decided the build-versus-wait question — without it the reveal would turn a re-served transcript into a memory test. **Verified live in both locales**, including that the served item's payload contains no `planted` field; two integration tests cover the reveal and the clean-control silence, and a third asserts the key never appears on a served item.

**Also fixed, outside the ranked list:** S-7 (Delegation's `<input type="number">` silently discarding `۱۱۰۰` — now a text field with one `toNumber` fold), S-10 (`FA_STATE_CHANGE_VERBS` held only positive past forms, so a negated Persian done-condition could never match; negated forms are now derived from the positive list so a future verb cannot be added to one and forgotten in the other), and the real-work dead end in all four labs that have one — the empty state now offers "Create a goal" and "Practise on a module instead".

### What is still open

| | Why it was not done |
|---|---|
| **Persian register drift** | `verification`'s `fa` block is formal (`می‌گوید`, `است`) where the content packs are informal (`تو`/`کن`). A translation pass, not a defect fix; it should be done in one sweep by a native reviewer rather than string by string. |
| **`(s)` outside the skills labs** | `intervals.repeatUnit*` and `projects.projectHasActionsPrompt` carry the same artifact. Out of this review's scope; recorded here so the next sweep has the list. |

### What this pass did not re-measure

The scores in §3 are pre-remediation. **They were not re-scored after the fixes** — a re-score by the same reviewer on the same day measures memory, not usability. Pass 4 should re-run the tiered procedure on fresh accounts and record its own numbers.

---

## Changelog

- **1.0 · 2026-08-24** — Initial file. Pass 3 of the persona review, first pass covering all six labs. Confirms all five pass-2 remediation items landed; records three blockers (Persian-Indic digit matching, hardcoded English criterion evidence in four labs, Monitoring's empty reveal), eleven non-blocking bugs, and the cross-cutting finding that the four labs built after passes 1–2 did not inherit the landing page, rail glosses or score-display fixes those passes produced. Report-only by instruction; nothing fixed.
- **1.1 · 2026-08-24** — Adds §8, the same-day remediation: three blockers and eight of the eleven bugs fixed and verified live, with what was left open and why. The §3 scores are pre-remediation and were deliberately not re-scored — see D-50.
- **1.2 · 2026-08-24** — S-5a closed: Clarity's reveal now names which text each half of the screen is about, driven by a server flag derived from the same predicate that picks the diagnosis key. Test counts corrected (the earlier line misstated the baseline).
- **1.3 · 2026-08-25** — S-6 closed: the reveal now names each planted turn and its kind, in either locale. Records the three constraints that shaped it and the fact that decided build-versus-wait (items are never re-served, so a revealed key cannot contaminate a later attempt).
