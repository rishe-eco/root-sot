# Decomposition Lab — build plan

*The order it gets built in, the exact files, the algorithms that would otherwise be invented, and the gate at the end of each phase. Implements `03-decomposition-lab.md`; wireframes `03a-decomposition-lab-wireframes.html`. Written to be handed to a coding agent together with those two files. Update the changelog; don't fork.*

**Version 0.1 · Status: plan · 2026-08-11 · Owner: _root**

---

## 0. Read this first — orientation for whoever builds it

**Read these, in this order, before writing a line:**

1. `tracker/canon/02-architecture/04-conventions.md` — the rules that, skipped, each produce a specific class of bug. This plan cites them by number.
2. `tracker/canon/03-engineering/01-testing.md` — what earns a test here and what deliberately doesn't.
3. `tracker/canon/06-specs/00-skills-engine.md` §3 (the seven-step template), §5 (content model), §7 (scoring sources), §8 (mastery and spacing), §9 (data model), §12 (Tracker integration).
4. `tracker/canon/06-specs/03-decomposition-lab.md` — the spec this implements. §4 is the rubric; §9 lists the engine deltas.
5. `03a-decomposition-lab-wireframes.html` — open it in a browser. Ten plates plus an RTL pass; the figcaption on each frame names the criterion or rule that frame exists to protect.

**Then read this code, to copy its shape rather than invent one:**

| Read | For |
|---|---|
| `api/src/content/skills/clarity/types.ts` | the spec/surface split, and `toPublicClarityItem` — the client-safe projection |
| `api/src/content/skills/clarity/validate.ts` | the validator shape to mirror, including `isServable` / `isProbeReady` |
| `api/src/content/skills/versions.ts` | the version registry. Versions are never deleted |
| `api/src/services/skills/clarity/claritySession.ts` | serve → lock → score → revise, and how the locks are written |
| `api/src/services/skills/evidenceSession.ts` | `probeReadiness()`, and how an unverified key blocks a probe but not practice |
| `api/src/services/skills/{scheduler,mastery,profile}.ts` | the shared engine services |
| `client/app/components/skills/ClarityLabPage.tsx` | page shape, `useApi()`, i18n usage, `ModuleIntroOverlay` |

**Five facts about the existing code that this plan depends on.** Verify each before relying on it; if one has changed, stop and re-plan rather than working around it.

- `logSkillCheckEvent(attemptId, kind, payload)` already exists and delegates to `logCheckEvent(...)`, which **stamps `offsetMs` server-side**. Reuse it unchanged with new `kind` strings. Do not add an `offsetMs` argument — a client-supplied offset is a client-asserted measurement.
- `SkillCheckEvent.kind` values are **lowercase snake** (`opened_sideways`, `verdict_set`). Match that.
- `SkillAttempt` already carries `probeId` and a relation to `SkillProbe`. The probe *plumbing* exists in the schema; **nothing writes a `SkillProbe` row anywhere in the codebase** except test cleanup.
- `skillModules`, `skillProgress` and `skillPlan` take a `skillKey` argument and then call `assertEvidence(skillKey)`, which throws for anything else. They are evidence-only despite their signatures. `skillDueReviews` reads evidence modules only.
- Prisma enum values are lowercase (`SkillKey { clarity evidence }`), and so are the GraphQL enum values.

**The one thing to understand before starting.** Two existing tools split along a credential: Evidence Lab measures without a model, Clarity Lab cannot. **Decomposition Lab measures without a model, and that is the property to protect through every phase.** Four of six rubric criteria are keyed or instrumented, D1 is a detector, and only D3/D6 on *free-authored* items want a judge. If a phase ends with the probe path depending on `ANTHROPIC_API_KEY`, the phase is wrong.

## 1. What this plan settles

Decided 2026-08-11 after the wireframe review. These are not open for re-litigation during the build.

