# `personas` — reference seeds

*Seeds for this skill's reference file and template, moved unchanged out of `skills-plan.md` 0.5 at 0.6. They bind as the plan does. The skill's first author places them, in stage 2 or later.*

**Version 0.2 · Status: placed — `SKILL.md` binds · 2026-10-21 · Owner: _root**

---

## Placed

Every seed below was placed in `SKILL.md` 0.1 on 2026-10-21 (rollout stage 3, session A). The registry record is `templates/persona-record.md`, which the skill injects; *Writes* went to steps 3, 4 and 7. The shared injection helpers are `skills/shared/design.sh`. `SKILL.md` binds from now on. Change it there, not here.

What placing added. Each is Claude's call, not yet reviewed by the founder:
- the plan names no gate, so the skill runs `journeys`' (`gate <module> 3`): its spec line is the input, and its personas line is what the skill satisfies;
- `personas` doesn't write `status.md`: column 3 is `journeys`';
- each accepted persona's decision-log entry is its own commit, in `decision-record`'s format;
- add mode appends rows and doesn't bump the journeys' version.

## The seeds, as moved

### Template: the registry record

ID, name, serves, grounding, grade (*hypothesis* or *grounded*), arrives how, device, knows entering (including the languages read), probes. Demographics are optional and never invented.

### Moved from the plan at 0.9

**Writes:** the selection into the module's `03-journeys.md` header (creating the file; `journeys` fills it): a title block plus `## Personas`, a table of persona, serves, why and anchors. `personas` owns `## Personas`, and `journeys` never edits it; the journeys version is bumped by the next `journeys` run. A proposed persona goes into `personas.md` marked *hypothesis*, with a decision-log entry in `decision-record`'s format.

## Changelog

- **0.2 · 2026-10-21** — Placed in `SKILL.md` 0.1. This file keeps the seeds as moved and a record of what placing added.
- **0.1 · 2026-10-20** — Seeds, moved unchanged out of `skills-plan.md`.
