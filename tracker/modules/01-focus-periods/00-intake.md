# Focus Periods — intake

*Module `tracker/modules/01-focus-periods/` · Track: Module · Phase 0 · 2026-10-20 · Owner: _root*

**Status of this page:** the founder's description, as given. Claims are **proposal** unless marked otherwise. No sources, no research.

---

## 1. Problem

I decide on a stretch of time in which I want to get a certain set of projects done. During that stretch there is no single place to see just those projects: how far each one has come, what its next actions are, and do small bits of management on them. The Projects list shows everything, and Today shows actions without their projects around them.

*Changed 2026-10-20, after the spec's 0.2: the founder moved this from goals to projects.*

## 2. Pillar

Organize. Tracker is Organize's app, and this is a view over its tree of intent (goals → milestones → projects → actions).

## 3. Place on the opportunity tree

Not placed yet. `spec` assigns the node in `ecosystem/ost.md`.

## 4. Who it is for

Someone who already plans projects in Tracker and, from time to time, commits to a short list of them for a bounded stretch of time. They want to keep those projects in view and keep each one moving, without going back through the whole tree.

## 5. Smallest version worth trying

- **A Focus Period** is a new object: a name, a start date, an end date, and a hand-picked list of the projects to be done in it. **One active at a time.** A period whose dates overlap an existing one is rejected.
- **Its own page**, as a top-level nav tab ("Focus"), next to Today and Calendar.
- **Header:** the period's dates and the days left. **No "N of M done" tally.**
- **Per project:** actions done out of total ("5 of 8"), with the project's goal and milestone as context.
- **Next actions per project:** its soonest undone actions, automatically. Nothing extra to maintain.
- **Management on the page:** add or remove projects from the period, complete a next action, add an action to a project, and reschedule a next action.
- **When a period ends:** one look-back screen listing which projects finished and which didn't, with "carry into a new period" for each unfinished project. No grade, no score.

**Out of scope:**
- Several periods at once, or overlapping periods.
- Any period-level tally or score ("2 of 5 done").
- Reminders, notifications, or anything on Today about the period.
- Recurrence. A period is one-off; Time Themes already cover recurring spans.
- Goals in a period. The founder chose projects only.
- Editing projects, milestones or goals themselves from this page. That stays on their own pages.

## 6. What would make us drop it

> Drop if the days-left header makes you feel behind rather than oriented.

**Testable:** not as written. It's a self-report with no instrument yet. `eval-plan` names one, for example a one-line "oriented or behind?" check on the look-back screen. This is the progress-policy test (ecosystem decision-log, 2026-07-29) applied to this surface: remove the marker, and is there still a reason to act?

## Decisions made at intake

| Decision | Answer |
|---|---|
| Track | Module |
| Research | waived (proposal): a view over existing data plus one small object; the policy question is already settled canon |
| Code repo | `E:\_root\tracker` |
| Phases that apply | all |
| Project | tracker |
