# Root · ریشه — Open work (blocked on a person)

*The queue. Work that engineering cannot finish because it needs human judgement, a native speaker, or a decision. Each item states its blocker and what it unblocks. Delete items when done — the decision logs are the permanent record.*

**Version 0.6 · Status: living · 2026-08-23 · Owner: _root**

---

## Summary

| # | Item | Who | Est. | Blocks |
|---|---|---|---|---|
| 1 | Verify 6 Evidence answer keys + freeze their search results | anyone careful | 2–4 h | Evidence scored baseline |
| 2 | Persian native review of both content packs | Persian reviewer | 6–10 h | Persian being equal-quality, not just present |
| 3 | Judge calibration pass, per criterion, per locale | 2 raters | 8–12 h | Clarity measurement-grade scores |
| 4 | Verify 18 Decomposition probe items' keys | anyone careful | 2–3 h | Decomposition scored baseline |
| 5 | Persian native review of the Decomposition pack | Persian reviewer | 3–4 h | Decomposition Persian off `draft` |
| 6 | Decomposition rubric-agreement rater pass | 2 raters | 8–12 h | Establishes the rubric is scoreable at all |
| 7 | Verify 18 Verification probe items' bench outcomes | anyone careful | 4–6 h | Verification scored baseline |
| 8 | Persian native review of the Verification pack | Persian reviewer | 4–6 h | Verification Persian off `draft` |
| 9 | Verification rubric-agreement rater pass | 2 raters | 8–12 h | Establishes the rubric's key matches human judgement |
| 10 | Verify 21 Delegation probe items' `truth` values | anyone careful | 3–4 h | Delegation scored baseline |
| 11 | Persian native review of the Delegation pack | Persian reviewer | 2–3 h | Delegation Persian off `draft` |
| ~~12~~ | ~~Decide whether Clarity ships permanently reader-less~~ | founder | — | **Decided 2026-08-01 — see below** |

Items 1–11 are independent of each other. **§13 is a different category** — anticipated work for the one tool that still has no code. It is listed so the cost is visible when build order is decided, not because anything is blocked today.

**Items 4–6 were promoted out of the anticipated section on 2026-08-16**, when the Decomposition Lab build (phases 1–5) confirmed live that all 18 probe items are still `key-unverified` — every one of the four skill tools' Lab pages correctly refuses to open a scored probe today, which is what makes this queue no longer anticipated for Decomposition. This should have moved when Phase 2 (the content pack) landed on 2026-08-15, per the build plan's own instruction; it is done now rather than back-dated.

**Items 7–9 were promoted out of the anticipated section on 2026-08-22**, the same way and for the same reason: the Verification Lab build's Phase 2 landed 2026-08-22 and confirmed live that all 18 of its probe items are `key-unverified` too.

**Items 10–11 were promoted on 2026-08-23**, when the Delegation Lab build reached the end of its pass's full scope (phases 1–6) and confirmed live that all 21 probe items are `key-unverified` too. No rater-pass item exists for Delegation — every criterion resolves against an authored key or computed arithmetic (spec §4), so there is no judge to calibrate and nothing for two humans to reconcile the way items 3, 6 and 9 do.

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

## 4 · Verify the Decomposition probe items' keys

**Blocked on:** anyone careful with the item bank — no Persian and no rating judgement needed, just checking the key against the item.
**Unblocks:** Decomposition Lab's scored baseline/post/delayed probes. Practice (calibrated and open) already works and is unaffected — every item type completes and scores with no credential.

Eighteen probe items, each an `arrangement` or `control` type item, checked against `03-decomposition-lab.md` §4.6's arrangement-key shape: `requiredPieceIds`, `overlapPairs`, `blockingEdges`, `independentPairs`, and which pieces are `atomic`/`decoy`/`intendedDepth`. The validator (`decomposition/validate.ts`) already catches a key that is *internally incoherent* (a required piece that's also a decoy, a cycle in blocking edges, and so on) — what a human has to confirm is that the key is *correct*, which no validator can check.

