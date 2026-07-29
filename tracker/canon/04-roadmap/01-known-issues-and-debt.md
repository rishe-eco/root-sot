# Tracker — Known Issues & Debt

*Source of truth. The bug catalogue and hygiene items. Status must be re-verified — read the grounding note. Update the changelog; don't fork.*

**Version 0.1 · Status: mixed (see per-item grounding) · 2026-07-22 · Owner: _root**

---

> **Grounding — important.** This catalogue was compiled from a **source-code audit on 2026-06-10** (`../../base/archived/tracker mvp roadmap - Jun 10, 26.md`). Since then B-1/B-2/B-3 were fixed (2026-07-16) and substantial feature + test work landed. The remaining items **have not been individually re-verified against current code.** Treat each open item as "reported, verify before acting." Where a bug is contradicted by later work, it's noted.

## Fixed ✓

- **B-1 — Delete without confirmation** (`ActionPreview`). Fixed 2026-07-16; deletes now route through `ConfirmDialog`.
- **B-2 — Toggle doesn't persist checked state** (`ActionPreview` `useEffect` dep). Fixed 2026-07-16.
- **B-3 — "Show more" hides the Add-action button** (`ProjectPreview`). Fixed 2026-07-16.

## Open — data integrity (highest priority to re-verify)

- **B-10 — Postponed actions vanish from the daily flow.** `postponeAction` sets `actionFate: Postponed`, but Today/Pre-day/After-day queries exclude any non-null `actionFate`. A postponed action moves to its new date *and* becomes invisible there. **Fix:** clear `actionFate` on reschedule, or treat `Postponed` as transitional in the day queries.
- **B-11 — Postponed gathered actions keep old `startTimeOfDay`.** On postpone, the old time isn't cleared, so the action reappears pre-slotted and skips Pre-day's time-assignment. **Fix:** null `startTimeOfDay` on postpone.
- **B-5 — `ActionForm` edit crash.** `setTempTitle`/`setTempDod` called without the state being declared — a runtime error in edit mode. **Likely already resolved** given the feature/test work since; verify `ActionForm.tsx`.
- **B-14 — New-user first-day deadlock.** A missing yesterday `DayState` is treated as "After-day required," so a brand-new user meets the end-of-day cleanup before doing anything. **Fix:** `afterDayRequired = yesterdayState != null && yesterdayState.afterDayCompletedAt == null`.

## Open — computed status / calendar

- **B-15 — Goal Group status always "Backlog".** `getGoalStatus` reads `props.projects`, which is empty for a goal group (it holds child goals). Also breaks the "Hide Done" filter for groups. **Fix:** exclude goal groups from status computation (treat as containers), or recurse child goals. *(This is the concrete instance of the "inference cascade is partial" caveat in `01-product/00-concepts-and-hierarchy.md` §5.)*
- **B-8 — Calendar omits gathered actions.** Gathered actions use `forDate`, not `tbd`; the calendar's queries filter by `tbd`. **Fix:** a date-range query returning actions by `tbd` **or** `forDate`.
- **B-13 — Calendar shows only interval custom dates, not recurrence.** Rule-based intervals produce no calendar events. **Fix:** run `intervalOccursOnDate` across the visible range (bounded, e.g. ≤90 days).
- **B-12 — Milestone `doa` parsed as a date.** The calendar falls back to `parseDateOnly(m.doa)`, but `doa` is free text → `Invalid Date`/`NaN`. **Fix:** use only `predictionDate` for milestone placement.

## Open — UX / smaller

- **B-7 — Project start/end dates not editable.** Fields exist and drive status, but no UI/mutation args to set them → projects stuck in "Backlog." **Fix:** add date args to `updateProject` + pickers. *(Verify — may have been addressed alongside status work.)*
- **B-6 — Goals dropdowns show only root goals.** `IntervalForm`/`ProjectForm` reuse the default `goals` query (root-level only), so child goals can't be linked. **Fix:** pass an `includeAll` flag in those dropdowns.
- **B-4 — Milestone prediction date locked after first edit.** Once set, it's read-only with no way to change/clear. **Fix:** add a "Change"/"Clear" affordance.
- **B-9 — After-day "Tomorrow review" hidden inside Pre-day.** Intentional asymmetry; decide whether to document or unify.

## Hygiene / security

> From Root canon `organize.md` appendix — contents not inspected; verify and act at refactor time.

- Frontend repo has committed `.env` / `.env.production`; the API has a committed `dev.db`. **If any hold real secrets, treat as exposed and rotate.** Add to `.gitignore` going forward.
- Production `JWT_SECRET` must be a strong random value (the code defaults to `dev-secret` if unset — never ship that).

## How to use this file

Before working a bug, re-read the cited file(s), confirm the issue still reproduces, then fix and move it to **Fixed** with a date. Don't trust the "Open" status blindly — it's a June-10 snapshot with a few July updates.

---

## Changelog

- **0.1 · 2026-07-22** — Initial. B-1/2/3 marked fixed; remaining items carried from the June-10 audit with verify-first flags and hygiene items from the Root appendix.
