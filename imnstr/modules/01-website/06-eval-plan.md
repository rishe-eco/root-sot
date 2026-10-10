# IMNSTR.com — eval plan

*Module `imnstr/modules/01-website/` · Track: Module · Phase 6. How we will know the site works for the people it is for. It sets out the failures that look alike in the data, the instruments, and the decision rules, written before any data so that an ambiguous result can't be read as a pass. Input: `02-spec.md` 0.2 (§3 Metrics, §5 Risks, AC-15), with the research sections that §3 cites. Update the changelog; don't fork.*

**Version 0.1 · Status: evaluation design · 2026-10-10 · Owner: founder**

**Grading.** Everything here is a **proposal**: nothing is built, and no data exists. Research findings keep their grade from `01-research.md` and are cited by section. Items marked **[F]** were decided by the founder at this step (log `06-eval-plan.md`, Founder Q&A).

---

## Summary

1. **Two evaluations, at two times.** Before launch: is publishing on a phone nearly free (M3, AC-15)? After launch: is the site still of use (M1, with M2 as its only supporting fact)? The first can be judged at close-out. The second can't, because the first check comes three months after launch.
2. **The check is private, and it is more than one question.** It asks whether the founder still chooses to write, whether writing feels chosen or owed, what got in the way, and whether either job was done. It is answered before any fact is looked at.
3. **A lull is never a drop.** M2, the date of the last entry, can only turn a "yes" into "ambiguous". It can never produce a drop on its own (research §2.3).
4. **When the site is the reason, fix the site, don't drop the habit.** Friction is a product defect and goes to the Change track. Pressure is a design problem and goes to `revise`. Only the founder's own "no" leads to a drop, and what goes is decided at that time **[F]**.
5. **Named ambiguous outcomes:** a "yes" with no entry in six weeks, and, before launch, a signed-in M3 that passes while the signed-out case, which is the daily one, doesn't. Two ambiguous checks in a row count as a drop reading.

## 1. The failures, stated so they can be measured

The site collects nothing about visitors (spec §3), so the only data is the founder's answers and the content itself. Four failures produce the same content store:

| | Failure | What the data shows | Why it matters |
|---|---|---|---|
| **F1** | **Lull or end.** Writing has paused, or it has stopped for good. | An old last-entry date (M2). The two cases look the same. | A lull is normal, and one missed day doesn't disrupt a habit; time to habit ranged from 18 to 254 days (research §2.3, *evidence, moderate*). A rule that fires on M2 would kill a habit that is still forming. |
| **F2** | **Quota.** Entries continue, but writing has become something owed: to the "daily" aim, or to two streams. | Recent entries; it looks like success. | Overjustification hurts the already motivated most, and the founder is already motivated (research §1, *evidence, strong* via the evidence summary). Spec risks: "'Daily' turns into pressure"; "Two streams double the pressure". |
| **F3** | **Friction.** Writing stops because publishing costs too much: sign-in, the editor on a phone, lost text. | Same as F1. | The site can be fixed and the habit kept. It is the intake's "nearly free" promise failing, not the founder's interest. |
| **F4** | **Unread.** The notebook continues, but the public-image job isn't being done. | Same as F2. | Unmet recognition is the common thread in blog abandonment (research §2.4, *evidence, thin*), and the site gives no reader signal by design (spec §5, "No sign anyone reads it"). |

So no fact the site holds can decide the outcome. The founder's answers decide it, and they are asked in a fixed order, so that the fact (M2) can't steer them.

## 2. What is evaluated, and when

| | Question | Measures | When | Who judges |
|---|---|---|---|---|
| **E1** | Is publishing on a phone nearly free? | M3, warm and cold (§3.A) | At the build's verification of the admin stage, and at step 9 | `verify`, then step 9. Close-out reads both. |
| **E2** | Is the site still of use? | M1 in parts, M2, reader sign (§3.C, §3.D) | 3 and 6 months after launch, then every 6 months **[F]** | The founder, alone |
| — | Early friction | One note (§3.B) | 2 weeks after launch | The founder. It feeds fixes, not the decision. |

**Launch** is the day the first real entry, in either language, is published on the production domain. Close-out (step 10b) judges E1 and writes the E2 dates in `STATE.md`. Reminders live **outside the site**, in the founder's calendar. The admin never prompts for a check: a "3-month check due" notice would be the "time since" display that AC-5 rules out.

**Not evaluated here:** correctness (the acceptance criteria, at `verify`) and usability (`ux-review`, steps 5 and 9). **Not measured, by design** (spec §3): visits, reads, entries per period, words written.

## 3. The instruments

### A. M3: publishing overhead, warm and cold

