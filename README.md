# Root — Source of Truth

*The index. One repository holding the non-code source of truth for the Root ecosystem and for Tracker, its first product. Start here; this file only tells you where to go.*

**Version 0.3 · Status: canonical · 2026-11-16 · Owner: _root**

---

## Where things are now

**`ecosystem/roadmap.md` §0** says what Root is working toward and where every piece stands, as of the date in its header. The decision behind it is `ecosystem/decisions/0002-product-ladder-to-hamrah-prototype.md`. If you read one thing before starting work, read that section.

## The areas

| Area | What it owns | Grading |
|---|---|---|
| **`ecosystem/`** | Root itself — brand, philosophy, the five pillars, the engine, the Opportunity Solution Tree. The *why*. Changes slowly, graded by evidence. | evidence |
| **`tracker/`** | Tracker — the as-built personal app and staging ground where pillar prototypes are built and felt. The *what* and *how*. Graded by the code. | the code |
| **`team/`** | Work blocked on a person rather than on code — content verification, native-speaker review, scoring calibration, decisions awaiting a call. The *who and when*. Graded by whether it moves. | whether it moves |
| **`lifecycle/`** | The method every module is built by: tracks, phases and gates, the skills, per-project settings, and the status table (`lifecycle/status.md`). The *how we build*. Start at `lifecycle/README.md`. | its own decision log (`L-n`) |
| **`imnstr/`** | IMNSTR, a personal site that is outside Root (`lifecycle/projects/imnstr/config.md` §1). Its documents are here because it was the lifecycle method's trial run. | the code |

**Brand is the apex.** Everything in `ecosystem/canon/01-philosophy/01-brand-definition.md` outranks everything else in this repo. When `tracker/` and `ecosystem/` disagree, distinguish the question: on **what Tracker should become**, ecosystem wins; on **what Tracker currently is**, tracker wins, because it is checked against running code.

## Read order

**Where things are now:** `ecosystem/roadmap.md` §0, then the newest ADR in `ecosystem/decisions/`.

**New to Root:** `ecosystem/canon/01-philosophy/01-brand-definition.md` → `00-core-philosophy.md` → `02-anti-patterns-and-constraints.md` → `ecosystem/canon/02-pillars/00-the-loop.md` → the pillar files → `ecosystem/canon/03-engine/00-five-phase-engine.md` → `ecosystem/ost.md`.

**Picking up Tracker work:** `tracker/canon/00-orientation/01-glossary.md` → the relevant `01-product/` file → `tracker/canon/02-architecture/04-conventions.md`. The conventions file is the one that most prevents mistakes.

**Catching up on recent history:** `ecosystem/root-canon-log_2026-07-14_to_2026-07-22.md`, then the two decision logs.

**Looking for something to pick up:** `team/open-work.md`. Everything there is blocked on a person, not on code.

## Map

```
root-sot/
  README.md                    this file
  ecosystem/
    README.md                  the working-folder index (piles, conventions)
    ost.md                     the Opportunity Solution Tree
    roadmap.md                 §0: where things are now; §1–§6: the earlier skeleton
    decisions/                 ADRs: Root brand + shared platform (0002 = current direction)
      decision-log.md          the append-only ledger (pre-ADR)
    canon/                     THE CANON — philosophy, pillars, engine, research
    working/                   living layer: website specs, Learn discovery, brand assets
    modules/                   lifecycle module folders for root-app work
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
                               04-roadmap (as-built inventory), 06-specs (the
                               Skills Engine — partly built, a Learn prototype)
    modules/                   lifecycle module folders for Tracker work
    drafts/                    Time Themes spec, plan and wireframes; the session
                               rhythm concept (session-rhythm.md)
    docs/                      older backend docs (superseded by canon, kept)
    base/                      archived planning artifacts + research notes
    DEPLOY-VPS.md              deployment runbook
  team/
    README.md                  why this area exists, and its house rules
    open-work.md               the queue: what is waiting, on whom, and why
  lifecycle/
    README.md                  the method: tracks, phases, gates, rules
    status.md                  one row per module, one column per phase
    STATE.md                   the latest handoff for work without a module
    decision-log.md            decisions about the method (L-n)
    skills/, skills-plan.md    the skills and their specification
    projects/                  per-project settings: imnstr, root-app, tracker
    templates/, bin/           phase templates; the gate and its tests
    learnings/, retros/, trial-run/
  imnstr/
    modules/01-website/        IMNSTR's module folder
    open-work.md               what IMNSTR's build left owed
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
- **`root-app`** — the Root Studio website-as-application (see `ecosystem/working/root-website-v3-overview.md`). An npm-workspaces monorepo: `apps/web` (Vite + React, Persian-first and RTL, with the thin operational admin at `src/admin`) and `apps/api` (Express + Apollo + Prisma over **Postgres**). Its current state is in `ecosystem/roadmap.md` §0.2 and in that repo's `docs/development/README.md`. Was named `root-website` until 2026-07-29.
- **`i-monster`** — the code for IMNSTR.com: one Node process with server-rendered pages and a SQLite file. Outside Root; described by this repo's `imnstr/` area.

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

- **0.3 · 2026-11-16** — **The index catches up with the repo.** Added *Where things are now*, pointing at `ecosystem/roadmap.md` §0 and ADR 0002. Added the two areas that arrived in October and were never indexed: `lifecycle/` and `imnstr/`. Map corrected: `docs/`, `base/` and `DEPLOY-VPS.md` were drawn under `team/` and are in `tracker/`; module folders and `tracker/drafts/` added. *Where the code lives* gains `i-monster`, and root-app's line no longer says "Phase 0 and most of Phase 1". Written by Claude; not yet read by the founder.
- **0.2 · 2026-08-01** — Added the **`team/`** area for work blocked on a person, prompted by the Skills Engine shipping into a state where every remaining gate is human. Restated `tracker/` as a staging ground rather than "the Organize pillar" (ecosystem decision log, 2026-08-01).
- **0.1 · 2026-07-29** — Initial. Two repos consolidated into one; `ecosystem/` + `tracker/` spine established.
