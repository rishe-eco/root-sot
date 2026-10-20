---
name: debug
description: Bounded debugging for root-sot lifecycle build work in root-app, Tracker or IMNSTR. Use it when a test fails unexpectedly in a lane, a verify or a milestone run, or when the founder runs /debug. It runs the smallest reproducing test and one hypothesis per targeted run, fixes environmental causes in the test setup rather than rerunning, and stops after three failed hypotheses with a write-up in STATE.md.
argument-hint: "[the failing test or symptom, in a line]"
effort: high
allowed-tools: Bash(bash "${CLAUDE_SKILL_DIR}/context.sh" *) Bash(git -C * add *) Bash(git -C * commit --only *) Bash(git commit --only *)
---

# debug

Find why one thing fails, cheaply, and stop before debugging turns into a search. The journeys build's J1 lane lost hours rerunning the full e2e suite against a rate limit that a one-line test setup change would have fixed (retrospective finding 2). These rules exist so that doesn't happen again. This skill is `lifecycle/skills-plan.md` §3 `debug`.

**Start with one line:** `debug · <your model>, <effort>`. Debugging runs on the session's own model, at high effort. Effort here is ${CLAUDE_EFFORT}. If it isn't `high`, say so in that line and carry on.

The failure: `$ARGUMENTS`

## What the files say

```!
bash "${CLAUDE_SKILL_DIR}/context.sh" <<'LIFECYCLE_ARGS'
$ARGUMENTS
LIFECYCLE_ARGS
```

## The rules

1. **Reproduce it with the smallest test.** Use one file, and one test in it (`-g <name>`, `-t <name>`), with quiet output. If the failure appeared in a full run, find the single test that shows it and run that alone. Use the suite commands and the slot's variables above, exported in the same command.

2. **One hypothesis at a time.** Before each run, write the hypothesis in one line and say what result would confirm or refute it. Then make one targeted run, and read its result against that line. Don't change two things between runs, or you won't know which one mattered.

3. **Never debug through the full e2e suite.** A full run takes about 30 minutes on IMNSTR, and hides the one failure among many. It is for milestones, run by `verify --milestone`.

4. **An environmental cause is fixed in the test setup, not rerun.** Rate limits, the clock, the database, ports, a shared server, leftover state: if the test fails because of where it runs, change the setup so it can't happen again. Fix the fixture, the fixed clock, the per-lane database or the port variables. A rerun that passes proves nothing about the next run. Tests run against a fixed clock, with fixtures relative to it (`lifecycle/README.md` §6 rule 8).

5. **After fixing a shared rule, rerun every test file that asserts it.** Also rerun every file that imports or renders through a changed helper. Find them with grep, not memory.

6. **Don't edit a test file that a running full suite has loaded.** Fix it after the run, then rerun that file alone. The runners above show what is running now. App source may change mid-run if the server loads it once at the start.

7. **A failure with no cause found** after the fix attempts is run alone five times. If it passes some of those times, record it as a flake, with its pass count, in the stage record or the lane report. Never call it fixed.

## Three failed hypotheses: stop

After the third hypothesis that the run refutes, stop debugging. Write what is known as a new block at the top of the module's `STATE.md` (`README.md` §4 lets `debug` write it here). Use the files listed above, or `lifecycle/STATE.md` for a Fix with no module. Use the block format in `lifecycle/skills/handoff/SKILL.md`, and name the step `debug <the failure>`. The block holds:
- the failure, with the exact command that reproduces it, and its output's key lines;
- each hypothesis, the run that tested it, and what the run showed;
- what is ruled out, and what is left;
- the first next step, as a whole prompt for a cold session: what to try next, on which branch and checkout, at which model and effort.

Commit it by path: `git -C <root-sot> add <STATE.md>`, then `git -C <root-sot> commit --only <STATE.md> -m "debug: stop on <the failure>"`, with the session's attribution lines. Don't push.

**In a lane,** the lane budget also applies (`README.md` §6 rule 5). Commit the work in progress, write the lane report with the failure in part 6, and stop. Don't write `STATE.md`: the session that lands the lane does that.

## How it ends

- **Fixed:** the cause in one line, the fix and its commit, and the files rerun with their counts. Then go back to the work that called you.
- **Stopped:** "stopped after three hypotheses", the `STATE.md` block's path, and "not pushed". If this ends the session, finish as `lifecycle/README.md` §5 rule 8 asks: run `/learned`, then `/clear`, then paste the block's first next step, in a fenced block.
