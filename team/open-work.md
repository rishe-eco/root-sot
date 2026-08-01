# Root · ریشه — Open work (blocked on a person)

*The queue. Work that engineering cannot finish because it needs human judgement, a native speaker, or a decision. Each item states its blocker and what it unblocks. Delete items when done — the decision logs are the permanent record.*

**Version 0.2 · Status: living · 2026-08-01 · Owner: _root**

---

## Summary

| # | Item | Who | Est. | Blocks |
|---|---|---|---|---|
| 1 | Verify 6 Evidence answer keys + freeze their search results | anyone careful | 2–4 h | Evidence scored baseline |
| 2 | Persian native review of both content packs | Persian reviewer | 6–10 h | Persian being equal-quality, not just present |
| 3 | Judge calibration pass, per criterion, per locale | 2 raters | 8–12 h | Clarity measurement-grade scores |
| ~~4~~ | ~~Decide whether Clarity ships permanently reader-less~~ | founder | — | **Decided 2026-08-01 — see below** |

Items 1–3 are independent of each other.

---

## 1 · Verify the Evidence answer keys and freeze their search results

**Blocked on:** anyone careful with a browser. No project knowledge needed.
**Unblocks:** the Evidence Lab before/after test. Practice already works and is unaffected.

Six probe items, two jobs each — confirm the recorded answer is actually right, and capture the search results that every learner will see. Twelve tasks, hence the "12 items" the app's banner counts.

**The work order is written and self-contained:** `tracker/canon/06-specs/02a-evidence-verification-brief.md`. It covers the procedure, each item's specific trap, how to record the result, and what to do when a key turns out to be wrong (flag it, don't fix it — the items are interlocking and a patched key usually breaks something else that still compiles).

**Why it can't be skipped.** A wrong answer key does not fail loudly. The test still runs and quietly returns a false number — which is, uncomfortably, exactly the failure the tool exists to teach people to catch.

---

## 2 · Persian native review of both content packs

**Blocked on:** the Persian reviewer.
**Unblocks:** the claim that the Persian version is equal in quality rather than merely present. Persian users can practise today; the packs are marked `draft` in the UI, honestly.

Both packs are machine-drafted Persian awaiting post-editing: Evidence (42 items) and Clarity (26 items). This is **not** proofreading — the review has to check that each item's *fault survives in Persian*, which for several items it structurally cannot without re-authoring.

Read `tracker/canon/06-specs/02a-...` §7 for the framing. The specific thing to brief the reviewer on: Clarity's referent and economy drills were **authored, not translated**, because pro-drop, *ezāfe* chains and اسم‌مصدر are different problems from bare demonstratives and Latinate nominalisation. Where they read oddly, the fix is a better Persian item, not a closer translation.

---

## 3 · Judge calibration pass

**Blocked on:** two people willing to score independently and then reconcile, **and on the credential** (item 4) — there is nothing to calibrate until the reader is configured.
**Unblocks:** Clarity scores counting as measurement rather than as feedback.

About 20 human-scored samples per criterion, double-scored and reconciled, per locale — six criteria, so roughly 120 judgements a side. Until a criterion passes, the app shows its level and keeps it out of every total, and says so.

**Persian needs this more than English does, not less.** Two of six criteria route to the model in Persian that are handled deterministically in English, so more of the Persian score depends on the judge. A calibration pass done only in English would produce a two-tier product wearing a bilingual label.

**Do not skip the reconciliation step.** A rubric alone does not fix rater agreement; the reconciliation *is* the calibration. Scoring against the rubric without it produces two people's opinions with a shared vocabulary.

---

## 4 · ~~Decide: does Clarity ship permanently without a reader?~~ — decided

**Decided 2026-08-01 (founder): no. The reader is coming; the reader-less state is temporary.**

So nothing is re-scoped and nothing is retired:

- **Mastery stays as specified** — all six criteria. It is unreachable today and the app says why. That is a waiting state, not a permanent design, and redefining it downward would have handed out mastery of a skill nobody assessed.
- **The write-from-scratch items stay in the pack.** They are withheld from serving rather than deleted, and start appearing the moment a credential is configured.
- **Item 3 (calibration) is therefore live**, not conditional. It stays blocked on the credential arriving rather than on this decision.

What this leaves outstanding is a dependency, not a question: **Clarity Lab's measurement is gated on `ANTHROPIC_API_KEY` reaching `api/.env`.** Setup notes — including the point that the issuing account does not matter, and that the *reader* is a second call distinct from the judge — are in `../tracker/canon/06-specs/01a-clarity-lab-build-plan.md` §4.

## Changelog

- **0.2 · 2026-08-01** — Item 4 decided: the reader is coming, so the reader-less state is temporary and nothing is re-scoped. Item 3 re-pointed at the credential rather than at the decision.
- **0.1 · 2026-08-01** — Created with the four items outstanding after the Skills Engine build.
