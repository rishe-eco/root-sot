*Session: 2026-10-20 · lifecycle · rollout stage 2, session C (B-15 on the Fix track) · Opus 5.5*

## `/debug` reads the session's starting folder, not the code checkout

**Rule:** Start a Fix or build session from the code checkout, or make `debug`'s `context.sh` resolve the project from `config.md` when the session starts in root-sot.
**Event:** `/debug Goal Group status always "Backlog" (B-15)` ran from `~/Desktop/Root/Root` and injected "Project: root-sot (the method itself; no suites)" while the work was in `~/Desktop/Root/tracker`; the suites were taken from `lifecycle/projects/tracker/config.md` §3 by hand.
**Cost:** small: the injected suites and runners were useless for the run
**Scope:** skill `debug`
**Destination:** `lifecycle/skills/debug/SKILL.md` and `context.sh`
**Urgent:** no
