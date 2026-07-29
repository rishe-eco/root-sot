# Tracker — Track Progress MVP: Remaining Work

> This document covers everything left to reach a complete, testable MVP of the Track Progress pillar. It is structured as a list of projects you can create and track inside the app itself.

---

## Feature Projects

---

### F-1 · Goal / Milestone DoD & DoA Clarity Check

**What:** Both Goals and Milestones have free-text definition fields (`dod` and `doa`) that currently accept any input without guidance. The clarity check is a structured validation step that prompts the user to ensure the definition is concrete, measurable, and unambiguous — consistent with Root's belief in "intelligence questions over straight-forward answers."

**Scope:**

Backend
- Add a `dodClarity` field to the `Goal` model (JSON or structured enum: `unchecked | in_review | approved`) — or handle state purely at UI level if clarity is session-based
- Optionally: add a `dodNotes` text field for the outcome of the check

Frontend
- On the Goal form and the inline-edit on the Manage Goal page, trigger a clarity check flow when a DoD is saved for the first time or explicitly re-checked
- The check presents the user with a set of guiding questions (e.g. "Is it observable?", "Is it binary — can you clearly say yes/no when it's done?", "Does it depend on something outside your control?")
- User answers each question; flagged issues are shown as warnings, not blockers
- Show a visual indicator on the goal card (e.g. a badge: "DoD not checked" / "DoD reviewed") so the goal's readiness is visible at a glance
- Same flow for Milestone DoA on the Milestone form

**Notes:** The questions themselves are the product design problem here. They should come from the Root philosophy and be finalized before implementation begins. The technical work is straightforward once those are defined.

---

### F-2 · Notes on All Modules

**What:** A simple free-text notes field (or a small list of timestamped notes) attached to Goals, Milestones, Projects, Actions, Intervals, and Routines. This is for working notes — thinking in progress, context, reminders to self — as opposed to the DoD which is a formal definition.

**Scope:**

Backend (trackerApi)
- Add a `notes` text field to the `Goal`, `Milestone`, `Project`, `Action`, `Interval`, and `Routine` models in `schema.prisma`
- Add corresponding `notes` argument to all `update*` mutations (no need to set on create for most; Action create may want it)
- Add `notes` to the relevant GraphQL type fields and query return shapes

Frontend (trackerProject)
- On each entity's edit/manage page, add a notes textarea (multi-line, not a single-line input)
- For Goal and Project: show it on the Manage page as an expandable or always-visible section, with inline-edit consistent with the existing title/DoD inline-edit pattern
- For Action: show on the ActionForm edit view
- For Intervals and Routines: add to IntervalForm
- For Milestone: add to MilestoneForm

**Notes:** Keep it simple — a single text field, not a list of notes with timestamps, for MVP. A richer notes history can come later.

---

### F-3 · File Attachments (Documentation)

