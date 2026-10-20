# Retrospective — the journeys build (root-app, P0 → J12)

*What the largest build to date cost, where the cost went, and what the lifecycle system changes because of it. Stage 0 of the lifecycle plan: the baseline every later build is measured against.*

**Version 0.4 · Status: draft — completed once the journeys dev process is fully done · 2026-10-05 · Owner: _root**

---

## Summary

The journeys build shipped 18 stages and four milestones in six working days, and used about **2.5 weekly limits**. The output was large (≈41k lines of code, ≈30k lines of tests), but output was not where the usage went: across the build, **input outweighed output by two to three orders of magnitude**. Most of the cost was the same large context being re-sent — a single orchestrating session that lived seven days at 500–760k tokens, lanes that ran for hours across limit resets, and one debug loop that ran overnight against a cause rerunning could not fix. The process itself — per-stage briefs, Sonnet building, Opus reviewing, stage records — was sound and is adopted into the lifecycle; the changes are about session hygiene, not method.

**Grading.** Three kinds of claim, kept apart:

- **As-built** — read from `rishe-eco/root-app` branch `journeys-build` @ `267a71d` on 2026-10-05: commit history, diff stats, `docs/development/README.md`, the stage records. Commit times are Tehran (+03:30).
- **Reported** — the build session's own account, reconstructed from its transcripts and relayed by the founder on 2026-10-05. Token counts, lane runtimes, resume times. Times in this section are UTC. **Not independently verified here.**
- **Analysis** — mine. Every finding in §4 and every estimate is marked as such.

---

## 1. What was built *(as-built)*

| | |
|---|---|
| Branch | `journeys-build`, 162 commits (25 merges) over `main` @ `0a51b53` |
| Active days | Sep 28, 29, 30, Oct 1, Oct 4, Oct 5 (paused Oct 2–3) |
| Stages | P0 (pre-flight) · S1–S3 · T1–T2 · J1–J13 (J5+J6 one lane, J9 split into libs/J9a/J9b) |
| Diff | 393 files, +77,685 / −3,674 |
| Added lines, by kind *(approximate — classified by path)* | code ≈41.2k · tests ≈30.3k · strings/JSON ≈3.7k · migrations ≈1.5k · docs ≈1.1k |
| Final suites (M4, 2026-10-05) | unit 1064 API + 327 web · integration 1242 · e2e 114 |

Milestone suites, per `docs/development/README.md`: M1 (S1·J1·T1·S3) 2026-09-29 · M2 (J2·J3·S2) 2026-09-30 · M3 (J4–J7·J13) 2026-10-01 · M4 (J8–J12) 2026-10-05.

## 2. How it was run *(reported, except where noted)*

- **One session, planning to merge.** A single Claude Code session ran from Sep 28 15:02 to Oct 5 morning. It wrote both source documents (the user-journeys spec from 15:35, the build plan from 18:03, Opus 5.5) and then orchestrated every stage. **Compacted three times by hand, never cleared.** Resumed about ten times after the 5-hour limit.
- **Lanes.** Each stage was built by a background Sonnet subagent (Agent tool) in its own git worktree with its own test database and ports. 23 launches, 22 ran (one J7 launch failed at worktree creation). Peak concurrency three (small P0 chunks); real stages never more than two: S3∥J2, J3∥T2, J5+J6∥J13, J8∥J9a, J9b∥J11. Pause and resume through SendMessage (25 calls).
- **Models.** Sonnet lanes from P0, after the founder asked (Sep 28 18:58) whether the plan could be chunked for Sonnet with Opus reviewing. First six lanes on claude-sonnet-5, then claude-sonnet-5-5 from T1. Opus did every review, fix, merge and stage record, and built S1's API half.
- **Orientation.** Each lane read `brief-common.md` (~490 words: lanes, test commands, gotchas) plus a stage brief (~500–700 words) that named exactly which plan §5 section, which journeys sections and which earlier stage records to read. **Lanes read sections, not whole documents.** After each compaction the main session reoriented from its memory file, the briefs and the stage records.
- **Source sizes.** Journeys build plan: 972 lines, 16.7k words, 117 KB. User-journeys spec: 802 lines, 15.0k words, 94 KB. Roughly 20–30k tokens each.
- **Reviews.** A custom pass in the main session, no `/code-review` and no review subagent: stat, then core files; a standing checklist (guards, money gating, database CHECKs, the mockup host fence, origin checks, the staging-host rule); fix on the branch, merge `main` in, re-run affected test files; write the stage record; fast-forward `main`.
- **Tests** *(as-built, README)*: targeted per stage, full suites at milestones, one heavy runner at a time. Lanes nevertheless sometimes ran the full e2e suite inside their worktree *(reported)*.

