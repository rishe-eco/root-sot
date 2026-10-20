---
name: ux-review
description: Reviews a root-sot lifecycle module's UX in a fresh forked context by walking each journey as each selected persona and scoring it on the review instrument's six metrics, with coverage and Nielsen's heuristics — in design mode on the latest design or wireframes before the build (phase 5), in live mode on the running app after UI stages (phase 9). It asks nothing, appends a dated pass to 05-ux-review.md with each finding's route and status, and commits by path. Run by name only.
argument-hint: "<design | live> <module folder> [--override \"<reason>\"]"
disable-model-invocation: true
model: opus
effort: high
context: fork
background: false
allowed-tools: Bash(bash "${CLAUDE_SKILL_DIR}/context.sh" *) Bash(bash */lifecycle/bin/gate *) Bash(git -C * add *) Bash(git -C * commit --only *) Bash(git commit --only *) Bash(git -C * fetch *) Bash(git -C * log *) Bash(git -C * worktree *) Bash(curl -sI *)
---

# ux-review

Walk the module as each person it is for, one journey at a time, and say where they would guess, get lost or lose work. The same instrument scores the design before the build and the app after it, so the two passes compare. This skill is `lifecycle/skills-plan.md` §3 `ux-review`.

**This runs forked:** a fresh context that holds only this skill and what is injected below (`README.md` §5 rule 4). You can't ask the founder anything, and nothing reaches them until you return. **The review asks nothing anyway:** a decision it finds is a finding routed `question`, for `revise` or the next change note.

**Start with one line:** `ux-review · <design | live> · <module> · Opus, high effort, forked`. This skill's frontmatter sets that model. If you aren't Opus, say which model you are and stop. Effort here is ${CLAUDE_EFFORT}. If it isn't `high`, say so in that line and carry on.

The argument was: `$ARGUMENTS`

## What the files say

```!
bash "${CLAUDE_SKILL_DIR}/context.sh" <<'LIFECYCLE_ARGS'
$ARGUMENTS
LIFECYCLE_ARGS
```

## Before anything else

- If the injected section says `ROOT-SOT NOT FOUND`, or names no mode or module, return that and stop.
- **Read the gate's first line.** `GATE FAIL`: return what it found, in its words, and stop. `GATE OVERRIDDEN`: carry on, and copy the reason into the pass's *What was reviewed*. In live mode, open by-hand device checks don't block the pass: list them under *Not checked*.
- **Read only what the review needs:** the journeys whole; the spec's interface and acceptance sections (above), and no other part of it; the selected personas' registry entries (above); the design or the app. **Don't read the earlier passes** until this pass's findings are written. Then read them, and list each earlier finding as it now stands in *Coverage*.
- **Owed and carried items** (above) aren't defects. Count one only if the module was meant to have settled it by now.

## The walk

1. **What is reviewed.**
   - **Design mode:** the 4b design where it exists, else `04-wireframes.html`. Render each page at 360 px and at desktop width, in each language and colour scheme it draws, with a headless browser or the built-in browser pane, and look. Observations are *simulated*.
   - **Live mode:** read production read-only, as a bot wherever the project counts readers: `HEAD` requests, or a bot user agent. Walk every state, and anything behind sign-in, on a local server built from the deployed commit (a worktree of the code checkout at that commit), with the review seed route and a virtual authenticator where `config.md` names them. Observations are *as-built*.
   - Say exactly what was reviewed: files or commit, widths, schemes, languages, and how production was read.

2. **Walk each journey as each persona** that anchors it, step by step, against the step's *Must be true*. Follow the instrument's rules (§5):
   - judge sticky docks, dialogs and the keyboard from viewport screenshots and a position probe, never a full-page capture;
   - never judge clipping or animation from a still;
   - follow text through reload, restore and publish before reporting it lost;
   - in live mode, confirm a suspected bug below the UI (the API, the database) before reporting it;
   - in design mode, check the spec and the design's own captions and README before calling a state missing.

3. **Coverage:** every acceptance criterion has a screen, and every screen its empty, error and loading states. A criterion with no screen by design (the journeys' Coverage says so) isn't a gap.

4. **Score** the six metrics, 1 to 5, per persona per journey, on the instrument's scale. Language parity is "not scorable", with why, when no selected persona reads the second language or it isn't drawn yet: never 1 for absence. Never score speed from a review pass. A live pass puts the design pass's score in brackets beside its own.

5. **Findings,** numbered `P<pass>-F<n>`, each with what, where (journey step and screen), the persona, what it breaks (metric and heuristic, or `coverage`), severity on the instrument's §4 scale, a proposed fix, its route (`revise`, `design`, `build`, `question`) and status `open`. The heuristics get one line each, citing findings.

6. **Write the pass.** Append `## Pass <n> — <date> · <mode> mode, against <what>` to `<module>/05-ux-review.md`, creating the file from the template above if it doesn't exist. Keep every heading the gate checks inside each pass: *What was reviewed*, *Coverage*, *Scores*, *Findings*, *For `revise`* (the findings that change the spec, or "None"), *Not checked*, plus *Heuristics, in brief*, *Carried* and *Worth keeping*. Add the pass's five-point summary at the top of *Summary*, newest first. Add a changelog line and bump the version line. After the build, say in *For `revise`* that UI fixes go to `spec change` as one proposed Change.

7. **Now read the earlier passes,** and update this pass's *Coverage* with each earlier finding as it now stands (fixed, still there, worse). Don't change their findings' text: a status changes only where this pass closes one, as `closed in <file>`.

8. **Check it with the gate:** in design mode `bash <root-sot>/lifecycle/bin/gate <module> 7`, whose `05-ux-review.md` and open-findings lines are this file's. In live mode, `gate <module> 9` for the journeys input, and check the pass's headings by eye against the template.

9. **Write `status.md`,** your own cell only: column 5 reads `done` after a design pass. After a live pass, column 9 reads `done` only if `08-design-review.md` covers the same commit; otherwise leave it, and say that `design-review` is owed.

10. **Commit by path:** `<module>/05-ux-review.md` and `lifecycle/status.md`, with `ux-review <mode>: <module>, pass <n>`, and the session's attribution lines. Don't push.

Never re-score in the session that wrote the fixes: a reviewer who has just written a fix can't read the screen as a stranger.

## What you return

At most 12 lines, then *For the main session*:

```
ux-review · <mode> · <module> · Opus, high, forked
Reviewed: <files or commit, widths, schemes, languages>
Scores: <the lowest per persona, and the metric>
Findings: <n> · high <n>, medium <n>, low <n> · routed revise <n>, design <n>, build <n>, question <n>
Coverage: <criteria without a screen; states missing>
Not checked: <items>
Commit: <hash> · status: column <5 | 9> <done | left: design-review owed>
```

**For the main session:** the findings routed `question`, each phrased so the founder can answer it as it stands; then the next step: `revise <module>` (Opus, medium) when *For `revise`* holds items, otherwise `build-plan` after a design pass, or `design-review <module>` after a live pass when it hasn't run. Then `/handoff`, `/learned`, `/clear`, and the next session's prompt in a fenced block (`README.md` §5 rule 8).
