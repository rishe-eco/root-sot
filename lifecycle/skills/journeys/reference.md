# `journeys` — reference seeds

*Seeds for this skill's reference file and template, moved unchanged out of `skills-plan.md` 0.5 at 0.6. They bind as the plan does. The skill's first author places them, in stage 2 or later.*

**Version 0.2 · Status: placed — `SKILL.md` binds · 2026-10-21 · Owner: _root**

---

## Placed

Every seed below was placed in `SKILL.md` 0.1 on 2026-10-21 (rollout stage 3, session A). *Reference holds* went to *Rules for every mode*; the modes, *Asks*, the step cells, Coverage, Suggested, the states table and amending to *The modes* and step 3. The shared injection helpers are `skills/shared/design.sh`. `SKILL.md` binds from now on. Change it there, not here.

What placing added. Each is Claude's call, not yet reviewed by the founder:
- `gap` mode records the code check as a *Code* column (Have, Partly, Missing, with the file) in each journey's table, in the shape of `ecosystem/working/root-studio-user-journeys.md` §2;
- the file is checked with `gate <module> 4`, whose coverage line diffs the spec's criteria against the Coverage table;
- `new` takes the version to 0.2 when `personas` wrote 0.1;
- the skill writes column 3, and an `update` run clears a `STALE` there.

## The seeds, as moved

### Reference holds

failure journeys walk every security requirement; each walk's additions are Suggested, so they land on the spec's scope ledger where the founder sees them.

### Moved from the plan at 0.9

- `new` — 3–5 journeys (first day, normal loop, return after a gap, not enough data, error) of ~10 steps each. Scenarios may share a journey, error journeys may be branches, and a journey with two actors adds a *Who* column. About 3,000–4,000 words, a guide, not a limit.

`gap` and `update` may be scoped (`--steps J2.9,J3.4` or `--from-note 07`): the changelog then says what wasn't checked, and the status cell stays `done`.

**Asks:** in every mode, one batch, recorded in *Decisions taken at journeys*. A founder decision the spec lacks is also listed as Suggested, for `revise`.

- **Each step's last cell, *Must be true*,** is a check citing criteria. Steps are cited `J<n>.<step>`.
- **`## Coverage`** (required): each acceptance criterion to its step, as `step`, `no screen` or `all steps`.
- **Suggested,** in every mode: requirements the spec lacks, kept apart in a section `revise` reads. Once accepted, the next `journeys` run marks each "accepted at spec x.y", pointing at its criterion.
- **A states table** at the end (empty, error, loading, not enough data, notices), which `wireframes` reads.
- **Amending:** keep step numbers, give inserted steps a letter suffix, and mark changed text **[x.y]**, so citations downstream still hold.

## Changelog

- **0.2 · 2026-10-21** — Placed in `SKILL.md` 0.1. This file keeps the seeds as moved and a record of what placing added.
- **0.1 · 2026-10-20** — Seeds, moved unchanged out of `skills-plan.md`.
