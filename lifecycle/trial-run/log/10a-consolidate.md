# 10a Consolidate — 2026-10-18

## Session
Opus 5.5 (`claude-opus-5-5`), effort **high**, as the founder stated. Opening prompt: "On branch `lifecycle-trial/imnstr` (repo `E:\_root\root-sot`, checked out there directly), pull first, then read `lifecycle/trial-run/README.md`. You are step 10a. Model: Opus, effort: high." Claude desktop app (Code tab). **8a PL1 ran beside it in the same checkout:** it committed its card and launch while this session worked, and its PL1 lane was still running when this session ended.

## Read
- `lifecycle/trial-run/README.md`, whole (the brief).
- `lifecycle/README.md` §0–§4.
- `skills-plan.md` lines 1–100: §0 and §1. That covers `learned`, and also `lifecycle-status`, `handoff` and `decision-record`, which sit above it in §1. *Outside the read order:* those three sections came along in one range. `handoff`'s format was needed for the `STATE.md` block anyway.
- `imnstr/modules/01-website/STATE.md`, the top three blocks (9b, 9, 8d MS4). After the pull, the new 8a PL1 block's head.
- `lifecycle/status.md`; `founder-notes.md`, whole.
- **Every log's *Lessons* section**, from 60 logs and 3 archive logs, extracted to one scratch file with `awk` (8,400 words).
- *Outside the read order, to find what was already integrated* (the skill reads `learnings/index.md`, which doesn't exist):
  - `projects/imnstr/brief-common.md`: headings, *Environment*, *Git*, *Your report*, changelog;
  - `config.md`, whole (a `sed` range printed more than meant);
  - `review-checklist.md`: headings, §3, §5, §7, §8, changelog;
  - `review-instrument.md`, whole (the same `sed` slip);
  - memory `root-app-dev-machine`; `imnstr/CLAUDE.md`, by grep;
  - a grep of the three config files for about twenty lessons' keywords.
- *Outside, for evidence on founder notes 1–2:* `02-spec.md`'s changelog and its AC count; `00-intake.md`'s headings (§5, *smallest version*).
- *Outside, small:* `log/08b-B2-land.md` (grep, how the report file was handled); `briefs/B9.md` (grep, whether 180 px was carried by card); the *Session* and *Cost* sections of `08c-B9-verify.md` and `09b-polish-change.md`, for this log's format.

## Gate
- The inputs exist: 60 logs in `log/`, 3 in `archive/01-research/`, and `founder-notes.md`. No cell in `status.md` is `STALE`.
- `learned --consolidate`'s trigger is "inbox over cap, and before any close-out". There is no inbox. 129 notes is far over the 15-note cap, and 10b hasn't started. **GATE OK.**
- `STATE.md`'s 9b block names 10a as runnable beside PL1.

## Did
Mapped to `learned --consolidate`:
1. **Read every note** (*Reads*): extracted the *Lessons* sections. There's no inbox, and no `index.md`.
2. **Cluster and count** (step 1): 129 notes, two of them a lane's item 7 adopted by a verify log. Pass 3's archive log repeats `01-research.md`'s three notes, which are counted once. The founder notes were taken as weighted inputs, in a cluster of their own.
3. **Find what was already integrated** (not a spec step: in place of reading `index.md`): grepped the destinations. 10 notes are already in the trial README, IMNSTR config, the repo or memory.
4. **Decide each cluster** (step 2): 33 to integrate (90 notes); one scope-growth cluster (3 notes plus the founder notes) with four mechanisms for the founder; 18 to hold; 18 to discard (10 integrated, 8 product knowledge).
5. **Draft each edit** (step 3): one rule in blockquote and a destination per cluster. Most destinations don't exist yet (skill reference files, templates), so these are drafted rules, not exact edits (*Spec gaps* 6).
6. **Committed the proposal** before asking (`bd6d50f`), by path, because PL1 shared the checkout.
7. **Presented the batch** (step 4) with the question tool: first by section, then, at the founder's request, by group. L30–L33 took two more rounds: the founder couldn't answer from the text above the question box, and got the explanation only in a closing message (*Lessons* 1).
8. **Recorded the decisions** in the proposal (0.2) and below. **Step 5 (apply, decision-log entries, `index.md`, deleting notes) is skipped:** the trial table gives it to 10c.

## Output
- `log/10a-consolidate-proposal.md`: 0.1 at `bd6d50f`; 0.2 with the decisions in this session's second commit.
- This log; a new top block in `STATE.md`.
- **No status cell.** 10a has no column, and column 10 is close-out's.

**Accepted items** (the founder, 2026-10-18), all to be applied at 10c:

| Item | Destination |
|---|---|
| L1 parallel sessions on one branch or machine | `skills-plan.md` §0; config template §3; `verify` reference |
| L2 handoff carries pointers, names, ready questions | `skills-plan.md` `handoff` and reference |
| L3 references carry their committed path | §0; `revise` change-note template; design README template; `templates/brief-common.example.md` |
| L4 the step comes from the files | §0, each phase skill's first step; `bin/gate` |
| L5 the gate fetches; behind is `GATE FAIL` | §0, *The gate* |
| L6 independence of passes; a redo path | §0; `ux-review` reference |
| L7 `revise`: contradiction is `STALE`, silence is carried | `revise` |
| L8 a new language or audience → `personas`, then `journeys gap` | `revise`; `README.md` §2 |
| L9 Suggested and *Beyond the spec* gate the build plan | `README.md` §2; `build-plan`, `revise` |
| L10 research reviews itself against its inputs | `research` reference |
| L11 reach sources; grade summaries | `research` reference; grading key |
| L12 design from scratch starts with references | the design step's opening form |
| L13 eval plans split close-out from later | `eval-plan`, `close-out`; `README.md` §2 |
| L14 the founder's facts in one batch, before drafting | `build-plan`, `build-phase` launch 1; `spec` reference |
| L15 by-hand checks and today's devices at launch | `build-phase` launch 1; `verify` milestone; config template |
| L16 earlier claims checked against the code | `build-phase` launch 2; `spec`, `revise` references |
| L17 tests pinning the stage's absence named in the card | card template; launch 2 |
| L18 an "image and deploy" line per stage | `build-plan` template; card checklist; `spec` reference |
| L19 defect pass: leaks and bounded writes | `build-plan` reference |
| L20 whole schema first when the spec fixes it | `build-plan` reference |
| L21 the lane writes its report to a file | `build-phase`; `brief-common` template |
| L22 "every card" carry-overs move to `brief-common` | `verify` reference; `build-phase` |
| L23 commit identity checked by the lane and at land | `brief-common` template; `--land` |
| L24 prove a test fails before the fix | `verify` step 3; checklist template |
| L25 exercise the artifact before reading | `verify` step 2 and reference; checklist template |
| L26 reflow at 180 px, content column, fonts loaded | `review-instrument.md` §3; IMNSTR checklist §5; `brief-common` template |
| L27 check a workaround's stated cause | `verify` reference |
| L28 live checks the reader record won't count | `verify` reference; `ux-review` live; project checklist |
| L29 observing correctly in a review | `review-instrument.md` §5, §3 |
| L30 no prose through a double-quoted shell string | memory `root-app-dev-machine`; `brief-common` template |
| L31 escapes differ by tool | same |
| L32 Git Bash isn't Linux | `brief-common` template |
| L33 free disk on `C:` before an image build | memory; config template |
| Z-a a founder answer that adds, contradicts or questions back becomes a sized `revise` item | §0; `revise` |
| Z-b the scope ledger in the spec header | spec template; `revise` |
| Z-c an item adding a capability leaves `revise` for `spec change` | `revise`; `README.md` §1 |
| §3's 18 holds, as seeds | 10c, when drafting reference files |
| §4's 8 product notes, kept | 10c proposes a cross-project web engineering checklist |

**Not chosen:** Z-d (reopen research's cheaper options when the ledger trips).

## Spec gaps
1. **There's no inbox in the trial.** Lessons sit in each log's *Lessons* section, in four different formats (numbered, bulleted, bold fields, nested lists). Extracting them needed an `awk` over 63 files, and the formats made counting by hand slower. A capture template with fixed fields would make the inbox machine-countable.
2. **The cap never fired.** "15 notes or 14 days" would have tripped about eight times in 12 days. Consolidating once, at the end, meant IMNSTR-scope lessons were carried card by card: `brief-common.md` changed 3 times across 10 stages and 2 Changes, while 180 px, report-to-file and `fonts.ready` sat in cards. *Proposal:* during a build, consolidate at each milestone, and have `lifecycle-status` enforce the cap.
3. **"Hold" has no next batch at the end of a run.** I treated holds as seeds for 10c's reference files. The founder accepted.
4. **"Seen twice" doesn't say twice of what.** I counted sessions, not notes: 09b's two notes are one session. The spec should say so.
5. **Already-integrated detection needs `index.md`,** which doesn't exist. I grepped the destinations instead. The skill should inject each destination's changelog lines, which date what landed.
6. **Step 3's "exact edit" presumes the destination exists.** Most don't yet: skill reference files and templates. I drafted each as a rule plus a destination, and 10c places it.
7. **Product notes reached the lessons anyway.** 8 notes are engineering knowledge about IMNSTR's code, which capture is meant to reject. The founder wants them kept, so the method needs a destination it lacks: a cross-project engineering checklist.
8. **The founder's observations aren't in `learned`'s inputs.** I gave them their own cluster, with mechanisms as options, since they ask a method question that no single lesson answers.
9. **Presenting the batch.** "The founder accepts, edits or rejects each item" means 33+ items through a tool that takes 4 questions of 2–4 options. Grouping worked for L1–L29. For L30–L33, an explanation written above the question box wasn't read as one, which cost two rounds. The skill's reference should say: each item gets one plain sentence with its event, inside the question; longer explanations go in a closing message.
10. **Decide (10a) and apply (10c) are split** in the trial. The skill's step 5 does both. No decision-log entries were written here.
11. **10a has no status column,** and the README doesn't list it among the steps without one. I wrote no cell.

## Template sample
Proposal headings: *Summary* · *How to read it* · *1. Integrate* (grouped by where the lesson acts; each item: ID and title, count and cited notes with costs, the rule as a blockquote, *Destination*) · *2.* the founder-observation cluster (inputs, what happened, who could have flagged it, options) · *3. Hold* (table: note, rule, seed for) · *4. Discard* (already integrated with where; product; not counted) · *Decisions* (table) · *Changelog*.
Required: *Summary*, *Integrate*, *Hold*, *Discard*, *Decisions*.

## Missing foundation
- `lifecycle/learnings/inbox/` and `index.md`. I used the logs' *Lessons* sections and grepped the destinations.
- Skill reference files and templates, the destinations of most items. I drafted rules for 10c to place.
- A cross-project engineering checklist (founder decision, §4).

## Founder Q&A
1. *Accept the 33 integrate clusters?* → "Walk through by group."
2. *Scope mechanisms, any of Z-a to Z-d?* → Z-a, Z-b, Z-c.
3. *The 18 holds?* → Seeds for 10c.
4. *The 8 product notes?* → Start an engineering checklist.
5. *L1–L6? L7–L13? L14–L20? L21–L29?* → Accept each group.
6. *L30–L33, which?* → "I need more explanation — I don't get what's going on here."
7. *The same, after an explanation placed above the question box* → "you didn't explain anything you just said you'll accept them!"
8. *The same, explained in the closing message* (what integrating means, and each quirk with its event) → "all four".

## Skill shape
- **Opus, high, in its own session, not forked:** it needs several rounds with the founder.
- **Inject:** the extraction of every inbox note (`awk` over `learnings/inbox/`); the changelog lines of each candidate destination (`grep -A` on `## Changelog`); the note count and oldest date.
- **Fetched here that injection would have saved:** the grep sweep of the config files (about 6 tool calls).
- **Reference file:** the decision rule, with recurrence counted by session; the destination table; how to tell what's already integrated (changelogs, memory); the product-vs-working test; the founder-observation pattern; and presentation: groups of at most 4, one plain sentence per item with its event, explanations in the closing message, never above a question box.

## Lessons
1. **Rule:** whatever the founder needs in order to answer a question goes inside the question's options or in the closing message, never in text just before the question box. **Event:** L30–L33 were asked twice without an answer ("you didn't explain anything"). **Cost:** two round trips. **Scope:** every session in this app that asks the founder. **Destination:** `skills-plan.md` §0 (asking the founder); memory `founder-commands-in-closing-message`, widened. `urgent: yes`.
2. **Rule:** during a build, consolidate lessons at each milestone, not once at the end of a module. **Event:** 129 notes over 12 days, but `brief-common.md` changed 3 times while the same carry-overs were rewritten into each card. **Cost:** card words at every launch; one card over its limit (B3). **Scope:** `learned`, `lifecycle-status`. **Destination:** `skills-plan.md` `learned` (the cap). `urgent: no`.
3. **Rule:** before proposing a lesson, check the destination's changelog and the memory for it; count recurrence by session. **Event:** 10 of 129 notes were already integrated, found only by grepping five files. **Scope:** `learned --consolidate`. **Destination:** its reference file. `urgent: no`.

## Cost
From the founder's paste: **$3.05**; API 12 m, wall 21 m; Opus 5.5 only. Tokens: 64 input, 56.6k output, 4.4M cache read, 129k cache write.

The wall time includes four rounds of founder questions, two of them for L30–L33 (*Lessons* 1). Most of the output went on the proposal (277 lines), from one 8,400-word extraction of the lessons, so reading 63 logs cost almost nothing.

## Next
- **10b close-out** waits for MS3 (E1, V-9), MS4 (V-5) and PL1's verify, as the 9b and 8a PL1 blocks say.
- **10c trial wrap-up** can run once 10b is done, or beside it if the founder prefers: it reads only logs. **It must also take this log's *Accepted items*:** its row lists *Spec gaps* and *Missing foundation* as inputs, but the accepted lessons are applied there too (the trial table, 10a's *Don't*). The 18 holds and 8 product notes are in the proposal's §3 and §4.
- The memory change in *Lessons* 1 is made now. It changes no method file, and it is the founder's working preference.
