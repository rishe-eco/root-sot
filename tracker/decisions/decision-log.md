# Tracker — Decision Log

*Append-only, living. How we got here and what we set aside. New decisions go at the top of §2; don't rewrite history — supersede it. Update the changelog; don't fork.*

**Version 0.1 · Status: living · 2026-07-22 · Owner: _root**

---

## 1. Migration timeline (the build, in order)

The migration history is the ground truth of how the schema evolved. Condensed:

| Date | Migration(s) | What it means |
|---|---|---|
| 2025-04 → 05 | init · project · goal · goal_milestone_setup · user · user_password | Foundations: goals, projects, milestones, users, auth. |
| 2025-06 | habit_cycle_and_actions · consistency_checks | An earlier **habits/streak** model. |
| 2026-02-17 | **remove_habits** | Streak-style habits **dropped** — the first clear philosophy alignment (no streaks). |
| 2026-02-17 → 18 | intervals · interval_status · interval_custom_repeat_rule · routines · estimated_time · routine_time_of_day_blocks | Recurrence rebuilt as **Intervals + Routines** (future commitments, not streaks). |
| 2026-02-19 → 20 | day_state_and_action_today_fields · pre_day_completed_at · milestone_order_and_is_last · interval_predicted_to_do_time · goal_group_and_parent | The **daily cycle** (DayState, Pre-day/After-day, gathered-action fields) and **goal groups / hierarchy**. |
| 2026-06-12 | **add_dod_clarity_to_goal** | The **Clarity Check** — first feature that is pure Root philosophy. |
| 2026-06-13 | **add_notes · add_onboarding · add_journals** | Notes, the onboarding system, and **journals** (a *Journey/ماجرا* seed) — the graft toward the brand. |

## 2. Key decisions

### D-16 · Clarity Lab core built; detector caps, judge deducts — 2026-07-27
Content pack (`clarity/v1`: rubric v1, six modules, nine items, `en` + `fa`), deterministic detectors for R1/R4/R6, rubric assembly, and the judge with its calibration gate. No schema change — the engine from **D-14** carried it. Adds `@anthropic-ai/sdk` as the project's first external-service dependency.

Four things the build settled:

1. **The detector is a ceiling; the judge may only lower it.** `min(detector, judge)` for the three criteria both can see. This resolves the spec's own tension between "R1/R4/R6 survive without a model" and "no criterion reaches level 2 on surface features alone". It is also the anti-gaming mechanism: writing to the detector tops out rather than paying off.
2. **`temperature: 0` was specced and is not available** — sampling parameters return a 400 on Claude Opus 5 and Sonnet 5. Reproducibility instead comes from per-attempt immutability: an artifact is scored once and resubmission is rejected, so a learner cannot see two numbers for one text.
3. **An unscored criterion is not a zero.** Without a judge, R2/R3/R5 leave both numerator and denominator (`6/6, 3 of 6 criteria`), and **mastery stays unreachable** rather than being redefined down to what happens to be measurable.
4. **Persian repair drills are authored, not translated.** The English R4/R6 drills turn on bare demonstratives and Latinate nominalisation; the Persian ones exercise unanchored اشاره, ezāfe chains and اسم‌مصدر. Translating them would have produced items whose seeded fault did not survive the translation.

*Current state:* nothing is calibrated, so every judge criterion is feedback-only and clarity probes cannot yet produce a measurement-grade total. Reported by the API rather than scored around. 250 API tests green.

### D-15 · Skill sittings can be scheduled into the calendar; steps cannot — 2026-07-26
Migration `20260726182944_add_skill_calendar_planning`: `ActionSourceType` gains `skill`, `SkillProfile` gains `calendarPlanningEnabled` + `planTimeOfDay`. Opt-in and off by default. Planned sittings are ordinary scheduled actions with `isGathered: false`, so the daily-cycle branching (which only walks gathered actions) never sees them — no risk to Pre-day/After-day.

