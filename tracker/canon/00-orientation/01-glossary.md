# Tracker — Glossary

*Source of truth. The domain vocabulary. Read before touching code — these words have precise meanings here. Update the changelog; don't fork.*

**Version 0.1 · Status: as-built · 2026-07-22 · Owner: _root**

---

Terms are grouped. Where a term maps to a model field, the field is named so you can find it in `02-architecture/01-data-model.md`.

## The hierarchy of intent

- **Goal** — the top-level unit of intent. Has a **DoD** (definition of done). Can be a normal goal or a **Goal Group**. Model: `Goal`.
- **Goal Group** — a goal whose children are *other goals* rather than projects, for clustering related goals under a theme. `Goal.isGoalGroup = true`.
- **Milestone** — an ordered progress checkpoint inside a goal. Has a **DoA** (definition of achieved), an order, and an optional prediction date. One per goal may be marked **last** (the completion milestone). Model: `Milestone`.
- **Project** — a defined body of work under a goal *or* a milestone (never both). Holds actions. Model: `Project`.
- **Action** — the atomic, schedulable unit of work. The only thing you actually "do." Model: `Action`.

## Definitions and clarity

- **DoD — Definition of Done** — the free-text statement of what "done" means for a goal or project. Field: `dod`.
- **DoA — Definition of Achieved** — the milestone equivalent of a DoD. Field: `doa`. (Note: `doa` is *text*, not a date — a recurring source of bugs; see `04-roadmap`.)
- **Clarity Check** — a five-dimension structured review of whether a DoD is well-formed. Non-gating: it produces a soft green/amber indicator, never a block. Dimensions: **Observability, Control, Binary Clarity, Ownership, Decomposability**. Fields: `Goal.dodClarityStatus`, `Goal.dodFlaggedDimensions`. Full detail: `01-product/02-clarity-check.md`.

## Scheduling and time

- **tbd** — an action's scheduled/due calendar day (`Action.tbd`). Historically "to be done."
- **dateKey** — a calendar day as the string `"YYYY-MM-DD"`. The canonical day identifier across DayState and day-scoped queries.
- **startTimeOfDay** — when in the day an action starts, `"HH:mm"`. Assigned during Pre-day. Field: `Action.startTimeOfDay`.
- **estimatedTimeMinutes** — expected duration, required when an action has a `tbd`; max 1440 (24h).
- **Overlap** — two timed actions whose `[start, start + estimated)` windows intersect. Flagged (amber) in Pre-day.

## Recurrence

- **Interval** — a recurring work *template* that can be scoped to a goal, milestone, or project (one at most), or left standalone. Rich recurrence (every N units; specific weekdays/month-days/months; ad-hoc date lists). Generates gathered actions. Model: `Interval`.
- **Routine** — a daily, time-of-day recurring template with *no* goal/project link (e.g. a morning routine). Repeats via time-of-day blocks. Model: `Routine`.
- **Step** — an ordered sub-task on an interval or routine (a template, not an action). Models: `IntervalStep`, `RoutineStep`.
- **Action gathering** — the process that materializes intervals/routines into actual `Action` rows for today, today+1, and today+2. Runs on After-day completion. A gathered action has `isGathered = true`, plus `sourceType`, `sourceId`, `forDate`.
- **Gathered action** — an action created by gathering (as opposed to user-created). **Linked gathered** = from an interval scoped to a goal/milestone/project (needs disposition in After-day). **Non-linked gathered** = from a routine or unscoped interval (auto-archived if not done).

## The daily cycle

- **DayState** — one record per user per `dateKey` tracking the day's lifecycle. Model: `DayState`.
- **Pre-day** — the morning ritual: assign start times to untimed actions, resolve overlaps, then "begin." Sets `preDayCompletedAt`, which unlocks Today.
- **Today** — the primary daily view; gated behind Pre-day completion.
- **After-day** — the evening ritual: consciously dispose of every unfinished action, review the day, and (on completion) trigger gathering for upcoming days. Sets `afterDayCompletedAt`.
- **The gate** — the enforced order: **After-day (yesterday) → Pre-day (today) → Today → After-day (today).**

## Action fates (disposition)

An **action fate** is the terminal disposition written to `Action.actionFate` when an unfinished action is dealt with. `null` = still live or done.

- **Postponed** — rescheduled to a new date.
- **OutsourceWoo** — delegated; creates two follow-up actions (do-the-outsourcing + ensure-it's-done).
- **Backlog** — marked not important (for linked actions).
- **BucketList** — marked ignore (for standalone actions).
- **PassedArchived** — passed / auto-archived (for non-linked gathered actions).

## Priority

- **P / S / O / B** — an Eisenhower-style urgency × importance scheme applied to actions and projects. **P** = Primary (urgent + important), **S** = Secondary (important, not urgent), **O** = Outsource (urgent, not important), **B** = Bucket-list (neither).

## Cross-cutting

- **Notes** — free-text working notes attachable to any entity (goal, milestone, project, action, interval, routine), distinct from the formal DoD. Model: `Note` (polymorphic via `entityType` + `entityId`).
- **Journal / Journal Entry** — a log surface, optionally linked to a goal or project, shareable with other users by email. A seed of Root's *Journey/ماجرا*. Models: `Journal`, `JournalEntry`, `JournalAccess`.
- **Discoverability** — a user opt-in (`User.discoverableByEmail`) that allows others to find them by email for journal sharing. Off by default.
- **Onboarding progress / Module intro** — DB-persisted first-run guidance state. Models: `OnboardingProgress`, `ModuleIntroViewed`.

---

## Changelog

- **0.1 · 2026-07-22** — Initial glossary. Terms reconciled against the live schema and the June-10 platform doc.
