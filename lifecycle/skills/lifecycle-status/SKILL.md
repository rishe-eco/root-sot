---
name: lifecycle-status
description: Where root-sot's lifecycle work stands and what comes next. With a module, its phase from lifecycle/status.md, what is missing or stale, the next skill and its model. With a line of new work, which track it is (Module, Change or Fix). Also lists the founder's rows that are due and warns when the learnings inbox is over its cap. Writes nothing. Run by name only.
argument-hint: "[module | one line of new work]"
disable-model-invocation: true
model: sonnet
effort: low
allowed-tools: Bash(bash "${CLAUDE_SKILL_DIR}/context.sh" *)
---

# lifecycle-status

Answer "where are we, and what do I run next?" in under 15 lines, from the files below. The method is `lifecycle/README.md`, and this skill is `lifecycle/skills-plan.md` §1 `lifecycle-status`. It writes nothing and commits nothing, so it's safe at any point in a session.

**Start with one line:** `lifecycle-status · Sonnet, low effort`. This skill's frontmatter sets that model. If you aren't Sonnet, say which model you are and stop before anything else: the founder chose a cheap model for a read-only summary. Effort here is ${CLAUDE_EFFORT}. If it isn't `low`, say so in that line and carry on.

The argument was: `$ARGUMENTS`

## What the files say

Injected when the skill started. Don't fetch these again.

```!
bash "${CLAUDE_SKILL_DIR}/context.sh" <<'LIFECYCLE_ARGS'
$ARGUMENTS
LIFECYCLE_ARGS
```

## How to read it

**Which case this is.**
- **A module matched.** Its row in the status table and its top `STATE.md` block are above. Report on it.
- **Only near matches.** The argument may mean one of them, and the founder rarely types a row's exact name. If one near match plainly fits, say which one you took it to mean, then rerun `bash "${CLAUDE_SKILL_DIR}/context.sh" <its name>` to get its `STATE.md` and report on it. If several could fit, list them and stop (`skills-plan.md` §0: the step comes from the files, not from a guess).
- **Nothing matched.** The argument is new work. Sort it into a track with the *Tracks* table above, including its rule for Change against Module: new journeys or new screens make it a Module. A Fix is a defect in something that exists. Name the first step of that track's path. If the line is too vague to sort, say what one fact would decide it. Don't ask more than that.
- **No argument.** Give the whole picture: which rows have work in flight (column 8 part done, a `STALE` cell, a `done · owed` cell), and the top block of `lifecycle/STATE.md` if there is one.

**The phase.** A module is at the first phase whose cell isn't `done` or `n/a`, read with the status values above:
- `3/4` in column 8 is a build in progress;
- `closed · eval due` in column 10 means closed, with the evaluation still to come;
- `done · owed 4b` means a pass is owed on the column's sub-phase;
- `STALE` means that output contradicts a later change and must be redone before anything downstream of it.

A blank cell on a row from before the method usually means the phase was skipped, not that it is next. The backfill notes in `lifecycle/status.md` say so for each row. Don't send the founder back to write research for a module that's already built.

**The next step.** Where the module has a `STATE.md`, its top block's first next step outranks the table. It's the line the last session left to be pasted, so quote it. Otherwise take the next phase's skill from the *Phases* table and its model from the *Models* table. If that skill isn't in the list of skills written so far, say so: the step runs as a plain session that reads the skill's section in `lifecycle/skills-plan.md`.

**The founder's rows.** List any *From the founder* row whose *needed by* is the next step or earlier. If there are none, leave the line out.

**The inbox.** If the inbox section says `OVER CAP`, end with: `inbox over cap: N notes, oldest <date> — run learned --consolidate`. Consolidation runs in its own Opus session, so put it after the next step, not in place of it.

## What to print

At most 15 lines, in this order, leaving out lines that have nothing to say:

```
lifecycle-status · Sonnet, low effort
Track: <Module | Change | Change (small) | Fix> — <module, or the new work in a few words>
Phase: <n, name> · <what the row says, e.g. "8 Build, 3/4 stages">
Missing or stale: <cells or files, or "nothing">
Next: <skill> · <model, effort> — <one line; quote STATE.md's first next step when there is one>
From the founder: <rows due, each with its needed-by>
inbox over cap: N notes, oldest <date> — run learned --consolidate
```

Cite files by their path relative to root-sot (`imnstr/modules/01-website/STATE.md`), never a machine path. That's how a later session finds them (`skills-plan.md` §0 *References*). If the injected section above is missing or reports an error, say what failed and stop. Don't guess the state from memory.