*Two judgement calls worth keeping:* **(1) Two sittings per module is the default**, because mastery requires at-criterion attempts on two distinct calendar days — a one-sitting plan would look complete and never produce mastery. **(2) Individual steps are not schedulable.** A module is designed as one sitting and steps 3–6 are a single learning loop; splitting them across days breaks the loop and would put 42 entries in the calendar for a tool whose sessions run five minutes. Clarity Lab's revision step is the one case where a gap helps, and that is a P1 Clarity-only option.

*Alignment:* this is **D-3**-consistent rather than an exception to it — a scheduled sitting is a future commitment, not a streak; nothing breaks when one is missed. Spaced review is deliberately not an `Interval`: intervals repeat on a fixed cadence, review intervals expand and depend on outcome.

### D-14 · Evidence Lab P0 built; skill content lives in the API — 2026-07-26
Migration `20260726171708_add_skill_tools` (SkillProfile, SkillModuleProgress, SkillAttempt, SkillProbe, SkillCheckEvent + four enums). Three corrections to the spec, all found by building it:

1. **Content moved from the client to the API** (`api/src/content/skills/`). The spec sketched it under `client/`; that would have shipped every answer key in the browser bundle. The client gets a `PublicEvidenceItem` projection and there is no GraphQL field that can return a key.
2. **An attempt row is created when the item is served, not at submission.** Check events are then timestamped server-side. The ordering of *check* versus *verdict* is the primary outcome measure, so it must not be a number the client reports afterwards.
3. **Probe readiness is a hard gate, snapshots are separate from keys.** Practice runs today on live search in a new tab; a scored baseline is refused until a human has verified each item's answer key and frozen its search results. The seed pack ships `keyVerifiedAt: null` deliberately — an unverified key in a measurement instrument fails silently, so the gate says so out loud.

*Rationale for build order:* Evidence Lab needs no LLM at all (behavioural scoring against authored keys), so it ships first and proves the engine before the judge exists. 174 API tests / 141 frontend tests green; en + fa at key parity (72 keys).

### D-13 · Skill tools are specs first; `../canon/06-specs/` added to the canon — 2026-07-26
Two skill-training tools (**Clarity Lab**, **Evidence Lab**) were specified before any code, in a new `../canon/06-specs/` folder graded **spec** rather than as-built. *Rationale:* they are measurement instruments as much as features — a rubric and a scored probe whose validity depends on being fixed before data is collected. Load-bearing sub-decisions: content is **authored and repo-versioned**, never runtime-generated (a generated item can't support pre/post comparison); scoring is **server-side only** (answer keys must not reach the client); mastery is **rule-based, not BKT** (item volume is two orders of magnitude too small); **Evidence Lab ships first** because it needs no LLM at all; and **no streaks** — the review queue is the only recurring pressure, per **D-3**. Settled same day: **external LLM access approved** (Tracker's first outbound dependency — Anthropic API, server-side only, per-tool consent, genuine no-AI fallback); **Persian content is a launch requirement, not a phase-2 gap** — made affordable by a locale-invariant item spec with per-locale surfaces, a CI parity validator, Batch-API drafting with native review, English corroborating sources permitted for Persian evidence items, and Persian linguistic work scoped to two of six clarity rubric criteria; **assessment sideways-checks run on frozen pre-fetched result snapshots shipped in the content pack** — zero search calls and, more importantly, an identical evidence surface for every learner, which is a better instrument than live search. A native Persian reviewer was then secured at negligible cost, which **withdrew the tiered-review compromise** (full review on every item in both locales) and — more importantly — made the **`fa` judge calibration gate achievable**, so Persian scores are measurement-grade rather than feedback-only. Without a native rater, Persian learners would have received prose feedback and no comparable scores: a two-tier product wearing a bilingual label. See `../canon/06-specs/00-skills-engine.md` §5.1, §7, §16.

### D-12 · Bug-fix + e2e pass — 2026-07-16
Fixed B-1 (delete confirmation), B-2 (toggle sync), B-3 (add-action button); stood up Playwright e2e with a two-user (owner + discoverable "friend") global setup. *Rationale:* stabilize the core before the Root refactor; make the journey testable end-to-end.

