---
name: design-review
description: Reviews a root-sot lifecycle module's built UI in a fresh forked context against the project's own design system and the access gates (contrast, touch targets, text scaling, keyboard, screen reader), with hierarchy, feedback, consistency and right-to-left rules beside them. Each finding is What, Why with a source, and Fix, on the module's severity scale, written to 08-design-review.md (phase 9). Run by name only, on a module, a stage or a screen; verify reads its checklist for UI stages.
argument-hint: "<module folder> [<stage or screen>] [--override \"<reason>\"]"
disable-model-invocation: true
model: opus
effort: high
context: fork
background: false
allowed-tools: Bash(bash "${CLAUDE_SKILL_DIR}/context.sh" *) Bash(bash */lifecycle/bin/gate *) Bash(git -C * add *) Bash(git -C * commit --only *) Bash(git commit --only *) Bash(git -C * fetch *) Bash(git -C * log *) Bash(git -C * worktree *) Bash(curl -sI *)
---

# design-review

Check the built UI against the design system it was built to, and against the gates that decide whether people can use it at all. The project's own design system is the rubric. General principles fill its gaps. Apple's visual language doesn't apply. This skill is `lifecycle/skills-plan.md` §3 `design-review`.

**This runs forked:** a fresh context that holds only this skill and what is injected below. You can't ask the founder anything, and nothing reaches them until you return.

**Start with one line:** `design-review · <module>[ · <stage or screen>] · Opus, high effort, forked`. This skill's frontmatter sets that model. If you aren't Opus, say which model you are and stop. Effort here is ${CLAUDE_EFFORT}. If it isn't `high`, say so in that line and carry on.

The argument was: `$ARGUMENTS`

## What the files say

```!
bash "${CLAUDE_SKILL_DIR}/context.sh" <<'LIFECYCLE_ARGS'
$ARGUMENTS
LIFECYCLE_ARGS
```

## Before anything else

- If the injected section says `ROOT-SOT NOT FOUND`, or names no module, return that and stop.
- **Read the gate's first line.** `GATE FAIL`: return what it found, in its words, and stop. A review scoped to one stage or screen may run before every stage is verified: the founder overrides with that reason. `GATE OVERRIDDEN`: carry on, and copy the reason into the review's header.
- **The rubric** is the design system named above. Read it first. Root's brand files apply only when that row points at them. If the row names none, say so in the header, and review against general principles only.
- If the code checkout isn't on this machine, return that, with what the main session must do, and stop. A design review without the running UI is no review.
- **Don't read an earlier `08-design-review.md`** until this review's findings are written.

## The checklist

`verify` reads this section for UI stages.

**Access gates.** Each checked by a script or a probe where one can measure it, with its figures, and graded *as-built*, or *not checked* with the reason:
- **Contrast:** text against its ground at WCAG 2.2 AA (4.5:1, and 3:1 for large text), and controls, focus rings and field edges at 3:1, in every colour scheme the project ships. Computed from the tokens or measured on the page, never judged by eye alone.
- **Touch targets:** at least 24 × 24 CSS px with spacing (WCAG 2.5.8), and the project's own minimum where it sets one (often 44). Inline links in running text are exempt, as WCAG says. Probe the DOM for every control under the minimum.
- **Text scaling:** at 200% zoom, or a 180 px viewport standing in for it, no sideways scroll and no clipped text (WCAG 1.4.4, 1.4.10). Measure after `document.fonts.ready`.
- **Keyboard:** every action reachable, focus visible in every scheme, tab order following reading order, no trap, and Escape closing what it opened.
- **Screen reader:** every control has a name, landmarks and headings make an outline, state changes and errors are announced (live regions), and decorative images are hidden. Read the accessibility tree; a real screen reader on a device is a by-hand item, listed under *Owed* if it wasn't done.
- **Also:** `prefers-reduced-motion` honoured, and `forced-colors` rules holding for anything drawn with colour alone.

**Against the design system:**
- **Hierarchy:** one primary action per screen, headings in order, the type scale and spacing from the tokens, not literals.
- **Feedback:** every action answers (loading, success, error), errors say what happened and the way out, in the project's voice.
- **Consistency:** the same thing looks and behaves the same everywhere; components come from the kit; copy follows the project's terms.

**Right to left,** when the project has a right-to-left language:
- the page is `dir="rtl"` with the right `lang`, and mirrors with logical properties, not `left` and `right`;
- what must not flip doesn't: media controls, numbers, code, brand marks, and anything the design system marks as fixed;
- digits are the locale's where the project says so, and dates are the locale's calendar;
- mixed-direction text (Latin terms, URLs and numbers inside right-to-left text, and the reverse) is isolated, not left to the first character.

## Steps

1. **Run what you review.** Build and run the app at the deployed commit (a worktree of the code checkout), or the stage's branch for a stage review, with the review scripts `config.md` names. Drive it in a scripted real browser at 360 px and at desktop width, in each language and colour scheme the project ships, and look at the screenshots. Grade observations *as-built*, and say they are screenshots, not a window.

2. **Go through the checklist** above, then the project's UI items (above), for each screen in scope.

3. **Findings,** ranked worst first, `F<n>`, each **What** (as-built, with the screen and width), **Why** (citing a source: the design system's section, a WCAG criterion, a platform guideline) and **Fix** (a *proposal*), with a severity on the instrument's scale (`lifecycle/review-instrument.md` §4: High, Medium, Low).

4. **Write `<module>/08-design-review.md`** from the template above, keeping every heading the gate checks: *Summary*, *Findings*, *Access gates*, *Right to left* (or "n/a: no right-to-left language"), *What holds, against the design system* (so a fix doesn't break it), *Owed* and the changelog. A second review of the module appends a dated section rather than overwriting, and reads the first one now, saying which findings still stand.

5. **Owed items** (a real screen reader, a device the project lists, anything past the verification ceiling) go in *Owed*, and are named in your return for the open-work file. You don't write that file: `verify` and `close-out` do.

6. **Write `status.md`,** your own cell only: column 9 reads `done` when `05-ux-review.md` has a live pass at the same commit. Otherwise leave it, and say that the live `ux-review` is owed.

7. **Commit by path:** `<module>/08-design-review.md` and `lifecycle/status.md`, with `design-review: <module>`, and the session's attribution lines. Don't push.

## What you return

At most 10 lines, then *For the main session*:

```
design-review · <module>[ · scope] · Opus, high, forked
Reviewed: <commit, widths, schemes, languages, browser>
Rubric: <the design system file>
Gates: contrast <…> · targets <…> · scaling <…> · keyboard <…> · screen reader <…>
Findings: <n> · high <n>, medium <n>, low <n>
Owed: <items for the open-work file>
Commit: <hash> · status: column 9 <done | left: live ux-review owed>
```

**For the main session:** the owed rows to add to the open-work file, with *needed by*; the fixes, proposed as one Change for `spec change` when they change what was specified, or as a list for the next `verify` when they only correct a defect; then `/handoff`, `/learned`, `/clear`, and the next session's prompt in a fenced block (`README.md` §5 rule 8).
