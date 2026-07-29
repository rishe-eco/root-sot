# Root — Source of Truth

*The index. One repository holding the non-code source of truth for the Root ecosystem and for Tracker, its first product. Start here; this file only tells you where to go.*

**Version 0.1 · Status: canonical · 2026-07-29 · Owner: _root**

---

## The two areas

| Area | What it owns | Grading |
|---|---|---|
| **`ecosystem/`** | Root itself — brand, philosophy, the five pillars, the engine, the Opportunity Solution Tree. The *why*. Changes slowly, graded by evidence. | evidence |
| **`tracker/`** | Tracker — the as-built product that implements Root's **Organize** pillar. The *what* and *how*. Graded by the code. | the code |

**Brand is the apex.** Everything in `ecosystem/canon/01-philosophy/01-brand-definition.md` outranks everything else in this repo. When `tracker/` and `ecosystem/` disagree, distinguish the question: on **what Tracker should become**, ecosystem wins; on **what Tracker currently is**, tracker wins, because it is checked against running code.

## Read order

**New to Root:** `ecosystem/canon/01-philosophy/01-brand-definition.md` → `00-core-philosophy.md` → `02-anti-patterns-and-constraints.md` → `ecosystem/canon/02-pillars/00-the-loop.md` → the pillar files → `ecosystem/canon/03-engine/00-five-phase-engine.md` → `ecosystem/ost.md`.

**Picking up Tracker work:** `tracker/canon/00-orientation/01-glossary.md` → the relevant `01-product/` file → `tracker/canon/02-architecture/04-conventions.md`. The conventions file is the one that most prevents mistakes.

**Catching up on recent history:** `ecosystem/root-canon-log_2026-07-14_to_2026-07-22.md`, then the two decision logs.

## Map

```
root-sot/
  README.md                    this file
  ecosystem/
    README.md                  the working-folder index (piles, conventions)
    ost.md                     the Opportunity Solution Tree
    roadmap.md                 ecosystem sequencing  ← SKELETON, see note below
    decisions/                 ADRs: Root brand + shared platform
      decision-log.md          the append-only ledger (pre-ADR)
    canon/                     THE CANON — philosophy, pillars, engine, research
    working/                   living layer: website specs, Learn discovery, brand assets
    research/                  evidence base + domain research
    archive/                   provenance: source records that fed the canon
    deprecated/                superseded drafts, each logged
    personal-canon.md          private register
    root-canon-log_*.md        bridge record, 2026-07-14 → 07-22
  tracker/
    roadmap.md                 what's next, in order
    notes.md                   R&D log: what's being tested for graduation
    decisions/                 Tracker-only ADRs
      decision-log.md          the append-only ledger (pre-ADR)
    canon/                     orientation, product, architecture, engineering,
                               04-roadmap (as-built inventory), 06-specs (unbuilt)
    docs/                      older backend docs (superseded by canon, kept)
    base/                      archived planning artifacts + research notes
    DEPLOY-VPS.md              deployment runbook
```

## House rules (inherited from both canons)

- **Don't fork a decision — update it.** One file per topic. If something changes, edit the file and add a changelog line. Two files disagreeing within a week is the failure mode this repo exists to prevent.
- **Every file carries a header:** version, status, date, owner, and a one-line "what this is."
- **Grade your grounding.** Claims are **as-built** (verified against the repo on the header date), **spec** (designed, may not match code), or **inferred** (reasoned from structure — "verify in code").
- **The code is the tiebreaker** for anything in `tracker/`.
- **Deprecating something?** Move it to `ecosystem/deprecated/` and add a numbered entry to `DEPRECATED-LOG.md`.
- **Private register:** material tagged INTERNAL/PRIVATE (`ecosystem/personal-canon.md`, `ecosystem/research/philosophy-bahai-anthropology-notes.md`) stays out of canon, onboarding, product, and client-facing docs by deliberate decision.

## Where the code lives

This repo holds no code. Its siblings in the `rishe-eco` organization:

- **`tracker`** — `api/` (Express + GraphQL + Prisma + SQLite) and `client/` (React Router + Vite PWA). The as-built product this repo's `tracker/` area describes.
- **`root-app`** — the Root Studio website-as-application (see `ecosystem/working/root-website-v3-overview.md`). An npm-workspaces monorepo: `apps/web` (Vite + React, Persian-first and RTL, with the thin operational admin at `src/admin`) and `apps/api` (Express + Apollo + Prisma over **Postgres**). Phase 0 and most of Phase 1 are built. Was named `root-website` until 2026-07-29.

## Consolidation note — read once

This repo was assembled on **2026-07-29** from two previous repos (`rishe-eco/root-sot`, `rishe-eco/trackerSOT`) and their local working copies. Content is complete: every file from both sources is present, and **internal cross-references were rewritten to match the new layout** in the same pass.

**Paths that moved.** Kept as a decoder for anything written before 2026-07-29 — older notes, commit messages, and the pre-consolidation history of both source repos still use the left-hand column.

| Was | Is now |
|---|---|
| `root-canon/03-engine/01-opportunity-solution-tree.md` | `ecosystem/ost.md` |
| `root-canon/05-log/decision-log.md` | `ecosystem/decisions/decision-log.md` |
| `tracker-canon/05-log/decision-log.md` | `tracker/decisions/decision-log.md` |
| `root-canon/`, `Working/`, `Research/`, `Archive/`, `Deprecated/` | `ecosystem/canon/`, `working/`, `research/`, `archive/`, `deprecated/` |
| `tracker-canon/`, `docs/`, `Base/` | `tracker/canon/`, `docs/`, `base/` |

**Code paths point at a sibling repo.** Both canons cite application code — `api/src/...`, `client/app/...`. Those are relative to the **`rishe-eco/tracker`** repo, not to this one. They were `tracker-api/` and `tracker-project/` before the code repos were consolidated on the same date; the workspaces still carry those two `package.json` names.

**What was deliberately left alone.** Historical narrative still names things as they were called at the time — the `root-canon-log`, the `DEPRECATED-LOG`, and the two decision logs describe a `root-canon/` directory and a `05-log/`, because that is what existed on those dates. Those are records, not links, and rewriting them would falsify the account. The `--name tracker-api` PM2 process in `tracker/DEPLOY-VPS.md` is likewise unchanged: it identifies a running service on the VPS, not a path.

One inaccuracy inherited from the sources was corrected rather than carried: `tracker/base/README.md` described a `deprecated/` bucket and two files that were already absent before consolidation. See the note at the foot of that file.

---

## Changelog

- **0.1 · 2026-07-29** — Initial. Two repos consolidated into one; `ecosystem/` + `tracker/` spine established.
