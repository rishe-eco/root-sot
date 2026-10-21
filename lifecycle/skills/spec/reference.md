# `spec` — reference seeds

*Seeds for this skill's reference file and template, moved unchanged out of `skills-plan.md` 0.5 at 0.6. They bind as the plan does. The skill's first author places them, in stage 2 or later.*

**Version 0.2 · Status: placed — `SKILL.md` binds · 2026-10-21 · Owner: _root**

---

## Placed

Every seed below was placed in `SKILL.md` 0.1 on 2026-10-21 (rollout stage 3, session A). *Template* is `templates/02-spec.md` and `templates/change-note.md`, which the skill injects; *Reference holds* went to change mode steps 2 and 3 and full mode step 4; the *Metrics* line to full mode step 4; *Writes, in `change` mode* to change mode step 5; the *Gate* to step 4 (the lanes check) and to `build-phase`, which re-reads the note against `main`. `SKILL.md` binds from now on. Change it there, not here.

What placing added. Each is Claude's call, not yet reviewed by the founder:
- **No gate mode for change notes.** `bin/gate` is unchanged. In change mode the plan's gate is the lanes check, and `context.sh` injects it: each live lane in the project's modules, with the files its branch touches against the base branch, and the checkout's other unmerged branches. The skill refuses on a lane's overlap and only names a branch's. `gate <module> spec` would fail every module that predates the method, which has no research.
- **The note is checked by the stage-8 gate** (`gate <module> 8 <first stage>`) before it is committed: its headings, and every criterion id in a stage's **Acceptance** line.
- **"Too large to stage here"** is read as more than three stages, or any stage over size L.
- **`decisions.md`:** the skill writes one line per note in the shape of the journeys module's file, and backfills an earlier note's missing line in the same commit (note 02 had none).
- **`STATE.md` and `status.md` are left alone in change mode** (`README.md` §4): `build-phase` writes the lane block and `verify` writes column 8. The session's state comes from `handoff`, if no `build-phase` follows in it.
- **root-sot on `main`:** the batch asks whether to commit there or on a branch.
- **Full mode** writes column 2 of `status.md` and checks the spec with `gate <module> 3`. It is unproved until the next new module (`README.md` §8, stage 3).

## The seeds, as moved

### Template

Summary, What it is, Decisions taken at spec, Metrics, Interface requirements, Risks, Acceptance criteria, Out of scope, Changelog, References; the scope ledger in the header.

### Reference holds

- Cite every as-built fact a step depends on, with its file. Read the code an option's consequence depends on before asking (change mode).
- Where a gesture sits on a link or control, say which one wins.

### Moved from the plan at 0.9

- **Metrics:** the spec defines measures. The eval plan owns instruments and rules, and may refine a measure. A refinement goes to `revise` as an item, and the plan proceeds on its refinement.

**Writes, in `change` mode:** `changes/NN-change-<slug>.md` — what changes and why, acceptance criteria, what must not break, and a **Stages** section: one or more stages in the build plan's §5 shape, each with a size (S/M/L) and its traps. This section is what `build-phase` and `verify` read in place of a build plan; a change too large to stage here is a Module.
- **Header:** the kind (*change*), and `main @ <hash>` of the code it was written against.
- **Criteria:** the note owns a two-letter prefix (`README.md` §0). The criteria table has an *Item* column naming the review finding each criterion closes. A review's findings routed `question` join the note's first batch of questions.
- **Each stage** also has: an *Image and deploy* line; optional *At the verify* (a server runbook) and *Stop points* (commit boundaries). Lanes run targeted tests; the full suites are the verify's. It is sized with the test harness counted, as `build-plan` does. For any infrastructure change, it answers "what does this change about how later stages are built, verified or deployed?"
- **It ends with *What this makes stale*:** each file, its owner, and the step that catches it up. A note that defers the spec adds a `revise` line to its `STATE.md` block's next steps, and `close-out`'s gate fails while one is pending.

**Gate:** research, or a waiver line in the intake (`full`). In `change` mode: `STATE.md`'s top block and the lanes in flight are injected, and the skill refuses while a lane touches the same files. `build-phase` re-reads the note against `main`'s log since its `main @` before drafting a card.

## Changelog

- **0.2 · 2026-10-21** — Placed in `SKILL.md` 0.1. This file keeps the seeds as moved and a record of what placing added.
- **0.1 · 2026-10-20** — Seeds, moved unchanged out of `skills-plan.md` 0.5 at 0.6.
