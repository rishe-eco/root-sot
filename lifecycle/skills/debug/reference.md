# `debug` — reference seeds

*Seeds for this skill's reference file and template, moved unchanged out of `skills-plan.md` at 0.10. They bind as the plan does. The skill's first author places them.*

**Version 0.3 · Status: placed — `SKILL.md` binds · 2026-10-21 · Owner: _root**

---

## Placed

The seed below was placed in `SKILL.md` 0.1 on 2026-10-20 (rollout stage 2, session B) as rule 6. `SKILL.md` binds from now on. Change it there, not here.

What placing added. Each is Claude's call, not yet reviewed by the founder:
- each hypothesis is written with the result that would refute it, before its run;
- a failure with no cause found is run alone five times and recorded as a flake, as in `verify`;
- in a lane, the lane budget applies and the lane report carries the failure. The session that lands the lane writes `STATE.md`, not the lane.

It is the one build skill Claude may invoke on its own. Its description names root-app, Tracker and IMNSTR, so it isn't picked up for unrelated test failures.

## The seeds, as moved

### Moved from the plan at 0.10

- Don't edit a test file while a full run has it loaded. Fix it, then rerun that file after the run. App source may change mid-run if the server loads once at the start.

## Changelog

- **0.3 · 2026-10-21** — `SKILL.md` rule 1: reproduce on the surface the user saw (grep the callers; render the component, not a new helper). From `learned --consolidate`, the first (L-42).
- **0.2 · 2026-10-20** — Placed in `SKILL.md` 0.1. This file keeps the seed as moved and a record of what placing added.
- **0.1 · 2026-10-20** — Seed, moved unchanged out of `skills-plan.md` at 0.10.
