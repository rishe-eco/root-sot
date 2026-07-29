# Tracker — Modules

*Source of truth. A module-by-module functional map — what each surface is for and where it lives. Update the changelog; don't fork.*

**Version 0.1 · Status: as-built · 2026-07-22 · Owner: _root**

---

Front-end surfaces live under `client/app/components/<module>/`. Routing is defined in `app/protectedRoutes.tsx` with layouts in `app/layout/`. Status legend: **● built** · **◐ partial/placeholder** · **○ not built**.

## Core hierarchy modules

### ● Goals — `components/goals/`
Create and manage goals and goal groups; nest goals; add and drag-reorder milestones; mark the last milestone; inline-edit title and DoD; run the Clarity Check; view a progress bar and computed status. Pages/components: `GoalsListPage`, `ManageGoal`, `GoalForm`, `GoalPreview`, `DodClarityWizard`.

### ● Milestones — `components/milestones/`
Ordered checkpoints under a goal, with `doa`, `order`, `isLast`, and optional `predictionDate`. Created/edited via `MilestoneForm`. In a goal group, milestones hold child goals instead of projects.

### ● Projects — `components/projects/`
Bodies of work under a goal or milestone (exclusive). CRUD, priority, DoD, actions. Pages/components: `ProjectsListPage`, `ProjectForm`, `ProjectPreview`. (Note: project start/end date editing was a known gap — bug **B-7**; verify current state.)

### ● Actions — `components/actions/`
The schedulable unit. Create/edit/toggle/delete; standalone, project-linked, or gathered. Pages/components: `ActionsListPage`, `ActionForm`, `ActionPreview`.

### ● Intervals & Routines — `components/intervals/`
Recurring templates. Intervals carry the full recurrence engine and a scope link; routines are daily-with-timer and unscoped. `IntervalsListPage`, `IntervalForm`, plus routine forms.

## Daily-cycle modules

### ● Today — `components/today/`
The gated primary view. Linked vs standalone sections, inline quick-add, done toggles, After-day entry point. `TodayPage`.

### ● Pre-day / After-day — `components/today/`
The morning and evening wizards (`PreDayWizard`, `AfterDayWizard`) with overlap detection and the full action-fate disposition set. See `01-daily-cycle.md`.

### ● Calendar — `components/calendar/`
Month and week/day views of scheduled actions, built on `react-big-calendar` with a custom toolbar and event component. `CalendarPage`. (Known gaps in what it renders — gathered actions and interval recurrence — bugs **B-8 / B-13**; verify.)

## Navigation & structure

### ● Activities — `components/activities/`
The structural home linking Goals, Projects, Actions, and Intervals/Routines. `ActivitiesPage`.

### ● Tools — `components/tools/`
A hub surface (`ToolsHomePage`, `ToolsPage`); journals live under Tools (`/tools/journals`).

## Root-aligned modules (grafted toward the brand)

### ● Clarity Check
Covered in its own file, `01-product/02-clarity-check.md`.

### ● Notes — `components/notes/`
Free-text working notes attachable to any entity (goal, milestone, project, action, interval, routine) via the polymorphic `Note` model. Distinct from the formal DoD.

### ● Journals — `components/journals/`
Log surfaces optionally linked to a goal/project, with entries, a per-user default journal, and **email-based sharing** gated by opt-in discoverability. A seed of Root's *Journey/ماجرا*. `JournalsListPage`, `JournalDetailPage`, plus a session-scoped `JournalQuickAdd` on Today.

### ● Onboarding — `components/onboarding/`
First-run guidance, DB-persisted. `OnboardingSlideshow` (full-screen first-login slideshow, resumes per-slide) and `ModuleIntroOverlay` (skippable per-module intro cards keyed by `moduleKey`, wired into the module pages).

### ● Concepts — `components/concepts/`
An in-app reference explaining the platform's core concepts and the hierarchy. `ConceptsPage`.

## Peripheral

### ◐ Settings — `components/settings/`
`SettingsPage` — minimal; includes the discoverability toggle (wired to `updateDiscoverability`). Otherwise largely a placeholder.

### ○ Insights — `components/insights/`  ·  ○ Habits — `components/habits/`
Empty directories — reserved, not built. (Habits is a deliberate non-feature: streak-style habits were removed; see `../../decisions/decision-log.md`.)

### ○ Focus Mode
Placeholder only (`components/UnderConstruction.tsx`, referenced from Today).

## Not present as modules
File attachments, a zero-to-goal setup wizard, interactive tutorials, and the Maintain / Grow / Others pillars are not built. See `04-roadmap/00-state-of-the-build.md`.

---

## Changelog

- **0.1 · 2026-07-22** — Initial. Module list and statuses verified against the `client` component tree on this date.
