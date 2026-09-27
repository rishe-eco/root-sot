# Tracker — Persona review pass 4, all six skill labs

*Fresh accounts, both personas, all six labs, the day after pass 3's remediation. The first pass that can say whether those fixes worked. Method, personas and metrics: `00-persona-review-method.md` — not redefined here.*

**Version 1.0 · Status: as-built findings · 2026-08-25 · Owner: _root**

---

## 1. Setup and coverage

Two new accounts registered through the UI (`persona-a4@example.test`, `persona-b4@example.test`), `localStorage` cleared first so first-run onboarding fired for both. Dev servers already running: API on `:4000`, client on `:5173`, `client/.env.local` present, no `ANTHROPIC_API_KEY` — so Clarity's judge is off, per the standing environment note.

The running API was confirmed to be serving the remediated code before anything was scored (`MonitoringScore.answerOutcome` present in the schema). This mattered: a dev server started before the remediation would have invalidated the whole pass. Pass 3’s fixes are commit `52288d9`, “fix everything persona review pass 3 found across the six skill labs”.

**Covered.** Persona B (en): all six labs, landing → commit → reveal, plus a deliberately wrong path in Evidence, an over-decomposition control in Decomposition, and a `CORRECT`-profile item in Verification. Persona A (fa): all six labs, with the three pass-3 blockers re-tested at their exact original items.

