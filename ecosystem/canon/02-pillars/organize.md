# Root · ریشه — Pillar: Organize
*Source of truth. Short on purpose. Concept + philosophy as canon; as-built tracker in the appendix. Update the changelog; don't fork.*

**Version 0.1 (draft) · 2026-07-14 · Owner: _root**

---

## 1. Purpose

Organize is where understanding becomes committed, tracked pursuit. It is the only pillar where time horizons expand and things are followed over time. It exists to help a person recognize what they're actually chasing, see *how* they chase it (and fail), track real pursuit, and set new goals with clarity — all without becoming the goal-optimization treadmill Root refuses.

## 2. Four outcomes, kept separate

An early error was collapsing these into one sentence; they are four distinct discovery problems (see the decision log and `03-engine/`):

1. **Recognize** currently active goals.
2. **Understand loopholes** — one's own patterns in how one pursues (and drops) goals.
3. **Track** pursuit over time.
4. **Set new goals** with clarity.

"Doing all four effectively" is a byproduct, not a fifth outcome. Outcome 2 is the leverage point: without seeing *how* you fail, recognizing, tracking, and setting new goals just repeats the pattern.

## 3. Mindset first

Before tracking or introspection, Organize sets a frame — because a person who doesn't believe loopholes are discoverable and workable will track like an obligation and introspect defensively. The frame (growth-mindset lineage; cf. stress/emotion reappraisal interventions): **pursuing a goal badly is information, not failure; understanding your own pattern is the highest form of self-knowledge here.** Give the frame first, briefly and felt; then invite the work. This is scoped to Organize now, likely the whole Journey later.

## 4. Understanding, not fixing

Outcome 2 stops at *recognizing and articulating* the loophole. Fixing the pattern — building the capacity to pursue differently — is **Learn's** job, not Organize's. The loophole is the bridge: Organize says "here's what's true about how I pursue," Learn says "here's what I can build to pursue differently." Keep the line clean.

## 5. Failure handling (a gap the concept must close)

Organize needs a first-class **failure mode**, not just a success path. Two toxic responses to guard against: "I tried, it didn't work, so effort is pointless" and "I failed, full stop." Growth mindset's move — **separate effort from outcome** — is the antidote: you own effort, strategy, and learning; you do not own outcomes. So on failure, Organize asks: was this in my control or not? did I know? what can I learn? what next time? The structural read lives here; the emotional and meaning-making read lives in **Reflect** (the Reflect↔Organize coupling). This also closes the Others execution gap — service goals whose outcomes you don't control ("I showed up fully and it still didn't land") need exactly this effort-vs-outcome handling.

## 6. Service goals

Service acts recognized in Others, once they pass Reflect's motive check, arrive in Organize and get the **same rigor as any goal**: blocked time, prep, reliable follow-through. This is the core reframe — **discipline is the container for compassion, not its enemy.** A promise not kept isn't compassion; it's performance. This tightly couples Reflect and Organize on the service path (motive in, failure out).

## 7. The Clarity Check (F-1)

A "ready to act on?" soft indicator for a goal's definition-of-done, across five dimensions — **Observability, Control, Binary Clarity, Ownership, Decomposability**. It is **non-gating**: amber/green soft indicator with flagged dimensions, never a block. It is *already implemented* in the tracker (see appendix). The same object, pointed at the team's own work, is the model for the engine's stage gates (`03-engine/`).

## 8. Decision test

Does the feature help the person pursue *what they genuinely want, seen clearly, learning from how they pursue* — or does it optimize output and incentivize hitting numbers? The second is the goal-setting dark side (`04-research/`); it's off-pillar.

---

## Appendix A — As-built: the tracker (to be refactored)

*Read from schema + component structure of `trackerProject` (Vite + React Router 7, Apollo/GraphQL, Radix, Tailwind 4, i18next, PWA) and `trackerApi` (Express + Apollo Server, Prisma/SQLite, JWT). **Below the data-model level, verify in code.***

**What exists.** A goal-execution system, already mid-transformation toward Root:
- **Hierarchy:** `Goal` (with `dod`; goal-groups and parent goal/milestone nesting) → `Milestone` (`doa`, ordered, `isLast`) → `Project` (`dod`; links to goal *or* milestone) → `Action` (priority, estimated time, scheduled time, gathered-action fields).
- **Recurrence:** `Interval` (scoped to goal/milestone/project; repeat rules; steps) and `Routine` (daily-with-timer; time-of-day blocks; steps).
- **Priority:** `P/S/O/B` — an urgency×importance scheme (Primary / Secondary / Outsource / Bucket-list).
- **Daily cycle:** Pre-day → Action-gathering → After-day wizard, with `DayState` tracking completion and an `ActionFate` disposal set (Postponed / Outsource / Backlog / BucketList / PassedArchived).
- **Already-Root pieces (grafted on):** the **Clarity Check** is live — `Goal.dodClarityStatus` ("green"|"amber", null = not run) + `dodFlaggedDimensions`. **Journaling** exists — `Journal` (linkable to goal/project, a default journal per user, shareable by email via `JournalAccess`) + `JournalEntry`; this is Journey/ماجرا seeded inside the tracker. **Onboarding + module intros** exist — `OnboardingProgress`, `ModuleIntroViewed` (keyed by `moduleKey`), plus `concepts`, `tools`, `activities` front-end surfaces.

**Refactor gap.** The tracker is overwhelmingly **outcome 3 (track/execute)**. It has no mindset frame, no loophole recognition (outcome 2), no failure handling with effort/outcome separation (§5), and no Reflect motive-coupling for service. The recurring `Routine`/`Interval` machinery is streak-adjacent — it lives correctly in Organize (future commitments) rather than Reflect/Maintain, but must be reconciled with the no-streaks refusal in how it's surfaced. A prior `remove_habits` migration shows streak-style habits were already dropped once (philosophy-consistent). Bug **B-10** (postponed actions disappearing) lives at `ActionFate.Postponed`.

**Hygiene, not urgent.** The frontend repo has committed `.env` / `.env.production`; the API has a committed `dev.db`. Contents not inspected. If any hold real secrets, treat as exposed and rotate at refactor time.

## Open questions

- How the tracker's execution machinery is re-surfaced so recurrence doesn't read as streaks.
- Whether the Pre-day/After-day cycle survives, changes, or retires under the new concept.
- Which of the four outcomes the refactor tackles first (discovery decision; current lean is outcome 2).

---

## Changelog

- **0.1 · 2026-07-14** — Initial draft. Four outcomes separated, mindset-first, understanding-not-fixing, failure handling with effort/outcome split, service-goal discipline, Clarity Check (F-1). As-built appendix from updated repos: Clarity Check, journaling, onboarding/module-intro scaffolding all found present.
