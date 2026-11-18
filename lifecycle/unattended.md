# Unattended runs — the standing rule

*`bin/drive` appends this file to the system prompt of every step session it starts. Each session is fresh and headless, and nobody is there to answer. The founder's rule comes first, in their words. The rest says how a step session applies it to the lifecycle skills. Where a skill says to ask the founder, wait for their word, or stop for them, this file wins, except at an irreversible step.*

**Version 0.1 · Status: prototype · 2026-11-19 · Owner: _root (decision L-49)**

---

## The founder's rule

> You should continue working. If you encounter questions, try to answer them yourself. Log your decision. If and only if you get at a point where a change would be irreversible, that's the only place where you stop. Otherwise, make the best decision based on best practices and the canon and the vision. That's it.

## How a step session applies it

**1. Nobody is there.** This session was started by `lifecycle/bin/drive`, not by the founder. Text you write mid-session reaches nobody until morning. Don't ask questions, and don't open a question box. Don't end a turn waiting for an answer: a headless session that ends its turn has ended.

**2. A question becomes a call.** Where a skill says to ask the founder, or a choice is open, make the call yourself. Draw on these sources, in this order:
1. the module's own files: spec, journeys, wireframes, build plan, change notes and `decisions.md`;
2. the area's canon and vision (`ecosystem/`, and `tracker/canon/` for Tracker);
3. the project's `config.md`, `brief-common.md` and `review-checklist.md`;
4. best practice.

Prefer the choice that is easiest to undo and keeps the module smallest. Then **log it**: add one row to `<module>/calls.md` (create it from the format below if it's missing) and commit it by path with the step's other files. A call that the skill's output already records, such as a card's *Decided here* or a stage record's *decided*, still gets its row, so the founder has one place to read. Grade the call *proposal* (`skills-plan.md` §0 *Grades*). It is never written as the founder's decision.

**3. Stop only before an irreversible step.** These are irreversible here:
- any `git push`, to any remote. root-sot is public, and a code repo's `main` may deploy;
- a deploy, and any command on a production server or against production data;
- rewriting or discarding history: force-push, `reset --hard` over commits not saved elsewhere, deleting a branch or worktree with unmerged work;
- dropping or overwriting a database that holds anything but test data;
- anything sent outside this machine: messages, posts, issues, uploads, form submissions;
- spending money, accepting terms, or creating accounts, keys or secrets.

These are **not** irreversible, so keep going:
- local commits;
- fast-forwarding or merging a stage into the code repo's **local** `main`;
- removing a lane's worktree once its branch is merged;
- migrations and schema changes against test databases;
- edits to cards, tests, config files and docs.

At an irreversible step, don't take it. Do everything before it, commit, and stop (rule 5). A step that only *waits* on an irreversible one is skipped and recorded under **Owed**. The run goes on without it: for example, the push after a verify. Stop the run only when nothing useful can follow without that step.

**4. Blocked is not a question.** Sometimes there is no way forward at all, and no call would open one:
- a service the step needs is down, after one attempt to start it, such as Docker Desktop;
- `debug` has stopped after three failed hypotheses (`README.md` §6 rule 6);
- the gate fails on an input this step may not write;
- a usage limit is reached.

Then stop, with the cause, what you tried, and the command that resumes. Never loop: the journeys build's J1 lane lost ten overnight hours that way.

**5. How a step ends.** Every step session ends as follows, whatever the skill's own ending says:
1. Write the `STATE.md` block, as `handoff` would. Follow `lifecycle/skills/handoff/SKILL.md`'s *Steps* and *The block format* yourself, because a skill can't call a skill. Skip this if the skill you ran already wrote the block.
2. Put the **Drive line** in the block, directly under its first line (format below). `bin/drive` reads only this line to choose the next step.
3. Write `learned`'s capture notes as `lifecycle/skills/learned/SKILL.md` says, zero to three, if the session learned something about *working*.
4. Commit by path. Don't push.
5. End with at most ten lines: the step, its result, the calls logged, and anything owed.

**6. Launch and land are one step.** In an unattended run, `build-phase <stage>` runs its lane in the foreground: the Agent tool with `run_in_background: false`. A headless session can't wait for a background lane. When the lane returns, carry on with `--land` in the same session. Then write one block that replaces the launch block. Its Drive line is `run · /verify <stage> <module>`.

**7. After a verify.** The verify fork returns to this session, which acts as its main session. Do every *For the main session* item that rule 3 allows, without asking: fast-forward the local `main`, remove the lane's worktree and branch, and apply the correction-only edits and config changes, each logged in `calls.md`. Put each push under **Owed** as "push pending: founder". The stage then counts as verified for the next stage: build it on the local `main`. If the verify ended *blocked*, the Drive line is `stop`.

**8. Choosing the next step.** Next steps come from the files, in this order:
1. the build plan's stage order (or the change note's *Stages*);
2. `verify --milestone <M>` when the stage just verified closes a milestone;
3. at most one lane at a time. An unattended run doesn't run lanes in parallel.

When the last stage and its milestone are done, the Drive line is `done`. Phases after the build (live review, close-out) are not run unattended.

## The Drive line

One line, in the top block of `<module>/STATE.md`, directly under the block's first line:

```
**Drive:** run · /verify B3 tracker/modules/05-example
**Drive:** stop · <why, in a sentence> · resume: <what the founder does, then `lifecycle/bin/drive <module>`>
**Drive:** done
```

After `run ·` comes the next step's paste line, exactly as it would appear under *Next steps*: a skill invocation alone, or a whole plain-work prompt on one line. Only steps an unattended run may take go here. A `stop` names a reason, and a resume step where the founder has to act. Blocks written by hand during attended work may leave the Drive line out. `bin/drive` refuses to start without one.

## `calls.md` — calls made unattended

```
# Calls made unattended — <project> / <module>

*One row per call made without the founder during a `bin/drive` run (`lifecycle/unattended.md` rule 2). Newest last. The founder reads these after the run. Veto a row by writing a change note or running `revise`, never by editing the row.*

| # | Date | Step | The question | The call | Why (source) | To undo |
|---|---|---|---|---|---|---|
```

*Step* is the step's name, for example `8a+8b B3` or `8c B3`. *Why* cites the file and section, or names the best practice. *To undo* says what reverting it would take. A row that `revise` later settles gets ` · settled: <change note>` added to its *The call* cell, and nothing else.

## Changelog

- **0.1 · 2026-11-19** — Prototype. The founder's rule, adopted with the founder's go-ahead (L-49). Rules 1–8, the Drive line and `calls.md` were written to fit it.
