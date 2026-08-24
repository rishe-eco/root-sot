# Tracker — Persona review method

*How the skill labs are reviewed from a newcomer's seat: the two personas, the six metrics, the procedure, and the score history across passes. Grade: **as-built method** — every pass recorded here was run against the running dev servers on the date in its own file.*

**Version 1.1 · Status: living · 2026-08-24 · Owner: _root**

---

## 1. Why this file exists

The skill labs are the only part of Tracker whose value depends on a stranger understanding them unaided. The specs in `../06-specs/` say what each lab *measures*; nothing said whether a person can *use* it. Two review passes were run in August 2026 and both found real, shipped defects that no test suite had caught — but the method lived only in a chat transcript, and the third pass had to excavate it. This file is the durable record so a later pass starts from the same instrument.

**The method is deliberately not usability-testing-by-the-book.** There are no real participants. It is one reviewer walking the product twice, once per persona, committing real attempts against a real server, and scoring against a fixed rubric. Its value is reproducibility across passes, not statistical validity. Where a finding needs a human, it goes to `../../../team/open-work.md`, not here.

## 2. The two personas

Fixed across passes. Do not redefine them — the score history depends on them being the same instrument.

| | **A** | **B** |
|---|---|---|
| Age | 30 | 25 |
| Background | MSc data mining, medium quality | Management student |
| Programming | little prior Python | none |
| Online/technical experience | ordinary | none |
| Language | native Persian, medium English → **chooses Persian** | → **chooses English** |
| What they know entering | that the Tools page has labs for practising skills that help with AI models. Nothing else. | same |

**A is the language and measurement probe.** A native-Persian expert reader clears every reasoning bar the content sets — "discrimination", "calibration", "resolution" are native vocabulary from ML — so anything A struggles with is a *product* problem, not a comprehension one. A is the persona who surfaces locale bugs, and every locale bug found in three passes has been found by A.

**B is the register probe.** B is who the content is hardest on. Expert vocabulary that A reads straight through — *oracle, falsifiability, discrimination, lateral, referents, unscaffolded, elicitation* — is where B stops. B also surfaces every defect that is locale-independent, because B has no language excuse for it.

## 3. The six metrics

Scored 1–5, per persona, **per lab** (the first two passes scored per-pass; from pass 3 on, per-lab, because six labs no longer average into one meaningful number).

1. **Clarity of purpose** — after landing, can they say what skill this trains and why it helps with AI?
2. **Clarity of use** — do they know what to *do* next at every step, without guessing?
3. **Distinction of data** — can they tell apart *their own input*, the app's *material*, and the app's *judgement*? Whose text is whose?
4. **Feedback legibility** — is the scoring understandable and actionable? Does the screen say one thing or three?
5. **Recoverability** — dead ends, error states, "am I done?" moments.
6. **Language parity** (A only) — is the Persian equal in quality, or merely present?

Metrics 1–3 were the founder's own suggestion in pass 1; 4–6 were added because pass 1 could not express its findings without them. **Feedback legibility has been the lowest-scoring metric in all three passes** and is the metric that has moved most between passes.

## 4. The procedure

1. **Fresh accounts, one per persona**, registered through the UI, `localStorage` cleared first so first-run onboarding actually fires. Never reuse an account across passes — half the findings live in the first-run path.
2. **Tier 1, both personas, every lab:** Tools hub → lab landing → first item committed → first reveal. This is where purpose and data-distinction are won or lost.
3. **Tier 2, one persona per item kind,** assigned by who the kind stresses: A for anything language-shaped (answer matching, rubric prose, seeded faults), B for anything register-shaped (an oracle bench, a WOA reveal, an arrangement canvas). Six labs × ~4 item kinds is ~40 sittings; the repetition buys nothing, the kind boundaries buy everything.
4. **At least one deliberately wrong path per lab** — the false alarm, the over-decomposition, the unchecked verdict. The worst screens in every pass have been on wrong attempts, not right ones.
5. **Verify a suspected bug below the UI before reporting it.** Every pass has caught itself about to report a tooling artifact as a defect. Read the source, query the DB, or curl the server; then report.
6. **Report as:** per-lab score tables, verified bugs separated from judgment calls, then one ranked cross-lab list ordered by score gained per unit of work.

