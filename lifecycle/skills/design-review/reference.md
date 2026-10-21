# `design-review` — reference seeds

*Seeds for this skill's reference file and template, moved unchanged out of `skills-plan.md` at 0.10. They bind as the plan does. The skill's first author places them.*

**Version 0.2 · Status: placed — `SKILL.md` binds · 2026-10-21 · Owner: _root**

---

## Placed

Every seed below was placed in `SKILL.md` 0.1 on 2026-10-21 (rollout stage 3, session A, ahead of its own rollout stage at the founder's word). *Reads* went to the injection (the design system row, and Root's brand files only where it points at them) and *The checklist*. The shared injection helpers are `skills/shared/design.sh`. `SKILL.md` binds from now on. Change it there, not here.

What placing added. Each is Claude's call, not yet reviewed by the founder:
- the checklist sits in `SKILL.md` under *The checklist*, because `verify` reads it there for UI stages;
- the access gates are given figures: WCAG 2.2 AA contrast (4.5:1, 3:1 for large text and controls), 24 × 24 CSS px targets (2.5.8) or the project's own minimum, and reflow at 200% or a 180 px viewport (1.4.4, 1.4.10);
- the review runs the app at the deployed commit, or the stage's branch for a stage review; a scoped review before every stage is verified needs the founder's override;
- column 9 is written only when the live `ux-review` pass covers the same commit;
- owed rows are returned for the open-work file, not written: that file is `verify`'s and `close-out`'s.

## The seeds, as moved

### Moved from the plan at 0.10

**Reads:**
- the design system named in `config.md` §1. For Root's products that row points at: the summary sections of `ecosystem/canon/01-philosophy/01-brand-definition.md`; the code repo's `apps/web/src/styles/tokens.css`; the type and spacing rules from `ecosystem/working/root-website-requirements_2.md`. Root's brand and tokens apply only when the row points at them;
- its own reference checklist: accessibility gates (contrast, touch targets, text scaling, keyboard, screen reader); hierarchy, feedback and consistency; right-to-left rules.

**From:** the review format and accessibility gates of `dickwu/apple-design-skill`, borrowed, not installed; its lookup-table loading, kept small.

## Changelog

- **0.2 · 2026-10-21** — Placed in `SKILL.md` 0.1. This file keeps the seeds as moved and a record of what placing added.
- **0.1 · 2026-10-20** — Seeds, moved unchanged out of `skills-plan.md`.
