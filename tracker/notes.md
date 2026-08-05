# Tracker — R&D Notes

*The R&D log: what is being tested for graduation into the product. Designed-but-unbuilt work lives in `canon/06-specs/`; this file tracks its status, what each piece is for, and what has to be true before it ships. Update the changelog; don't fork.*

**Version 1.1 · Status: living · 2026-08-03 · Owner: _root**

---

## What "graduation" means here

A spec graduates when it ships. At that point its as-built reality moves into `canon/01-product/` and `canon/02-architecture/`, and the spec file is **marked superseded rather than deleted**. Everything on this page is graded **spec** throughout — none of it is verified against code, because none of it exists yet.

This file is the index and the status board. The specs themselves are the detail.

## In R&D now — the Skills Engine and its two tools

Three specs written **2026-07-26**, all v0.1, all status `spec`. They form one system: an engine plus two content-and-scoring packs.

| Spec | What it is | Status |
|---|---|---|
| `canon/06-specs/00-skills-engine.md` | Shared machinery: initial assessment (doubling as baseline measurement), sequenced modules on a fixed seven-step template, per-item feedback, error diagnosis, open practice, spaced review queue, progress tracking, delayed retention probe, data export. | spec |
| `canon/06-specs/01-clarity-lab.md` | Skill tool #1 — **clarity of expression**. Trained slowly, by revision. | spec |
| `canon/06-specs/02-evidence-lab.md` | Skill tool #2 — **evidence-seeking**. Trained fast, as a drilled reflex. | spec |

### The asymmetry that is the whole design risk

The two tools deliberately do **not** share pedagogy. From the engine spec:

| | Clarity Lab | Evidence Lab |
|---|---|---|
| Session shape | few, long (8–20 min), one artifact | many, short (2–4 min), 3 items |
| Unit of work | a written artifact the learner revises | a claim the learner checks |
| What's scored | the **product**, by analytic rubric | the **behavior**, by instrumentation |
| Progression | revision delta over drafts | reflex rate and latency |
| Failure mode to design against | "checkbox clarity" written to the rubric | blanket distrust instead of discrimination |

> **The stated risk, worth repeating because it is the thing to watch:** an engine that treats these as two skins on one quiz component will produce a working Clarity Lab and a **useless** Evidence Lab.

### What each tool is actually training

- **Clarity Lab.** Lineage is Grice's maxims (used as *diagnostic vocabulary for why an attempt failed*, never as commandments), Pinker on why human indirectness doesn't apply to a machine, and Williams/Turabian on subjects-as-characters and verbs-as-actions. Core loop: *write it → see what the reader actually received → diagnose the gap → revise → see the difference.* The central mechanic is the **gap reveal** — the learner predicts what the reader will produce, then sees the actual output; the distance is the lesson. Six modules, 1:1 with rubric criteria.
- **Evidence Lab.** Lineage is Wineburg & McGrew on **lateral reading** (fact-checkers were faster *and* more accurate because they left the page immediately), Caulfield's **SIFT**, and epistemic vigilance — over-trust was the single biggest predictor of a bad outcome across studies. Two non-negotiables: it trains a **reflex, not an audit** (items are timed; a 40-second correct check beats a 6-minute one), and the goal is **discrimination, not distrust** (every form contains true, well-sourced control claims; the headline metric is hit rate *minus* false-alarm rate). A tool that never lets the AI be right teaches distrust and calls it vigilance.

### Constraints these specs inherit

Stated in the specs, and each is a live temptation worth re-checking at build time:

- **No streaks, badges, or leaderboards.** Streak-style habits were deliberately removed from Tracker (`decisions/decision-log.md`; `components/habits/` is intentionally empty). The review queue — "3 modules due" — is the only recurring pressure permitted. Reintroducing streaks here contradicts a standing product decision.
- **Not a prompt-tips library.** The founding finding is that tricks perish and skills compound. No "10 magic phrases" surface, no model-specific technique content.
- **Not a chat playground.** The learner never free-chats with a model inside the Lab; every AI turn is a scored or scaffolded step.
- **Not gated onto anything.** Consistent with the Clarity Check, these tools never block another Tracker flow.
- **No proctoring.** Single-user self-development; item leakage is handled by parallel forms, not surveillance.

