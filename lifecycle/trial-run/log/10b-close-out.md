# 10b Close-out — 2026-10-19

## Session
Opus 5.5 (`claude-opus-5-5`). **Effort wasn't stated:** the opening prompt was "Steps are almost done for life cycle trial run, can you do step 10b?". It named no branch, model or effort. Claude desktop app (Code tab), on Linux at `/home/gholi/Desktop/Root/Root`, not the build machine (`E:\_root`). The checkout was already on `lifecycle-trial/imnstr` but **86 commits behind** origin. Pulled before the gate.

## Read
- `lifecycle/trial-run/README.md`, whole.
- `lifecycle/README.md` §0–§4 and §7.
- `skills-plan.md` §0, `learned` and `handoff` (in one range), and `close-out`.
- `STATE.md`: the top three blocks; after that, the 10a, MS4, MS3 and MS2 blocks for the milestone states (outside the read order, needed to state them); and every block's heading.
- `lifecycle/status.md`.
- **Inputs:**
  - `06-eval-plan.md`, whole;
  - every log's *Cost* section, by `awk` over `log/`;
  - `imnstr/open-work.md`, the open rows (`grep -v '~~'`);
  - `07-build-plan.md` and `02-spec.md`, their changelogs and version lines;
  - `changes/`, the listing.
- **Outside the read order:**
  - logs `08d-MS3`, `08d-MS4`, `08c-B6` and `09-live-review`, by grep for E1/M3, to confirm E1 never ran;
  - `08c-*` logs, by grep, for *Flagged for close-out*, because the stage records were out of reach;
  - `log/10a-consolidate.md`, whole, for the lessons consolidated;
  - `05-ux-review.md` and `08-design-review.md`, the summaries;
  - `00-intake.md`'s header, for the start date.
- **Couldn't read:** the stage records in `rishe-eco/imnstr` `docs/development/`. The repo returns 404 to this machine's GitHub account (`markRiceOld`), over both https and ssh.

## Gate
`close-out`'s gate: every stage verified, milestones green, the learnings inbox consolidated.
- **Stages:** all verified. Column 8 is `10/10`, and PL1 and CS1 (Changes) are verified and deployed (8c PL1 and 8f CS1 blocks). **Pass.**
- **Milestones:** MS1 was done at B2's verify, and MS2 has its suites done with V-7 partly owed. **MS3 and MS4 aren't closed:** E1 (V-9) and V-5 are owed (open-work 0.23), and the 8c PL1 block says "10b close-out waits for MS3 (V-9) and MS4 (V-5)". **Fail.**
- **Inbox:** consolidated at 10a; the decisions were made there, and applying them is left to 10c. **Pass.**
- Nothing in `status.md` is `STALE`.

**GATE FAIL.** Asked the founder (Q&A 1). The founder overrode it: close anyway.

## Did
Mapped to `close-out`'s *Writes*:
1. **Evaluation against the rule:** E1 has no data, so no reading. Stated plainly, with what stands in for it (suites, the live walk) graded *as-built*, not as a reading. E2 dates are set relative to launch, because launch hasn't happened.
2. **What the plan didn't know, added up:** from plan changelog 0.2–0.8, change notes 04–06 and the open-work canon flags. The records' own sections were out of reach.
3. **The module's cost:** every log's *Cost*, summed with shared sessions counted once; lane tokens and minutes from the harness figures.
4. **Retrospective:** short, with 10a's consolidation counts.
5. **Moves to canon, canon-sync flags, roadmap:** **skipped.** Trial rule 4 limits what this step writes. The flags (F-11, F-14, F-19–F-21) are listed in §2 for the founder.
6. **Status row closed** as `closed · eval due`, by the founder's override.
7. `open-work.md` **not touched:** `close-out` is one of its writers (README §4), but trial rule 4 doesn't list it.

## Output
- `imnstr/modules/01-website/09-close-out.md` 0.1.
- `lifecycle/status.md`, column 10: `closed · eval due`.
- A new top block in `STATE.md`, and this log.
- Commit: see `git log` (one commit, "IMNSTR trial step 10b").

