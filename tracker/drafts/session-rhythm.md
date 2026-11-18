# Tracker — The session rhythm (concept and build plan)

*Draft. Not yet canon. A concept and a staged build plan, not a spec: each stage needs its own spec, through the lifecycle method, before code. When a stage lands, fold it into `../canon/01-product/`, `../canon/02-architecture/01-data-model.md` and a `../decisions/decision-log.md` entry. Reuses two Journey specs: `../../ecosystem/working/journey-build/03-batteries-check.md` and `05-failure-and-ignoring.md`. Update the changelog; don't fork.*

**Version 0.3-draft · Status: concept (nothing built; stage 0 decided, D-63 to D-78; stage 1 opened as `../modules/05-session-rhythm/`) · 2026-11-19 · Owner: _root**

---

Tracker goes back to its first purpose: a personal place to follow a goal until it is real and to see how you pursue and drop things. The daily gate retires. A planning and review session every 2 to 7 days replaces it, and the day in between is a light list.

## Summary

- **The rhythm changes.** Pre-day and After-day stop being gates. A session at a spacing the person chooses (2 to 7 days) looks back, then sets up the days ahead.
- **The day is light.** Items can be crossed out to clear them from view. Crossing out is not a record and nothing is counted.
- **The record is made at review.** For each item the person says what happened. Patterns are read from that, and from gaps.
- **Three things are added on top:** level checks with an immediate action, a short read when a goal goes quiet or fails, and a dashboard over chosen goals.
- **Three more came from Galaxy** (section 8b): requirements between items, tension, and deep-work blocks, which are mostly Time Themes. Galaxy itself, the full-screen room, is interface only and draws what this concept stores (`../modules/04-galaxy/`).
- **Two specs already exist** for the level checks and the failure read, written on 2026-10-18 for Journey. This concept reuses them and changes two of their rules; both changes are named below.

This is a concept and a plan, not a spec. Each stage in the build plan still needs its own spec before code. Stage 0's decisions were made on 2026-11-19 and are in Tracker's decision log as D-63 to D-78 (listed in §12); stage 1's spec is written from this draft in `../modules/05-session-rhythm/`. Sources: the founder's account in conversation on 2026-11-16, and a read of the `tracker` and `root-sot` repositories the same day. The app was not run.

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
4. **Look ahead.** The days until the next session, with recurring items already placed. The person adds, moves and removes items, and resolves time clashes across all those days in one pass (section 4). It is the session's own screen, a list per day, reusing Calendar's parts but not its page (D-73).
5. **Next session date,** with the when and where (section 10), and an optional "add to my calendar" for it: one event, as an `.ics` file or a calendar link (D-69).

**How a session calls the person (D-69).** The founder expects to open Tracker almost daily to skim the plan, with the planning session every few days. So the call is on Today: from the due date, the daily view shows one line offering to start the session. The calendar event from step 5 is the backstop for stretches when the daily skim lapses. Tracker sends nothing itself: no email, no push.

**A session that is late blocks nothing.** The daily list keeps working, because recurring items are generated ahead regardless. The same quiet line shows the date the session was due. It is never a count of days late.

**Coming back after a gap costs nothing.** The session starts from today. Days older than the person's spacing are offered as one block, marked "not tracked" in a single tap, or opened to fill in if they want to. The gap itself is stored: its dates and what was planned when it began.

**Switching over (D-72).** When stage 1 lands, nothing existing is deleted or rewritten, and stored day states stay as read-only history. The record starts on the switch date, so the first session has nothing to look back over. Older open actions are offered once, as one "from before" block: keep an item (into the look-ahead), let them all go, or leave it untouched.

**A session can be done in parts.** Each step saves as it is completed, so it can be left and resumed.

## 3. The daily view

The day is a list to look at, opened at any time with no step before it.

