# Backend – GraphQL API

Single endpoint: **POST /graphql**. All operations except `register` and `login` require `Authorization: Bearer <token>`.

Schema and resolvers: `api/src/graphql/` (typeDefs, resolvers).

---

## Enums (GraphQL)

Same as Prisma; see [schemas.md](./schemas.md).

- **Priority:** `P` \| `S` \| `O` \| `B`
- **RepeatUnit:** `minute` \| `hour` \| `day` \| `week` \| `month` \| `year`
- **IntervalStatus:** `active` \| `inactive`
- **ActionFate:** `Postponed` \| `OutsourceWoo` \| `Backlog` \| `BucketList` \| `PassedArchived`
- **ActionSourceType:** `interval` \| `routine`

---

## Main types (output)

| Type | Description |
|------|-------------|
| **Action** | id, title, tbd (ISO), done, priority, estimatedTimeMinutes, startTimeOfDay, createdAt, project, sourceType, sourceId, forDate (YYYY-MM-DD), isGathered, actionFate |
| **DayState** | id, dateKey, afterDayCompletedAt, actionGatheringCompletedAt, preDayCompletedAt (all dates as ISO strings or null) |
| **ActionWithOverlap** | action, overlapIds (other action IDs overlapping in time) |
| **PreDayStatus** | afterDayRequired, canAccessToday, actionsWithoutTime, todayActionsWithOverlap |
| **NotDoneActionsForDate** | nonLinkedGathered, linkedGathered, standalone (arrays of Action) |
| **Project** | id, title, dod, type, priority, actions, intervals, startDate, endDate (derived from actions), goal, milestone |
| **Goal** | id, title, dod, startDate, endDate, createdAt, milestones, projects, intervals |
| **Milestone** | id, title, doa, goalId, goal, projects, intervals, predictionDate |
| **Interval** | id, title, status, estimatedTimeMinutes, endTime, repeatValue, repeatUnit, customRepeatDates (array), customRepeatRule, steps, goal, milestone, project, createdAt, updatedAt |
| **IntervalStep** | id, title, order, createdAt |
| **Routine** | id, title, status, estimatedTimeMinutes, endTime, timeOfDayBlocks (array), timerDurationMinutes, steps, createdAt, updatedAt |
| **RoutineStep** | id, title, order, createdAt |
| **User** | id, email, name, createdAt, actions, projects, goals, intervals, routines |
| **AuthPayload** | token, user |
| **RunActionGatheringResult** | dateKeysProcessed, actionsCreated |

---

## Input types

| Input | Fields |
|-------|--------|
| **ActionInput** | title!, tbd, priority, estimatedTimeMinutes |
| **IntervalStepInput** | title!, order |
| **RoutineStepInput** | title!, order |

---

## Queries

All require auth. Dates are **YYYY-MM-DD** unless noted.

| Query | Arguments | Returns | Notes |
|-------|-----------|--------|-------|
| **actions** | — | [Action!]! | Current user, desc createdAt |
| **action** | id: ID! | Action | By id, user-scoped |
| **projects** | — | [Project!]! | With actions, goal, milestone |
| **project** | id: ID! | Project | By id |
| **goals** | — | [Goal!]! | With milestones, projects |
| **goal** | id: ID! | Goal | By id |
| **intervals** | — | [Interval!]! | With steps, goal, milestone, project |
| **interval** | id: ID! | Interval | By id |
| **routines** | — | [Routine!]! | With steps |
| **routine** | id: ID! | Routine | By id |
| **linkedActions** | date: String! | [Action!]! | Actions with tbd=date and projectId set |
| **standaloneActions** | date: String! | [Action!]! | Actions with tbd=date, no project |
| **dayState** | date: String! | DayState | For (userId, dateKey) |
| **todayActions** | date: String! | [Action!]! | All actions for day (linked + standalone + gathered for that date) |
| **preDayStatus** | date: String! | PreDayStatus! | After-day required?, canAccessToday?, actions without time, overlap info |
| **notDoneActionsForDate** | date: String! | NotDoneActionsForDate! | Grouped for After-day wizard |
| **me** | — | User | Current user |

---

## Mutations

### Actions

