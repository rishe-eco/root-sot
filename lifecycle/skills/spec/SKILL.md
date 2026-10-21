---
name: spec
description: Writes a root-sot lifecycle module's spec (02-spec.md, phase 2) in full mode, or in change mode a change note (changes/NN-change-<slug>.md) whose Stages section build-phase and verify read in place of a build plan. It reads the code first, asks the founder at most eight questions in one batch, writes and gate-checks the file, records the note in the module's decisions.md and commits by path. Run by name only, for phase 2 or to open a Change.
argument-hint: "full <module folder> [--override \"<reason>\"] | change [<module folder>] <what changes, e.g. wp-dashboards #1>"
disable-model-invocation: true
model: opus
effort: high
allowed-tools: Bash(bash "${CLAUDE_SKILL_DIR}/context.sh" *) Bash(bash */lifecycle/bin/gate *) Bash(git -C * add *) Bash(git -C * commit --only *) Bash(git commit --only *) Bash(git -C * fetch *) Bash(git -C * diff *) Bash(git -C * log *) Bash(git -C * show *) Bash(git -C * grep *)
---

# spec

Say what will be built, precisely enough that a Sonnet lane can build it from a card and a reviewer can tell whether it did. The spec fixes the testable criteria and the decisions behind them. A change note does the same for one Change, and also stages it, so the Change needs no build plan (`lifecycle/README.md` §1). This skill is `lifecycle/skills-plan.md` §2 `spec`. Its seeds, and what each became here, are in `reference.md` beside this file.

**Start with one line:** `spec · <full | change> · <module> · Opus, high effort`. This skill's frontmatter sets that model. If you aren't Opus, say which model you are and stop before anything else: what this writes binds every later step. Effort here is ${CLAUDE_EFFORT}. If it isn't `high`, say so in that line and carry on.

The argument was: `$ARGUMENTS`

## What the files say

Injected when the skill started. Don't fetch these again.

```!
bash "${CLAUDE_SKILL_DIR}/context.sh" <<'LIFECYCLE_ARGS'
$ARGUMENTS
LIFECYCLE_ARGS
```

## Before either mode

- If the injected section says `ROOT-SOT NOT FOUND`, or names no mode, say so and stop. If it names no module, it lists them: pick the one whose `STATE.md` owes the change, and say which in a line. Ask only if two fit.
- **root-sot's branch.** If it is behind its upstream, say so and stop: a note written on stale state may fork a decision. If it is `main`, put a question in the batch: commit on `main`, or on a new branch named `lifecycle/<step>` (root `CLAUDE.md` *Commits*).
- **Paths.** Name every file by its path relative to its repo, and the code by `config.md`'s names, never by this machine's path (`skills-plan.md` §0 *References*). Cite steps, criteria and findings by the id in their file.
- **Grade every claim** (`skills-plan.md` §0 *Grades*): *as-built* with its file, *proposal*, *evidence* with its strength, or the founder's **decision**, dated and marked [F]. Something the founder accepted on your judgement is written as exactly that, never as their decision.

## Change mode (`spec change <module> <what changes>`)

1. **Know the change.** Find its source: the review item, the founder's words, a `revise` item or a finding. Read the source itself, not a summary in a `STATE.md` block, and quote its id (`wp-dashboards #1`). One item per note, unless the founder has grouped items or the source does ("items 4–8 are one piece of work"). Note what the source has already decided, so that you don't ask it again.
   - **Track check.** If the change needs new journeys or new screens, it is a Module (`README.md` §1). So is one you can't stage in at most three stages of size L or under. Say which, and stop or ask.
   - A change that adds a capability (new stored data, a new screen family, or anything an intake put out of scope) carries research or a waiver line in its *What changes and why*.

2. **Read the code before you ask,** in the checkout at the base branch's newest commit, the `main @` above:
   - every file the change touches, and the callers of what it changes;
   - the tests that pin today's behaviour: grep them for the routes, fields, strings and helpers involved. Each one the change breaks on purpose is a *Tests that change on purpose* line;
   - the environment and deploy facts it depends on (`config.md`, the deploy workflow, environment variables with their production defaults).

   Cite each as-built fact with its file. Before you cite a section of a document, open it at the line and confirm the heading. Notes 01 and 02 show the depth: **Today** says what the code does and where.

3. **Ask, in one batch** (`skills-plan.md` §0 *Asking the founder*): at most eight questions, at most four per call. Two calls in one turn count as one batch.
   - Ask only what the source and the code leave open, and what changes the build: the scope, a behaviour with two defensible readings, a copy or product call, a server step. A finding that a review routed to `question` joins the batch.
   - Word each option from the code you read. Put what the founder needs to answer inside the question: in two or three plain sentences, what changes, why it matters, and what it costs. No packed ids or shorthand.
   - Facts the founder must look up (a server value, a device) go in a *Founder pre-flight* list, not the batch.
   - An answer that adds a requirement, contradicts the source or is itself a question is a new item: size it, propose a bounded reading graded *proposal* with what it excludes, and ask again. Don't write it into the note as accepted.
   - What you settle without asking goes under **Decided here, by Claude**, each with its reason and "refuse it on the diff if it's wrong".

4. **The lanes check** (the change-mode gate). Once the stages' **Files** are known, compare them with *Lanes in flight* above: the files each live lane's branch touches. If a running or landed lane touches any of the same files, refuse. Name the lane, its branch and the shared files, and stop before writing. The founder lands or verifies that lane first. Name any overlap with the other unmerged branches above, but don't refuse on it.

