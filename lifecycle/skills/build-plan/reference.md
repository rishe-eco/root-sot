# `build-plan` — reference seeds

*Seeds for this skill's reference file and template, moved unchanged out of `skills-plan.md` 0.5 at 0.6. They bind as the plan does. The skill's first author places them, in stage 2 or later.*

**Version 0.2 · Status: placed — `SKILL.md` binds · 2026-10-21 · Owner: _root**

---

## Placed

Every seed below was placed in `SKILL.md` 0.1 on 2026-10-21 (rollout stage 3, session A). *Template* is `templates/07-build-plan.md`, injected; *Reference holds* went to steps 2 and 4; *Step 1* to step 1; *Writes* and *Each stage section* to steps 4 and 5; *Sizes* to step 4; *Gate* to *Before you start*. The shared injection helpers are `skills/shared/design.sh`. `SKILL.md` binds from now on. Change it there, not here.

What placing added. Each is Claude's call, not yet reviewed by the founder:
- an open item that changes the spec's scope is carried to `revise`, never accepted in the plan;
- the plan is checked with `gate <module> 8 <first stage>`, which reads its stage sections' bold fields;
- the skill writes column 7 and leaves column 8 to `verify`;
- the push that ends the session is asked for, since root-sot is public.

## The seeds, as moved

### Template

`templates/07-build-plan.md`, the §0–§10 skeleton and one sample stage. *Held:* a 400–600-word bound per stage, until a second plan exists to compare with.

### Reference holds

- In the defect pass, take each "never shows X" in the spec and ask which mechanism could leak X: ids, URLs, timing, logs, cookies the browser sends. For every count or row created from request data, name what bounds its growth.
- When the spec fixes every table, the whole schema lands in the first stage, so lanes can run in pairs.

### Moved from the plan at 0.9

**Step 1, the foundation batch:** when `projects/<project>/` doesn't exist, ask the founder's facts in one batch before drafting: repo, host, stack, domain, server facts, the devices they have. Answers go in the plan's §4, marked as answered. For a new project, the plan's §0.3 is the source of the project's house rules, which `project-config` transcribes.

**Writes:** `07-build-plan.md` in the journeys plan's shape — §0 what was read, what must not break, house rules, defects found and assigned · §1 the shape at the end · §2 planning decisions (PD-n), each vetoable · §3 stage order, milestones, parallel lanes allowed (never two touching shared schema) · §4 pre-flight unknowns · §5 one section per stage, to the level of models, mutations, refusal codes, screens and tests, with a **size (S/M/L)** and its **traps** · §6 cross-cutting catalogues · §7 what changes in built code · §8 verification and its ceiling · §9 where this goes wrong · §10 for the founder.

**Each stage section** also says, beside size and traps:
- **Image and deploy:** new environment variables with production defaults, and toolchain changes;
- **constraints from earlier stages** its writes must work through (triggers, unique keys);
- **the plate it draws from,** and which stage owns each control on it. A frame-first split is planned explicitly;
- **the API from the screens' save boundaries,** not one route per verb;
- **a guard for every destructive CLI;**
- **deploy-sequencing traps as stages** (B6a, B6b), never as an instruction one lane can't carry out;
- **for a server-filled field,** what the screen shows for each verb.

**Sizes:** a size is lane hours and lines of new app code, with tests and moved code counted apart. *Evidence* (IMNSTR): stages overran their line estimates (B4a +3,875 against L's ~3,000; B5 +2,634 against M's ~1,500; B7 +5,291) while running far under in time (B4a about 23 min against 4–6 h). Recalibrate from the stage records once a second module exists.

**Gate:** as `README.md` §2, phase 7: phases 2–6; UX findings, journeys' *Suggested*, the design's *Beyond the spec* and wireframes' *Calls made here* each accepted, refused or carried; `revise`'s *Open* items.

## Changelog

- **0.2 · 2026-10-21** — Placed in `SKILL.md` 0.1. This file keeps the seeds as moved and a record of what placing added.
- **0.1 · 2026-10-20** — Seeds, moved unchanged out of `skills-plan.md`.
