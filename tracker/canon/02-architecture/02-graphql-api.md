# Tracker — GraphQL API

*Source of truth. The API contract: queries, mutations, types, validation. Update the changelog; don't fork.*

**Version 0.2 · Status: as-built (core) / verify (journal & onboarding ops, marked) · 2026-10-21 · Owner: _root**

---

Single endpoint: **`POST /graphql`**. Every operation except `register` / `login` requires `Authorization: Bearer <token>`. Schema in `src/graphql/schema/typeDefs.ts`; resolvers in `src/graphql/resolvers/`.

> The core CRUD + daily-flow surface below is transcribed from the API doc and matches the schema. The **journal, notes, onboarding, and discoverability** operations were added later (see memories and the decision log) and are listed at the end — treat those signatures as **verify-in-code** until reconciled against `typeDefs.ts`.

## Enums (GraphQL — mirror Prisma)

`Priority` P|S|O|B · `RepeatUnit` minute|hour|day|week|month|year · `IntervalStatus` active|inactive · `ActionFate` Postponed|OutsourceWoo|Backlog|BucketList|PassedArchived · `ActionSourceType` interval|routine

## Key output types

- **Action** — id, title, tbd (ISO), done, priority, estimatedTimeMinutes, startTimeOfDay, createdAt, project, sourceType, sourceId, forDate, isGathered, actionFate
- **DayState** — id, dateKey, afterDayCompletedAt, actionGatheringCompletedAt, preDayCompletedAt
- **ActionWithOverlap** — action, overlapIds
- **PreDayStatus** — afterDayRequired, canAccessToday, actionsWithoutTime, todayActionsWithOverlap
- **NotDoneActionsForDate** — nonLinkedGathered, linkedGathered, standalone (arrays of Action)
- **Project** — id, title, dod, type, priority, actions, intervals, startDate, endDate (derived), goal, milestone
- **Goal** — id, title, dod, startDate, endDate, createdAt, milestones, projects, intervals (+ clarity fields, verify exposure)
- **Milestone** — id, title, doa, goalId, goal, projects, intervals, predictionDate
- **Interval** — id, title, status, estimatedTimeMinutes, endTime, repeatValue, repeatUnit, customRepeatDates (array), customRepeatRule, steps, goal, milestone, project, createdAt, updatedAt
- **Routine** — id, title, status, estimatedTimeMinutes, endTime, timeOfDayBlocks (array), timerDurationMinutes, steps, createdAt, updatedAt
- **User** — id, email, name, createdAt, actions, projects, goals, intervals, routines
- **AuthPayload** — token, user · **RunActionGatheringResult** — dateKeysProcessed, actionsCreated

## Queries (all require auth; dates are "YYYY-MM-DD")

