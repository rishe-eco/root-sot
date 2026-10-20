# `ux-review` — reference seeds

*Seeds for this skill's reference file and template, moved unchanged out of `skills-plan.md` 0.5 at 0.6. They bind as the plan does. The skill's first author places them, in stage 2 or later.*

**Version 0.2 · Status: placed — `SKILL.md` binds · 2026-10-21 · Owner: _root**

---

## Placed

Every seed below was placed in `SKILL.md` 0.1 on 2026-10-21 (rollout stage 3, session A, ahead of its own rollout stage at the founder's word). *Reference holds* went to *Before anything else* and step 7; the modes, the injected owed items and *Live mode* to step 1 and the injection; *Writes* to step 6. The shared injection helpers are `skills/shared/design.sh`. `SKILL.md` binds from now on. Change it there, not here.

What placing added. Each is Claude's call, not yet reviewed by the founder:
- an earlier pass's headings are injected, but not its findings, so the reviewer can't read them until its own are written (step 7);
- design mode renders the design or wireframes at 360 px and desktop width with a headless browser or the browser pane;
- a live pass writes column 9 only when `08-design-review.md` covers the same commit, since column 9 is the live review as a whole;
- a design pass is checked with `gate <module> 7`, which reads `05-ux-review.md`'s headings and its open findings.

## The seeds, as moved

### Reference holds

a review with an earlier pass in the folder reads it only after its own findings are written. Before calling a state missing, check the design's captions and README.

### Moved from the plan at 0.10

**Modes:** `design` (before build, on the latest design: 4b where it exists, else `04-wireframes.html`; observations graded *simulated*) · `live` (after UI stages).

- injected: the change notes' *carried* lists and the open-work file's verification and founder rows, so owed items aren't counted as defects; the serve-and-capture script (`config.md`), to render a bundled design.

**Live mode** reads production read-only, as a bot (`HEAD` or a bot agent) wherever the project counts readers. It walks every state, and anything behind sign-in, on a local server built from the deployed commit, with the review seed route and a virtual authenticator.

**Writes:** a dated pass appended to `05-ux-review.md`, with one short summary per pass at the top of the file, newest first. A required *For `revise`* heading lists the findings that change the spec. The findings table has a *Status* column (`open`, `closed in <file>`, `carried to <step>`), which `revise`, the design import and change notes update; `build-plan`'s gate greps it for `open`. After the build, UI fixes go to `spec change` as one proposed Change.

## Changelog

- **0.2 · 2026-10-21** — Placed in `SKILL.md` 0.1. This file keeps the seeds as moved and a record of what placing added.
- **0.1 · 2026-10-20** — Seeds, moved unchanged out of `skills-plan.md`.