- **Crossing out.** Clicking an item strikes it through with a short animation and moves it out of the remaining list. It means "off my plate for today", so what is left is easy to see. Clicking again restores it.
- **Crossing out is not the record.** It makes no claim that the thing was done, and it feeds no done state, goal or project status, or Focus progress (D-67). At the next session a crossed item arrives pre-filled as "happened" and is still confirmed there.
- **No counts.** No "4 of 7", no progress bar, no daily total, no colour for a finished day. Any of these would turn crossing out back into ticking.
- **Three settings for review (D-71).** **Ask me**, the default for every item: it is asked about in the look-back. **Don't ask**: it can be crossed out but is not asked about and makes no record; any item can be switched to it in one tap inside the look-back, and for a gathered item the setting is kept on its recurrence. **Just to know**: it shows in the day, cannot be crossed, and is not asked about.
- **Adding is always open (D-70).** A small modal opens from every screen: a title (the only required field), an optional date and an optional time. An empty date means today; "no date yet" is an explicit choice, and undated items are offered in the look-ahead. Estimate, project and tags are set later. An estimate is no longer required on a dated item; one without an estimate is not checked for overlaps.
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
| **Happened** | It was done | The action is marked done; this is the only way it becomes done (D-67) |
| **Partly** | Some of it was done | Optionally place the rest in the look-ahead |
| **Didn't happen** | It was not done | Move it to a day ahead, set it aside, or let it go |
| **No longer matters** | It should not have been there, or stopped being relevant | Removed, with no follow-up question |

**Keeping the look-back cheap.** Crossed items are pre-filled as "happened" and confirmed together in one step, with a tap on any that need a different answer. The person's attention goes to the uncrossed items, and any item can be switched to "don't ask" in one tap (D-71). If the look-back takes longer than a few minutes it becomes the next ritual to avoid, so its length is measured: "usually under five minutes" is one of the stage 1 gate's measures (D-68).

**What is stored:**

- for each item on each planned day: the answer, whether it was crossed out that day, and the date it was first due;
- for each session: its date, the days it covered, and when its look-back started and finished (D-68);
- for each gap: its start and end dates and what was planned when it began.

**Patterns.** Three kinds are worth showing first, because each already has a defined response in section 7:

1. a recurring item that keeps not happening;
2. an item that keeps being moved;
3. a goal with nothing done and nothing planned.

A fourth is new and is the one the founder most needs: **what was on the plate when a gap began.**

**Where patterns appear.** Only in the session look-back and on the item's or goal's own page, as a plain dated observation followed by a question. Example: "Evening walk has not happened on its last four planned days. What's been in the way?" Never on the daily view, and never as a score or a total across items.

**This changes an existing rule (decided, D-65).** The failure spec says "no counts, dates only", to prevent a guilt ledger. Seeing a pattern needs some counting. A count about a single item's own planned days is allowed in the look-back and on that item's or goal's own page, and nowhere else. Never a count across items, never a total, never on the daily view.

**Do not design the pattern view yet.** Stage 1 of the build stores the record. What to show should be decided after about four weeks of real records, from what they contain.

## 6. Level checks

A level check asks how the person is, on a schedule they set, and offers something to do now when a level is low. It reuses the batteries check spec (`ecosystem/working/journey-build/03-batteries-check.md`, v0.1, 2026-10-18), which is not built.

**Kept from the spec as written:**

- Three batteries: body, mind and spirit, each read in one of four words: low, okay, full, too full. No numbers, no slider.
- Each battery can be skipped, and a skip is not recorded.
- On "low" or "too full", one question: is there anything small you can do for this right now? The choices are the person's own list of what recharges them, in their words.
- Whether they did it is never stored.
- A low read informs and never blocks.

**Changed (decided, D-66).** The spec forbids exactly what the founder now asks for. It says no reminder, interval or gathered action may open the check, and it writes that into the data model so it cannot be added quietly. Its reason is that a scheduled read drifts from noticing into a number to improve.

| Rule in the spec | Decided here (D-66) | Why |
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

## 8b. Requirements, tension and deep-work blocks

*Added 0.2-draft, 2026-11-19, from the conversation that described Galaxy (`../modules/04-galaxy/00-intake.md`). Galaxy is kept to interface only. Anything it needs that stores or calculates something is here, under this concept's rules.*

### Requirements

An item can be marked as a **requirement of** another item, project or goal: "this has to happen before that can". Tracker has no link of this kind today.

- It is the data under three things: an item shown as "waiting on a requirement", the calculated part of tension, and preparing actions for a deep-work block.
- A requirement is a warning, never a block, like overlaps. Nothing stops the later item from being planned or crossed out.
- **What it points at (D-78).** The requirement is always an item (an action). What waits on it can be an item, a project or a goal.

