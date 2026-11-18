# Tracker — The session rhythm (concept and build plan)

*Draft. Not yet canon. A concept and a staged build plan, not a spec: each stage needs its own spec, through the lifecycle method, before code. When a stage lands, fold it into `../canon/01-product/`, `../canon/02-architecture/01-data-model.md` and a `../decisions/decision-log.md` entry. Reuses two Journey specs: `../../ecosystem/working/journey-build/03-batteries-check.md` and `05-failure-and-ignoring.md`. Update the changelog; don't fork.*

**Version 0.1-draft · Status: concept (nothing built; four decisions open, §12) · 2026-11-16 · Owner: _root**

---

Tracker goes back to its first purpose: a personal place to follow a goal until it is real and to see how you pursue and drop things. The daily gate retires. A planning and review session every 2 to 7 days replaces it, and the day in between is a light list.

## Summary

- **The rhythm changes.** Pre-day and After-day stop being gates. A session at a spacing the person chooses (2 to 7 days) looks back, then sets up the days ahead.
- **The day is light.** Items can be crossed out to clear them from view. Crossing out is not a record and nothing is counted.
- **The record is made at review.** For each item the person says what happened. Patterns are read from that, and from gaps.
- **Three things are added on top:** level checks with an immediate action, a short read when a goal goes quiet or fails, and a dashboard over chosen goals.
- **Two specs already exist** for the level checks and the failure read, written on 2026-10-18 for Journey. This concept reuses them and changes two of their rules; both changes are named below.

This is a concept and a plan, not a spec. Each stage in the build plan still needs its own spec before code. Sources: the founder's account in conversation on 2026-11-16, and a read of the `tracker` and `root-sot` repositories the same day. The app was not run.

## 1. The need, and why the current shape failed

The need has not changed since the app began: follow a goal until it becomes real, see the patterns in how it is pursued and dropped, and handle problems, mistakes and failures instead of leaving quietly.

The founder is Tracker's first user and has repeatedly stopped using it. Four causes are visible. The first three come from the founder's account; the fourth is from the canon.

| Cause | What happens today | What this concept does |
| --- | --- | --- |
| **The rhythm is wrong** | A ritual is required every day, and yesterday's must be closed before today opens. The founder's working rhythm on paper was a session about every 2.5 days. | Sessions every 2 to 7 days; no gates (section 2) |
| **Ticking feels like obligation** | Marking an action done is the only way to record it. The founder feels they have to, then doesn't want to. | Crossing out is separated from the record (sections 3 and 5) |
| **Coming back has a cost** | After missed days, the missed ritual stands between the person and today. | Return starts from today; the gap is one tap (section 2) |
| **It cannot say why you left** | Only completion is stored. A goal going quiet leaves no trace. The Organize pillar calls seeing your own patterns its leverage point, and it is not built. | The review record, gaps and the quiet-goal read (sections 5 and 7) |

Part of the leaving is unexplained: the founder also simply stopped going back and does not know why. The concept does not depend on knowing. It makes return free and records the gap, so the next absence leaves evidence.

## 2. The rhythm: sessions

The session is the one ritual Tracker asks for. It replaces both Pre-day and After-day, and nothing in the app is locked behind it.

```
Session ──▶ Day · Day · Day ──▶ Session
(5 steps)   look, add, cross out
            2 to 7 days, chosen by the person
```

**Spacing.** The person chooses how far apart sessions are, from 2 to 7 days. Each session ends by setting the date of the next one, pre-filled with their usual spacing. That lets a 2.5-day rhythm be lived as alternating 2 and 3.

**What a session contains, in order:**

1. **Look back.** Every item planned since the last session, grouped by day. The person says what happened to each (section 5).
2. **What keeps moving, and what has gone quiet.** Items carried a long time and goals with nothing done or planned are raised here, with the short read (section 7).
3. **Level check,** if one is due (section 6).
4. **Look ahead.** The days until the next session, with recurring items already placed. The person adds, moves and removes items, and resolves time clashes across all those days in one pass (section 4).
5. **Next session date.**

**A session that is late blocks nothing.** The daily list keeps working, because recurring items are generated ahead regardless. One quiet line shows the date the session was due. It is never a count of days late.

**Coming back after a gap costs nothing.** The session starts from today. Days older than the person's spacing are offered as one block, marked "not tracked" in a single tap, or opened to fill in if they want to. The gap itself is stored: its dates and what was planned when it began.

