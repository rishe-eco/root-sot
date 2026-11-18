# Session rhythm, stage 1 — eval plan

*Module `tracker/modules/05-session-rhythm/` · Track: Module · Phase 6. How we will know the module works for the people it is for: the failures that look alike in the data, the instruments, and the decision rules, written before any data so an ambiguous result can't be read as a pass. Input: `02-spec.md` 0.2 (§3 Metrics, §5 Risks, §2.3 #36, AC-56 to AC-58), `00-intake.md` §6 (the drop rule) and Tracker decision D-68 (the four-week test). Update the changelog; don't fork.*

**Version 0.1 · Status: evaluation design · 2026-11-19 · Owner: _root**

**Grading.** Everything here is **proposal**: nothing is built and no data exists. Research was waived at intake, so no finding is cited. D-68's four measures and their lines (8 sessions, 7 days, five minutes, the founder's judgement) are **[F]**, from the decision log. **No item here is [F] from this step.** This plan was written in the founder's unattended run (`lifecycle/unattended.md`): the questions `eval-plan` asks the founder (what "drop" means, what follows the last check, and the rule actions only the founder can choose) were answered by Claude, and each such answer is marked *call* below, graded *proposal* and refusable on the diff or by `revise`.

**Gate at this step:** `GATE OK` for phase 6. Journeys and wireframes (status columns 3 and 4) read `STALE` after `revise` 01; they are not this phase's inputs and their touch-ups run in parallel.

---

## Summary

