# `build-phase` — reference seeds

*Seeds for this skill's reference file and template, moved unchanged out of `skills-plan.md` 0.5 at 0.6. They bind as the plan does. The skill's first author places them, in stage 2 or later.*

**Version 0.1 · Status: seeds · 2026-10-20 · Owner: _root**

---

## Template: the phase card

- *Decided here*: what the plan left open, including development dependencies added and how e2e gets its data;
- *Tests that change on purpose*: every test the grep found that asserts the stage's absence or forbids what it adds, with the new rule. The lane changes those and no others;
- from the first deploy on, *What the verify deploys*. Each deploy check is one that fails when what it guards is broken. The card doesn't assert a computed outcome it hasn't tried.
