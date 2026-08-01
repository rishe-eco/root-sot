# Tracker — Decision Log

*Append-only, living. How we got here and what we set aside. New decisions go at the top of §2; don't rewrite history — supersede it. Update the changelog; don't fork.*

**Version 0.2 · Status: living · 2026-08-01 · Owner: _root**

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

### D-20 · Persian is informal (تو/کن) app-wide, and conveys the concept rather than the words — 2026-08-01
The `fa` locale was formal (شما/کنید) everywhere except the Skills labs, which were authored informal. Founder's call: take the whole app informal to match the labs, not the labs formal to match the app. *Rationale:* a register split is more jarring in Persian than in English, and `concepts.priority` was already switching between the two inside one screen. The translation standard is stated as **"the Persian conveys the concept and meaning of the original English, not its exact translation"** — calques are the failure mode, not wrong words. Also fixed one word per concept where three were in use (Action was کار/اقدام/وظیفه → **کار**; backlog → **فهرست انتظار**; bucket list → **لیست آرزوها**; the Pass fate → **منتفی**). See `../canon/02-architecture/04-conventions.md` §7 for the glossary and the grammar trap. *Not covered:* the Evidence/Clarity item packs (`api/src/content/skills/*/surface.fa.ts`) — several items' faults exist only in English, so a fluency pass would change what they measure. Still `team/open-work.md` item 2.

### D-19 · Clarity's forcing functions are check events; a revision is a row — 2026-08-01
Phase 2 built: `claritySession.ts`, GraphQL surface, 17 integration tests. Two structural choices, both of which avoided a migration and are better than the thing they replaced:

1. **The prediction and diagnosis locks are `SkillCheckEvent` rows.** That model was built for Evidence Lab because "the ordering of check versus verdict *is* the measurement"; Clarity's locks are the same claim about a different sequence, so they use the same mechanism — payload carries the prediction text or the tag list, offset is stamped server-side. Submitting a revision or elicitation item without a committed diagnosis is rejected, because a diagnosis entered after the levels is a recollection.
2. **A revision is a new attempt row linked by `revisionOfAttemptId`, never an edit.** The delta then compares two scored artifacts rather than diffing one mutable field — and the mastery rule falls out of the data instead of needing a flag: `unscaffolded` is `revisionOfAttemptId == null`. A revision follows feedback that named exactly what failed, so counting it would measure the feedback.

*Two smaller calls:* **Clarity got its own GraphQL types** rather than widening Evidence's — the tools measure different things and a shared type would make every field on both sides nullable. And **elicitation items are withheld when no reader is configured**: serving one that dead-ends at the reveal is worse than serving fewer, so the candidate filter drops them and progress reports `readerAvailable: false`.

*Also generalised:* `ensureProfile` now takes a `skillKey`, and the **content-version upgrade rule is Evidence-only** — it exists because v1 was superseded for audience reasons (**D-17**), and Clarity has one version with nothing to move off.

### D-18 · Clarity Lab ships offline-first; item type decides the dependency — 2026-08-01
Wireframes reviewed and three questions settled: **offline path first**, **ship visible-but-uncalibrated**, **three practice items per module**. Build plan in `canon/06-specs/01a-clarity-lab-build-plan.md`. Phase 1 (content) done: 17 new pool items, `en` + `fa`, plus a Clarity content validator.

The phasing is possible because **Clarity's dependency on a model is a property of the item type, not of the tool**. Revision items ship the reader's misread in the pack, so the gap reveal is a playback rather than a generation; repair drills are detector-scored. Only elicitation needs a live model — twice over, since the reader must respond to *the learner's own text* and R3 has no detector. So the offline build is not a degraded preview: it is revision and repair complete, including the diagnose step, diagnosis accuracy, the gap reveal, the revision chain and the delta. What it cannot do is elicitation, which is the scored core of the probe — the offline tool **trains but does not measure**.

Three rules the content phase added, each of which would otherwise fail silently:

1. **The pool floor counts *offline-capable* items, not items.** A module whose pool is all elicitation looks fully stocked on the modules page and is empty on an install with no credential. `pool-not-offline` is now a validator error alongside `pool-too-small` — the generalisation of **D-17**'s lesson, one level up.
2. **A repair drill must be provably satisfiable.** Each ships an `exemplarFix` that never reaches the client; the validator asserts the weak text fails its own criterion under the detector and the fix clears it. Without that a drill can teach something the rubric then marks wrong, and nothing anywhere notices. English only — `fa` routes R4/R6 to the judge, so there is no detector to check against and no honest check to make.
3. **An item must seed its own module's criterion.** Diagnosis accuracy is scored against `seededFaults`, so an item filed under `c4` that fails only R1 mis-scores the module it sits in.