### Related code already on disk

The `tracker` repo carries **committed** early work matching these specs (in the single `init` commit; working tree clean) — and it is **broader than clarity**: `api/src/content/skills/` (both `clarity/v1` and `evidence/v1`, `en`+`fa`), the shared `api/src/services/skills/` (`evidenceSession`, `mastery`, `planning`, `profile`, `scheduler`, `scoring`) plus `services/skills/clarity/`, unit tests (`clarityDetectors`, `clarityJudge`, `clarityScoring`, `skillScoring`) and a `skills.integration` test, and early client pages (`EvidenceDrillPage`, `EvidenceLabPage`, `SkillPlanPanel`). That work is ahead of this log: the specs are still v0.1 `spec`, but code exists. **Reconcile before trusting either** — if the code has settled decisions the spec doesn't record, the spec is wrong and should be updated.

## In R&D now — Feelings & Needs (Learn Module 1)

**Build started 2026-08-02.** The first **Learn**-pillar surface in Tracker (the Skills Engine is the sibling Learn family). Plan, wireframes and mechanisms are in the ecosystem repo (`../ecosystem/working/learn-build/`, `../ecosystem/working/learn-mechanisms/`); this is the R&D status board for the code.

Built as a Tracker tool that **reuses the skills-engine content discipline** (authored, versioned content in the repo; locale-invariant **spec** + per-locale **surface**), but is **LLM-free** — the distinction catch runs on an authored faux-feelings lexicon, not a model. English-only demo; Persian deferred (the split is what keeps it cheap later). Guardrails are structural: nothing counts or streaks, loop passes are parallel and never related (tier-4 storytelling is deferred), graduation is a one-time door. See **D-21**.

Phasing (from plan §9, M0–M6):

| Phase | Milestone | Status |
|---|---|---|
| **1** | **Scaffold** — data model (`add_feelings_needs`), content module (spec/surface + dials), `feelingsNeedsState` query, navigable tool home | **done 2026-08-02** |
| **2** | **Content** — English palettes, Day-1 frame script, catch copy, faux-feelings lexicon, loop microcopy | **done 2026-08-02** |
| **3** | **The spine** — the daily loop + optional repeat + sitting recap, persisted | **done 2026-08-02** |
| **4** | **Day-1 frame** — the felt-not-told onboarding, and the gate it opens | **done 2026-08-02** |
| **5** | **Distinction catch** — lexicon-based, in-context | **done 2026-08-02** |
| **6** | **Self-initiation** — prompt-fade + one-time capability moment | **done 2026-08-02** |
| **7** | **Polish + team feel-test** — guardrail audit, presentation pass, seeded review accounts | **done 2026-08-03** |

Tier 4 (storytelling) is **out of scope** for this build — tied to Reflect's existence, deferred.

**The demo is built.** Every surface a person touches works; tiers 1–3 are live end to end. What it is *not* is validated — see "the honesty line" below.

### Running the feel-test

`npm run seed:fn` in `api/` creates six accounts, one per state worth feeling, each printed with what to look at. Password `change-me-please`; start at `/tools/learn/feelings-needs`.

| Account | State | What it is for |
|---|---|---|
| `fn-fresh` | nothing done | the frame is the only way in; the loop is genuinely locked |
| `fn-new` | frame done | full scaffolding, pleasant/met-need palette only |
| `fn-settled` | 5 sittings | helpers withdrawn, palette broadened — note that nothing announced either |
| `fn-catching` | 10 sittings | type "ignored" at the escape to meet the catch |
| `fn-faded` | 10 sittings | terse prompts throughout |
| `fn-door` | one short | finish a loop to meet the capability moment |

The states are ordinary rows, not special cases — the point is you cannot judge this module from its first screen, and nobody will run fifteen sittings to reach the interesting parts.

**What the feel-test is for, and what it cannot answer.** It asks whether the thing *feels* like the pillar — short, body-first, in your own words, always moving toward a need, teaching by gentle catch rather than quiz (`learn.md` §6). It cannot answer whether any of it works. That is the discovery's job, and per the honesty line this build is deliberately made to the *provisional* definition-of-done. **This artifact is what the Phase-3 test will later be run on.**