**A session can be done in parts.** Each step saves as it is completed, so it can be left and resumed.

## 3. The daily view

The day is a list to look at, opened at any time with no step before it.

- **Crossing out.** Clicking an item strikes it through with a short animation and moves it out of the remaining list. It means "off my plate for today", so what is left is easy to see. Clicking again restores it.
- **Crossing out is not the record.** It makes no claim that the thing was done. At the next session a crossed item arrives pre-filled as "happened" and is still confirmed there.
- **No counts.** No "4 of 7", no progress bar, no daily total, no colour for a finished day. Any of these would turn crossing out back into ticking.
- **Know-only items.** An item can be set as "just to know". It shows in the day, cannot be crossed, and is not asked about at review.
- **Adding is always open.** An item can be added to today or to any later day from the daily view, without waiting for a session.
- **Order.** Items are listed in time order by the rules in section 4.

## 4. Time: order and overlaps

Most overlaps in the founder's use came from two or three recurring items set to the same hour, which then appeared at that hour in no reliable order. Some overlaps were intended: one task done in the middle of another. The rules below treat those two cases differently.

**Two kinds of timing.** An item has either a clock time or a part of the day (morning, afternoon, evening). Only things that happen at a fixed hour need a clock time. Items with a part of the day cannot overlap.

**Order within a day.** The list is sorted by:

1. start time, with part-of-day items placed at the head of their part;
2. for items at the same time, an order the person sets once by dragging. For recurring items that order is kept, so the same three routines appear in the same sequence every time;
3. where no order was set, the order in which the items were created.

**Overlaps are handled in the session's look-ahead,** for all its days together:

- **One decision per clash.** The two items are shown side by side. The person picks which keeps its time. The other is offered the next free slot, with "another day" as the alternative.
- **"During" is a valid answer.** The person can mark one item as happening during the other. It is then shown nested under it and never flagged again.
- **Recurring clashes are settled once.** When two recurring items clash, the choice (move one, order them, or nest one) is saved on the recurrence, so it does not come back at every session.
- **A warning, never a block.** An unresolved clash can be left as it is. This matches the current rule.

Today overlap detection works one day at a time, on actions with a start time and an estimate, and only flags the clash in amber. Resolution, ordering and the multi-day pass are new.

## 5. The record and patterns

The record is made in the session's look-back, after the fact, and it is the only source patterns are read from.

**What the person says about each item:**

| Answer | Meaning | What follows |
| --- | --- | --- |
| **Happened** | It was done | Nothing |
| **Partly** | Some of it was done | Optionally place the rest in the look-ahead |
| **Didn't happen** | It was not done | Move it to a day ahead, set it aside, or let it go |
| **No longer matters** | It should not have been there, or stopped being relevant | Removed, with no follow-up question |

**Keeping the look-back cheap.** Crossed items are pre-filled as "happened" and confirmed together in one step, with a tap on any that need a different answer. The person's attention goes to the uncrossed items. If the look-back takes longer than a few minutes it becomes the next ritual to avoid, so its length is something to watch in use.

**What is stored:**

- for each item on each planned day: the answer, whether it was crossed out that day, and the date it was first due;
- for each session: its date and the days it covered;
- for each gap: its start and end dates and what was planned when it began.

**Patterns.** Three kinds are worth showing first, because each already has a defined response in section 7:

1. a recurring item that keeps not happening;
2. an item that keeps being moved;
3. a goal with nothing done and nothing planned.

A fourth is new and is the one the founder most needs: **what was on the plate when a gap began.**

**Where patterns appear.** Only in the session look-back and on the item's or goal's own page, as a plain dated observation followed by a question. Example: "Evening walk has not happened on its last four planned days. What's been in the way?" Never on the daily view, and never as a score or a total across items.

**This changes an existing rule.** The failure spec says "no counts, dates only", to prevent a guilt ledger. Seeing a pattern needs some counting. The proposal is to allow a count about a single item inside the look-back and nowhere else. This needs the founder's decision and a decision-log entry.

**Do not design the pattern view yet.** Stage 1 of the build stores the record. What to show should be decided after about four weeks of real records, from what they contain.

## 6. Level checks

A level check asks how the person is, on a schedule they set, and offers something to do now when a level is low. It reuses the batteries check spec (`ecosystem/working/journey-build/03-batteries-check.md`, v0.1, 2026-10-18), which is not built.

