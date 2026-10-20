---
name: build-plan
description: Writes the build plan a root-sot lifecycle module is built from (07-build-plan.md, phase 7) — what it is written against, planning decisions, stage order, pre-flight, one section per stage with size and traps, the cross-cutting catalogues and verification — after a defect pass over the code and documents, and with every journeys Suggested item, wireframes call, design extra, UX finding and open change-request item accepted, refused or carried. Run by name only, once phases 2 to 6 are done; the session ends when the plan is committed and pushed.
argument-hint: "<module folder> [--override \"<reason>\"]"
disable-model-invocation: true
model: opus
effort: high
allowed-tools: Bash(bash "${CLAUDE_SKILL_DIR}/context.sh" *) Bash(bash */lifecycle/bin/gate *) Bash(git -C * add *) Bash(git -C * commit --only *) Bash(git commit --only *) Bash(git -C * fetch *) Bash(git -C * log *) Bash(git -C * grep *) Bash(git -C * show *) Bash(git -C * diff *) Bash(wc *)
---

# build-plan

Turn the spec, journeys, design and eval plan into the order the code lands in and the shape it takes, to the level of tables, routes, refusal codes, screens and tests, so that each stage's phase card is a transcription and not a design exercise. The plan is also where everything the design phases left open is settled or handed on. This skill is `lifecycle/skills-plan.md` §2 `build-plan`. Its seeds are in `reference.md` beside this file.

**Start with one line:** `build-plan · <module> · Opus, high effort`. This skill's frontmatter sets that model. If you aren't Opus, say which model you are and stop before anything else. Effort here is ${CLAUDE_EFFORT}. If it isn't `high`, say so in that line and carry on.

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
- **Read the gate's first line.** `GATE FAIL`: say what it found, in its words, and stop. A missing phase is that phase's skill's to write. An open UX finding goes to `revise` first. `GATE OVERRIDDEN`: carry on, and copy the reason into the plan's header.
- **Read the inputs whole:** `02-spec.md`, `03-journeys.md`, `04-wireframes.html`'s calls and coverage, `04b-design/README.md` if it exists, `05-ux-review.md`'s findings, `06-eval-plan.md`'s instruments, and the change requests in `changes/`. Then `lifecycle/projects/<project>/` if it exists.

## Steps

1. **The foundation batch,** only when the project has no config folder (shown above). Before drafting, ask the founder's facts in one batch: the code repo, the host, the stack, the domain, the server, and the devices they have. At most four questions per call, and two calls in one turn count as one batch (`skills-plan.md` §0 *Asking the founder*). Facts they must look up go in a pre-flight list instead. The answers go in the plan's §4, marked answered, and §0.3 holds the project's house rules, which `project-config` transcribes later.

2. **The defect pass.** Read the code and infrastructure the build will touch or share, in the checkout above at the base branch's newest commit. For a project with no code yet, read the inputs for contradictions and leaks instead.
   - Take each "never shows X" in the spec, and ask which mechanism could leak X: ids, URLs, timing, logs, cookies the browser sends.
   - For every count or row created from request data, name what bounds its growth.
   - Each defect goes in §0.4, assigned to the stage that fixes it.

3. **Settle every open item** listed above under *To accept, refuse or carry*: the journeys' Suggested, the wireframes' *Calls made here*, the design's *Beyond the spec*, the UX review's items for `revise` and its carried findings, and each change request's *Open*. Each is **accepted** (name the stage that builds it), **refused** (say why) or **carried** (say where, and to which step). An item that changes the spec's scope is carried to `revise`, never accepted here, because the spec is `revise`'s to change. Write the outcomes in §2, as planning decisions, or in §10.

4. **Plan the stages.**
   - **The order** (§3): each stage's size, what it comes after, what may run beside it, and its milestone. At most two lanes at once, and never two that touch shared schema. When the spec fixes every table, the whole schema lands in the first stage, so that later lanes can run in pairs.
   - **Sizes** (`README.md` §6 rule 5) are lane hours and lines of new app code, with tests and moved code counted apart. Recalibrate from earlier stage records, where they exist, rather than from the bands alone.
   - **Each stage in §5** has every bold field in the template, and these:
     - **Image and deploy:** new environment variables with production defaults, and toolchain changes;
     - **constraints from earlier stages** its writes must work through (triggers, unique keys);
     - **the plate it draws from,** and which stage owns each control on it. A frame-first split is planned as such;
     - **the API from the screens' save boundaries,** not one route per verb, with its refusal codes;
     - **for a server-filled field,** what the screen shows for each verb;
     - **a guard for every destructive command line**;
     - **deploy-sequencing traps as stages of their own** (B6a, B6b), never as an instruction that one lane can't carry out.
   - **About 400–600 words per stage**, a held bound. Past it, the stage is probably two.
   - **The eval plan's preconditions** (devices, the domain, real data) are placed in the order, and the instruments that need a built feature name the stage that builds it.

5. **The catalogues and the rest** (§6–§10): routes, refusal codes, tables, limits, runtime dependencies, and §6.7, every criterion of the spec and of each change note to its stage. §7 what this changes in built code. §8 verification and its ceiling, with the by-hand list and each item's *needed by*. §9 where it is most likely to go wrong. §10 for the founder: facts owed, decisions to veto, and every open call left to the card.

6. **The last check, before committing.**
   - Each §6 row agrees with its §5 section.
   - The planning decisions don't contradict each other or the house rules.
   - Every open call is in §10, as left to the card.
   - Every criterion id shown above is in §6.7 once.

   Fix what this finds.

7. **Check it with the gate:** `bash <root-sot>/lifecycle/bin/gate <module> 8 <first stage>`. Its `07-build-plan.md` line must say every heading is met, and that every stage under *The stages* carries **Goal**, **Acceptance**, **Size** and **Traps**. Its project-config lines fail until `project-config` has run for a new project; say so, and don't treat that as yours.

8. **Write `status.md`,** your own cell only: column 7 reads `done`. Column 8 is `verify`'s.

9. **Commit by path:** `git -C <root-sot> add <module>/07-build-plan.md lifecycle/status.md`, then `git -C <root-sot> commit --only <module>/07-build-plan.md lifecycle/status.md -m "build-plan: <module>"`, with the session's attribution lines.

10. **Push, with the founder's yes.** The session ends once the plan is committed and pushed, and the build starts fresh (`README.md` §5 rule 1). root-sot is public, so ask before pushing. If the founder says no, or the push is blocked, end with "push pending: founder".

## How it ends

At most twelve lines: the stages with their sizes and milestones, the defects found, the items accepted, refused and carried, the planning decisions for the founder to veto, the facts owed, the gate's line, the commit and whether it was pushed. The next step is `project-config <project>` when the project has no config, otherwise `/build-phase <first stage>` (Opus, medium) from the code checkout. End exactly like this (`README.md` §5 rule 8):

Run `/handoff`, then `/learned`, then `/clear`, then paste:
```
Read the top block of `<module>/STATE.md` in root-sot (`<branch>`), then §3 and the first stage of `<module>/07-build-plan.md`. Start from the <project> checkout. Run `/build-phase <stage>` (Opus, medium effort).
```
