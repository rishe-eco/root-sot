---
name: eval-plan
description: Writes a root-sot lifecycle module's evaluation plan (06-eval-plan.md, phase 6) — the failures that look alike in the data, the instruments and their preconditions, and decision rules written before any data with the ambiguous outcome named — after asking the founder what "drop" means and what follows the last check. With --touch-up <change note>, it fixes only what a change note made wrong, leaving the rules alone. Run by name only, after spec.
argument-hint: "<module folder> [--touch-up <change note>] [--override \"<reason>\"]"
disable-model-invocation: true
model: opus
effort: high
allowed-tools: Bash(bash "${CLAUDE_SKILL_DIR}/context.sh" *) Bash(bash */lifecycle/bin/gate *) Bash(git -C * add *) Bash(git -C * commit --only *) Bash(git commit --only *)
---

# eval-plan

Decide, before anything is built, how we will know whether the module works for the people it is for, and what we will do with each answer. The rules are written before the data, so that an ambiguous result can't be read as a pass afterwards. This skill is `lifecycle/skills-plan.md` §2 `eval-plan`.

**Start with one line:** `eval-plan · <full | touch-up> · <module> · Opus, <high | medium> effort`. This skill's frontmatter sets Opus. If you aren't Opus, say which model you are and stop before anything else. Effort here is ${CLAUDE_EFFORT}: full mode is high effort, a touch-up medium. If it differs, say so in that line and carry on.

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
- **Read the gate's first line.** `GATE FAIL`: say what it found, in its words, and stop. `GATE OVERRIDDEN`: carry on, and copy the reason into the plan's header.
- **A touch-up's own gate:** the spec's version must be newer than the one the plan names as its input (both shown above). If it isn't, say so and stop. If the change note isn't found, list the notes and stop.

## Full mode (`eval-plan <module>`)

1. **The failures that look alike.** From the spec's metrics and risks and the intake's drop rule, write down the ways the module can fail that would look the same in the data: low use because it is useless, because it is hard, because it isn't needed yet, because nobody found it. For each, say what tells it apart. If the drop rule couldn't be tested at intake, make it testable here, and say that you did.

2. **What is evaluated, and when.** Separate what `close-out` can judge (before launch, or at launch) from what matures after it, counted from launch, which is an event, not a phase (`README.md` §2). Name who runs each later check, and where they are reminded.

3. **The instruments.** One subsection each: the measure from the spec it serves (`M<n>`), its preconditions (a device, the domain, real data, a number of weeks), which `build-plan` places in the stage order, and its procedure. The spec defines measures; this plan owns instruments and rules. A measure the plan must refine goes to `§6 For revise` as an item, and the plan proceeds on its refinement.

4. **Ask the founder, in one batch** (`skills-plan.md` §0 *Asking the founder*), about consequences, not methods: what "drop" means for this module (stop, remove, pause, rescope), what happens after the last check, and any rule whose action only the founder can choose. At most four questions per call. Each says, in plain words, what each answer would make the plan do. Their answers are marked **[F]**.

5. **The decision rules, before the data.** A table of readings and actions, read top-down. At least one row's reading starts "Ambiguous", and its action says what happens then (usually: no decision, and what is collected next). The founder's answers go in as **[F]**. Everything else is *proposal*.

6. **Cost** (the founder's time per check, and anything paid for), and **what this can't do**, said plainly: what the evidence won't be able to tell us.

7. **Write `<module>/06-eval-plan.md`** from the template above, keeping every heading the gate checks. The rules heading must contain "before the data". Leave *Results* as an empty table for `close-out`. Delete every template comment.

## Touch-up (`eval-plan <module> --touch-up <change note>`)

1. Read the change note's items, and the spec sections they cite. Find what the change makes contradict the spec, and what it makes wrong in an instrument (a measure renamed, a precondition gone, a timing changed).
2. Fix those, and only those. **Decision rules stay unchanged** unless the founder decides otherwise in this session. A rule whose action cites a question the spec has since settled goes to the founder as a question, with both readings.
3. Log each fix in the changelog line: the spec version, the change note, each **[F]** decision, and the status cell it clears.

## Both modes

- **Grade:** everything here is *proposal* until data exists. Research findings keep their grade from `01-research.md`, cited by section.
- **Check it with the gate:** `bash <root-sot>/lifecycle/bin/gate <module> 7`. Its `06-eval-plan.md` line must say every heading and the "Ambiguous" row are met. The other inputs it lists are `build-plan`'s.
- **Write `status.md`,** your own cell only: column 6 reads `done`, clearing a `STALE` there in a touch-up.
- **Commit by path:** `git -C <root-sot> add <module>/06-eval-plan.md lifecycle/status.md`, then `git -C <root-sot> commit --only <module>/06-eval-plan.md lifecycle/status.md -m "eval-plan<: touch-up NN>: <module>"`, with the session's attribution lines. Don't push. root-sot is public, so a push needs the founder's yes in this session.

## How it ends

At most ten lines: the failures and instruments, the rules and the ambiguous row, the founder's decisions, the items for `revise`, the gate's line and the commit, ending with "not pushed". The next step is `build-plan <module>` (Opus, high) once phases 2 to 6 are done, or the next open phase among them. End exactly like this (`README.md` §5 rule 8):

Run `/handoff`, then `/learned`, then `/clear`, then paste:
```
Read the top block of `<module>/STATE.md` in root-sot (`<branch>`), then `<module>/06-eval-plan.md`. <The next step, with its model and effort.>
```