**Why it can't be skipped, same shape as item 1:** "a wrong key does not fail loudly — it silently produces a wrong score, which is the exact failure this tool teaches people to catch" (build plan §4.6). Stamp `keyVerifiedAt` per item once confirmed.

---

## 5 · Persian native review of the Decomposition pack

**Blocked on:** the Persian reviewer.
**Unblocks:** the claim that Decomposition's Persian is equal in quality rather than merely present. Persian users can practise today; the pack is marked `reviewStatus: "draft"` in the UI, honestly.

**Cheapest of the three tools' Persian work, and deliberately so** (build plan §5.1's cost model, extended here): `fa` is a translation of a locale-invariant spec rather than a re-authoring, because nothing that makes a decomposition item an instrument is language-shaped — no seeded fault needs to survive translation the way Evidence's do, no rubric criterion needs linguistic rework the way Clarity's R4/R6 do. The review is a fluency and register pass (informal تو/کن, concept not calque, Western digits) over 54 items' worth of scenarios, piece labels, and the two costume-aside strings — not a re-derivation of anything that scores.

---

## 6 · Decomposition rubric-agreement rater pass

**Blocked on:** two people willing to score independently and then reconcile — **not** on a credential, unlike item 3. This is the pass build plan §1 flags as different in kind from judge calibration.

**Unblocks:** treating D3/D5/D6 as more than self-diagnosis on free-authored (`breakdown`) items once a judge exists (Phase 6, unbuilt). Arrangement, control, and repair items are already fully key-scored and need no rater pass at all — this is scoped to the minority of items a judge would ever touch.

**This is not calibrating a model against humans — no judge exists yet to calibrate.** It is establishing whether *two humans* can agree on the rubric at all: "no validated decomposition rubric exists in the published literature" (`03-decomposition-lab.md` §1), so ~20 double-scored breakdown samples per criterion, reconciled, per locale, is the first evidence either way. Publish the agreement figure whatever it turns out to be — a low one is a finding about the rubric, not a failed task.

---

## 7 · Verify the Verification probe items' bench outcomes

**Blocked on:** anyone careful with the item bank — no Persian and no rating judgement needed.
**Unblocks:** Verification Lab's scored baseline/post/delayed probes. Practice already works and is unaffected — every module completes and scores with no credential.

Eighteen probe items, each carrying six authored bench entries. Unlike a simple answer key, **every authored outcome has to be re-derived, not just the correctness of a single answer** (`04-verification-lab.md` §9, §11) — confirm each check's `costSeconds`, whether it's genuinely `independent` of the artifact's own source, whether it would actually be `discriminating` if the artifact were wrong, and that the outcome text shown on selection is accurate. Roughly six re-derivations per item, ~108 total.

**Why it can't be skipped, same shape as item 1 and item 4:** a wrong bench outcome or a wrong `discriminating`/`independent` tag does not fail loudly — it silently mis-scores V2, V3 and V4 on every future attempt of that item, which is exactly the failure this tool exists to teach people to catch. Stamp `keyVerifiedAt` per item once confirmed.

---

## 8 · Persian native review of the Verification pack

**Blocked on:** the Persian reviewer.
**Unblocks:** the claim that Verification's Persian is equal in quality rather than merely present. Persian users can practise today; the pack is marked `reviewStatus: "draft"` in the UI, honestly.

**Cheap, for the same structural reason Decomposition's Persian work is cheap** (`04-verification-lab.md` §9): fault classes are units, magnitudes, boundaries and inverted logic — locale-invariant — so `fa` is a translation of a locale-invariant spec, not a re-authoring. No seeded fault needs to survive translation the way Evidence's do, no rubric criterion needs linguistic rework the way Clarity's R4/R6 do. The review is a fluency and register pass over 54 items' worth of artifacts, bench-check labels and outcomes, and element labels — plus one specific check: that no bench entry reads as two separate checks once translated, since a check that splits in Persian is a broken key, not a translation nit.