**Kept from the spec as written:**

- Three batteries: body, mind and spirit, each read in one of four words: low, okay, full, too full. No numbers, no slider.
- Each battery can be skipped, and a skip is not recorded.
- On "low" or "too full", one question: is there anything small you can do for this right now? The choices are the person's own list of what recharges them, in their words.
- Whether they did it is never stored.
- A low read informs and never blocks.

**Changed, and needing a decision.** The spec forbids exactly what the founder now asks for. It says no reminder, interval or gathered action may open the check, and it writes that into the data model so it cannot be added quietly. Its reason is that a scheduled read drifts from noticing into a number to improve.

| Rule in the spec | Proposed here | Why |
| --- | --- | --- |
| No scheduled check | The person may set a check as a recurring item, and one may sit in the session | The founder's stated need; a level noticed only when you think to ask is noticed too late |
| A read is visible only on the goal it informed | A read also appears as one line of context in the look-back for its day, and on a gap's record | It is the most direct evidence for why something did not happen or why a gap began |
| No history view, chart or trend | Unchanged | The fence against optimizing the reading still holds |

**When a level is low, two offers,** both optional:

1. something small now, from the person's own list (as in the spec);
2. lighten today: the remaining items for the day are shown, each movable in one tap.

The second offer is new. The spec lists "whether a low read should do more than inform" as an open decision, and this is one answer to it.

**Open.** The founder mentioned emotional level alongside battery level. The spec has no separate emotional read; mind and spirit cover part of it. Whether a fourth read is needed is undecided.

## 7. Quiet goals, mistakes and failure

When pursuit stalls, the person gets one short read and a way forward. This reuses the failure-and-ignoring spec (`ecosystem/working/journey-build/05-failure-and-ignoring.md`, v0.1, 2026-10-18), which is not built.

**The three moments the spec defines, and where each now appears:**

| Moment | What triggers it | Where it appeared in the spec | Where it appears now |
| --- | --- | --- | --- |
| **Carried** | An item is moved again, long after it was first due | Under the postpone control in Pre-day and After-day | Session step 2, and beside the item in the look-back |
| **Gone quiet** | An open goal with nothing done recently and nothing planned ahead | An overview section and the goal page | Session step 2, the goal page and the dashboard |
| **Closed** | The person ends a goal as achieved, let go, or didn't work | A new control on the goal page | Unchanged |

**A fourth moment is added: away.** On the first session after a gap, one optional question asks what was going on when the person stopped. It uses the same answer list as the others.

**The read, kept from the spec:**

- One question in every moment: what's been in the way? The answers are: no time, not sure how, didn't have what it took, didn't want to, forgot, outside my control, it stopped mattering.
- Each answer leads somewhere: a smaller step, a new date, or letting go. "Forgot" asks nothing further.
- A goal can be closed three ways. "Didn't work" asks what part was yours and what part was not, before anything else.
- Letting go is offered on equal footing with trying again, and a closed goal can be reopened.
- Wording is about the attempt, never the person. The "Ignored" badge becomes "Date passed". Nothing is marked overdue, and there is no red.
- The look is one line, never a pop-up, and is not repeated within a cooldown.

**Left out for now.** In the spec, three answers lead into Reflect or the capacity check. Reflect is 7 of 8 stages built and the capacity check is at research. Until they exist, those answers lead to a plain note field and the same next steps as the others.

**A dependency.** The spec's mindset frame (a two-step exercise shown once, the first time any look opens) should ship with the first look. The Organize pillar says the frame comes before the work.

## 8. Goal dashboard and Focus

**The dashboard** is a read-only view the person builds by picking goals. It needs no new data; everything it shows already exists in the hierarchy.

For each chosen goal it shows:

- how far along it is: milestones reached and remaining, projects and actions done and open;
- what comes next: the next few open actions and their dates;
- the estimate: time still planned on open actions, and the predicted date where one is set;
- when something was last done, and whether the goal has gone quiet;
- the level read it was set on, if there was one.

A selection can be saved under a name, so the person can keep more than one dashboard. This is progress of the goal, not performance of the person: no totals across goals and no comparison between periods. That follows the rule already set for the skills hub (decision D-53).

**Focus stays as it is.** Focus Periods is the one recent piece the founder uses: a dated, hand-picked set of projects with no tally and a look-back at the end. Two small ties to the new rhythm are worth making:

