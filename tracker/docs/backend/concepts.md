# Backend – Concepts

Domain concepts and flows used by the API and services.

---

## Date handling

- **dateKey:** Calendar day as string **"YYYY-MM-DD"** (e.g. `"2026-02-20"`). Used in DayState, queries, and mutations. Parsed as UTC midnight for DB range queries where needed.
- **Time of day:** Stored as **"HH:mm"** (e.g. `"09:00"`) in `startTimeOfDay`, `timeOfDayBlocks`, `predictedToDoTime`.

---

## DayState

One record per user per calendar day (`userId` + `dateKey`). Tracks completion of three steps:

| Field | Meaning |
|-------|---------|
| **afterDayCompletedAt** | User completed the After-day wizard for that day. |
| **actionGatheringCompletedAt** | Action gathering has been run for that date (used internally). |
| **preDayCompletedAt** | User completed the Pre-day for that day; “today” view becomes accessible. |

Used to enforce flow: **yesterday After-day** → **today Pre-day** → access to today.

---

## Today actions

**“Actions for a day”** = actions the user sees for that calendar day. Two sources:

1. **Scheduled (tbd):** User-created actions with `tbd` in that day. Can have `projectId` (linked) or not (standalone).
2. **Gathered:** Actions generated from Intervals/Routines with `isGathered = true` and `forDate` = that day. Hidden until that day (by design: you don’t see future gathered actions early).

Both exclude actions with `actionFate` set (disposed in After-day). Query: **todayActions(date)**.

---

## Pre-day flow

Pre-day is the morning step: assign **start time** to actions and optionally resolve overlaps before “today” is considered started.

- **preDayStatus(date)** returns:
  - **afterDayRequired:** Yesterday has no `afterDayCompletedAt` → user must do After-day first.
  - **canAccessToday:** Yesterday’s After-day is done and today’s Pre-day is done (`preDayCompletedAt` set) → user can use “today”.
  - **actionsWithoutTime:** Today’s actions that still need a `startTimeOfDay`.
  - **todayActionsWithOverlap:** Today’s actions plus `overlapIds` (other action IDs whose time windows overlap), so the UI can warn or adjust.

Overlap is computed from `startTimeOfDay` and `estimatedTimeMinutes`: two actions overlap if their intervals `[start, start + estimated)` intersect.

- **setActionStartTime(id, startTimeOfDay)** sets "HH:mm" for one action.
- **completePreDay(date)** sets `preDayCompletedAt` for that date so “today” becomes accessible.

---

## After-day flow

After-day is the end-of-day step: process **not-done** actions (postpone, outsource, backlog, bucket list, or passed/archived).

- **notDoneActionsForDate(date)** returns three groups:
  - **nonLinkedGathered:** Gathered actions not tied to a goal/milestone/project (e.g. from routines, or intervals with no scope). User can mark as passed/archived (e.g. bulk).
  - **linkedGathered:** Gathered actions from intervals that are linked to a goal/milestone/project. Can be postponed, not important (backlog), etc.
  - **standalone:** User-created actions for that day with no project. Can be postponed, ignore (bucket list), etc.

Mutations set **actionFate** and optionally move or create actions:

| Mutation | Effect |
|----------|--------|
| **postponeAction(id, newDate)** | Move to new date; set actionFate = Postponed. |
| **outsourceAction(...)** | Create two new actions (do outsourcing, ensure done); set original actionFate = OutsourceWoo. |
| **setActionNotImportant(id)** | actionFate = Backlog (linked). |
| **setActionIgnore(id)** | actionFate = BucketList (standalone). |
| **setActionPassedArchived(id)** | actionFate = PassedArchived (e.g. non-linked gathered). |
| **completeAfterDay(date)** | Set `afterDayCompletedAt` for that date. |

---

## Action gathering

**Action gathering** creates **gathered** actions from Intervals and Routines for upcoming days. One Interval/Routine can generate one action per “occurrence” on a given day.

- **runActionGathering(todayDate)** runs for **today**, **today+1**, **today+2** (dateKeys). Dates that already have gathering completed for that range are skipped. Returns how many date keys were processed and how many actions were created.
- Logic lives in **actionGathering** service:
  - **Intervals:** Occurrence on a date is determined by `repeatValue`/`repeatUnit`, `customRepeatDates` (JSON array), and `customRepeatRule` (e.g. week days, month days). Respects `endTime`. Uses `predictedToDoTime` as default `startTimeOfDay` for the created action.
  - **Routines:** Similar idea with `timeOfDayBlocks` (JSON array of "HH:mm").
- Created actions have `isGathered = true`, `sourceType` = interval \| routine, `sourceId` = interval or routine id, and `forDate` = the calendar day. They appear in **todayActions** only for that day and in **notDoneActionsForDate** if not done and not yet disposed.

---

## Scoping rules

- **Project:** At most one of `goalId` or `milestoneId` (enforced in DB and API).
- **Interval:** At most one of `goalId`, `milestoneId`, or `projectId`. Can be standalone (all null).
- **Routine:** No link to goal/milestone/project; user-level only.
- **Gathered “linked” vs “non-linked”:** In After-day, “linked gathered” = gathered from an Interval that has goal/milestone/project set; “non-linked” = from Routine or from an Interval with no scope.

---

## Auth and ownership

- **JWT:** Issued on register/login; contains `userId`. Valid for 7 days (configurable).
- **requireAuth:** All queries/mutations except `register` and `login` require a valid Bearer token; otherwise `Unauthorized`.
- **ensureOwned:** Every mutation that touches a resource checks that the resource’s `userId` matches the current user; otherwise returns `Not found` (no existence leak).
