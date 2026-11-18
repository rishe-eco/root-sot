# Session rhythm, stage 1 — spec

*Module `tracker/modules/05-session-rhythm/` · Track: Module · Phase 2 · Spec, not as-built. Stage 1 of the session rhythm: Today with no gate, crossing out, quick capture, the planning-and-review session every 2 to 7 days, return after a gap, and the record. Inputs: `00-intake.md` (research waived there), written from `../../drafts/session-rhythm.md` 0.3-draft and Tracker decisions D-63 to D-78. Update the changelog; don't fork.*

**Version 0.3 · Status: spec · 2026-11-19 · Owner: _root**

**Grading.** Everything here is **proposal** until built. Items marked **[F]** were decided by the founder: at stage 0 (D-63 to D-78, `../../decisions/decision-log.md`) or at this spec (§2). Items under §2.2 were settled by Claude without asking and are refusable on the diff. Every as-built fact cites its file in `rishe-eco/tracker`, read at `main @ eea1c59`.

**Scope ledger** *(acceptance criteria by area, at each version, against the intake)*:

| Area | Intake | 0.1 | 0.2 | 0.3 |
|---|---|---|---|---|
| A. The switch and what retires | in scope | 7 | 8 | 8 |
| B. Today | in scope | 9 | 11 | 11 |
| C. Crossing out | in scope | 6 | 7 | 7 |
| D. Quick capture | in scope | 5 | 7 | 7 |
| E. The session: shell, look-back | in scope | 12 | 14 | 14 |
| F. The session: look-ahead, next session | in scope | 9 | 9 | 9 |
| G. Return after a gap, and "from before" | in scope | 5 | 6 | 6 |
| H. The record | in scope | 5 | 5 | 5 |
| I. Language and fences | in scope | 6 | 6 | 6 |
| J. Failures | in scope (implied by convention #8) | — | 2 | 2 |
| **Total** | | **64** | **75** | **75** |

---

## Summary

The day gate retires (D-64): Today opens with nothing before it, lists the day in time order, and offers the session from the day it is due.
A checkbox anywhere in Tracker now **crosses an item out**: off my plate for today, a claim of nothing. An action becomes done only when the look-back answers **happened** (D-67, §2 #1).
A **session** every 2 to 7 days, at the person's spacing: look back (four answers), look ahead over the days to the next session, then when and where, with an optional calendar event (D-69, D-73).
**Quick capture** is a small modal from any screen: title, optional date (empty is today), optional time (D-70).
The **record** (answers per item per day, crossings, sessions, gaps, look-back times) is stored for the four-week test (D-68) and later patterns, and shown nowhere as a count.

## 1. What it is

### 1.1 Where the code stands (as-built)

- **The gate isn't enforced in code.** `getPreDayStatus` computes `afterDayRequired` and `canAccessToday` (`api/src/services/todayPreDayAfterDay.ts:69-137`, :97-99), but no client code reads `canAccessToday`, and no route redirects. `/today` always renders (`client/app/protectedRoutes.tsx:232-233`). Pre-day and After-day open only from the **Organize** and **Review** buttons on Today (`client/app/components/today/TodayPage.tsx:125-149`). What enforces D-5 is copy: the onboarding intros say Today is "locked" (`client/app/locales/en/common.json:995-1018`, :478). Retiring the gate is mostly retiring the wizards, the buttons and that copy.
- **Done** is one boolean flipped by `toggleAction` and nothing else (`api/src/graphql/resolvers/mutations.ts:910-917`). It is called from Today's rows and anywhere else `ActionPreview` renders (`client/app/components/actions/ActionPreview.tsx:200-212`), and from Focus (`client/app/components/focus/FocusCard.tsx:43`, `FocusPage.tsx:62`). Project and goal status are computed on the client from `done` (`ProjectPreview.tsx:57-77`, `GoalPreview.tsx:36-54`); nothing is stored.
- **Gathering** makes rows for today, +1 and +2 (`getGatheringDateKeys`, `api/src/services/actionGathering.ts:268-274`), on every Today mount (`TodayPage.tsx:79-89`) and at the end of After-day, under the per-user lock (`actionGathering.ts:334`, D-55, D-57).
- **Order on Today:** none. The server concatenates dated and gathered actions with no `orderBy` (`todayPreDayAfterDay.ts:43-65`); the client doesn't sort.
- **Fates:** `Postponed`, `OutsourceWoo`, `Backlog`, `BucketList`, `PassedArchived` (`api/prisma/schema.prisma:46-52`). Any fate keeps an action off Today (`todayPreDayAfterDay.ts:48`, :59). `postponeAction` moves the date and clears the fate (`mutations.ts:967-981`).
- **The estimate rule:** an action with a date must have an estimate, on the server (`validateEstimatedMinutes`, `mutations.ts:101-111`, :130-131, :208-209) and in four client forms (`ActionForm.tsx:212-236`, `TodayPage.tsx:54-59`, `focus/AddActionForm.tsx:38-49`, `ProjectPreview.tsx:238-242`).
- **Overlap** is computed for today's timed actions only, pairwise on start time and estimate (`todayPreDayAfterDay.ts:26-35`, :104-129), and drawn amber only inside Pre-day (`PreDayWizard.tsx:511`).
- **Today's date** is the client's local date key, `yyyy-MM-dd` (`client/app/utils/dateUtils.ts:16-18`), stored as UTC midnight on the server (`todayPreDayAfterDay.ts:11-13`), as Focus Periods do. No time zone is stored.
- **Per-user state** lives in `*State` singletons keyed by `userId` (`LoopState`, `ReflectState`, `NoticingState`, `schema.prisma:720`, :832, :952). There is no settings table.

### 1.2 What stage 1 builds

**A per-user rhythm state.** One row per user: the spacing (2 to 7 whole days), the switch date, the next session's due date, and whether "from before" has been offered. Created on the person's first visit after the deploy, which is their switch date [F, §2 #3].

**The session.** A short sequence of three steps, each saved as it is completed, resumable, never blocking anything:

1. **Look back** over the days since the previous session, up to yesterday. Each "ask me" item planned on those days gets one of four answers: **happened**, **partly**, **didn't happen**, **no longer matters**. Crossed items arrive pre-filled as happened.
2. **Look ahead** over the days from today to the next session. The next session's date sits at the top, pre-filled with today plus the spacing; changing it changes the days shown. Recurring items are already placed. Add, move and remove on each day.
3. **When and where.** The when (a time, optional) and where (a short text, optional) of the next session, then an optional **add to my calendar**. Completing this step completes the session.

(The draft's steps 2 and 3, what has gone quiet and the level check, belong to stages 3 and 4, and the next date moves to the head of the look-ahead, §2.2 #6.)

**The record.** For each action on each planned day: whether it was crossed out and when, the answer and when it was given, and the date it was first due. For each session: its start, the days its look-back covered, when the look-back started and finished, and when the session completed. For each gap: its dates and what was planned on its first day.

**Done.** An action is done when one of its day records has the answer **happened**, and not done otherwise [F, D-67]. Crossing out never sets it. Every rule that reads `done` (project and goal status, Focus progress) is unchanged; it simply moves at review.

### 1.3 What it isn't

No patterns, counts or totals are shown, anywhere (§7). No reminder is sent by Tracker (D-69). The draft's stages 2 to 7 are out (§7).

## 2. Decisions taken at spec

### 2.1 Asked of the founder, 2026-11-19

| # | Question | Answer [F] | Consequence |
|---|---|---|---|
| 1 | The done checkbox (`toggleAction`) is on Today, the project page, the actions list and Focus. Under D-67, what does it become? | **Crossing out, everywhere.** One gesture with one meaning. An undated item is placed on today when crossed. | `toggleAction` retires. Focus's and projects' progress moves only after each session. §4.3, AC-17 to AC-22 |
| 2 | The follow-ups to "didn't happen" in the look-back | **Three:** move to a day ahead, set it aside (`Backlog`), let it go (`PassedArchived`) | Outsource and bucket list leave the review flow. Old items keep their fates. §4.5, AC-34 |
| 3 | Who gets the rhythm at deploy | **Everyone at once**, the founder being production's only real user. Each account's switch date is its first visit after the deploy | One flow; no per-user flag. AC-1, AC-2 |
| 4 | An uncrossed item from an earlier day, between sessions | **Waits for the look-back.** Today shows today only; the item can be moved from its own page at any time | No backlog on the daily view. AC-10 |

### 2.2 Decided here, by Claude

Each with its reason. Refuse any on the diff if it's wrong.

1. **Spacing is whole days, 2 to 7, default 3.** A 2.5-day rhythm is lived as alternating 2 and 3 (draft §2), so the next date is always editable. 3 is the founder's paper rhythm rounded up. The spacing is changed in the session's look-ahead header, never in a settings page.
2. **"Usual spacing" is the last spacing used:** the gap in days between the session's date and the next date it set, when that is 2 to 7. The next session's date is pre-filled from it.
3. **The look-back covers** the days from the previous session's date to yesterday. The session's own day is reviewed by the next session. ~~The first session after the switch has nothing to look back over (D-72).~~ **[0.2]** The first session covers the switch date to yesterday (§2.3 #19).
4. **Answers are stored per action per planned day**, so an action moved to another day keeps the record of the day it was missed. "Done" is derived from those records (§1.2), and written to `Action.done` when an answer is given or changed, so every existing reader keeps working.
5. **"No longer matters"** sets the fate `PassedArchived`, not a delete, so the record survives. The draft's "removed" means removed from view.
6. **The next date is chosen at the head of the look-ahead**, not after it. The look-ahead's days depend on it, so it must come first. The when-and-where and the calendar event stay last.
7. **Gathering's horizon** is today through the later of today+2 and the day before the next session, capped at today+7. With no session due date yet, it stays today+2. It still runs on Today's mount and, newly, whenever the look-ahead's next date changes. The lock and the dedup key are unchanged.
8. **Order within a day:** timed items by start time; items at the same start time by an order the person sets by dragging, then by creation; untimed items after the timed ones, under "Any time", in their dragged order, then creation order. A dragged order on a gathered item is saved on its interval or routine too, so the next occurrences keep it.
9. **Crossing out a future-dated item** moves it to today and crosses it. Crossing is always about today. **[0.2]** A past-dated item likewise (§2.3 #23).
10. **Review settings on recurrence:** the setting lives on the action, and on its interval or routine. Gathering copies it to each new occurrence. "Don't ask" set in the look-back is also written to the source and to every occurrence already gathered ahead.
11. **"Just to know" items can't be crossed,** on the server as well as in the UI.
12. **A gap** is recorded when the look-back's range holds days older than today minus the spacing, and the person marks that block "not tracked". Its first and last dates, and the titles and ids of the "ask me" items planned on its first day, are stored. If they open the block and fill it in instead, no gap is stored; the session dates still show the interval.
13. **The calendar event is an `.ics` file,** built in the browser: one event titled "Tracker session" (localized), at the chosen time for 30 minutes, or all-day without one, with the where as its location. It holds no item data, so nothing personal leaves the app. No calendar-service links: they would send data to a third party.
14. **The capture key is `N`** (by physical key, so it works on a Persian layout), ignored while typing in a field. The add control sits in the app's top bar on every protected page.
15. **Retired in code:** the Organize and Review buttons, `PreDayWizard`, `AfterDayWizard`, the `preDayStatus` query and the `completePreDay` and `completeAfterDay` mutations, the "pre-day" and "after-day" module intros, and the unused `TodayActionRow.tsx` and `TodayActionWidget.tsx`. `DayState` stays: gathering still writes `actionGatheringCompletedAt`, and the two completion times stay as history (D-72). Fate mutations stay; the look-back reuses them.
16. **Overlap in stage 1** is shown, never resolved: the amber mark appears on Today's rows and on each look-ahead day, computed per day as today. Resolution is stage 2. Items without an estimate aren't checked (D-70).
17. **Persian terms** (D-20, informal), proposed for the founder to refuse in the journeys or on the diff: session **نشست**; cross out **خط زدن**; happened **انجام شد**; partly **نصفه انجام شد**; didn't happen **انجام نشد**; no longer matters **دیگه مهم نیست**; ask me **ازم بپرس**; don't ask **نپرس**; just to know **فقط برای اینکه بدونم**; from before **از قبل**; not tracked **ثبت نشده**; any time **هر وقت**.
18. **The opportunity tree:** the tree is drawn on a canvas (`ecosystem/ost.md` §6), and no node is named in the files. The module isn't placed; the founder places it (STATE.md question).

### 2.3 Decisions taken at the 0.2 revise

From `changes/01-req-journeys-gaps-and-review-pass-1.md`. Items 19 and 20 are the founder's, at journeys (`03-journeys.md` §1). The rest were settled by Claude during the founder's unattended run (`lifecycle/unattended.md`), each logged in `calls.md`, graded *proposal* and refusable on the diff.

19. **The first look-back** covers the switch date to yesterday; every later one, the previous completed session's date to yesterday [F, journeys §1 #1; S1]. AC-31.
20. **A session continued on a later day** stays the same session: its answers, its date and its look-back range are kept; the look-ahead, the next-date limits and the pre-fill count from the day it is continued [F, journeys §1 #2; S2]. AC-28, AC-31, AC-40.
21. **"From before" sits at the head of the first session's look-ahead,** under the next date. It counts as offered once it has been shown there; a session left before the look-ahead hasn't offered it (S3). AC-51, AC-52.
22. **The look-back's day picker** ("Place the rest", "move to a day ahead") offers today to the day before the pre-filled next date; a later change of the next date leaves placed items where they are (S4). AC-65.
23. **Crossing a past-dated item** moves it to today and crosses it; its first-due date is unchanged (S6). AC-19.
24. **Changing an answer restores the fate** the answer or its follow-up set: away from "no longer matters", or from "didn't happen" with set aside or let go, the action gets back the fate it had before; a move stays (S5). AC-66.
25. **"From the gap":** after **Not tracked**, the same session's look-ahead offers the gap's open items once, shaped like "From before" (S7). AC-67.
26. **Empty Today** is one quiet line, "Nothing on today."; the "Crossed out" fold is hidden when nothing is crossed (S8). AC-68.
27. **Failures are drawn:** every save shows "Not saved." and **Try again** where it failed, keeps what was entered, blocks nothing else, and uses no red; a failed load shows one line with **Try again** (S9, review P1-F6). AC-69, AC-70.
28. **Capture's date** is today onward or "No date yet"; the server refuses an earlier date from capture (S10). AC-71.
29. **A removed operation** called from a tab left open across the deploy shows "Tracker was updated. Reload" (S11). AC-72.
30. **On `/session`** the top bar is hidden; `N` still opens capture, and an item captured onto a shown look-ahead day appears there at once (S12). AC-73.
31. **A pre-filled "happened" counts:** when the look-back step completes, a crossed item whose pre-filled "happened" the person didn't change is recorded as happened (review P1-F1). AC-32, AC-38.
32. **"Done for now" is renamed "Skip the rest"** (fa: «بقیه رو رد کن»), because the skipped items are not asked again (review P1-F3). §4.5, AC-38.
33. **Uncrossing on the same day undoes the move** crossing made: the item returns to the date, or no date, it had before (review P1-F4). AC-18, AC-55.
34. **Move up and Move down** order a row without dragging, wherever drag-to-order is offered; a drop across start times is refused and the row returns, with no message (review P1-F14; WCAG 2.2 SC 2.5.7). AC-74.
35. **Focus and the project page** say, in one quiet line beside their progress, "Moves at your next session" while an item there is crossed and not done. The square control stays (W26) (review P1-F5, option *a line*). AC-75.
36. **Items the look-back leaves behind stay where they are** (unanswered after **Skip the rest**, or "didn't happen" with no follow-up): on their own day, visible on the project page and the actions list, and on no planning surface. No new block is added; `06-eval-plan.md` watches for them (review P1-F2, refused as a requirement).
37. **"Let them all go"** ("From before", "From the gap") has the same undo as remove (review P1-F7). AC-51, AC-67.

### 2.4 Decisions taken at the 0.3 revise

From `changes/02-req-session-saves-and-eval-measures.md`. Settled by Claude during the founder's unattended run, logged in `calls.md`, graded *proposal* and refusable on the diff.

38. **The session's own steps fail like every other save:** completing a step, **Confirm these**, **Skip the rest**, "Don't ask about this", the next date, when and where, and **Finish** show "Not saved." and **Try again**, and the session stays at the step that failed (journeys S13). §4.10, AC-69.
39. **M2 counts a filled-in return:** a stretch over 7 days that ended in a session whose old days were filled in, with no gap stored, is a recorded return (eval plan §6 #1).
40. **M3's typical value** is the median of unpaused look-backs; paused means finished on a later date than started, or over 30 minutes (eval plan §6 #2).
41. **M5** is read from the eval plan's paper-page instrument and the founder's day-28 questions (eval plan §6 #3).
42. **The record query** (AC-58) also computes the left-behind count of §2.3 #36 and the sessions started and not completed (eval plan §6 #4). Nothing new is stored.

## 3. Metrics

Measures only. `06-eval-plan.md` owns how each is read and the decision rules. M1 to M4 are D-68's gate [F].

| # | Measure | What it counts | Why |
|---|---|---|---|
| M1 | Sessions held | Completed sessions in the 28 days from the switch date (D-68: at least 8) | The rhythm holds, or doesn't |
| M2 | Longest stretch between sessions, and its gap record | Days between consecutive session dates; whether a stretch over 7 days ended in a session with a gap stored **[0.3]** or with its days filled in (D-68; §2.4 #39) | Return after absence is the failure the concept was written for |
| M3 | Look-back time | Finished minus started, per session, from the stored times; the typical value against five minutes (D-68). **[0.3]** The typical value is the median of unpaused look-backs; a look-back is paused when it finished on a later date than it started, or took over 30 minutes (§2.4 #40) | A long look-back becomes the next ritual to avoid (draft §5) |
| M4 | Crossing out as obligation | The founder's own judgement, asked once at the end of the four weeks (D-68) | Cause 2 of draft §1 |
| M5 | The drop rule | The founder's own account, at the end of the four weeks, of whether they planned on paper because it was easier than the app (intake §6). Not readable from the record. **[0.3]** Made testable by `06-eval-plan.md` §3.B and §3.C, the dated paper pages (§2.4 #41) | The intake's drop rule |
| M6 | Days with a crossing | Days in the four weeks with at least one item crossed out | The daily skim the founder described (D-69), as far as the record can see it |

## 4. Interface requirements

Every string is a key in `en` and `fa` (convention #7). No red, no counts of items or days, no progress bars on any surface below (§4.9).

### 4.1 Today

- **Opens with nothing before it.** No Organize or Review button, no wizard, no locked state (D-64).
- **The session line,** one quiet line under the date, never a pop-up:
  - before the due date: "Next session: Thursday 21 November" and a **Start now** link;
  - from the due date: "Session due today" or, once past, "Session was due Thursday 21 November", and **Start**. Never "3 days late" or any number of days;
  - with a session in progress: "Session in progress" and **Continue**;
  - before the first session (just switched): "Plan your next days" and **Start**.
- **The list:** today's actions that have no fate, in the order of §2.2 #8, timed items first, then "Any time". Crossed items move to a "Crossed out" fold at the foot, closed by default; uncrossing returns an item to its place.
- **Each row:** the title, the time or nothing, the amber overlap mark where it applies (§2.2 #16), the project or source as today, and the cross-out control. "Just to know" items show without the control and read as such.
- **Drag to order** within the same start time, and within "Any time". Dragging never changes a time. **[0.2]** Each row also offers **Move up** and **Move down**; a drop across start times is refused and the row slides back (§2.3 #34).
- **[0.2] Empty:** with no items, one quiet line, "Nothing on today." (§2.3 #26).
- **Earlier days' items don't appear** [F, §2.1 #4].
- **Gathering** runs on mount as today, with the horizon of §2.2 #7.

### 4.2 Quick capture

- **Opens** from the add control in the top bar of every protected page, or with `N` (§2.2 #14). Escape or a click outside closes it without saving.
- **Fields:** title (required, trimmed, 1 to 200 characters); date (empty means today; a "No date yet" choice clears it; **[0.2]** no day before today, §2.3 #28); time (optional, `HH:mm`). Nothing else [F, D-70].
- **Enter saves** and closes, with a short confirmation naming the day ("Added to today", "Added to Friday", "Added, no date"). The item is a standalone action, "ask me".
- **Keyboard:** the title has focus on open; Tab reaches date, time and save; the modal traps focus and restores it on close.

### 4.3 Crossing out, everywhere

- **The gesture** replaces the done checkbox on Today, the project page, the actions list and Focus [F, §2.1 #1]. One click strikes the title through with a short animation; on Today the row then moves to the fold. Clicking again restores it. With reduced motion, no animation.
- **It records** a crossing on the action for today (§4.8); it never sets `done`. A future-dated item moves to today first; an undated item is placed on today (§2.2 #9).
- **Where the control sits on a row that is also a link,** the control wins: crossing never opens the item.
- **Focus and project progress** read `done` as before, so they move at review. Their "done" labels and counts are unchanged code; the change is when `done` moves. **[0.2]** One quiet line beside that progress says "Moves at your next session" while an item there is crossed and not done (§2.3 #35).
- **[0.2] Uncrossing on the same day** returns an item that crossing moved to the date, or no date, it had before (§2.3 #33).

### 4.4 The session: shell

- **Its own route**, `/session`, full width, no other navigation competing in the page (**[0.2]** the top bar is hidden; `N` still opens capture, §2.3 #30): a step header (Look back · Look ahead · When and where) showing the current step, and an exit that returns to Today and keeps everything answered so far.
- **Resumable:** every answer and change is saved as it is made (convention #8). Reopening goes to the first step not completed.
- **One session open at a time.** Starting when one is open continues it.
- **Late blocks nothing** (draft §2): Today and every other page work with a session due or in progress.

### 4.5 Look back

- **The range** is §2.2 #3, with §2.3 #19 and #20. With nothing to ask about, the step says so in a line and offers Continue.
- **Crossed first:** every crossed "ask me" item in the range is listed under "Crossed out", pre-filled **happened**, grouped by day; **Confirm these** confirms the group in one tap. Tapping one opens its four answers.
- **Then the rest,** grouped by day, oldest first: each uncrossed "ask me" item with its four answers as one row of choices.
- **Follow-ups,** inline under the answer, all optional:
  - **happened:** none;
  - **partly:** "Place the rest", a day picker over the look-ahead's days (**[0.2]** today to the day before the pre-filled next date, §2.3 #22); picking one moves the action there;
  - **didn't happen:** move to a day ahead (the same picker), set it aside (`Backlog`), or let it go (`PassedArchived`) [F, §2.1 #2]. With no follow-up, the action stays on its day;
  - **no longer matters:** none; the item leaves the list (§2.2 #5).
- **Stop asking:** each row has "Don't ask about this", one tap, applied as §2.2 #10, with an undo for a few seconds.
- **An answer can be changed** until the session completes; changing away from happened clears `done` unless another day says happened. **[0.2]** Changing away from a fate-setting answer restores the fate (§2.3 #24).
- **The step is complete** when every item in the range has an answer, or when the person taps **Skip the rest** (**[0.2]** was "Done for now", §2.3 #32), which leaves unanswered items unanswered and moves on. Crossed items still pre-filled "happened" are recorded as happened when the step completes (§2.3 #31). Unanswered items are not asked again by a later session, and stay on their day (§2.3 #36).

### 4.6 Look ahead

- **Its own screen**, not a mode of Calendar [F, D-73]. Its head holds the next session's date, a date picker limited to today+2 to today+7, pre-filled with today plus the usual spacing (§2.2 #1, #2).
- **The days** from today to the day before the next session, each as a list in Today's order, recurring items already placed (gathered for those days, §2.2 #7). Time Theme bands are drawn where a day has them, reusing Calendar's band component.
- **On each day:** add (the capture fields, with the day fixed), move an item to another of these days or out of them, remove (`PassedArchived`, with undo), and set a time. Drag-to-order as on Today.
- **Undated items** (no date, no fate) are listed above the days as "No date yet", each with "Place on…" over the same days. They are never counted.
- **Overlaps** show amber per day (§2.2 #16); nothing asks to resolve them.
- **[0.2] "From before" and "From the gap"** sit at the head of the look-ahead, under the next date (§2.3 #21, #25), each with "Let them all go" and its undo (§2.3 #37).

### 4.7 When and where, and the calendar event

- Two optional fields: **when** (a time) and **where** (up to 80 characters), with the prompt "When and where will you sit down for it?" (draft §10 point 2).
- **Add to my calendar** downloads the `.ics` of §2.2 #13. It can be skipped.
- **Finish** completes the session and returns to Today, whose line now reads "Next session: …".

### 4.8 Item settings

- **Review setting** on the action form, the interval form and the routine form: **Ask me** (default), **Don't ask**, **Just to know**, with one line of help each [F, D-71].
- **No estimate required** with a date, in every form and on the server [F, D-70]. A start time is no longer required for today either (`ActionForm.tsx:230-236`, `TodayPage.tsx:54-59`).

### 4.9 Fences on every surface

No "x of y", no progress bar, no daily total, no streak, no colour for a finished day, no count of days late or of items waiting, and no red, on Today, the session or the capture modal (draft §3, §7). The look-back shows the record of the days it covers and nothing summed across them.

### 4.10 Failures *(0.2)*

- **A failed save** anywhere in this module (an answer, a crossing on any surface, a capture, a look-ahead edit, a "From before" or "From the gap" choice, **[0.3]** and the session's own steps of §2.4 #38) shows "Not saved." and **Try again** on that row or in the modal, in amber, keeps what was entered on screen, and blocks nothing else (§2.3 #27).
- **A failed load** of Today, `/session` or the look-ahead's gathering shows one line and **Try again** in place of the list.
- **A removed operation** called from an old tab shows "Tracker was updated. Reload" (§2.3 #29).

## 5. Risks

| # | Risk | Why it matters | Mitigation |
|---|---|---|---|
| R1 | **The look-back grows past five minutes** | It becomes the next ritual to avoid (draft §5); M3 fails | Crossed items confirmed in one tap; one-tap "don't ask"; **Skip the rest**; the older block collapsed into one "not tracked" tap. M3 is read from stored times, so it is seen, not guessed |
| R2 | **Done moves only at review,** so Focus and project progress lag up to seven days | Focus is the piece the founder uses (draft §8) | Accepted [F, D-67]. Crossed state shows on Focus rows, so what was cleared today is still visible |
| R3 | **Retiring `toggleAction` breaks tests** that pin it | `actions.integration.test.ts` ("toggleAction marks action done then undone", :124), `client/e2e/today.spec.ts` (:24 Organize/Review, :58 toggle), `ActionPreview.test.tsx` (:105), `FocusPage.test.tsx` (:235) | Each is a test that changes on purpose; the build plan lists them per stage |
| R4 | **Gathering's horizon widens** to seven days | Duplicate-gather races were a real defect (D-55); recurrence edits must regather more days | The lock and dedup key stay (`actionGathering.ts:291-303`, :334); the skip rule already regathers a date when a source changed after it (:376-408). Tests pin "today, +1, +2" (`gathering.integration.test.ts:33`, `recurrence.unit.test.ts:32`) and change on purpose |
| R5 | **Date keys come from the client** | A session started near midnight or after travel can land on the wrong day | Same rule as Focus Periods and Today: the client sends its local date key. Accepted for a single-user test; noted for stage 6 |
| R6 | **The record is a new table with one row per action per day** | It grows with recurring items; the look-back reads ranges of it | Indexed on `(userId, dateKey)`; a row is written only when an item is crossed or answered, never for every gathered item |
| R7 | **"Don't ask" written onto a recurrence** reaches occurrences already gathered | A missed propagation keeps asking about something the person stopped | §2.2 #10 names both writes; an API test pins it |
| R8 | **Stale copy that says Today is locked** | It contradicts the new rhythm in two languages | The intros and the Concepts page's day-state section are rewritten or retired in the same stage that removes the wizards (`common.json:995-1018`, :900-907; `ConceptsPage.tsx:125-134`) |
| R9 | **Schema change** (new state, session, day-record and gap tables; review setting and order fields) | Convention #12: the data model doc changes in the same commit | `build-plan` assigns it; `close-out` folds it into `tracker/canon/02-architecture/01-data-model.md` |

## 6. Acceptance criteria

### 6.1 The switch and what retires

- **AC-1.** On a user's first authenticated visit after the deploy, a rhythm state is created with the switch date set to the client's date key and spacing 3; later visits don't change the switch date.
- **AC-2.** Every account gets the new flow; there is no per-user flag [F, §2.1 #3].
- **AC-3.** Today has no Organize or Review button, and no route or component renders `PreDayWizard` or `AfterDayWizard`; both files are deleted.
- **AC-4.** The `preDayStatus` query and the `completePreDay` and `completeAfterDay` mutations are removed from the schema and the client's queries.
- **AC-5.** Existing `DayState` rows are untouched by the migration and by any new code path; gathering still writes `actionGatheringCompletedAt`.
- **AC-6.** No existing action, goal, project, interval or routine is deleted or changed by the migration, apart from new fields taking their defaults.
- **AC-7.** The "pre-day" and "after-day" module intros no longer show; the "today" intro and the Concepts page no longer say Today is locked, in `en` and `fa`.
- **AC-72.** *(0.2)* A call from an open tab to an operation removed by AC-4 or AC-17 shows "Tracker was updated. Reload" in place of the raw error, and writes nothing.

### 6.2 Today

- **AC-8.** `/today` renders the day's list with no step before it, whatever the state of any session.
- **AC-9.** Today lists today's actions with no fate: timed items in start-time order, ties by dragged order then creation, then "Any time" items by dragged order then creation.
- **AC-10.** An uncrossed action dated before today does not appear on Today [F, §2.1 #4].
- **AC-11.** Dragging an item among items at the same start time, or within "Any time", persists its order across reloads and never changes its time.
- **AC-74.** *(0.2)* Every list ordered by dragging (Today, each look-ahead day) also offers **Move up** and **Move down** on each row, with the same effect as a drag; a drop across start times is refused and the row returns to its place, with no message.
- **AC-12.** A dragged order on a gathered item is kept on its source, and the next occurrence of the same source sits in the same place.
- **AC-13.** The session line shows the next date before it is due, "due today" on the due date, "was due <date>" after it, "in progress" with Continue when a session is open, and never a number of days.
- **AC-14.** Crossed items sit in a closed "Crossed out" fold at the foot of the list and return to their place when uncrossed.
- **AC-15.** The amber overlap mark shows on timed rows whose start time and estimate overlap another's; rows without an estimate are never marked.
- **AC-16.** A "just to know" item shows on Today with no cross-out control.
- **AC-68.** *(0.2)* Today with no items shows one quiet line, "Nothing on today.", and no illustration or button; the "Crossed out" fold is hidden when nothing is crossed.

### 6.3 Crossing out

- **AC-17.** The cross-out control replaces the done checkbox on Today, the project page, the actions list and Focus; `toggleAction` is removed from the API and the client.
- **AC-18.** Crossing an item writes a crossing for that action and today's date key; uncrossing removes it. **[0.2]** Uncrossing on the same day returns an item that the crossing moved to the date, or no date, it had before. Neither changes `Action.done`.
- **AC-19.** Crossing a future-dated **[0.2] or past-dated** item moves it to today and crosses it; crossing an undated item places it on today and crosses it. **[0.2]** The first-due date (AC-54) is unchanged.
- **AC-20.** The server refuses to cross a "just to know" item, and refuses an action the user doesn't own.
- **AC-21.** On a row that is also a link, activating the cross-out control never navigates.
- **AC-22.** With `prefers-reduced-motion`, crossing has no animation.
- **AC-75.** *(0.2)* While an item on Focus or a project page is crossed and not done, one quiet line beside its progress reads "Moves at your next session"; it shows no number.

### 6.4 Quick capture

- **AC-23.** The add control is present in the top bar of every protected page, and `N` opens the modal except while focus is in a text field; it works on a Persian keyboard layout.
- **AC-24.** The modal saves with only a title; an empty date saves the action on today; "No date yet" saves it with no date; a time is optional.
- **AC-25.** A title that is empty after trimming, or over 200 characters, is refused with a message; nothing is saved.
- **AC-26.** No form and no resolver requires an estimate on a dated action, or a start time on today's (`addAction`, `updateAction`, `addProject`, and the four client forms).
- **AC-27.** The modal traps focus, starts on the title, closes on Escape without saving, and returns focus where it was.
- **AC-71.** *(0.2)* Capture's date offers today onward and "No date yet"; the server refuses a date before today from capture.
- **AC-73.** *(0.2)* On `/session` the top bar is hidden and `N` still opens capture; an item captured onto a day the look-ahead shows appears on that day at once.

### 6.5 The session: shell and look-back

- **AC-28.** `/session` opens at the first step not completed; with no open session it starts one, dated with the client's date key. **[0.2]** A session continued on a later day keeps its date, its answers and its look-back range; its look-ahead, next-date limits and pre-fill count from the day it is continued.
- **AC-29.** At most one session per user is open; starting while one is open continues it.
- **AC-30.** Every answer, move and setting in the session is saved when made; leaving and reopening shows it.
- **AC-31.** The look-back covers the days from the previous completed session's date to yesterday, **[0.2]** or from the switch date to yesterday when there is none, and only "ask me" actions planned on those days and not already answered. **[0.2]** Its range is fixed when the session starts (AC-28).
- **AC-32.** Crossed items in range arrive pre-filled "happened", grouped by day, and **Confirm these** records happened for all of them in one action. **[0.2]** When the step completes, any pre-filled "happened" the person didn't change is recorded as happened.
- **AC-33.** Each item can be answered happened, partly, didn't happen or no longer matters; the answer is stored for that action and that day.
- **AC-34.** "Didn't happen" offers move to a day ahead, set aside (fate `Backlog`) and let go (fate `PassedArchived`), all optional; "partly" offers place the rest; moving keeps the earlier day's record.
- **AC-35.** "No longer matters" sets the fate `PassedArchived` and asks nothing further.
- **AC-36.** `Action.done` is true exactly when one of the action's day records says happened; changing an answer away from happened clears it unless another day says happened.
- **AC-37.** "Don't ask about this" on an item sets it, and for a gathered item sets its source and every occurrence already gathered after today; that item and those occurrences are not asked about again.
- **AC-38.** **Skip the rest** *(0.2; was "Done for now")* completes the look-back step with the uncrossed items left unanswered (crossed ones count as AC-32 says); a later session doesn't ask about them, and they stay on their day.
- **AC-39.** The look-back's start time is stored when the step first opens and its finish time when the step completes.
- **AC-65.** *(0.2)* "Place the rest" and "move to a day ahead" offer today to the day before the pre-filled next date; changing the next date later leaves placed items where they are.
- **AC-66.** *(0.2)* Changing an answer away from "no longer matters", or away from "didn't happen" with set aside or let go, restores the fate the action had before; a move made by a follow-up stays.

### 6.6 The session: look-ahead and next session

- **AC-40.** The look-ahead's head shows the next date, pre-filled with today plus the usual spacing (§2.2 #2), and accepts only today+2 to today+7, **[0.2]** "today" being the day the session is continued (AC-28).
- **AC-41.** Changing the next date changes the days shown, and gathers recurring items for any newly shown day.
- **AC-42.** Each day lists its actions in Today's order, with recurring items placed and Time Theme bands drawn where they apply.
- **AC-43.** On a look-ahead day, an item can be added, moved to another shown day or off them, removed (fate `PassedArchived`, with undo) and given a time.
- **AC-44.** Undated actions with no fate are listed as "No date yet", each placeable on a shown day, with no count.
- **AC-45.** Overlaps are marked amber per day, and nothing in the step requires resolving them.
- **AC-46.** The last step takes an optional time and an optional place (at most 80 characters), and **Finish** completes the session, sets the next due date, and returns to Today.
- **AC-47.** **Add to my calendar** downloads a valid single-event `.ics` for the next session (timed for 30 minutes, or all-day with no time), titled in the person's language, with the place as location and no item data.
- **AC-48.** Gathering's horizon is today through the later of today+2 and the day before the next due date, at most today+7; without a due date it is today+2.

### 6.7 Return after a gap, and "from before"

- **AC-49.** When the look-back's range holds days older than today minus the spacing, those days collapse into one block at the top, "<first date> – <last date>", with **Not tracked** and **Fill in**.
- **AC-50.** **Not tracked** stores a gap with its first and last dates and the ids and titles of the "ask me" items planned on its first day, and removes those days from the look-back; **Fill in** opens them as ordinary days and stores no gap.
- **AC-51.** The first session after the switch offers "From before" once, **[0.2]** at the head of its look-ahead under the next date: open actions dated before the switch date, with no fate and not done, each keepable (placed on a look-ahead day) or all let go in one tap (fate `PassedArchived`, **[0.2]** with undo), or the block left as it is.
- **AC-52.** Once offered, "From before" is not offered again, whatever was chosen, and leaving it untouched changes no action. **[0.2]** It is offered once it has been shown in the look-ahead; a session left before the look-ahead hasn't offered it.
- **AC-53.** A session late by any amount blocks nothing: every page works, and Today shows only the line of AC-13.
- **AC-67.** *(0.2)* After **Not tracked**, the same session's look-ahead offers the gap's open actions (no fate, not done) once, as "From the gap": each keepable onto a shown day, all let go in one tap with undo, or left as they are; once shown, it is not offered again.

### 6.8 The record

- **AC-54.** Each action stores the date it was first due, set when it first gets a date and never changed by a move.
- **AC-55.** A day record holds the action, the date key, when it was crossed (or nothing), **[0.2]** the date the crossing moved it from (or nothing), its answer (or nothing) and when it was answered; there is at most one per action per day.
- **AC-56.** Each session stores its start, the first and last days its look-back covered, the look-back's start and finish, the next due date, when, where, and when it completed.
- **AC-57.** Each gap stores its first and last dates and the planned items of AC-50, and the session it was recorded in.
- **AC-58.** M1 to M3 and M6 (§3) can be computed for any 28-day window from these tables alone, by a query the eval plan names. **[0.3]** The same query computes the actions a look-back left on a past day with no fate (§2.3 #36) and the sessions started and not completed.

### 6.9 Language and fences

- **AC-59.** Every new string exists in `en` and `fa`; `npm run i18n:check-missing` and `i18n:check-hardcoded` pass.
- **AC-60.** The Persian terms of §2.2 #17 are used unless the founder replaced them before the build; Persian is informal (D-20).
- **AC-61.** Today, the session and the capture modal show no count of items or days, no progress bar, no daily total and no streak.
- **AC-62.** No new surface uses red; the overlap mark stays amber.
- **AC-63.** Every new resolver uses `requireAuth` and `ensureOwned` (convention #1); a user can't read or write another user's sessions, day records or gaps.
- **AC-64.** The session, the capture modal and Today work in RTL with no mirrored-icon or bidi defects, checked in `fa` in a browser.

### 6.10 Failures *(0.2)*

- **AC-69.** A failed save of an answer, a crossing (on any surface), a capture, a look-ahead edit, a "From before" or "From the gap" choice, **[0.3]** or a session step (completing a step, **Confirm these**, **Skip the rest**, "Don't ask about this", the next date, when and where, **Finish**, which then leaves the session at that step) shows "Not saved." and **Try again** on that row or in the modal, keeps what was entered on screen, leaves every other control working, and uses no red.
- **AC-70.** A failed load of Today, `/session` or the look-ahead's gathering shows one line with **Try again** in place of the list, and no red.

## 7. Out of scope

- **The draft's stages 2 to 7:** part-of-day timing; clash resolution, "during", recurring clashes and the multi-day pass; one-off deep-work blocks (D-76); closing goals three ways; carried, gone quiet and away; the one-time frame; renaming "Ignored" to "Date passed"; level checks (D-66); the dashboard; requirements and tension (D-77, D-78); roles, switches per user and the first-session onboarding; every pattern view, including per-item counts (D-65).
- **Galaxy** (`../04-galaxy/`), after this module's four-week gate.
- **Any reminder Tracker sends:** email, push, a server schedule (D-69).
- **Showing the record** as anything but the look-back's own days: no history page, no chart.
- **Focus Periods' ties to the session** (draft §8): its actions offered first in the look-ahead, and its look-back inside the session. Stage 1 changes only its checkbox.
- **Outsource and bucket list** in the look-back (§2.1 #2). They stay in the data, and stay on old items.
- **Time zones** stored per user (R5).
- **Calendar** as a page: unchanged, apart from the shared checkbox.

## Changelog

- **0.3 · 2026-11-19** — `revise`, `changes/02-req-session-saves-and-eval-measures.md`: journeys S13 (the session's own saves fail visibly) and the eval plan's §6 items 1 to 4 (M2, M3, M5, AC-58), as §2.4 #38 to #42; AC-58 and AC-69 amended; §3 M2, M3, M5. No new criteria. Claude's calls in the unattended run, logged in `calls.md`.
- **0.2 · 2026-11-19** — `revise`, `changes/01-req-journeys-gaps-and-review-pass-1.md`: the journeys' Suggested S1 to S12 and the UX review's pass 1 (P1-F1 to F7, F14) written in as §2.3 #19 to #37, §4.10 and AC-65 to AC-75; AC-18, AC-19, AC-28, AC-31, AC-32, AC-38, AC-40, AC-51, AC-52 and AC-55 amended; "Done for now" renamed "Skip the rest". S1 and S2 are the founder's (journeys §1); the rest were settled by Claude during the founder's unattended run and are logged in `calls.md`. New area J (failures). 64 → 75 criteria.
- **0.1 · 2026-11-19** — Spec, from `00-intake.md` (research waived there) and `../../drafts/session-rhythm.md` 0.3-draft with D-63 to D-78. Four questions asked at spec (§2.1), eighteen settled by Claude (§2.2). Code read at `rishe-eco/tracker` `main @ eea1c59`; the main finding is that D-5's gate was never enforced in code (§1.1). Written by Claude (Opus 5.5) following `spec`'s steps by hand.

## References

- `00-intake.md`; `../../drafts/session-rhythm.md` 0.3-draft; `../../decisions/decision-log.md` D-5, D-20, D-54, D-55, D-57, D-61, D-63 to D-78
- `../../canon/02-architecture/04-conventions.md` (conventions #1, #7, #8, #12)
- `../../../ecosystem/working/journey-build/05-failure-and-ignoring.md` 0.1 (moments and fences, for stage 3)
- `rishe-eco/tracker` at `main @ eea1c59`: the files cited in §1.1, §4 and §5