### D-11 · Journals = Journey seeded inside Tracker — 2026-06-13
Journals are linkable to a goal/project, have a per-user default, and are **shared by email** gated by an **opt-in `discoverableByEmail`** flag (off by default). *Rationale:* begin *Journey/ماجرا* inside the working app rather than as a separate build; email-sharing with opt-in discovery is the privacy-preserving default. *Set aside:* open/directory-wide discovery (rejected — privacy).

### D-10 · Onboarding is DB-persisted; module intros keyed by `moduleKey` — 2026-06-13
`OnboardingProgress` tracks the last slide (resumes across logins, never goes backward); `ModuleIntroViewed` is unique per `(userId, moduleKey)`. Closing the slideshow via X is session-only; finishing sets `completedAt`. *Rationale:* guidance that survives sessions without nagging.

### D-9 · Notes are one polymorphic field, not a timestamped history — 2026-06-13
A single `Note` model keyed by `entityType` + `entityId`, body text, for MVP. *Rationale:* keep it simple; a richer note history can come later. *Set aside:* per-entity note tables; note threads.

### D-8 · The Clarity Check is non-gating, five dimensions — 2026-06-12
Observability, Control, Binary Clarity, Ownership, Decomposability; result is a soft **green/amber** with flagged dimensions, never a block. *Rationale:* Root's *questions over answers* — help the person see their DoD clearly without authoring it for them or gatekeeping. The same object models the engine's stage-gates in Root canon `../../ecosystem/canon/03-engine/`.

### D-7 · Wizards save immediately on completion (edit contexts) — standing UX preference
Re-running a wizard on a saved entity writes on completion, no separate save step; create-flows accumulate locally until the main submit. *Rationale:* user preference, confirmed when designing the Clarity Check re-run from Manage Goal.

### D-6 · Gathered actions reuse the `Action` model ("Option A") — 2026-02
Rather than a separate entity, gathering writes `Action` rows with `isGathered`, `sourceType`, `sourceId`, `forDate`. *Rationale:* one action pipeline (Today, fates, disposition) serves both user-created and recurring work. *Trade-off:* the `sourceId` link is loose (by id, not an FK).

### D-5 · The daily cycle is gated by DayState — 2026-02-19
Enforced order: After-day (yesterday) → Pre-day (today) → Today → After-day (today). *Rationale:* the ritual is the product — it guarantees nothing scheduled is silently dropped.

### D-4 · Scope exclusivity — 2026-02
Project links a goal **xor** a milestone; an Interval links at most one of goal/milestone/project; a Routine links nothing. Enforced in resolver/DB. *Rationale:* a clean single-parent tree; routines are explicitly user-level.

### D-3 · No streaks — habits removed — 2026-02-17
The streak-style habits model was deleted and recurrence rebuilt as Intervals/Routines. *Rationale:* Root refuses engagement mechanics; recurrence is a *future commitment*, tracked in Organize, not a streak to defend. This is the load-bearing philosophy decision in the codebase.

### D-2 · P/S/O/B priority — 2026-02
Eisenhower urgency × importance, with names that suggest disposition (O→outsource, B→bucket list). *Rationale:* a compact, actionable priority vocabulary.

### D-1 · GraphQL-only contract; SQLite with JSON-string arrays — 2025-04 onward
Frontend talks to the backend exclusively over GraphQL (via `useApi` + `queries.ts`); list fields are stored as JSON strings in SQLite and parsed in `typeResolvers.ts`. *Rationale:* one contract, one client seam; SQLite simplicity for a personal app, with Postgres available by datasource swap.

## 3. Standing constraints (not dated — always true)

- **Persian-first.** Every user string exists in `en` and `fa`; Persian is a brand non-negotiable.
- **Web-first PWA; no native apps** (post-MVP distribution decision).
- **`requireAuth` + `ensureOwned` on every resolver** — the whole authorization model.
- **Backend integration tests preferred; frontend `useApi` mocks are temporary.**

---

## Changelog

- **0.1 · 2026-07-22** — Initial log. Timeline from the migration history; decisions reconstructed from the base docs, session history (2026-06-12 build, 2026-07-16 fixes), and memories.