| Query | Args | Returns |
|---|---|---|
| `actions` / `action` | — / `id` | `[Action!]!` / `Action` |
| `projects` / `project` | — / `id` | `[Project!]!` / `Project` |
| `goals` / `goal` | — / `id` | `[Goal!]!` / `Goal` |
| `intervals` / `interval` | — / `id` | `[Interval!]!` / `Interval` |
| `routines` / `routine` | — / `id` | `[Routine!]!` / `Routine` |
| `linkedActions` | `date` | `[Action!]!` — tbd=date, projectId set |
| `standaloneActions` | `date` | `[Action!]!` — tbd=date, no project |
| `todayActions` | `date` | `[Action!]!` — linked + standalone + gathered for that day |
| `dayState` | `date` | `DayState` |
| `preDayStatus` | `date` | `PreDayStatus!` |
| `notDoneActionsForDate` | `date` | `NotDoneActionsForDate!` |
| `me` | — | `User` |
| `focusOverview` | `dateKey` (the client's today) | `FocusOverview!` — `lookback` (latest ended, only if unseen), `active` (contains `dateKey`), `upcoming` (earliest after it); each nullable, projects in added order with actions, goal and milestone→goal |
| `focusPeriodRanges` | — | `[FocusPeriodRange!]!` — id, title, dates; for the form's overlap message |

> Note: the default `goals` query returns only root-level goals (`parentGoalId` and `parentMilestoneId` null). Dropdowns needing all goals pass an `includeAll`-style flag — see bug **B-6**.

## Mutations

**Actions:** `addAction`(title!, tbd, projectId, priority, estimatedTimeMinutes, startTimeOfDay) · `updateAction`(id!, …, done, actionFate) · `deleteAction`(id!) · `toggleAction`(id!)

**Projects:** `addProject`(title!, dod, type, goalId, milestoneId, priority, actions:[ActionInput!]) · `updateProject`(id!, title, dod, type, goalId, milestoneId, priority) · `deleteProject`(id!)

**Goals:** `addGoal`(title!, dod) · `updateGoal`(id!, title, dod, startDate, endDate) · `deleteGoal`(id!)

**Milestones:** `addMilestone`(goalId!, title!, doa, predictionDate) · `updateMilestone`(id!, title, doa, predictionDate) · `deleteMilestone`(id!)

**Focus Periods:** `createFocusPeriod`(input!: FocusPeriodInput) · `updateFocusPeriod`(id!, input!) — full replace of title, dates and `projectIds`; only newly added projects are checked (owned, not done) · `deleteFocusPeriod`(id!): Boolean · `recordFocusLookback`(id!, answer: "oriented"|"behind"|null, dateKey!) — only after the period has ended. Rejects end before start, any shared day with another period, and more than 30 projects. `FocusPeriodInput` = `{ title!, startDate!, endDate!, projectIds! }`.

**Intervals:** `addInterval`(title!, estimatedTimeMinutes!, status, endTime, repeatValue, repeatUnit, customRepeatDates, customRepeatRule, steps, goalId, milestoneId, projectId) · `updateInterval`(id!, …) · `deleteInterval`(id!)

**Routines:** `addRoutine`(title!, estimatedTimeMinutes!, status, endTime, timeOfDayBlocks, timerDurationMinutes, steps) · `updateRoutine`(id!, …) · `deleteRoutine`(id!)

**Day flow & gathering:** `runActionGathering`(todayDate!) → processes today/+1/+2, skips already-gathered · `setActionStartTime`(id!, startTimeOfDay!) · `postponeAction`(id!, newDate!) · `outsourceAction`(id!, doOutsourcingTitle!, doOutsourcingDate!, ensureDoneTitle!, ensureDoneDate!) → creates two actions · `setActionNotImportant`(id!) → Backlog · `setActionIgnore`(id!) → BucketList · `setActionPassedArchived`(id!) → PassedArchived · `completeAfterDay`(date!) · `completePreDay`(date!)

**Auth:** `register`(email!, password!) → AuthPayload · `login`(email!, password!) → AuthPayload

**Clarity / Notes / Journals / Onboarding — verify in `typeDefs.ts`:**
Later additions (present in the schema, exposed via these approximate operations):
- Clarity — `updateGoal` extended with clarity fields, or a dedicated mutation writing `dodClarityStatus` + `dodFlaggedDimensions`.
- Notes — CRUD over `Note` keyed by `entityType` + `entityId`.
- Journals — `journals` / `journal` / `journalEntries` queries; `createJournal`, `updateJournal`, `archiveJournal`, `deleteJournal`, `addJournalAccess`, `removeJournalAccess`, `setDefaultJournal`, `createEntry`, `updateEntry`, `archiveEntry`, `addQuickEntry`, `updateDiscoverability`.
- Onboarding — `onboardingProgress` / `moduleIntroViewed` queries; `markSlideViewed`, `markModuleIntroViewed`.

## Validation rules (backend)

- `estimatedTimeMinutes`: 0–1440; required when an action has `tbd`, and on Interval/Routine create.
- `startTimeOfDay` / `timeOfDayBlocks`: "HH:mm".
- dates / dateKeys: "YYYY-MM-DD".
- Project: cannot set both `goalId` and `milestoneId`.
- Interval: at most one of `goalId` / `milestoneId` / `projectId`.

**Errors:** `Unauthorized` (missing/invalid token) · `Not found` (wrong user or missing — no existence leak) · domain errors (e.g. "estimatedTimeMinutes must be between 0 and 1440").

---

## Changelog

- **0.2 · 2026-10-21** — Focus Periods: `focusOverview`, `focusPeriodRanges`, and four mutations (D-61). `Milestone.goal` now resolves (it had no type resolver behind a non-null field).
- **0.1 · 2026-07-22** — Initial. Core surface from the API doc, cross-checked to the schema; later journal/notes/onboarding ops listed from memory and flagged verify-in-code.
