---
name: wireframes
description: Draws a root-sot lifecycle module's low-fidelity wireframes (04-wireframes.html, phase 4) from its journeys — every journey step and state, grouped by screen, in the neutral frame kit — with the required Calls made here table and a coverage plate tracing every step to a frame. It renders the page at 1200 and 375 px and looks before committing. Run by name only, after journeys, for a module with UI.
argument-hint: "<module folder> [--override \"<reason>\"]"
disable-model-invocation: true
model: opus
effort: medium
allowed-tools: Bash(bash "${CLAUDE_SKILL_DIR}/context.sh" *) Bash(bash */lifecycle/bin/gate *) Bash(cp */lifecycle/templates/wireframes.html *) Bash(git -C * add *) Bash(git -C * commit --only *) Bash(git commit --only *)
---

# wireframes

Draw every step and state the journeys name, at low fidelity, so that the design step and the UX review start from the whole module and not from its happy path. Wireframes decide structure: what is on each screen, in what order, and what happens on each tap. They don't decide look. What they decide that the spec and journeys left open is written down as a call, so it can be accepted or refused. This skill is `lifecycle/skills-plan.md` §2 `wireframes`.

**Start with one line:** `wireframes · <module> · Opus, medium effort`. This skill's frontmatter sets that model. If you aren't Opus, say which model you are and stop before anything else. Effort here is ${CLAUDE_EFFORT}. If it isn't `medium`, say so in that line and carry on.

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
- **Read the gate's first line.** `GATE FAIL`: say what it found, in its words, and stop. `GATE OVERRIDDEN`: carry on, and copy the reason into the page's changelog line.
- If the module has no UI (column 4 is `n/a`), say so and stop.
- **Read** `02-spec.md` §4 whole, and the journeys' steps, states table and §4 Suggested above. A redraw also reads the existing page, keeps its plate numbers, and adds a draft line.

## Steps

1. **List** every journey step and every state, from the injected lists.

2. **Group them by screen.** One plate (an `<h2>`) per screen, numbered, with the states drawn on it in its title (`The log — empty, one entry, three, and long`). A step with no screen of ours is "no screen", or "not ours, drawn as context" when the person sees someone else's screen (an OS sheet, a feed reader).

3. **Draw by screen,** from a copy of the frame kit: `cp <root-sot>/lifecycle/templates/wireframes.html <module>/04-wireframes.html`, then edit the copy.
   - **Low fidelity:** the kit's neutral tokens only. Real copy only where the words are the requirement (an error's way out, an empty state's sentence, a label the spec fixes), placeholder bars elsewhere. No brand, type or colour decisions: those are step 4b's.
   - **A phone frame for every screen and state.** A desktop frame where the spec or the journeys call for one.
   - **Each frame's caption** cites its journey steps, criteria, spec section and state (`J1.1 · AC-1 · §4.1 · default`), and says in a line what the frame shows and why.
   - **Where a gesture sits on a link or a control,** say which one wins.
   - **Suggested items** are drawn only inside the kit's `.sugg` box, visibly marked with their id, never as plain UI.
   - **Persian or another right-to-left language** in the spec gets its frames drawn right to left, with `dir="rtl"`.

4. **Write *Calls made here*:** each behaviour these wireframes decided that the spec and journeys left open, numbered `W<n>`, graded *proposal*, with why and where. `ux-review` reads it, and `build-plan`'s gate needs each one accepted, refused or carried.

5. **Write the coverage plate:** every journey step to its plate, or "no screen" or "not ours" with a note; every state in the journeys' states table to its plates; every Suggested item, drawn or not, and where.

6. **Write the changelog and references:** `draft <n> · <date> — From 03-journeys.md <version> and 02-spec.md <version>`, and say that it was rendered and looked at. Delete the kit's instruction comment and the sample plate.

7. **Render and look.** Render the page at 1200 px and at 375 px wide, with the browser named above, to a scratch folder outside the repo, and read each image. Check that no frame overflows, every caption is readable, every `.sugg` box shows its id, and right-to-left frames read right to left. Fix and render again until they do. If nothing can render, say so in the changelog line and in the closing message, and don't claim it was looked at.

8. **Check it with the gate:** `bash <root-sot>/lifecycle/bin/gate <module> 4b`. Its `04-wireframes.html` line must say both headings are met.

9. **Write `status.md`,** your own cell only: column 4 reads `done`, or `done · owed 4b` when a design step is planned.

10. **Commit by path:** `git -C <root-sot> add <module>/04-wireframes.html lifecycle/status.md`, then `git -C <root-sot> commit --only <module>/04-wireframes.html lifecycle/status.md -m "wireframes: <module>, draft <n>"`, with the session's attribution lines. Don't push. root-sot is public, so a push needs the founder's yes in this session.

Don't ask the founder anything mid-draw. A choice the files leave open is a call (step 4), and the founder accepts or refuses it on the page.

## How it ends

At most ten lines: the plates and the frames on each, the calls made, the steps with no screen, what the render showed, the gate's line and the commit, ending with "not pushed". The next step is the design step (4b, the founder's, in a design tool) when it is planned, then `ux-review` (`design` mode). Without a design step, it is `ux-review` on these wireframes. Until `ux-review` is built (rollout stage 4), name it as the founder's step. End exactly like this (`README.md` §5 rule 8):

Run `/handoff`, then `/learned`, then `/clear`, then paste:
```
Read the top block of `<module>/STATE.md` in root-sot (`<branch>`), then `<module>/04-wireframes.html`. <The next step, with its model and effort.>
```
