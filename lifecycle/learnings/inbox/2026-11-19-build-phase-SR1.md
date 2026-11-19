*Session: 2026-11-19 · tracker/modules/05-session-rhythm · build-phase SR1 (launch and land) · Opus · unattended*

## A launch may find a worktree holding an interrupted lane's uncommitted work — resume it, don't discard
**Rule:** Before `build-phase` launch creates or reuses a worktree, check `git status` in it. If a prior lane left uncommitted work (the stage's files present, no `.tmp` report, no stash — i.e. it was interrupted before committing or reporting), preserve it: launch the Sonnet lane *in that worktree* with a prompt that names the inherited work and tasks it to review against the card, finish/fix, run the targeted tests green, commit, and report. Don't `reset --hard`/`clean` and start fresh — discarding un-backed-up lane work is close to irreversible in spirit and wastes hours.
**Event:** SR1's `sr1-crossing` worktree already held a complete-looking but uncommitted SR1 build (19 files changed, 8 new, `TodayActionRow.tsx` deleted) from a prior `build-phase SR1` session that committed the card and made the worktree but never launched/landed. Resumed it (call 32); the lane finished green in ~34 min / ~215k tokens and committed 5 commits.
**Cost:** none beyond the diagnosis; it *saved* a full rebuild.
**Scope:** skill `build-phase` (launch, and unattended runs especially), method.
**Destination:** `build-phase` SKILL/reference — add a "resuming an interrupted worktree" check to launch step 5 (make the lane's worktree).
**Urgent:** no

## The measured-at-land metric is misleading for a resumed lane
**Rule:** When a lane resumed inherited work, label its land measurement (time, tokens) as covering the finish/verify pass only, not the original build, so `verify`'s size check (README §6 rule 5) isn't read against a partial figure. Line-count still measures the whole diff from the recorded base and is fine as-is.
**Event:** SR1 landed at ~34 min / ~215k tokens, but that was only the resumed pass; the original build's cost is unrecorded (the prior lane wrote no report). The land block and report flagged this explicitly.
**Cost:** a note, not time.
**Scope:** skill `build-phase` (land), skill `verify` (size check).
**Destination:** `build-phase` reference (land step 3).
**Urgent:** no
