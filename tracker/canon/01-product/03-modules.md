# Tracker — Modules

*Source of truth. A module-by-module functional map — what each surface is for and where it lives. Update the changelog; don't fork.*

**Version 0.2 · Status: as-built (partial — see the note below) · 2026-09-21 · Owner: _root**

> **Known stale.** The list below was verified against the component tree on 2026-07-22 and has had exactly one module added since (Noticing). The **Skills Engine** (six labs plus the `/tools/skills` hub), **Feelings & Needs**, **Tags** and **Time Themes** all exist and have no entry here. Until this file is re-walked, `../04-roadmap/00-state-of-the-build.md` is the reliable inventory.

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

### ● Noticing (Impact Act 1) — `components/impact/`
The first **Impact**-pillar surface. `NoticingPage` (the tool’s home), `NoticingFramePage` (the once-only Day-1 frame), `NoticingLoopPage` (the repeatable loop) and `NoticingLogPage` (“what you’ve noticed”), routed under `/tools/impact/noticing`. The log deliberately has **no search and no person filter**, and the schema has no `Person` — a log you can search by a name is a file on that person, however innocent each entry was. Spec in the ecosystem repo, `working/impact-build/`.

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
File attachments, a zero-to-goal setup wizard and interactive tutorials are not built, and the **Maintain** pillar has no surface here. **Learn** and **Impact** both do now — the Skills Engine and Noticing respectively — which is what the staleness note at the top of this file is about. (The fifth pillar was renamed *Others* → **Impact** on 2026-09-20.) See `04-roadmap/00-state-of-the-build.md`.

---

## Changelog

- **0.2 · 2026-09-21** — **Noticing** added (Impact Act 1, `components/impact/`), and the “not present” line corrected: it claimed the Grow/Learn and Others pillars were unbuilt, and both claims had stopped being true. Rather than quietly fix the one line and leave the rest, the file is now **marked stale at the top** — four built module families still have no entry here, and a reader deserves to know that before trusting the list.
- **0.1 · 2026-07-22** — Initial. Module list and statuses verified against the `client` component tree on this date.