### Tension

Tension is how heavy a task feels, recorded so the person is aware of it. It isn't a call to act, and it isn't attention: an item can be tense and need nothing.

- **Two parts.** A **calculated part** comes from requirements: how close the deadlines of the things waiting on the item are, and how much follows from them. A **marked part** is set by the person, for any reason of their own. The item's tension is both together.
- **Sizes (D-77).** Three, in words: light, heavy, very heavy; no mark means none. The item's tension is the larger of its two parts, never their sum, and the calculated part is mapped onto the same three words. (Galaxy's probe used five steps.)
- **Easing.** When something is tense, the person can plan items to ease it, linked to the tense item. When an easing item is answered "happened" in the look-back, one question follows: did the tension come down, in your own judgment? The answer updates the marked part. The founder's reason: this is about how someone feels about doing something, so their own feedback is essential.
- **Where it shows.** Tension is the person's own mark, not a pattern, so it may appear on the daily view as a size. A tense item that keeps being moved *is* a pattern (section 5, "an item that keeps being moved"). It shows only where patterns show: the look-back and the item's own page. No red, as in section 7.
- **Not a level.** Level checks (section 6) read how the person is. Tension reads how one task feels. They sit side by side and don't feed each other unless the founder decides they should.
- **Fences (decided, D-77):** no tension total across items, and no history chart. The same reasoning as the level-check fence: a felt weight turned into a number to bring down stops being felt.

### Deep-work blocks: mostly Time Themes

The founder asked whether deep-work blocks are Time Themes. **Mostly yes,** with one gap and one reuse.

| What a deep-work block needs | Time Themes today (D-54) | What is new |
| --- | --- | --- |
| A span of the day with a nature ("deep work") | Exactly this: a span with a tag | Nothing |
| On a regular schedule | Interval recurrence, verbatim | Nothing |
| Just this once, set up while planning the days ahead | Possible only as a theme with one ad-hoc date, made in the theme editor | **The gap:** placing a one-off block from the session's look-ahead, without authoring a recurring theme. Decided (D-76): it is a Time Theme with one date, made in the look-ahead in one step; past one-offs are hidden from the theme list |
| Items put into it | An item given a time inside the span sits in the band; matching tags rise to the top | Nothing. Decided (D-75): a block surfaces items by time and never holds them; D-54's "soft means order, never membership" stands |
| Preparing actions | Not modelled | **The reuse:** a preparing action is a requirement of the block's items. No separate concept |

So no new entity. The one-off block belongs in stage 2, next to part-of-day timing and the look-ahead's clash pass.

### Attention

"Needs you" in Galaxy is a derived list, and nothing new is stored for it: items with no date, items with a date and no time, items waiting on a requirement, and items that are requirements of something due soon. It never shows as a count. Undated items are offered in the look-ahead, which is where they get placed.

### Alignment, later

Galaxy draws goals as orbits that line up, or don't, with one direction. Reading that from data is a pattern: a scattered cloud with no direction yet, or a formed system whose goals are out of line. It belongs in stage 7, designed from real records like the other patterns. Galaxy draws it only once it exists.

## 9. What retires, what stays, what changes

Most of the app stays. The change is concentrated in the daily cycle.

| Piece | Standing | Note |
| --- | --- | --- |
| Pre-day wizard | **Retires** | Its day overview, time-setting and overlap warning move into the session's look-ahead |
| After-day wizard | **Retires** | Its handling of unfinished actions (postpone, outsource, backlog, bucket list, pass) moves into the look-back |
| The day gate (decision D-5) | **Retires** | Superseded by D-64. Existing day states are kept as read-only history (D-72) |
| Today | **Changes** | Opens with no step before it. "Toggle done" becomes crossing out. Shows the line offering the session from its due date (D-69) |
| Marking an action done | **Changes** | Set at review, not in the moment (D-67) |
| Adding an action | **Changes** | A small modal from any screen; an estimate is no longer required on a dated action (D-70) |
| Gathering recurring items | **Changes** | Today it gathers for today plus two days. It must reach the next session date, up to seven days |
| Overlap detection | **Changes** | Gains ordering, resolution, "during" and a multi-day pass |
| The "Ignored" badge | **Changes** | Becomes "Date passed", neutral colour |
| Goals | **Changes** | Can be closed as achieved, let go or didn't work. Today a goal ends only when every child is done |
| Goals, milestones, projects, actions, intervals, routines | Stays | |
| Calendar, Clarity Check, notes, journals, tags and Time Themes | Stays | |
| Focus Periods | Stays | Two small ties to the session (section 8) |
| Skills labs, Feelings & Needs, Noticing, Reflect | Stays in code | Switched off by default per user (section 10) |

