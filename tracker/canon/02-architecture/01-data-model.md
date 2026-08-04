# Tracker — Data Model

*Source of truth. The Prisma schema, as-built. If the schema changes, update this file in the same change. Update the changelog; don't fork.*

**Version 0.6 · Status: as-built · 2026-08-03 · Owner: _root**

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

### Feelings & Needs (Learn Module 1)
The as-built tables for the Feelings & Needs tool (`06-specs/` companion; plan in the ecosystem repo `learn-build/00-module1-demo-plan.md` §8). Per-user state only — the palettes, frame script, catch copy and faux-feelings lexicon live in `api/src/content/feelings-needs/`, authored and versioned like code (the module is LLM-free). Migration `20260802120142_add_feelings_needs`.

- **FrameCompletion** — `id` · `userId: String @unique` → User (Cascade) · `completedAt`. The Day-1 "felt, not told" frame, done once (P1).
- **LoopSitting** — `id` · `userId` → User (Cascade) · `breathTaken: Boolean=false` · `wasPrompted: Boolean=false` (drives prompt-fade inference, P7) · `completedAt: DateTime?` (null = still open, which is what makes a sitting resumable; **not** a completion metric) · `createdAt` · **`@@index([userId, createdAt])`**. One per sitting; groups its passes. Only *completed* sittings are counted anywhere — an abandoned one is not a rep.
- **LoopEntry** — `id` · `sittingId` → LoopSitting (Cascade) · `passIndex: Int` (0-based) · `bodyLocation?` (where in the body; `hard_to_place` is a real answer, not a missing one — P2 failure mode c) · `bodyTexture?` · `feelingWord?` · `feelingSource?` (`palette`|`own`|`catch`) · `need?` · `needSource?` · `smallAction?` · `distinctionCaught: Boolean=false` · `createdAt` · **`@@index([sittingId])`**. One per loop pass; ownership inherited from the sitting. **Passes are never cross-referenced to each other** — parallel, not related (relating them is storytelling, tier 4, deferred).
- **LoopState** — `id` · `userId: String @unique` → User (Cascade) · `contentVersion` (pins the version the user started on) · `graduationSurfaced: Boolean=false` (the one-time capability moment; a door, not a score) · `createdAt` · `updatedAt`. Deliberately thin: `frameDone` and `promptFadeLevel` were both dropped once they had authoritative records elsewhere (a FrameCompletion row; the count of completed sittings). **Prefer deriving from the event over storing a summary of it** — a cached value beside the record is a value that can disagree with it. What remains is the one fact with no other record.

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

- **0.6 · 2026-08-03** — Added `LoopEntry.bodyLocation` (`add_loop_entry_body_location`): the body step split into *where* then *what texture*, because the UI asked the first question and offered answers to the second.
- **0.5 · 2026-08-02** — Dropped `LoopState.promptFadeLevel` (`drop_loopstate_prompt_fade_level`); the fade level is derived from completed sittings. Added `catch` as a third feeling/need source.
- **0.4 · 2026-08-02** — Dropped `LoopState.frameDone` (`drop_loopstate_frame_done`); the Day-1 frame's completion is derived from `FrameCompletion`.
- **0.3 · 2026-08-02** — Added `LoopSitting.completedAt` (migration `add_loop_sitting_completed_at`) for loop resumability.
- **0.2 · 2026-08-02** — Added the **Feelings & Needs** tables (FrameCompletion, LoopSitting, LoopEntry, LoopState; migration `add_feelings_needs`) for Learn Module 1, Phase 1 scaffold. (The Skill-tool tables remain documented in their spec, `06-specs/00-skills-engine.md` §9, not yet transcribed here.)
- **0.1 · 2026-07-22** — Initial, transcribed from the live schema. Reflects migrations through `20260613174330_add_journals`.
