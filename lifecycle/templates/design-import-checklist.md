<!-- Checklist for the design import (Opus, medium), which brings step 4b's files from `../repo-handoff-<step>/` into `<module>/04b-design/` at their repo paths. Template 0.1 · 2026-10-20. Sources: `skills/design-step/reference.md` *The import's checklist*; finding DS-3; trial logs `04b-design-import`, `05e-design-import`. The import has its own log and `STATE.md` block, merges `STATE.md` by block (never by overwriting), and records the results in the README's *What didn't survive*. Copy this list into the import's log and tick it. -->
# Design import — checklist

**Import:** <module> · step <step> · <YYYY-MM-DD> · from `../repo-handoff-<step>/`

## Before

- [ ] Diff `STATE.md` against the handoff's copy; merge by block, newest first.
- [ ] Files copied at their repo paths; nothing outside `04b-design/` overwritten without a reason in the log.

## The checks

- [ ] **Self-contained.** Served locally, with zero external requests (network log, not a guess).
- [ ] **Fonts.** Every face loads from the bundle, in each language.
- [ ] **Direction.** Right-to-left pages mirror as the README says; what must not flip doesn't.
- [ ] **Each interactive behaviour** named in the README works in the export.
- [ ] **Reduced motion.** Checked in the browser, or in the source where emulation isn't available, and said which.
- [ ] **Narrowest width.** Every revealed or animated state is drawn at the narrowest width.
- [ ] **Against the README's list,** while the founder compares with the tool's preview.
- [ ] **By eye.** At least one frame per new plate named and looked at.
- [ ] **Re-editing.** `source/` reopens in the tool.

## After

- [ ] *What didn't survive* written: checked-by line, verdict, one bullet per check, *Not checked*, and what is still true from the last import.
- [ ] What was lost in the move kept apart from what is missing in the design.
- [ ] Status cell: column 4 stays `done`; an owed pass is `done · owed 4b`.
- [ ] The import's own `STATE.md` block written; next step named.