### Code on disk (Phases 1–7)
`api/prisma/schema.prisma` (FrameCompletion, LoopSitting, LoopEntry, LoopState) · `api/src/content/feelings-needs/` (types, dials, `v1/` spec+surface, registry) · `api/src/services/feelingsNeeds/state.ts` · `feelingsNeedsState` query in the GraphQL surface · client `components/learn/` (`FeelingsNeedsPage`, `FeelingsNeedsFramePage`, `FeelingsNeedsLoopPage` — the Phase-1 `ComingNext` placeholder is retired, both routes are real), routes in `protectedRoutes.tsx`, `toolsHome`/`learn` i18n keys in `en`+`fa`.

**Content as authored (Phase 2, `feelings-needs/v1`):** 12 body textures · 20 feeling words (8 `early` pleasant/met-need, 12 `broaden`) · 12 needs · a four-beat Day-1 frame script · full loop microcopy incl. sitting recap and the one-time graduation line · **39 faux-feeling concepts in 5 families** (excluded, diminished, betrayed, pressured, threatened) across 82 trigger strings, each with the feeling and need hints underneath · generic + per-family catch templates.

**Phase 3 added** (migration `add_loop_sitting_completed_at`): `services/feelingsNeeds/session.ts` (content + display selection, sitting/pass lifecycle), the loop GraphQL surface (`feelingsNeedsContent`, `activeLoopSitting`; `startLoopSitting`, `setLoopBreath`, `updateLoopEntry`, `addLoopPass`, `finishLoopSitting`), and client `FeelingsNeedsLoopPage.tsx`.

Three guardrails are enforced **server-side**, not in the UI, because a guardrail the client owns is one refactor from gone: the soft cap refuses a fourth pass; a finished sitting rejects further writes; and nothing in the service reads one pass while writing another. Verified end to end in the browser — breath → notice → name (incl. the "other → type it" escape) → need (incl. skip) → small step → close → repeat → recap, all committing per step, plus ownership isolation across two accounts.

**Two bugs found and fixed during that verification, both worth remembering.** `startLoopSitting` had a check-then-create race with no unique constraint to arbitrate it — a double-invoked mount effect created a second, empty sitting every time. Fixed with a transaction server-side *and* a mount guard client-side. That empty sitting also revealed the second issue: `sittingCount` counted *all* sittings, so an abandoned one would broaden the palette before the person had their early wins (P1) and would later read as practice to the prompt-fade inference (P7). It now counts **completed sittings only**.

**Phase 4 added** (migration `drop_loopstate_frame_done`): `FeelingsNeedsFramePage.tsx`, the `completeFeelingsNeedsFrame` mutation, and the gate. The frame is a four-beat script — recall a *mild* off-moment → locate it in the body → try a word on → payoff — and the payoff hands the person their own two words back before reporting what happened. It never states the lesson: no slogan, no praise, no explanation of the mechanism afterwards, because a belief that is asserted is a poster and a belief that is felt is a belief. Nothing is persisted but the fact of completion — the texture and word are the experience, not an entry.

**The gate is server-side.** `startLoopSitting` refuses without a `FrameCompletion`, for the same reason the soft cap is enforced there: it should survive a client that forgets it. The gate is about sequence, not permission — running the loop first would spend the person's first reps on a practice whose point hasn't landed.

**Resolved here rather than carried:** `LoopState.frameDone` mirrored the `FrameCompletion` table. Phase 4 was the code that would have had to keep both in sync, so the mirror was **dropped** before anything ever wrote it — the row already carries the fact *and* its timestamp, and two rows that must agree about one event are a desync waiting for the first code path that forgets one. `frameDone` is now derived.

**Phase 5 added:** `services/feelingsNeeds/distinctions.ts` (the matcher and the distribution gates), the catch wired into `updateLoopEntry` — which now returns `FnLoopResult { sitting, catch }` — and a catch beat in the loop wizard between naming and the need.

The whole detector is the authored trigger list; there is still no inference dependency anywhere in the module. Three things are enforced rather than hoped for. It **stays silent until the loop is established** (`minLoopsBeforeCatch`) — B is a refinement on top of A, never the opening move. It **spaces the touches out** (`catchCooldownPasses`) — someone who habitually reaches for "ignored" would otherwise meet the same card daily, which is the drill this is defined against. And it **never blocks**: `dismiss` keeps the person's own word and carries on, because a catch you cannot decline is a quiz, and a quiz produces defensiveness instead of looking.

