# Backend – Database schemas

Prisma schema lives in `api/prisma/schema.prisma`. Database: **SQLite** (default) or **PostgreSQL** via `DATABASE_URL`.

---

## Enums

### Priority

Eisenhower-style priority for actions (and projects).

| Value | Meaning |
|-------|---------|
| `P` | Primary – high urgency, high importance |
| `S` | Secondary – low urgency, high importance |
| `O` | Outsource – high urgency, low importance |
| `B` | Bucket list – low urgency, low importance |

### RepeatUnit

Used by **Interval** for recurrence (with `repeatValue`, e.g. every 2 weeks ⇒ `repeatValue=2`, `repeatUnit=week`).

`minute` | `hour` | `day` | `week` | `month` | `year`

### IntervalStatus

`active` | `inactive` — used for **Interval** and **Routine**.

### ActionFate

How an action was disposed in the **After-day** wizard. `null` = still scheduled or done.

| Value | Meaning |
|-------|---------|
| `Postponed` | Moved to another date |
| `OutsourceWoo` | Outsourced (WOO) |
| `Backlog` | Not important → backlog |
| `BucketList` | Ignore → bucket list |
| `PassedArchived` | Passed/archived (e.g. non-linked gathered) |

### ActionSourceType

Source of **gathered** actions. `null` = user-created (standalone or project-linked).

`interval` | `routine`

---

## Models

### User

| Field | Type | Notes |
|-------|------|-------|
| id | String (cuid) | PK |
| email | String | Unique |
| password | String | Hashed (bcrypt) |
| name | String? | |
| createdAt | DateTime | |

**Relations:** actions, projects, goals, intervals, routines, dayStates.

---

### Action

Single task/item. Can be user-created (with optional `projectId`) or **gathered** from an Interval/Routine.

| Field | Type | Notes |
|-------|------|-------|
| id | String (uuid) | PK |
| title | String | |
| tbd | DateTime? | Due/scheduled date (calendar day) |
| done | Boolean | Default false |
| priority | Priority | Default P |
| estimatedTimeMinutes | Int? | Required when `tbd` set; max 1440 (24h) |
| startTimeOfDay | String? | "HH:mm" – when to start; set in Pre-day |
| createdAt | DateTime | |
| projectId | String? | Optional link to Project |
| userId | String | FK → User |
| sourceType | ActionSourceType? | interval \| routine if gathered |
| sourceId | String? | Interval or Routine id |
| forDate | DateTime? | Calendar day this gathered action is for |
| isGathered | Boolean | Default false |
| actionFate | ActionFate? | Set in After-day wizard |

**Relations:** project, user.

---

### DayState

One row per user per calendar day (`dateKey` = "YYYY-MM-DD"). Tracks completion of After-day, action gathering, and Pre-day.

| Field | Type | Notes |
|-------|------|-------|
| id | String (uuid) | PK |
| userId | String | FK → User |
| dateKey | String | "YYYY-MM-DD" – unique with userId |
| afterDayCompletedAt | DateTime? | After-day wizard completed |
| actionGatheringCompletedAt | DateTime? | Gathering run completed for this date |
| preDayCompletedAt | DateTime? | Pre-day completed; “today” becomes accessible |

**Unique:** `[userId, dateKey]`.

---

### Goal

Top-level goal; can have milestones and projects. Optional hierarchy: goal group with `childGoals` and `parentMilestoneId`.

| Field | Type | Notes |
|-------|------|-------|
| id | String (cuid) | PK |
| title | String | |
| dod | String? | Definition of done |
| isGoalGroup | Boolean | If true, children are goals; milestones contain goals |
| parentGoalId | String? | FK → Goal (parent) |
| parentMilestoneId | String? | FK → Milestone |
| milestones | Milestone[] | |
| projects | Project[] | |
| intervals | Interval[] | |
| startDate, endDate | DateTime? | |
| userId | String | FK → User |

---

### Milestone

Belongs to one Goal. Can have projects and intervals; when goal is a goal group, can have `childGoals`.

| Field | Type | Notes |
|-------|------|-------|
| id | String (cuid) | PK |
| title | String | |
| doa | String? | Definition of achieved |
| goalId | String | FK → Goal |
| childGoals | Goal[] | When parent goal is goal group |
| projects | Project[] | |
| intervals | Interval[] | |
| predictionDate | DateTime? | Optional |
| order | Int | Display order (lower first) |
| isLast | Boolean | At most one per goal |

---

### Project

Work item under a Goal or Milestone (or standalone). **At most one of** `goalId` or `milestoneId` (enforced in DB).

| Field | Type | Notes |
|-------|------|-------|
| id | String (uuid) | PK |
| title | String | |
| dod | String? | |
| type | String | Default "individual" |
| priority | Priority | Default P |
| createdAt, updatedAt | DateTime | |
| goalId | String? | Optional direct link to Goal |
| milestoneId | String? | Optional link via Milestone |
| userId | String | FK → User |

**Relations:** actions, intervals, goal, milestone, user.

---

### IntervalStep

Conceptual step for one repetition of an Interval (template only; not the same as Action).

| Field | Type | Notes |
|-------|------|-------|
| id | String (uuid) | PK |
| title | String | |
| order | Int | |
| intervalId | String | FK → Interval |

---

### Interval

Recurring work (e.g. “Review inbox weekly”). Can be **standalone** or scoped to **one of** goal, milestone, or project.

| Field | Type | Notes |
|-------|------|-------|
| id | String (uuid) | PK |
| title | String | |
| status | IntervalStatus | Default active |
| estimatedTimeMinutes | Int? | Required; max 1440 |
| endTime | DateTime? | Until when repetitions count |
| repeatValue | Int | Default 1 (e.g. 2 = every 2 units) |
| repeatUnit | RepeatUnit? | Null if only customRepeatDates |
| customRepeatDates | String? | JSON array of ISO date-time strings |
| customRepeatRule | String? | JSON: e.g. `{ unit: "week", daysOfWeek: [1..7] }` |
| predictedToDoTime | String? | "HH:mm" default for gathered actions |
| steps | IntervalStep[] | |
| goalId, milestoneId, projectId | String? | At most one set |
| userId | String | FK → User |

---

### RoutineStep

Step template for a Routine (like IntervalStep).

| Field | Type | Notes |
|-------|------|-------|
| id | String (uuid) | PK |
| title | String | |
| order | Int | |
| routineId | String | FK → Routine |

---

### Routine

Daily/time-of-day style; **no** link to goal/milestone/project. Has time blocks and optional timer.

| Field | Type | Notes |
|-------|------|-------|
| id | String (uuid) | PK |
| title | String | |
| status | IntervalStatus | Default active |
| estimatedTimeMinutes | Int? | Max 1440 |
| endTime | DateTime? | |
| timeOfDayBlocks | String? | JSON array of "HH:mm" |
| timerDurationMinutes | Int? | Timer length per occurrence |
| steps | RoutineStep[] | |
| userId | String | FK → User |

---

## Relations overview

- **User** → actions, projects, goals, intervals, routines, dayStates.
- **Action** → user; optional project. Gathered actions: sourceType/sourceId/forDate.
- **Project** → user; optional goal or milestone; actions, intervals.
- **Goal** → user; milestones, projects, intervals; optional parent goal/milestone and childGoals.
- **Milestone** → goal; projects, intervals; optional childGoals.
- **Interval** → user; optional goal/milestone/project; steps.
- **Routine** → user; steps.
- **DayState** → user; unique per (userId, dateKey).