| Mutation | Arguments | Returns | Notes |
|----------|-----------|--------|-------|
| **addAction** | title!, tbd, projectId, priority, estimatedTimeMinutes, startTimeOfDay | Action! | estimatedTimeMinutes required if tbd set |
| **updateAction** | id!, title, tbd, done, priority, estimatedTimeMinutes, startTimeOfDay, actionFate | Action! | |
| **deleteAction** | id! | Action! | |
| **toggleAction** | id! | Action! | Flips done |

### Projects

| Mutation | Arguments | Returns | Notes |
|----------|-----------|--------|-------|
| **addProject** | title!, dod, type, goalId, milestoneId, priority, actions: [ActionInput!] | Project! | goalId and milestoneId mutually exclusive |
| **updateProject** | id!, title, dod, type, goalId, milestoneId, priority | Project! | |
| **deleteProject** | id! | Project! | |

### Goals

| Mutation | Arguments | Returns |
|----------|-----------|--------|
| **addGoal** | title!, dod | Goal! |
| **updateGoal** | id!, title, dod, startDate, endDate | Goal! |
| **deleteGoal** | id! | Goal! |

### Milestones

| Mutation | Arguments | Returns |
|----------|-----------|--------|
| **addMilestone** | goalId!, title!, doa, predictionDate | Milestone! |
| **updateMilestone** | id!, title, doa, predictionDate | Milestone! |
| **deleteMilestone** | id! | Milestone! |

### Intervals

| Mutation | Arguments | Returns | Notes |
|----------|-----------|--------|-------|
| **addInterval** | title!, estimatedTimeMinutes!, status, endTime, repeatValue, repeatUnit, customRepeatDates, customRepeatRule, steps, goalId, milestoneId, projectId | Interval! | At most one of goalId, milestoneId, projectId |
| **updateInterval** | id!, title, estimatedTimeMinutes, status, endTime, repeatValue, repeatUnit, customRepeatDates, customRepeatRule, steps, goalId, milestoneId, projectId | Interval! | |
| **deleteInterval** | id! | Interval! | |

### Routines

| Mutation | Arguments | Returns |
|----------|-----------|--------|
| **addRoutine** | title!, estimatedTimeMinutes!, status, endTime, timeOfDayBlocks, timerDurationMinutes, steps | Routine! |
| **updateRoutine** | id!, title, estimatedTimeMinutes, status, endTime, timeOfDayBlocks, timerDurationMinutes, steps | Routine! |
| **deleteRoutine** | id! | Routine! |

### Action gathering & day flow

| Mutation | Arguments | Returns | Notes |
|----------|-----------|--------|-------|
| **runActionGathering** | todayDate: String! | RunActionGatheringResult! | todayDate = YYYY-MM-DD; processes today, today+1, today+2; skips already gathered |
| **setActionStartTime** | id!, startTimeOfDay! | Action! | Pre-day: startTimeOfDay = "HH:mm" |
| **postponeAction** | id!, newDate! | Action! | After-day: move to newDate (YYYY-MM-DD) |
| **outsourceAction** | id!, doOutsourcingTitle!, doOutsourcingDate!, ensureDoneTitle!, ensureDoneDate! | Action! | Creates two actions, marks original OutsourceWoo |
| **setActionNotImportant** | id! | Action! | actionFate = Backlog |
| **setActionIgnore** | id! | Action! | actionFate = BucketList |
| **setActionPassedArchived** | id! | Action! | actionFate = PassedArchived |
| **completeAfterDay** | date! | DayState! | Sets afterDayCompletedAt for date |
| **completePreDay** | date! | DayState! | Sets preDayCompletedAt; today becomes accessible |

### Auth

| Mutation | Arguments | Returns |
|----------|-----------|--------|
| **register** | email!, password! | AuthPayload! |
| **login** | email!, password! | AuthPayload! |

---

## Validation rules (backend)

- **estimatedTimeMinutes:** 0–1440 (24h); required when action has `tbd` or for Interval/Routine create.
- **startTimeOfDay / timeOfDayBlocks:** "HH:mm" (e.g. "09:00").
- **date / dateKey / todayDate / newDate:** YYYY-MM-DD.
- **Project:** cannot set both goalId and milestoneId.
- **Interval:** at most one of goalId, milestoneId, projectId.

Errors: `Unauthorized` (no/invalid token), `Not found` (wrong user or missing resource), plus domain errors (e.g. "estimatedTimeMinutes must be between 0 and 1440").
