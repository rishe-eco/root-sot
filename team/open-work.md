# Root · ریشه — Open work (blocked on a person)

*The queue. Work that engineering cannot finish because it needs human judgement, a native speaker, or a decision. Each item states its blocker and what it unblocks. Delete items when done — the decision logs are the permanent record.*

**Version 0.3 · Status: living · 2026-08-12 · Owner: _root**

---

## Summary

| # | Item | Who | Est. | Blocks |
|---|---|---|---|---|
| 1 | Verify 6 Evidence answer keys + freeze their search results | anyone careful | 2–4 h | Evidence scored baseline |
| 2 | Persian native review of both content packs | Persian reviewer | 6–10 h | Persian being equal-quality, not just present |
| 3 | Judge calibration pass, per criterion, per locale | 2 raters | 8–12 h | Clarity measurement-grade scores |
| ~~4~~ | ~~Decide whether Clarity ships permanently reader-less~~ | founder | — | **Decided 2026-08-01 — see below** |

Items 1–3 are independent of each other. **§5 is a different category** — anticipated work for four tools that have no code yet. It is listed so the cost is visible when build order is decided, not because anything is blocked today.

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

---

## 5 · Anticipated — the four specced-but-unbuilt packs

**Nothing here is blocked today, because none of these packs exist yet.** Each item becomes live when its tool reaches **Phase 2** of its build plan — the content phase — and not before. Listed now for one reason: the human cost is not uniform across the four, and it is cheaper to know that before choosing what to build than after.

| Tool | Key verification | Persian | Rater pass |
|---|---|---|---|
| **#3 Decomposition** | 2–3 h · required-element sets, atomic markers, overlap pairs, blocking edges | 3–4 h · **cheapest of all** — no Persian-specific linguistic work at all | **8–12 h, 2 raters** — and unusually, not calibration but establishing the rubric is scoreable at all |
| **#4 Verification** | **4–6 h** · every authored **bench outcome** re-derived, not just the keys — ~6 per probe item | 4–6 h · structural faults translate; check no bench entry splits into two checks in Persian | 8–12 h, 2 raters |
| **#5 Delegation** | 3–4 h · every `truth` value independently re-derived | 2–3 h · **cheapest of the five** — the instrument is numeric | **none** — this tool has no judge |
| **#6 Monitoring** | **heaviest** · keys plus the answer-variant review (below) | **heaviest** · `s4` transcripts are **re-authored, not translated** | none |

Four things worth knowing before any of it is scheduled.

**#3's rater pass is not judge calibration.** Every other pass in this file exists to check a model against humans. This one exists because **no validated decomposition rubric exists in the published literature** (`tracker/canon/06-specs/03-decomposition-lab.md` §1), so the pass establishes whether two people can agree on the rubric at all. Publish the agreement figure either way — a low one is a finding about the rubric, not a failed task.

**#4's verification is larger than its item count suggests.** Eighteen probe items carry roughly six bench entries each, and **every authored outcome has to be re-derived**, not just the answer key. An outcome that is wrong produces a confident wrong score with no symptom — the same silent-failure shape as item 1, multiplied.

**#5's is the smallest job with the sharpest failure.** A wrong `truth` value inverts advice quality and **reverses the headline metric**, silently. Small, and not skippable.

**#6's answer-variant review is the heaviest human item across all six tools, and it has a deadline of a kind.** Short-answer items are scored against authored acceptable-answer sets; a narrow set marks correct phrasings wrong, which **inverts the learner's resolution score**. And because a scored attempt is immutable (`00-skills-engine.md` §7), a variant added later **does not re-score history** — it applies to future attempts under a bumped content version. So the review has to happen *before* real use, not after complaints. Plan ≥3 variants per item at authoring, plus a pass over the unmatched-answer queue for every subsequent version.

**And one item that is authoring rather than review.** `#6`'s `s4` Persian transcripts cannot be translated: تعارف makes polite agreement a default register, so an agreement beat that reads as sycophancy in English may read as ordinary courtesy in Persian. Where the planted influence does not survive, the turn is **re-authored until it does**, keeping influence type and count identical across locales. Same category as **D-23**'s faux-feelings finding, and it needs the same person — a native speaker willing to challenge the item, not proofread it.

---

## Changelog

- **0.3 · 2026-08-12** — §5 added: anticipated human work for the four specced-but-unbuilt packs (#3–#6), each triggered by its tool reaching Phase 2 rather than live now. Records that the cost is not uniform — #5 is the smallest job with the sharpest failure mode, #6's answer-variant review is the heaviest across all six and cannot be deferred past real use because attempts are immutable, and #3's rater pass establishes whether its rubric is scoreable at all rather than calibrating a judge.
- **0.2 · 2026-08-01** — Item 4 decided: the reader is coming, so the reader-less state is temporary and nothing is re-scoped. Item 3 re-pointed at the credential rather than at the decision.
- **0.1 · 2026-08-01** — Created with the four items outstanding after the Skills Engine build.
