*Session: 2026-11-20 · tracker/modules/05-session-rhythm · verify --milestone MS2 (rerun, after SR9) · Opus 5.5*

## A fork's bounded wait on the milestone log worked a second time
**Rule:** None new. It repeats `2026-11-19-verify-MS1-rerun.md`'s second note: start the milestone script in the background, then wait with foreground loops that check the log for `EXIT` and end within the tool's 10-minute limit. This is the second time it has worked, so it is ready to fold into `verify` milestone step 2 at consolidation.
**Event:** Two loops covered the run: the first returned the API and client totals, the second the e2e total and `EXIT 0`. The whole run took about 15 minutes (API 327 s, client 86 s, e2e 7.4 min).
**Cost:** none.
**Scope:** skill `verify` (milestone) · forked skills generally
**Destination:** `lifecycle/skills-plan.md` §3 `verify`, milestone step 2 (founder's yes; merge with the MS1 rerun note)
**Urgent:** no

## The milestone script's log name doesn't say which milestone
**Rule:** The script in config §6 names its log `milestone-<date>-<time>.log`. Earlier runs added the milestone id by hand (`milestone-MS2-<date>-<time>.log`), so the script as pasted and the logs on the machine disagree. Put the id in the script (`out=.tmp/milestone-<M>-$(date …).log`) so every run names it the same way.
**Event:** This run pasted the script as written, and its log is `.tmp/milestone-20261120-0400.log`. Beside it in `.tmp/` are `milestone-MS1-20261119-*.log` and `milestone-MS2-20261120-0001.log`, from the earlier runs. The record cites the real name.
**Cost:** none. A log without the id is harder to find among the others.
**Scope:** project tracker
**Destination:** `lifecycle/projects/tracker/config.md` §6 (founder's yes)
**Urgent:** no
