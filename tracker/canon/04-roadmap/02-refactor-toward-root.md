# Tracker — The Refactor Toward Root

*Source of truth. The gap between tracker-as-it-is and the Organize pillar it's meant to become. Concept ownership is Root's; this file holds the seam. Update the changelog; don't fork.*

**Version 0.1 · Status: draft (derived from Root canon) · 2026-07-22 · Owner: _root**

---

## 1. The frame

Tracker was built as a competent goal-execution app and is being pulled toward Root's **Organize** pillar. This file names the distance still to travel. It is deliberately thin — the *concept* is owned by Root canon `02-pillars/organize.md`; here we only hold the mapping to this codebase. When the two disagree on direction, Root wins.

## 2. The four outcomes — and where Tracker stands

Organize is defined by four distinct outcomes (Root canon `organize.md` §2):

| # | Outcome | Tracker today |
|---|---|---|
| 1 | **Recognize** currently active goals | partial — goals exist and list, but nothing helps *surface* what you're actually chasing |
| 2 | **Understand loopholes** — your own patterns in how you pursue and drop goals | **absent** — this is the leverage outcome and it isn't built |
| 3 | **Track** pursuit over time | **strong** — this is almost all of what Tracker does today |
| 4 | **Set new goals** with clarity | partial — the **Clarity Check** is the one real piece here |

The honest summary: **Tracker is overwhelmingly outcome 3.** The current lean for what to tackle first is outcome 2 (loophole recognition) — a discovery decision, not settled.

## 3. What's missing, in the pillar's terms

Drawn from `organize.md` §3–§6:

- **No mindset frame.** Organize is meant to set a frame first — *pursuing a goal badly is information, not failure* — before any tracking or introspection. Tracker opens straight into execution.
- **No loophole recognition (outcome 2).** No surface for seeing *how* one fails at pursuit. This is the highest-leverage gap.
- **No failure handling with effort/outcome separation.** Organize needs a first-class failure mode that asks "in my control or not? what can I learn? what next?" — the structural read (Reflect owns the emotional read). Tracker has action *fates*, but no goal/project *failure* concept.
- **No Reflect↔Others motive coupling.** Service goals are supposed to arrive from Others via Reflect's motive check and then get the same rigor as any goal. None of that seam exists in Tracker.

## 4. The streak tension (a live design constraint)

The recurring `Interval` / `Routine` machinery is **streak-adjacent**. It sits correctly in Organize (future commitments tracked over time) rather than in Reflect/Maintain — but it must be *surfaced* so it never reads as a streak, per Root's no-streaks refusal. The `remove_habits` migration shows streak-style habits were already dropped once, on purpose. **Open question:** how recurrence is re-presented so it doesn't drift back into streak mechanics.

## 5. Open questions (mirror of `organize.md`)

- How the execution machinery is re-surfaced so recurrence doesn't read as streaks.
- Whether the Pre-day/After-day cycle survives, changes, or retires under the new concept.
- Which of the four outcomes the refactor tackles first (current lean: outcome 2).

## 6. Carrying issues into the refactor

Some catalogued bugs are really pieces of this refactor, not isolated fixes — most notably **B-10** (postponed actions disappearing) lives at `ActionFate.Postponed`, exactly where a real failure/postpone concept would be reworked. Fold such items into the refactor rather than patching them twice.

---

## Changelog

- **0.1 · 2026-07-22** — Initial. Derived from Root canon `organize.md` (v0.1, 2026-07-14) and mapped to the current tracker build.
