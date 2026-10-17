# 8d MS3 milestone — 2026-10-18

## Session
Opus 5.5 (`claude-opus-5-5`), effort **high**, as the founder stated. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 8d milestone MS3. Model: Opus, effort: high." Step, model and effort all matched the table. Nothing ran beside it. The founder said the 8c B7 cost was "just committed"; it wasn't on the remote at either push (I fetched before each), so root-sot's push may need a rebase once it lands.

## Read
- `lifecycle/trial-run/README.md`, whole; `lifecycle/README.md` §0–§4; `skills-plan.md` §0, `handoff`, `verify`.
- `STATE.md`, top block (8c B7 deployed, with the 10-18 addition).
- Inputs: `lifecycle/projects/imnstr/config.md`, whole (§6, the milestone script and MS3's by-hand row); plan 0.8 §3 (milestones) and §8 (*Outside the suites*); `imnstr/open-work.md` (header, V-items, changelog).
- *Outside the read order:*
  - the memory notes for this build;
  - `log/08d-MS2-milestone.md`, whole, for the shape and MS2's lessons (one worker; ask for devices first);
  - `docs/development/README.md`, to record the counts;
  - plan §6.1 (routes), to list what "every feature present" means on the live site;
  - `lib/record.ts` and `lib/record-middleware.ts`, by grep, so the live walk would not add to the reader record (only `GET 200` counts; curl's agent is a bot for R1/R3, but R2 counts bots, so feeds by `HEAD`);
  - `scripts/reset-content.ts`, by grep, to see that it clears episodes too;
  - `tests/e2e/auth.spec.ts`, by grep, for the 9 skips;
  - eval plan, by grep, for E1's rule (§4.1).

## Gate
- B5, B6, B7 and B8 are on `main` and verified (README stage list); status column 8 at `9/10`; nothing `STALE`.
- imnstr `main @ ca1b2aa` = `origin/main`, tree clean, `user.email` the founder's.
- The config's milestone script exists (§6).

**Gate passed.**

## Did
Milestone mode: the script, one heavy runner at a time, then MS3's by-hand row.
1. **Asked the founder first** (MS2's lesson 2), while the script ran: a phone today? **No.** May I push the record myself? **Yes**, "just double check".
2. **The script, in the main checkout, in the background, in order:** `npm ci --ignore-scripts` (205 packages, 0 vulnerabilities); `npm run check` (clean); `npm test`: **45 files, 948 passed**, 62 s; `npm run e2e`: **445 passed, 9 skipped**, one worker (MS2's fix held), 12.4 min. All green on the first run. The background task reported exit 1, which came from my wrapper's closing `tail -3` over several files, not a suite: each suite's own exit code was 0.
3. **The 9 skips** are `auth.spec.ts`'s dark runs, the same as MS2, by design.
4. **"Every feature present", live, by `curl`:** every public route in plan §6.1, both languages, `200` with `noindex`; both feeds `200` Atom (by `HEAD`); each language's `404`; `robots.txt` disallows all; signed out, the session, entries and episodes APIs answer `401`; `/__test/clock` answers `404`; the admin bundle is served (310,540 B, uncompressed: F-17). `/podcast` shows the founder's episode; `/log` shows two English test entries from 10-18.
5. **E1 not run:** no phone. MS3 recorded as *suites green, E1 owed*, and not closed.
6. **The record:** an MS3 section in `docs/development/README.md`, the same shape as MS2's. open-work 0.19 (V-9 holds MS3 open; V-8 is due now). Status column 8 unchanged (`9/10`): a milestone verifies no stage.
7. **The push:** checked first that `origin/main` hadn't moved, the Actions runs were idle and green, and the diff was one docs file with no stop file. Then `git push origin HEAD:main`. The permission check allowed it this time, after the founder's word.

## Output
- imnstr: `fdfda8b` (MS3 record), pushed; CI run 39074234512 green (check, deploy): https://github.com/rishe-eco/i-monster/actions/runs/39074234512
- root-sot: `imnstr/open-work.md` 0.19; a `STATE.md` block; this log.

## Spec gaps
- **The trial still has no word for a half-closed milestone.** MS2 closed its suites with by-hand items owed; MS3 is the same, but its by-hand item (E1) is the milestone's whole point ("E1 has passed at B6"). I recorded "suites green, E1 owed, MS3 not closed". The skill should give a milestone two states, *suites green* and *closed*, and name which by-hand items block closing.
- **"Every feature present" has no check behind it.** Config §6 lists it as a by-hand item, but nothing says how. I took plan §6.1's route table and walked it live. The skill's reference file should say: walk the route catalogue on production, both languages, and confirm the signed-out API refuses.
- **A live walk can pollute the product's own data.** IMNSTR records views and feed fetches; a careless `GET` of a feed adds a fetch to R2. The skill should say: read the project's analytics rules before touching production, and use `HEAD` or a bot agent.
- **A milestone verifies no stage,** so the status cell doesn't move; the trial README is silent on whether a milestone writes column 8. I left it.

## Template sample
The MS3 section of the development README: *suite / result / on* table (with MS2's counts beside, for growth); *Fixed at the milestone*; *By hand*, each item done or owed, and a line saying whether the milestone is closed. Require: the table with its commit, and the closed/not-closed line.

## Missing foundation
- No milestone states (see *Spec gaps*).
- No "every feature" checklist; plan §6.1 served.

## Founder Q&A
- **A phone for this session (E1, V-9)?** "No phone today."
- **May I push the MS3 record to `main` myself (a CI deploy, docs only)?** "Yes, push it yourself. Just double check, b7's costs were just committed." I checked both remotes before each push.

## Skill shape
Opus · high is more than this run needed: with green suites, the work was mechanical, and Sonnet · medium could run the script and write the record, handing to Opus only on a red suite. Not forked, because the founder answers device and push questions. Inject at invocation: `git log -1 origin/main`, the config's milestone row, open-work's V-items for the milestone, the latest Actions run, and the previous milestone's counts. Reference file: the per-milestone by-hand lists, the route catalogue walk (with the analytics caution), and the push check (remote unmoved, runs idle, no stop file).

## Lessons
1. **Rule:** before any live check on production, read how the product records visits, and use requests it won't count (`HEAD`, a bot agent). **Event:** MS3's walk nearly fetched both feeds by `GET`, which R2 counts whatever the agent; caught by reading `record-middleware.ts` first, at no cost. **Scope:** any project with first-party analytics. **Destination:** `verify` reference file; IMNSTR review checklist §7. urgent: no.
2. **Rule:** in a background suite script, end with a line that can't fail, and judge each suite by its own exit code. **Event:** the task reported "failed" because of a trailing `tail -3` over several files, while every suite passed. **Scope:** milestone scripts. **Destination:** project config §6 (the script could write each exit code itself). urgent: no.

## Cost
*Founder fills in.*

## Next
1. **8a B9**, the last stage. Its card carries what the 8c B7 block lists (`expectWithinColumn` into `support.ts`; the date input's clip at 180 px; contrast of B7's dark pairs).
2. **The founder:** F-17, then the phone check (V-9 with V-7). MS3 closes when E1 passes; then `reset-content` (plan §8).
3. V-8 is due: subscribe to both feeds in two aggregators.
