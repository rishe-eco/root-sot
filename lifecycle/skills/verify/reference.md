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
