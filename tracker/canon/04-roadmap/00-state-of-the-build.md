# Tracker — State of the Build

*Source of truth. What exists and what doesn't, verified. The most time-sensitive file in the canon — trust the date. Update the changelog; don't fork.*

**Version 0.2 · Status: as-built · 2026-08-01 · Owner: _root**

---

> Verified against the schema, migrations, and component tree on 2026-07-22. Feature codes (F-n / B-n / T-n) reference the June-10 MVP roadmap (`../../base/archived/tracker mvp roadmap - Jun 10, 26.md`), kept as an archived planning artifact.

## Built and working ●

**Core execution**
- Full CRUD across the hierarchy: Goals, Goal Groups, Milestones, Projects, Actions, Intervals, Routines.
- Goal hierarchy: goal groups, milestone-linked child goals, drag-reorderable milestones, `isLast` completion marker.
- Interval recurrence engine (every-N, weekly/monthly/yearly rules, custom date lists) and the routine daily-blocks model.
- Action-gathering pipeline (today + 2 days), with dedup and hidden-until-`forDate` behavior.
- Pre-day and After-day wizards with overlap detection and the full action-fate disposition set.
- Today view (linked vs standalone), Calendar (month + week/day).
- Auth (register/login, JWT, bcrypt) with `requireAuth` + `ensureOwned`.
- P/S/O/B priority.

**Root-aligned features** (grafted toward the brand)
- **DoD Clarity Check** (F-1) — 5-dimension wizard, non-gating green/amber, persisted on `Goal`. *(migration `add_dod_clarity_to_goal`)*
- **Notes** (F-2) — polymorphic working notes on all entities. *(`add_notes`)*
- **Concepts page** (F-5) — in-app concept reference.
- **Onboarding** (F-6a/b) — first-login slideshow + per-module intro overlays, DB-persisted. *(`add_onboarding`)*
- **Journals** — linkable, shareable-by-email logs with opt-in discoverability; a seed of *Journey/ماجرا*. *(`add_journals`)*

**Engineering**
- Backend test suite: unit (auth, overlap, recurrence) + integration (actions, auth, gathering, goals, milestones, projects, today, journals). *(T-1, T-4)*
- Frontend end-to-end: Playwright across auth, actions, goals, journals, navigation, projects, today. *(T-3, substantial)*

**Recent fixes** (session 2026-07-16): delete-confirmation (B-1), toggle-sync (B-2), add-action-button visibility (B-3), plus e2e scaffolding.

## Not built ○

- **File attachments** (F-3) — no `Attachment` model, no UI. Storage strategy undecided.
- **Zero-to-goal Setup Wizard** (F-4) — the Clarity Check wizard exists and is embedded in the goal form, but the full guided goal→milestone→project→action creation flow is not built.
- **Focus Mode** — `UnderConstruction` placeholder only.
- **Insights module** — empty reserved directory.
- **Interactive tutorials** (F-6c) — deferred; depends on the module-intro infra (built) as a base.

## Deliberately out of scope

- **Habits / streaks** — an earlier streak-style habits model was *removed* (`remove_habits` migration); recurrence lives in intervals/routines instead. This is a philosophy choice (Root refuses streaks), not a gap.
- **Native iOS/Android apps** — PWA only; native is a post-MVP distribution decision.
- **Rich-text / internal document editor** — deferred.

## Other pillars (Root context)

Tracker is a **personal app and staging ground**, not itself a pillar. Its most-developed resident is the **Organize** prototype (this document); residents may later migrate to their own standalone app or be retired (decision log, 2026-08-01). A **Grow (Learn)** prototype now also lives here — the **Skills Engine** (Clarity Lab, Evidence Lab; `../06-specs/`), conceptually owned by the Learn pillar and hosted here for now. A third tool, **Decomposition Lab**, is **specced with wireframes and a build plan and has no code at all** as of 2026-08-11 (`../06-specs/03-decomposition-lab.md`) — listed here only so the absence is on the record in the file whose job is to prevent assuming things exist. **Maintain** and **Others** are not present. All pillar concept work is tracked in Root canon `02-pillars/`. See `02-refactor-toward-root.md` for how even the Organize prototype is only partly realized.

---

## Changelog

- **0.2 · 2026-08-01** — Reframed the "Other pillars" section: Tracker is a staging ground, not the Organize pillar; recorded the **Grow (Learn) Skills Engine** now hosted here (decision log, 2026-08-01). Build inventory itself unchanged and still verified as of 2026-07-22.
- **0.1 · 2026-07-22** — Initial. Inventory verified against the repo; feature codes mapped to the June-10 roadmap.
