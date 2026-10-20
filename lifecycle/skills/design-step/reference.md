# The design step (4b) — reference seeds

*Seeds for this skill's reference file and template, moved unchanged out of `skills-plan.md` 0.5 at 0.6. They bind as the plan does. The skill's first author places them, in stage 2 or later.*

**Version 0.1 · Status: seeds · 2026-10-20 · Owner: _root**

---

## Template: the design README

- the design system it settles (type, colour, spacing, components);
- *Beyond the spec*, with *scope* and *ends when* columns;
- a plate index: plate, caption anchor, journey steps, criteria, states and copy;
- every plate carries its `Wireframe plate N.` marker;
- *Disagreements*: where phone and desktop frames differ;
- contrast figures measured by a script, never by eye;
- *What didn't survive* the move from the tool.

## The import's checklist

- serve locally and confirm zero external requests;
- reduced motion may be checked in the source;
- every revealed or animated state is drawn at the narrowest width;
- check against the README's list while the founder compares with the tool's preview;
- name at least one frame per new plate to look at by eye;
- keep what was lost in the move apart from what is missing in the design.

## Moved from the plan at 0.9

**Opening form,** before the first direction: references, the feel wanted, and whether an attached design system binds.

**Inputs:** spec §4 and §6; the journeys' steps and states table; the wireframes' coverage plate. A second pass also reads the change notes' *Carried to design* lists (each item linked to its source), any earlier design review folder, and the spec sections those notes cite. Before editing in the tool, re-read the repo's latest source.

**How much to draw:** phone for every screen and state. Desktop is required for public pages and the main editor. Gaps are listed in the README. Build plate by plate: large single writes time out.

**Output:** `04b-design/`: self-contained HTML exports plus `source/`, edited in place (git keeps the history), and a README.

**The handoff.** A design tool that can't push leaves files at their repo paths in `../repo-handoff-<step>/`, beside the repo.

**The import** (Opus, medium) has its own log and `STATE.md` block, and may edit `04b-design/README.md`. It diffs `STATE.md` and merges by block, never by overwriting. Its checklist is in `skills/design-step/reference.md`.

**Optional review at the end of 4b:** an accessibility and HIG pass that writes proposals only, for `revise`. Scores are left to the UX review.
