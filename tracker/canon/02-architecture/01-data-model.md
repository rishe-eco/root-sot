# Tracker — Data Model

*Source of truth. The Prisma schema, as-built. If the schema changes, update this file in the same change. Update the changelog; don't fork.*

**Version 0.1 · Status: as-built · 2026-07-22 · Owner: _root**

---

> Verified against `api/prisma/schema.prisma` on 2026-07-22. Datasource: SQLite (`postgresql` block present but commented). IDs are `cuid()` for User/Goal/Milestone and `uuid()` for the rest; `JournalAccess` and the onboarding tables use autoincrement ints.

## Enums

| Enum | Values | Used by |
|---|---|---|
| `Priority` | `P` `S` `O` `B` | Action, Project |
| `RepeatUnit` | `minute` `hour` `day` `week` `month` `year` | Interval |
| `IntervalStatus` | `active` `inactive` | Interval, Routine |
| `ActionFate` | `Postponed` `OutsourceWoo` `Backlog` `BucketList` `PassedArchived` | Action (null = live/done) |
| `ActionSourceType` | `interval` `routine` | Action (null = user-created) |

## Core models

### Action
The atomic unit. User-created (optionally project-linked) or gathered from a template.

`id` · `title` · `tbd: DateTime?` (scheduled day) · `done: Boolean` · `priority: Priority=P` · `estimatedTimeMinutes: Int?` (required when `tbd` set; max 1440) · `startTimeOfDay: String?` ("HH:mm") · `createdAt` · `projectId: String?` → Project (onDelete: SetNull) · `userId` → User (Cascade) · **gathered fields:** `sourceType: ActionSourceType?` · `sourceId: String?` · `forDate: DateTime?` · `isGathered: Boolean=false` · `actionFate: ActionFate?`

### DayState
One row per user per calendar day; drives the daily gate.

`id` · `userId` → User (Cascade) · `dateKey: String` ("YYYY-MM-DD") · `afterDayCompletedAt: DateTime?` · `actionGatheringCompletedAt: DateTime?` · `preDayCompletedAt: DateTime?` · **`@@unique([userId, dateKey])`**

### Goal
Top-level intent; supports goal groups and hierarchy.

`id` · `title` · `dod: String?` · `isGoalGroup: Boolean=false` · `parentGoalId: String?` (self-relation `GoalChildren`, SetNull) · `parentMilestoneId: String?` (relation `MilestoneChildGoals`, SetNull) · `childGoals: Goal[]` · `milestones: Milestone[]` (`GoalMilestones`) · `projects: Project[]` · `intervals: Interval[]` · `createdAt` · `startDate/endDate: DateTime?` · **`dodClarityStatus: String?`** ("green"|"amber"|null) · **`dodFlaggedDimensions: String?`** (JSON array) · `userId` → User (Cascade) · `journals: Journal[]`

### Milestone
Ordered checkpoint under a goal.

`id` · `title` · `doa: String?` (text, *not* a date) · `goalId` → Goal (Cascade, `GoalMilestones`) · `childGoals: Goal[]` (`MilestoneChildGoals` — when parent is a goal group) · `projects: Project[]` · `intervals: Interval[]` · `createdAt` · `predictionDate: DateTime?` (no logic effect) · `order: Int=0` · `isLast: Boolean=false` (≤1 per goal)

### Project
Body of work under a goal **or** milestone (exclusive).

`id` · `title` · `dod: String?` · `type: String="individual"` · `priority: Priority=P` · `createdAt/updatedAt` · `actions: Action[]` · `intervals: Interval[]` · `goalId: String?` → Goal (SetNull) · `milestoneId: String?` → Milestone (SetNull) · `userId` → User (Cascade) · `journals: Journal[]`

> Exclusivity of `goalId` / `milestoneId` is enforced by a DB check added in migration, not by the Prisma schema alone.

## Recurrence models

### Interval
Recurring template, scoped to one of goal/milestone/project or standalone.

