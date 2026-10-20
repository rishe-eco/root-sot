---
name: build-phase
description: Launches one build stage of a root-sot lifecycle module as a Sonnet lane, or lands it once the lane has reported. Launch runs the gate, checks the plan against the code, drafts and commits the phase card in briefs/<stage>.md, makes the lane's worktree and starts a background Sonnet subagent. --land saves the lane's report as briefs/<stage>.report.md, measures the diff and names verify as next. Run by name only, in phase 8 (Build) or a Change stage.
argument-hint: "<stage> [--land] [<module folder>] [--override \"<reason>\"]"
disable-model-invocation: true
model: opus
effort: medium
allowed-tools: Bash(bash "${CLAUDE_SKILL_DIR}/context.sh" *) Bash(git -C * add *) Bash(git -C * commit --only *) Bash(git commit --only *) Bash(git -C * worktree add *) Bash(git -C * fetch *) Bash(git -C * diff *) Bash(git -C * log *)
---

# build-phase

Build one stage at a time, each in a lane: a Sonnet subagent in its own worktree, with its own test database and ports, working from the project's common brief and a phase card committed before it starts (`lifecycle/README.md` §6). This skill writes the card and launches the lane, and later lands what the lane returns, so that `verify` can review it in a fresh context. It never reviews, merges or pushes code. This skill is `lifecycle/skills-plan.md` §3 `build-phase`.

**Start with one line:** `build-phase · <stage> · <launch | land> · Opus, medium effort`. This skill's frontmatter sets that model. If you aren't Opus, say which model you are and stop before anything else: the card is the lane's whole picture of the stage, so it is drafted by the model that reviews. Effort here is ${CLAUDE_EFFORT}. If it isn't `medium`, say so in that line and carry on.

The argument was: `$ARGUMENTS`

## What the files say

Injected when the skill started. Don't fetch these again.

```!
bash "${CLAUDE_SKILL_DIR}/context.sh" <<'LIFECYCLE_ARGS'
$ARGUMENTS
LIFECYCLE_ARGS
```

## Before either step

- **Read the gate's first line.** `GATE FAIL`: say what it found, in its words, and stop. The founder fixes the input or reruns with `--override "<reason>"`. `GATE OVERRIDDEN`: carry on, and copy the reason into the card's header line (launch) or the report's header line (land). If the injected section says `ROOT-SOT NOT FOUND`, or names no stage or module, say so and stop.
- **The step comes from the files,** not the prompt (`skills-plan.md` §0). If the argument names a stage that isn't defined, the injected section lists the stages that are. Name the near matches and stop. If the gate's notes say `STATE.md`'s next step is a different stage, say so in one line and ask whether to go on.
- **Paths.** Name checkouts in the card as `config.md` names them, never by this machine's path. The card and the report are read by sessions on other machines (`skills-plan.md` §0 *References*). Only the lane's launch prompt uses this machine's absolute paths.
- **Commit by path.** Run `git -C <root-sot> add <file>`, then `git -C <root-sot> commit --only <file> -m "<message>"`, with the attribution lines the session uses. Parallel sessions share the checkout, so commit nothing else (`skills-plan.md` §0 *Parallel sessions*). Don't push: root-sot is public, so a push needs the founder's yes in this session.

## Launch (`build-phase <stage>`)

1. **Room for the lane.** From *Lanes in flight* above: at most two lanes at once, and never two that change shared schema (`README.md` §6 rule 4). A stage changes schema when its section names a migration, a schema file or new tables. If either rule would break, stop and say which lane is in the way. If the code checkout isn't on this machine, ask the founder where to clone it, unless `config.md` names this machine's path. Then clone it there.

2. **Facts first.** List the P0 items the stage needs, or the change note's pre-flight, each marked done or open. Ask every open one in **one** question batch, together with the environment preconditions `config.md` names (Docker running, the founder's devices today). List every by-hand check that names the stage, from the open-work lines above. **An infrastructure stage** (a server, a deploy, a database or a secret) waits for the answers before you draft its card. Any other stage drafts now and folds the answers in when they arrive.

3. **Check the plan against the code,** in the checkout at the base branch's newest commit:
   - diff the stage's file list against the tree;
   - compare its screens with the design's plates;
   - read the migration for each table it writes;
   - on the Change track, re-read the note against the base branch since its `main @`.

   Then **grep the tests** for:
   - the stage's routes, tables and page names;
   - every literal it changes;
   - every request field a route starts reading;
   - every value class a new refusal covers;
   - every helper that does the same job, found by behaviour rather than one name (all the clock setters, not just `setClock`).

   Each test that asserts the stage's absence, or forbids what it adds, goes in the card's *Tests that change on purpose*, with its new rule. Each other mismatch goes in the card, flagged for verify.