1. **One test, from the record, at day 28.** D-68's four weeks start on the founder's switch date (their first visit after the deploy, AC-1). M1 to M3 and M6 come from one read-only query over the stored record (AC-58); M4 and M5 come from the founder's answers, given before the query is read. A record check at day 7 only confirms the record is being written.
2. **The drop rule is made testable** by one habit during the four weeks: date every paper page used to plan days, and note why in a word. At day 28 the founder counts the pages and codes each reason. Paper planned "because it's easier than the app" as the usual way, in the last two weeks, is the drop reading.
3. **Fail is not drop.** A missed D-68 line means *fail*: nothing more is built, and the concept is revised from the record (D-68, draft §11). *Drop* comes only from the intake's drop rule, and it means *pause*: stage 1 stays deployed, untouched; stages 2 to 7 and Galaxy wait; rolling stage 1 back is the founder's own choice, never a rule's (*call*).
4. **The named ambiguous outcome:** a near miss (7 sessions, or a typical look-back between five and six minutes, with everything else passing), a look-back time that can't be read because too many were paused, a "mixed" answer on crossing out, or paper used because it was easier but not as the usual way. It gives no decision: the test runs two more weeks and is read again over the last 28 days. A second ambiguous reading counts as *fail*, never as *pass* or *drop* (*call*).
5. **One watch item outside the gate:** actions a look-back left behind with no fate (spec §2.3 #36, review P1-F2). They are counted and listed at day 28; if the founder lost something that mattered among them, `revise` adds the "Left behind" block that `calls.md` row 7 refused, whatever the gate reads.

## 1. The failures, stated so they can be measured

The record sees sessions, look-back times, crossings, answers and gaps (AC-54 to AC-57). It can't see paper, a skim of Today without a crossing, or why a session didn't happen. These failures look alike in it:

| # | Failure | Looks like | Told apart by |
|---|---|---|---|
| F1 | **The rhythm doesn't fit.** Sessions every 2 to 7 days are not how the founder plans after all | Few sessions (low M1), long stretches (M2) | Crossings continue most days (M6 high) while sessions don't; sessions that are started are finished (few with no completion time, AC-56); the founder's Q3 code is *rhythm* (§3.B) |
| F2 | **The session is too hard or too long.** The look-back or look-ahead costs more than it gives (R1) | The same low M1 as F1 | Sessions started and not completed; a long typical look-back (M3) or many items per look-back; Q3 code *app*. F1 has short look-backs and few abandoned sessions |
| F3 | **Not needed yet, or away.** A holiday, or the January Hamrah work, takes the founder off planning altogether (draft §11 "Against the January commitment") | The same low M1 and a long stretch in M2 | A gap is stored, or its days filled in, at the return (AC-50); M6 is also near zero in the stretch (Tracker was not open, so no rival tool either); Q3 code *life*; no dated paper pages in the stretch |
| F4 | **Not found, or forgotten.** The call on Today (AC-13) isn't seen, or no calendar event is added (D-69) | The same low M1, with long stretches | M6 stays high in the stretches (Today is open, yet no session); sessions mostly begin later than their due date; Q3 code *forgot* |
| F5 | **Paper wins** (the drop rule). Planning moves back to paper because it is easier | Can look like F1 or F3 (fewer sessions), or like success (sessions still held, with real planning on paper beside them) | Only the dated paper pages and their reasons (§3.C). *Easier than the app* is F5; *no device to hand* or *for other work* is not. This is the intake's drop rule, made testable here: intake §6 said it couldn't be tested from the record |
| F6 | **Crossing out became an obligation** (cause 2 of draft §1; M4) | Looks like success: many crossings, high M6 | Only the founder's answer (Q1). High M6 with "it felt owed" is F6; high M6 with "not at all" is the skim working |
| F7 | **The record is broken.** A defect stores no session, or no look-back times | Low M1 or empty M3: indistinguishable from F1 or F2 in the numbers | The day-7 check (§3.D): sessions the founder remembers holding are missing, or a completed session has no look-back start or finish. Then nothing else here is read |
| F8 | **The look-back time is inflated by pauses.** A look-back left open and finished later (resumable, §2.3 #20) counts idle time as look-back time | A long M3 that looks like F2 | The look-back's finish is on a later date than its start, or the span is over 30 minutes. Such look-backs are counted and reported, not used for the typical value (§6 item 2) |

**Watch item W1, not a failure of the gate:** an action planned on a day a completed look-back covered, still dated that day, with no answer (left after **Skip the rest**) or "didn't happen" with no follow-up, no fate and not done (spec §2.3 #36). It looks like nothing in the record, because nothing asks about it again. Counted by the query (§3.A) and read with the founder's Q4.

## 2. What is evaluated, and when

**Launch** is the switch date: the founder's first visit to production Tracker after stage 1 is deployed (AC-1), which is the "deployed and in daily use" day of D-68. Day *n* below counts from it, the switch date being day 0. The four weeks are days 0 to 27.

| Check | When (from launch) | Judged by | Run by | Reminder |
|---|---|---|---|---|
| E1 | before launch | `close-out` | `close-out`, from `verify`'s records: AC-56 to AC-58 pass on test data, the query of §3.A runs on a fixture, §3.B to §3.D are written into the close-out | — |
| E2 | launch + 7 days | the founder (record check only, §3.D; no measure is read) | the founder, on the production box, or an attended Claude session with them (a production command is never run unattended, `unattended.md` rule 3) | an event in the founder's own calendar, added at `close-out` |
| E3 | launch + 28 days | `close-out --eval` | the founder: questions first (§3.B), then the query (§3.A) | the same calendar, added at `close-out`; `close-out` also writes the date into `STATE.md` |
| E4 | launch + 42 days, only if E3 reads *Ambiguous* | `close-out --eval` | as E3, over days 14 to 41 | added at E3 |

Tracker itself never reminds anyone of a check: a "test due" notice would be a count of days, which §4.9 and D-69 rule out.

**Not evaluated here:** correctness (the 75 acceptance criteria, at `verify`) and usability (`ux-review`, design and live passes). **Not measured, by design:** anything shown to the person as a count; the team members of intake §4, who come after stage 6.

## 3. The instruments

### A. The record query

**Measures:** M1, M2, M3, M6, W1, and the diagnostics of §1 (sessions started and not completed, items per look-back, sessions begun after their due date) · **Preconditions:** stage 1 deployed and the switch date stored; the record's tables (AC-55 to AC-57); the query written, tested on a fixture in the record's stage (AC-58), and present in the deployed API image; read access to production's `api/data/prod.db` on the box (`lifecycle/projects/tracker/config.md` §7) · **Procedure:**

- **What it is.** One read-only script in `rishe-eco/tracker`, proposed as `api/src/scripts/rhythmGate.ts`, taking the user's email and a window start date key, and printing a plain-text report for the 28 days from that date. It writes nothing. `build-plan` names its card and the exact command on the box (inside the API container, or against a copy of the database file made with SQLite's `.backup`); this plan names what it computes.
- **M1:** completed sessions (completion time set) whose session date falls in the window. Also printed: sessions started in the window and not completed.
- **M2:** each session date in the window, with the prior session's date (or the switch date before the first); the longest stretch in days; for each stretch over 7 days, whether the session that ended it stored a gap (AC-57) or its look-back covered those days as ordinary days (**Fill in**, §2.2 #12).
- **M3:** for each completed session, look-back finish minus start in minutes and seconds, with the number of days and items its range held. A look-back is *paused* when its finish is on a later date than its start, or the span is over 30 minutes; paused look-backs are listed apart. **The typical value** is the median of the unpaused ones; "usually under five minutes" (D-68) reads as that median under 5:00.
- **M6:** days in the window with at least one day record whose crossing time is set, out of 28.
- **W1:** the actions of §1's watch item, as a count and a list (title, planned day, the session whose look-back covered it), excluding days inside a stored gap.
- **What it never prints:** anything across users, and nothing ever reaches the app. The report is read by the founder at the check and pasted into §5.

### B. The founder's questions at day 28

**Measures:** M4, M5, and the codes that separate F1 to F4 · **Preconditions:** the dated paper pages of §3.C; ten minutes; answered **before** the query is run · **Procedure:** in this order, written down as answered:

1. **Q1 (M4).** "Over the four weeks, did crossing out feel like something I owed?" *Not at all* / *mixed* / *yes*. One line on when, if not *not at all*.
2. **Q2 (M5).** Count the dated paper pages from the four weeks. For each, its reason as noted at the time: *easier than the app* / *no device to hand* / *for other work* / *other* (named). Then: "In the last two weeks, was paper my usual way to plan my days?" Yes / no.
3. **Q3.** "When a session was due and didn't happen, what stopped me?" Free text, then one code per item: *app* (hard, slow, broken), *rhythm* (the spacing or the session shape didn't fit), *life* (away, or other work), *forgot* (didn't see the call or the date), *none*.
4. **Q4 (W1).** "Did anything I planned in Tracker get lost, something that mattered and that I only found again later, or never?" Yes (name it) / no.
5. **One line,** in the founder's words.
6. **Then the query** (§3.A). If its W1 list contradicts Q4 (an item the founder recognises as lost), a second line records it; the first answers stand as written.

### C. Dated paper pages

**Measures:** M5 · **Preconditions:** a habit the founder agrees to at launch; `close-out` writes it into its launch notes · **Procedure:** during days 0 to 27 (and to 41 if E4 runs), any paper page used to plan days gets the date and one word: *easier*, *device*, *work* or *other*. Nothing is entered in Tracker; the pages are counted at day 28. A page that only copies a plan out of Tracker is not counted.

### D. The record check at day 7

**Measures:** none; it guards F7 · **Preconditions:** as §3.A · **Procedure:** run the query over days 0 to 6 and look only at whether each session the founder remembers holding is there, with a look-back start and finish and a completion time, and whether crossings are stored. Measure values are not read or noted, so they can't steer the remaining weeks. A missing or empty record is a defect: it goes to the Change track as a Fix, and the four weeks restart from the day the fix is deployed (§4 row 1).

## 4. The decision rules (written before the data)

Fixed by this commit. Any change before day 28 goes through `revise` with a changelog line; nothing changes after a value has been seen. Read the rows top-down and stop at the first that matches. D-68's lines are **[F]**; every other line, every band and every action is *proposal*, and those marked *call* were Claude's answers to the founder's questions in the unattended run.

| Reading | Action |
|---|---|
| **Invalid:** the day-7 or day-28 check finds sessions the founder held missing from the record, or completed sessions with no look-back times (F7) | No reading. Fix the defect (Change track); the four weeks restart on the day the fix is deployed. Nothing else in this table is read |
| **Drop** (the intake's rule, F5): Q2 says paper was the usual way to plan in the last two weeks, and most of the dated pages in those two weeks say *easier* | **Pause** (*call*): stage 1 stays deployed and unchanged, and the founder may go on using it or not; no later stage and not Galaxy is specced or built; the four weeks' record and answers become the input to a revision of `../../drafts/session-rhythm.md`. Rolling stage 1 back to the old Today is not this rule's action: it is the founder's alone (*call*) |
| **Fail:** any D-68 line missed outside the ambiguous band below: M1 under 7; a stretch over 7 days with no session after it in the window, or ended by a session that neither stored a gap nor filled the days in; the typical look-back 6:00 or longer; Q1 *yes* | No later stage and not Galaxy is specced. The concept is revised from the record before anything more is built (D-68, draft §11), aimed by §1: the measure that failed, with the diagnostics and Q3's codes saying which of F1 to F4 it was. A new four-week test follows the revision's deploy. Stage 1 stays deployed (*call*) |
| Ambiguous: everything else passes, and one of these holds: M1 is 7; the typical look-back is 5:00 to 5:59; a third or more of the look-backs are paused, so M3 can't be read; Q1 is *mixed*; or one or more dated pages say *easier* but paper was not the usual way | No decision. The test runs two more weeks (E4, day 42) and every measure is read again over days 14 to 41, with Q1 to Q4 asked again. A second *Ambiguous* counts as **Fail** (row above), never as Pass or Drop (*call*) |
| **Pass:** M1 at least 8; no stretch over 7 days, or each one ended by a session that stored a gap or filled the days in; the typical look-back under 5:00 with under a third paused; Q1 *not at all*; no dated page says *easier* | The gate is open (D-68). This plan's checks end; the results go in §5 and `STATE.md`. Nothing starts on its own (*call*): the founder chooses what is specced next, among stages 2 to 5b and Galaxy, with draft §11's proposal (stage 2 first if overlaps troubled the four weeks, stage 3 if a goal went quiet) and the query's diagnostics as the input |

**Read alongside, whatever the row (W1, spec §2.3 #36, review P1-F2):**

| Reading | Action |
|---|---|
| Q4 *yes*, or the second line of §3.B step 6 names a lost item, and it is among W1's list | A `revise` item: the "Left behind" block shaped like "From the gap" (`calls.md` row 7's undo), taken into the next spec version that is written, whatever the gate reads |
| W1 has items, and Q4 is *no* | Nothing: leaving them was letting them go. W1's count goes in §5 as a fact for stage 7's pattern design |
| W1 is empty | Nothing |

**Why these bands.** Near misses (one session short, under a minute over) are the readings most open to being read generously or harshly after the fact; naming them now, and requiring the strict D-68 line over a fresh 28 days to pass, keeps D-68's line and still lets a holiday or a slow first week be told apart from a rhythm that doesn't fit. Thirty minutes as the pause line is six times the target, so a real slow look-back is never discarded as paused.

## 5. Results

| Check | Date | Result | Reading |
|---|---|---|---|
| E1 | | | |
| E2 | | | |
| E3 | | | |
| E4 | | | |

## 6. For `revise`

1. **M2 should count a filled-in return.** M2 asks "whether a stretch over 7 days ended in a session with a gap stored", but §2.2 #12 lets the person **Fill in** the old days instead, which stores no gap and records every day. D-68's "the return happened and the gap was recorded" is met either way. This plan reads M2 so (§3.A, §4).
2. **M3's "typical value" is the median of unpaused look-backs.** A look-back is resumable across days (§2.3 #20), and AC-56 stores only its start and finish, so idle time would count. This plan sets the pause line at a later date or over 30 minutes, and requires under a third paused for M3 to be read. The spec could say so in §3, or store the look-back's active time instead; the plan proceeds on the pause line.
3. **M5 is now testable** by the dated paper pages (§3.C) and Q2's codes (§3.B). §3's M5 row could cite this plan instead of "Not readable from the record".
4. **AC-58 could add W1** (the left-behind count of §2.3 #36) and the diagnostics of §3.A (sessions started and not completed) to what the query computes from the tables. Both are computable from AC-55 to AC-57 as specified; nothing new is stored.
5. **The query's place.** AC-58 says "a query the eval plan names": it is §3.A's `rhythmGate` script, read-only, run on the box. `build-plan` gives it a card in the record's stage, with its fixture test.

## 7. Cost

- **The founder's time:** dating a paper page, seconds each; the day-7 check, about 10 minutes; the day-28 check, about 25 minutes (10 for the questions, 5 to run the query, 10 to read it and write §5); the day-42 check, if it runs, the same again.
- **Build time:** one read-only script and its fixture test, inside the record's stage.
- **Paid for:** nothing.

## 8. What this can't do, said plainly

- **It is one person for four weeks.** It can't say whether the rhythm suits anyone else, and the team members of intake §4 are not tested by it.
- **Four weeks may be novelty.** The founder's earlier exits came after the habit had worn in ("simply stopped going back"); a pass at day 28 says the rhythm can hold, not that it will at month three.
- **The founder is judge and builder.** M4, M5 and Q3 are self-report by the person who wants it to work. Asking them before the query, and dating paper pages at the time, limits this; it doesn't remove it.
- **January confounds it.** If the four weeks fall in the Hamrah run-up, a low M1 may be the calendar, not the rhythm. The codes and the stored gaps tell the founder's account apart from the record, but both are only as good as the founder's answers.
- **The record can't see a skim.** M6 counts days with a crossing, not days Today was read; a day skimmed and left alone looks like a day away.
- **Look-back time includes thinking.** M3 can't separate time spent deciding from time spent fighting the screen; the items-per-look-back figure is the only hint.
- **W1 is a count, not a cost.** It can say what was left behind, not whether leaving it mattered: only Q4 says that.

## Changelog

- **0.1 · 2026-11-19** — Plan, from spec 0.2, intake §6 and D-68. Written by Claude (Opus 5.5) following `eval-plan`'s full mode by hand in the founder's unattended run: the founder's questions (what "drop" means, what follows the last check, the founder-only actions, the ambiguous band's second reading) were answered as *calls*, graded *proposal*; none is [F].

## References

- `02-spec.md` 0.2 (§2.2 #12, §2.3 #20 and #36, §3, §4.9, §5, AC-1, AC-13, AC-50, AC-54 to AC-58); `00-intake.md` (§4, §6); `calls.md` row 7
- `../../decisions/decision-log.md` D-64, D-67, D-68, D-69, D-74; `../../drafts/session-rhythm.md` 0.3-draft §1, §5, §11
- `../../../lifecycle/unattended.md` 0.1; `../../../lifecycle/projects/tracker/config.md` §7 (the production database)
- `01-research.md`: none (research waived at intake)