**Not re-measured.** Real-work entry screens (unchanged since pass 3, whose dead-end fix is recorded as landed); the delayed-probe path (still correctly closed — every lab's items remain `key-unverified`); S-6's planted-influence reveal.

One deviation from procedure: `persona-a4` was created through the API rather than the UI, because the UI's Register control did not respond — which turned out to be S-19 below. First-run onboarding is `localStorage`-driven and fired normally, so no lab measurement is affected.

## 2. The pass-3 remediation: what actually holds

Verified live, not read from the diff. All three blockers are genuinely fixed.

| Pass-3 item | Verdict |
|---|---|
| **S-1** Persian-Indic digits | **Fixed.** `۱۰۰ درجه` on the original boiling-point item now returns **درست**. |
| **S-2** English criterion evidence | **Fixed, and better than specified.** Persian evidence in Decomposition and Verification, in second person, in the packs' own colloquial register. |
| **S-3** Monitoring's empty reveal | **Fixed.** Headline is the outcome, answer sits beside the key, prediction-vs-outcome is stated, and one sentence explains why the criteria are blank. |
| **S-4** rail as score display | **Fixed.** `2 / 2` prints as a numeral beside the pips. |
| **S-5a** Clarity's two texts | **Fixed.** Both panels name which text they are about, in both locales. |
| **S-5b** floating denominator | **Fixed.** "3 of 6 criteria scored, so this total is out of 6"; the gate says "needs all six criteria scored". The zero-scored case reads "no score — not a zero." |
| **S-5c** static delta caption | **Fixed in Clarity** (switches once a delta exists). **Not fixed in Decomposition** — see S-17. |
| **S-5d** `okNote` vs negative net gain | **Fixed.** The `costly` bucket fires and reads well in both locales. |
| **S-7** Persian numerals discarded | **Fixed.** `toNumber` folds Indic digits. Display caveat at S-21. |
| **S-8 / S-9** `(s)` artifacts, markdown | **Fixed.** No literal asterisks; counted plurals. |
| **S-10** negated Persian verbs | **Fixed — and it introduced S-14b.** |
| **S-11** landing pages, glosses, hub, tour | **Fixed.** All four new labs have a numbered walkthrough; "oracle" glossed in three places; hub says six labs with a **START HERE** badge; tour slide 7 names the labs and links to Evidence. |

**Score movement is real.** Monitoring for Persona A went from `3/2/2/1/3/1` to `4/4/4/4/4/4` — the largest single-lab movement recorded in four passes.

## 3. Scores

Per lab, per persona, 1–5. Taken before any pass-4 fix.

**Persona A (fa)**

| Lab | Purpose | Use | Distinction | Feedback | Recover | Parity |
|---|---|---|---|---|---|---|
| Evidence | 5 | 5 | 5 | 5 | 4 | 5 |
| Clarity | 4 | 4 | 4 | 3 | 4 | 3 |
| Decomposition | 4 | 4 | 4 | 3 | 4 | 3 |
| Verification | 4 | 3 | 4 | 4 | 3 | 3 |
| Delegation | 4 | 4 | 5 | **2** | 4 | 4 |
| Monitoring | 4 | 4 | 4 | 4 | 4 | 4 |

**Persona B (en)**

| Lab | Purpose | Use | Distinction | Feedback | Recover |
|---|---|---|---|---|---|
| Evidence | 5 | 5 | 5 | 5 | 5 |
| Clarity | 4 | 4 | 5 | 3 | 4 |
| Decomposition | 4 | 4 | 4 | 3 | 4 |
| Verification | 4 | 3 | 4 | 4 | 3 |
| Delegation | 4 | 4 | 5 | **2** | 4 |
| Monitoring | 4 | 4 | 4 | 4 | 4 |

Two numbers did **not** move and one went down. Delegation's feedback stayed at 2 for both personas (S-16). Verification's recoverability fell from 4 to 3 (S-15 — found this pass, not a regression: it was always there, and pass 3 did not walk a `CORRECT`-profile item). Feedback legibility remains the lowest-scoring metric, for the fourth pass running.

## 4. The headline finding — the same defect, one layer over

**Pass 3's blocker 1 is fixed where it was found and still live one module away.**

`normalizeAnswer` now folds Persian-Indic and Arabic-Indic digits to ASCII. Decomposition's boundedness check does not:

```
api/src/services/skills/decomposition/detectors.ts:126
const FA_NUMERIC_BOUND = /\d+/;   // Western digits only
```

Run against `isBounded`:

| Done condition | Bounded? |
|---|---|
| `شام تا ساعت 7 آماده باشه.` | **true** |
| `شام تا ساعت ۷ آماده باشه.` | **false** |
| `هر 22 بند بررسی شده باشه.` | **true** |
| `هر ۲۲ بند بررسی شده باشه.` | **false** |

Decomposition's **own** `fa` content pack writes Persian numerals — `suppliedWhole: { statement: "تا ساعت ۷ که مهمون‌ها می‌رسن، شام آماده باشه." }` (`surface.fa.ts:501`). A learner who matches the numeral style the lab itself models scores D1 and D4 unbounded, and is told their condition has "no date, count, or state-change verb."

**Why it survived.** There is no shared fold. There are three independent implementations of one idea:

- `api/src/services/skills/monitoring/answerMatch.ts:28` — `INDIC_DIGITS`, correct.
- `client/app/components/skills/DelegationSessionPage.tsx:87` — its own regex literal, correct.
- `api/src/services/skills/decomposition/detectors.ts:126` — absent.

This is the fourth appearance of the shape §6 of the method file names, and the first time it has recurred *after* that file warned about it. Pass 3's remediation correctly generalised two other fixes into shared components (`RubricPips`, `HowASittingWorks`) and did not do the same for the digit fold — the one defect it had just called a blocker.

**Also relevant.** `04-conventions.md` §7d ("Western digits in both locales", enforced by a `no-persian-digits` validator rule) is not upheld in the packs. Persian digits per `surface.fa.ts`: clarity **58**, evidence **42**, decomposition **6**, verification **3**, delegation 0, monitoring 0. The rule exists only in the delegation, monitoring and verification validators — the two packs with zero, plus one with three that the rule's field scope does not reach (`verification` L69 is module `model` teaching prose, not item surface). Clarity's and Decomposition's validators have no such rule at all.

## 5. Verified defects

Numbered continuing the pass-3 series. Every one reproduced below the UI.

### High

- **S-12 · Persian numerals fail Decomposition's boundedness check.** §4 above. Affects D1 and D4, `fa` only. The fix belongs in one shared fold, not a third `replace`.

- **S-13 · Clarity's R6 penalises ordinary correct writing (en).** `NOMINALISATION = /\b\w{4,}(tion|sion|ment|ance|ence|ity)\b/gi` is suffix-only with no exceptions (`detectors.ts:158`), and `contains` is bare `String.includes` with no word boundary (`detectors.ts:237`). R6 deducts when ≥2 nominalisations co-occur with ≥1 "weak verb". Reproduced: **"Send me the documentation for the payment integration by Friday."** — a direct, active, deadline-bearing request — is penalised, because *"documentation"* matches the suffix regex **and** contains the substring `do`, supplying both halves of the test by itself. Live hit on my own rewrite: R6 `1/2`, *"The actions are hiding in nouns (agreement, sentence)"* — where "agreement" is the item's own subject noun and "sentence" is a length unit **the same file lists at `detectors.ts:145` as a legitimate R2 unit**. Stating a length in sentences, which R2 asks for, costs you R6.

- **S-14 · Decomposition D1 cannot read the words the items themselves use.**
  - **(a, en)** `EN_DEADLINE_DATE` requires a digit after the preposition and `EN_WEEKDAYS` holds only weekday names, so *"by tomorrow"*, *"today"* and *"tonight"* are not dates. `"The book is back at the library by tomorrow."` → unbounded, on an item whose own text is *"Return a library book that's **due tomorrow**."* Also `"checked in"` is absent from `EN_STATE_CHANGE_VERBS` though `"returned"` and `"handed back"` are present.
  - **(b, fa)** `FA_STATE_CHANGE_VERBS_POSITIVE` holds only formal written past forms. Pass 3's S-10 fix derived negations using the tails `["نشد","نشده","نباشه"]` — and `نباشه` is *colloquial*. Net result: `کتاب برگردانده نباشه.` (colloquial negative) is **bounded**, while `کتاب برگردونده بشه.` (colloquial positive) and `کتاب برگردانده بشود.` (formal subjunctive positive) are **not**. A learner scores better saying "the book is not un-returned" than "the book is returned" — and the `fa` pack is itself written in colloquial Tehrani.
  - **(c, parity)** `isBounded` gives English four routes (verb, numeric, weekday, deadline+digit) and Persian two (verb, digit). There is no `fa` weekday list and no `fa` deadline pattern. `"by Friday"` → bounded; `"تا جمعه"` → not. Identical content, different score, purely by locale.

- **S-15 · Verification requires naming a fault that does not exist.** `canCommit` (`VerificationSessionPage.tsx:286`) demands an element unconditionally on verdict, and the locus list has no "nothing fails" option — which **Evidence Lab does have** ("Nothing wrong"). `types.ts:106` maps profile `CORRECT` → verdict `supported`, and `spec.ts` has **9 such items**. Reproduced live on the `v1-oracle` heating item: verdict `supported`, commit blocked, forced pick of *"the multiplication itself"*, and the reveal then printed **V5 Localisation — not scored**. The app compels an assertion it discards. The disabled button also states no reason. Confirmed identical in `fa`.

### Medium

- **S-16 · Delegation's first module scores nothing, and the rail says otherwise.** `scoring.ts:12` states that G1 and G6 carry no per-attempt level; `CRITERION_BY_MODULE` maps `g1-own → G1`; and "Start your first sitting" lands on `g1-own`. So the first reveal a learner ever sees reads **"RESULT — not scored"** with all six criteria "not scored", while the rail caption (`en/common.json:1827`) promises *"A single item only trains one of these six lines — **the rest** read 'not scored'."* Same for `g6-drift` rounds 1–2. In fairness the screen is **not** empty — it carries you/final/advice/truth, the interval and the reliance note — so this is pass 3's blocker 4.3 in a milder form, surviving in the sibling lab that did not get the `answerOutcome` treatment.

- **S-17 · Decomposition's delta tile carries two subjects.** `DecompositionSessionPage.tsx:536-545`: the label is `overDecomposedLabel` — whose English **value is "Draft to revision"** (`en/common.json:1526`) — the number is `result.delta`, and the caption switches to the over-decomposition verdict when the item is a control. Live: `DRAFT TO REVISION / — / "Split into more than one piece — this task was already checkable as one."` Label and number are the delta; the caption is a different measurement. `overDecomposedNo` ("Left whole, correctly.") under the same label is worse. Confirmed in `fa`. Pass 3's S-5c fixed Clarity's copy of this tile and not Decomposition's.

- **S-18 · Verification's `fa` now mixes registers inside one screen.** The remediation translated criterion evidence into colloquial second person (`evidence.ts`: "زدی", "مربوطه", "کاره") while the pre-existing chrome stayed formal (`fa/common.json`: `unscoredHint` — "نمی‌تواند", "می‌شود"). They now render adjacent. One reveal carried three different renderings of *your verdict matched the key*: "حکمت با کلید خوند", "با کلید مطابقت داشت", "حکم با کلید می‌خونه". Pass 3 logged this drift as an open translation sweep; the fix made it intra-screen rather than inter-file.

- **S-19 · The Register control has a dead zone, on the first screen anyone sees.** `LoginPage.tsx:71` nests `<Link to="/register">` inside a `<Button>` — invalid HTML (interactive content inside a button). Measured: button `83.5 × 36`, anchor `51.5 × 20`; `elementFromPoint` at the button's padding returns the `BUTTON`, and clicking there produces no navigation, no request and no error. Same pattern on `RegisterPage` ("Log In").

### Small

- **S-20 · The six lab cards on the Tools hub have no titles.** `ToolsHomePage.tsx:49-90`: every card is badge + `<p>` + Button, so the lab's name exists only inside its CTA. Time Map, Journals and Feelings & Needs each get an `<h2>`. The six descriptions are the only scannable text, and the START HERE badge is a bare `<span>` whose referent is positional.

- **S-21 · Delegation echoes raw Persian numerals beside Latin-digit advice.** Pre-commit: *"تو گفتی ۱۱۰۰ کیلومتر / دستیار می‌گوید 1150 کیلومتر"* — two numeral systems on the single comparison the item exists to make. The reveal normalises correctly (`تو 1,100`), so only the deciding screen is affected. Created by the S-7 fix, which accepts Indic input and echoes it unfolded.

- **S-22 · Interpolated numeral beside a spelled-out one, in one clause.** `rubricIncomplete` in two labs and both locales: `"{{done}} of six criteria still need the AI scorer"` → "3 of six criteria"; `fa` → "1 از شش معیار". `en/common.json:1385`, `:1567`; `fa/common.json:1549`.

## 6. Not defects — recorded so the next pass does not re-raise them

- **Clarity scores nothing in `fa`.** All six criteria read `بدون نمره`. This is `DETECTOR_CRITERIA_BY_LOCALE.fa = []` (pass 2's deliberate fix — no Persian detectors authored) plus the judge being off. The screen now handles it honestly: *"مجموع — چیزی اینجا قابل ارزیابی نبود، پس نمره‌ای در کار نیست — نه اینکه نمره صفر باشد."* Worth knowing that even with the judge, `en` gets three criteria free and `fa` gets none.
- **`fa/common.json` has 22 lines carrying Persian digits** (canon recorded 23 on 2026-08-15). None is a Skills key. Already open under §7d; not a pass-4 finding.
- **`۱۰۰ درجه` shown beside accepted answer `100`** is correct: learner input is echoed verbatim, keys are Latin per §7d, and the normalizer handles the match.
- **Tooling artifacts, checked and dropped.** The apparent missing space in `"…above.(WOA 0.40…"` is a Tailwind `ms-1` margin that `innerText` does not reproduce (`ThreePositionReveal.tsx:78`). Onboarding slides 3–4 appearing "skipped" was my click loop outrunning React's re-render.

## 7. Ranked, by score gained per unit of work

1. **One shared Indic-digit fold, used by all three call sites.** Fixes S-12 and S-21, and removes the class. The point is not the third `replace` — it is that there should be one.
2. **Give Verification a "nothing fails" option and make the element conditional on the verdict.** S-15. Nine items currently require the learner to assert a falsehood, and Evidence already ships the pattern that works.
3. **Bound R6's nominalisation test.** S-13. Word-boundary matching in `contains`, and an exclusion list starting with the length units the same file already declares. Stops the writing lab penalising correct writing.
4. **Teach D1 the words the items use.** S-14 — relative days in `en`, a weekday list and deadline pattern in `fa`, colloquial and subjunctive positives in the `fa` verb list. Derive the register variants from one list the way S-10 derived the negations, so the two axes cannot diverge again.
5. **Give Delegation's window-level modules an outcome line**, and make the rail caption tell the truth when nothing scored. S-16 — the same shape `answerOutcome` solved in Monitoring.
6. **Split Decomposition's delta tile in two.** S-17. Rename the key to match its value while there.
7. **Un-nest the auth anchors and title the hub's lab cards.** S-19, S-20.
8. **One Persian register sweep across `fa/common.json`**, now that the evidence tables have set the register. S-18, and it closes pass 3's open sweep.
9. **Extend `no-persian-digits` to Clarity's and Decomposition's validators** and widen its field scope — or amend §7d to say what it actually means for authored teaching prose. S-22 alongside.

Items 1–4 are what stand between the labs and trustworthy measurement. Items 5–7 are what stand between them and reading as finished.

## 8. What this pass says about the method

Pass 3 wrote two rules into `00-persona-review-method.md`: *never re-score in the same session as the fixes*, and *a fix that only lands in one lab has not landed.* Pass 4 is the evidence for the first and a counter-example inside the second.

The first rule paid. Every one of pass 3's three blockers is genuinely fixed, and a same-day re-score would have said so a day early with no independent basis. The scores moved because the product moved.

The second rule needs a sharper edge. Pass 3 applied it to **components** — five `Pips` copies became one `RubricPips`, five landing pages became one `HowASittingWorks` — and not to **predicates**. Digit folding, boundedness and register handling are each implemented per-site, and each is where pass 4 found its worst defects. The rule that would have caught S-12 is not "check the other five labs" but: *when a fix normalises an input, the normaliser is the artifact, not the fix.*

---

## Changelog

- **1.0 · 2026-08-25** — Initial file. Pass 4, all six labs, fresh accounts, one day after pass 3's remediation. Confirms all three pass-3 blockers fixed and records the largest single-lab score movement in four passes (Monitoring / Persona A). Opens S-12 → S-22, of which S-12 (Persian numerals still failing Decomposition's boundedness check), S-14b (the pass-3 negation fix making colloquial negatives more permissive than positives) and S-21 are direct consequences of the pass-3 remediation. Names the structural cause — three unshared implementations of one digit fold — and proposes the sharper form of the rule that would have prevented it.
