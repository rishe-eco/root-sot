---
name: journeys
description: Writes the journeys of a root-sot lifecycle module (03-journeys.md below its Personas section, phase 3) — the paths the selected personas take, step by step, each step with a testable check citing the spec's criteria, plus the Coverage table, the states table for wireframes and the Suggested gaps for revise. Modes new, gap (each step checked against the code) and update (brought up to a newer spec), optionally scoped. Run by name only, after spec and personas.
argument-hint: "<new | gap | update> <module folder> [--steps J2.9,J3.4 | --from-note 07] [--override \"<reason>\"]"
disable-model-invocation: true
model: opus
effort: high
allowed-tools: Bash(bash "${CLAUDE_SKILL_DIR}/context.sh" *) Bash(bash */lifecycle/bin/gate *) Bash(git -C * add *) Bash(git -C * commit --only *) Bash(git commit --only *) Bash(git -C * log *) Bash(git -C * grep *) Bash(git -C * show *) Bash(wc *)
---

# journeys

Walk the module as the people it is for, one step at a time, and say at each step what must be true. Journeys are where a spec's gaps show: a step nobody specified, an error with no way out, a state with no screen. They catch the kind of bug a criteria list misses (Tracker's B-14). This skill is `lifecycle/skills-plan.md` §2 `journeys`.

**Start with one line:** `journeys · <new | gap | update> · <module> · Opus, high effort`. This skill's frontmatter sets that model. If you aren't Opus, say which model you are and stop before anything else. Effort here is ${CLAUDE_EFFORT}. If it isn't `high`, say so in that line and carry on.

The argument was: `$ARGUMENTS`

## What the files say

Injected when the skill started. Don't fetch these again.

```!
bash "${CLAUDE_SKILL_DIR}/context.sh" <<'LIFECYCLE_ARGS'
$ARGUMENTS
LIFECYCLE_ARGS
```

## Before you start

- If the injected section says `ROOT-SOT NOT FOUND`, or names no mode or module, say so and stop. If root-sot is behind its upstream, say so and stop.
- **Read the gate's first line.** `GATE FAIL`: say what it found, in its words, and stop. A missing or empty Personas table means `personas` runs first. `GATE OVERRIDDEN`: carry on, and copy the reason into the file's title block.
- **The mode fits the file.** `new` needs a file holding only its title block and Personas. `gap` and `update` need journeys already written. If the mode doesn't fit, say which does, and stop.
- **Read the spec whole:** `02-spec.md` §2, §4 and §6 at least. The journeys cite its criteria and sections, and must not contradict them.

## Rules for every mode

- **Write below `## Personas`, never in it.** `personas` owns that section.
- **Each step** is a row: `J<n>.<step>`, the step, where it happens (a screen, a place, a channel), and **Must be true**: a check that a reviewer could test, citing criteria (`AC-3: …`). A journey with two actors adds a *Who* column.
- **Failure journeys walk every security requirement** in the spec: each refusal, limit and expiry is a step someone hits. What the walk adds that the spec lacks is **Suggested**.
- **Suggested** is a requirement the spec doesn't have. Mark it at the step, and list it in §4 with where it was found, what is suggested and why. Nothing Suggested is a requirement until `revise` accepts it into the spec. A founder decision made here that the spec lacks is also listed there.
- **Amending keeps citations true:** step numbers are never changed or reused, an inserted step takes a letter (J2.5a), and changed text is marked **[x.y]** with the new version. Downstream files cite these steps.
- **Grade:** every journey is *proposal*. Personas are cited as the registry grades them. A claim about the code is *as-built*, with its file and the commit read.

## The modes

**`new`.** Three to five journeys of about ten steps each: the first day, the normal loop, the return after a gap, not enough data, and an error. Scenarios may share a journey, and an error journey may be a branch. Each journey names its persona from the Personas table, where it starts and ends, and the criteria it covers. Anchor each persona on the journeys its row names. About 3,000–4,000 words, as a guide.

**`gap`.** Check each step against the code, in the checkout above at its base branch's newest commit: add a *Code* column reading **Have**, **Partly** or **Missing**, each with the file that shows it. A step the code does differently from the journey is a finding. Say whether the code or the journey is wrong, and put a spec gap in §4. The gap mode's worked example is `ecosystem/working/root-studio-user-journeys.md` §2.

**`update`.** Bring the journeys up to the newer spec and personas: read each change note and change request since the journeys' version (listed above), and each spec changelog line since the version this file names as its input. Amend the steps they touch, add journeys for new personas, mark Suggested items the spec has since accepted as "accepted at spec x.y", pointing at the criterion.

**Scoped** (`--steps J2.9,J3.4` or `--from-note 07`): only those steps, or only what that note touches. The changelog says what wasn't checked, and the status cell stays `done`.

## Steps

1. **Draft** in the mode's terms, from the spec and the personas, and the code in `gap` mode.

2. **Ask, in one batch** (`skills-plan.md` §0 *Asking the founder*): at most four questions per call, and two calls in one turn count as one batch. Ask what the walk found the spec can't answer: a step with two defensible outcomes, an error's way out, a copy choice the step depends on. Each question says in plain words what each answer would change in the journey, and what it costs. An answer that adds a requirement is recorded in §1 and listed as Suggested. If nothing needs asking, §1 says "None".

3. **Write `<module>/03-journeys.md`** below Personas, from the template above, keeping every heading the gate checks and deleting every template comment:
   - **Summary:** five lines;
   - **§1 Decisions taken at journeys:** this run's questions and answers [F], with their consequence;
   - **§2 Journeys;**
   - **§3 Coverage:** every criterion id in the spec (listed above) to its steps, `no screen` or `all steps`. Then the **States** table (empty, not enough data, error, loading, notices), each with where it occurs and its steps, which `wireframes` draws;
   - **§4 Suggested;**
   - **Changelog:** the version, the mode, the spec version it was written from, the personas, and for a scoped run what wasn't checked. Bump the version line (`new` makes it 0.2 when `personas` wrote 0.1).

4. **Check it with the gate:** `bash <root-sot>/lifecycle/bin/gate <module> 4`. Its `03-journeys.md` line must say every heading is met, and its coverage line must find every spec criterion in the Coverage table. Fix the file until they do.

5. **Write `status.md`,** your own cell only: column 3 reads `done`. In `update` mode, a `STALE` in column 3 is cleared by this run.

6. **Commit by path:** `git -C <root-sot> add <module>/03-journeys.md lifecycle/status.md`, then `git -C <root-sot> commit --only <module>/03-journeys.md lifecycle/status.md -m "journeys <mode>: <module>"`, with the session's attribution lines. Don't push. root-sot is public, so a push needs the founder's yes in this session.

## How it ends

At most ten lines: the journeys and step counts, the decisions taken, the Suggested items, the coverage line from the gate, and the commit, ending with "not pushed". The next step is `wireframes <module>` (Opus, medium) for a module with UI, or `eval-plan <module>` (Opus, high) without. If §4 holds Suggested items, say that `revise` takes them before `build-plan`. End exactly like this (`README.md` §5 rule 8):

Run `/handoff`, then `/learned`, then `/clear`, then paste:
```
Read the top block of `<module>/STATE.md` in root-sot (`<branch>`), then `<module>/03-journeys.md`. Run `/<next skill> <module>` (<model>, <effort> effort).
```