**One consequence, accepted (D-67).** Goal status is worked out from which actions are done. Since "done" is set only at review, a goal's progress (and a project's, and Focus's) can be as old as the last session, up to seven days. Counting crossed items as provisionally done was set aside: it would make crossing out a claim again.

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
| **0 · Decisions** | **Done 2026-11-19:** D-63 to D-78 (§12). Then the stage 1 spec, in `../modules/05-session-rhythm/` | Nothing yet |
| **1 · The rhythm** | Today without a gate; crossing out; quick capture (D-70); the session (look-back with the four answers, look-ahead, next date, the optional calendar event); the call on Today (D-69); the review settings (D-71); return after a gap; switching over (D-72); the record; gathering up to seven days; time order within a day | Use Tracker on the new rhythm |
| **Gate** | The founder uses stage 1 for four weeks | Decide whether to go on |
| **2 · Clashes** | Part-of-day timing; one decision per clash; "during"; recurring clashes settled once; the multi-day pass; one-off deep-work blocks from the look-ahead (section 8b) | Plan several days without repeated clash handling |
| **3 · Stalling** | Closing a goal three ways; carried, gone quiet and away; the one-time frame; the badge rename | See and answer what stalls |
| **4 · Level checks** | The read, the person's own lists, scheduling, the two offers on a low read | Check levels on a schedule and act on a low one |
| **5 · Dashboard** | Pick goals, saved selections | See chosen goals at a glance |
| **5b · Requirements and tension** | The requirement link; tension's two parts and sizes; easing items and the look-back question (section 8b) | Mark and see what weighs, and see whether easing it worked |
| **6 · Access and onboarding** | Roles, switches per user, the first-session path | Bring a second person in |
| **7 · Patterns** | Designed from the records stage 1 has produced, including the alignment read (section 8b) | See patterns across weeks |

**The gate after stage 1, with its test set before building (decided, D-68).** Four weeks from the day stage 1 is deployed and in daily use:

- sessions held: at least 8 in the four weeks;
- no gap longer than 7 days, or if there is one, the return happened and the gap was recorded;
- the look-back usually takes under five minutes;
- the founder's own judgement that crossing out does not feel like an obligation.

Stage 1 stores what the first three need (session dates, gaps, look-back start and finish), so the gate is read from the record. The fourth is asked of the founder at the end and written into the gate's record. If the test fails, the record of how it failed is the most useful thing Tracker will have produced, and the concept is revised from it before more is built.

**A paper run first: not held (D-74).** Suggested on 2026-11-16: test the rhythm by hand before stage 1 is built. The founder chose not to; the four-week test after stage 1 is the first test in use.

**Galaxy is not a stage here.** It is its own module (`../modules/04-galaxy/`), interface only, built after the gate over whichever stages exist by then. Its goals view is the natural face of stage 5's dashboard.

**Order after the gate is a proposal.** Stages 2 to 5b do not depend on each other. If overlaps cause the most trouble during the four weeks, stage 2 goes first; if a goal goes quiet, stage 3.

**Method and size.** Each stage goes through the lifecycle method already used for Focus Periods and Reflect, starting from its own spec. No effort estimate is given here: none can be made honestly before the stage 1 spec exists.

**Against the January commitment.** Root's current work is the product sale and the Hamrah prototype, due around the third week of January 2027, and the founder's hours are already split across it. Stages 0 and 1 are the smallest piece that tests this concept. **They start now (D-63):** the design phases are attended, and the build can then run unattended (`lifecycle/bin/drive`, L-49).

## 12. Open questions and what is still missing

All decided with the founder on 2026-11-19, each in Tracker's decision log (`../decisions/decision-log.md`).

**Decisions for the founder before stage 1:**

