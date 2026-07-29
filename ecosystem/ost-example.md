# Opportunity Solution Tree — Worked Example

*Teaching artifact. The same tree at four moments, so the lifecycle in `ost.md` §3 and the update protocol in §5 are visible rather than described. Deliberately a toy domain — not a Root pillar, so it can never be mistaken for a live tree.*

**Version 0.1 · Status: reference · 2026-07-29 · Owner: _root**

---

## Why four snapshots

`ost.md` §4's micro-example teaches the *shape* in thirty seconds and should stay that short. What it can't show is the two things people actually get wrong:

1. **The tree is written whole, then sharpened** (§3) — not researched tier by tier.
2. **A tree after contact looks different from a tree before it** (§5) — and the after version is the one that's worth reading.

So this is one tree, four times. Notation per `working/affine-canvas-notation.md`: `○` untested · `◎` in test · `●` held · `◐` partial · `✕` failed, with `P1/P2/P3` marking how falsifiable the wording is.

The domain is hydration, continuing `ost.md` §4 rather than introducing a third example.

---

## Snapshot 1 — Phase 1, after interviews

Eight conversations. Opportunities are in participants' words, `n=` is how many raised it, `C·I·S` is common × impactful × solvable (1–3 each). Assumptions at this stage are deliberately broad.

```
OUTCOME  W-O · "I drink water consistently through my day"        [locked for the loop]

OPPORTUNITIES                                          n=   C·I·S
├─ W-1  "I forget — I'm heads-down and hours go by"    n=6   3·3·3   ← TARGET
├─ W-2  "I don't notice I'm thirsty until I ache"      n=4   2·3·1
└─ W-3  "there's water right there, I just don't want it" n=3 2·2·2

ASSUMPTIONS (broad — this is correct at P1)
○ P1  people can't see their own drinking pattern
○ P1  a cue at the right moment would be acted on
```

**Why W-1 was targeted, written on the canvas so the pick is auditable:** most common (6 of 8) and most solvable. W-2 scores equally on impact but `S=1` — training interoception is a different product. W-3 is a preference problem, not a memory one, and would fork the outcome.

**Note what is deliberately absent:** no solution tier yet. Sketching solutions before the gate is the most common way a loop goes wrong — you end up testing the idea you arrived with.

---

## Snapshot 2 — Phase 2, solutions and ranked assumptions

Three genuinely different approaches, not three variants of one. Then the pick, then assumptions **ranked riskiest-first** — the order is the whole point, because the riskiest one is what Phase 3 tests.

```
W-1  "I forget — I'm heads-down and hours go by"
├─ W-1a  timed reminders (notification every 90 min)
├─ W-1b  visible bottle as an ambient cue                ← CHOSEN
└─ W-1c  anchor to an existing habit (every coffee refill = one glass)

Chosen W-1b: highest confidence × lowest risk. W-1a is the obvious one and
interrupts exactly the deep work the opportunity is about. W-1c depends on a
habit only 3 of 6 had.

ASSUMPTIONS under W-1b — ranked by risk, riskiest first
○ P2  1. seeing the bottle prompts drinking, not just noticing it
○ P2  2. the bottle stays in the sightline across a working session
○ P2  3. a visible bottle catches attention at all
○ P2  4. people refill it rather than let it sit empty
```

Assumption 1 is load-bearing: if noticing doesn't convert to drinking, the whole approach is dead and 2–4 don't matter. That's what "ranked by risk" means — **not** ordered by how easy they are to check.

---

## Snapshot 3 — Phase 3, falsifiable

Same assumptions, rewritten so a result can contradict them. This rewrite *is* the Phase 2→3 transition.

```
◎ P3  1. Given a filled bottle placed in their sightline for five working days,
         participants drink from it ≥3 times per session unprompted, and can
         name the moment they noticed it.
○ P3  2. At four random checks per day, the bottle is within the participant's
         sightline in ≥80% of checks.
○ P3  3. Participants report noticing the bottle without being asked about it
         in the daily check-in.
○ P3  4. The bottle is refilled the same day it empties in ≥half of instances.
```

Compare 1 across the three snapshots — *"a cue would be acted on"* → *"seeing it prompts drinking"* → the version above. Vagueness at P1 is fine. **A `P1` assumption still sitting at Phase 3 is a bug**, not a status: the test will run and answer nothing.

---

## Snapshot 4 — after the test, at the Phase 4 gate

The snapshot that matters. Each assumption marked, each carrying **what was learned** — a learning, not a verdict. Failures stay on the canvas, struck through.

```
● P3  1. HELD — 5 of 6 drank ≥3×/session unprompted.
         Learned: the *first* drink was the hard one; after that it self-sustained.

✕ P3  2. FAILED — bottle left the sightline by day 2 in 4 of 6 cases, moved for desk space.
         Learned: sightline isn't a stable property. The cue has to survive a tidy desk.

◐ P3  3. PARTIAL — noticed reliably while seated; not at all when standing or moving.
         Learned: this is a desk intervention, and shouldn't pretend to be general.

◐ P3  4. PARTIAL — refilled when the tap was under ~10 steps away; rarely otherwise.
         Learned: refill distance is a hidden precondition nobody mentioned in interviews.
```

**Phase 4 decision: ITERATE on W-1b** — recorded in `decisions/`, not on the canvas.

The load-bearing assumption held: seeing it does convert to drinking. What failed was placement, which is mechanical. So this is an iterate, not a pivot — the next test uses a cue that can't be moved out of the sightline (monitor stand, screen-edge marker). Had assumption 1 failed instead, the same four results would have meant **pivot to W-1c**, because the approach itself would be dead.

**This is the distinction the snapshot exists to teach.** Iterate vs. pivot is decided by *which* assumption failed, not by how many.

Also note what the tree now carries that no summary would: refill distance (assumption 4) never came up in eight interviews and is a real constraint on the next design. Tests produce findings the tree didn't ask for. Log them where they surfaced.

---

## What to copy from this

- **Opportunities in the participant's words.** If it reads like a feature, it's a solution in the wrong band.
- **Write the pick reasoning on the canvas.** In three weeks you will not remember why W-2 lost, and `S=1` alone doesn't say it.
- **Rank by risk, not by convenience.** Then test the top one.
- **Keep failures visible.** A tree showing only what worked can't be read for how tight anything is — which is the one thing a teammate needs from it.
- **Learnings, not verdicts.** "FAILED" is worth nothing; "sightline isn't a stable property" changes the next design.

---

## Changelog

- **0.1 · 2026-07-29** — Initial. Four snapshots of the hydration tree (Phase 1 → 2 → 3 → post-test), extending `ost.md` §4 to show the sharpening lifecycle, risk ranking, the update protocol, and the iterate-vs-pivot distinction.
