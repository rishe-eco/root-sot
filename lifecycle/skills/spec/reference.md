# `spec` — reference seeds

*Seeds for this skill's reference file and template, moved unchanged out of `skills-plan.md` 0.5 at 0.6. They bind as the plan does. The skill's first author places them, in stage 2 or later.*

**Version 0.1 · Status: seeds · 2026-10-20 · Owner: _root**

---

## Template

Summary, What it is, Decisions taken at spec, Metrics, Interface requirements, Risks, Acceptance criteria, Out of scope, Changelog, References; the scope ledger in the header.

## Reference holds

- Cite every as-built fact a step depends on, with its file. Read the code an option's consequence depends on before asking (change mode).
- Where a gesture sits on a link or control, say which one wins.

## Moved from the plan at 0.9

- **Metrics:** the spec defines measures. The eval plan owns instruments and rules, and may refine a measure. A refinement goes to `revise` as an item, and the plan proceeds on its refinement.

**Writes, in `change` mode:** `changes/NN-change-<slug>.md` — what changes and why, acceptance criteria, what must not break, and a **Stages** section: one or more stages in the build plan's §5 shape, each with a size (S/M/L) and its traps. This section is what `build-phase` and `verify` read in place of a build plan; a change too large to stage here is a Module.
- **Header:** the kind (*change*), and `main @ <hash>` of the code it was written against.
- **Criteria:** the note owns a two-letter prefix (`README.md` §0). The criteria table has an *Item* column naming the review finding each criterion closes. A review's findings routed `question` join the note's first batch of questions.
- **Each stage** also has: an *Image and deploy* line; optional *At the verify* (a server runbook) and *Stop points* (commit boundaries). Lanes run targeted tests; the full suites are the verify's. It is sized with the test harness counted, as `build-plan` does. For any infrastructure change, it answers "what does this change about how later stages are built, verified or deployed?"
- **It ends with *What this makes stale*:** each file, its owner, and the step that catches it up. A note that defers the spec adds a `revise` line to its `STATE.md` block's next steps, and `close-out`'s gate fails while one is pending.

**Gate:** research, or a waiver line in the intake (`full`). In `change` mode: `STATE.md`'s top block and the lanes in flight are injected, and the skill refuses while a lane touches the same files. `build-phase` re-reads the note against `main`'s log since its `main @` before drafting a card.
