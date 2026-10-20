# Focus Periods — spec

*Module `tracker/modules/01-focus-periods/` · Track: Module · Phase 2 · Spec, not as-built. A dated, hand-picked set of projects with its own page for progress, next actions and light management. Inputs: `00-intake.md` (research waived there). Update the changelog; don't fork.*

**Version 0.3 · Status: spec · 2026-10-20 · Owner: _root**

**Grading.** Everything here is **proposal** until built. Items marked **[F]** were decided by the founder (intake rounds 1–2, §2 and §2.1). Every as-built fact a requirement depends on cites its file. Code read at `main @ 003db5a`.

**Scope ledger** *(acceptance criteria by area, at each version, against the intake)*:

| Area | Intake | 0.1 | 0.2 | 0.3 |
|---|---|---|---|---|
| Data & API | in scope | 6 | 6 | 6 |
| Page states | in scope | 4 | 4 | 4 |
| Project card: progress & next actions | in scope | 6 | 6 | 7 |
| Management on the page | in scope | 5 | 5 | 5 |
| Look-back | in scope | 4 | 4 | 4 |
| Navigation & language | in scope | 3 | 3 | 3 |
| Policy guards | in scope | 3 | 3 | 3 |
| **Total** | | **31** | **31** | **32** |

*At 0.3 the subject changed from goals to projects [F]. AC-20 was retired (a project can always take an action), and AC-32 and AC-33 were added.*

---

## Summary

A **Focus Period** (Persian **فشرده** [F]) is a new object: a name, start and end dates, and the hand-picked **projects** to be done in that time [F]. Only one runs at a time.
It has its own top-level **Focus** tab. The header shows the dates and the days left, with no tally [F].
Each project shows **actions done out of total** ("5 of 8"), its goal and milestone for context, and its **3 soonest undone actions** [F]. From the page you can complete, add or reschedule an action, and add or remove projects.
When the period ends, a **look-back** lists finished and unfinished projects, with carry-over and a one-tap "oriented or behind?" check that measures the drop rule.
No new rules about what "done" means. The page reuses the project rules Tracker already ships.

## 1. What it is

**A Focus Period is a lens, not a container.** It doesn't own projects. It points at them. A project stays where it is in the tree of intent (under its goal or milestone, or on its own) and can belong to many periods over time (one at a time, since periods can't overlap). Removing a project from a period, or deleting the period, never touches the project.

**Fields.** `title`; `startDate` and `endDate`, both date-only and inclusive; `projects` (many-to-many); `lookbackAnswer` (`"oriented" | "behind" | null`); `lookbackSeenAt`.

**Its state is derived from today's date, never stored:**
- *upcoming*: start is after today;
- *active*: start ≤ today ≤ end;
- *ended*: end is before today.

**No overlaps.** Two periods may not share any day, past or future. This is what makes "the current period" unambiguous. One upcoming period may be planned while another is active, as long as their days don't overlap.

**How it differs from its neighbours:**
- A **Project** is a body of work.
- A **Time Theme** is a recurring, tag-shaped stretch of the *day* that has no projects.
- A Focus Period is a one-off stretch of *days* that points at a few projects.

### 1.1 The rules it reuses (as-built)

- **A project is done** when it has at least one action and all of them are done. That's `getProjectStatus` returning `"Done"` (`client/app/components/projects/ProjectPreview.tsx:57-64`), the same rule as `isProjectDoneForGoal` (`client/app/components/goals/GoalPreview.tsx:36`). The client computes it; it isn't stored.
- **Project progress** is done actions divided by all of the project's actions. That's the bar `ProjectPreview` already draws (`ProjectPreview.tsx:121`, `:538-540`).
- **A project's actions are only ones you made.** Recurring actions from intervals and routines are created without a `projectId` (`api/src/services/actionGathering.ts:433-444`), so they never appear among a project's actions. Nothing has to filter them out.
- **Scheduling an action requires an estimate.** `addAction` and `updateAction` reject a `tbd` that has no `estimatedTimeMinutes` (`api/src/graphql/resolvers/mutations.ts:98-128`, `:154`).
- **A project's dates are inferred from its actions** (`Project.startDate`/`endDate`, `api/src/graphql/resolvers/typeResolvers.ts:42-60`). The project picker uses them to show which projects already have work scheduled inside the period.

