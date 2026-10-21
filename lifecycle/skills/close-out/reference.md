# `close-out` — reference seeds

*Seeds for this skill's reference file and template, moved unchanged out of `skills-plan.md` at 0.11. They bind as the plan does. The skill's first author places them.*

**Version 0.2 · Status: placed — `SKILL.md` binds · 2026-10-21 · Owner: _root**

---

## Placed

Every seed below was placed in `SKILL.md` 0.1 on 2026-10-21 (rollout stage 3, session A, ahead of its own rollout stage at the founder's word). *Writes* went to full mode steps 1 to 7; *Cost* to step 4; the reminders to step 3. The shared injection helpers are `skills/shared/design.sh`. `SKILL.md` binds from now on. Change it there, not here.

What placing added. Each is Claude's call, not yet reviewed by the founder:
- the cost figure is asked of the founder, never estimated when it can be given;
- the stage records' *Decided*, *Owed* and *Flagged for close-out* sections are injected from the code checkout, or the plan's changelog when it isn't on the machine;
- design-side canon flags are left to `revise --catch-up`, named as the next step, while as-built canon is written here;
- `--eval` has no phase gate: it needs the close-out and a check whose date has come.

## The seeds, as moved

### Moved from the plan at 0.11

**Writes:**
- `09-close-out.md`: the evaluation result against the rule written beforehand; what the plan did not know, aggregated; the module's cost; a short retrospective, including the lessons consolidated during the module.
- **Closed, launch-ready and evaluated are separate.** It records launch's date, or "not yet"; writes the later checks' dates, counted from launch; and creates their reminders (a `/schedule` task, with the founder's yes). The row reads `closed · eval <date>` until the last check.
- **Cost** in dollars from `/usage`, plus the session-limit share where it is shown. Each log's *Cost* says whether its figure is exact or estimated, and which log carries a shared session's figure. Steps run outside Claude Code read the limit percentage at start and end.
- Updates the *Grading* line of each design document to say what is now as-built, citing the stage records.
- Moves documents from `working/` or `drafts/` into canon, per the area's conventions.
- Applies the canon-sync flags to the as-built canon: the canon `config.md` names (for IMNSTR: the spec, plan, design README and `CLAUDE.md`), through `revise --catch-up` when the files are design-side.
- Updates the roadmap.
- Closes the `status.md` row as done, parked or killed.

**From:** the canon/working convention in `ecosystem/README.md`; this retrospective, which `close-out` completes for the journeys build.

## Changelog

- **0.2 · 2026-10-21** — Placed in `SKILL.md` 0.1. This file keeps the seeds as moved and a record of what placing added.
- **0.1 · 2026-10-20** — Seeds, moved unchanged out of `skills-plan.md`.
