# Evidence Lab — content verification brief

*A self-contained work order. Everything needed to do this job is in this file; no prior knowledge of Tracker is assumed. Companion to `02-evidence-lab.md`. Update the changelog; don't fork.*

**Version 0.1 · Status: open work · 2026-08-01 · Owner: _root · Est. 2–4 hours**

---

## 1. What you are being asked to do, in one paragraph

Evidence Lab is a training tool that shows people a question someone asked an AI and the answer the AI gave, and asks them to work out whether the answer holds up. Six of its items are reserved for a **before-and-after test**: you take it, do the training, take a matching version, and the two scores are compared to see whether you improved. That test is currently switched off, because two jobs have not been done for each of those six items. **Six items × two jobs = the twelve outstanding tasks.** This brief is those twelve.

Nothing else about the tool is blocked. Ordinary practice works today and is unaffected by this work.

## 2. Why it can't just ship

**Job A — confirm the answer key.** Every item has a recorded "correct answer" and a note explaining why. Those were written by one person in one sitting and never independently checked. A wrong key does not fail loudly: the learner is simply marked wrong when they were right, the test still runs, and the number it produces is quietly false. This is the only defect in the whole design that produces a confident, plausible, incorrect result — which is, uncomfortably, the exact thing the tool is meant to teach people to catch.

**Job B — freeze the search results.** During practice a learner searches the live web. During the test they must not: two people searching the same claim on different days get different results, so part of what the test measures becomes their search luck. Instead, the test shows a **saved snapshot** of search results packaged with the item, identical for everyone. Nobody has captured those snapshots yet.

The two jobs are coupled and the code enforces it. Saving a snapshot without re-reading the key against *that snapshot* is the one way this can rot silently — the evidence changes, the key doesn't, and nothing complains. So an item with a saved snapshot and an unconfirmed key is a build error, not a warning.

## 3. The procedure, per item

Work one item at a time. For each of the six:

**A. Confirm the key.**

1. Read the question and the answer exactly as a learner sees them (§5 lists where).
2. Read `keyNote` — my claim about what is wrong (or right) with the answer, and why.
3. Check it yourself, from primary sources where possible. You are looking for one of three outcomes:
   - **Confirmed** — the note is right. Proceed.
   - **Confirmed but incomplete** — the note is right and misses something a learner could reasonably argue. Extend the note; don't change the key.
   - **Wrong** — stop. Do not patch the key to match reality. Flag it (§6), because an item whose key was wrong may also have the wrong *profile*, and changing one without the other produces a self-inconsistent item that the validator will catch but a human might not.
4. Also confirm the `faultTarget` — the short phrase naming *which part* fails. Learners are scored on locating the fault, not only on the verdict, so a vague or misplaced `faultTarget` mis-scores a correct answer.

**B. Freeze the snapshot.**

1. Run each of the item's authored queries (listed in §5) in a clean browser — logged out, private window, no personalisation. Personalised results are not reproducible and defeat the point.
2. Capture the **top 5–8 organic results** for each: title, URL, and the snippet as shown. No ads, no "people also ask" boxes.
3. Do not curate. Do not drop a result because it is unhelpful, and do not promote the one that gives the game away. The snapshot must be what a real search returned, or the item stops being a fair test.
4. If a query returns nothing useful, that is a finding — flag it (§6) rather than inventing a better query. A claim that cannot be settled by an ordinary search does not belong in a timed test.
5. **Re-read the key against what you just captured.** Would a competent person, seeing only these results, reach the recorded verdict inside a minute? If not, say so. This step is the whole reason A and B are coupled.

**C. Record it.**

Both edits go in one file: `api/src/content/skills/evidence/v2/spec.ts`. Find the item by its `itemId`. Change two fields:

```ts
    keyVerifiedAt: "2026-08-05",          // the date you confirmed it, YYYY-MM-DD
    snapshot: verifiedSnapshot("2026-08-05", "your-name", [
      {
        query: "1945 Food and Nutrition Board water recommendation",
        results: [
          { title: "…", url: "https://…", snippet: "…" },
          // 5–8 of these
        ],
      },
      // one entry per authored query
    ]),
```

`verifiedSnapshot` is already defined at the top of that file; replace the existing `pendingSnapshot(...)` call with it. Keep the same queries in the same order.