- in the session's look-ahead, open actions from the current focus are offered first;
- when a focus period ends, its look-back is offered inside the next session, so there is one review moment and not two.

## 9. What retires, what stays, what changes

Most of the app stays. The change is concentrated in the daily cycle.

| Piece | Standing | Note |
| --- | --- | --- |
| Pre-day wizard | **Retires** | Its day overview, time-setting and overlap warning move into the session's look-ahead |
| After-day wizard | **Retires** | Its handling of unfinished actions (postpone, outsource, backlog, bucket list, pass) moves into the look-back |
| The day gate (decision D-5) | **Retires** | The decision log calls this ritual "the product". Retiring it needs a superseding entry, not a quiet change |
| Today | **Changes** | Opens with no step before it. "Toggle done" becomes crossing out |
| Marking an action done | **Changes** | Set at review, not in the moment |
| Gathering recurring items | **Changes** | Today it gathers for today plus two days. It must reach the next session date, up to seven days |
| Overlap detection | **Changes** | Gains ordering, resolution, "during" and a multi-day pass |
| The "Ignored" badge | **Changes** | Becomes "Date passed", neutral colour |
| Goals | **Changes** | Can be closed as achieved, let go or didn't work. Today a goal ends only when every child is done |
| Goals, milestones, projects, actions, intervals, routines | Stays | |
| Calendar, Clarity Check, notes, journals, tags and Time Themes | Stays | |
| Focus Periods | Stays | Two small ties to the session (section 8) |
| Skills labs, Feelings & Needs, Noticing, Reflect | Stays in code | Switched off by default per user (section 10) |

**One consequence to accept or solve.** Goal status is worked out from which actions are done. If "done" is set only at review, a goal's progress on the dashboard can be as old as the last session. The alternative is to count crossed items as provisionally done until review. This is undecided.

**Tracker's role in Journey.** On 2026-10-18 Tracker became Journey's child version (decision D-62), and that work has been paused since 2026-10-23. This concept does not reverse it. It builds two of that plan's five specs, for personal use first, and leaves the first act, Reflect and the capacity check where they stand.

## 10. Access and onboarding

One mechanism serves both: features are switched on per user. It decides who can use what, and it lets a new person start small.

**Access.**

- **A core set is always on:** adding items, the daily view and the session.
- **Everything else is a switch per user:** level checks, the quiet-goal read, the dashboard, Focus, Calendar, the Clarity Check, journals, Time Themes, and each of the prototypes (skills labs, Feelings & Needs, Noticing, Reflect).
- **An admin role** can set the switches for any user. A user can turn on, for themselves, the features an admin has made available to them.
- **Enforced on the server,** not only by hiding menu items.

This is new ground for the app. Today every account is equal: each request is checked for a signed-in user who owns the data, and there is no role.

**Onboarding into the habit.** The existing onboarding explains concepts with a slideshow and per-module introductions. That teaches what the app contains. It does not build the habit of returning, which is what failed.

1. **The first session is the onboarding.** Add a few things for the next two days and set the next session date. No tour before it.
2. **Name the when and where.** The first session ends by asking when and where the next one will happen. An if-then plan of this kind has a medium effect on following through (Gollwitzer & Sheeran, 2006, the source the failure spec already relies on).
3. **One feature at a time, when it becomes relevant.** The quiet-goal read introduces itself the first time something has gone quiet. Level checks are offered after a few sessions. Nothing is introduced before the person has a use for it.
4. **Coming back is the same path.** A person returning after a gap gets the light version again, not a backlog. Onboarding and return are one design.

**Order of people.** The founder first, for about four weeks. Then one or two team members with only the core set on. Bringing others in earlier would onboard them into a shape its first user has not yet kept using.

## 11. Build plan

Stage 1 is the whole bet: if the new rhythm does not hold in the founder's own use, nothing after it is worth building. Each later stage is usable on its own and can wait.