`id` · `title` · `status: IntervalStatus=active` · `estimatedTimeMinutes: Int?` (max 1440) · `endTime: DateTime?` · `repeatValue: Int=1` · `repeatUnit: RepeatUnit?` (null when only `customRepeatDates`) · **`customRepeatDates: String?`** (JSON array of ISO datetimes) · **`customRepeatRule: String?`** (JSON: `{unit:"week",daysOfWeek:[1..7]}` / `{unit:"month",daysOfMonth:[1..31]}` / `{unit:"year",months:[1..12],daysOfMonth?:[…]}`) · `predictedToDoTime: String?` ("HH:mm") · `steps: IntervalStep[]` · `goalId/milestoneId/projectId: String?` (≤1 set, all SetNull) · `userId` → User (Cascade) · `createdAt/updatedAt`

### IntervalStep
`id` · `title` · `order: Int=0` · `intervalId` → Interval (Cascade) · `createdAt`

### Routine
Daily-with-timer template; no scope link.

`id` · `title` · `status: IntervalStatus=active` · `estimatedTimeMinutes: Int?` (max 1440) · `endTime: DateTime?` · **`timeOfDayBlocks: String?`** (JSON array of "HH:mm") · `timerDurationMinutes: Int?` · `steps: RoutineStep[]` · `userId` → User (Cascade) · `createdAt/updatedAt`

### RoutineStep
`id` · `title` · `order: Int=0` · `routineId` → Routine (Cascade) · `createdAt`

## Cross-cutting models

### Note
Polymorphic working note.

`id` · `entityType: String` ("action"|"project"|"goal"|"milestone"|"routine"|"interval") · `entityId: String` · `body: String` · `createdAt/updatedAt` · `userId` → User (Cascade) · **`@@index([entityType, entityId])`**

### Journal / JournalEntry / JournalAccess
A seed of *Journey/ماجرا*.

- **Journal** — `id` · `title` · `description: String?` · `isArchived: Boolean=false` · `linkedGoalId: String?` → Goal (SetNull) · `linkedProjectId: String?` → Project (SetNull) · `createdAt/updatedAt` · `entries: JournalEntry[]` · `accessList: JournalAccess[]` · **`defaultForUserId: String? @unique`** → User (relation `UserDefaultJournal`, SetNull)
- **JournalEntry** — `id` · `journalId` → Journal (Cascade) · `body` · `createdAt/updatedAt` · `isArchived: Boolean=false` · `timestampOverridden: Boolean=false`
- **JournalAccess** — `id: Int autoincrement` · `journalId` → Journal (Cascade) · `userEmail: String` (sharing is by email) · `addedAt` · **`@@unique([journalId, userEmail])`**

### OnboardingProgress / ModuleIntroViewed
First-run guidance state.

- **OnboardingProgress** — `id: Int` · `userId: String @unique` → User (Cascade) · `lastSlideViewed: Int=0` · `completedAt: DateTime?`
- **ModuleIntroViewed** — `id: Int` · `userId` → User (Cascade) · `moduleKey: String` · `viewedAt` · **`@@unique([userId, moduleKey])`**

### User
`id` · `email: String @unique` · `password: String` (bcrypt) · `name: String?` · `createdAt` · relations: `actions` `projects` `goals` `intervals` `routines` `dayStates` `notes` `onboardingProgress` `moduleIntrosViewed` · **`discoverableByEmail: Boolean=false`** (opt-in for journal sharing lookup) · `defaultJournal` (`UserDefaultJournal`)

## Relations at a glance

- **User** owns everything (all `onDelete: Cascade` from User).
- **Goal** → milestones, projects, intervals, journals; self-nests via parentGoal/childGoals and via parentMilestone.
- **Milestone** → goal (Cascade); projects, intervals; childGoals when the goal is a group.
- **Project** → optional goal *or* milestone; actions, intervals, journals.
- **Interval** → optional one-of goal/milestone/project; steps.
- **Action** → user; optional project; gathered-source fields point (loosely, by id) at an interval/routine.
- **Journal** → optional linked goal/project; entries, access list; may be a user's default.

## The JSON-string fields (SQLite)

SQLite has no array type. These fields are **JSON strings** in the DB and are parsed back to lists in `typeResolvers.ts`: `Goal.dodFlaggedDimensions`, `Interval.customRepeatDates`, `Interval.customRepeatRule`, `Routine.timeOfDayBlocks`. Any new list field must follow the same stringify-on-write / parse-in-typeResolver pattern (`04-conventions.md`).

---

## Changelog

- **0.1 · 2026-07-22** — Initial, transcribed from the live schema. Reflects migrations through `20260613174330_add_journals`.