## Spec gaps
1. **The gate has no override, and no state for a half-closed milestone** (MS3's and MS4's logs said the same). The founder overrode it in chat. The skill should allow a recorded override, with its reason, and the close-out's header should say so.
2. **`status.md` can't say "closed, evaluation owed".** The cells are blank, done, n/a or STALE, and `close-out` closes as done, parked or killed. I wrote `closed · eval due`, as 06's log proposed (`closed · eval <date>`). No date was possible: E2 counts from launch, and launch hasn't happened.
3. **The eval plan assumed E1 would have run by close-out.** E1 needs the founder's phone, and so does every milestone's by-hand check. No skill owns "the module's own success measure is still owed". The close-out had to separate "closed" from "launch-ready".
4. **Launch isn't a phase.** The eval plan defines launch as the first real entry on production. The lifecycle has no step for it, so close-out can't write E2's dates, which the eval plan expects it to (§2).
5. **The stage records live in the code repo,** and this session couldn't reach it. The skill reads "every stage record's *decided* and *owed*". It should inject them, or the plan's changelog and open-work should be named as the fallback, as I used them.
6. **Weekly-limit shares were never recorded.** The skill asks for "share of weekly limits", but the logs hold dollars and tokens. `/usage`'s share should be taken in each log's *Cost*, or the skill should ask for dollars.
7. **Shared sessions muddy the per-step cost:** 8a and 8b in one session, PL1's verify with CS1, and 08e over two days. The total is still right if each session counts once. Each log should say "this session's figure is in log X" (most did).
8. **Close-out's canon writes don't fit the trial,** under rule 4, and IMNSTR has no canon area; its "canon" is the spec, plan, design README and `CLAUDE.md`. Listed, not applied.

## Template sample
`09-close-out.md`: *Summary* · *1. Evaluation against the rule written beforehand* (one subsection per evaluation, each with rule, result and reading) · *2. What the plan didn't know, added up* · *3. The module's cost* (table by part; not in the total; lanes; limits; wall time) · *4. Retrospective* · *Changelog*.
Required: Summary, Evaluation, What the plan didn't know, Cost, Retrospective.

## Missing foundation
- Access to `rishe-eco/imnstr` from this machine. Used the build plan's changelog, `open-work.md` and the verify logs instead.
- A `bin/gate` override mechanism, and a closed-with-eval-owed status.
- `learnings/index.md`, for "lessons consolidated during the module". Used 10a's log.

## Founder Q&A
1. *10b's gate needs MS3 (V-9, the E1 timing runs) and MS4 (V-5, feed readers). Neither is recorded as done. How should I go on?* Options: log the gate failure and stop (recommended); "I've done them"; close out anyway. → **"Close out anyway".**

## Skill shape
- **Opus, high, not forked.** It needs the founder for the gate, and maybe for the evaluation.
- **Inject:**
  - every log's *Cost* (`awk`);
  - the status row;
  - the open rows of open-work;
  - the plan's and spec's changelogs;
  - the eval plan's §4 and §5;
  - each stage record's *Decided*, *Owed* and *Flagged for close-out* (`git show` from the code repo, if it's mounted).

  That would have saved about 8 of this session's calls.
- **Reference file:** the cost table's parts; how to count shared sessions once; the override wording; the closed-with-eval-owed state.

## Lessons
1. **Rule:** when a module's success measure needs the founder's device, schedule it as a dated founder task when the plan is accepted, not at a milestone. Close-out shouldn't be the first step that finds it still open. **Event:** E1 was owed at B6, MS3, MS4 and step 9 ("No phone today" each time), and 10b closed with no reading. **Scope:** `build-plan`, `eval-plan`. **Destination:** `eval-plan` reference; L15's founder-device batch. `urgent: no`.
2. **Rule:** a session opened without the trial's standard prompt still pulls first, and states its model and the missing effort. **Event:** this checkout was 86 commits behind. Before pulling, it showed B2 unverified and the step as impossible. **Scope:** every phase skill (10a's L4, L5). **Destination:** `skills-plan.md` §0, *The gate*. `urgent: no`.

## Cost
*Founder fills in after the session.*

## Next
- **The founder:** F-17, V-9 with V-7, V-5 with V-8, then launch (F-2, F-7, `reset-content`). On launch day, E2's dates go in eval plan §5.
- **A `revise` session** for F-20 and F-21 (spec 0.5).
- **10c trial wrap-up:** take this log's *Spec gaps* 1–4 with 06's log, gap 2, and MS3's: they are one gap, a module closing with its evaluation owed.