**`feelingSource`/`needSource` gained a third value, `catch`.** P5's observable signal is that the person catches *some of their own* faux-feelings, so a word that arrived through the catch has to stay distinguishable from one they reached for unaided — otherwise the only evidence the mechanism worked is indistinguishable from evidence it was never needed. Verified in the browser: a pass recorded `feeling: "taken for granted" (own) → need: "to matter" (catch)`, and the next pass — "dismissed", also in the lexicon — correctly did not fire.

**Phase 6 added** (migration `drop_loopstate_prompt_fade_level`): the fade is computed from completed sittings and applied **server-side** in `getContent`, so the client never implements the withdrawal — a client that decided when to stop explaining would be a second, silent copy of the dial. Level 1 stops sending the helper lines; level 2 switches to authored **terse prompts** ("where, and what texture?"). The terse need prompt keeps its *if*, because the conditional is the guardrail, not scaffolding to withdraw. Nothing announces any of it; the app simply says less.

The **capability door** fires on the run that earns it, is **acknowledged explicitly** (`acknowledgeGraduation`) so closing the tab cannot silently spend the only time it is offered, and never returns. Verified in the browser at fade level 2 and through the door.

**`LoopState` is now down to `contentVersion` and `graduationSurfaced`.** `frameDone` went in Phase 4 and `promptFadeLevel` here, both for the same reason: the authoritative record already exists elsewhere (a FrameCompletion row; the completed sittings), and a cached value beside it is a value that can disagree with it. What remains is the one fact with no other record — that the door has been walked through. Worth stating as a rule: **on this model, prefer deriving from the event over storing a summary of it.**

The **honest limit**, recorded rather than designed around: with no cue mechanism in the demo — no notifications, nothing that nudges — the other half of P7 is unobservable. The loop firing from a *life* context rather than the app cannot be seen from here. The mechanism doc licenses exactly this ("accept partial unobservability"); forcing it to be observable is what would manufacture the streak.

**After the demo — first review pass (2026-08-03).** Four notes from looking at the built thing; all four done.

**The body step asked one question and answered another.** The frame read "Where does it sit in your body?" over chips saying *heavy, tight, hollow, knotted*. Each half was fine; together they were a non-sequitur, met at the exact moment the person is first asked to attend inward. Now two beats — **where**, then **what it's like there** — which is also closer to P2's actual move ("attend to where / what texture"). Needed a body-location palette, `LoopEntry.bodyLocation` (`add_loop_entry_body_location`), and the split applied to both the frame and the loop. The new content test asserts each beat draws from *its own* palette, so this cannot come back.

Two things that fell out of it. `hard_to_place` is in the location palette because P2's third failure mode is going blank at "where do you feel it" and the mechanism requires that be **information, not failure** — and it needed pinning explicitly, because taking the first N of the pool silently dropped it off the end of the loop's chips, leaving the one person who most needed an answer without one. And the schema now has a **build test** (`schema.unit.test.ts`): `typeDefs` is a template literal, so a half-renamed type compiles perfectly and only fails at `new ApolloServer(...)` — which surfaces as a server that won't boot rather than as anything pointing at the schema. It caught exactly that twice during this change.

**Entry history** — `loopHistory`, and a page grouped by day, newest first. A record and deliberately nothing more: plan §2 puts pattern-recognition across entries out of scope and "no streaks" rules out totals, so there are no counts, no gaps marked, and nothing derived. A test asserts the rows carry no aggregate, because a scoreboard would arrive by exactly that back door. Days are grouped client-side since a day is a local-timezone concept. One bug worth remembering: a Prisma `Date` on a GraphQL `String` field serializes as **epoch milliseconds**, and `new Date("1785738600000")` is an Invalid Date — everything type-checked and the page rendered a column of "Invalid Date" until `typeResolvers` converted it, which is the convention the rest of that file already followed.

**Two expansions recorded, not built** — alternative breathing patterns, and a valence/arousal feeling axis (the *How We Feel* / Mood Meter shape) as progressive disclosure rather than a word wall. Both are in the demo plan's new §12 with the guardrail each would have to survive.