**Two standing environment notes.** `client/.env` ships the production same-origin `VITE_API_URL`, so a dev client needs the gitignored `client/.env.local` the README describes or every request 404s. And `api/.env` has no `ANTHROPIC_API_KEY` on a normal dev box, so Clarity's judge is off — which is not a bug but does cap what Clarity can score (see `04-verification-lab.md`-era discussion and `../06-specs/00-skills-engine.md` §7).

**Never re-score in the same session as the fixes.** Pass 3 fixed its own findings on the same day. Its score tables were deliberately left as they were taken, and the remediation is recorded separately (`01-...md` §8) rather than folded into them. A reviewer who has just written the fix cannot read the screen as a stranger; re-scoring then measures memory of the intent, not the experience. The next pass starts from fresh accounts and records its own numbers, and it is the only thing that can say whether a fix worked.

**A fix that only lands in one lab has not landed.** Pass 3's largest finding was not a bug but a shape: passes 1 and 2 fixed the landing page, the rubric glosses and the score display *in Evidence and Clarity*, and the four labs built afterwards shipped without any of them. The remediation answered that at the shape — one shared walkthrough component, one shared pips component, one evidence-table helper — rather than by copying each fix four more times. When a pass finds a defect in one lab, check the other five before closing it, and prefer a fix that cannot be forgotten by the seventh.

**One standing measurement caveat.** Instrumented walkthroughs are slow — elapsed timers read 90–120 s where a person would take 20. **Never score reflex speed from a review pass**, and never treat a lab's own median-time figure as valid after one.

## 5. Score history

| Pass | Date | Scope | Where |
|---|---|---|---|
| 1 | 2026-08-14/15 | Evidence + Clarity | pass-1 findings live only in session `local_622daf2d`; the five remediation items it produced are all landed and re-verified in pass 3 |
| 2 | 2026-08-15 | Evidence + Clarity, re-test after fixes | same session |
| 3 | 2026-08-24 | **all six labs** | `01-six-lab-review-2026-08-24.md` (§8: fixed same day) |

Passes 1 and 2, averaged over Evidence + Clarity:

| Metric | A (fa) p1 → p2 | B (en) p1 → p2 |
|---|---|---|
| Clarity of purpose | 3 → 4 | 2 → 4 |
| Clarity of use | 2 → 4 | 2 → 4 |
| Distinction of data | 2 → 4 | 2 → 4 |
| Feedback legibility | 2 → 1 | 1 → 4 |
| Recoverability | 2 → 4 | 2 → 4 |
| Language parity | 1 → 2 | — |

Pass 3's per-lab tables are in its own file. **Scores are not comparable across passes at different granularity** — pass 3's Evidence and Clarity numbers are per-lab and are the closest thing to a continuation of the table above; the four newer labs have no prior.

## 6. What each pass has cost and returned

Roughly half a day of walkthrough per pass, and every pass has returned at least one defect that inverts a measurement silently — the failure mode these labs exist to teach people to catch:

- **Pass 1:** Persian content unreachable (`SkillProfile.locale` defaulted to `en` and every caller used the default); the rewrite step dead for every non-repair item; diagnosis scored against the rewrite instead of the original.
- **Pass 2:** Persian Clarity scores meaningless (`contentWords` stripped every non-ASCII character, so R1 always returned 0 on Persian).
- **Pass 3:** Persian-Indic digits never match any answer key (16 of 33 Monitoring items, 10 of them the module whose whole output is the headline measurement); the per-criterion "why" is hardcoded English in four labs. Both fixed the same day (D-50).

**The recurring shape is worth naming, because it has recurred three times:** a locale decision is made correctly at one layer and not carried to the next. Pass 1 was the profile layer, pass 2 the tokenizer, pass 3 the answer key's numeral system. When reviewing a locale fix, check every layer that touches the field, not the layer where the fix was made.

---

## Changelog

- **1.0 · 2026-08-24** — Initial file. Records the two personas and six metrics established in pass 1 (2026-08-14) and used unchanged since, the tiered procedure pass 3 introduced for six labs, the score history, and the three-pass pattern of locale fixes not propagating between layers. Created because the method had been living in a chat transcript and pass 3 had to recover it from one.
- **1.1 · 2026-08-24** — Two procedural rules added from pass 3's remediation: never re-score in the same session as the fixes, and treat a fix that lands in only one lab as unlanded. Pass table notes that pass 3's findings were fixed the same day.