5. **Write the note** at `<module>/changes/NN-change-<slug>.md`, from the template above, with the number shown as next. Delete every template comment.
   - **Header:** today's date; `<code repo> main @ <hash>` of the commit you read; the note's **prefix**, two letters no other note owns (the list above), which also name its stages (`XY1`, `XY2`).
   - **What changes and why:** **Today** (as-built, cited), **After** (what is true once it ships), the founder's answers in *Decided by the founder at this step*, then *Decided here, by Claude*, then *What stays*: the files, behaviour and copy it leaves alone.
   - **Acceptance criteria:** one testable line each, `XY-n`. The *Item* column names the source item each one closes, or `—`. Cover the locales and roles the change touches.
   - **What must not break:** the tests and behaviours next to the change, named by file and test name.
   - **Founder pre-flight:** only when the change touches a server, a secret or production data.
   - **Stages,** each an `### XY<n> · <Name>` with every bold field the template lists: **Goal**, **Branch and slot** (`config.md`'s change-stage naming), **Files** and **Not changed**, **Tests** (written first and seen failing, targeted runs only, since the full suites are the verify's; the exact commands as `config.md` §3 gives them), **Image and deploy**, the infrastructure question when it applies, **At the verify** and **Stop points** when they apply, **Acceptance**, **Size**, **Traps** and **Not here**.
   - **Size** S, M or L by `README.md` §6 rule 5, with the test harness counted. **Traps** are the ones the code reading found: a shared rule that could be written twice, a test that sums or pins what changes, the fixture clock, a loading state, the machine's browser. Each says what to do instead.
   - **What this makes stale:** each file that will disagree once the stage ships, its owner (`README.md` §4) and the step that catches it up. If the note departs from `02-spec.md`, it names `revise --catch-up NN` here, and the closing message says that `handoff` must add that `revise` line to the next steps.
   - **Changelog:** `0.1 · <date> — Note, against main @ <hash>.`

6. **Check it with the gate.** Run `bash <root-sot>/lifecycle/bin/gate <module> 8 <first stage>`, which reads the note's headings and checks every criterion id against a stage's **Acceptance** line. A missing heading or criterion is yours: fix the note and rerun until those lines pass. The lines about the card, the report and `STATE.md`'s next step are `build-phase`'s, so ignore them here.

7. **Record it in `<module>/decisions.md`:** one line per change note (`README.md` §4), in the file's own form: `- **<date> · [NN — <title>](changes/NN-change-<slug>.md).** <What it decides, in a sentence or two, and what the founder chose.>` Bump its version line and add a changelog line. If the file doesn't exist, create it in the shape of `ecosystem/modules/01-root-studio-journeys/decisions.md`. If an earlier note has no line, add it in the same commit and say so.

8. **Commit by path:** `git -C <root-sot> add <note> <module>/decisions.md`, then `git -C <root-sot> commit --only <note> <module>/decisions.md -m "spec change: NN <title> (<module>)"`, with the session's attribution lines. Commit nothing else: parallel sessions share the checkout. Don't push. root-sot is public, so a push needs the founder's yes in this session.

Don't write `status.md` or `STATE.md`. Column 8's total grows when `verify` counts the stage, and the module's state is `build-phase`'s or `handoff`'s to write (`README.md` §4).

## Full mode (`spec full <module>`)

1. **Read the gate's first line.** `GATE FAIL`: say what it found, in its words, and stop. The founder fixes the input or reruns with `--override "<reason>"`. `GATE OVERRIDDEN`: carry on, and copy the reason into the spec's header.
2. **Read the inputs:** `00-intake.md` whole; `01-research.md`'s summary and *For the next phases* (injected above) and the sections it points to; the code the module will change, by section, when it touches an existing product. The research's *questions for spec* are the first draft of your batch.
3. **Ask, in one batch,** as in change mode step 3: at most eight questions. Each answer goes in *Decisions taken at spec* with its consequence.
4. **Write `02-spec.md`** from the template above, with every heading the gate checks.
   - **Scope ledger:** acceptance criteria counted by area at this version, against the intake's scope, so that growth is visible to `revise`.
   - **Metrics** define measures only. The eval plan owns instruments and decision rules.
   - **Interface requirements:** one subsection per surface. Where a gesture sits on a link or a control, say which one wins.
   - **Risks:** a stack or platform implication is named here as a risk. `build-plan`'s foundation batch decides it.
   - **Acceptance criteria** `AC-n`, in sequence, grouped by area, never reused. Journey-level criteria belong to `03-journeys.md`, not here.
5. **Check it with the gate** for the next phase: `bash <root-sot>/lifecycle/bin/gate <module> 3`. Its line for `02-spec.md`'s headings must pass. The personas line is `personas`'s.
6. **Write `status.md`,** your own cell only: column 2 reads `done`.
7. **Commit by path:** `02-spec.md` and `lifecycle/status.md`, `spec: <module>`. Don't push.

## How it ends

At most ten lines: the mode, the file written, and its version; the questions asked and the decisions recorded; criteria and stages with their sizes; what the gate said; what this makes stale; every commit made, ending with "not pushed". Then the next step.

- **Change mode.** The next step is `build-phase` for the first stage. It is the founder's to run, from the code checkout (`config.md` names it), at Opus medium effort. If the session goes on, say "run `/build-phase <stage>` here". Otherwise end exactly like this (`README.md` §5 rule 8):

  Run `/handoff`, then `/learned`, then `/clear`, then paste:
  ```
  Read the top block of `<module>/STATE.md` in root-sot (`<branch>`), then `<module>/changes/NN-change-<slug>.md`. Start from the <project> checkout. Run `/build-phase <stage>` (Opus, medium effort), then `/build-phase <stage> --land` when the lane reports, then `/verify <stage>` (Opus, high effort; it runs forked).
  ```
- **Full mode.** The next phase is `personas`, then `journeys` (Opus, high), for a module with UI. Without UI, it is `eval-plan`. End as above, with that step in the block.
