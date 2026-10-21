# `revise` — reference seeds

*Seeds for this skill's reference file and template, moved unchanged out of `skills-plan.md` at 0.11. They bind as the plan does. The skill's first author places them.*

**Version 0.2 · Status: placed — `SKILL.md` binds · 2026-10-21 · Owner: _root**

---

## Placed

Every seed below was placed in `SKILL.md` 0.1 on 2026-10-21 (rollout stage 3, session A, ahead of its own rollout stage at the founder's word). The plan's *Asks*, *Scope*, *Outcomes* and `STALE` rules went to steps 2, 3 and 5; *Writes* to steps 4, 6 and 7; `--catch-up` and the method mode to their own sections. The shared injection helpers are `skills/shared/design.sh`. `SKILL.md` binds from now on. Change it there, not here.

What placing added. Each is Claude's call, not yet reviewed by the founder:
- a finding the change request closes has its *Status* in `05-ux-review.md` set to `closed in changes/NN-req-<slug>.md`;
- the spec's headings are checked with `gate <module> 3`;
- method mode shows the founder the exact edit before writing it, and runs `gate-test` after a change to the gate or the required headings.

## The seeds, as moved

### Moved from the plan at 0.11

- An [F] decision from an earlier phase is accepted by default, but still scanned for an open sub-question. A spec assumption confirmed downstream is written into the spec.

**Writes,** for a module:
- `changes/NN-req-<slug>.md` (template `templates/change-request.md`): header (kind, `main @`, spec version from and to); *Items*, each with its outcome; *Changes to the spec*; *Carried to design*, each item linked to its source; *STALE*, with quoted sentences; *Open*; *Owed by other skills*, naming each touch-up (`eval-plan --touch-up`, `journeys update`, the design step) and its order in `STATE.md`'s next steps. Accepted Suggested items are noted as owed to the next `journeys` run;
- the spec's version bump, changelog line and ledger;
- `STALE` in `status.md` where the rule above says so;
- a line in the module's `decisions.md`, pointing at the change note;
- struck open-work rows it settled, citing its change note.

**`--catch-up <notes>`,** after a build: its writes are the files the notes' *What this makes stale* names (spec, plan, config, design README, the code repo's `CLAUDE.md`), each with the founder's acceptance and listed in its note. Pushing a repo whose `main` deploys asks first (§0).

## Changelog

- **0.2 · 2026-10-21** — Placed in `SKILL.md` 0.1. This file keeps the seeds as moved and a record of what placing added.
- **0.1 · 2026-10-20** — Seeds, moved unchanged out of `skills-plan.md`.
