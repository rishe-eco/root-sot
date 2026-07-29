# Root — Ecosystem Index

*This area holds the Root project's documents outside of running code. It has two layers, mirroring the canon's own vocabulary: a stable **canonical** layer and a moving **living** layer, plus provenance and research around them.*

**Start here if you're new:** read `canon/README.md` first (the canon is the source of truth), then this file for how everything else is organized. For what changed most recently, read `root-canon-log_2026-07-14_to_2026-07-22.md`. For the whole repo — this area plus Tracker — see `../README.md`.

---

## The piles

| Folder | What's in it | Source of truth? |
|---|---|---|
| **`canon/`** | **THE CANON** — the stable, cited source of truth for what Root is and how we work (philosophy, brand, pillars, engine, research grading). | **Yes — the apex.** |
| **`decisions/`** | The decision ledger, and going forward one ADR per decision. See `decisions/README.md` for the convention. | **Yes — for decisions.** |
| **`working/`** | Active, in-play documents — the "living layer." Website specs, the Learn Module 1 discovery doc, the personal goals/dogfooding spec, brand visual assets. These change as work proceeds; they graduate into canon only when stable. | No — in progress. |
| **`research/`** | Evidence base and domain research (the science under the pillars) + one private philosophy note. Reference material, not decisions. | No — inputs. |
| **`archive/`** | Provenance: authoritative *source records* that fed the canon — the LOCKED decision cards, the Learn design transcript, the standalone brand definition, and the dated canon snapshot (`.zip`). Kept intact as origins. | No — historical originals. |
| **`deprecated/`** | Superseded *drafts* of Root's own thinking (the trail from the earliest seed to the canon), each logged in `deprecated/DEPRECATED-LOG.md`. Kept only for lineage. | No — retired. |

## Top-level files

- **`ost.md`** — the **Opportunity Solution Tree**, the living artifact the five-phase engine moves down. Promoted out of the canon (`canon/03-engine/01-opportunity-solution-tree.md`) on 2026-07-29.
- **`roadmap.md`** — ecosystem sequencing: which pillar and which business stream get worked next. **A skeleton** — Root never had a roadmap file, so this one carries only already-decided sequencing and names its own gaps. Read its header before relying on it.
- **`root-canon-log_2026-07-14_to_2026-07-22.md`** — the bridge record: everything that happened across the seven sessions between the first canon and 2026-07-22. Read this to catch up on recent history.
- **`personal-canon.md`** — private register; see the note below.
- **`README.md`** — this file.

## Conventions

- **Deprecating something?** Move it to `deprecated/` and add a numbered gist entry to `deprecated/DEPRECATED-LOG.md` (append-only, chronological). See that file's header for the rule.
- **Canonical vs living:** if a document is stable enough to *cite* as source of truth, it belongs in `canon/`; if it's still moving week to week, it belongs in `working/`. (This is the canon's own house rule — see `canon/README.md`.)
- **Recording a decision?** Small items append to `decisions/decision-log.md`; anything you expect to cite later gets its own ADR. See `decisions/README.md`.
- **Private register:** material tagged INTERNAL/PRIVATE (`personal-canon.md`, `research/philosophy-bahai-anthropology-notes.md`) stays out of canon, onboarding, product, and client-facing docs by deliberate decision.

## The Tracker side

Tracker is the as-built implementation of Root's **Organize** pillar. It has its own area at `../tracker/` with the same shape — `canon/`, `decisions/`, plus `roadmap.md` and `notes.md`. On **what Tracker should become**, this area wins; on **what Tracker currently is**, `../tracker/` wins, because it is checked against running code.

*Structure established 2026-07-22. Folded into the `root-sot` repo as `ecosystem/` on 2026-07-29.*