## 2. Decisions taken at spec

| # | Question | Answer [F] | Consequence |
|---|---|---|---|
| 1 | Which goals can be added? | *Superseded at 0.3 (§2.1, #10).* | — |
| 2 | How many next actions per card? | 3 undone | The card shows at most 3, plus "+N more" linking to the project's page. |
| 3 | Persian name | فشرده (changed at 0.2 from بازه فشرده) | Used for both the object and the tab, in UI strings and the glossary. Dropping بازه avoids the collision with Interval (R1, retired). |
| 4 | Container, header, management, concurrency, end, placement, drop rule | As in `00-intake.md` §5–6 | Carried over unchanged. |

Decisions made at spec without asking. Each is reversible at `revise`:

| # | Decision | Why |
|---|---|---|
| 5 | Progress and done-ness are computed **on the client**, reusing `getProjectStatus` and `ProjectPreview`'s progress calculation | A second server-side copy of the "done" rule would drift (R2). |
| 6 | *Retired at 0.3.* | Recurring actions never carry a `projectId` (§1.1), so the rule that excluded them is moot. |
| 7 | The look-back reads project status **live**, when you open it, not as a snapshot at the period's end | It needs no stored snapshot. A project finished a day after the end shows as finished, which is accepted for now (R5). |
| 8 | Browsing past periods is out of scope | The intake asked only for the look-back. |
| 9 | The Focus tab also goes on the mobile bottom bar, as its 6th item | You asked for its own tab. Crowding is R4. |

### 2.1 Decisions taken at the 0.3 revise

| # | Question | Answer | Consequence |
|---|---|---|---|
| 10 | Goals or projects? | **Projects only** [F] | The model links to `Project`. Progress becomes actions done out of total, and milestone counting is dropped. "+ Action" no longer needs a project picker or a no-projects fallback, so AC-20 is retired. |
| 11 | "Projects tbd in that period": picked by hand, or pulled in by date? | **Picked by hand.** The picker lists projects with actions already scheduled inside the period first, each showing its dates. | It matches "you set … projects", and nothing joins a period you didn't put there. The date sorting still helps you find the projects already planned for that stretch. Reversible if you meant automatic. |
| 12 | Does the card show the project's status badge? | **No.** Progress, and "Done" once finished, only. | The existing "Ignored" badge (yellow, all undone actions in the past) is a nag here. Progress already says where the project stands. |
| 13 | Does the card show where the project sits? | **Yes**, one muted line: *goal › milestone*, or "No goal". | Projects from different goals sit side by side, and their names alone often lack context. |

## 3. Metrics

| # | Measure | What it counts | Why |
|---|---|---|---|
| M1 | Felt-behind rate | Of the look-backs answered, the share answering "behind" | The drop rule, verbatim: "drop if the days-left header makes you feel behind rather than oriented." |
| M2 | Visits during a period | Distinct days the Focus tab was opened while a period was active, divided by the period's length in days | Shows whether the page is used at all, or whether Today and Projects already cover the need. |
| M3 | Actions moved from the page | Completions, additions and reschedules made from the Focus page | Shows whether the management on the page earns its place. |

The founder waived the eval plan (0.2). M1 is stored (`lookbackAnswer`). M2 and M3 stay as measures, with no instrument planned.

## 4. Interface requirements

### 4.1 Focus tab: page states

The tab is the only entry point. What it shows depends on the derived state:

| State | Shows |
|---|---|
| No period | Empty state: one line on what a focus period is, and a **Start a focus period** form (title, start date defaulting to today, end date, project picker). |
| Upcoming only | The period's card with "Starts in N days" and its projects (same cards as when active). Edit stays available. |
| Active | Header plus project cards (4.2–4.3). |
| Ended, look-back not seen | The look-back (4.5). This comes first: if a new period is already active, the look-back still shows first, then the active period. |
| Ended, look-back seen, nothing upcoming | The empty state, with **Start a focus period**. |

### 4.2 Header

- The title, the dates (`fmt` from `useAppDate`, so Jalali in Persian), and **days left** counting today: "12 days left" or, on the final day, "Last day".
- **No count of finished projects, no percent, no colour that changes as the end gets closer.** The header looks the same on day 1 and on the last day, apart from the number.
- An **Edit** control: rename, change the dates (the overlap check applies), add or remove projects, delete the period (with a confirmation saying the projects themselves stay).

### 4.3 Project card

One card per project, in the order the projects were added.

- **The project title** links to the project's page.
- **Context:** one muted line with the goal's title, then the milestone's title if the project sits under one, or "No goal" for a standalone project (§2.1, #13).
- **Progress:** "**5 of 8 actions done**" and a bar, the same calculation as `ProjectPreview`. With no actions, it says "No actions yet" and shows no bar. A finished project shows "Done", and no next actions.
- **Next actions:** up to **3** undone actions of the project. An action with an `actionFate` other than `Postponed` is excluded. *(Assumption: `Postponed` stays live; check this against `api/src/services/todayPreDayAfterDay.ts` in the build.)*
  - **Order:** scheduled actions first, earliest `tbd` first (overdue ones included), then unscheduled ones, oldest first.
  - **Each row** shows the title and the scheduled day, or "No day".
  - **Overdue days** show as a plain date. No red, no "overdue" label.
  - **"+N more"** links to the project's page when there are more than 3.
- **Gestures on a row. One control, one effect; nothing nests:**
  - The **checkbox** only completes the action (`toggleAction`).
  - The **day button** only opens the reschedule popover.
  - The **title** only opens the action's page.
  - Tapping empty space on the row does nothing.

### 4.4 Management

- **Complete.** The checkbox calls the existing `toggleAction`. The row leaves the list, the next one moves up, and the progress count updates. An **Undo** toast lasts about 5 seconds.
- **Reschedule.** A date popover. If the action has no estimate, the popover also asks for minutes, because the server requires one (§1.1). "Clear day" unschedules it.
- **Add action.** An inline "+ Action" on each card: a title and an optional day. A day requires an estimate. It uses the existing `addAction` with the card's `projectId`, so the new action inherits the project's tags as usual.
- **Add or remove projects.**
  - **Picker.** Lists the user's projects that aren't done. Projects with at least one undone action scheduled inside the period's dates come first, then the rest, each with its inferred dates or "No dates" and its goal context. It has a search field (§2.1, #11).
  - **Removing** is done from Edit, or "Remove from period" on a card's menu. Removing never changes the project.

### 4.5 Look-back

- Shown once per ended period, when the tab opens (4.1).
- Two lists:
  - **Finished**: projects whose status is now `Done`.
  - **Not finished**: each one shows its progress, as on the card.
- **One question, optional and skippable:** "Over this period, the days-left count made me feel… **oriented** · **behind**." The answer is saved to `lookbackAnswer`.
- **Start a new period with these.** Opens the start form with the unfinished projects already ticked, each one untickable. The start date defaults to the day after the old period ended, or today if that day has already passed.
- **Done** sets `lookbackSeenAt`. Skipping the question doesn't stop you from leaving.
- **No grade, score, percent or "you finished 2 of 5".** The lists are the whole report.

### 4.6 Navigation and language

- The sidebar gets **Focus** between Calendar and Tools. The bottom bar gets it as its 6th item (`client/app/layout/navigationItems.tsx`). Icon: a neutral one such as `Crosshair` or `Target`, chosen in the design step.
- **Route:** `/focus`, protected like the others (`client/app/protectedRoutes.tsx`).
- **Persian:**
  - Both the period and the tab are **فشرده** [F]. *Draft: native pass owed.*
  - Every string goes in both `en` and `fa`, and the pages must lay out correctly right to left.

## 5. Risks

| # | Risk | Why it matters | Mitigation |
|---|---|---|---|
| R1 | *Retired at 0.2.* The 0.1 term بازه فشرده reused بازه, which already means Interval in the glossary and UI. | — | The founder changed the term to فشرده alone. |
| R2 | The "done" rule gets forked | Project done-ness is computed client-side today. A server-side copy for this page would drift. | Decision 5: reuse the existing functions. If the rule ever moves to the server, this page moves with it. |
| R3 | **The marker becomes the motive** (ecosystem decision-log, 2026-07-29) | Days left is a countdown, and countdowns can create pressure. This is exactly the founder's drop rule. Action-count bars move with every tick, so they're more "fillable" than milestone counts. | No tally, no urgency colour, no "Ignored" badge, no reminders (AC-29–31, #12). M1 measures it. |
| R4 | A 6th item crowds the bottom bar | Five icons fit today. Six may be cramped at 360px, worse with Persian labels. | Verify at 360px wide in both locales during the build. If it doesn't fit, use G1 from the wireframes: icons only on the bottom bar. |
| R5 | The look-back is computed live | Finishing a project after the period ends shows as "finished in this period". | Accepted for 0.3. A `finishedAt` snapshot is a revise item if it ever misleads. |
| R6 | Date-only boundaries cross time zones | An inclusive end date stored as a timestamp can drop or add a day. This also affects the picker's "scheduled inside the period" sorting. | Store dates the way `Action.forDate` does (date-only ISO, `typeResolvers.ts`), and compare by calendar day. |
| R7 | **Progress can go backwards** | Adding an action lowers the share done (5 of 8 becomes 5 of 9). | This is accepted as honest information. The card shows counts, not just a bar, so the reason is visible. |

## 6. Acceptance criteria

### 6.1 Data & API

- **AC-1.** A `FocusPeriod` model exists with `title`, date-only `startDate`/`endDate`, an implicit many-to-many to `Project`, `lookbackAnswer`, `lookbackSeenAt`, `userId` (cascade on delete), and `createdAt`/`updatedAt`. The data model and decision log are updated in the same change (Convention #11).
- **AC-2.** `createFocusPeriod` and `updateFocusPeriod` reject `endDate < startDate`, and reject any range sharing a day with another of the user's periods.
- **AC-3.** Setting a period's projects rejects projects that are already done, and projects the user doesn't own.
- **AC-4.** A query returns the user's latest-ended period with an unseen look-back, the active period, and the upcoming period (each nullable). Each comes with its projects' actions and goal and milestone titles, in one round trip.
- **AC-5.** Deleting a period or removing a project leaves the project and its actions unchanged. Deleting a project removes it from its periods.
- **AC-6.** `recordFocusLookback(id, answer)` stores `"oriented"`, `"behind"` or nothing, and sets `lookbackSeenAt`. It's only allowed on an ended period.

### 6.2 Page states

- **AC-7.** With no periods, `/focus` shows the empty state and the start form.
- **AC-8.** With an active period, `/focus` shows its header and one card per project.
- **AC-9.** With an upcoming period and none active, `/focus` shows "Starts in N days" with the projects.
- **AC-10.** An ended period with an unseen look-back shows its look-back before anything else. Once it's seen, it never shows again.

### 6.3 Project card: progress & next actions

- **AC-11.** A project with actions shows "D of T actions done" and a bar, matching `ProjectPreview`'s numbers for the same project.
- **AC-12.** A project with no actions shows "No actions yet", no bar, and "+ Action".
- **AC-13.** A finished project shows "Done" and lists no next actions.
- **AC-14.** At most 3 next actions are listed: undone, scheduled ones first by earliest day, then unscheduled ones oldest first. "+N more" appears when there are more.
- **AC-15.** Overdue actions show a plain date, with no warning colour or label.
- **AC-16.** On a row, the checkbox only completes, the day button only reschedules, and the title only navigates.
- **AC-32.** Each card shows the project's context line: goal › milestone, goal alone, or "No goal".

### 6.4 Management on the page

- **AC-17.** Completing an action removes it from the list, moves the next one up, updates the count, and offers Undo for about 5 seconds.
- **AC-18.** Rescheduling an action that has no estimate asks for minutes in the same popover. The save never fails on the server's estimate check.
- **AC-19.** "+ Action" creates an action under that card's project. A day requires minutes.
- **AC-20.** *Retired at 0.3.* A project can always take an action.
- **AC-21.** Projects can be added and removed from Edit, and removed from a card's menu. The page updates without a reload.
- **AC-33.** The picker lists only projects that aren't done. Those with an undone action scheduled inside the period's dates come first, each with its dates and goal context, and the picker can be searched by title.

### 6.5 Look-back

- **AC-22.** The look-back lists finished projects and not-finished projects (with progress), and shows no grade, score, percent or count sentence.
- **AC-23.** The oriented/behind question is optional. Skipping it still allows **Done**.
- **AC-24.** **Start a new period with these** opens the start form with the unfinished projects ticked, each one untickable.
- **AC-25.** The new period's start date defaults to the day after the old end, or today if that day has passed.

### 6.6 Navigation & language

- **AC-26.** **Focus** appears in the sidebar between Calendar and Tools, and on the bottom bar. `/focus` requires sign-in.
- **AC-27.** Every new string exists in `en` and `fa`. `i18n:check-missing` and `i18n:check-hardcoded` pass. Persian uses فشرده.
- **AC-28.** At 360px wide, in both locales, the bottom bar's six items don't overlap and the page has no horizontal scroll.

### 6.7 Policy guards

- **AC-29.** Nowhere on the page or the look-back is there a count or percent of projects finished in the period.
- **AC-30.** The header's styling is the same on every day of the period. Only the number changes.
- **AC-31.** Focus Periods add no notification, no reminder, and nothing on Today.

## 7. Out of scope

- Goals, milestones or goal groups in a period (§2.1, #10).
- Pulling projects into a period automatically by date (§2.1, #11).
- Several active periods at once, or overlapping periods.
- Any period-level tally or score.
- Browsing or editing past periods, apart from their look-back.
- Reminders, notifications, a line on Today, or a band on the Calendar.
- Recurring periods.
- Editing projects, or creating them, from this page.

## Changelog

- **0.3 · 2026-10-20** — The founder moved the subject from goals to projects. Progress is now actions done out of total. Milestone counting dropped. AC-20 retired; AC-32 (context line) and AC-33 (picker) added. Decisions #10–13 added and #6 retired. R7 added.
- **0.2 · 2026-10-20** — Persian term changed to فشرده by the founder; R1 retired. Eval plan waived by the founder: M1–M3 stay as measures, with no instrument planned. Wireframes added (`04-wireframes.html`).
- **0.1 · 2026-10-20** — Spec, from `00-intake.md` (research waived). The founder decided: normal goals only, 3 next actions, Persian بازه فشرده.

## References

- `00-intake.md`; `04-wireframes.html`
- Ecosystem `decisions/decision-log.md`, "Progress indication is not an extrinsic incentive" (2026-07-29)
- `canon/01-product/00-concepts-and-hierarchy.md` §1, §4; `canon/00-orientation/01-glossary.md`
- Code at `main @ 003db5a`: `api/prisma/schema.prisma`; `api/src/graphql/resolvers/mutations.ts:98-160`; `api/src/graphql/resolvers/typeResolvers.ts:42-60`; `api/src/services/actionGathering.ts:412-444`; `client/app/components/projects/ProjectPreview.tsx`; `client/app/components/goals/GoalPreview.tsx`; `client/app/layout/navigationItems.tsx`