## 3. What it cost *(reported)*

| Where | Input tokens | Output tokens |
|---|---|---|
| 22 Sonnet lanes | ≈1.94B | — |
| Main Opus session | ≈279M | ≈790k |

**Main-session context at each compaction:** Sep 28 18:35 ≈518k · Sep 29 22:48 ≈762k · Oct 4 22:04 ≈505k.

**Five-hour limit run-outs (UTC):** Sep 29 16:09, 21:01 · Sep 30 04:31, 09:31, 14:31, 19:31 · Oct 4 14:31, 19:31 · Oct 5 00:31 (J12's lane died on it mid-run).

**Weekly limit:** Sep 30 21:10 at ≈94%, both lanes paused; Oct 1 08:36 over 92%; Oct 1 09:12 "pause now", lanes committed work in progress; Oct 4 11:04 continue (one more pause 12:20, continue 14:27). The Oct 2–3 gap was this deliberate pause, not a run-out.

**Hotspot lanes, by input:**

| Lane | Input | Output | Runtime | Why *(reported)* |
|---|---|---|---|---|
| J1 phone identity | 269M | 80k | ≈10 h, overnight | Long debug loops, little new code; the e2e suite hit the real sign-in rate limits. Review found 5 issues. Opus finished it |
| J10 demo readiness | 167M | 119k | ≈1.7 h | Readiness and origin checks, staging-host rule, four stale expectations, a migration rename |
| J8 design step | 145M | 188k | ≈9 h | Ran beside J9a across limit hits; needed `main` merged in after J9a changed `Demo.projectId` |
| J7 agreement gate | 132M | 95k | — | The planned sequence flip touched many tests |
| J4 requirements | 130M | 134k | — | — |

The five together ≈843M, about 43% of all lane input; J1 alone ≈14% *(analysis, from the reported figures)*.

**Rework** *(reported)*: no stage was redone because the plan was wrong. Closest: J9 split mid-plan; J13's "signed" rule read the wrong record and its fix broke an un-rerun j3 test; a whitespace-only-reason CHECK needed a follow-up migration; J12 found the banner never covered a first draft; the date time-bomb in test fixtures surfaced at M4.

## 4. Findings *(analysis)*

1. **The orchestrating session was the biggest structural cost.** Planning, eighteen reviews, merges and records shared one context that sat at 500–760k tokens for a week. Every review turn re-sent half a million tokens of history unrelated to the stage under review; every resume after a 5-hour reset missed the cache (one hour on a subscription) and reprocessed it in full; each `/compact` was itself a request over the whole context. The session already proved the alternative works: after each compaction it reoriented from the memory file, briefs and records. **A fresh session per milestone or per review, started from those files, does the same work at a fraction of the context.**
2. **J1's debug loop had a cause rerunning could not fix.** The e2e suite was hitting a real rate limit; ten overnight hours produced 80k output tokens. A stop rule after three failed hypotheses, and a rule against debugging through the e2e suite, would have surfaced the environmental cause within the first hour or two.
3. **Lanes straddled limit resets.** J1 overnight, J8 ≈9 h across limit hits, J12 killed mid-run. A lane resumed hours later re-reads its context uncached; a fresh lane from the brief and the WIP commit is cheaper.
4. **Parallel lanes collided on schema.** J8 had to absorb J9a's `Demo.projectId` change. Parallelism was not the problem; two lanes changing shared schema at once was.
5. **Smaller leaks.** Full e2e runs inside lanes, against the build's own milestone rule; test fixtures tied to today's date; the 117 KB plan and 94 KB spec written inside the session that then orchestrated, so they sat in its context from day one.
6. **Process state lived outside git.** The orchestrator's memory files and the stage briefs survived only because they sat in `~/.claude` on the build machine — the briefs were copied there on purpose after the session scratchpad proved volatile — and were recovered by hand on 2026-10-05. Another account, another machine, or a second developer would not have had them. The memory also held durable environment knowledge that belongs in `root-app`'s CLAUDE.md, not in one machine's memory: start Docker Desktop first; `E2E_BROWSER_CHANNEL=msedge`; `prisma generate` after every `npm install`; revert the lockfile's `fsevents` noise; background Bash ignores a leading `cd`; never `git add -A` in the main checkout (agent worktrees would be committed as embedded repos).

**What worked, and is kept:** stage briefs that name exact sections (better than loading documents whole); `brief-common.md` — one shared lane brief holding environment, git rules, style and a six-part **lane report** (branch and hashes, files and why, exact suite counts, decisions the brief did not make, where the plan was wrong or vague, what could not be verified) that the reviewer reads before the diff; the orchestrator's **rolling state log** (main @ hash, lanes in flight with branch/database/ports/brief, next, carry-overs, open founder questions, owed); Sonnet builds, Opus reviews; a standing per-project review checklist; stage records with *decided* and *owed* sections; a worktree, database and port set per lane; the pre-build defect pass (`defects-found.md`, nine of ten fixed inside their assigned stages).

## 5. What changes in the lifecycle *(analysis — adopted into the plan)*

| Change | Lands in |
|---|---|
| One session per milestone at most. `/clear` once a handoff exists, not `/compact`. Never resume a large session after a limit reset — start fresh from the handoff | `handoff`, CLAUDE.md, `lifecycle/README.md` |
| Planning and orchestration in separate sessions; the plan is committed and pushed before the build starts | `build-plan` |
| Reviews in a fresh context: lane report, stage diff, phase card, review checklist — nothing else | `verify` |
| Lane budget: past twice its size, or near a limit reset, a lane commits WIP, writes its report and stops; a fresh lane continues | `build-phase` |
| Debug stop rule; no debugging through e2e; an environmental cause means fixing the test setup, not rerunning | `debug` |
| Parallel lanes only without shared schema changes; at most two | `build-plan` |
| Full suites only at milestones, enforced | `verify` |
| Fixed clock and clock-relative fixtures as a test convention | `root-app` CLAUDE.md |
| `brief-common` per project, and per-stage briefs ("phase cards") drafted just in time and committed | `projects/<project>/`, `build-phase` |

**Estimate, not measurement:** had each review session started near 50k tokens instead of 500k+, review turns would have cost about a tenth as much. With J1 stopped early and no cold resumes of the large session, a build of this size plausibly fits in about one weekly limit. The next comparable build tests this.

## 6. Open — to complete this retrospective

- [x] **The source documents are pushed** — `7fb81fc` (user journeys 0.7, build plan 0.2) on `root-sot` branch `journeys-build`, 2026-10-05. Not yet on `main`.
- [x] The orchestrator's memory files and `brief-common.md` recovered from the build machine, 2026-10-05 (§4 finding 6). Read as evidence; not committed — they hold machine paths and unrelated projects.
- [ ] **Final cost**, once the remaining dev work (owed items, review, merge to `main`) is done — the figures above stop at Oct 5 morning.
- [ ] **Owed items consolidated** from the stage records into `team/open-work.md` (e.g. J12: Persian native read of new strings, phone width, print).
- [ ] `/usage` (7-day attribution and flags) and `/insights` from the build machine, to check §3 against Claude Code's own breakdown.
- [ ] Whether the fixture-date fix (separate session, 2026-10-05) closed the time-bomb across all suites.
- [ ] Versus §5's estimate, after the next comparable build.

---

## Changelog

- **0.4 · 2026-10-06** — §5 aligned with the lifecycle plan: reviews read the lane report (they write the stage record); a stopping lane writes its report; phase cards are drafted by `build-phase`, `brief-common` lives in the project config.
- **0.3 · 2026-10-05** — Memory files and `brief-common.md` recovered: finding 6 corrected (state survived, but only on one machine); lane report and state log added to what worked.
- **0.2 · 2026-10-05** — Source documents found pushed; finding 6 (process state outside git) added.
- **0.1 · 2026-10-05** — Draft. Built from `journeys-build` @ `267a71d` and the build session's transcript-based account. Sections 1–5 written; §6 lists what completes it.
