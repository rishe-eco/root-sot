# Tracker — Base (source docs)

This folder holds the working documents created while building Tracker. As of **2026-07-22**, their contents have been absorbed into the Tracker canon (`../canon/`) — **that is now the source of truth.** These files are kept, organized into buckets, for provenance and history.

## research/ — design source material
Still-relevant source material that fed the canon. Narrow but authoritative for what it covers.

- **Rood DoD clarity questions.txt** — the exact copy for the five Clarity Check dimensions (Observability, Control, Binary Clarity, Ownership, Decomposability). Origin of `../canon/01-product/02-clarity-check.md`. Going forward, edit the canon; this is the historical source.
- **Status and date inferrence.txt** — the design spec for the cascading date/status inference. Origin of `../canon/01-product/00-concepts-and-hierarchy.md` §5. Note: the cascade is only partially implemented (see canon + bug B-15).

## archived/ — point-in-time planning snapshots
Kept for future reference; not current, not to be edited (they are historical records).

- **tracker mvp roadmap - Jun 10, 26.md** (+ .pdf) — the MVP planning roadmap. Source of the F-/B-/T- codes referenced throughout the canon's `../canon/04-roadmap/`. Many of its bugs are now fixed and many features now built — see `../canon/04-roadmap/00-state-of-the-build.md` for current status.
- **Tracker status - Jun10, 26.pdf** — a June-10 status snapshot (PDF).

## Where to look now

| For… | Read |
|---|---|
| What Tracker is / how it works | `../canon/00-orientation/`, `../canon/01-product/` |
| Architecture, data model, API | `../canon/02-architecture/` |
| Setup / run / deploy | `../canon/03-engineering/`, `../DEPLOY-VPS.md` |
| What's built / bugs / refactor | `../canon/04-roadmap/` — and `../roadmap.md` for the ordering |
| Designed but unbuilt | `../canon/06-specs/`, indexed by `../notes.md` |
| How we got here | `../decisions/decision-log.md` |

---

*Note, 2026-07-29:* an earlier version of this file also described a **`deprecated/`** bucket holding `Tracker doc - Jun10, 26.md` and a duplicate of `DEPLOY-VPS.md`. Neither that folder nor those files are present here, and they were already absent before the repo consolidation — the section has been removed rather than left pointing at nothing. If those files matter, they are recoverable from the pre-consolidation `trackerSOT` history.
