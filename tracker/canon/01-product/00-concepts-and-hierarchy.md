# Tracker — Concepts & Hierarchy

*Source of truth. The domain model, conceptually. The data-model file has the fields; this file has the meaning. Update the changelog; don't fork.*

**Version 0.1 · Status: as-built (model) / spec (inference behavior, marked) · 2026-07-22 · Owner: _root**

---

## 1. The tree of intent

Tracker models goals as a tree, with execution tracked at the leaves:

```
Goal (or Goal Group)
  └── Milestone (ordered steps toward the goal)
        └── Project (a defined body of work)
              └── Action (a schedulable unit of work)

Goal Group
  └── Milestone
        └── Goal (child goal — recursive nesting)
```

The rule that governs the whole tree: **intent flows down, status and dates flow up.** You author from the top (a goal, its milestones, its projects); the system reports from the bottom (which actions are done, when work is actually happening).

### Goals and Goal Groups

A **Goal** carries a `dod` (definition of done) and, once checked, a clarity status. A **Goal Group** (`isGoalGroup = true`) is the one structural variant: its children are *other goals* instead of projects, and its milestones hold child goals. Use a goal group to cluster related goals under a theme; use a normal goal for a single pursuit.

### Milestones

Milestones are **ordered checkpoints** within a goal, each with a `doa` (definition of achieved), a display `order`, and an optional `predictionDate` (informational — it does not drive logic). At most one milestone per goal is marked `isLast` (the completion checkpoint); new milestones are inserted before it. Milestones are drag-reorderable. Deleting a milestone prompts the user to delete its projects, move them up to the goal, or move them to another milestone.

> Grounding note: `predictionDate` is a *prediction*, not a commitment — it is deliberately excluded from the date-inference cascade (§4). `doa` is free text, never a date.

### Projects

A **Project** is a body of work under a goal **or** a milestone — never both (enforced at the DB level). It carries a `dod`, a `type` (`individual` | `team`, default `individual`), and a `priority`. Projects hold actions and can be linked by intervals.

### Actions

An **Action** is the atomic, schedulable unit — the only thing a person actually does. By origin, an action is one of:

- **Standalone** — user-created, no project link.
- **Project-linked** — `projectId` set.
- **Gathered** — auto-created from an interval or routine (`isGathered = true`, plus `sourceType` / `sourceId` / `forDate`).

An action carries a scheduled day (`tbd`), a `priority`, an `estimatedTimeMinutes`, and (once Pre-day runs) a `startTimeOfDay`.

## 2. Priority — the P/S/O/B quadrant

An Eisenhower urgency × importance scheme, applied to actions and projects:

| Code | Name | Urgency | Importance |
|------|------|---------|------------|
| **P** | Primary | high | high |
| **S** | Secondary | low | high |
| **O** | Outsource | high | low |
| **B** | Bucket list | low | low |

The names line up with disposition: an **O** action is a natural candidate to *outsource*; a **B** action is a natural candidate for the *bucket list*.

## 3. Recurrence — Intervals vs Routines

Recurring work is a **template** that generates actions; it is never a "streak." (Root refuses streaks; an earlier streak-style habits model was removed — see `../../decisions/decision-log.md`.) Two template types:

| | **Interval** | **Routine** |
|---|---|---|
| Scope link (goal/milestone/project) | Yes — one at most | No (user-level only) |
| Recurrence | Rich: every N units; weekdays; month-days; months; ad-hoc date list | Daily, via time-of-day blocks |
| After-day disposition if not done | Linked → mandatory; unscoped → auto-archived | Auto-archived |
| Steps | Ordered `IntervalStep[]` | Ordered `RoutineStep[]` |
| Default start time | `predictedToDoTime` | per time-of-day block |

**Interval recurrence** combines `repeatValue` + `repeatUnit` (e.g. every 2 weeks) with optional `customRepeatRule` (JSON — weekdays, month-days, or months) and/or `customRepeatDates` (JSON — an explicit list of dates). `endTime` stops generation after a date.

## 4. Action gathering

**Gathering** materializes templates into real `Action` rows for a rolling window: **today, today+1, today+2**. It runs automatically when After-day is completed. For each un-gathered date in the window it walks every active interval and routine, creates a gathered action per occurrence, deduplicates against what's already gathered, and marks `DayState.actionGatheringCompletedAt` for that date. Gathered actions are **hidden until their `forDate`** — you don't see future recurring work early.

Full behavioral detail lives in `01-daily-cycle.md`; the service is `api/src/services/actionGathering.ts`.

## 5. Date & status inference (cascade)

> **Grounding: spec.** This describes the *intended* cascade as designed. It is partially implemented — goal/project status computation exists, but the full recursive cascade (esp. for goal groups) is known-incomplete; see bug **B-15** in `04-roadmap/01-known-issues-and-debt.md`. Verify against `GoalPreview.tsx` / `ProjectPreview.tsx` and the resolvers before relying on any specific rule.

**Dates cascade from children:**

- **Start date** = the earliest active child's start (or earliest done date if work has begun). For a goal, children are its projects, intervals, and standalone actions; for a project, its actions; for an interval, its own start.
- **End date** = the furthest active child's end / to-do date.
- **Excluded from the cascade:** milestones (predictions, not commitments) and *ignored* actions (to-do dates before today — historical, can't move forward-looking dates).

**Status bubbles up:**

- **In progress** if any child is in progress or has in-progress actions.
- **TBD** if all children are TBD.
- **Has ignored actions** if some children contain ignored actions — still counts as in progress (mixed state).
- **Done** only if all children are done.

The intent is that this is **reactive**: a child changing state or date recalculates its parent, up the tree, with no manual step, and the inferred dates/status are shown on projects and goals so the user sees the cascading picture without doing the math.

---

## Changelog

- **0.1 · 2026-07-22** — Initial. Hierarchy, priority, recurrence, and gathering are as-built; the inference cascade is carried forward from the design note and flagged as partially implemented.