| Stage | What is built | What the person can do after it |
| --- | --- | --- |
| **0 · Decisions** | Decision-log entries: retiring the day gate (D-5); the two changed fences (scheduled level checks, counts inside the look-back); done-at-review. Then the stage 1 spec | Nothing yet |
| **1 · The rhythm** | Today without a gate; crossing out; the session (look-back with the four answers, look-ahead, next date); return after a gap; the record; gathering up to seven days; time order within a day | Use Tracker on the new rhythm |
| **Gate** | The founder uses stage 1 for four weeks | Decide whether to go on |
| **2 · Clashes** | Part-of-day timing; one decision per clash; "during"; recurring clashes settled once; the multi-day pass | Plan several days without repeated clash handling |
| **3 · Stalling** | Closing a goal three ways; carried, gone quiet and away; the one-time frame; the badge rename | See and answer what stalls |
| **4 · Level checks** | The read, the person's own lists, scheduling, the two offers on a low read | Check levels on a schedule and act on a low one |
| **5 · Dashboard** | Pick goals, saved selections | See chosen goals at a glance |
| **6 · Access and onboarding** | Roles, switches per user, the first-session path | Bring a second person in |
| **7 · Patterns** | Designed from the records stage 1 has produced | See patterns across weeks |

**The gate after stage 1, with its test set before building.** Proposed measures, for the founder to adjust:

- sessions held: at least 8 in the four weeks;
- no gap longer than 7 days, or if there is one, the return happened and the gap was recorded;
- the look-back usually takes under five minutes;
- the founder's own judgement that crossing out does not feel like an obligation.

If the test fails, the record of how it failed is the most useful thing Tracker will have produced, and the concept is revised from it before more is built.

**A paper run first (suggested 2026-11-16).** The rhythm can be tested by hand before stage 1 is built: sessions on paper at the chosen spacing, crossing out during the day, the four answers at review, and the next session put in a calendar each time. The founder's earlier paper rhythm worked; a few weeks of this costs nothing and tells stage 1 what it needs.

**Order after the gate is a proposal.** Stages 2 to 5 do not depend on each other. If overlaps cause the most trouble during the four weeks, stage 2 goes first; if a goal goes quiet, stage 3.

**Method and size.** Each stage goes through the lifecycle method already used for Focus Periods and Reflect, starting from its own spec. No effort estimate is given here: none can be made honestly before the stage 1 spec exists.

**Against the January commitment.** Root's current work is the product sale and the Hamrah prototype, due around the third week of January 2027, and the founder's hours are already split across it. Stages 0 and 1 are the smallest piece that tests this concept. Whether they start now or after January is the founder's call.

## 12. Open questions and what is still missing

**Decisions for the founder before stage 1:**

- [ ] Retire the day gate (D-5) and record why.
- [ ] Allow counts about a single item inside the look-back (section 5).
- [ ] Allow scheduled level checks and show a read in the look-back (section 6).
- [ ] Done-at-review, or crossed items count as provisionally done (section 9).
- [ ] The four-week test and its measures (section 11).
- [ ] Start stages 0 and 1 now, or after the January commitment.

**Missing from the concept:**

- **How the app calls the person to a session.** Nothing here reminds anyone that a session is due. The founder's unexplained "simply not going back" makes this the largest gap. Root refuses engagement mechanics, so the question is whether one reminder, on a date the person chose, is acceptable, and by what channel.
- **Quick capture.** "Easily add items" is a stated need and is not designed here: which fields are required, and how few steps adding takes from any screen.
- **Which items are asked about at review.** Some routines only need to be known, others need a record. The proposal is a per-item setting, with "ask me" as the default. Whether that default is right is untested.
- **Emotional level.** Whether it is a fourth read or already covered by mind and spirit.
- **Calendar's part.** Whether the session's look-ahead is its own screen or a mode of the existing Calendar.
- **Existing data.** What happens to the founder's current goals, half-finished days and stored day states when the gate retires.
- **Persian wording.** Session, crossing out, the four answers and "just to know" need authored Persian terms, not translations.
- **Overlap with the team system.** A piece is being considered in Root's own app for weekly goals, Friday check-ins and ownership statements. It has the same shape as a session at seven-day spacing. Whether that is one tool or two has not been asked.

**Carried over from the two specs, still open there:**

- whether the person ever sees their own past level reads as a series;
- the failure spec's starting values: an item counts as carried 7 days after it was first due, a goal as quiet after 14 days, with a 7-day cooldown between looks. They were set for a daily rhythm and should be checked against sessions up to 7 days apart.

---

## Changelog

- **0.1-draft · 2026-11-16** — Initial. Written by Claude from the founder's account in conversation on 2026-11-16 and a read of `tracker` and `root-sot` that day; the app was not run. Committed 2026-11-19 from the shared doc of the same name; the §11 paper-run paragraph was added from the same conversation. Not yet read in this form by the founder.
