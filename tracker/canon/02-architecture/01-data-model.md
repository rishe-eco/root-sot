# Tracker — Data Model

*Source of truth. The Prisma schema, as-built. If the schema changes, update this file in the same change. Update the changelog; don't fork.*

**Version 0.11 · Status: as-built · 2026-09-15 · Owner: _root**

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

`id` · `title` · `tbd: DateTime?` (scheduled day) · `done: Boolean` · `priority: Priority=P` · `estimatedTimeMinutes: Int?` (required when `tbd` set; max 1440) · `startTimeOfDay: String?` ("HH:mm") · `createdAt` · `projectId: String?` → Project (onDelete: SetNull) · `userId` → User (Cascade) · **gathered fields:** `sourceType: ActionSourceType?` · `sourceId: String?` · `forDate: DateTime?` · `isGathered: Boolean=false` · `actionFate: ActionFate?` · `tags: Tag[]` (m2m — locked when `sourceType != null`, see §Tags & Time Themes)

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

`id` · `title` · `dod: String?` · `type: String="individual"` · `priority: Priority=P` · `createdAt/updatedAt` · `actions: Action[]` · `intervals: Interval[]` · `goalId: String?` → Goal (SetNull) · `milestoneId: String?` → Milestone (SetNull) · `userId` → User (Cascade) · `journals: Journal[]` · `tags: Tag[]` (m2m — seed an action's tags at create)

> Exclusivity of `goalId` / `milestoneId` is enforced by a DB check added in migration, not by the Prisma schema alone.

## Recurrence models

### Interval
Recurring template, scoped to one of goal/milestone/project or standalone.

`id` · `title` · `status: IntervalStatus=active` · `estimatedTimeMinutes: Int?` (max 1440) · `endTime: DateTime?` · `repeatValue: Int=1` · `repeatUnit: RepeatUnit?` (null when only `customRepeatDates`) · **`customRepeatDates: String?`** (JSON array of ISO datetimes) · **`customRepeatRule: String?`** (JSON: `{unit:"week",daysOfWeek:[1..7]}` / `{unit:"month",daysOfMonth:[1..31]}` / `{unit:"year",months:[1..12],daysOfMonth?:[…]}`) · `predictedToDoTime: String?` ("HH:mm") · `steps: IntervalStep[]` · `goalId/milestoneId/projectId: String?` (≤1 set, all SetNull) · `userId` → User (Cascade) · `createdAt/updatedAt` · `tags: Tag[]` (m2m — gathered actions inherit these, locked)

### IntervalStep
`id` · `title` · `order: Int=0` · `intervalId` → Interval (Cascade) · `createdAt`

### Routine
Daily-with-timer template; no scope link.

`id` · `title` · `status: IntervalStatus=active` · `estimatedTimeMinutes: Int?` (max 1440) · `endTime: DateTime?` · **`timeOfDayBlocks: String?`** (JSON array of "HH:mm") · `timerDurationMinutes: Int?` · `steps: RoutineStep[]` · `userId` → User (Cascade) · `createdAt/updatedAt` · `tags: Tag[]` (m2m — gathered actions inherit these, locked)

### RoutineStep
`id` · `title` · `order: Int=0` · `routineId` → Routine (Cascade) · `createdAt`

## Tags & Time Themes

The **first many-to-many relations in the schema.** Everywhere else a list is a JSON string (§JSON-string fields), because those are lists of *values*. A tag is a reference to another table, not a value — so it is a real relation, not a JSON blob (decision **D-54**). Prisma implicit m2m; five join tables it manages.

### Tag
A user-scoped label with a colour, shared across five entities.

`id` (uuid) · `name: String` · `color: String` (palette **key**, not hex — validated against a fixed set in `services/tags.ts`) · `userId` → User (Cascade) · `createdAt` · m2m: `projects` `intervals` `routines` `actions` `timeThemes` · **`@@unique([userId, name])`**

### TimeTheme
A recurring, tag-bearing **span of time with a nature** — neither a project nor a goal. It only *surfaces* matching actions and draws a band; it never blocks anything (soft by design). Its recurrence fields deliberately mirror `Interval`'s so the exported `intervalOccursOnDate` resolves theme occurrences unchanged.

`id` (uuid) · `title` · `status: IntervalStatus=active` · `startTimeOfDay: String` ("HH:mm") · `endTimeOfDay: String` ("HH:mm", validated `> start`) · **recurrence (Interval-shaped):** `repeatValue: Int=1` · `repeatUnit: RepeatUnit?` · **`customRepeatDates: String?`** (JSON) · **`customRepeatRule: String?`** (JSON) · `endTime: DateTime?` · `tags: Tag[]` (m2m) · `userId` → User (Cascade) · `createdAt/updatedAt`

> **Tag inheritance onto actions** (the rule behind the locked/editable split): a **gathered** action snapshot-copies its source interval/routine's tags at gather time and they are **locked** (server rejects `setActionTags` when `sourceType != null` — the nature belongs to the template). A **project-linked** action is *seeded* from the project's tags at create, then **editable** (it is not generated). A **standalone** action starts empty, editable. Snapshots are copies, not live links; retagging a template affects only future gathers. Tags are **not** part of gathered-action dedup identity (`gatheredActionKey`), so re-gathering stays idempotent.

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
- **Action** → user; optional project; gathered-source fields point (loosely, by id) at an interval/routine; tags (m2m).
- **Journal** → optional linked goal/project; entries, access list; may be a user's default.
- **Tag** → user; m2m to Project, Interval, Routine, Action, TimeTheme (the shared vocabulary).
- **TimeTheme** → user; tags (m2m). No scope link, no steps, no estimate — only a time-of-day span + Interval-shaped recurrence.

## The JSON-string fields (SQLite)

SQLite has no array type. These fields are **JSON strings** in the DB and are parsed back to lists in `typeResolvers.ts`: `Goal.dodFlaggedDimensions`, `Interval.customRepeatDates`, `Interval.customRepeatRule`, `Routine.timeOfDayBlocks`, `TimeTheme.customRepeatDates`. Any new list field must follow the same stringify-on-write / parse-in-typeResolver pattern (`04-conventions.md`). (`customRepeatRule` — on both Interval and TimeTheme — is a JSON string consumed by the service layer, not exposed as a parsed list.) Note that **tags are not in this list**: they are a real m2m relation, not a JSON value-list — this is exactly the distinction D-54 draws.

---

## Changelog

- **0.11 · 2026-09-15** — Added **`Tag`** and **`TimeTheme`** and the schema's **first m2m relations** (`tags Tag[]` on Project/Interval/Routine/Action/TimeTheme; migration `add_time_themes`) — Time Themes, D-54. Records the value-list-vs-relation distinction (tags are a relation, so not a JSON string — the one place §JSON-string fields does *not* extend), the locked-vs-editable tag-inheritance rule, and that `TimeTheme`'s recurrence fields mirror `Interval`'s so `intervalOccursOnDate` is reused verbatim.
- **0.10 · 2026-08-23** — `SkillKey` gained `monitoring` — Monitoring Lab Phase 1 (`06-specs/06b-monitoring-lab-build-plan.md`). No other schema change: `responseStructure` holds predictions/ratings/explanations/step-selections/influence-marks, and this tool needs no `rung` column and no new tables. SQLite has no enum type, so only `prisma generate` ran, same as Delegation's 0.9 entry.
- **0.9 · 2026-08-23** — `SkillKey` gained `delegation` — Delegation Lab Phase 1 (`06-specs/05b-delegation-lab-build-plan.md`). No other schema change: `responseStructure` (added for Decomposition) holds the estimate/advice/revision/cue/sequence JSON, and this tool needs no `rung` column — the two-rung progression is specific to Verification Lab's cost bench. SQLite has no enum type, so `npx prisma migrate dev` found no pending migration; only `prisma generate` ran.
- **0.8 · 2026-08-22** — `SkillKey` gained `verification`; `SkillModuleProgress` gained `rung String @default("assisted")` and `SkillAttempt` gained `rung String?` (migration `add_verification_lab`) — Verification Lab Phase 1 (`06-specs/04b-verification-lab-build-plan.md`). Two rungs (assisted = hard cost ceiling, unassisted = none) are two different instruments, not two settings of one, so the rung is a stamped column on the attempt rather than derived from the module's *current* rung — a module's rung changes over time, and deriving it would retroactively relabel history and silently join two different instruments into one trend line. Both columns are unused by every other skill. No other migration was needed: `responseStructure` (added for Decomposition) is reused unchanged for the oracle/verdict response structure.
- **0.7 · 2026-08-15** — `SkillKey` gained `decomposition`; `SkillAttempt` gained `responseStructure String?` (migration `add_decomposition_lab`) — Decomposition Lab Phase 1a (`06-specs/03b-decomposition-lab-build-plan.md`). A separate column from `responseText` because one holds prose and one holds a tree; a single field holding either would make every later query ambiguous about which it got. SQLite has no enum type, so the new `SkillKey` value needed no migration of its own — only the column addition did. The Skill-tool tables are still not transcribed into this file (see the 0.2 note below); this entry documents only the delta.
- **0.6 · 2026-08-03** — Added `LoopEntry.bodyLocation` (`add_loop_entry_body_location`): the body step split into *where* then *what texture*, because the UI asked the first question and offered answers to the second.
- **0.5 · 2026-08-02** — Dropped `LoopState.promptFadeLevel` (`drop_loopstate_prompt_fade_level`); the fade level is derived from completed sittings. Added `catch` as a third feeling/need source.
- **0.4 · 2026-08-02** — Dropped `LoopState.frameDone` (`drop_loopstate_frame_done`); the Day-1 frame's completion is derived from `FrameCompletion`.
- **0.3 · 2026-08-02** — Added `LoopSitting.completedAt` (migration `add_loop_sitting_completed_at`) for loop resumability.
- **0.2 · 2026-08-02** — Added the **Feelings & Needs** tables (FrameCompletion, LoopSitting, LoopEntry, LoopState; migration `add_feelings_needs`) for Learn Module 1, Phase 1 scaffold. (The Skill-tool tables remain documented in their spec, `06-specs/00-skills-engine.md` §9, not yet transcribed here.)
- **0.1 · 2026-07-22** — Initial, transcribed from the live schema. Reflects migrations through `20260613174330_add_journals`.