- **Device and network.** The founder's own phone, holding an enrolled passkey, on mobile data rather than Wi-Fi. The keyboard is open whenever a field has focus.
- **Text.** A fixed entry of two short paragraphs in each language, held on the clipboard. Pasting stands in for writing, which is how "excluding writing time" (spec §3) is made measurable. The paste counts as overhead.
- **Start:** the tap that opens `/admin`, from a bookmark or the address bar. **Stop:** the admin's confirmation that the entry is published. After each run, open `/log` (or `/fa/log`) and check that the entry is there. That check isn't timed.
- **Included:** choosing the language (AC-42), skipping the title, publishing, and any sign-in the run needs.
- **Timing:** record the phone's screen and read the start and stop times from the video. This beats a stopwatch held in the other hand.
- **Runs:** five warm and five cold per language, 20 in all.
  - **Warm** is M3 as the spec defines it: already signed in.
  - **Cold** starts signed out, so it includes the passkey sign-in. *Proposal:* with a 1 h idle limit (AC-10) and roughly daily writing, almost every real publish starts signed out. Cold is reported but not gated, because the spec gates only warm (see §6).
- **Test data.** Runs happen on a staging instance, or on production before launch, followed by a database reset. Anything published where a feed reader can see it may be kept after it is unpublished (spec §5, "Unpublish is not erasure").

### B. The first fortnight

Two weeks after launch, the founder writes one note: *"What got in the way of publishing?"* Each item gets one of the codes in §3.C, Q3. Items coded **site** go to the Change track before the 3-month check. This note never feeds the keep-or-drop decision. It exists so that friction is fixed while it is cheap.

### C. The check: M1 and M2

It takes about 10 minutes, and the founder answers before opening the admin or the site. The order is fixed.