1. **Enforced level structure, not a free canvas.** Nodes live at a depth with a parent. A free canvas is more expressive and makes D2 unmeasurable — "every top-level piece before any second-level piece" needs "level" to be a real thing, not a visual impression.
2. **The live D4 badge reports absence only.** A leaf with no done condition shows a neutral `no done condition yet`. There is **no green "checkable" affirmation anywhere during authoring** — a detector can prove a feature absent, never prove that a piece ticking the box is a real unit of work. Clearing a warning cannot earn a level: D4's level 2 additionally requires not having split anything the key marks atomic, about which the badge is silent. (This is `01-clarity-lab.md` §4's detector-is-a-ceiling rule applied to a live indicator.)
3. **A node carries its own `doneWhen` field.** This is a refinement the plan adds and the wireframes do not yet show: D4 becomes "is this field present, and is what's in it bounded", rather than an attempt to infer checkability from a free-text label. It is cheaper, far more honest, and it mirrors the `dod` / `doa` fields the app already has. **Plate 5 needs a per-leaf `doneWhen` affordance when built** — revealed on focus, not a permanently visible second column.
4. **The `d5` honesty note appears on the export screen as well as in-module.** Tracker models containment and sequence and has no dependency edge; the export is where dependency information actually dies, so that is where it must be stated.
5. **The real-work export is itemised, opt-in, reversible, and never automatic.**

## 2. What "offline" means here, precisely

| Item type | Needs a model? | Why |
|---|---|---|
| **Arrangement** | **No** | Pieces are authored; every criterion resolves against the item key. D1 by detector, D2 by event order. **This is the probe instrument.** |
| **Repair** | **No** | One seeded fault, named in a fixed tag set, checked against the key. |
| **Control** | **No** | The correct response is one piece; over-decomposition is a node count. |
| **Breakdown** (free authoring) | **Only D3 and D6** | Matching the learner's own prose to required elements and overlap pairs is fuzzy string work. Degrades to self-diagnosis against a revealed key. |

So the offline build is not a degraded preview: **baseline → six modules → post → delayed probe all complete with no credential.** What a credential buys is D3/D6 scoring on free-authored practice items, which is a practice nicety, not the measurement.

## 3. Phases

Each phase ends at a gate (§7). Do not start the next phase until the gate passes. Each phase is one or more commits (§8).

### Phase 0 — Confirm the ground · *no code*

Run `cd api && npm test` and `cd client && npm test` and record that both are green **before** touching anything. 519 API tests across 27 files passed on 2026-08-11; if that number has moved, find out why before adding to it. Verify the five facts in §0.

### Phase 1 — Engine groundwork · *two commits, reviewed separately*

**1a — the migration.** One additive change:

```prisma
enum SkillKey { clarity evidence decomposition }

model SkillAttempt {
  // …
  /// JSON: the decomposition artifact — a tree, not prose. Parsed in typeResolvers.
  responseStructure String?
}
```

```bash
cd api && npx prisma migrate dev --name add_decomposition_lab && npx prisma generate
```

`responseStructure` is a separate column rather than reusing `responseText` on purpose: one holds prose, one holds a structure, and a single field holding either would make every later query ambiguous about which it got. **Convention #11 applies — update `02-architecture/01-data-model.md` and add a migration note to `tracker/decisions/decision-log.md` in the same commit.**

**1b — fix the shared review scheduler.** This is a pre-existing gap, and a third tool is the point at which it stops being tolerable:

- `claritySession.ts` sets `masteredAt` on mastery but never `nextReviewAt` or `reviewIntervalIndex`, so **Clarity modules never enter the review queue.** Evidence does both (`evidenceSession.ts` ~line 304) plus a calendar row.
- `skillDueReviews` (`resolvers/query.ts:285`) reads evidence modules only.

Fix both in the shared layer: extract the "on mastery, schedule the next review" step so all three tools call it, and make `skillDueReviews` union across every `SkillKey` the user has a profile for. Do **not** fix it a third time inside the new tool. Add a regression test that a mastered Clarity module gets a `nextReviewAt`.