- [x] Start stages 0 and 1 now, or after the January commitment. **Now** (D-63).
- [x] Retire the day gate (D-5) and record why. **Retired** (D-64, supersedes D-5).
- [x] Allow counts about a single item inside the look-back (section 5). **Yes, in the look-back and on the item's own page** (D-65).
- [x] Allow scheduled level checks and show a read in the look-back (section 6). **Both** (D-66).
- [x] Done-at-review, or crossed items count as provisionally done (section 9). **Done at review** (D-67).
- [x] The four-week test and its measures (section 11). **As written, read from the record** (D-68).

**Decisions for the founder before stages 2 and 5b (section 8b):**

- [x] Whether a deep-work block holds items, which reverses D-54's "order, never membership", or only surfaces them. **Only surfaces; D-54 stands** (D-75).
- [x] A one-off block: a Time Theme with one date, or an occurrence placed without a theme. **A one-date Time Theme** (D-76).
- [x] The tension scale, and whether its fences (no total, no chart) hold. **Three sizes in words; fences hold** (D-77).
- [x] What a requirement can point at: items only, or projects and goals too. **Items, projects and goals** (D-78).

**Missing from the concept:**

- [x] **How the app calls the person to a session.** **A line on Today from the due date, and an optional calendar event at the end of each session; Tracker sends nothing itself** (D-69, section 2).
- [x] **Quick capture.** **A small modal from any screen: title, optional date (empty means today) and time** (D-70, section 3).
- [x] **Which items are asked about at review.** **"Ask me" by default; one tap in the look-back sets "don't ask", kept on the recurrence** (D-71, section 3).
- [x] **Calendar's part.** **The look-ahead is the session's own screen** (D-73, section 2).
- [x] **Existing data.** **Kept; day states read-only; the record starts at the switch; old open items offered once** (D-72, section 2).
- [x] **A paper run before building** (section 11). **Not held** (D-74).
- [ ] **Emotional level.** Whether it is a fourth read or already covered by mind and spirit. Open until stage 4.
- [ ] **Persian wording.** Session, crossing out, the four answers, "just to know", "don't ask" and "from before" need authored Persian terms, not translations. Stage 1's are authored with its spec and journeys.
- [ ] **Overlap with the team system.** A piece is being considered in Root's own app for weekly goals, Friday check-ins and ownership statements. It has the same shape as a session at seven-day spacing. Whether that is one tool or two has not been asked.

**Carried over from the two specs, still open there:**

- whether the person ever sees their own past level reads as a series;
- the failure spec's starting values: an item counts as carried 7 days after it was first due, a goal as quiet after 14 days, with a 7-day cooldown between looks. They were set for a daily rhythm and should be checked against sessions up to 7 days apart.

---

## Changelog

- **0.3-draft · 2026-11-19** — Stage 0 decided with the founder, D-63 to D-78, and applied: start now (§11); the day gate retires (§9); per-item counts in the look-back and on the item's page (§5); scheduled level checks and a read in the look-back (§6); done at review (§3, §5, §9); the four-week test, read from the record (§5, §11); the call on Today with an optional calendar event, switching over, and the look-ahead as its own screen (§2); quick capture and the three review settings (§3); no paper run (§11); and the four §8b decisions (blocks surface, one-date themes, three tension sizes, requirement targets). §12 ticked; emotional level, Persian wording, the team-system overlap and the carried-over items stay open. Stage 1 opened as `../modules/05-session-rhythm/`.
- **0.2-draft · 2026-11-19** — New section 8b from the Galaxy conversation, so that Galaxy stays interface only: **requirements** between items; **tension** (a calculated part from requirements, a marked part, sizes, easing items and a look-back question); **deep-work blocks** read as mostly Time Themes (one gap, a one-off block from the look-ahead; one reuse, preparing actions as requirements); the derived **attention** list; and the **alignment** read deferred to stage 7. Build plan: stage 5b added, stages 2 and 7 widened, Galaxy named as its own module after the gate. Four decisions added to §12, and Galaxy noted against the reminder gap.
- **0.1-draft · 2026-11-16** — Initial. Written by Claude from the founder's account in conversation on 2026-11-16 and a read of `tracker` and `root-sot` that day; the app was not run. Committed 2026-11-19 from the shared doc of the same name; the §11 paper-run paragraph was added from the same conversation. Not yet read in this form by the founder.
