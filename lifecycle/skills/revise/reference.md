# `revise` — reference seeds

*Seeds for this skill's reference file and template, moved unchanged out of `skills-plan.md` at 0.11. They bind as the plan does. The skill's first author places them.*

**Version 0.1 · Status: seeds · 2026-10-20 · Owner: _root**

---

## Moved from the plan at 0.11

- An [F] decision from an earlier phase is accepted by default, but still scanned for an open sub-question. A spec assumption confirmed downstream is written into the spec.

**Writes,** for a module:
- `changes/NN-req-<slug>.md` (template `templates/change-request.md`): header (kind, `main @`, spec version from and to); *Items*, each with its outcome; *Changes to the spec*; *Carried to design*, each item linked to its source; *STALE*, with quoted sentences; *Open*; *Owed by other skills*, naming each touch-up (`eval-plan --touch-up`, `journeys update`, the design step) and its order in `STATE.md`'s next steps. Accepted Suggested items are noted as owed to the next `journeys` run;
- the spec's version bump, changelog line and ledger;
- `STALE` in `status.md` where the rule above says so;
- a line in the module's `decisions.md`, pointing at the change note;
- struck open-work rows it settled, citing its change note.

**`--catch-up <notes>`,** after a build: its writes are the files the notes' *What this makes stale* names (spec, plan, config, design README, the code repo's `CLAUDE.md`), each with the founder's acceptance and listed in its note. Pushing a repo whose `main` deploys asks first (§0).