*Unrelated, found by the suite:* the Skills calendar-planner test hardcoded `startDate: "2026-08-03"`, which stopped working the day that date arrived — `clearFuturePlan` only removes future sittings, so once the clock passed the first 09:00 slot the re-plan test found 11 to remove instead of 12, and from the next day all of them would be in the past. Made relative to today.

**Phase 7 added:** `feelingsNeedsGuardrails.unit.test.ts` and `src/scripts/seedFeelingsNeeds.ts` (`npm run seed:fn`).

**Plan §10's guardrails are now executable.** They are the one part of this build most easily lost by accident — every one is a property of *copy*, and copy gets edited by people thinking about how a sentence reads rather than which mechanism it was protecting. So all eight are tests: no prompt asks *why*; the palette stays small on screen; the catch always offers a decline and phrases every hint as a question; the need stays conditional **in both the full and the withdrawn prompt**; no streak or scoring language anywhere; the frame's payoff never states the lesson it exists to produce; the recap declines to relate the passes; the breath promises no duration. Mutation-checked by planting four violations at once and confirming four failures. One test caught its own over-broad rule first — the need prompt says "if it **points** at something you care about", which is the verb, not gamification points.

**Presentation.** Dark mode flips correctly (the components use semantic tokens throughout) and nothing overflows at 375px — the chips wrap rather than scroll. One real fix: the quiet controls were rendering as bare 16px-tall text, which is genuinely hard to hit on a phone. That matters more here than it would elsewhere, because **"offer, never force" is only true if the skip is reachable, and the catch is only a catch rather than a quiz if you can actually decline it** — so those two guardrails were resting on an untappable target. All quiet controls now route through a shared `QuietAction` with a 44px touch target and unchanged appearance. The primary buttons (36px) and chips (34px) are the app's own sizing and clear WCAG AA; diverging for one tool would be the inconsistency, not the fix. The breath animation's reduced-motion guard was verified against the live rule rather than the source.

**Test pass (after Phase 4).** Two suites, 64 tests: `feelingsNeedsContent.unit.test.ts` (content invariants — spec/surface parity, lexicon slot counts, family coverage, template placeholders, frame id references, dials vs pools, trigger collisions, the client-safe projection, the `fa` refusal) and `feelingsNeeds.integration.test.ts` (the frame gate and idempotency, per-step commits, the repeat and its cap, ownership isolation, resumability, counting, the tier transition). Both include regression cover for the two Phase-3 bugs. Each was mutation-checked — the content and the service were deliberately broken to confirm the tests actually fail. Full suite: **343 passing, no regressions.**

**The concurrency test changed the fix it was written to protect.** Phase 3 closed the start-sitting race with an interactive transaction; the 5-way concurrency test timed out against it. The cause is structural, not tuning: **Prisma holds SQLite's single connection for the life of an interactive transaction**, so concurrent callers cannot even begin one — raising `maxWait` does nothing. `startSitting` now *converges* instead of locking: everyone inserts, then everyone independently agrees on the same winner (the oldest open sitting, deterministic ordering) and `deleteMany`s the blank duplicates, which is idempotent and needs no coordination. Content-bearing duplicates are never discarded. Worth remembering for any other check-then-create on this stack.

Two content decisions worth carrying forward. **Pool size ≠ display size:** the "keep the palette small" guardrail governs what is *on screen* (a wall of words becomes a menu), not what the pack knows — a pool too small to name anger or shame would teach that the app only wants mild things (P1 failure mode b). Display counts are dials (`textureDisplayCount` etc.); pool sizes are asserted against the authored content. **The matcher has a contract:** detection runs on the *feeling field only* (chosen word or the "other → type it" escape), case-insensitive, on word boundaries, longest-match-wins, at most one catch per pass — several triggers are ordinary English words that are unambiguous as a named feeling but would over-fire inside prose. Recorded in `types.ts` above `LexiconConceptSurface`; binding on Phase 5.

### Open decisions carried into later phases (plan §11)
Palette-vs-free-text (building against **palette + "other → type it" escape**); exact dial values (provisional, in `dials.ts` — tune at M6); how much graduation detection to build vs. stub to prompt-fade only.

## Open questions before anything here graduates

