# Tracker — Roadmap

*Source of truth for sequence: what gets done next, in what order, and why. Synthesized from the three `canon/04-roadmap/` files, which remain the detailed sources. Update the changelog; don't fork.*

**Version 0.1 · Status: draft (sequencing is a proposal; the inputs are as-built) · 2026-07-29 · Owner: _root**

---

> **How this file relates to the canon.** It does not restate what exists — `canon/04-roadmap/00-state-of-the-build.md` owns the verified inventory, `canon/04-roadmap/01-known-issues-and-debt.md` owns the bug catalogue, `canon/04-roadmap/02-refactor-toward-root.md` owns the gap to the Organize pillar. This file holds the one thing none of them holds: **order**. Read it as a proposal to argue with, not a settled plan — the roadmap is the least-verified document in this repo.

## 1. The strategic question that gates everything

Tracker is **overwhelmingly outcome 3** of Organize's four outcomes — *track pursuit over time*. Outcome 2, *understand loopholes* (seeing your own patterns in how you pursue and drop goals), is the leverage outcome and **is not built at all**. Current lean is to tackle outcome 2 first, but this is a discovery decision, not settled (`canon/04-roadmap/02-refactor-toward-root.md` §5).

**Nothing below is worth sequencing until that lean is confirmed or replaced**, because it decides whether the next phase is a refactor or a feature push.

## 2. Now — data integrity, before anything else

These are correctness bugs in the daily flow, the one path every user takes every day. All four are **reported from a 2026-06-10 audit and not individually re-verified** — confirm each still reproduces before acting.

| ID | Issue | Note |
|---|---|---|
| **B-10** | Postponed actions vanish from the daily flow | Fold into the refactor, not a patch — it lives at `ActionFate.Postponed`, exactly where a real failure/postpone concept gets reworked |
| **B-11** | Postponed gathered actions keep old `startTimeOfDay` | Pairs with B-10; fix together |
| **B-14** | New-user first-day deadlock — brand-new user meets After-day cleanup before doing anything | Onboarding-blocking |
| **B-5** | `ActionForm` edit crash | Likely already fixed by later work; **verify first** |

## 3. Then — security hygiene

Not a feature, and not optional. From `canon/04-roadmap/01-known-issues-and-debt.md`:

- Production `JWT_SECRET` must be a strong random value. The code **defaults to `dev-secret` if unset** — never ship that.
- The client's `.env` / `.env.production` are committed (verified 2026-07-29: they hold only API URLs, no secrets). A `dev.db` was committed to the API historically. **If any historical commit holds a real secret, treat it as exposed and rotate.**

## 4. Then — computed status and calendar correctness

The visible-wrongness tier. Users see incorrect state rather than losing data.

- **B-15** — Goal Group status always "Backlog" (also breaks the "Hide Done" filter). The concrete instance of the partial inference cascade.
- **B-8** — Calendar omits gathered actions (`forDate` vs `tbd`).
- **B-13** — Calendar shows only interval custom dates, not rule-based recurrence.
- **B-12** — Milestone `doa` parsed as a date → `Invalid Date`. Use only `predictionDate`.

## 5. Then — the Organize refactor

The real work, gated on §1. From `canon/04-roadmap/02-refactor-toward-root.md`, in dependency order:

1. **A mindset frame before execution** — Organize is meant to establish *pursuing a goal badly is information, not failure* before any tracking. Tracker opens straight into execution. Cheapest structural change, and it frames everything after it.
2. **Loophole recognition (outcome 2)** — the highest-leverage gap; no surface exists for seeing *how* one fails at pursuit.
3. **Failure handling with effort/outcome separation** — a first-class failure concept for goals/projects asking "in my control or not? what can I learn? what next?" Tracker has action *fates* but no goal *failure*. Absorbs B-10/B-11.
4. **Re-surfacing recurrence so it never reads as a streak** — a live design constraint, not a feature. `Interval`/`Routine` are streak-adjacent; the `remove_habits` migration shows streak-style habits were dropped once on purpose. Root refuses streaks.
5. **The Reflect↔Others motive coupling** — service goals arriving from Others via Reflect's motive check. This seam does not exist in Tracker at all; likely last.

**Open, and load-bearing:** whether the Pre-day/After-day cycle survives, changes, or retires under the new concept. That answer changes the size of items 1–3.

## 6. Parked — unbuilt features

Real gaps, but none blocks the refactor. Sequence after §5 unless one becomes urgent.

- **F-4 Zero-to-goal Setup Wizard** — the Clarity Check wizard exists inside the goal form; the full guided goal→milestone→project→action flow does not. Closest to shippable, and it serves outcome 4.
- **F-3 File attachments** — no `Attachment` model, no UI. Storage strategy undecided; decide before estimating.
- **Focus Mode** — `UnderConstruction` placeholder only.
- **Insights module** — empty reserved directory. Note this is where outcome 2 would most naturally land; consider merging it into §5.2 rather than treating it as its own feature.
- **F-6c Interactive tutorials** — deferred; the module-intro infrastructure it depends on is built.

## 7. Not doing — deliberate refusals

Restated so they don't get re-proposed: **habits / streaks** (a philosophy choice, not a gap — the `remove_habits` migration is deliberate), **native iOS/Android** (PWA only; post-MVP distribution decision), **rich-text / internal document editor**.

## 8. Not in this repo's scope

The **Maintain**, **Grow (Learn)**, and **Others** pillars are separate Root work, tracked in `../ecosystem/canon/02-pillars/`. The skill tools specified in `canon/06-specs/` are tracked in `notes.md`, not here — they are R&D awaiting graduation, not roadmap commitments.

---

## Changelog

- **0.1 · 2026-07-29** — Initial. Sequence synthesized from `04-roadmap/00`, `01`, and `02` (all v0.1, 2026-07-22) at repo consolidation. No new findings; ordering is the only new claim.
