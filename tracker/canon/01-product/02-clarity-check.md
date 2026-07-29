# Tracker — The Clarity Check

*Source of truth. The one feature where Root's philosophy is already a feature. Update the changelog; don't fork.*

**Version 0.1 · Status: as-built · 2026-07-22 · Owner: _root**

---

## 1. What it is

The Clarity Check is a **five-step wizard** that reviews whether a goal's **definition of done** is well-formed. It does not grade the goal or block the user; it produces a **soft indicator** — green or amber — with the specific dimensions that were flagged, so the goal's readiness is visible at a glance.

It is the most direct expression in the product of Root's conviction that **an intelligent question compounds where a straight answer is spent** (Root canon `01-philosophy/00-core-philosophy.md` §3). The same object, pointed at the team's own work, is the model for the engine's stage-gates in Root canon `03-engine/`.

Component: `client/app/components/goals/DodClarityWizard.tsx`. It is reusable — triggered from the goal form and re-runnable from the Manage Goal page.

## 2. The five dimensions

Each dimension is one question the user answers about their DoD. The wording below is the current copy (source: `base/research/Rood DoD clarity questions.txt`, retained as reference).

1. **Observability** — *"What will be different or exist when this is done — whether that's something you can point to, a skill you've gained, or a change in how things work?"* You should be able to describe what changed or what exists — a deliverable, a learned skill, a concrete outcome. This is how you know you're actually done.

2. **Control** — *"Does this depend on anyone else saying yes or making a decision?"* If completion depends on someone else's approval, you're not fully in control. Either reframe to what you can do, or be explicit about the dependency and plan for the uncertainty.

3. **Binary Clarity** — *"Is 'done' a clear yes-or-no, or does it exist on a scale?"* Scale goals ("get better," "improve") never quite finish. A clear yes/no makes completion obvious.

4. **Ownership** — *"Is this something you genuinely want, or are you doing it because someone else expects it?"* If it's someone else's want, you'll struggle to prioritize it or push through when it's hard.

5. **Decomposability** — *"What's your actual first step — the one you could start today?"* If you can't name a first step, break the goal down further; a concrete next action tells you whether you actually know what you're doing.

## 3. How it behaves

- **Non-gating.** The outcome is `dodClarityStatus` = `"green"` or `"amber"` (or `null` = never run). Flagged dimensions are stored in `dodFlaggedDimensions` (a JSON array of dimension keys). Amber is a nudge, not a wall — the user can proceed with a flagged DoD.
- **Persisted on the goal.** Both fields live on the `Goal` model (migration `20260612022408_add_dod_clarity_to_goal`).
- **Saves immediately on completion.** When the wizard is re-run on an already-saved goal, the result is written on completion with no separate save step. (This reflects a standing UX preference — immediate saves on wizard completion in edit contexts; buffer to local state only in create-flows before the entity exists.)
- **Surfaced as a badge.** The goal card shows the clarity state so readiness is visible without opening the goal.

## 4. Scope notes

- The check currently targets **Goal DoD**. The same pattern is intended for **Milestone DoA**; confirm in code whether that path is wired before assuming it.
- The dimensions and their copy are a **product-design artifact owned by Root philosophy**, not an engineering detail — changes to the questions should be made deliberately and reflected here.

---

## Changelog

- **0.1 · 2026-07-22** — Initial. Five dimensions and copy from the reference file; behavior verified against the schema (`dodClarityStatus`, `dodFlaggedDimensions`) and the wizard component's presence.