1. ~~**Does this belong in Tracker at all?**~~ **Resolved 2026-08-01** (`../ecosystem/decisions/decision-log.md`). It belongs conceptually to **Grow (Learn)** (`../ecosystem/canon/02-pillars/learn.md` §1 — skill-training builds durable capacity on purpose). Tracker is a **staging ground**, not the Organize pillar, so hosting it here is not a scope error; code location does not determine ownership. It stays a **second Learn content family**, distinct from Module 1 (Feelings & Needs), and may later move to its own app. Open-Qs 2–3 (reliability gates) still stand.
2. **Judge reliability for Clarity Lab.** The engine names rater/judge reliability as the scoring risk. No reliability target or measurement method is specified yet.
3. **Item validity for Evidence Lab.** The stated risk is item validity rather than scoring. No item-authoring or validation process exists yet.
4. **Sequencing against the Organize refactor.** `roadmap.md` §5 is the committed work. Nothing here is on that roadmap; decide explicitly whether this runs in parallel or waits, rather than letting it drift in alongside.

## Graduated

*(none yet)*

---

## Changelog

- **1.1 · 2026-08-03** — First review pass on the built demo: split the body step into **where** then **what texture** (the question and its options disagreed; `add_loop_entry_body_location`), added **entry history** as a plain record, added a **schema build test**, and recorded two deferred expansions in the plan's §12. Fixed an unrelated date-rot failure in the Skills planner test. 418 tests passing.
- **1.0 · 2026-08-03** — Feelings & Needs **Phase 7 (polish + feel-test) done — the demo is built**. Plan §10's eight guardrails are now executable tests; presentation pass (dark mode, 375px, touch targets); `npm run seed:fn` seeds six review accounts. 400 tests passing.
- **0.9 · 2026-08-02** — Feelings & Needs **Phase 6 (self-initiation) done**: server-side prompt-fade with authored terse prompts, and the one-time capability door (acknowledged, never repeated). Dropped `LoopState.promptFadeLevel`; recorded the derive-over-store rule and P7's accepted unobservability. 381 tests passing.
- **0.8 · 2026-08-02** — Feelings & Needs **Phase 5 (distinction catch) done**: the lexicon matcher, the distribution gates, and the gentle catch in the loop. Added `catch` as a third feeling/need source so P5's observable signal is recorded. 371 tests passing.
- **0.7 · 2026-08-02** — **Test pass** for Feelings & Needs: content-invariant and frame/loop suites (64 tests, mutation-checked; 343 passing overall). Records why the Phase-3 transaction was replaced with convergence — Prisma holds SQLite's single connection for an interactive transaction, so concurrent callers cannot begin one.
- **0.6 · 2026-08-02** — Feelings & Needs **Phase 4 (Day-1 frame) done**: the felt-not-told script, the `completeFeelingsNeedsFrame` mutation, and the server-side gate that opens the loop. Dropped the `LoopState.frameDone` mirror (`drop_loopstate_frame_done`) rather than keep two rows in sync.
- **0.5 · 2026-08-02** — Feelings & Needs **Phase 3 (the spine) done**: the daily loop wizard, bounded repeat and sitting recap, persisted per step (`add_loop_sitting_completed_at`). Records the two bugs the browser verification caught (the start-sitting race; sittingCount counting abandoned sittings).
- **0.4 · 2026-08-02** — Feelings & Needs **Phase 2 (content) done**: palettes, Day-1 frame script, loop microcopy, and the 39-concept faux-feelings lexicon with per-family catch copy. Recorded the two content decisions (pool-size vs display-size; the matcher contract).
- **0.3 · 2026-08-02** — Added the **Feelings & Needs (Learn Module 1)** R&D section: build started, Phase 1 (scaffold) done, phasing board and code-on-disk index. See D-21.
- **0.2 · 2026-08-01** — Resolved open-Q #1 (the Skills Engine belongs to **Grow (Learn)**; Tracker is a staging ground — decision log, 2026-08-01). Corrected the "related code on disk" note: it is **committed** (single `init` commit) and broader than clarity — evidence content, shared services, and early client pages are present too.
- **0.1 · 2026-07-29** — Initial. Indexes the three Skills Engine specs (all 2026-07-26) at repo consolidation; records the uncommitted clarity code found in the `tracker` repo and the four open questions.
