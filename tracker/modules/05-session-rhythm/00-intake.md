# Session rhythm, stage 1 — intake

*Module `tracker/modules/05-session-rhythm/` · Track: Module · Phase 0 · 2026-11-19 · Owner: _root*

**Status of this page:** the founder's description, as given. Claims are **proposal** unless marked otherwise. No sources, no research. The concept, its staged plan and the decisions behind it are in `../../drafts/session-rhythm.md` 0.3-draft and Tracker's decision log, D-63 to D-78; this page opens stage 1 of that plan, and nothing after it.

---

## 1. Problem

Tracker exists to follow a goal until it is real and to see how it is pursued and dropped. Its first user, the founder, has repeatedly stopped using it. Three causes are in their own account (draft §1):

- **The rhythm is wrong.** A ritual is required every day, and yesterday's must be closed before today opens (D-5). The founder's working rhythm on paper was a session about every 2.5 days.
- **Ticking feels like obligation.** Marking an action done is the only way to record it.
- **Coming back has a cost.** After missed days, the missed ritual stands between the person and today.

A fourth, from the canon: only completion is stored, so a goal going quiet, or a gap in use, leaves no trace. Part of the leaving is unexplained; the founder "simply stopped going back".

## 2. Pillar

Organize. Seeing your own patterns in how you pursue and drop things is the leverage point the Organize pillar names, and it isn't built. Stage 1 stores the record those patterns will be read from; it shows none yet.

## 3. Place on the opportunity tree

Not placed yet. `spec` assigns the node in `ecosystem/ost.md`.

## 4. Who it is for

Someone who plans their days in a sitting every few days and then lives them, skimming the plan most days and skipping some (weekends, holidays), and who has left planning tools before because keeping them up cost more than they gave. The founder first, for about four weeks; then one or two team members with only the core set on (draft §10).

## 5. Smallest version worth trying

Stage 1 of the draft's build plan (§11), "the rhythm":

- **Today with no gate.** The day opens with no step before it (D-64). Items in time order within the day: start time, then an order the person sets once by dragging (kept for recurring items), then creation order (§4).
- **Crossing out.** One click strikes an item and moves it out of the remaining list; another restores it. It claims nothing, feeds no done state or progress (D-67), and shows no counts (§3).
- **Quick capture.** A small modal from any screen: a title, an optional date (empty means today; "no date yet" is a choice) and an optional time (D-70).
- **Three review settings** per item: ask me (default), don't ask, just to know (D-71).
- **The session,** every 2 to 7 days at a spacing the person chooses: look back (the four answers: happened, partly, didn't happen, no longer matters; crossed items pre-filled as happened); look ahead, on its own screen, over the days to the next session (D-73); the next session's date, with when and where, and an optional "add to my calendar" event (D-69). Each step saves as it is done. A late session blocks nothing.
- **The call on Today:** one line offering the session from its due date, never a count of days late (D-69).
- **Return after a gap:** the session starts from today; older days are one block, "not tracked" in one tap. The gap is stored.
- **Switching over:** nothing existing is deleted; day states become read-only history; the record starts on the switch date; older open actions are offered once as "from before" (D-72).
- **The record:** each item's answer per planned day, whether it was crossed, the date it was first due; each session's date, days covered, and look-back start and finish; each gap's dates and what was planned when it began (§5, D-68).
- **Gathering up to seven days ahead,** to the next session date, in place of today plus two.
- **Pre-day and After-day retire,** their jobs moved into the session (§9).

**Out of scope:**
- Stages 2 to 7 of the draft's plan: part-of-day timing and clash resolution (one decision per clash, "during", recurring clashes, the multi-day pass, one-off deep-work blocks); closing goals three ways and the carried, quiet and away reads; level checks; the goal dashboard; requirements and tension; access switches, roles and the first-session onboarding; any pattern view.
- Galaxy (`../04-galaxy/`), built after this module's four-week gate.
- Showing any pattern or count, anywhere. Stage 1 stores; it doesn't show.
- Any reminder Tracker sends itself: email, push, or a server-side schedule.
- Changes to Focus Periods, Calendar, Time Themes, journals, the Clarity Check or the skills labs, beyond what retiring the gate forces.

## 6. What would make us drop it

> Drop it if I find myself planning on paper again because it's easier than the app.

*The founder chose this wording from three that Claude proposed (2026-11-19).*

**Testable:** not from Tracker's record, which can't see paper. Only by the founder's own account. `spec` and `eval-plan` make it testable.

## Decisions made at intake

| Decision | Answer |
|---|---|
| Track | Module |
| Research | waived (founder, 2026-11-19): the rhythm is the founder's own paper rhythm made into an app, and its test is the four weeks of the founder's own use (D-68); the two Journey specs it reuses carry their own sources |
| Code repo | rishe-eco/tracker |
| Phases that apply | all, with no design pass (founder, 2026-11-19): phase 4b is skipped and the UX review reads the wireframes |
| Project | tracker |