*Why this is Phase 1 and not Phase 6:* mastery is currently unreachable in Clarity (no reader ⇒ three criteria unscored), so the bug is latent there and would become live the day a credential lands. Fixing it while it is invisible is cheaper than debugging it later in two tools at once.

### Phase 2 — Content pack and validator · *no credential*

```
api/src/content/skills/decomposition/
  types.ts                 # module keys, criteria, item/spec/surface types, toPublicDecompositionItem()
  validate.ts              # mirrors clarity/validate.ts
  v1/
    spec.ts                # locale-invariant: ids, difficulty, keys, profiles, ITEM_SPECS
    rubric.ts              # the six criteria + RUBRIC_CRITERIA_BY_MODULE
    surface.en.ts
    surface.fa.ts
    index.ts               # buildDecompositionPack(locale), ITEM_SPECS re-export
```

Register in `versions.ts`: `CURRENT_VERSION.decomposition = "decomposition/v1"`, plus a `DECOMPOSITION_VERSIONS` registry and `ENROLLABLE_DECOMPOSITION_VERSIONS` mirroring the evidence ones. **Content counts, enforced by the validator as errors, not warnings:**

| Rule | Value | Code |
|---|---|---|
| Pool items per module | ≥ 6 | `pool-too-small` |
| Control items per module pool | ≥ 2 | `control-ratio` |
| Key-only (no-judge) items per module pool | ≥ 3 | `pool-not-offline` |
| Probe forms | A, B, C · 6 scored items each (4 decomposable + 2 control) | `form-composition` |
| Control ratio per form | ≥ ⅓ | `control-ratio` |
| Locale parity | identical `itemId` set and identical specs across `en` / `fa` | `locale-parity` |
| An item's seeded fault includes its module's own criterion | — | `fault-off-module` |
| Every arrangement item's key is internally consistent (§4.6) | — | `key-incoherent` |
| Probe items have `keyVerifiedAt` | warning only | `key-unverified` |
| `fa` `reviewStatus: "draft"` | warning only | `locale-draft` |

Six modules: `d1-frame`, `d2-breadth`, `d3-seams`, `d4-size`, `d5-order`, `d6-recompose`. Criteria `D1`–`D6`, 1:1 with modules. Item types: `arrangement` · `breakdown` · `repair` · `control` · `contrast` (step 2 only, unscored).

`fa` is a **translation of a locale-invariant spec**, not a re-authoring — the opposite of the Skills packs' usual rule, and the reason is in the spec §4: nothing that makes a decomposition item an instrument is language-shaped. Conventions **#7a** (concept not calque), **#7b** (informal تو/کن), **#7c** (one Persian word per concept) all apply. Ship `reviewStatus: "draft"` and surface the banner, as Feelings & Needs does.

**The subject matter rule inherited from Evidence `v2` (D-17) applies: general-audience scenarios, no domain knowledge needed to feel the problem.** The spec's worked example — moving two people to another city in five weeks — is a usable `d6` item and a good template for the rest.

Write `api/src/__tests__/decompositionContent.unit.test.ts` in the shape `01-testing.md` §2 recommends: the invariants that live *between* two hand-written files and cannot be typed.

### Phase 3 — Scoring, session service, GraphQL · *no credential* · the big phase

```
api/src/services/skills/decomposition/
  detectors.ts             # D1 whole-statement, D4 doneWhen boundedness  (§4.2, §4.3)
  metrics.ts               # breadth-first index, coverage, discrimination (§4.1, §4.4, §4.5)
  keyScoring.ts            # arrangement/repair/control scoring against the item key (§4.6)
  scoring.ts               # assembles a ScoredAttempt: per-criterion level + evidence + total
  decompositionSession.ts  # serve → lock whole → lock diagnosis → score → revise
```

Session service contract — the ordering **is** the measurement, so all of it is server-stamped:

1. `serveItem(prisma, userId, mode, moduleKey?)` → opens a `SkillAttempt`, returns a `PublicDecompositionItem`. Never returns a key, a required-element set, an atomic marker, an overlap pair, a blocking edge, or a fault label.
2. `lockWhole(attemptId, statement, doneWhen)` → writes a `whole_stated` check event. **Rejects if any `node_added` already exists for the attempt.**
3. `lockDiagnosis(attemptId, tags[])` → writes `diagnosis_locked`. Repair items only.
4. `submitAttempt(attemptId, structure, tzOffset)` → writes `breakdown_locked`, scores, persists `responseStructure` + `scores`, recomputes mastery, returns the feedback payload. **Rejects a second submission for the same attempt** (per-attempt immutability, engine §7).
5. `startRevision(attemptId)` → a **new attempt row** with `revisionOfAttemptId` set. Never an edit. `unscaffolded` is read from the data as `revisionOfAttemptId == null`, so a revision cannot earn mastery.
6. **Reject a score request that arrives before `whole_stated`** — same category as Clarity rejecting a score before a diagnosis lock.

`responseStructure` JSON shape — one string field, parsed once in `typeResolvers.ts` (convention #2):

```json
{
  "whole":  { "statement": "…", "doneWhen": "…" },
  "nodes": [ { "id": "n1", "parentId": null, "label": "…", "doneWhen": "…",
               "order": 1, "dependsOn": ["n0"] } ]
}
```

`scores` JSON shape:

```json
{ "criteria": [ { "id": "D1", "level": 2, "scoredBy": "detector", "evidence": "…" } ],
  "total": 10, "scoredCount": 6,
  "coverage": { "found": 8, "required": 9 },
  "bfi": 0.71, "overDecomposed": false, "void": false }
```

`evidence` is a quote from the learner's own structure — the feedback UI shows it, and a level with no evidence is a level nobody can argue with. **Own GraphQL types**, per the Clarity precedent (widening the Evidence types would force every field on three tools to be nullable):

| Kind | Name |
|---|---|
| Queries | `decompositionModules`, `decompositionProgress` |
| Mutations | `startDecompositionItem(mode, moduleKey)`, `lockDecompositionWhole(attemptId, statement, doneWhen)`, `lockDecompositionDiagnosis(attemptId, tags)`, `submitDecompositionAttempt(attemptId, structure, timeZoneOffsetMinutes)`, `startDecompositionRevision(attemptId)` |
| Reused unchanged | `logSkillCheckEvent`, `skipSkillAssessment`, `resetSkillProgress` |
| Types | `DecompositionModule`, `DecompositionServedItem`, `DecompositionAttemptResult`, `DecompositionProgress`, `DecompositionNode` |

Every resolver takes `requireAuth` **and** `ensureOwned` (convention #1). New check-event kinds: `whole_stated`, `node_added`, `node_moved`, `dependency_set`, `breakdown_locked`, `diagnosis_locked`, `recompose_revealed`.

Tests: `decompositionDetectors.unit.test.ts`, `decompositionMetrics.unit.test.ts` (fixtures with known BFI values, including the degenerate single-top-level case), `decompositionScoring.unit.test.ts`, `decomposition.integration.test.ts` (the full serve → lock → score → revise path, the two rejections, and **an assertion that no key material appears in any payload**).

### Phase 4 — Frontend · *no credential*

```
client/app/components/skills/
  DecompositionLabPage.tsx      # plate 1 — both variants
  DecompositionSessionPage.tsx  # plates 2,3,4,7,8 — stage machine per item type
  BreakdownCanvas.tsx           # plate 5 — new component
  RecomposeReveal.tsx           # plate 6 — new component
```

Routes `/tools/skills/decomposition` and `/tools/skills/decomposition/session` in `client/app/protectedRoutes.tsx`. All documents added to `client/app/api/queries.ts` and consumed via `useApi()` (convention #6). Every string a key in **both** `en` and `fa` (convention #7) under the existing `skills.*` namespace; run `npm run i18n:check-missing` and `npm run i18n:check-hardcoded`.

`ModuleIntroOverlay` with `moduleKey = "skills.decomposition"`. **Do not add slides to `OnboardingSlideshow`** — that touches `TOTAL_SLIDES` and the `markSlideViewed` threshold, a known churn point (engine §12).

**The stage order differs by item type, and not arbitrarily.** A *breakdown* item states the whole, authors, commits, sees the recomposition gap, then diagnoses its own structure — because until the reveal there is nothing to diagnose. A *repair* item diagnoses someone else's structure first, because that is the reading exercise, then fixes it. A *control* item has no diagnose step. What is constant: whatever the learner commits, they commit it before any score appears.

Three display rules are load-bearing enough to be **tested rather than left to styling**:

- An unscored criterion renders as the words **"not scored"**, never an empty two-pip row — an empty row is indistinguishable from a level of 0.
- The total reads **`9 / 10`** with "5 of 6 criteria scored" beneath, never a silently weakened `9 / 12`.
- Containment, sequence and dependency render as **three distinct notations** — nesting, a numbered badge, a dashed chip. Not one arrow type at three weights. Published diagrams blend hierarchy and sequence and become unscoreable; a canvas that permits the blend reproduces the confusion and then scores the learner for it.

RTL pass on the canvas, the three recomposition panes and the rubric rail. One frontend test, `client/app/test/DecompositionSession.test.tsx`, covering the unscored-is-not-zero rule and the whole-before-pieces gate. Thin I/O glue stays untested by design (`01-testing.md` §1).

### Phase 5 — Probes and export · *no credential* · **builds shared engine surface**

Nothing writes a `SkillProbe` row today. This phase builds that, and **it must be written skill-agnostic, because Evidence and Clarity will inherit it** — put it in `api/src/services/skills/probes.ts`, not under `decomposition/`.

- `startSkillProbe(skillKey, timepoint)` — assigns form A/B/C with the per-user rotation offset (engine §6), creates the row, refuses if the pack is not `isProbeReady`.
- `completeSkillProbe(probeId, selfReport)` — computes totals, stamps `contentVersion` / `rubricVersion`, and **schedules the delayed probe 7 days out** via the existing `delayedProbeDueAt()` in `scheduler.ts`, which is currently written and never called.
- `skillProbe(skillKey, timepoint)` and `skillExport(skillKey)` queries. Export returns JSON plus a markdown summary.
- Comparability enforced **in code**: a probe result is charted only against results with the same `contentVersion` and `rubricVersion`; a mismatch renders the series broken at that point with a visible marker.
- The delayed probe surfaces as a due item on the tool home and **at most one line on Today** — not a card, not a nag, no streak.
- Self-report: 4 self-efficacy items per timepoint, **collected and never scored**, displayed as the self-report-vs-behaviour overlay.

`skillProbes.integration.test.ts`: baseline → six modules → post → delayed completes; **a full probe runs with outbound network blocked** (assert it); a second submission for one attempt is rejected; totals never pool across content versions.

### Phase 6 — Judge for D3/D6 on free-authored items · **credential required** · optional

The only credential-dependent work in the tool. Reuse `services/skills/clarity/anthropicJudge.ts` — the client construction, the 1-hour cache TTL and the pinned-model handling are already built and tested. One call per criterion, structured output, evidence quote required, `min(key, judge)` ceiling. A judge failure degrades to self-diagnosis, never to a blocked session. **`createAnthropicJudge()` returning `null` is a supported state, not an error path.**

### Phase 7 — Real-work export · *no credential* · handle with care

The one screen that writes the learner's real data. Itemised review (plate 9), `ConfirmDialog` per convention #9, reversible, never automatic, and it states what it drops: dependency edges do not survive into Tracker's model, so the screen says so rather than silently flattening them. Real-work attempts are `mode: open_practice` and are **excluded from mastery and probe totals**.

### Phase 8 — Human work · *not code*

Key verification for the 18 probe items (`keyVerifiedAt`, the same discipline as `02a-evidence-verification-brief.md`); native Persian review to move `reviewStatus` off `draft`; and the rubric agreement pass — ~20 double-scored samples per criterion, reconciled, per locale. Until a criterion clears agreement it runs feedback-only and says so. Add these to `team/open-work.md` when Phase 2 lands, not when Phase 8 starts.

## 4. Algorithms — spelled out, because otherwise they get invented

### 4.1 Breadth-first index (D2)

From `node_added` events **in event order**, each payload carrying `{nodeId, parentId, depth}`.

```
T            = nodes at depth 1 in the final structure
firstDeepIdx = index of the first node_added with depth >= 2   (∞ if none)
bfi          = |{ n ∈ T : index(n) < firstDeepIdx }| / |T|
```

- **`|T| < 2` ⇒ `bfi = null`.** A structure with one top-level piece has nothing to be breadth-first about; null is excluded from levels and from trend lines rather than counted as 0 or 1.
- Level 2 if `bfi == 1`; level 1 if `bfi >= 0.5`; else 0. On **arrangement** items level 2 additionally requires every piece to sit at the depth its key specifies. On free-authored items depth correctness is not scored.
- **`node_moved` is recorded and ignored for D2.** Rearranging afterwards does not retroactively make the authoring breadth-first, and letting it would delete the only behavioural measure the tool has.

### 4.2 Whole-statement detector (D1)

Level 2 requires all three: a `whole_stated` event exists **before** the first `node_added`; `statement` is not a near-copy of the item prompt (normalised token overlap < 0.6); `doneWhen` is non-empty **and** bounded per §4.3. Level 1 = statement present, `doneWhen` absent or unbounded. Level 0 = no whole, or pieces precede it.

### 4.3 Boundedness of a `doneWhen` (D4)

Deterministic, no model. A `doneWhen` is **bounded** if it contains at least one of:

- a date, weekday, or explicit deadline preposition + temporal object (`by the 12th`, `before Friday`);
- a numeric bound — digits or number words attached to a countable noun;
- a **state-change verb from an authored lexicon** (`booked`, `cancelled`, `signed`, `sent`, `paid`, `handed back`, `confirmed`, `submitted`, `secured`, `arrived`, `returned`, `published`). A lexicon, not a parser: this is a heuristic that must be *conservative and legible*, and a per-locale list is honest where a grammar would be a pretence.

Persian: the same three tests, with a Persian verb lexicon in `surface.fa.ts` rather than a translated English one. **Convention: Persian word boundaries are not `\b`** — `\b` is defined against ASCII `\w`, so a `\b…\b` pattern matches *nothing* in Persian, silently. Use Unicode property escapes (`[\p{L}\p{M}\p{N}]` in lookarounds, `u` flag). This exact bug disabled the Feelings & Needs faux-feeling matcher for the whole locale; see conventions §7.

D4 levels — free authoring: level 2 = every leaf has a bounded `doneWhen` and nothing the key marks atomic was split; level 1 = one fault; level 0 = two or more. Arrangement items: labels are authored, so D4 = did they avoid splitting an atomic piece and avoid placing the monolith decoy.

### 4.4 Coverage (D6) and overlap (D3) on keyed items

Level 2 = every `requiredPieceId` placed exactly once **and** at most one `decoyPieceId` placed. Level 1 = exactly one required piece missing. Level 0 = two or more missing. D3: level 2 = no `overlapPair` has both members placed; level 1 = exactly one such pair; level 0 = two or more. D5: compare placed `dependsOn` edges against the key's `blockingEdges` — level 2 = all present and correctly directed, with no false ordering between pieces the key marks independent; level 1 = one missing or inverted; level 0 = more.

### 4.5 Granularity discrimination

```
discrimination = (D4 level-2 rate on decomposable items) − (over-decomposition rate on control items)
over-decomposed on a control item  ⇔  node count > 1
```

Reported **beside** the rubric total, never alone and never below the fold. This is the metric that distinguishes the skill from the disposition, and the direct descendant of Evidence Lab's hit-rate-minus-false-alarm refusal.

### 4.6 The arrangement item key, and the validator check it needs

```ts
type ArrangementKey = {
  pieces: { id: string; intendedDepth: 1 | 2; atomic: boolean; decoy: boolean }[];
  requiredPieceIds: string[];
  overlapPairs: [string, string][];
  blockingEdges: [string, string][];   // [blocker, blocked]
  independentPairs: [string, string][];
};
```

A key can be internally incoherent in ways that compile fine and score wrongly, so the validator (`key-incoherent`) must reject: a `requiredPieceId` that is also a decoy; an `overlapPair` whose members are both required (they could never both be correctly placed); a `blockingEdge` referencing a decoy; a cycle in `blockingEdges`; a pair appearing in both `blockingEdges` and `independentPairs`; a piece with `intendedDepth: 2` and no possible parent. **A wrong key does not fail loudly — it silently produces a wrong score, which is the exact failure this tool teaches people to catch.**

### 4.7 Mastery

Reuse the shape in `services/skills/mastery.ts`. Mastered = on two consecutive **unscaffolded** items (`revisionOfAttemptId == null`) across **two distinct calendar days**: total ≥ 10/12, no criterion at 0, level 2 on that module's own criterion, **and no over-decomposition on any control item in the window.** All four clauses, or a globally competent decomposer masters `d4` while shattering controls.

## 5. What must not be built — check this list at every phase gate

Each of these will look like an obvious improvement. Each one breaks the instrument or the pedagogy.

- [ ] **No "suggest a breakdown", no autocomplete on piece names, no template gallery, no AI review before commit.** Decomposition is the most offloadable skill in the stack; a model produces a plausible breakdown instantly. The tool's central guard is an *absence*, and absences are hard to keep because nobody notices when one is removed.
- [ ] **No green "checkable" badge.** Absence only (§1.2).
- [ ] **No client-supplied `offsetMs`, and no client-asserted ordering.** Every lock is server-stamped.
- [ ] **No key material in any client payload** — keys, required-element sets, atomic markers, overlap pairs, blocking edges, fault labels, exemplar fixes. There must be no GraphQL field through which a key can be requested. Asserted by test.
- [ ] **No streaks, badges, or leaderboards.** The expanding review queue is the only recurring pressure (D-3, and the `remove_habits` migration).
- [ ] **No holistic "how good was this breakdown?" score** anywhere — one level per criterion, and no criterion reaches level 2 on surface features alone.
- [ ] **No silently weakened total** (`9 / 12` when four criteria ran).
- [ ] **No retroactive repair of D2 via `node_moved`.**
- [ ] **No mastery redefinition** to whatever happens to be measurable.
- [ ] **Do not touch `evidence/v1`, `evidence/v2` or `clarity/v1` content, or Evidence/Clarity scoring.** Learners are pinned to versions; versions are never deleted. The only shared files this build may modify are `versions.ts`, `scheduler.ts`, `mastery.ts`, `probes.ts` (new), `typeDefs.ts`, the three resolver files, `protectedRoutes.tsx`, `queries.ts`, and the two locale files.

## 6. Cost

Phases 1–5 and 7: **zero API spend.** Phase 6: one judge call per criterion per free-authored practice attempt, sharing a cached rubric prefix — single-digit cents per attempt. Phase 8's agreement pass is ~120 judge calls per locale per rubric version, halvable via the Batch API since it is not interactive.

## 7. Acceptance, per phase

| Phase | Gate |
|---|---|
| 0 | Both suites green, and the §0 facts verified. |
| 1a | `npx prisma migrate dev` clean; `SkillKey` has three values; `responseStructure` present; data-model doc and decision log updated **in the same commit**. |
| 1b | A mastered Clarity module gets a `nextReviewAt` (regression test); `skillDueReviews` returns due modules across all three skills; no change to Evidence behaviour. |
| 2 | Validator passes with **zero errors**; warnings limited to `key-unverified` and `locale-draft`. Every count in §3's table asserted by `decompositionContent.unit.test.ts`. `en` / `fa` at item parity. |
| 3 | Full path completes: serve → lock whole → author → commit → score → revise, draft and revision linked. A score request before `whole_stated` is **rejected**. A second submission is **rejected**. No key material in any payload (asserted). BFI fixtures pass, including `|T| < 2 ⇒ null`. |
| 4 | A learner completes a module sitting end to end with **no credential configured**, all six criteria scored on an arrangement item, D3/D6 shown as "not scored" on a free-authored one with the reason. `en`/`fa` key parity; both i18n checks clean; RTL pass on canvas and panes. Three display rules asserted by test. |
| 5 | Baseline → six modules → post → 7-day delayed completes, every attempt version-stamped. **A full probe completes with outbound network blocked** (asserted). Series break at a version boundary is visible. Self-report collected and absent from every total. |
| 6 | An identical submission re-scored returns the identical cached score; `usage.cache_read_input_tokens` non-zero on the second and later criteria of an attempt — a persistent zero means the prompt split regressed. With the key removed, the tool still completes a full module. |
| 7 | Export writes only selected items, routes through `ConfirmDialog`, is reversible, and states that dependencies are dropped. Real-work attempts appear in history and in **no** mastery or probe total. |
| 8 | Per-criterion agreement at or above threshold before that criterion contributes to a probe total; below-threshold criteria stay feedback-only and stay visibly marked. |

## 8. Commit sequence

One phase per commit except Phase 1 (two) and Phases 3–4 (split at will; keep the canvas its own commit). Suggested messages:

```
add decomposition to SkillKey; SkillAttempt.responseStructure
schedule reviews for every skill, not just evidence
decomposition/v1 content pack and validator
decomposition scoring, session service and GraphQL
decomposition lab frontend; breakdown canvas
skill probes: baseline, post and the 7-day delayed probe
judge-scored D3/D6 for free-authored breakdowns
real-work breakdown export into goals and projects
```

## 9. Risks to the build itself

| Risk | What it looks like | Guard |
|---|---|---|
| **The canvas grows an assistant** | A later commit adds "suggest pieces" because the empty canvas feels unhelpful | §5 is a checklist at every gate; the absence is the feature |
| **A plausible-but-incoherent item key** | Scores look reasonable and are wrong | §4.6 validator checks, plus human verification in Phase 8 |
| **D2 quietly stops measuring** | Someone makes `node_moved` update the index "for correctness" | Fixture test asserting a depth-first-then-rearranged structure still scores D2 = 0 |
| **Phase 5 written skill-specifically** | Probes land under `decomposition/` and Evidence/Clarity can't use them | `probes.ts` at the `services/skills/` level, with a test that calls it for two skill keys |
| **Persian regexes match nothing** | The `doneWhen` detector silently returns "unbounded" for every Persian item | Unicode property escapes; a `fa` fixture in the detector unit test — not an `en`-only suite |
| **Scope creep into skill #5** | The delegation mark starts being scored | It is recorded and never scored; assert it contributes to no criterion |

---

## Changelog

- **0.1 · 2026-08-11** — Written after the wireframe review settled enforced levels, the absence-only live badge, and the export honesty note. Adds two things the spec did not carry: a per-node `doneWhen` field (which turns D4 from prose inference into field validation, and needs a plate-5 affordance), and the arrangement-key coherence checks in §4.6. Records that Phase 1b fixes a pre-existing Clarity review-scheduling gap in the shared layer, and that Phase 5 builds probe machinery the other two tools inherit — so it must be written skill-agnostic.
