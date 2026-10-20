# `verify` — reference seeds

*Seeds for this skill's reference file and template, moved unchanged out of `skills-plan.md` 0.5 at 0.6. They bind as the plan does. The skill's first author places them, in stage 2 or later.*

**Version 0.1 · Status: seeds · 2026-10-20 · Owner: _root**

---

## Reference holds

- Check a lane's stated cause for an environment workaround before recording it as fact.
- A "later stage reuses this" claim is tested or not written. An owed reuse says "extract and generalise" when it is a refactor. A placeholder carries the later stage's accessibility semantics, or none, checked against the design. A test never uses a later stage's planned route as its example of an unknown one.
- Name the accepted fallbacks when the machine can't run a check, with their conditions (for example, "the deploy is the build check when the build runs before `up`, and a failed build leaves the old container serving").
- Each validator check names its endpoint and is posted with seed content only, never real entries.
- Commands for a human at a server: `sudo` explicit and `| sudo tee` for writes; one command per line, no chains whose failure is ambiguous; no Run-button shell tags, which would run locally; all of it in the closing message.
- Before any live check on production, read how the product counts visits, and use requests it won't count (`HEAD`, a bot agent).
- A verify whose code repo's local `main` is held by another session pushes `HEAD:main` from its stage worktree and tells that session to rebase (§0, parallel sessions).

## Moved from the plan at 0.10

1. **Exercise first:** before reading further, run what can be run. Build and run the image; probe each new one-rule file with inputs its tests don't hold; send raw, un-normalised paths at a path guard on the running server; check that each deploy check fails when what it guards is broken. The lane report's item 6 is the first work list. Then read the stat and the core files.

2. Check against the review checklist. "Driven in a browser" means a scripted real browser plus screenshots that were looked at, graded "screenshots, not a window"; the preview pane counts for look, and DOM measurement for layout.

3. Fix on the branch. A fix that changes no rendered pixel at the designed sizes, or only corrects a defect, is the reviewer's; anything else goes back to a lane or to the founder. A test added by the review is run against the unfixed code and seen to fail first (stop or exhaust a page's timers before). A failure with a cause found is fixed in the test or the page; one without is repeated five times alone, recorded as a flake in the record, and named in the push question.

5. Rerun the affected test files, and every file asserting a changed shared rule. A fix to a shared helper or a one-rule file reruns every spec that imports or renders through it. When a change note's criteria ask for the full suites, run them, and budget for them in the first message (about 30 min per e2e run on IMNSTR).

- **Before the run,** list the by-hand items: the open-work file's verification rows whose *needed by* names this milestone (`config.md`'s milestone row points there). Ask which devices the founder has today, and check that production holds the content each item needs.

- **"Every feature present":** walk the plan's route catalogue on production in each language, and confirm the signed-out API refuses, with requests the product won't count.
