---
name: ideate
description: Opens a new root-sot lifecycle module (phase 0) by turning the founder's idea into a one-page intake. It asks the founder the intake's questions in one batch, then creates the module folder with 00-intake.md and STATE.md, adds the module's row to lifecycle/status.md and commits by path. Run by name only, when an idea should become a Module.
argument-hint: "[<area>/modules/NN-slug] [the idea, in a line]"
disable-model-invocation: true
model: sonnet
effort: medium
allowed-tools: Bash(bash "${CLAUDE_SKILL_DIR}/context.sh" *) Bash(bash */lifecycle/bin/gate *) Bash(git -C * add *) Bash(git -C * commit --only *) Bash(git commit --only *)
---

# ideate

Write down what the founder wants, in their words, on one page, so that every later phase measures itself against the same intake: what the problem is, who it is for, the smallest version worth trying, and what would make us drop it. This skill opens the module. It doesn't research, design or judge the idea. This skill is `lifecycle/skills-plan.md` §2 `ideate`.

**Start with one line:** `ideate · <module> · Sonnet, medium effort`. This skill's frontmatter sets that model. If you aren't Sonnet, say which model you are and stop before anything else (`skills-plan.md` §0 *Model and effort*). Effort here is ${CLAUDE_EFFORT}. If it isn't `medium`, say so in that line and carry on.

The argument was: `$ARGUMENTS`

## What the files say

Injected when the skill started. Don't fetch these again.

```!
bash "${CLAUDE_SKILL_DIR}/context.sh" <<'LIFECYCLE_ARGS'
$ARGUMENTS
LIFECYCLE_ARGS
```

## Before you ask

- If the injected section says `ROOT-SOT NOT FOUND`, say so and stop. If root-sot is behind its upstream, say so and stop.
- **Is it a Module?** If the idea is a change to something built, with no new journeys or screens, it is a Change, and `spec change` opens it. If it is a bug, it is a Fix, and `debug` opens it (`README.md` §1). Say which, and stop, unless the founder says it is a Module.
- **Is it new?** If one of the modules listed above already covers it, name that module and ask whether this is a new module or a change to that one.
- **The folder.** The area that owns the product: `tracker/modules/` for Tracker, `ecosystem/modules/` for Root's own work and root-app, `<project>/modules/` for a project outside Root's areas. Number it with the next number shown for that area, and name it with a short slug. If the argument named a folder that already exists, stop: this skill opens new modules only.

## Ask, in one batch

Ask everything the intake needs that the founder's words don't already answer, in one batch: at most four questions per call, and two calls in one turn count as one batch (`skills-plan.md` §0 *Asking the founder*). Each question says in plain words what the answer decides.

1. **Problem:** what is wrong today, and for whom.
2. **Pillar and place on the opportunity tree:** the pillar it serves, from the list above, and its node on the tree, if the founder has one. For work outside Root, "n/a, outside Root" and why.
3. **Who it is for,** described by what they do, not by demographics. `personas` selects from these later.
4. **The smallest version worth trying:** what is in, and what is out of scope. `revise` measures scope growth against this, so the out-of-scope list matters.
5. **What would make us drop it.** Record the answer word for word. If it can't be tested, say so in the intake, so that `spec` and `eval-plan` can make it testable. Don't make it testable yourself.
6. **Decisions at intake:** whether research runs or is waived, and why; the code repo, or "none yet"; whether the module has UI (if not, phases 3, 4, 4b, 5 and 9 are `n/a`); and the project, for `lifecycle/projects/<project>/`.

If the argument carries a `Skips:` part from `start`, it already answers question 6's research and UI parts: write them in, and ask only what's left. Offer a proposed answer where the files suggest one (a project from the area, a pillar from the problem), marked as Claude's proposal. An answer that is itself a question, or that widens the idea, is a new item: propose a bounded reading and ask again.

## Write

1. **`<module>/00-intake.md`,** from the template above. Keep every heading the gate checks. One page and no sources: this is the founder's description, graded *proposal*, with the drop rule quoted. Delete every template comment.
2. **`<module>/STATE.md`:** a title line, `*Newest block first. Written by handoff, and by build-phase when it launches or lands a lane.*`, then the first block, in the block format above. The step is `0 intake`. Its first next step is the next phase, written as a whole prompt for a cold session: `research` (Opus, high) if research runs, or `spec full <module>` (Opus, high) if the intake waives it.
3. **The `status.md` row:** one new row at the foot of the table, before the blank line. It reads `| [<Module name>](../<module>/) | Module | done |` and then ten cells: blank, or `n/a` for the UI phases when the module has no UI. Don't touch any other row.
4. **Check it with the gate:** run `bash <root-sot>/lifecycle/bin/gate <module> 1`. Its `00-intake.md` line must say every heading is met. If the research is waived, run `gate <module> 2` as well, and check that it says so.
5. **Commit by path,** these three files only: `git -C <root-sot> add <files>`, then `git -C <root-sot> commit --only <files> -m "ideate: <module> intake"`, with the session's attribution lines. Don't push. root-sot is public, so a push needs the founder's yes in this session.

## How it ends

At most eight lines: the module folder, the drop rule and whether it is testable, what was waived, the gate's line, and the commit, ending with "not pushed". The `STATE.md` block this skill wrote is the session's state, so the session doesn't run `/handoff` as well. End exactly like this (`README.md` §5 rule 8):

Run `/learned`, then `/clear`, then paste:
```
<the new block's first next step, word for word>
```
