# 08b CD1 land — 2026-10-15

## Session
The same session as 8a CD1 (Opus 5.5, high effort as the founder stated; the brief's table says medium). The lane's report came back to this session, and the 8a log's *Next* said to land it here, as at B4b. No new opening prompt.

## Read
- The lane's final message, and `<worktree>/.tmp/CD1.report.md` (the same text).
- In the code repo: `git log main..cd1-ci-deploy`, with authors; `git diff --shortstat`; `git status`. Nothing else: landing doesn't review the diff.
- `briefs/B4b.report.md`, the head only, for the file's shape.

## Gate
- The report has all seven parts.
- The branch exists, with 2 commits on `4c2b9b2`, both `TheMonster1995 <salmanian.foad2@gmail.com>`, and a clean tree.
- The lane finished without a stop (about 15 min wall time by the harness; the lane says about 1.5 h, which can't be right).

Result: pass.

## Did
1. Saved the report as `briefs/CD1.report.md`. The text is the lane's, with the title changed to match the other reports.
2. Wrote a `STATE.md` block. It replaces the 8a block's lane table, and lists for verify the four points the lane raised: the "already current" change, the comment trap, the unproven server setup, and the workflow never having run.
3. Committed and pushed. The worktree and branch stay for 8c.

## Output
- `briefs/CD1.report.md`; the `STATE.md` block; this log. All in one commit (hash in the next block or `git log`).
- Code repo: `cd1-ci-deploy` @ `8fd95a9`, local only.

## Spec gaps
- **The lane changed a behaviour the note specified,** and gave its reason in item 5. In the note, "already current" meant skipping build and up. After a failed build that is a false green, because the merge comes before the build. The lane was right to say so, not to follow the note quietly. `build-phase --land` has no step that brings such a change to the founder's attention ahead of verify. The STATE block's "for verify to decide" list does that job. The land step should require that list.
- **The size estimate was off by nearly 2×:** +1,285 lines against ~700. The harness and the README's server setup are larger than the note guessed. `spec change` should size a stage with a test harness, like `build-plan` does.
- **The lane's own time estimate was wrong:** it said 1.5 h, the harness measured about 15 min. The report should take its time from the harness, not from the lane.

## Template sample
The lane's seven parts, as `brief-common.md` lists them. Required: all seven.

## Missing foundation
None new.

## Founder Q&A
None.

## Skill shape
As at B4b: landing is mechanical. It could be Sonnet · low, apart from the "for verify to decide" list, which needs judgement about which report items change what the spec says. Inject: the report file, `git log --format='%h %an <%ae> %s' main..<branch>`, and `git diff --shortstat`.

## Lessons
- **Rule:** when a lane departs from the plan or the note, the land step lifts that departure into `STATE.md` for verify. It is not left inside the report's item 5. **Event:** the CD1 lane changed the "already current" path, for a sound reason. **Scope:** `build-phase --land`. **Destination:** its Land steps. **urgent:** no.

## Cost
Shared with 8a; see `08a-CD1-launch.md`, *Cost* ($4.35 for the whole session). Lane, by the harness: 189k tokens, 59 tool uses, about 15 min.

## Next
8c verify CD1 (Opus · high), in a fresh session, with the founder at the server and on GitHub. Before it: create the `production` environment. Start Docker Desktop if the review should run `shellcheck` and the Linux run locally; otherwise CI's first `check` does the Linux run.
