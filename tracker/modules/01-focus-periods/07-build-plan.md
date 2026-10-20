# Focus Periods — build plan

*Module `tracker/modules/01-focus-periods/` · Track: Module · Phase 7 · `build-plan` (written by hand; the skill isn't built yet). The order the code lands in and the shape it takes, to the level of tables, operations, refusals, screens and tests, so each stage is a transcription and not a design exercise. Inputs: `02-spec.md` 0.3, `04-wireframes.html` draft 2, `lifecycle/projects/tracker/`. No journeys, design step, UX review or eval plan: waived or not run for this module. Update the changelog; don't fork.*

**Version 0.1 · Status: plan · 2026-10-20 · Owner: _root**

**Where this file yields.** On *what* the module does, the spec wins. On how it looks, the wireframes. On what the code is, the repository.

**Grading.** Everything here is **proposal**. Facts about the code are **as-built**, read at `tracker main @ 003db5a`. Items marked **[F]** were decided by the founder.

---

## 0. What this plan is written against

### 0.1 · What was read

- `02-spec.md` 0.3, `04-wireframes.html` draft 2, `00-intake.md`.
- `tracker/canon/02-architecture/04-conventions.md` 0.6; `lifecycle/projects/tracker/config.md` 0.1.
- Code:
  - `api/prisma/schema.prisma` (Project, Action, Milestone, Tag/TimeTheme m2m) and the last migration, `20260920004517_…`.
  - `api/src/graphql/schema/typeDefs.ts` (Project, Milestone, Mutation).
  - `api/src/graphql/resolvers/{query,mutations,typeResolvers}.ts`.
  - `api/src/services/{actionGathering,todayPreDayAfterDay}.ts`.
  - `api/src/test/helpers.ts`; `api/src/__tests__/timeThemes.integration.test.ts`, which is the closest earlier build.
  - `client/app/{protectedRoutes.tsx,root.tsx}`, `client/app/layout/{navigationItems,pathUtils}.ts*`, `client/app/api/queries.ts`, `client/app/components/{projects/ProjectPreview,goals/GoalPreview}.tsx`, `client/app/components/ui/`.

### 0.2 · What this plan must not break

- **Project and action behaviour everywhere else.** The build adds no column to `Project` or `Action`. It only adds a back-relation on `Project` and one type resolver on `Milestone` (D-2).
- **`toggleAction`, `addAction`, `updateAction`** are reused unchanged. Their rules (ownership, the estimate needed with `tbd`, tag seeding from the project) keep applying.
- **The bottom bar and sidebar** on every existing page.
- **The full suites as of the last run:** 1,079 API tests and 223 client tests (config §3, 2026-09-21). The memory has later counts; the milestone records whatever `main` gives before B1.

### 0.3 · House rules this build is held to

- **Conventions 1–12.** Most relevant here:
  - 1: `requireAuth` + `ensureOwned`.
  - 4: validate at the resolver, dates as `YYYY-MM-DD`.
  - 6: `useApi()` + `queries.ts`.
  - 7: every string in `en` and `fa`. Informal register; کار for action; Western digits (7d); display dates through `useAppDate`, wire dates through `~/utils/dateUtils` (7e).
  - 9: `ConfirmDialog` for destructive actions.
  - 10: named `date-fns` imports.
  - 12: schema change goes with the data-model doc and a decision-log entry in the same change.
- **Phased-build practice** (founder feedback): targeted tests per stage; full suites, live browser checks in `en` and `fa`, and the canon updates (decision log + state of the build) at the milestone; tracker and root-sot committed separately.
- **Typecheck.** Config §3 lists `npm run typecheck`. Earlier sessions found that it fails on route typegen, and that `npx tsc --noEmit` passes. B1 runs both and records which one holds.

### 0.4 · Found while reading *(defects in the documents and code, each assigned)*

| # | Defect | Where | Assigned to |
|---|---|---|---|
| D-1 | The spec's AC-1 says *implicit* many-to-many, but an implicit join has no columns. It can't keep "the order the projects were added" (§4.3), and `Project` has no column to sort by for this. | spec AC-1 vs §4.3 | B1: explicit join model (PD-3); spec revise item |
| D-2 | `Milestone.goal` is `Goal!` in `typeDefs.ts:134`, but `typeResolvers.ts:177` has no `goal` resolver, and `Project.milestone` loads the milestone without its goal. Asking for `project.milestone.goal` today returns null on a non-null field, which is a GraphQL error. The context line needs exactly this. | `typeResolvers.ts:177-196` | B1 |
| D-3 | The spec's "`Postponed` stays live" is an assumption. In the code, `postponeAction` moves the day and *clears* the fate (`mutations.ts:938-947`), and nothing ever writes `Postponed`. | spec §4.3 | Resolved here: exclude any action with a non-null fate (PD-6); spec revise item |
| D-4 | "Reject projects already done" (AC-3), applied to every save, would make the Edit sheet fail once any project in the period finishes. The wireframes keep finished projects in the period (W7). | spec AC-3 vs plate 4 | B1: check only projects being *added* (PD-4) |
| D-5 | A project under a milestone has `goalId = null` (Convention 3, xor). Its goal is only reachable via `milestone.goal`. | `schema.prisma`, Project | B1 query, B2 context line |
| D-6 | The bottom bar is hidden on any path not in `BOTTOM_NAV_PATHS` (`pathUtils.ts:2-9`). Without `/focus` added, the new tab would hide its own bar. | `pathUtils.ts` | B2 |
| D-7 | **A state the spec missed:** a project whose remaining undone actions all have a fate (Backlog, bucket list…) is not Done, yet it has no next actions. The card would show progress, then nothing. | spec §4.3 | B2: "No next actions" line plus "+ Action"; spec revise item (it brings back wireframe call W4) |
| D-8 | Nothing bounds the number of projects in a period. | spec | B1: limit of 30 (§6.4) |
| D-9 | No toast component exists in the client (no `sonner` or `useToast`; nothing in `components/ui/`). | `client/app/components/ui/` | B3: a local one (PD-7) |

## 1. The shape at the end

- **One table:** `FocusPeriod`, joined to `Project` through `FocusPeriodProject` (which keeps `addedAt`).
- **One service** with the rules: `api/src/services/focusPeriods.ts` (overlap, date validation, the done check for new additions, the overview).
- **Two queries and four mutations** in GraphQL.
- **One type resolver added:** `Milestone.goal`.
- **On the client:**
  - One route, `/focus`, in the sidebar and on the bottom bar.
  - One page, `components/focus/FocusPage.tsx`, which works out its state from the overview.
  - Components: `FocusHeader`, `FocusProjectCard`, `FocusPeriodForm` (start and edit, with `ProjectPicker`), `FocusLookback`, and a small `UndoToast`.
  - Pure helpers in `components/focus/focusLogic.ts`: next actions, progress, picker grouping, days left. They're unit-tested, and `ProjectPreview`'s rules are imported, not copied.
- **Strings** under the `focus.*` namespace in both locales.

## 2. Planning decisions *(each the founder's to veto)*

- **PD-1 · Three stages, in order, one at a time.** B1 data and API, B2 the page (read-only cards and the forms), B3 row actions and the look-back. All of the schema lands in B1. No two stages run at once: B3 builds on B2's card, and there's one builder.
- **PD-2 · The client tells the server what "today" is.**
  - `focusOverview(dateKey)` and `recordFocusLookback(id, dateKey)` take the client's local date as `YYYY-MM-DD`, the way `timeThemesForDate(dateKey)` already does (`query.ts:314`). The server never decides today, which closes R6.
  - Dates are stored as `DateTime` at UTC midnight, using the `dateKeyToDate` pattern (`todayPreDayAfterDay.ts:11-13`), and returned as `YYYY-MM-DD` strings from `typeResolvers.ts`.
- **PD-3 · An explicit join model, `FocusPeriodProject`,** with `addedAt` and a composite id, cascading from both sides. This fixes D-1. It differs from AC-1's word "implicit" only in shape: what AC-1 requires (projects linked, rows removed when either side goes) still holds.
- **PD-4 · The server copies the done rule once, narrowly.**
  - `isProjectDone(actions)` (at least one action, all done) sits in `focusPeriods.ts`. A comment points to `getProjectStatus` in `ProjectPreview.tsx:57-64` as the rule it mirrors, and the client function gets a comment pointing back.
  - It's used only to reject projects being **newly added** (D-4).
  - Everything a person *sees* uses the client's own functions (spec decision 5).
- **PD-5 · The Edit sheet saves everything in one call.** `updateFocusPeriod(id, input)` takes the title, dates and the full `projectIds` together, matching plate 4's single Save. The card's "Remove from period" uses the same mutation with one id left out. There are no separate add or remove mutations.
- **PD-6 · Next actions** are the project's actions where `done = false` and `actionFate = null` (D-3). Order: those with a `tbd` first, by `tbd` ascending; then those without, by `createdAt` ascending. Top 3.
- **PD-7 · The Undo toast is local to the Focus page.** It's one small component, not an app-wide toast system. Undo calls `toggleAction` again. The toast shows one item at a time: a second completion replaces it, and the first is final.
- **PD-8 · Overlap is checked twice.**
  - The form checks against `focusPeriodRanges` before submitting, so it can name the conflicting period and its dates (W8).
  - The server rejects too, with a plain message, as a backstop. That keeps us off a new error-code system the codebase doesn't have (it only matches on `"Unauthorized"`, `useApi.ts:72`).
- **PD-9 · Only the most recent ended period gets a look-back,** and only if `lookbackSeenAt` is null. Older unseen ones never appear.
- **PD-10 · No new end-to-end test.** The milestone's live browser pass in `en` and `fa` covers the whole flow, as previous builds did. A Playwright spec is noted as owed (§8).

## 3. Stage order

| Stage | Name | Size | After | Parallel with | Milestone |
|---|---|---|---|---|---|
| B1 | Data and API | M | — | — | — |
| B2 | Focus page: states, cards, forms, nav | L | B1 | — | — |
| B3 | Row actions and look-back | M | B2 | — | MS1 |

**Sizes** *(working hours, and lines of new app code, with tests counted apart)*:

| Size | Hours | Lines of app code |
|---|---|---|
| S | under 2 | under 150 |
| M | 2–4 | 150–500 |
| L | 4–8 | 500–1,000 |

Estimate: B1 ~3 h, B2 ~6 h, B3 ~4 h, plus the milestone ~1.5 h. About 14–15 hours in all.

## 4. P0 — pre-flight

- **P0-1 · Is `Postponed` live?** *Answered:* it's never written (D-3, PD-6).
- **P0-2 · Does `project.milestone.goal` resolve?** *Answered:* no (D-2). Fixed in B1.
- **P0-3 · Is there a toast?** *Answered:* no (D-9, PD-7).
- **P0-4 · Lanes.** *Answered:* no lane setup exists (config §4). This session builds the stages in the main checkout on a branch, `feat/focus-periods`, following the founder's phased-build practice.
- **P0-5 · Does the bottom bar fit six items at 360 px, in both locales?** *Open, checked in B2.* If not, apply wireframe suggestion G1 (icons only).
- **P0-6 · Persian copy.** *Open, owed to the native pass:* the term فشرده and every `focus.*` string ship as draft. Added to `team/open-work.md` at the milestone.

## 5. The stages

### B1 · Data and API

**Goal.** Focus periods can be created, edited, deleted and read through GraphQL with every rule of spec §1 enforced, and `project.milestone.goal` resolves.

**Schema.** Migration `add_focus_periods`:

```prisma
model FocusPeriod {
  id             String               @id @default(uuid())
  title          String
  startDate      DateTime             // UTC midnight of a YYYY-MM-DD, inclusive
  endDate        DateTime             // UTC midnight, inclusive
  lookbackAnswer String?              // "oriented" | "behind"
  lookbackSeenAt DateTime?
  projects       FocusPeriodProject[]
  userId         String
  user           User                 @relation(fields: [userId], references: [id], onDelete: Cascade)
  createdAt      DateTime             @default(now())
  updatedAt      DateTime             @updatedAt
  @@index([userId, startDate])
}
model FocusPeriodProject {
  focusPeriodId String
  projectId     String
  addedAt       DateTime    @default(now())
  focusPeriod   FocusPeriod @relation(fields: [focusPeriodId], references: [id], onDelete: Cascade)
  project       Project     @relation(fields: [projectId], references: [id], onDelete: Cascade)
  @@id([focusPeriodId, projectId])
}
```

Back-relations: `Project.focusPeriods FocusPeriodProject[]` and `User.focusPeriods FocusPeriod[]`.

**Logic** (`api/src/services/focusPeriods.ts`):
- `validateRange(start, end)`: both must be valid date keys, and `end ≥ start`.
- `assertNoOverlap(prisma, userId, start, end, exceptId?)`: rejects when an existing period has `startDate ≤ end AND endDate ≥ start`.
- `isProjectDone(actions)` (PD-4).
- `setProjects(tx, periodId, ids)`: diffs the current and new id lists, keeping `addedAt` for projects that stay. Only the added ids are checked for ownership and for not being done. At most 30 ids.
- `getOverview(prisma, userId, dateKey)`: returns `{ lookback, active, upcoming }`.
  - `active`: the period containing `dateKey`.
  - `upcoming`: the earliest period starting after it.
  - `lookback`: the latest period ending before it, if not yet seen (PD-9).

**API.**
- Types:
  - `FocusPeriod { id, title, startDate, endDate, lookbackAnswer, lookbackSeenAt, projects: [Project!]! }`. Projects are ordered by `addedAt`, and the field resolver includes `actions`, `goal` and `milestone { goal }`.
  - `FocusOverview { lookback, active, upcoming }`, each one nullable.
  - `FocusPeriodRange { id, title, startDate, endDate }`.
- Queries: `focusOverview(dateKey: String!): FocusOverview!`, `focusPeriodRanges: [FocusPeriodRange!]!`.
- Mutations:
  - `createFocusPeriod(input: FocusPeriodInput!)`
  - `updateFocusPeriod(id: ID!, input: FocusPeriodInput!)`
  - `deleteFocusPeriod(id: ID!)`
  - `recordFocusLookback(id: ID!, answer: String, dateKey: String!)`, where `answer` must be `"oriented"`, `"behind"` or null.
- `FocusPeriodInput { title, startDate, endDate, projectIds }`.
- Every resolver uses `requireAuth`; every resolver that takes an id also uses `ensureOwned`.
- Plus the type resolver `Milestone.goal: parent.goal ?? prisma.goal.findUnique(...)` (D-2).

**Screens.** None.

**Tests** (`api/src/__tests__/focusPeriods.integration.test.ts`, in the `timeThemes.integration.test.ts` pattern; plus a unit file for the pure checks):
- create, update and delete;
- end before start is rejected; same-day start and end is allowed;
- overlap: touching on one shared day is rejected, the day after the end is allowed, updating a period against itself is allowed;
- a done project is rejected when added but kept on re-save (D-4);
- another user's project and another user's period both give "Not found";
- deleting a project drops it from its periods (AC-5);
- overview picks lookback, active and upcoming correctly around `dateKey`;
- the look-back is refused before the end and stores both answers and null;
- `project.milestone.goal` resolves (D-2);
- 31 project ids are refused.

`clearDb` in `api/src/test/helpers.ts` gains `focusPeriodProject` then `focusPeriod`, *before* `project` and `user`.

**Image and deploy.** None. No new environment variables.

**Constraints from earlier stages.** Convention 12: update `01-data-model.md` (0.12 → 0.13) and add a decision-log entry (D-61) in the same change. The decision-log entry is written at the milestone, with the B1 schema described in it.

**Acceptance.** AC-1 (as PD-3 shapes it), AC-2, AC-3, AC-4, AC-5, AC-6.

**Size: M.**

**Traps.**
- Run `npx prisma migrate dev --name add_focus_periods` against `dev.db` only. Never `migrate reset` on the dev database without the founder's yes.
- Compare by date key, not by timestamps carrying a time of day. A `new Date()` anywhere in the overlap or overview code is a bug.
- `ensureOwned` gives "Not found" on another user's project. Keep that wording, so ownership can't be probed.
- Forgetting `clearDb` makes tests leak rows across files.

**Not here:** any screen.

### B2 · Focus page: states, cards, forms, nav

**Goal.** `/focus` shows the right state (empty, upcoming, active) with read-only project cards. You can start, edit and delete a period with the project picker. The tab sits in the sidebar and on the bottom bar in both locales.

**Schema.** None.

**Logic** (`client/app/components/focus/focusLogic.ts`, pure and unit-tested):
- `deriveState(overview)`;
- `daysLeft(endKey, todayKey)`, counting today, with "Last day" when it's 0;
- `nextActions(actions)` (PD-6);
- `progress(actions)`, which reuses `getProjectStatus` from `ProjectPreview.tsx` (already exported);
- `contextLine(project)`: goal › milestone, or the milestone's goal › milestone (D-5), or "No goal";
- `groupForPicker(projects, start, end)`: "Scheduled in these dates" (an undone action with `tbd` in range) vs "Other", searched by title, excluding done projects. Projects already in the period stay listed even when done (W7).

**API.** Documents in `queries.ts`: `GET_FOCUS_OVERVIEW`, `GET_FOCUS_PERIOD_RANGES`, `CREATE_FOCUS_PERIOD`, `UPDATE_FOCUS_PERIOD`, `DELETE_FOCUS_PERIOD`. The picker uses the existing `GET_PROJECTS`, extended with `actions { createdAt actionFate }` and `milestone { goal { id title } }`.

**Screens.**
- Plate 1 (cards, read-only: checkboxes and day buttons render but aren't wired until B3). Plate 3 (empty with picker, upcoming, overlap error, loading). Plate 4 (edit, delete through `ConfirmDialog`). Plate 6.
- Cards show "No actions yet" (no bar), "Done", and the D-7 state "No next actions".
- Route `/focus` in `protectedRoutes.tsx`.
- `navigationItems.tsx`: Focus between Calendar and Tools in both lists.
- `pathUtils.ts`: `/focus` added to `BOTTOM_NAV_PATHS` (D-6).
- Strings `nav.focus` and `focus.*` in `en` and `fa`.

**Tests.**
- `client/app/test/focusLogic.test.ts`: every rule above, including overdue-first ordering, fated actions excluded, the milestone-goal context, the picker's date grouping at the range boundaries, and days left on the last day.
- `client/app/test/FocusPage.test.tsx` (with `useApi` mocked): the empty, upcoming and active states; the D-7 card; the overlap message naming the conflict, from `focusPeriodRanges`.

**Image and deploy.** None.

**Constraints from earlier stages.** B1's operations and the `Milestone.goal` resolver.

**Acceptance.** AC-7, AC-8, AC-9, AC-11, AC-12, AC-13, AC-14, AC-15, AC-26, AC-28, AC-29, AC-30, AC-32, AC-33. Plus the client half of AC-2 and AC-3.

**Size: L.**

**Traps.**
- **Week and date display** go through `useAppDate`. Date keys sent to the API go through `~/utils/dateUtils`. Using `format` from `date-fns-jalali` for a wire value stores a date in year 1405 (7e).
- **Persian copy:** informal register, کار for action, Western digits.
- **The 360 px check** (P0-5) uses `resize_window` in both locales. Apply G1 if labels clip.
- **No count of finished projects** anywhere, including the Edit sheet (AC-29).

**Not here:** completing, rescheduling or adding actions; the card menu; the look-back.

### B3 · Row actions and look-back

**Goal.** Next actions can be completed (with Undo), rescheduled and added from the card. Projects can be removed from the card's menu. An ended period shows its look-back once, with carry-over.

**Schema.** None.

**Logic.**
- **Complete** calls `toggleAction`. The card refetches the overview, or patches it locally; the card decides which. `UndoToast` lasts about 5 s and Undo calls `toggleAction` again (PD-7).
- **Reschedule popover:**
  - Uses `date-picker-grid` from `components/ui/`.
  - If the action's `estimatedTimeMinutes` is null, the popover asks for minutes (0–1440).
  - Saves through `updateAction(id, tbd, estimatedTimeMinutes)`. "Clear day" sends `tbd: null`.
- **Inline add:** `addAction(title, projectId, tbd?, estimatedTimeMinutes?)`. The minutes field appears once a day is picked (W5).
- **Card menu:** "Open project" and "Remove from period". Remove goes through `ConfirmDialog`, then `updateFocusPeriod` with that id left out (PD-5).
- **Look-back** (`FocusLookback.tsx`):
  - Finished and Not finished lists, using `getProjectStatus` live (spec decision 7).
  - The oriented/behind buttons start with neither selected.
  - Done calls `recordFocusLookback`.
  - "Start a new period with these" opens `FocusPeriodForm` with the unfinished project ids pre-ticked. The start date is `max(previous end + 1, today)`.

**API.** Existing `toggleAction`, `updateAction` and `addAction`. Plus `RECORD_FOCUS_LOOKBACK` in `queries.ts`.

**Screens.** Plate 2 (all four frames) and plate 5 (both frames). Mirrored in Persian: popovers open on the left side of the row (plate 6).

**Tests.**
- Extend `FocusPage.test.tsx`:
  - completing removes the row, moves the next one up and updates the count, and Undo restores it;
  - rescheduling without an estimate asks for minutes and never sends `tbd` without them;
  - add sends the card's `projectId`;
  - remove sends the id list minus one.
- `FocusLookback.test.tsx`:
  - the lists, with no count sentence;
  - Done works without an answer;
  - carry-over pre-ticks and sets the start date.

**Image and deploy.** None.

**Constraints from earlier stages.** B2's card and form components; B1's `updateFocusPeriod` keeps finished projects (D-4).

**Acceptance.** AC-10, AC-16, AC-17, AC-18, AC-19, AC-21, AC-22, AC-23, AC-24, AC-25, AC-27, AC-31.

**Size: M.**

**Traps.**
- **The checkbox and day button sit inside a row whose title is a link.** Each control stops propagation and none nests in another, so tapping the checkbox never navigates (AC-16).
- **Undo after the toast is gone** doesn't exist. Completing a second action finalizes the first (PD-7).
- **The look-back takes over the tab only while `lookbackSeenAt` is null.** If an active period also exists, it shows after Done.

**Not here:** anything on Today; reminders.

---

## 6. Cross-cutting catalogues

### 6.1 · Routes

| Route | Page | Stage |
|---|---|---|
| `/focus` | `FocusPage` (protected; bottom bar visible) | B2 |

### 6.2 · Refusal messages *(English, as thrown; Convention 4)*

| Message | Operation | When |
|---|---|---|
| `End date must be on or after the start date.` | create, update | end before start |
| `These dates overlap another focus period.` | create, update | any shared day (the form names the conflict itself, PD-8) |
| `Invalid date: <key>.` | create, update, overview, look-back | a date key that isn't a real `YYYY-MM-DD` |
| `A finished project can't be added to a focus period.` | create, update | a newly added project is done |
| `A focus period can hold at most 30 projects.` | create, update | more than 30 ids |
| `The look-back opens after the period ends.` | look-back | `endDate ≥ dateKey` |
| `Answer must be "oriented" or "behind".` | look-back | any other non-null value |
| `Not found` / `Unauthorized` | all | the existing ownership and auth checks |

### 6.3 · Tables

`FocusPeriod`, `FocusPeriodProject` (B1). No column changes to existing tables.

### 6.4 · Limits

| Limit | Value | Where |
|---|---|---|
| Projects per period | 30 | B1 service |
| Title | 1–120 characters, trimmed | B1 service |
| Minutes on reschedule or add | 0–1440 | the existing `validateEstimatedMinutes` |
| Next actions per card | 3 | B2 `focusLogic` |
| Periods per user | unbounded. `focusOverview` returns at most 3, and `focusPeriodRanges` returns 4 fields per row | — |

### 6.5 · Strings

Namespace `focus.*`, plus `nav.focus`, in `client/app/locales/{en,fa}/common.json`. Persian terms: فشرده (the object and the tab), کار (action), پروژه (project). Draft until the native pass (P0-6).

### 6.6 · Runtime dependencies

None added.

### 6.7 · Every acceptance criterion, by stage

| Criterion | Stage | Criterion | Stage | Criterion | Stage |
|---|---|---|---|---|---|
| AC-1 | B1 | AC-12 | B2 | AC-23 | B3 |
| AC-2 | B1 (+B2 form) | AC-13 | B2 | AC-24 | B3 |
| AC-3 | B1 (+B2 picker) | AC-14 | B2 | AC-25 | B3 |
| AC-4 | B1 | AC-15 | B2 | AC-26 | B2 |
| AC-5 | B1 | AC-16 | B3 | AC-27 | B3 (B2 adds most strings) |
| AC-6 | B1 | AC-17 | B3 | AC-28 | B2 |
| AC-7 | B2 | AC-18 | B3 | AC-29 | B2 |
| AC-8 | B2 | AC-19 | B3 | AC-30 | B2 |
| AC-9 | B2 | AC-20 | *retired* | AC-31 | B3 |
| AC-10 | B3 | AC-21 | B3 (B2: from Edit) | AC-32 | B2 |
| AC-11 | B2 | AC-22 | B3 | AC-33 | B2 |

## 7. What this plan changes in code that is already built

- `api/prisma/schema.prisma`: back-relations on `Project` and `User`.
- `api/src/graphql/resolvers/typeResolvers.ts`: `Milestone.goal` added (D-2). It also benefits any existing query that asks for it.
- `api/src/test/helpers.ts`: `clearDb`.
- `client/app/layout/navigationItems.tsx` and `pathUtils.ts`: the new tab (D-6).
- `client/app/protectedRoutes.tsx`: the route.
- `client/app/api/queries.ts`: `GET_PROJECTS` gains `actions { createdAt actionFate }` and `milestone { goal }`. These are additive; the existing consumers ignore them.
- `client/app/components/projects/ProjectPreview.tsx`: a comment on `getProjectStatus` (already exported) pointing at its server mirror (PD-4).

## 8. Verification, and its ceiling

**Done means:**
- B1–B3 are merged into `main`.
- The full API and client suites are green.
- `i18n:check-missing` and `i18n:check-hardcoded` are clean, and the typecheck is clean (whichever command holds, §0.3).
- The live pass is done.
- The canon is updated: the data model goes to 0.13, a new decision-log entry D-61, a state-of-the-build paragraph, a glossary entry for Focus Period / فشرده, and the open-work native-pass item.

**The suites prove:** the rules (overlap, done-on-add, ownership, date boundaries), the derivations (next actions, progress, context, picker groups, days left), and that each control does one thing.

**The live pass, at MS1,** with both dev servers via `preview_start`, in `en` and then `fa`:
1. Register.
2. Make 2 goals, 3 projects (one under a milestone) and a few actions.
3. Start a period from the empty state.
4. See the cards.
5. Complete with Undo, reschedule an action with no estimate, add an action.
6. Remove a project.
7. Edit the dates into an overlap and see the message.
8. Make an ended period, see the look-back, answer it, carry over.
9. Check 360 px.
10. Check the console for errors.

**Past the ceiling (by hand, the founder):**
- **Whether days left feels oriented or behind** over a real period. That's the drop rule (M1). *Needed by:* the first look-back.
- **The Persian wording** (native pass). *Needed by:* none; it ships as draft.
- **A Playwright spec for `/focus`** is owed and not built (PD-10).

## 9. Where this is most likely to go wrong

1. **Off-by-one days.** Inclusive end dates, UTC midnight storage, and the client's local date key all meet in the overlap check, the overview and days left. PD-2 confines them to date-key comparison. The boundary tests in B1 and B2 are the guard.
2. **`milestone.goal` nulls** (D-2). If the resolver is missed, the overview query errors for any period holding a milestone project. B1 has a test for it.
3. **Re-saving with a finished project** (D-4). It's easy to write the done check over all ids. The test asserts that a re-save succeeds.
4. **Controls nested in the link row** on the card (B3 trap). Tapping the checkbox would navigate.
5. **Bottom bar fit in Persian at 360 px** (P0-5).

## 10. For the founder

- **To veto:**
  - PD-3, the explicit join table (needed to keep the order projects were added);
  - PD-4, the done rule copied to the server, for added projects only;
  - PD-7, a local Undo toast instead of an app-wide one;
  - PD-9, look-back only for the latest ended period;
  - PD-10, no Playwright spec this build.
- **The spec will get a revise after the build** (0.4): AC-1's wording (D-1), §4.3's `Postponed` assumption (D-3), the "No next actions" state (D-7), and the 30-project limit (D-8). None changes what you'll see except D-7's one line.
- **Left to the build, decided as it goes:** the icon (Crosshair or Target), exact copy, and whether a completed row refetches or patches locally.
- **Owed by you:** nothing before B1.

## Changelog

- **0.1 · 2026-10-20** — Plan, from `02-spec.md` 0.3 and `04-wireframes.html` draft 2, against `tracker main @ 003db5a`. Nine defects found while reading (D-1 to D-9), each assigned.
