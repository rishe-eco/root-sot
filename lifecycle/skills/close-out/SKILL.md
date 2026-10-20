---
name: close-out
description: Finishes a root-sot lifecycle module (09-close-out.md, phase 10) — judges it against the eval plan's rule written beforehand, adds up what the plan didn't know from every stage record, records its cost from /usage, writes a short retrospective, applies the canon-sync flags, and closes the status.md row as done, parked or killed, keeping closed, launch-ready and evaluated separate. With --eval, it appends a later evaluation's result and clears the cell. Run by name only, after every stage is verified.
argument-hint: "<module folder> [--eval] [--override \"<reason>\"]"
disable-model-invocation: true
model: opus
effort: high
allowed-tools: Bash(bash "${CLAUDE_SKILL_DIR}/context.sh" *) Bash(bash */lifecycle/bin/gate *) Bash(git -C * add *) Bash(git -C * commit --only *) Bash(git commit --only *) Bash(git -C * fetch *) Bash(git -C * log *) Bash(git -C * mv *)
---

# close-out

Close the module honestly: say whether it did what the eval plan said it must, by the rule written before the data; what the plan didn't know; what it cost; and what the next module should do differently. Closing, launching and evaluating are three different facts, and this skill keeps them apart. This skill is `lifecycle/skills-plan.md` §4 `close-out`.

**Start with one line:** `close-out · <full | --eval> · <module> · Opus, high effort`. This skill's frontmatter sets that model. If you aren't Opus, say which model you are and stop before anything else. Effort here is ${CLAUDE_EFFORT}. If it isn't `high`, say so in that line and carry on.

The argument was: `$ARGUMENTS`

## What the files say

Injected when the skill started. Don't fetch these again.

```!
bash "${CLAUDE_SKILL_DIR}/context.sh" <<'LIFECYCLE_ARGS'
$ARGUMENTS
LIFECYCLE_ARGS
```

## Before you start

- If the injected section says `ROOT-SOT NOT FOUND`, or names no module, say so and stop. If root-sot is behind its upstream, say so and stop.
- **Read the gate's first line.** `GATE FAIL`: say what it found, in its words, and stop. The usual causes each have their skill: a stage not verified (`verify`), the inbox not consolidated (`learned --consolidate`), a change note whose spec catch-up is pending (`revise --catch-up NN`). The founder may override with a reason. `GATE OVERRIDDEN`: carry on, and write the reason, with the founder's [F] and the date, in the close-out's header.
- **The cost needs the founder:** ask them for the `/usage` figure in dollars, and the session-limit share where it is shown, in the same batch as step 3's questions. Never estimate a figure you could be given. A part you can only estimate is marked *estimated*, with how.
- If the code repo isn't on this machine, the stage records above are replaced by the plan's changelog and the open-work file. Say so in the header's *Inputs*.

## Full mode (`close-out <module>`)

1. **The evaluation, against the rule written beforehand.** For each evaluation that `06-eval-plan.md` §2 says `close-out` judges: quote the rule, give the result with its source, and name the rule's row that applies, or "Ambiguous" when the result fits none. Don't reinterpret a rule after seeing the data. An evaluation that couldn't run says so, and why, and the module is then not shown launch-ready on it.

2. **What the plan didn't know, added up:** from every stage record's *Decided* (the lane's calls and what the review changed), every lane report's part 5, and the change notes and requests written during the build. Group the items by kind (spec gaps, plan errors, environment, tooling), count them, and name the worst few.

3. **Closed, launch-ready and evaluated are separate.** Ask the founder, in one batch (`skills-plan.md` §0 *Asking the founder*): launch's date, or "not yet"; whether the row closes as done, parked or killed; and whether to create the reminders for the later checks. Write the later checks' dates counted from launch, or "due, counted from launch" when launch hasn't happened. A reminder is a `/schedule` task, created only with the founder's yes, and named in the close-out.

4. **The cost**, in the template's table: design phases, lanes, reviews, and the total, each exact or estimated, with its source. Steps run outside Claude Code (a design tool) are estimated from the limit percentage at their start and end. Add the wall time.

5. **The retrospective:** short. What went well, what to change, and the lessons consolidated during the module (from the learnings index above).

6. **What close-out changes,** and records in §5 of the close-out:
   - **the canon-sync flags** from every stage record's *Flagged for close-out*: the as-built canon `config.md` names (data model, API, glossary, the code repo's `CLAUDE.md`) is written here. Design-side files (the spec, the plan, the design README) go through `revise --catch-up`, which is named as the next step instead;
   - **documents moved from `working/` or `drafts/` into canon,** with `git mv`, per the area's conventions (`ecosystem/README.md`);
   - **each design document's *Grading* line**, saying what is now as-built and citing the stage records;
   - **the roadmap** (`ecosystem/roadmap.md`, or the project's state-of-the-build file);
   - **the `status.md` row:** column 10 reads `closed` when every evaluation is judged; `closed · eval <date>` or `closed · eval due` while one is owed; `parked` or `killed` as the founder said.

7. **Write `<module>/09-close-out.md`** from the template above, keeping every heading the gate checks. Delete every template comment.

8. **Commit by path:** the close-out, `status.md`, and each file step 6 changed in root-sot, with `close-out: <module>`, and the session's attribution lines. A file in a code repo is committed there, and its push waits for the founder's yes: a push to a `main` that deploys is a deploy. Don't push root-sot without the founder's yes either.

## A later evaluation (`close-out <module> --eval`)

When a check from the eval plan's §2 has come due. Run it as the eval plan's instrument says, or take the founder's result. Apply the rule, as in full mode step 1. Append the result to the eval plan's §5 *Results* and to the close-out's §1 and changelog, with the date and the reading. When it was the last check, column 10 reads `closed`. Commit by path, with `close-out --eval: <module>, <check>`.

## How it ends

At most twelve lines: closed, launch and evaluated, each stated; the reading of each rule; the plan's unknowns, counted; the cost; what was moved, synced or left for `revise --catch-up`; the reminders created; the commits, ending with "not pushed" or the push. The next step is `revise <module> --catch-up <notes>` (Opus, medium) when design-side flags remain, or the module's next later check, or none. End exactly like this (`README.md` §5 rule 8):

Run `/handoff`, then `/learned`, then `/clear`, then paste:
```
<the next step as a whole prompt, or "No next step for <module>: closed.">
```