Do not touch anything else in the item — not `profile`, not `key`, not `difficulty`, and not the question, answer or reveal text in `surface.en.ts` / `surface.fa.ts`. Those are matched across two languages and across the before/after forms; changing one side silently breaks the pairing.

## 4. How to know you're done

From `api/`:

```bash
npx vitest run src/__tests__/skillContent.unit.test.ts
```

While work is outstanding, `blocks unverified items from probes while leaving practice usable` passes *because* blockers exist. When all twelve are done that test will fail, and that failure is the finish line — flip its assertion from `toBeGreaterThan(0)` to `toBe(0)` and note the date in the changelog below.

The other signal is in the app: the amber banner on the Evidence Lab page reading *"Scored assessment is not available yet: 12 item(s)…"* disappears, and the baseline becomes startable.

## 5. The six items

All six live in `api/src/content/skills/evidence/v2/`. The question and answer text a learner sees is in `surface.en.ts` (and `surface.fa.ts`); the key, note and queries are in `spec.ts`. Both are keyed by `itemId`.

---

### `ev2-a1` — daily water intake · difficulty 2 · module `e4-trace`

**Recorded verdict:** `misattributed` — the source exists and is quoted correctly, but does not support the conclusion.
**Fault target:** the step from the 1945 recommendation to the advice drawn from it.
**The claim to test:** that the "eight glasses a day" advice traces to a 1945 US Food and Nutrition Board recommendation of ~2.5 litres. My note says the recommendation is real and correctly quoted, and that its *next sentence* — that most of that water is already present in prepared foods — is the part the popular advice drops.
**What to establish:** (a) the 1945 recommendation exists and says ~2.5 L; (b) the "contained in prepared foods" qualifier is really there, in the original, and reads as I describe; (c) that the answer's secondary claim about coffee and tea being counted at half value is weak enough to mention in the reveal but not so wrong that it becomes the item's primary fault.
**Authored queries:** `1945 Food and Nutrition Board water recommendation` · `eight glasses of water a day origin`
**Watch for:** this one turns on a primary document that is old and often paraphrased. Secondary sources describing the qualifier are not enough — find the wording.

---

### `ev2-a2` — Jupiter's moon count · difficulty 2 · module `e1-stop`

**Recorded verdict:** `outdated`.
**Fault target:** the moon count, and the claim that Jupiter leads.
**The claim to test:** the answer says 79 confirmed moons and that Jupiter has the most in the solar system. My note says 79 was right around 2018, Jupiter is now past 95, and Saturn overtook it in 2023.
**What to establish:** the current confirmed counts for both planets, from a body that actually maintains them, and that the ordering has genuinely flipped.
**Authored queries:** `how many moons does Jupiter have` · `Saturn moon count confirmed`
**Watch for:** the count moves. Record the figure and the date you checked it in `keyNote`, and expect this item to need re-verification periodically — it is the most perishable of the six. If that proves annoying, that is a real argument for replacing it, not for fudging it.

---

### `ev2-a3` — petrichor · difficulty 1 · module `e3-sideways` · **CONTROL**

**Recorded verdict:** `supported`. This item is **correct**; there is nothing wrong with it.
**The claim to test:** that "petrichor" was coined in 1964 by Isabel Joy Bear and Richard Thomas in *Nature*, from Greek *petra* and *ichor*, and that geosmin from soil bacteria is a major component of the smell.
**What to establish:** all of the above, including that the *Nature* paper is real and is by those authors in that year.
**Authored queries:** `petrichor Bear Thomas 1964 Nature` · `geosmin smell of rain`
**Watch for:** controls carry more weight than they look like they do. A third of every scored form is deliberately correct, because a learner who flags everything has acquired distrust rather than skill and the score has to be able to see that. A control that turns out to have a flaw in it is worse than a faulty item with a wrong key — it punishes exactly the behaviour the tool is trying to produce. Check it as hard as the others.

---

### `ev2-a4` — food left out at room temperature · difficulty 3 · module `e2-source`