---

## 9 · Verification rubric-agreement rater pass

**Blocked on:** two people willing to score independently and then reconcile — **not** on a credential. Every criterion here resolves against an authored key or an instrumented event (spec §4), so this is not calibrating a judge; it is establishing whether the *key itself* matches what two independent humans would conclude applying the same rubric.

**Unblocks:** treating the strict composite, and the mastery gate built on it, as measurement rather than an assumption. Until this runs, the rubric's validity rests on the authors' own judgement alone.

~20 double-scored items per criterion, reconciled, per locale — six criteria, so roughly 120 judgements a side, the same shape as item 3's and item 6's rater passes. Publish the agreement figure whatever it turns out to be; a low one is a finding about the rubric — particularly V1 (oracle named) and V2 (independence), the two criteria closest to judgement calls rather than arithmetic — not a failed task.

---

## 10 · Verify the Delegation probe items' `truth` values

**Blocked on:** anyone careful with the item bank — no Persian and no rating judgement needed, just re-deriving each authored quantity.

**Unblocks:** Delegation Lab's scored baseline/post/delayed probes. Practice already works and is unaffected — every item kind completes and scores with no credential.

Twenty-one probe rows (5 single-item modules × 3 forms, plus one g5-stakes pair × 3 forms), each carrying an authored `truth` value that the learner's estimate, the advice, and every derived metric are measured against.

**This is the smallest job of the three tools' key-verification items, and the sharpest failure.** A wrong `truth` value doesn't just mis-score one item — it inverts `adviceQuality` for every learner who ever sees it, which **silently reverses the headline reliance-discrimination metric's sign** for that item. Small, and not skippable. Stamp `keyVerifiedAt` per item once confirmed.

---

## 11 · Persian native review of the Delegation pack

**Blocked on:** the Persian reviewer.
**Unblocks:** the claim that Delegation's Persian is equal in quality rather than merely present. Persian users can practise today; the pack is marked `reviewStatus: "draft"` in the UI, honestly.

**Cheapest of the three tools' Persian work** (`05-delegation-lab.md` §4): the instrument is numeric — estimates, advice, truth are locale-invariant — so only scenario prose, cue labels, and split-piece labels are realised twice, and there is no Persian-specific linguistic work at all (no seeded fault to survive translation the way Evidence's do, no rubric criterion needing linguistic rework the way Clarity's R4/R6 do). The review is a fluency and register pass over 63 items' worth of scenario prose and labels — plus one specific check: that no cue option reads as two separate cues once translated, since a cue that splits in Persian is a broken key, not a translation nit.

---

## 12 · ~~Decide: does Clarity ship permanently without a reader?~~ — decided

**Decided 2026-08-01 (founder): no. The reader is coming; the reader-less state is temporary.**

So nothing is re-scoped and nothing is retired:

- **Mastery stays as specified** — all six criteria. It is unreachable today and the app says why. That is a waiting state, not a permanent design, and redefining it downward would have handed out mastery of a skill nobody assessed.
- **The write-from-scratch items stay in the pack.** They are withheld from serving rather than deleted, and start appearing the moment a credential is configured.
- **Item 3 (calibration) is therefore live**, not conditional. It stays blocked on the credential arriving rather than on this decision.

What this leaves outstanding is a dependency, not a question: **Clarity Lab's measurement is gated on `ANTHROPIC_API_KEY` reaching `api/.env`.** Setup notes — including the point that the issuing account does not matter, and that the *reader* is a second call distinct from the judge — are in `../tracker/canon/06-specs/01a-clarity-lab-build-plan.md` §4.

---

## 13 · Anticipated — the one specced-but-unbuilt pack

**Nothing here is blocked today, because the pack doesn't exist yet.** It becomes live when the tool reaches **Phase 2** of its build plan — the content phase — and not before.

