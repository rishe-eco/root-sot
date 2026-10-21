---
name: start
description: The front door for a new idea in the root-sot lifecycle. It sorts the idea into a track (Module, Change or Fix), says where in the lifecycle it starts and which phases it will run, asks the founder which optional phases to skip, offering only skips a gate accepts, and prints the first skill's line to paste. Writes nothing. Run by name only, with the idea in a line or a paragraph.
argument-hint: "[the idea, in a line or a paragraph]"
disable-model-invocation: true
model: sonnet
effort: medium
allowed-tools: Bash(bash "${CLAUDE_SKILL_DIR}/context.sh" *)
---

# start

Turn a raw idea into the first line of its lifecycle: which track it is, where it enters, what it will run and skip, and the skill invocation that opens it. This skill decides the route and writes nothing. The skill it hands to records the route where the gates read it. This skill is `lifecycle/skills-plan.md` §1 `start`.

**Start with one line:** `start · Sonnet, medium effort`. This skill's frontmatter sets that model. If you aren't Sonnet, say which model you are and stop before anything else (`skills-plan.md` §0 *Model and effort*). Effort here is ${CLAUDE_EFFORT}. If it isn't `medium`, say so in that line and carry on.

The argument was: `$ARGUMENTS`

If the argument is empty, ask for the idea in a line and stop.

## What the files say

Injected when the skill started: the method's tracks, phases, status values and models, the status table, and any module whose name shares a word with the idea. Don't fetch these again.

```!
bash "${CLAUDE_SKILL_DIR}/context.sh" <<'LIFECYCLE_ARGS'
$ARGUMENTS
LIFECYCLE_ARGS
```

## Decide what you can from the words

1. **Is it new?** If a module above already covers it, it's probably a Change to that module, or work in flight there. Say which module, and treat that as your proposal.
2. **The track,** with the *Tracks* table above:
   - a defect in something that exists is a **Fix**;
   - a change to something built, with no new journeys or screens, is a **Change**: *small* if it is size S, one stage and no schema change, *during a build* if that module's build is in progress;
   - anything needing new journeys or screens is a **Module**.
3. **Its UI.** Whether people see it, or it is back-end only.

Grade each of these *proposal* and keep the reason to one clause.

## Ask, in one batch

Ask only what the words leave open, in one batch: at most four questions per call, and two calls in one turn count as one batch (`skills-plan.md` §0 *Asking the founder*). Put your proposal first in each question, marked (Recommended), with what the answer decides.

- **The track,** only if Change against Module or Fix against Change is unclear.
- **For a Module, the skips,** as one multi-select question. Offer only the skips a gate accepts:
  - *Research waived*: phase 1 doesn't run, and the intake carries a waiver line with the reason. Ask for the reason with it.
  - *No UI*: phases 3, 4, 4b, 5 and 9 are `n/a`. Offer it only when the idea is plausibly back-end only.
  - *No design pass*: phase 4b is skipped and the UX review reads the wireframes. Only for a module with UI.
- **For a Change, small or not,** only if the size is unclear. Small means note, build, verify and deploy in one session, and the founder chooses it (`README.md` §1).
- A Fix has nothing to skip: don't ask.

If the founder asks to skip something no gate accepts (the spec, the eval plan, a verify), don't offer a route around it. Say which phase it is, that its gate will refuse to start without it, and that the founder can pass `--override "<reason>"` to that phase's skill when it comes, which writes the reason into the output's header. List it under *Overrides to expect* in the output.

## What to print

At most 12 lines, then the fenced line:

```
start · Sonnet, medium effort
Track: <Module | Change | Change (small) | Change (during a build) | Fix> — <the idea in a few words>
Enters at: <phase or step, and its skill>
Runs: <the phases in order, e.g. "0 ideate → 2 spec → 3 personas, journeys → 4 wireframes → 5 ux-review → 6 eval-plan → 7 build-plan → 8 build → 9 live review → 10 close-out">
Skips: <each, with its reason, or "none">
Overrides to expect: <phase and reason, or leave the line out>
Next after this one: <the skill after the first, and its model>
```

Then: "Paste this now, in this session. It needs no `/clear`: the skill starts from what was said here." And the line, alone in a fenced block, the whole message:

| Track | The line |
|---|---|
| Module | `/ideate <area>/modules/NN-slug <the idea, in a line> · Skips: <research waived: reason>; <no UI>; <no design pass>` (leave out `· Skips:` if there are none) |
| Change | `/spec change <module folder> <what changes, in a line>` (add `· small` for a small Change) |
| Fix | `/debug <the symptom, in a line>` |

For a Module, take the area from the product it belongs to (`tracker/modules/` for Tracker, `ecosystem/modules/` for Root's own work and root-app, `<project>/modules/` for a project outside Root's areas) and NN from the next number for that area in the status table. If you can't tell the number, leave the folder out: `ideate` picks it.

The line must start with the slash and carry nothing before it, or the skill won't run (`skills-plan.md` §0 *Invocation*). If the first step is `debug`, add that Claude may also pick it up from the symptom alone.
