# Affine Canvas Notation — Opportunity Solution Trees

*Draft. The visual grammar for View B (the OST edgeless canvas) and how its nodes link to View A (the task kanban). Answers the two open questions in `../ost.md` §6 and one in `../canon/03-engine/02-async-coordination.md` §7 — folds into those files once it has survived one real loop.*

**Version 0.1 · Status: draft (unpiloted) · 2026-07-29 · Owner: _root**

---

## 1. What this is for

A tree that a teammate can't read at a glance has failed at its one job — carrying reasoning between people without a meeting (`02-async-coordination.md` §1). This file fixes the conventions that make a canvas readable cold: where a node sits, what shape it is, what its colour means, and how tight it currently is.

**One canvas per pillar.** Never one canvas holding several pillars — the WIP limit is supposed to be visible, and merged canvases hide it.

## 2. The canvas header block

Top-left of every canvas, mirroring the header every canon file carries. A canvas without this is not citable and probably stale.

```
PILLAR    Learn — Module 1 (Feelings & Needs)
OUTCOME   LRN-O · <the one locked sentence>
LOOP      2 of ? · currently PHASE 1
UPDATED   2026-07-29 · _root
```

`UPDATED` is load-bearing. A living artifact nobody dates becomes a confident lie — the same reason the roadmap files carry dates.

## 3. Layout: four fixed bands

The single most valuable convention. Each tier sits in its own horizontal band at a **fixed vertical position**, so a node's type is readable from where it is, before you trace a single edge.

```
┌─────────────────────────────────────────────────────────┐
│  HYPOTHESES   │            OUTCOME  (one, full width)   │  ← band 0
│  (off-tree    ├─────────────────────────────────────────┤
│   lane, left  │            OPPORTUNITIES                │  ← band 1
│   margin)     ├─────────────────────────────────────────┤
│               │            SOLUTIONS                    │  ← band 2
│               ├─────────────────────────────────────────┤
│               │            ASSUMPTIONS                  │  ← band 3
└─────────────────────────────────────────────────────────┘
                             CLOSED LOOPS ↓ (dated, below)
```

**Horizontal order carries meaning: leftmost = current target.** That gives you a second free signal with no extra notation.

**Only the targeted opportunity carries a solution subtree.** Siblings stay bare until their turn. This is what makes "one opportunity at a time" visible rather than a rule you remember.

*Sibling order runs left-to-right even on Persian canvases.* The tree flows top-down so direction barely bites, and mixing orders between canvases costs more than consistency does.

## 4. Node types — shape

Shape carries type, and nothing else.

| Tier | Shape | Contains |
|---|---|---|
| Outcome | one wide banner, full width | the locked sentence + `LRN-O` |
| Opportunity | rounded rectangle | ID, the need **in the participant's words**, badges |
| Solution | square rectangle | ID, the approach in one line |
| Assumption | small sticky note | ID, the claim, status glyph, phase badge |

Opportunities are quotes, not diagnoses. If an opportunity reads like a feature, it's a solution sitting in the wrong band.

## 5. Status — glyph first, colour second

Status exists **only on assumptions.** Nothing else on the canvas is coloured. If everything is coloured, nothing reads.

Extends the `● ◐ ○` legend already used in `../../tracker/canon/01-product/03-modules.md` and `../../tracker/canon/04-roadmap/00-state-of-the-build.md`:

| Glyph | Colour | Means |
|---|---|---|
| `○` | grey | untested |
| `◎` | blue outline | **in test now** |
| `●` | green | held |
| `◐` | amber | partial — held under some conditions, note which |
| `✕` | red + strikethrough | failed |

**The glyph is the signal; colour only makes it faster.** Never colour-alone — you will eventually export this, screenshot it, or hand it to someone who can't separate the reds.

## 6. Badges — "how tight is this?"

