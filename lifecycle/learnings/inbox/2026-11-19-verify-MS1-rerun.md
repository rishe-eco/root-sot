*Session: 2026-11-19 · tracker/modules/05-session-rhythm · verify --milestone MS1 (rerun) · Opus 5.5*

## Config §6's milestone script now runs as written, end to end
**Rule:** None new. The script with `npx prisma generate` first (config 0.6) is the one to run; config §6's "it still hasn't run as a script" is now stale.
**Event:** The script, pasted from config §6 into one background Bash call in `E:\_root\tracker`, ran `prisma generate`, the API suite, `tsc`, the client suite and the e2e suite one after another and ended `EXIT 0` in about 11 minutes (`.tmp/milestone-MS1-20261119-2223.log`).
**Cost:** none.
**Scope:** project tracker · skill `verify` (milestone)
**Destination:** `lifecycle/projects/tracker/config.md` §6 (drop "it still hasn't run as a script"; founder's yes)
**Urgent:** no

## A fork waits on a long suite with a bounded foreground loop, not by ending its turn
**Rule:** A forked `verify` that starts the milestone script in the background waits for it with a foreground loop that checks the log for the end marker and exits within the tool's 10-minute limit (`for i in $(seq 1 57); do grep -q EXIT log && break; sleep 10; done`), re-run until it ends. A Monitor alone gives events but the fork must keep a tool call open to receive them; ending the turn returns the fork with the run unread.
**Event:** Two bounded loops covered the API total and then the client and e2e totals; the Monitor's events arrived alongside them.
**Cost:** none.
**Scope:** skill `verify` (milestone) · forked skills generally
**Destination:** `lifecycle/skills-plan.md` §3 `verify`, milestone step 2 (founder's yes)
**Urgent:** no