**What:** Allow attaching files to Goals, Projects, and Actions. For MVP this is upload-only (no internal document editor — that's a future feature). The attached files serve as reference material: specs, research, images, contracts, etc.

**Scope:**

Backend
- Add an `Attachment` model to `schema.prisma`:
  ```
  model Attachment {
    id          String   @id @default(uuid())
    filename    String
    mimetype    String
    size        Int
    storagePath String   // local path or object storage key
    goalId      String?
    projectId   String?
    actionId    String?
    userId      String
    createdAt   DateTime @default(now())
  }
  ```
- Add file upload handling (multipart) — Express middleware (e.g. `multer`) alongside the GraphQL layer, since Apollo doesn't handle binary uploads cleanly
- REST endpoint or GraphQL File scalar for upload; REST is simpler for MVP
- Add `deleteAttachment` and `getAttachments(entityType, entityId)` endpoints
- Store files locally for now (a `/uploads` directory, configurable path)

Frontend
- On Goal manage page, Project form/manage page, and Action form: add an Attachments section
- File picker + upload button, list of attached files with filename, size, date
- Download link per file, delete button
- Keep visually minimal: a collapsible section, not a primary UI element

**Notes:** Decide on storage strategy before starting — local filesystem is fine for the personal version. The REST vs GraphQL decision for file upload should be made once (REST is recommended for simplicity).

---

### F-4 · Goal Setup Wizard

**What:** A guided wizard that takes a user from zero to a properly structured goal. It's designed to be used when creating a new goal, and it walks through: clarifying the DoD, breaking the goal into milestones, defining the first project, and optionally creating the first actions.

The wizard should feel like a conversation with the platform — not a form. It's the most direct expression of the Root philosophy in the UI.

**Steps:**

1. **Name the goal** — title only; no DoD yet
2. **DoD clarity check** — walks through the clarity questions from F-1; produces a reviewed DoD
3. **Milestone breakdown** — prompts "What are the major stages to get there?" — user adds 2–5 milestones with titles; DoA for each is optional at this stage
4. **Mark the last milestone** — which milestone represents completion?
5. **Define the first project** — within the first milestone (or directly on the goal if no milestones): title, optional DoD, start thinking about scope
6. **Add first actions to the project** — at least one action; can add estimated time and date or leave for later
7. **Summary and confirm** — read-only overview of what was created: goal → milestone(s) → project → actions

**Exit behaviors:**
- User can exit the wizard at any step; what has been entered so far is saved to the DB (partial state is valid — a goal with no milestones is fine)
- A "come back later" mechanism: if a goal was created via wizard but not completed, show a "Continue setup" nudge on the Goals list

**Scope:**

Backend
- No new data model needed; uses existing mutations (addGoal, addMilestone, addProject, addAction)
- Optionally: a `wizardState` field on `Goal` (enum: `complete | in_progress | skipped`) to track setup status

Frontend
- New route: `/activities/goal/wizard` or as an overlay/modal
- Multi-step component, similar in structure to PreDayWizard and AfterDayWizard — tabs/step indicator at the top, one focused step at a time
- Each step calls the appropriate mutation immediately (don't buffer everything to one final submit — it's safer and simpler)
- The clarity check step from F-1 is embedded here as a reusable component (also used in the standalone goal form)

**Notes:** This is the highest-value feature for first-time users. Even a rough version of it will dramatically reduce the "blank page" problem when someone opens the app for the first time.

---

## Bug Fixes & Inconsistencies

These are issues observable directly in the source code. They should be resolved before the MVP is considered complete.

---

### B-7 · Project Start/End Dates Not Editable

**Where:** `ProjectForm.tsx` (edit mode), `ProjectPreview.tsx`

**Issue:** The `Project` model has `startDate` and `endDate` fields and they're used in `getProjectStatus()` (to compute "In Progress", "TBD", etc.), but there is no UI to set or edit them anywhere. The `UPDATE_PROJECT` mutation also doesn't include `startDate`/`endDate` arguments in the GraphQL schema. As a result, projects are permanently stuck in "Backlog" status unless dates exist — and they can never be set after creation via the current UI.

**Fix:**
- Add `startDate` and `endDate` arguments to the `updateProject` mutation in `typeDefs.ts` and the mutation resolver
- Add date pickers to the Project form (both create and edit modes)
- Update the `UPDATE_PROJECT` GraphQL query in `queries.ts` to include the new fields

---

### B-14 · New User First-Day Deadlock

**Where:** `todayPreDayAfterDay.ts` (`getPreDayStatus`), `TodayPage.tsx`, `PreDayWizard.tsx`

**Issue:** `afterDayRequired` is true whenever `yesterdayState?.afterDayCompletedAt == null` — meaning if there is *no DayState record for yesterday at all*, after-day is considered required. For a brand-new user on their very first day, yesterday has never existed in the system, so this evaluates to `true`. Pre-day then opens with the After-day wizard for yesterday as its first step. The After-day wizard for an empty day loads successfully (no linked actions, no standalone actions, auto-archives nothing), and the user can click through — but this is a confusing and meaningless first experience that presents the app's end-of-day cleanup ritual before the user has done anything.

**Fix:** In `getPreDayStatus`, treat a missing yesterday DayState as "after-day not required" rather than "after-day required." The absence of a record should mean there's nothing to review, not that something is overdue. Change the condition to: `afterDayRequired = yesterdayState != null && yesterdayState.afterDayCompletedAt == null`.

### B-1 · ActionPreview: Delete Without Confirmation

**Where:** `ActionPreview.tsx`, `handleDelete` function (non-today-options variant)

**Issue:** The delete button on `ActionPreview` (in the standard list view, not today mode) calls `deleteAction` immediately with no confirmation dialog. Every other destructive action in the app uses `ConfirmDialog`. There's also commented-out dead code in `handleDelete` (the raw fetch block) that should be removed.

**Fix:**
- Wrap the delete call in a `ConfirmDialog` consistent with the rest of the app
- Remove the commented-out fetch block

---

### B-2 · ActionPreview: Toggle Does Not Persist Checked State Correctly

**Where:** `ActionPreview.tsx`, `handleToggle` and the `useEffect` that resets `checked`

**Issue:** The `useEffect` that syncs `checked` from `action.done` only re-runs when `action.id` changes, not when `action.done` changes. This means if the parent re-renders the same action with an updated `done` value (e.g. after refetch), the local checkbox state won't update. Combined with the fact that `onToggle` updates the parent's local state independently, the checkbox can get out of sync with the server if a refetch returns a different value.

**Fix:** Change the `useEffect` dependency from `[action.id]` to `[action.id, action.done]`.

---

### B-3 · ProjectPreview: "Show More" Does Not Show Add Action Button

**Where:** `ProjectPreview.tsx`, the detailed accordion layout

**Issue:** When `showAllActions` is false (collapsed, showing only the first action + "Show more" button), the "Add action" button is not accessible. It only appears in the `showAllActions` branch. A project in the collapsed state gives the user no way to add an action without first expanding all actions.

**Fix:** Move the "Add action" button outside the `showAllActions` conditional, or show it in the header area of the accordion regardless of expansion state.

---

### B-4 · MilestoneForm: Prediction Date Locked After First Edit

**Where:** `MilestoneForm.tsx`, `predictionDateLocked` state and `showPredictionReadOnly` logic

**Issue:** Once a prediction date is set on a milestone and the milestone is opened for edit, the date is shown as read-only text and the calendar is not rendered (`canSetPrediction = !isEdit || (isEdit && !predictionDateLocked)`). The intent seems to be preventing accidental changes, but the result is that the user cannot change the prediction date at all in edit mode once it's been set. There's no "edit" or "clear" affordance.

**Fix:** Show the read-only date with an explicit "Change" or "Clear" button that sets `predictionDateLocked = false`, revealing the calendar picker again.

---

### B-5 · ActionForm (Edit): `setTempTitle` Called on Undefined State

**Where:** `ActionForm.tsx`, `useEffect` that loads action data for edit mode

**Issue:** `setTempTitle` and `setTempDod` are called inside the useEffect but `tempTitle` and `tempDod` state variables are not declared in the component (they don't appear in the `useState` declarations visible in the file). This will throw a runtime error when loading an existing action in edit mode.

**Fix:** Either add the missing `useState` declarations for `tempTitle` / `tempDod`, or remove those calls if they're dead code from a refactor.

---

### B-6 · Goals Query: Root-Level Goals Only by Default

**Where:** `query.ts` (API), `GET_GOALS` query (frontend)

**Issue:** The default `goals` query (no `includeAll` flag) filters to `parentGoalId = null AND parentMilestoneId = null`, returning only top-level goals. This is correct for the Goals list page. However, the `IntervalForm` and `ProjectForm` use the same query to populate goal dropdowns, and they need all goals (including child goals) to be available for linking. Currently they only show top-level goals, making it impossible to link an interval or project to a child goal.

**Fix:** Pass `includeAll: true` in the `GET_GOALS` query called from `IntervalForm` and `ProjectForm` dropdowns.

---

### B-8 · Calendar Does Not Show Gathered Actions

**Where:** `useCalendarItems.ts` (not read, but inferred from architecture)

**Issue:** Gathered actions have `forDate` set (not `tbd`). The calendar query likely uses `linkedActions` and `standaloneActions` which filter by `tbd`. Gathered actions (from intervals/routines) will therefore not appear on the calendar even though they're scheduled for specific dates.

**Fix:** The calendar data fetching should use `todayActions(date)` per visible date range, or add a dedicated query that returns all actions (by tbd or forDate) within a date range. The latter is the correct long-term approach and should be added as a new API query.

---

### B-9 · After-day "Tomorrow Review" Step Hidden When Embedded in Pre-day

**Where:** `AfterDayWizard.tsx`, step 3 rendering condition

**Issue:** Step 3 (Tomorrow review) is conditionally hidden when the wizard is `embeddedInPreDay`. This is intentional per comments in the code, but it creates an asymmetry: when After-day is triggered standalone from the Today page, the user sees the tomorrow preview. When it's triggered as part of Pre-day for yesterday, they don't. The Pre-day flow then immediately shows tomorrow's actions in its own "Day overview" step — but only today's actions, not a true tomorrow review. Users who only ever do After-day from Pre-day never see the tomorrow preview feature.

**Fix:** Document this as intentional. We could even hide the step conditionaly

---

### B-10 · Postponed Actions Permanently Disappear from Today

**Where:** `mutations.ts` (`postponeAction`), `todayPreDayAfterDay.ts` (`getTodayActions`)

**Issue:** `postponeAction` updates the action's date and also sets `actionFate: "Postponed"`. Both `getTodayActions` and `getNotDoneActionsForDate` filter on `actionFate: null`. This means a postponed action is moved to its new date *and* flagged with a fate — so when that new date arrives, it will not appear in Today, not appear in Pre-day, and not appear in After-day either. It is permanently invisible to the daily flow, despite being a live action with a real due date.

**Fix:** `postponeAction` should clear `actionFate` back to `null` when rescheduling. The fate should only be written as a terminal state — when the action is truly disposed of. Alternatively, treat `Postponed` as a transitional fate and update `getTodayActions` / `getNotDoneActionsForDate` to include `Postponed` actions whose new date has arrived.

---

### B-11 · Postponed Gathered Actions Retain Old `startTimeOfDay`

**Where:** `mutations.ts` (`postponeAction`)

**Issue:** When a gathered action with an assigned `startTimeOfDay` (e.g. "09:00" from its interval's `predictedToDoTime`) is postponed to a future date, the `startTimeOfDay` is not cleared. When that future date arrives — if B-10 is fixed — the action will appear in Today already slotted at the old time, bypassing the Pre-day step where the user is supposed to assign times. It also means the Pre-day "actions without time" list won't include it, so the user has no opportunity to reconsider the time.

**Fix:** `postponeAction` should set `startTimeOfDay: null` when rescheduling, so the action re-enters the time-assignment flow naturally on its new date.

---

### B-12 · Calendar: Milestone `doa` Parsed as Date

**Where:** `useCalendarItems.ts`

**Issue:** The calendar tries to display milestones on a date using `parseDateOnly(m.doa)` as a fallback when `predictionDate` is not set. But `doa` is the "Definition of Achieved" — a free-text description field (e.g. "Feature is shipped and users can sign up"), not a date. `parseDateOnly` on arbitrary text returns `Invalid Date`, which silently produces `NaN` timestamps. The milestone is simply not shown, but `NaN` comparisons can cause subtle ordering/filtering issues downstream.

**Fix:** Remove `doa` from the date fallback entirely. Only use `predictionDate` for milestone calendar placement. A milestone with no `predictionDate` simply has no calendar representation — that's correct behavior.

---

### B-13 · Calendar: Intervals Show Only Custom Dates, Not Recurrence

**Where:** `useCalendarItems.ts`

**Issue:** The calendar renders intervals by iterating `customRepeatDates` only, with a comment acknowledging "recurrence expansion can be added later." This means intervals defined with a recurring rule (e.g. every Monday) produce no calendar events at all — only intervals with explicitly listed specific dates appear. Given that recurrence-based intervals are the primary use case, the calendar's "Intervals" filter is effectively broken for most users.

**Fix:** Run the same `intervalOccursOnDate` logic from `actionGathering.ts` across the visible date range to generate calendar events. This can be shared/imported from the service layer rather than duplicated. The range should be bounded (e.g. max 90 days forward) to avoid performance issues.

---

### B-15 · Goal Group Status Always "Backlog" Despite Child Goal Progress

**Where:** `GoalPreview.tsx` (`getGoalStatus`), `GoalsListPage.tsx`

**Issue:** `getGoalStatus` computes status from `props.projects` — but for a goal group, the `GET_GOALS` query only returns `projects` directly on the goal (empty for a goal group, which holds child goals instead). The child goals' projects are not included in this array. As a result, `getGoalStatus` always returns `"Backlog"` for goal groups regardless of how much work has been completed inside them. The UI partially papers over this by hiding the status badge for `isGoalGroup`, but `getGoalStatus` is also used for the `hideDone` filter — a completed goal group will never be hidden by "Hide Done."

**Fix:** For goal groups, either skip status computation entirely (treat them as containers, not trackable entities), or compute status by recursing through child goals. The simpler fix is to exclude goal groups from `getGoalStatus` and instead show a project/child-goal count in the preview card. The `hideDone` filter should also skip goal groups or use a separate completion heuristic.

---

## Technical Infrastructure Projects

---

### T-1 · Backend Unit Tests

**Scope:**
- Test framework: Vitest or Jest (Vitest recommended given the Vite/TS stack)
- Priority test targets:
  - `actionGathering.ts`: `intervalOccursOnDate`, `routineOccursOnDate`, `runActionGathering` — these are pure/near-pure functions with complex branching and are highest-risk
  - `todayPreDayAfterDay.ts`: `getTodayActions`, `getPreDayStatus`, `getNotDoneActionsForDate`
  - Mutation resolvers: auth guards (`requireAuth`, `ensureOwned`), and the core business logic in mutations (estimated time validation, goal/milestone scope exclusivity)
- Use Prisma's test client or mock Prisma with `jest-mock-extended` / `vitest-mock-extended`
- Minimum coverage target: 80% on the two service files; resolver tests should cover the main happy paths and the key error cases

**Notes:** The recurrence engine in `actionGathering.ts` is the most complex and most likely to have edge case bugs (DST, month boundaries, leap years). This is where unit tests will earn their keep fastest.

---

### T-2 · Frontend Unit Tests

**Scope:**
- Test framework: Vitest + React Testing Library (already compatible with Vite)
- Priority test targets:
  - Wizard step logic: `PreDayWizard` and `AfterDayWizard` — step transitions, auto-advance conditions, overlap detection, disposition handling
  - `ActionPreview` — toggle, delete, today-options mode, canIgnore/canPass logic
  - `GoalPreview` / `getGoalStatus` / `isProjectDoneForGoal` — computed status functions
  - `getProjectStatus` in `ProjectPreview`
  - Utility functions in `dateUtils.ts`, `actionGathering.ts` (shared logic)
- Mock the `useApi` hook; don't make real API calls in component tests

---

### T-3 · End-to-End Tests

**Scope:**
- Framework: Playwright (preferred over Cypress for modern Vite/React Router apps)
- Covers the complete MVP user journey from a fresh account:
  1. Register → login
  2. Create a goal via the Goal Wizard (F-4), complete all steps
  3. Navigate to Today — confirm Pre-day gate is shown
  4. Complete Pre-day — confirm Today is accessible
  5. Toggle an action done
  6. Trigger After-day — handle an unfinished action (postpone)
  7. Complete After-day — confirm action gathering runs and tomorrow's gathered actions appear
  8. Verify calendar shows scheduled actions
  9. Create an interval with weekly recurrence — verify gathered actions appear after running gathering
  10. Attach a file to a goal (F-3) — verify it appears in the attachments list
- Run against a dedicated test database (separate `.env.test` with a fresh SQLite file)
- CI-ready: should run headless and exit cleanly

---

### T-4 · Test Environment Setup

**Scope:** Before T-1/T-2/T-3 can run reliably, the test environment needs to be set up:

Backend:
- Add `vitest.config.ts` (or `jest.config.ts`) to `trackerApi`
- Add a test database setup script (migrate + seed) using Prisma's `--env-file` flag pointing to `.env.test`
- Ensure `DATABASE_URL` in test env points to an isolated SQLite file (e.g. `./prisma/test.db`)
- Add `"test"` script to `package.json`

Frontend:
- Add `vitest.config.ts` to `trackerProject` with `jsdom` environment and React Testing Library setup
- Add `setupTests.ts` for `@testing-library/jest-dom` matchers
- Mock the auth context and `useApi` hook at the module level for component tests
- Add `"test"` script to `package.json`

---

## Suggested Project Order

The projects above are roughly ordered by dependency and risk. A reasonable execution sequence:

1. **B-5** (ActionForm crash) — fix first, it's a runtime error
2. **B-14** (new user deadlock) — fix second; blocks all first-use testing
3. **B-10, B-11** (postponed actions) — data integrity bugs; fix before any user testing
4. **B-1, B-2, B-3, B-4** — low-effort hygiene fixes
5. **B-7** (project dates) — required before project status is meaningful
6. **B-6** (goals query in dropdowns) — fix before F-4 wizard is built
7. **B-12** (milestone calendar doa) — quick fix, prevents silent NaN bugs
8. **B-8, B-13** (calendar: gathered actions + interval recurrence) — fix before E2E tests reference the calendar
9. **B-15** (goal group status) — fix alongside or after B-7
10. **T-4** (test environment) — set up before writing any tests
11. **T-1, T-2** (unit tests) — can be done in parallel across backend and frontend
12. **F-2** (notes) — small, self-contained, good warm-up before the larger features
13. **F-1** (DoD clarity check) — design the questions first, then implement
14. **F-3** (attachments) — needs infrastructure decision (storage), then straightforward
15. **F-4** (goal wizard) — depends on F-1 being done; the most complex feature
16. **F-5** (concepts page) — static content; can be done any time but most useful once F-4 exists to link to
17. **F-6a** (first-login slideshow) — needs DB model; content can be drafted in parallel with other work
18. **F-6b** (module intro overlays) — depends on F-6a DB infrastructure being in place
19. **T-3** (E2E tests) — write after all features are complete; tests the full system
20. **B-9** (tomorrow review in wizard) — low priority; decide intent first, fix or document last

---

## Out of Scope for This MVP

The following are known placeholders in the codebase but deliberately excluded from this roadmap:

- **Settings page** — no product decisions made yet
- **Tools page** — no product decisions made yet  
- **Focus mode** — commented out in TodayPage
- **Maintain pillar** (dimension tracking: physical/mental/spiritual)
- **Grow pillar** (EI/Language of Needs module, learning paths)
- **Share pillar** (shared goals, co-working)
- **Native iOS/Android apps** — PWA manifest is in place; native apps are a distribution decision post-MVP
- **Internal document editor** — attachments (F-3) cover file upload only; rich text docs are deferred
- **Interactive tutorials (F-6c)** — deferred post-MVP; depends on F-6b overlay infrastructure and F-4 wizard as reference

---

## F-5 · Concepts Page

**What:** A dedicated reference page inside the app that explains the platform's core concepts, their definitions, and how they relate to each other. Accessible at any time from the navigation (a natural fit under the Tools section or as a standalone `/concepts` route). Supplemented by contextual hints that appear inline throughout the UI at relevant points.

**Two components:**

### 5a — Dedicated Concepts Page (`/concepts`)

A single scrollable page (or lightly tabbed) that covers:

- **The philosophy** — Root's three dimensions (physical, mental, spiritual), the belief in capability and systemic progress, reality over fiction
- **The hierarchy** — Goal → Milestone → Project → Action, with a visual diagram showing how they nest and link
- **Goal Groups** — what they are, when to use them vs a regular goal
- **Intervals vs Routines** — the distinction, when each is appropriate
- **The daily flow** — After-day → Pre-day → Today → After-day, and why it's structured that way
- **Priority system** — P/S/O/B explained as a quadrant (urgency × importance)
- **Action fates** — Postponed, Outsource, Backlog, BucketList, PassedArchived — what each means and when it applies
- **DayState lifecycle** — how the platform gates access and why

Each concept section should be short and concrete — 2–4 sentences max, with a real example. This is a reference page, not documentation prose.

**Scope:**

Backend
- No new API needed; this is a static content page

Frontend
- New route `/concepts` (or `/guide`)
- Add to navigation — a small "?" or "Guide" entry in the sidebar/bottom bar, distinct from Settings
- Content is hardcoded for MVP; no CMS needed
- The hierarchy diagram should be a simple visual component (SVG or styled divs) showing the nesting — not a third-party diagram library

### 5b — Contextual Inline Hints

Small "i" icon buttons placed at key points throughout the UI that, when tapped/clicked, open a popover explaining the concept directly relevant to what the user is looking at. These are persistent (always available, not just on first use) and require no DB state.

Placement targets for MVP:
| Location | Hint content |
|---|---|
| Goals list page header | What a goal is; the goal/milestone/project hierarchy |
| Goal form — DoD field | What DoD means; why clarity matters |
| Milestone form — DoA field | What DoA means; difference from DoD |
| Milestone form — "Last milestone" checkbox | What this controls and why only one can be last |
| Project form — Priority field | The P/S/O/B quadrant explained |
| Intervals list page | Interval vs Routine distinction |
| Interval form — recurrence fields | How the recurrence engine works |
| Today page — Linked vs Standalone sections | Why these are separated |
| Pre-day — overlap warning | What overlaps mean and why they matter |
| After-day — action fate options | What each fate does to the action |

**Implementation notes:**
- Use a `<HintPopover>` component wrapping shadcn's `Popover` — reusable, takes a `content` prop
- No DB state needed; hints are always available and not tracked
- Keep hint text to 3–5 sentences; link to the relevant section of the concepts page for more

---

## F-6 · Onboarding & Tutorial System

**What:** A three-layer system to help new users understand the platform and get to first real usage without friction. The layers are: a required first-login slideshow, per-module introduction overlays, and (deferred to post-MVP) an interactive tutorial section.

### 6a — First-Login Slideshow (Required)

A full-screen step-by-step guide that appears automatically the first time a user logs in after registering. Each slide must be explicitly advanced; the user cannot dismiss the whole flow without viewing every slide. Progress is tracked per-slide in the database so a user who closes mid-way resumes where they left off on next login.

**Slides (suggested sequence):**
1. Welcome — what Root is and what this platform is for
2. The three dimensions — physical, mental, spiritual; how the platform thinks about a whole person
3. The hierarchy — Goal → Milestone → Project → Action with a simple diagram
4. Intervals and Routines — recurring activities and how they feed into your day
5. The daily flow — Pre-day, Today, After-day; the rhythm the platform is built around
6. You're ready — what to do next (points toward Goal Wizard or Concepts page)

**DB scope:**

Backend
- Add an `OnboardingSlide` model (or a simpler `userOnboardingProgress` JSON field on `User`):
  ```
  model OnboardingProgress {
    id           String   @id @default(uuid())
    userId       String   @unique
    lastSlideViewed  Int  @default(0)   // 0 = not started, 6 = complete
    completedAt  DateTime?
    user         User     @relation(fields: [userId], references: [id])
  }
  ```
- Add `getOnboardingProgress` query and `markOnboardingSlideViewed(slideIndex: Int!)` mutation
- `markOnboardingSlideViewed` upserts the record, updating `lastSlideViewed` if the new index is higher (never goes backwards), and sets `completedAt` when all slides are done

Frontend
- On login/app load, query `getOnboardingProgress`; if `completedAt` is null, show the slideshow overlay
- Full-screen modal overlay (not a page route); renders on top of whatever the current route is
- Previous/Next navigation; "Next" calls `markOnboardingSlideViewed` before advancing
- Final slide has a "Get started" button that closes the overlay and optionally navigates to the Goal Wizard
- Slide content is hardcoded for MVP (same rationale as concepts page)
- Overlay is dismissible mid-flow (user can close it), but re-appears on next login at the last unviewed slide until all slides are marked viewed

### 6b — Module Introduction Overlays

When a user visits a module page for the first time, a step-by-step coach-mark overlay introduces the page — its purpose, the key concepts it relates to, and the primary actions available. Can be skipped at any point. Once dismissed (or completed), it does not reappear.

**Modules to cover:**
| Module | Key concepts to introduce |
|---|---|
| Today | The daily gate; linked vs standalone; what the page is for |
| Pre-day | Time assignment; overlap detection; why this ritual exists |
| After-day | Action fates; what "closing the day" means |
| Goals list | The goal hierarchy; goal groups vs goals |
| Manage Goal page | Milestones; progress computation; the story view |
| Projects list | Project lifecycle; how status is computed |
| Intervals list | Interval vs Routine; how gathering works |
| Calendar | What is and isn't shown; the filter options |

**DB scope:**

Backend
- Add a `moduleIntrosViewed` JSON field on `User` (array of module keys), or a separate table:
  ```
  model ModuleIntroViewed {
    id        String   @id @default(uuid())
    userId    String
    moduleKey String   // e.g. "today", "preDay", "goals", "intervals"
    viewedAt  DateTime @default(now())
    @@unique([userId, moduleKey])
  }
  ```
- Add `markModuleIntroViewed(moduleKey: String!)` mutation
- Add `viewedModuleIntros` field to the user query response (returns array of moduleKey strings)

Frontend
- On mount of each covered page, check if the module key is in `viewedModuleIntros`; if not, show the overlay
- Overlay is a step-by-step coach mark sequence: each step highlights a specific UI element (or is a simple centered card if no specific element to highlight) with a short explanation
- "Skip" button available at all times; "Next" advances through steps; final step has "Got it"
- Either Skip or completing all steps calls `markModuleIntroViewed` and closes the overlay
- Steps are hardcoded per module for MVP
- A `<ModuleIntroOverlay moduleKey="today" steps={[...]} />` reusable component handles the rendering; each page just passes its steps

### 6c — Interactive Tutorials (Post-MVP, Deferred)

A tutorials section (likely under Tools) where users can choose from a library of guided tasks — "Create your first goal," "Set up a recurring interval," "Run your first Pre-day" — and the app walks them through performing the real action step by step. At the end of each tutorial, the user has actually created something in their account.

This layer is explicitly deferred. It requires the module intro system (6b) to be in place first since it reuses the same overlay infrastructure, and it requires the Goal Wizard (F-4) as a reference implementation for how guided real-action flows work. Document it here to inform architecture decisions in 6b — the `ModuleIntroOverlay` component should be flexible enough to eventually support tutorials, not just fixed intro sequences.

---
