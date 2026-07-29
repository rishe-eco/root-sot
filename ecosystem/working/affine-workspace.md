# Affine Workspace — Setup Guide

*Draft. The concrete structure for the three views named in `../canon/03-engine/02-async-coordination.md` §5, and the boundary rule for what lives in Affine versus this repo. Folds into that file once it has held for one loop.*

**Version 0.1 · Status: draft (unpiloted) · 2026-07-29 · Owner: _root**

---

## 1. The boundary rule

**This repo answers *what did we decide and why*. Affine answers *where are we right now*.**

Decisions and their rationale are versioned, diffable, citable, and readable end-to-end by a new contributor — human or agent — in one pass. Current state is visual, moves daily, and would be noise in a commit log.

The seam `02-async-coordination.md` §5 already warns about: pillar **definitions** live here; pillar **work-in-progress** lives in Affine.

Two consequences worth stating because both are easy to get wrong:

- **`../roadmap.md` and View C are not duplicates.** `roadmap.md` holds committed order, gating and refusals. View C holds current position. Enforce it as: **the board never explains why, and `../roadmap.md` never says where.** The moment you're editing both for one change, what you're editing is state — Affine only.
- **`ecosystem/working/` stays in git.** It's the living layer *for prose documents that will graduate into canon* — specs, discovery method, briefs. Affine takes the things whose shape isn't a document: boards, canvases, raw capture. The test is form, not stability: **is it a document, or is it a board?**

## 2. Workspace structure

Five top-level docs. Resist a sixth — a solo founder with a nested doc tree stops opening it.

```
00 · Start here          the index + this boundary rule, in three lines
10 · Pillar portfolio    VIEW C
20 · Work                VIEW A
30 · Trees               VIEW B — one canvas per pillar, as child docs
40 · Discovery log       raw capture for the active loop
```

`30 · Trees` is a parent with one child canvas per pillar. Never one canvas holding several — the WIP limit is meant to be visible and merged canvases hide it. Notation for these is `affine-canvas-notation.md`.

## 3. View C — Pillar portfolio

Cards are **pillars**, columns are **engine phases**. Its whole job is making overload obvious at a glance.

| Column | Holds |
|---|---|
| Not started | pillars with no loop opened |
| Phase 1 — Opportunities | mapping, interviews running |
| Phase 2 — Solutions | solution branch + ranked assumptions |
| **Phase 3 — TEST · max 1** | the WIP limit, in the column title |
| Phase 4 — Decide | at the gate; the one synchronous event |
| Phase 5 — Consolidate | feature spec being born |
| Outside the engine | built without running the engine |

Put the limit **in the column name**, not in a doc nobody reopens. A second card in Phase 3 should look wrong immediately.

**Current state, as of 2026-07-29:**

- **Learn** → Phase 1. Module 1 (Feelings & Needs); method and participant criteria drafted, interviews not yet run.
- **Reflect · Maintain · Others** → Not started. Any of them may enter Phases 1–2 in parallel at any time; none has.
- **Organize** → Outside the engine. Implemented as Tracker, which predates the engine and never ran a loop. Its sequence lives in `../../tracker/roadmap.md`.

**Ongoing tracks — a separate lane, not phase columns.** Root Cast, Root Studio (`root-app`), and Journey integration are *not pillars* and don't run the discovery engine. Giving them phase columns would imply an engine position they don't have. A plain lane at the bottom, or a `track` tag, is enough.

## 4. View A — Work

Task kanban. The canon says simple suffices, so:

```
Backlog → Next → In progress → Blocked → Done
```

**Card titles carry an ID.** Tree-linked work uses its node ID, so a card traces to a canvas node with no lookup:

```
LRN-2b.1 · Test: bottle stays in sightline across a session
```

Work that will never hang off a tree takes an area prefix instead:

| Prefix | Area |
|---|---|
| `STU` | Root Studio — the `root-app` repo |
| `TRK` | Tracker — the `tracker` repo |
| `OPS` | VPS, Affine, nginx, backups |
| `CAST` | Root Cast |
| `SOT` | canon and docs — this repo |

**Most current work is the second kind, and labelling it honestly matters.** It stops infrastructure from masquerading as discovery, and it makes visible how little of a given week was actually spent on the engine.

Suggested seeds, from what's already recorded as blocking:

- `STU` · generate the first real Postgres migration — never run against a live DB
- `STU` · wire email sending; invite and reset links currently go out by hand (`TODO(email)`)
- `STU` · design-concept image upload — schema has `imageUrl`, admin has no form
- `LRN` · lock the Module 1 outcome sentence — nothing else on the canvas can be placed until this exists
- `LRN` · recruit 7–10 participants against the screening criteria
- `OPS` · decide how a closed loop's canvas gets snapshotted (see §6)

## 5. View B — Trees

Covered in `affine-canvas-notation.md`. Two things belong here rather than there:

- **One canvas per pillar**, as a child of `30 · Trees`.
- **A canvas is not a decision record.** At every Phase 4 gate the decision — iterate, pivot, move on — is written to `../decisions/`. When a decision exists only on a canvas it is unversioned, uncitable, and invisible to anyone reading the repo.

For what a canvas looks like before and after contact, see `../ost-example.md`.

## 6. The gap this setup does not close

**The canon is versioned; the canvases are not.**

Every decision in this repo can be traced — `git log` reaches its origin, and `../archive/` keeps the source records the canon was built from. A canvas has none of that. Affine holds one live state, and editing it destroys the previous one.

That matters specifically at Phase 4. The decision record will say *"iterate on W-1b — assumption 1 held, 2 failed"*, and its justification **is the tree as it stood that day**. Six weeks and two loops later the canvas has moved on, and the evidence for a decision you're still living with is gone. Not corrupted — overwritten, silently, by normal use.

Database backups don't solve it. They protect against loss, not against overwrite, and restoring a whole workspace to read one old tree is not a citation.

Three candidate fixes, undecided:

1. **Export at each gate** — image or PDF of the canvas into `../decisions/`, named for the decision it justifies. Cheap; not diffable or searchable.
2. **Transcribe the closed tree to markdown** in the ASCII form `../ost-example.md` uses, committed beside the decision. More work per gate; fully diffable, greppable, and readable by an agent. Snapshot 4 of the example is exactly this artifact.
3. **Accept the loss** and treat canvases as scratch, with the decision record carrying enough prose to stand alone.

Option 2 is the one that fits how this repo already works — but it is real work at every gate, and a convention that's too expensive gets skipped, which is worse than choosing option 3 openly. **Decide before the first loop closes, not after you want the old tree back.**

## 7. Still open

- Whether Affine's edgeless canvas holds the fixed-band layout without nodes drifting.
- Linking View A cards to View B nodes *bidirectionally* — the ID scheme is one-way by design; whether Affine's backlinks add enough to bother with is untested.
- The Journey integration indicator (`02-async-coordination.md` §7) — a product decision, not a tooling one.

---

## Changelog

- **0.1 · 2026-07-29** — Initial draft. Boundary rule, five-doc workspace, View C columns with the WIP limit in the column name and current pillar positions, View A columns with the ID and area-prefix conventions plus seed cards, and §6 naming the canvas-versioning gap with three candidate fixes.