**Decomposition (#3) was here until 2026-08-16, Verification (#4) until 2026-08-22, and Delegation (#5) until 2026-08-23** — each tool's content pack landed and its build reached the end of its pass's scope within days, so their key-verification, Persian review, and (where applicable) rater-pass items are promoted to items 4–6, 7–9 and 10–11 above, live not anticipated.

| Tool | Key verification | Persian | Rater pass |
|---|---|---|---|
| **#6 Monitoring** | **heaviest** · keys plus the answer-variant review (below) | **heaviest** · `s4` transcripts are **re-authored, not translated** | none |

**#6's answer-variant review is the heaviest human item across all six tools, and it has a deadline of a kind.** Short-answer items are scored against authored acceptable-answer sets; a narrow set marks correct phrasings wrong, which **inverts the learner's resolution score**. And because a scored attempt is immutable (`00-skills-engine.md` §7), a variant added later **does not re-score history** — it applies to future attempts under a bumped content version. So the review has to happen *before* real use, not after complaints. Plan ≥3 variants per item at authoring, plus a pass over the unmatched-answer queue for every subsequent version.

**And one item that is authoring rather than review.** `#6`'s `s4` Persian transcripts cannot be translated: تعارف makes polite agreement a default register, so an agreement beat that reads as sycophancy in English may read as ordinary courtesy in Persian. Where the planted influence does not survive, the turn is **re-authored until it does**, keeping influence type and count identical across locales. Same category as **D-23**'s faux-feelings finding, and it needs the same person — a native speaker willing to challenge the item, not proofread it.

---

## Changelog

- **0.6 · 2026-08-23** — Delegation's human-work items (key verification, Persian review) promoted from the anticipated table to live items 10–11, the same day its build reached the end of its pass's full scope (phases 1–6) and Phase 5 confirmed live that all 21 probe items are `key-unverified`. No rater-pass item exists for Delegation — nothing here resolves through a judge. The anticipated section now covers only Monitoring (#6), renumbered §11 → §13 to make room. Decided item renumbered 10 → 12. Caught and fixed a numbering collision before committing: the anticipated section's own header was left at §11 after items 10–11 were added, colliding with the new live item 11.
- **0.5 · 2026-08-22** — Verification's human-work items (key/bench-outcome verification, Persian review, rubric-agreement rater pass) promoted from the anticipated table to live items 7–9, the same day its Phase 2 content pack landed and Phase 5 confirmed live that all 18 probe items are `key-unverified`. The anticipated table now covers only Delegation and Monitoring, renumbered §8 → §11 to make room. Decided item renumbered 7 → 10.
- **0.4 · 2026-08-16** — Decomposition's human-work items (key verification, Persian review, rubric-agreement rater pass) promoted from the anticipated table to live items 4–6, per the build plan's own instruction to do this when Phase 2 lands — a day late (Phase 2 landed 2026-08-15), caught while Phase 5 confirmed live that all 18 probe items are still `key-unverified`. The anticipated table's own section renumbered §5 → §8 to make room, and now covers three tools, not four. Decided item renumbered 4 → 7 (nothing external referenced either number).
- **0.3 · 2026-08-12** — §5 added: anticipated human work for the four specced-but-unbuilt packs (#3–#6), each triggered by its tool reaching Phase 2 rather than live now. Records that the cost is not uniform — #5 is the smallest job with the sharpest failure mode, #6's answer-variant review is the heaviest across all six and cannot be deferred past real use because attempts are immutable, and #3's rater pass establishes whether its rubric is scoreable at all rather than calibrating a judge.
- **0.2 · 2026-08-01** — Item 4 decided: the reader is coming, so the reader-less state is temporary and nothing is re-scoped. Item 3 re-pointed at the credential rather than at the decision.
- **0.1 · 2026-08-01** — Created with the four items outstanding after the Skills Engine build.
