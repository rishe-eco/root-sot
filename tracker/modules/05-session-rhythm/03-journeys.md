# Session rhythm, stage 1 — journeys

*Module `tracker/modules/05-session-rhythm/` · Phase 3 · Journeys (`journeys new`). The paths the selected personas take, step by step, with what must be true at each step. Input: `02-spec.md` 0.1 (§4). Wireframes draw every step and state named here; this file doesn't decide layout. Update the changelog; don't fork.*

**Version 0.2 · Status: journeys · 2026-11-19 · Owner: _root**

**Grading.** Every journey is **proposal**. Personas marked *hypothesis* are cited from `lifecycle/personas.md`. Items marked **[F]** were decided by the founder (§1). AC-n and bare § numbers cite `02-spec.md`. **Amending:** step numbers are kept and never reused; an inserted step takes a letter (J1.5a); changed text is marked **[x.y]**, so citations downstream still hold. Where a journey needs something the spec doesn't require, the step says **Suggested** and the item is listed in §4.

---

## Summary

Five journeys, all walked by G (Sitting planner, *hypothesis*), 62 steps: the switch and the first session (J1), a day between sessions (J2), the session on its due day (J3), return after twelve days away (J4), and refusals and errors (J5).
The walk found that days between the switch and the first session were never reviewed; the founder decided the first session looks back from the switch date (§1 #1).
A session left open across days continues, with the look-ahead re-anchored to the day it is continued (§1 #2). The Persian terms of §2.2 #17 are kept as proposed (§1 #3).
Twelve Suggested items (§4), the largest being where "From before" sits, what happens to a gap's open items, reversing a follow-up's fate, and what a failed save shows.
No persona reads Persian or is new to the rhythm: AC-60 and AC-64 are walked only as checks, not as anyone's experience.

## Personas

Selected from `lifecycle/personas.md` 0.3. The intake names two audiences: the founder first, for about four weeks, then one or two team members with only the core set on. One persona is selected, **G — Sitting planner**, a hypothesis added for this module and recorded in L-50 (founder, 2026-11-19, accepted in chat). A and B are not selected: both are defined by entering Tracker's Tools page, and this module has no Tools-page surface. C is not selected: it is the IMNSTR writer on a phone, with a publishing task that has no counterpart here. D, E and F are IMNSTR's readers and listeners. The team-member audience is left without a persona: the founder refused a team-member persona (H) when asked on 2026-11-19, so G walks it, and nothing in this file speaks for someone new to the rhythm or for a Persian reader. The spec's Persian terms (§2.2 #17) therefore have no persona to be scored against.

| Persona | Serves | Why selected | Journeys it should anchor |
|---|---|---|---|
| G — Sitting planner (*hypothesis*, L-50) | The founder, and the intake's "plans in a sitting, then skims" audience | The only registered persona that plans in a sitting every few days and has left planning tools before; it probes Today without the gate, crossing out against done, the session's four answers, return after a gap and the fences (§4.1, §4.4 to §4.6, §4.9, §6.7). It does not stand in for the founder's own M4 and M5 judgment. Not covered: a team member new to the rhythm, and any Persian reader | First Today after the switch; a daily skim with a crossing; the session (look back, look ahead, when and where); quick capture; return after a gap; the first session after the switch |

## 1. Decisions taken at journeys

Asked in one batch, 2026-11-19.

| # | Question | Answer [F] | Consequence |
|---|---|---|---|
| 1 | The spec's first session looks back over nothing, which assumes it is held on the switch day. If it is held days later, the uncrossed items of the days between leave Today (AC-10), are never asked about and are too new for "From before"; crossings on those days never become done. What does the first session look back over? | **From the switch date to yesterday,** like every later session. Held on the switch day, it covers nothing, as the spec says | AC-31 and §2.2 #3 change at `revise`: "the previous completed session's date, or the switch date when there is none". J1.6. Suggested S1 |
| 2 | A session started on Monday, half answered, continued on Thursday: what does Thursday continue? | **The same session, with its dates re-anchored.** Answers are kept; the look-back keeps the range it opened with; the look-ahead, the next-date limits and its pre-fill count from the day it is continued. The session keeps its start date as its date, so the next look-back starts there and covers Monday to Wednesday | AC-28, AC-31 and AC-40 gain the rule at `revise`. J4.11. Suggested S2 |
| 3 | Keep the Persian terms of §2.2 #17? No persona reads Persian | **Keep all as proposed** | AC-60 holds as written. No Suggested item. Nothing in this file scores the terms as read; the founder's answer is the only judgment of them |

## 2. Journeys

### J1 — The switch: first Today and the first session *(G)*

**Starts:** G opens Tracker for the first time after the deploy, on a Monday, with older open actions from the gate era · **Ends:** the first session is finished on Wednesday and Today names the next one · **Covers:** AC-1 to AC-8, AC-10, AC-13, AC-15, AC-31, AC-32, AC-39, AC-40, AC-46, AC-47, AC-48, AC-51, AC-52, AC-56

| # | Step | Where | Must be true |
|---|---|---|---|
| J1.1 | G signs in and lands on Today | `/today` | AC-1: a rhythm state now exists with switch date = Monday's client date key and spacing 3. AC-2: no flag was set for this account. AC-8, AC-3: the list renders with no step before it; no Organize or Review button, no wizard, no locked state |
| J1.2 | G reads the line under the date | Today, session line | AC-13: it reads "Plan your next days" with **Start**, one quiet line, not a pop-up; no number of days anywhere |
| J1.3 | G reads the day | Today, list | AC-9: timed items in start-time order, then "Any time". AC-10: last week's open items are not shown. AC-15: two timed rows whose estimates overlap carry the amber mark; a row with no estimate never does |
| J1.4 | G opens the Today intro, then the Concepts page, to see what changed | Today intro; Concepts page | AC-7: neither says Today is locked, in `en` or `fa`; the pre-day and after-day intros no longer show anywhere |
| J1.5 | G skims, closes the tab without starting. Tuesday: opens Today, crosses two items, closes | Today | AC-1: the switch date is still Monday. AC-48: with no due date, gathering made rows for today to today+2 only. Line still "Plan your next days" |
| J1.6 | Wednesday: G taps **Start** | `/session`, Look back | AC-28: a session opens dated Wednesday. **[F §1 #1] Suggested S1:** the look-back covers Monday and Tuesday (switch date to yesterday). AC-39: its start time is stored now |
| J1.7 | G sees Tuesday's two crossings pre-filled "happened" and taps **Confirm these**; answers Monday's three uncrossed items | Look back | AC-32: the crossed group is pre-filled and confirmed in one action; the button names no number (AC-61). AC-33: each uncrossed item has the four answers |
| J1.8 | G moves to Look ahead | Look ahead, head | AC-39: the look-back's finish time is stored. AC-40: the next date reads Saturday (today + 3, the default spacing) and the picker offers only Friday to the following Wednesday |
| J1.9 | Under the next date G sees "From before": open actions dated before Monday, no fate, not done | Look ahead, "From before" block | AC-51: each item has a keep that places it on one of the shown days, and the block has one "let them all go" (fate `PassedArchived`). **Suggested S3:** the block sits at the head of the look-ahead, under the next date, in the first session only. No count of items (AC-61) |
| J1.10 | G keeps one item on Thursday and leaves the rest untouched | "From before" | AC-51: the kept item is now dated Thursday; AC-54: its first-due date is unchanged. AC-52: the untouched items are unchanged |
| J1.11 | G plans Wednesday to Friday, then goes to When and where: "19:00", "kitchen table"; taps **Add to my calendar**, then **Finish** | When and where | AC-46: both fields optional; place at most 80 characters. AC-47: a single-event `.ics` downloads, "Tracker session" in G's language, 19:00 for 30 minutes, location "kitchen table", no item data. AC-56: the session stores start, look-back days and times, next due date, when, where, completed |
| J1.12 | G lands on Today; next week opens another session | Today; next session | AC-13: the line reads "Next session: Saturday …" with **Start now**. AC-52: "From before" is not offered again. AC-5, AC-6: `DayState` rows and every older action, goal, project, interval and routine are as they were, apart from new fields' defaults |

### J2 — A day between sessions: skim, cross, capture *(G)*

**Starts:** Thursday, the day after a session, G opens Tracker over coffee · **Ends:** G closes Tracker having crossed, uncrossed, ordered and captured, without a session · **Covers:** AC-8, AC-9, AC-11, AC-12, AC-13, AC-14, AC-16 to AC-19, AC-21 to AC-24, AC-26, AC-27, AC-48, AC-61, AC-62, AC-64

| # | Step | Where | Must be true |
|---|---|---|---|
| J2.1 | G opens Today | `/today` | AC-8: no step before the list. AC-13: "Next session: Saturday 23 November" and **Start now**. AC-48: gathering on mount covers today to the day before Saturday |
| J2.2 | G crosses "Call the plumber" | Today, row | AC-18: a crossing is written for that action and today's key; `Action.done` is unchanged. AC-14: the title strikes through and the row moves into the "Crossed out" fold, closed. AC-22: with reduced motion set, no animation |
| J2.3 | G opens the fold and uncrosses it again | Today, "Crossed out" fold | AC-14: the row returns to its place in the order. AC-18: the crossing is removed. AC-61: the fold's label holds no count |
| J2.4 | G looks at "Mum's birthday", set "just to know" | Today, row | AC-16: it shows with no cross-out control and reads as just to know |
| J2.5 | G drags "Read chapter 3" above "Stretch" in "Any time", then reloads | Today, "Any time" | AC-11: the order survives the reload; neither item gained a time |
| J2.6 | "Stretch" is a daily routine: G checks tomorrow's occurrence in the look-ahead later | Today; next day | AC-12: the dragged order was kept on the routine; Friday's "Stretch" sits in the same place |
| J2.7 | G presses `N` on Today and types "Book dentist", Enter | Quick capture modal | AC-23, AC-27: the modal opens with focus on the title. AC-24: saved with only a title, on today, "ask me". The confirmation reads "Added to today". Focus returns to where it was. The item appears under "Any time" |
| J2.8 | On a project page, G is typing in a note field and presses `n` | Project page | AC-23: `n` is typed into the field; the modal does not open |
| J2.9 | G uses the top-bar add control, sets Friday, no time, Enter | Quick capture | AC-23: the control is in the top bar of this page. AC-24, AC-26: saved with no estimate and no time; "Added to Friday" |
| J2.10 | G switches to `fa` and presses the physical `N` key (it types د) | Any page, Persian layout | AC-23: the modal opens. AC-64: the modal and Today read right to left with no mirrored-icon or bidi defect |
| J2.11 | On Focus, G crosses a Focus action; on the actions list, crosses an undated item and a Saturday item; the rows are links | Focus; actions list | AC-17: the control replaces the checkbox on both. AC-19: the undated item and the Saturday item are now dated today and crossed. AC-21: no click navigated. Focus's progress did not move (§4.3, R2) |
| J2.12 | On a project page, G crosses an item dated Tuesday that was never crossed | Project page | **Suggested S6:** it is moved to today and crossed, as a future-dated item is; its first-due date is unchanged (AC-54) |
| J2.13 | G closes Tracker | — | AC-61, AC-62: no surface G saw showed a count, a progress bar, a total, a streak or red |

### J3 — The session on its due day *(G)*

**Starts:** Saturday, G opens Today; Wednesday's session set Saturday as due · **Ends:** the session is finished and Today names the next one · **Covers:** AC-13, AC-28 to AC-50 except AC-49 and AC-50, AC-53, AC-54, AC-55, AC-56

| # | Step | Where | Must be true |
|---|---|---|---|
| J3.1 | G opens Today | `/today` | AC-13: "Session due today" and **Start**; never a number |
| J3.2 | G taps **Start** | `/session`, Look back | AC-28: a session opens dated Saturday at the first step. AC-31: the look-back covers Wednesday to Friday, only "ask me" items not already answered; "don't ask" and "just to know" items are absent. AC-39: start time stored. The step header shows Look back · Look ahead · When and where |
| J3.3 | G taps **Confirm these** on the crossed group | Look back, "Crossed out" | AC-32: all crossed items in range, grouped by day, are recorded happened in one action. AC-36: each one's `Action.done` is now true |
| J3.4 | G answers the uncrossed items, oldest day first | Look back | AC-33: the answer is stored for that action and that day (AC-55: one record per action per day) |
| J3.5 | "Draft the proposal": **partly**, then "Place the rest" on Monday | Look back, follow-up | AC-34: the action moves to Monday; Wednesday's record keeps "partly"; AC-54: first-due unchanged. **Suggested S4:** the picker offers the days from today to the day before the pre-filled next date, since the next date isn't chosen yet |
| J3.6 | Three items **didn't happen**: one set aside, one let go, one left with no follow-up | Look back, follow-up | AC-34: fates `Backlog` and `PassedArchived` are set; the third stays on its day, unanswered by follow-up, with no fate |
| J3.7 | "Renew gym card": **no longer matters** | Look back | AC-35: fate `PassedArchived`, no follow-up, the item leaves the list |
| J3.8 | G changes "Call the bank" from happened to didn't happen, and "Renew gym card" back to happened | Look back | AC-36: "Call the bank" is no longer done unless another day says happened. **Suggested S5:** changing away from an answer reverses the fate its follow-up set; "Renew gym card" loses `PassedArchived` |
| J3.9 | On the daily "Stretch", G taps "Don't ask about this", then lets the undo lapse | Look back | AC-37: the routine and every occurrence gathered after today are "don't ask" and are not asked about again; the undo was offered for a few seconds |
| J3.10 | G exits to Today, crosses an item, then taps **Continue** | Today; `/session` | AC-53: Today worked fully. AC-13: the line read "Session in progress" with **Continue**. AC-28, AC-30: the session reopens at Look back with every answer shown |
| J3.11 | Two items left; G taps **Done for now** | Look back | AC-38: the step completes with them unanswered; no later session asks about them. AC-39: finish time stored |
| J3.12 | Look ahead: the next date is pre-filled Tuesday (Wednesday to Saturday was 3); G changes it to Thursday | Look ahead, head | AC-40: pre-fill = today + usual spacing; the picker allows Monday to the next Saturday only. AC-41, AC-48: the new days appear, with recurring items gathered for them |
| J3.13 | On each day G adds one item, moves one to another day, moves one off the shown days, removes one and undoes it, sets a time on one | Look ahead, days | AC-42: each day is in Today's order, recurring items placed, Time Theme bands drawn. AC-43: each change is saved as made (AC-30). AC-45: two items now overlap and show amber; nothing asks G to resolve it |
| J3.14 | G places "Fix bike" from "No date yet" on Tuesday | Look ahead, "No date yet" | AC-44: undated, fateless actions are listed with "Place on…" and no count |
| J3.15 | When and where left empty; G skips the calendar and taps **Finish** | When and where | AC-46: Finish completes the session, sets Thursday as due, returns to Today. AC-56: the session row is complete. AC-13: Today reads "Next session: Thursday 28 November" |

### J4 — Return after twelve days away *(G)*

**Starts:** G last finished a session on 1 December (spacing 3), then stopped; opens Tracker on 16 December · **Ends:** a session is finished with a gap stored, or the block filled in · **Covers:** AC-8, AC-10, AC-13, AC-28, AC-31, AC-38, AC-39, AC-49, AC-50, AC-53, AC-57, AC-61

| # | Step | Where | Must be true |
|---|---|---|---|
| J4.1 | G opens Today | `/today` | AC-8, AC-53: today's list, no step before it. AC-13: "Session was due Wednesday 4 December" and **Start**; no count of days late anywhere. AC-10: nothing from the twelve days shows |
| J4.2 | G opens a project and Focus before deciding anything | Project page; Focus | AC-53: both work as usual; no banner or block |
| J4.3 | G taps **Start** | `/session`, Look back | AC-31: the range is 1 to 15 December. AC-49: the days before 13 December (today minus the spacing) collapse into one block at the top, "1 December – 12 December", with **Not tracked** and **Fill in**; 13 to 15 December are ordinary days below it |
| J4.4 | G reads the block | Look back, gap block | AC-61: the block shows its two dates and nothing else: no count of days or items |
| J4.5 | G taps **Not tracked** | Look back | AC-50: a gap is stored with 1 and 12 December and the ids and titles of the "ask me" items planned on 1 December; the block's days leave the look-back. AC-57: the gap names this session |
| J4.6 | *Branch:* instead, G taps **Fill in** | Look back | AC-50: the twelve days open as ordinary days and no gap is stored |
| J4.7 | G answers 13 to 15 December, with **Done for now** after a few | Look back | AC-38, AC-39: start and finish times stored, so M3 can be read for a return session |
| J4.8 | G reaches the look-ahead | Look ahead | **Suggested S7:** the gap days' open items (no fate, not done, not answered) are offered once, as "From the gap", in the shape of "From before": keep onto a shown day, let them all go, or leave them. Without it they are off Today, out of every look-back and not undated, so nothing ever shows them again |
| J4.9 | G picks a next date two days out, plans, finishes | Look ahead; When and where | AC-40, AC-46 as in J3. §2.2 #2: the usual spacing is now 2 |
| J4.10 | G opens Today | Today | AC-13: "Next session: …". Nothing on Today mentions the gap |
| J4.11 | *Branch:* G had started a session on 1 December and left it at Look back with half the answers; on 16 December G taps **Continue** | `/session` | **[F §1 #2] Suggested S2:** the same session opens with its answers kept and its look-back range as it opened; the look-ahead, its date limits and its pre-fill count from 16 December. The days from 1 December onward are reviewed by the next session, with the gap block (AC-49) if they are old enough |

### J5 — Refusals and errors *(G, and a second account for J5.7)*

**Starts:** at the points named in each step · **Ends:** each refusal leaves nothing half-saved and a way on · **Covers:** AC-4, AC-17, AC-20, AC-25, AC-27, AC-29, AC-40, AC-46, AC-59, AC-62, AC-63

| # | Step | Where | Must be true |
|---|---|---|---|
| J5.1 | G types three spaces as a title and presses Enter; then pastes 201 characters | Quick capture | AC-25: both are refused with a message beside the title; nothing is saved; the modal stays open with the text |
| J5.2 | G presses Escape with a title typed; reopens and clicks outside | Quick capture | AC-27: the modal closes without saving and focus returns to where it was |
| J5.3 | G picks yesterday in the capture's date | Quick capture | **Suggested S10:** the date picker offers today onward and "No date yet"; a past date would land in a look-back nobody planned |
| J5.4 | G tries a next date of today + 9; a crafted request sends today + 1 | Look ahead, head; API | AC-40: the picker doesn't offer it, and the server refuses both |
| J5.5 | G types 120 characters as the place | When and where | AC-46: the field stops at 80 characters, or the server refuses more |
| J5.6 | A crafted request crosses a "just to know" item | API | AC-20: refused; no crossing written |
| J5.7 | A second account sends G's action id to cross, and G's session, day-record and gap ids to read and write | API | AC-20, AC-63: every one is refused by `requireAuth` and `ensureOwned`; nothing is read or written |
| J5.8 | G taps **Start** in two tabs at once | `/session` ×2 | AC-29: one session exists; the second tab continues it |
| J5.9 | G goes offline mid-look-back and answers an item | Look back | **Suggested S9:** the row shows "Not saved" with **Try again**, keeps the chosen answer on screen and blocks nothing else; no red (AC-62). On reconnect, retry saves it |
| J5.10 | A tab opened before the deploy is still showing the old Today; G ticks a checkbox | Old Today tab | AC-4, AC-17: `toggleAction` and the pre-day and after-day operations no longer exist; the call fails and nothing changes. **Suggested S11:** the failure shows "Tracker was updated. Reload" rather than a raw error |
| J5.11 | G switches to `fa` and walks J5.1 to J5.9 | All of the above | AC-59: every message is a key in `en` and `fa`, informal Persian |

## 3. Coverage

| Criterion | Steps |
|---|---|
| AC-1 | J1.1, J1.5 |
| AC-2 | J1.1 |
| AC-3 | J1.1 |
| AC-4 | J5.10 |
| AC-5 | J1.12 |
| AC-6 | J1.12 |
| AC-7 | J1.4 |
| AC-8 | J1.1, J2.1, J4.1 |
| AC-9 | J1.3 |
| AC-10 | J1.3, J4.1 |
| AC-11 | J2.5 |
| AC-12 | J2.6 |
| AC-13 | J1.2, J1.12, J2.1, J3.1, J3.10, J3.15, J4.1, J4.10 |
| AC-14 | J2.2, J2.3 |
| AC-15 | J1.3 |
| AC-16 | J2.4 |
| AC-17 | J2.11, J5.10 |
| AC-18 | J2.2, J2.3 |
| AC-19 | J2.11 |
| AC-20 | J5.6, J5.7 |
| AC-21 | J2.11 |
| AC-22 | J2.2 |
| AC-23 | J2.7, J2.8, J2.9, J2.10 |
| AC-24 | J2.7, J2.9 |
| AC-25 | J5.1 |
| AC-26 | J2.9 |
| AC-27 | J2.7, J5.2 |
| AC-28 | J1.6, J3.2, J3.10, J4.11 |
| AC-29 | J5.8 |
| AC-30 | J3.10, J3.13 |
| AC-31 | J1.6, J3.2, J4.3 |
| AC-32 | J1.7, J3.3 |
| AC-33 | J1.7, J3.4 |
| AC-34 | J3.5, J3.6 |
| AC-35 | J3.7 |
| AC-36 | J3.3, J3.8 |
| AC-37 | J3.9 |
| AC-38 | J3.11, J4.7 |
| AC-39 | J1.6, J1.8, J3.2, J3.11, J4.7 |
| AC-40 | J1.8, J3.12, J4.9, J5.4 |
| AC-41 | J3.12 |
| AC-42 | J3.13 |
| AC-43 | J3.13 |
| AC-44 | J3.14 |
| AC-45 | J3.13 |
| AC-46 | J1.11, J3.15, J4.9, J5.5 |
| AC-47 | J1.11 |
| AC-48 | J1.5, J2.1, J3.12 |
| AC-49 | J4.3 |
| AC-50 | J4.5, J4.6 |
| AC-51 | J1.9, J1.10 |
| AC-52 | J1.10, J1.12 |
| AC-53 | J3.10, J4.1, J4.2 |
| AC-54 | J1.10, J2.12, J3.5 |
| AC-55 | J3.4 |
| AC-56 | J1.11, J3.15 |
| AC-57 | J4.5 |
| AC-58 | no screen |
| AC-59 | J5.11 |
| AC-60 | J2.10 (terms kept, §1 #3; no persona reads them) |
| AC-61 | J1.7, J1.9, J2.3, J2.13, J4.4 |
| AC-62 | J2.13, J5.9 |
| AC-63 | J5.7 |
| AC-64 | J2.10 |

**States** *(read by `wireframes`)*:

| State | Where it occurs | Steps |
|---|---|---|
| Empty | Today with nothing on it (Suggested S8); "Crossed out" fold with nothing crossed (hidden, S8); look-back with nothing to ask about (§4.5, "nothing to ask" and Continue); a look-ahead day with no items; "No date yet" and "From before" with nothing in them (not shown) | J1.6 (switch-day session), J3.13, J3.14 |
| Not enough data | First visit: session line "Plan your next days", no due date, gathering to today+2; first session: no previous session, look-back from the switch date (S1), next date pre-filled with the default spacing 3; "From before" offered once | J1.1, J1.2, J1.5, J1.6, J1.8, J1.9 |
| Error | Capture title refused (empty, over 200); next date out of range; place over 80; server refusals (just to know, not owned); a save that fails (S9); an old tab calling a removed operation (S11) | J5.1, J5.4, J5.5, J5.6, J5.7, J5.9, J5.10 |
| Loading | Today while gathering runs on mount; the look-ahead while gathering for a changed next date; `/session` resuming at its step | J2.1, J3.12, J3.10 |
| Notices | Capture confirmation ("Added to today / Friday / no date"); undo after "Don't ask" and after remove; the session line's four forms; the `.ics` download; the session-in-progress line | J2.7, J2.9, J3.9, J3.13, J1.2, J3.1, J4.1, J1.11, J3.10 |

## 4. Suggested — gaps in the spec, for `revise`

| # | Gap | Found at | Suggested | Why |
|---|---|---|---|---|
| S1 | The first session looks back over nothing (AC-31, §2.2 #3), so days between the switch and the first session are never reviewed | J1.6 | **[F §1 #1]** The look-back covers the previous completed session's date to yesterday, or the switch date to yesterday when there is none. Amend AC-31 and §2.2 #3 | Without it, those days' uncrossed items vanish (AC-10) and their crossings never become done |
| S2 | A session open across days: which dates apply when it is continued | J4.11 | **[F §1 #2]** Continue the same session; keep its answers and its look-back range; the look-ahead's days, the next-date limits (today+2 to today+7) and the pre-fill count from the day it is continued; the session's date stays its start date. Amend AC-28, AC-31, AC-40 | The look-ahead would otherwise plan days already past |
| S3 | Where "From before" sits, and what "offered" means | J1.9 | At the head of the first session's look-ahead, under the next date. "Offered" means the block was shown on screen; a session left before the look-ahead hasn't offered it. Amend AC-51, AC-52 | Its keep needs the look-ahead's days; leaving before it shouldn't spend the one offer |
| S4 | "Place the rest" and "move to a day ahead" in the look-back need the look-ahead's days, which depend on a next date not yet chosen | J3.5 | The picker offers today to the day before the pre-filled next date (today + usual spacing); a later change of the next date leaves placed items where they are | §2.2 #6 put the next date at the look-ahead's head, after the look-back |
| S5 | Changing an answer reverses `done` (AC-36) but not the fate a follow-up or "no longer matters" set | J3.8 | Changing away from "no longer matters", or from "didn't happen" with a set-aside or let-go, restores the fate the action had before; a move made by a follow-up stays | Otherwise a corrected answer leaves the item archived and out of sight |
| S6 | AC-19 covers crossing future-dated and undated items, not past-dated ones, reachable from the project page and actions list | J2.12 | Crossing a past-dated item moves it to today and crosses it; its first-due date is unchanged | §2.2 #9 says crossing is always about today; a crossing on today's key for a Tuesday item would be seen by no look-back |
| S7 | After **Not tracked**, the gap days' open items are on no surface: off Today (AC-10), out of every look-back (AC-50), not undated | J4.8 | Offer them once in that session's look-ahead as "From the gap", shaped like "From before": keep onto a shown day, let them all go, or leave them | Return after a gap is the failure the module was written for; silently losing a gap's items is a second failure |
| S8 | No empty state for Today, nor for the "Crossed out" fold | States | Today with no items shows one quiet line and nothing else (the add control is in the top bar); the fold is hidden when nothing is crossed | Wireframes need a drawn state; the fences rule out "0 items" |
| S9 | No failure state for saves: the session saves every answer as made (AC-30), capture saves on Enter | J5.9 | A failed save shows "Not saved" and **Try again** on that row or in the modal, keeps what was entered on screen, blocks nothing else, and uses no red | A silent loss in the look-back is the worst failure for a resumable session |
| S10 | Quick capture's date accepts any date | J5.3 | The picker offers today onward and "No date yet"; the server refuses a date before today from capture | A past-dated capture lands in a look-back for a day nobody planned, or nowhere |
| S11 | A tab open across the deploy calls removed operations (AC-4, AC-17) | J5.10 | A call to a removed operation shows "Tracker was updated. Reload" | The founder keeps tabs open; a raw GraphQL error reads as broken |
| S12 | Quick capture's "every protected page" (§4.2) meets `/session`'s "no other navigation competing" (§4.4) | §4.2, §4.4 | On `/session` the top bar is hidden but `N` still opens capture; an item dated on a shown look-ahead day appears on it at once | The two sections disagree about one page |
## Changelog

- **0.2 · 2026-11-19** — `journeys new` from spec 0.1: five journeys (J1 12 steps, J2 13, J3 15, J4 11, J5 11; 62 rows), coverage of AC-1 to AC-64, states, and twelve Suggested items (S1 to S11). Three founder decisions in §1 (first look-back from the switch date; an open session re-anchors when continued; Persian terms kept). Persona G only; no persona reads Persian or is new to the rhythm. Written by Claude (Opus 5.5) at an effort below the skill's high.
- **0.1 · 2026-11-19** — `personas` selected G (Sitting planner, *hypothesis*, L-50).

## References

- `02-spec.md` 0.1; `00-intake.md`; `lifecycle/personas.md` 0.3 (G); `lifecycle/decision-log.md` L-50
- `../../decisions/decision-log.md` D-20, D-63 to D-78