4. **Draft the card** in the template above. It goes in `<module>/briefs/<stage>.md`. Work from the stage's section and from the code as it is now.
   - **500–700 words of body.** The header, the lane table and pasted facts don't count. Name exactly which plan sections, journeys sections and earlier stage records the lane reads. Past that range, cite the design's plate index rather than quoting copy.
   - **Over 1,000 words** means the plan section is underspecified. Say so in the closing message and in the `STATE.md` block.
   - **On the Change track,** when the note's stage already names files, tests and traps, the card defers to it and adds only the code check and the lane rules. *What to build* becomes *What this card settles*.
   - **Decided here** holds what the plan left open, including development dependencies added and how e2e gets its data.
   - **What the verify deploys,** from the project's first deploy on. Each deploy check must fail when what it guards is broken. The card doesn't assert a computed outcome it hasn't tried.
   - **Carry-overs.** A rule an earlier review marked "for every card", or an environment problem that cost a lane time, belongs in `brief-common.md`. Don't repeat it here: name it in the closing message as a proposal for the next `verify`.

   Delete the template's comments. If `briefs/<stage>.md` exists already, the gate said so: reuse it if it matches the code check, otherwise redraft it and say what changed. Commit it: `build-phase: <stage> card (<module>)`.

5. **Make the lane's worktree** from the slot in *Lane resources* that no live lane holds:
   - bring the local base branch up to date: `git -C <checkout> pull --ff-only` when it's checked out and clean, otherwise `git -C <checkout> fetch origin <base>:<base>`;
   - run `git -C <checkout> worktree add -b <branch> <checkout>/.claude/worktrees/<branch> <base>`. A local start point leaves the branch with no upstream, which is what a lane needs. The Agent tool's worktree isolation can't target another repo, so don't use it;
   - the base is `main` unless `config.md` or the card names another (root-app's isn't `main` until its two build branches merge).

6. **Launch the lane** with the Agent tool: `model: sonnet`, `run_in_background: true`, a description of `<stage> lane`. The prompt holds this machine's absolute paths:
   > You are the lane building <stage>. Your working directory is `<worktree>`. Bash calls don't start there, so begin every command with `cd <worktree> &&`, and use absolute paths with Read, Edit and Write. root-sot is at `<root-sot>`. Read `<root-sot>/lifecycle/projects/<project>/brief-common.md`, then `<root-sot>/<module>/briefs/<stage>.md`, and do what they say. When you stop, write your report in the seven parts of `<root-sot>/lifecycle/templates/lane-report.md` to `<worktree>/.tmp/<stage>.report.md`, and return it as your last message.

7. **Record the lane** in a new block at the top of `<module>/STATE.md`, in the block format above. The block names the stage's step `8a launch <stage>`, and *Lanes in flight* gets one row: stage and size, branch and its base `@ <hash>`, slot (database, ports), worktree (by `config.md`'s names), card, and status `running`. Its first next step is `build-phase <stage> --land`, written as a whole prompt for a cold session. Commit it: `build-phase: launch <stage> (<module>)`.

Don't write `status.md`. Column 8 counts verified stages, so `verify` writes it.

## Land (`build-phase <stage> --land`)

Land reads the report from `.tmp/<stage>.report.md`, so it can run in a later session than the launch. If the lane returned in this session, its last message is the report. If the two differ, use the file and say so.

1. **The commits.** The lane's branch exists, and its newest commit is the one the report's part 1 names. Check every commit's author against `config.md`'s commit identity, and check the lane's co-author line. Report any mismatch. Don't rewrite history.

2. **Measure from the recorded base,** the `@ <hash>` in the lane's `STATE.md` row, never from the base branch as it is now: `git -C <checkout> diff --numstat -M <base-hash>..<branch>`. Split the lines into app code, tests, and moved or renamed code. Then list the files that a newer base branch also touches: the overlap of `git diff --name-only <base-hash>..<base>` and the lane's files.

3. **Against the size.** Compare those lines, and the harness's time and tokens for the lane, with the stage's size. The time and tokens come from the Agent tool's completion notice in the launching session. Ignore the lane's own estimate. If the notice isn't in this session, write "not recorded" rather than guessing. A lane past twice its size is a finding for verify (`README.md` §6 rule 5).

4. **Save the report** as `<module>/briefs/<stage>.report.md`. Above the rule, add the template's header line (stage, branch, base, card, landed date, next step) and a second line: `**Measured at land:** +<app> app · +<tests> tests · <moved> moved · <time> · <tokens>, against size <S·M·L>`. Keep the lane's seven parts as written. Commit it: `build-phase: land <stage> (<module>)`.

5. **Hand it to verify.** Write a new block at the top of `<module>/STATE.md` that *replaces* the launch block's lane row (`8b land <stage>`). Put in it what verify must decide:
   - the lane's own calls (report part 4);
   - the card's *Decided here*;
   - card checks the lane didn't do;
   - changes to what the deploy runs;
   - departures from the note or the plan (report part 5);
   - the overlap with a newer base branch.

   Lanes in flight: the row stays, with status `landed`, until the stage is fast-forwarded and its worktree removed. Verify's return names that step. Its first next step is `verify <stage>`, written as a whole prompt for a cold session (Opus, high; it runs forked). Commit it: `build-phase: land <stage> (<module>)`.

Land doesn't push the lane's branch. If verify must run on another machine, the founder pushes it (`skills-plan.md` §0 *Outward-facing actions*).

## How it ends

At most ten lines: the stage and step, the card's word count (launch) or the measured lines (land), what you asked or flagged, and every commit made, ending with "not pushed". The block this skill wrote is the session's state, so the session doesn't run `/handoff` as well.

- After a launch, if the lane may return within this session, say "land it here when the lane reports". Otherwise end as below.
- Otherwise, end exactly like this (`README.md` §5 rule 8):

  Run `/learned`, then `/clear`, then paste:
  ```
  <the new block's first next step, word for word>
  ```