Each tier gets the one badge that's actually decision-useful for it. This is what makes §5 of `../ost.md` legible: a `P1` sticky beside a green `P3` tells a teammate exactly where the soft ground is.

| Tier | Badge | Reads as |
|---|---|---|
| Opportunity | `n=7` | how many participants raised it — feeds *most common* |
| Opportunity | `C3 I2 S3` | common × impactful × solvable, 1–3 each — makes the Phase-2 pick defensible instead of a hunch |
| Solution | *none* | they're candidates; a badge would imply a ranking you haven't earned |
| Assumption | `P1` `P2` `P3` | how falsifiable the **wording** currently is, per `../ost.md` §3 |

A `P1` assumption at Phase 3 is a bug, not a status. It means the test will answer nothing.

## 7. Connectors

Three, no more.

- **Solid** — live branch
- **Dashed** — provisional; not yet evidenced (every pre-interview opportunity starts dashed)
- **Faded** — closed or abandoned; kept for lineage

## 8. IDs, and the link to View A

Nodes are addressed by ID, not by Affine's internal linking — so the trace survives a tool change and works in a screenshot. Same instinct as Tracker's `F-`/`B-`/`T-` codes.

```
LRN-O        outcome (one per loop, locked)
LRN-1..5     opportunities
LRN-2a       solutions under opportunity 2
LRN-2b.1     assumptions under solution 2b
```

Pillar prefixes: `LRN` `RFL` `ORG` `MNT` `OTH`.

**A View A card that serves a tree is titled with its node ID:**

```
LRN-2b.1 · Test: timeline reveals ≥2 deviations
```

Work that will never hang off a tree takes an area prefix instead — `STU` (root-app) · `TRK` (Tracker) · `OPS` (VPS, Affine) · `CAST` · `SOT`. Most current work is this kind, and labelling it honestly stops infrastructure masquerading as discovery.

## 9. The update ritual

Per `../ost.md` §5 — after every test, before the Phase 4 gate:

1. Mark each assumption `●` / `◐` / `✕`, and append **one line of what was learned** — not a verdict, the learning.
2. Strike through the failed; **don't delete it.** A tree that only shows what worked can't be read for how tight anything is.
3. Fade the abandoned branch's connectors.
4. Bump `UPDATED` in the header block.
5. Record the *decision* — iterate / pivot / move on — in `../decisions/`, **not on the canvas.** The canvas shows state; the ledger holds decisions.

Step 5 is the git/Affine seam restated at node level. When a decision only exists on a canvas, it's unversioned and uncitable.

## 10. Refusals

Stated so they don't get re-invented mid-loop:

- **No colour outside assumption status.** Not for priority, not for owner, not for pillar.
- **No deleting failed nodes.** Same lineage instinct as `../deprecated/`.
- **No second opportunity growing a solution subtree** while one is live.
- **No two pillars on one canvas.**
- **No assumption you couldn't design a test against by Phase 3.** Vague is fine at P1, fatal at P3.
- **No decisions recorded only on the canvas.**
- **Count learning, not activity.** Node counts and tested-assumption tallies measure motion, not progress. The canvas is read for *how tight each decision is* — the phase badges are the progress indication, and they're the right kind. A number that makes a slow decisive loop look worse than a fast inconclusive one is measuring the wrong thing.

## 11. Still open

- Whether Affine's edgeless canvas can hold the fixed-band layout without nodes drifting — the first real test of this file.
- Whether `C·I·S` scoring survives contact or collapses into a hunch with numbers on it.
- Export/backup: the canon is versioned in git, the canvases are not. A pillar's tree is a genuine project asset; decide how it gets snapshotted before a loop closes.

---

## Changelog

- **0.1 · 2026-07-29** — Initial draft. Header block, four fixed bands, shape-for-type, `● ◐ ○ ✕` status extending the existing house legend, per-tier badges, three connectors, the `LRN-2b.1` ID scheme and its View A card format, the post-test update ritual, and the refusals.