1. **Q1. Do I still choose to write here?** Yes / no / not sure.
2. **Q2. Does writing here feel like something I choose, or something I owe?** Chosen / owed / mixed. If it's owed or mixed: owed to what? The daily aim, one stream, or both streams. Name it; don't count it. *(The construct is IMI pressure/tension, as used in `ecosystem/working/impact-build/03-spine-evaluation.md` §2.B. At n = 1 a single direct question is enough, so the scale isn't used.)*
3. **Q3. When I meant to write and didn't, what stopped me?** Free text, then one code per item:
   - **site:** sign-in, the editor, the phone, lost text;
   - **time;**
   - **nothing to say;**
   - **owed:** it felt like a duty;
   - **no point:** nobody reads it;
   - **none.**
4. **Reader sign** (§3.D), listed from memory.
5. **Q4. Has it done the notebook job?** Does writing here help me learn and make sense of things? Yes / no.
6. **Q5. Has it done the public-image job?** Does it show the people who follow my work what I'm learning and building, and support the attempt to have an impact? Yes / no.
7. **One line**, in the founder's words.
8. **Then M2.** Read the date of the last published entry, in either language, from the admin list or the database.

Q1, Q4 and Q5 are spec M1 ("Do I still choose to write here, and has it done either job?") split into its parts. Q2 and Q3 tell F2 and F3 apart from a real "no". English and Persian are judged as **one site** **[F]**. Q2 names a stream only when that stream feels owed. Nothing compares the two streams or counts either (spec §4.5).

### D. Reader sign

**Now: recall at the check [F].** The founder lists any time someone mentioned an entry, the feed or the podcast page, together with where and who. There is no running tally, because a tally is the counter the spec refuses. The list informs Q5 and doesn't decide it.

**If `revise` admits analytics.** The founder raised it at this step **[F]**, but spec 0.2 rules analytics out (Summary 1, §3, §4.1, AC-7, §7), so it goes to `revise` (§6) and isn't assumed here. The limits it would need to keep research §1's warning: server-side, no cookies, totals only, never shown in the admin, and read only at the check, after step 7 above. If the totals contradict the founder's Q5 answer, Q5 reads as **not sure**, and the founder resolves it in the one line. The totals never decide the reading on their own.

## 4. The decision rules (written before the data)

This rule is fixed by this commit. Any change before the first check goes through `revise`, with a changelog line. Nothing changes after an answer has been seen.

### 4.1 Before launch: M3

| Result | Reading | What we do |
|---|---|---|
| Warm median ≤ 30 s in **each** language, and no run loses text | **Pass** (AC-15) | Launch-ready on M3. Report the medians and the slowest run, with its cause. |
| Warm median > 30 s in either language | **Fail** | Fix before launch. `verify` blocks the admin stage. |
| Warm passes, but the cold median > 30 s in either language | **Ambiguous**: the spec's case passes, and the daily case misses "nearly free" | Not a launch block. Goes to `revise`: should M3 include sign-in? The idle limit stays, because 1 h is the NIST AAL2 ceiling (spec §4.3). The fix belongs in sign-in speed. |

### 4.2 At each check

Read the rows top-down and stop at the first that matches.

| # | Result | Reading | What we do |
|---|---|---|---|
| 1 | Q3 is mostly **site**, whatever Q1 says | **Friction** (F3) | Fix, not drop. Re-time M3 warm and cold, take the fix through the Change track, and run the check again in 3 months. |
| 2 | Q1 **no**; or Q4 and Q5 both **no** | **Drop** | The founder decides what goes, at the time **[F]**, and records it in §5. The choices on the table: freeze the log read-only, with entry URLs kept (research §2.4) and the landing and podcast pages kept; stop one stream; or take the whole site down. |
| 3 | Q1 **not sure**; or Q1 **yes** with M2 more than 6 weeks old | **Ambiguous**: the stated choice and the behaviour disagree (F1) | No decision. The founder adds one line: what would bring me back? Check again in 3 months, not 6. **Two ambiguous readings in a row count as row 2.** |
| 4 | Q2 **owed** or **mixed** | **Quota** (F2) | Change what is owed, not the site's existence: drop the daily aim, or pause the named stream. Through `revise` if it touches the spec. |
| 5 | Otherwise | **Keep** | Nothing changes; next check as scheduled. If Q5 is **no** and the reader sign is empty, record **unread** (F4). It isn't an action, but the next check reads it. |

**The 6-week line is a proposal.** It is half the interval between checks: long enough that "I still choose" has become a forecast rather than a report, and short enough to catch drift before the next check. M2 never triggers row 2.

## 5. Results

Each occasion adds one row, written by whoever runs it. For a check, record the codes and the reading. The one line is the founder's to include or leave out.

| Date | Occasion | Answers or measures | Reading | Action |
|---|---|---|---|---|
| | | | | |

## 6. For `revise`

These items came out of this step. None of them changes the plan above until `revise` decides it.

1. **Analytics [F]:** the founder would accept them. They contradict spec 0.2 in five places. If admitted: the limits in §3.D, and AC-7 rewritten.
2. **M3's definition:** warm only, or including sign-in (§3.A, §4.1)?
3. **AC-15's "M3 is 30 s or less":** this plan reads it as the warm median of five runs per language. Confirm.
4. **§3's "When" for M1:** add "then every 6 months" **[F]**.
5. **§3's M1 format:** "yes / no, plus one line" is now the five questions in §3.C. Align the wording.

## 7. Cost

| Instrument | Time | When |
|---|---|---|
| A · M3, 20 timed runs plus reading the video | ~45 min | Verification and step 9 |
| B · First-fortnight note | ~5 min | Launch + 2 weeks |
| C, D · The check | ~10 min | 3 and 6 months, then every 6 |

That is about an hour and a half before launch, and about 20 minutes a year after it.

## 8. What this can't do, said plainly

- **The founder is both the judge and the subject.** Every reading rests on self-report from the one person who most wants the site to work and who paid for its home-built login. The fixed question order, M2 read last, and "two ambiguous in a row" are the guards against that. They can't remove it.
- **Six months falls inside the habit range** of 18 to 254 days (research §2.3). A "yes" at 6 months doesn't mean the habit has formed, and the rule doesn't claim it.
- **The public-image job is judged from memory.** Without reader data (§3.D), Q5 is the founder's impression. If the founder wants a better read, it comes through `revise` (§6).
- **It can't separate the site from the founder's life.** Q3's codes **time** and **nothing to say** name that, and the rule doesn't act on them.
- **n = 1, no comparison, and no reader is ever asked.** Followers and listeners are judged only through what reaches the founder.

---

## Changelog

- **0.1 · 2026-10-10**: first eval plan. Four failures with the same data; two evaluations, E1 before launch and E2 after; the M3 protocol (warm and cold, both languages, screen-recorded, off production); the check's fixed order of questions; recall for the reader sign, with analytics as a `revise` item; decision rules with the ambiguous outcomes named; five items for `revise`.

## References

- `02-spec.md` 0.2: Summary, §3, §4.3, §4.5, §5, AC-5, AC-7, AC-10, AC-15, AC-16, AC-42, §7.
- `01-research.md` §1, §2.3, §2.4, §6 (sources listed there). `00-intake.md` §4–§6.
- `ecosystem/working/impact-build/03-spine-evaluation.md`: the shape (failures with identical data, a rule written before the data, the ambiguous outcome named) and the IMI pressure/tension construct.