**Recorded verdict:** `unsupported`, fault: *existence* — the named rule does not exist.
**Fault target:** the named rule.
**The claim to test:** the answer cites an "FDA 90-Minute Rule". My note says no such rule exists; the real guidance is the two-hour rule (one hour above 90°F/32°C), with the 40–140°F danger zone.
**What to establish:** (a) that no FDA or USDA guidance uses the name "90-Minute Rule"; (b) that the two-hour rule and the danger-zone range are stated as I describe, by a named authority; (c) that the answer's remaining content — the danger zone, the hot-day halving, heat-stable toxins surviving reheating — is accurate, since the item depends on everything *except* the rule name being right.
**Authored queries:** `FDA two hour rule food left out` · `USDA danger zone food safety`
**Watch for:** proving a negative. "I couldn't find it" is not the same as "it doesn't exist" — check the agencies' own sites directly, not just search results, and record where you looked in `keyNote`. This is also, note, the item most likely to be quoted back at someone in real life, so getting the *correct* guidance right in the reveal matters beyond the score.

---

### `ev2-a5` — morning vs evening exercise · difficulty 3 · module `e5-independence`

**Recorded verdict:** `contested` — not false, falsely settled.
**Fault target:** the framing of an open question as resolved.
**The claim to test:** the answer asserts evening training is better and says "the research settled on" it. My note says the circadian temperature curve and the performance differences are real, but small, dependent on outcome measure, sex and training status, with findings running both ways.
**What to establish:** that the literature genuinely is mixed — ideally a recent review or meta-analysis that says so in as many words. This is the hardest of the six to verify, because you are establishing the *state of a field* rather than a single fact.
**Authored queries:** `morning vs evening exercise which is better research` · `time of day exercise performance meta-analysis`
**Watch for:** the line between `contested` and `unsupported` is what this item measures, and it is a judgement call. If your reading is that the evidence has in fact converged on evening, the key is wrong and the item needs re-keying or replacing — flag it, don't split the difference.

---

### `ev2-a6` — why onions make you cry · difficulty 2 · module `e6-reflex` · **CONTROL**

**Recorded verdict:** `supported`. Correct, and deliberately **unsourced** — the item tests that a missing citation triggers a check rather than disbelief.
**The claim to test:** that cutting ruptures cells, mixing sulfur compounds with enzymes; that the product is the volatile syn-propanethial-S-oxide; that it forms a mild acid on contact with the eye; and that chilling and a sharp knife both reduce the effect.
**What to establish:** all of the above, particularly the compound name and the sharp-knife claim, which is the most folk-wisdom-sounding part of an otherwise chemical explanation.
**Authored queries:** `why do onions make you cry chemistry` · `syn-propanethial-S-oxide`
**Watch for:** same as `ev2-a3` — this is a control and must be airtight. Note that its answer is written with no citation *on purpose*; the absence is part of the item and must not be "fixed".

---

## 6. What to do when something is wrong

Do not repair a key, a profile or an item's text on your own initiative. An item is a small interlocking machine — profile implies verdict, verdict implies fault tag, fault target drives partial credit — and changing one part to match a finding will usually break another part in a way that still compiles.

Instead, for each problem, record:

- the `itemId`
- which of the three it is: **key wrong** / **note incomplete** / **not checkable in the time budget**
- what you found, with links
- your suggested verdict, if you have one

Hand that back rather than editing. Leave `keyVerifiedAt` as `null` on any item you couldn't confirm — a partially verified form is fine and the gate handles it; a form containing one unverified key that has been marked verified is not fine, and nothing downstream can detect it.

## 7. Related work, deliberately not part of the twelve

- **Persian review.** The `fa` surface is machine-drafted (`reviewStatus: "draft"`, surfaced in the UI). A native speaker needs to post-edit all 42 items for naturalness and for whether each item's fault survives in Persian. Separate job, plausibly the same person, tracked separately — it does not block the baseline, only the claim that the Persian version is equal in quality.
- **Forms B and C.** The before/after design needs three matched forms (baseline, post, 7-day delayed); only A exists. Authoring B and C is a content job, not a verification job, and it should wait until A has been through this process — there is no point matching two more forms to an instrument that may still change.

---

## Changelog

- **0.1 · 2026-08-01** — Written for outsourcing. Twelve outstanding tasks enumerated (6 items × key confirmation + snapshot capture), per-item detail and pitfalls, recording procedure, and the escalation path for a key that turns out to be wrong.
