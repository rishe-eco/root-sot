# `verify` — reference seeds

*Seeds for this skill's reference file and template, moved unchanged out of `skills-plan.md` 0.5 at 0.6. They bind as the plan does. The skill's first author places them, in stage 2 or later.*

**Version 0.2 · Status: placed — `SKILL.md` binds · 2026-10-20 · Owner: _root**

---

## Placed

Every seed below was placed in `SKILL.md` 0.1 on 2026-10-20 (rollout stage 2, session B). *Reference holds* went to steps 2 and 3 and to *Where the base branch deploys*; the server-command rule went to *What you return*; the moved steps 1, 2, 3 and 5 and the milestone's *Before the run* went to their own steps. They sit in the skill body because a forked review sees nothing else. `SKILL.md` binds from now on. Change it there, not here.

What placing added. Each is Claude's call, not yet reviewed by the founder:
- a fork can't ask the founder, so everything that needs their yes ends in the return's *For the main session*, with its command. That covers the fast-forward or push, correction-only plan edits, config edits and `brief-common.md` proposals;
- the return's second line answers `skills-plan.md` §0's stage 2 check: whether the fork can edit, commit and run suites;
- the milestone run waits for the founder's devices, given in the argument (`devices: …`), since the fork can't ask for them;
- the stage record's sections are root-app's (built · decided · owed · flagged for close-out · verification), the J12 shape plus the close-out flags;
- verify writes column 8, counting Change stages as `README.md` §3 says. The IMNSTR trial left Change stages out of the count.

**"Every feature present"** (the last seed) has no step of its own. It is a milestone's by-hand item, read from the open-work file's rows.

## The seeds, as moved

### Reference holds

- Check a lane's stated cause for an environment workaround before recording it as fact.
- A "later stage reuses this" claim is tested or not written. An owed reuse says "extract and generalise" when it is a refactor. A placeholder carries the later stage's accessibility semantics, or none, checked against the design. A test never uses a later stage's planned route as its example of an unknown one.
- Name the accepted fallbacks when the machine can't run a check, with their conditions (for example, "the deploy is the build check when the build runs before `up`, and a failed build leaves the old container serving").
- Each validator check names its endpoint and is posted with seed content only, never real entries.
- Commands for a human at a server: `sudo` explicit and `| sudo tee` for writes; one command per line, no chains whose failure is ambiguous; no Run-button shell tags, which would run locally; all of it in the closing message.
- Before any live check on production, read how the product counts visits, and use requests it won't count (`HEAD`, a bot agent).
- A verify whose code repo's local `main` is held by another session pushes `HEAD:main` from its stage worktree and tells that session to rebase (§0, parallel sessions).

### Moved from the plan at 0.10

1. **Exercise first:** before reading further, run what can be run. Build and run the image; probe each new one-rule file with inputs its tests don't hold; send raw, un-normalised paths at a path guard on the running server; check that each deploy check fails when what it guards is broken. The lane report's item 6 is the first work list. Then read the stat and the core files.

2. Check against the review checklist. "Driven in a browser" means a scripted real browser plus screenshots that were looked at, graded "screenshots, not a window"; the preview pane counts for look, and DOM measurement for layout.

3. Fix on the branch. A fix that changes no rendered pixel at the designed sizes, or only corrects a defect, is the reviewer's; anything else goes back to a lane or to the founder. A test added by the review is run against the unfixed code and seen to fail first (stop or exhaust a page's timers before). A failure with a cause found is fixed in the test or the page; one without is repeated five times alone, recorded as a flake in the record, and named in the push question.

5. Rerun the affected test files, and every file asserting a changed shared rule. A fix to a shared helper or a one-rule file reruns every spec that imports or renders through it. When a change note's criteria ask for the full suites, run them, and budget for them in the first message (about 30 min per e2e run on IMNSTR).

- **Before the run,** list the by-hand items: the open-work file's verification rows whose *needed by* names this milestone (`config.md`'s milestone row points there). Ask which devices the founder has today, and check that production holds the content each item needs.

- **"Every feature present":** walk the plan's route catalogue on production in each language, and confirm the signed-out API refuses, with requests the product won't count.

## Changelog

- **0.2 · 2026-10-20** — Placed in `SKILL.md` 0.1. This file keeps the seeds as moved and a record of what placing added.
- **0.1 · 2026-10-20** — Seeds, moved unchanged out of `skills-plan.md` 0.5 at 0.6.