*Distribution:* `c1`/`c2`/`c3`/`c5` get revision items and `c4`/`c6` get repair drills, per spec §5 — repair only fits the two criteria a detector can see. Four modules of revision items is on-message rather than a compromise; revision is the tool's declared centre of gravity. Items were authored general-audience (venues, tenancy agreements, a gas oven, a garage) following **D-17** — the earlier Clarity items skew software, and R5 in particular is not a workplace skill.

*Credential:* one variable, `ANTHROPIC_API_KEY`, read only by the API, and **the issuing account is irrelevant** — nothing is tied to an identity or workspace. Needed for Phase 4 only. The build plan §4.2 records the part most likely to be under-scoped: the **reader is a second call and is not the judge**, must carry no system prompt telling it to be charitable, and its model tier is a pedagogical parameter rather than a cost one — too capable a reader recovers from vagueness and there is no gap left to show.

### D-17 · Evidence content is general-audience; `evidence/v2` supersedes v1 — 2026-08-01
v1's items were all software claims (RFC numbers, SQLite features, npm defaults) — deliberate, because triage judgement (`e1-stop`) only trains where the learner can feel the stakes, and the first learner was a developer. It does not survive a wider audience: a reader who does not know what an RFC *is* cannot practise deciding whether this one is load-bearing, so the item stops measuring evidence skill and starts measuring domain familiarity. v2 re-authors all of it around claims that need no background to feel and no specialist access to check — history, language, everyday science, health guidance, records and counts — while keeping the hard constraint that every claim resolves by ordinary search in under a minute. 42 items (form A of 6 plus 36 pool), `en` + `fa`.

Three things this forced, all of which outlive the content:

1. **A module with fewer practice items than the mastery window can never be mastered.** v1 shipped **two** pool items in total: four of six modules opened onto an empty page, and no module could reach the bar however well anyone performed. Mastery needs 5 at-criterion attempts inside a 6-attempt window, so the floor is six items per module — now a validator error (`pool-too-small`), not something a learner discovers. The pool also carries the same ≥⅓ control ratio as a scored form, because mastery requires *zero* false alarms and a pool with no true claims makes that clause untestable as well as the training misleading.
2. **The version pin is about the baseline, not about content age.** A learner with no baseline has no pre/post comparison for a content change to invalidate, so `ensureProfile` moves them to the current version; anyone with a baseline stays put. Past attempts are unaffected either way — `SkillAttempt.contentVersion` is per row, so an old attempt still resolves its item after the profile moves. v1 stays registered and buildable, and a test asserts every retired version still builds in both locales.
3. **The profile→verdict and profile→fault tables belong to the taxonomy, not to a version.** Scoring imported them from `evidence/v1/spec`, so a second version would have been keyed against its own table and scored against v1's — wrong scores, no error. They now live in `content/skills/types.ts`, with a test asserting each version's local copy still agrees.

*Also settled here (interface, not content):* the drill separates **the question asked** from **the AI's answer** structurally — two boxes, two labels, two icons — because a learner who cannot tell which half is the claim cannot evaluate the claim; and authored markdown is rendered rather than printed, since literal asterisks are a tell that has nothing to do with the claim. The intro grew from 3 slides to 6 and starts from *what this tool is* rather than from a rule about it, and the mechanics moved to a re-openable panel on the page — a one-shot overlay is the wrong home for something wanted on the third item, not the first. Metrics are hidden until the first attempt: eight zeroed statistics are not a dashboard.

*Unchanged:* every key still ships `keyVerifiedAt: null` and every snapshot `pending`, so the scored baseline stays blocked — 12 blockers, being the 6 form-A items × 2 gates. Practice works today. 253 API tests / 147 frontend tests green.

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

- **Persian-first.** Every user string exists in `en` and `fa`; Persian is a brand non-negotiable. Informal register (تو/کن), and the Persian conveys the concept rather than the literal English — see `../canon/02-architecture/04-conventions.md` §7.
- **Web-first PWA; no native apps** (post-MVP distribution decision).
- **`requireAuth` + `ensureOwned` on every resolver** — the whole authorization model.
- **Backend integration tests preferred; frontend `useApi` mocks are temporary.**

---

## Changelog

- **0.2 · 2026-08-01** — D-17 → D-20 added: Evidence `evidence/v2`, Clarity's offline-first phasing and forcing functions, and the Persian register/glossary standard.
- **0.1 · 2026-07-22** — Initial log. Timeline from the migration history; decisions reconstructed from the base docs, session history (2026-06-12 build, 2026-07-16 fixes), and memories.
